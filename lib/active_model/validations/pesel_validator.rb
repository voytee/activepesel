# frozen_string_literal: true

module ActiveModel
  module Validations
    class PeselValidator < ActiveModel::EachValidator
      def validate_each(record, attr_name, value)
        return if value.blank?

        record.errors.add(attr_name, :invalid) unless Activepesel::Pesel.new(value).valid?
      end
    end
  end
end
