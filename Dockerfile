# ---------------------------
# Builder Stage
# ---------------------------
FROM ruby:3.2.10-slim AS builder

RUN apt-get update -qq && apt-get install -y \
  build-essential libpq-dev curl \
  && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && npm install -g yarn \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_WITHOUT=development:test

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.4.19 --no-document && bundle install

# Copy the full app including bin/ directory
COPY . .

# Precompile assets
ENV RAILS_ENV=production
RUN bundle exec rails assets:precompile

# ---------------------------
# Final Stage
# ---------------------------
FROM ruby:3.2.10-slim

RUN apt-get update -qq && apt-get install -y \
  libpq5 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Bundler environment
ENV BUNDLE_PATH=/usr/local/bundle \
    GEM_HOME=/usr/local/bundle \
    GEM_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development:test \
    RAILS_ENV=production \
    RACK_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true

# Copy gems and app from builder
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

# Config
COPY docker/database.yml /app/config/database.yml

EXPOSE 80

CMD ["bundle", "exec", "puma", "-e", "production", "-b", "tcp://0.0.0.0:80"]
