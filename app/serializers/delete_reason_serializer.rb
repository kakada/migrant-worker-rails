# frozen_string_literal: true

# == Schema Information
#
# Table name: delete_reasons
#
#  id            :uuid             not null, primary key
#  name_km       :string
#  name_en       :string
#  display_order :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class DeleteReasonSerializer < ActiveModel::Serializer
  attributes :id, :name_km, :name_en, :display_order
end
