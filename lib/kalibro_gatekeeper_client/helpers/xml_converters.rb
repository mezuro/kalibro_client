module XMLConverters
  def xml_instance_class_name(object)
    xml_name = object.class.name
    xml_name["KalibroGatekeeperClient::Entities::"] = "" if xml_name.start_with?("KalibroGatekeeperClient::Entities::")
    xml_name[0..0] = xml_name[0..0].downcase
    xml_name + "Xml"
  end

  def get_xml(field, field_value)
    hash = Hash.new
    if field_value.is_a?(KalibroGatekeeperClient::Entities::Model)
      hash = {:attributes! => {}}
      hash[:attributes!][field.to_sym] = {
        'xmlns:xsi'=> 'http://www.w3.org/2001/XMLSchema-instance',
        'xsi:type' => 'kalibro:' + xml_instance_class_name(field_value)
      }
    end
    hash
  end
end