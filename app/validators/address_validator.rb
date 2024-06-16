class AddressValidator < ActiveModel::Validator
  def validate(record)
    required_keys = %w[street suite city zipcode geo]
    missing_keys = required_keys - record.address.keys.map(&:to_s)
    if missing_keys.any?
      record.errors.add(:address, "is missing keys: #{missing_keys.join(', ')}")
    else
      geo_keys = %w[lat lng]
      missing_geo_keys = geo_keys - record.address['geo'].keys.map(&:to_s)
      record.errors.add(:address, "geo is missing keys: #{missing_geo_keys.join(', ')}") if missing_geo_keys.any?
    end
  end
end
