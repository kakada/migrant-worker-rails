# frozen_string_literal: true

require "spreadsheet"

class UserService
  def initialize(users)
    @users = users
  end

  def export
    Spreadsheet.client_encoding = "UTF-8"
    book = Spreadsheet::Workbook.new
    create_sheet_user(book)
    create_sheet_games(book)

    file_path = Rails.root.join("public", "uploads", "tmp", "users.xls")
    FileUtils.mkdir_p(file_path.dirname) # ensure parent directory exists

    book.write(file_path)
    File.read(file_path)
  end

  private
    def create_sheet_user(book)
      sheet = book.create_worksheet name: "Users"
      sheet.row(0).push("User ID", "User Name", "Sex", "Age", "Voice Record", "Registered At")

      @users.each_with_index do |user, index|
        audio = user.audio_url.present? ? Spreadsheet::Link.new(user.audio_url, user.audio_url) : ""
        sheet.row(index + 1).push(user.id, user.full_name, user.sex, user.age, audio, user.registered_at)
      end
    end

    def create_sheet_games(book)
      Form.all.each do |form|
        create_sheet_game(book, form)
      end
    end

    def create_sheet_game(book, form)
      sheet = book.create_worksheet name: form.name
      build_quiz_header(sheet, form)
      build_quiz_body(sheet, form)
    end

    def build_quiz_header(sheet, form)
      sheet.row(0).push("Game date", "User ID", "User Name")
      form.questions.each do |question|
        sheet.row(0).push(question.name)
      end
    end

    def build_quiz_body(sheet, form)
      surveys = Survey.where(form_id: form.id).includes(:user, :survey_answers)
      surveys.find_each(batch_size: 1000).with_index do |survey, index|
        # User info
        sheet.row(index + 1).push(survey.quizzed_at, survey.user.id, survey.user.full_name)

        # Survey answer info
        form.questions.each do |question|
          answer = survey.survey_answers.select { |ans| ans.question_id == question.id }.first
          sheet.row(index + 1).push(answer.try(:value))
        end
      end
    end
end
