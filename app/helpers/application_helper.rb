# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def css_class_name
    prefix = params["controller"].downcase.split("/").join("-")
    subfix = params["action"]

    "#{prefix}-#{subfix}"
  end

  def css_active_class(controller_name, *other)
    "active" if params[:controller] == controller_name || other.include?(params[:controller])
  end

  def pagy_label(pagy)
    "#{I18n.t('shared.display')} <b>#{pagy.from}</b> - <b>#{pagy.to}</b> of <b>#{pagy.count}</b>".html_safe
  end

  def program_languages
    [
      { code: "km", label: I18n.t("shared.km"), image: "khmer.png" },
      { code: "en", label: I18n.t("shared.en"), image: "english.png" }
    ]
  end

  def form_check_toggle(option = {})
    disabled = option[:disabled].present? ? "disabled" : ""
    checked = option[:checked].present? ? "checked" : ""

    str = "<div class='form-check'>"
    str += "<label class='form-check-label form-check-toggle'>"
    str += "<input type='hidden' name='#{option[:name]}' value='0'/>"
    str += "<input type='checkbox' name='#{option[:name]}' #{checked} #{disabled}/>"
    str += "<span class=#{'text-secondary' if disabled.present?}>#{option[:label]}</span>"
    str += "</label>"
    str + "</div>"
  end

  def tagify_class(value)
    "tagify-item-" + value.to_s.gsub(/[^a-zA-Z0-9]/, "-")
  end

  def status_class(item)
    return "invalid" unless item.valid?

    item.new_record? ? "new" : "edit"
  end

  def status_message(item)
    return item.errors.full_messages.join(", ") unless item.valid?

    item.new_record? ? I18n.t("shared.new") : I18n.t("shared.edit")
  end

  def display_date(date, format = nil)
    return "" unless date.present?
    format ||= ENV.fetch("DATE_FORMAT") { "yyyy_mm_dd" }

    I18n.l(date, format: :"#{format}")
  end

  def display_datetime(date)
    format = ENV.fetch("DATETIME_FORMAT") { "yyyy_mm_dd_time" }
    display_date(date, format)
  end

  def timeago(date, type = "date")
    return "" unless date.present?

    dis_date = type == "date" ? display_date(date) : display_datetime(date)
    str = "<span class='timeago' data-date='#{dis_date}'>"
    str += time_ago_in_words(date)
    str += "</span>"
    str
  end

  def date_format(date)
    return unless date.present?

    date = Time.parse(date) if date.is_a?(String)
    date.strftime("%Y-%m-%d")
  rescue
    nil
  end
end
