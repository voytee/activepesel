module Activepesel
  module PeselAttr
    extend ActiveSupport::Concern
    
    included do
    end
    
    module ClassMethods
      def pesel_attr(*attr_names)
        attr_names.each do |attr_name|
          define_method("#{attr_name}_personal_data") do 
            Pesel.new(send(attr_name)).personal_data
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Activepesel::PeselAttr
