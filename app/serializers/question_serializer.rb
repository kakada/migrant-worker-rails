# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id              :bigint           not null, primary key
#  code            :string
#  name            :text
#  type            :string
#  hint            :string
#  display_order   :integer
#  relevant        :string
#  required        :boolean
#  audio           :string
#  passing_score   :integer
#  passing_message :text
#  passing_audio   :string
#  failing_message :text
#  failing_audio   :string
#  form_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  section_id      :uuid
#  tracking        :boolean          default(FALSE)
#
class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :type, :hint, :audio_url, :display_order,
             :relevant, :required, :passing_score, :passing_message, :passing_audio_url,
             :failing_message, :failing_audio_url, :form_id, :criterias

  has_many :options

  def criterias
    object.criterias.map do |criteria|
      {
        id: criteria.id,
        question_id: criteria.question_id,
        question_code: criteria.question_code,
        operator: criteria.operator,
        response_value: criteria.response_value
      }
    end
  end

  class OptionSerializer < ActiveModel::Serializer
    attributes :id, :name, :value, :score, :alert_message, :alert_audio_url,
               :warning, :recursive, :question_id, :image_url

    def image_url
      object.image_url if object.image.present?
    end
  end
end
