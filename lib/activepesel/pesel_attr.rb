# frozen_string_literal: true

module Activepesel
  module PeselAttr
    extend ActiveSupport::Concern

    module ClassMethods
      def pesel_attr(*attr_names)
        attr_names.each do |attr_name|
          define_method("#{attr_name}_personal_data") do
            Pesel.new(__send__(attr_name)).personal_data
          end
        end
      end
    end
  end
end
