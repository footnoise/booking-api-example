class JsonMapper
  attr_reader :json
  
  def initialize(json)
    @json = json
  end

  def do_mapping(object, mapping_fields)
    object.tap do |o|
      mapping_fields.each do |object_attr, json_attr|
        o.send "#{object_attr}=".to_sym, json.dig(*json_attr)
      end
    end
  end
end