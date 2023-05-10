module Currency
  extend ActiveSupport::Concern

  class_methods do
    def has_currency *_attributes
      _attributes.each do |_attribute|
        define_method "#{_attribute}_in_dollars".to_sym do
          send(_attribute) / 100.0 rescue 0.0
        end

        define_method "#{_attribute}_in_dollars=".to_sym do |value|
          send("#{_attribute}=", value.to_f * 100) rescue 0.0
        end
      end
    end
  end
end