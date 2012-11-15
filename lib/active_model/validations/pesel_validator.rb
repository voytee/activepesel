module ActiveModel
  module Validations
    class PeselValidator < ActiveModel::EachValidator
      def validate_each(record, attr_name, value)
        unless value.blank?
          record.errors.add(attr_name, :invalid, options) unless Activepesel::Pesel.new(value).valid?
        end
      end
    end
  end
end
