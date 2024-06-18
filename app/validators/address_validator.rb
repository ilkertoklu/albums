class AddressValidator < ActiveModel::Validator
  REQUIRED_KEYS = %w[street suite city zipcode geo].freeze
  GEO_KEYS = %w[lat lng].freeze

  def validate(record)
    validate_required_keys(record)
    validate_geo_keys(record) if record.errors[:address].empty?
  end

  private

  def validate_required_keys(record)
    missing_keys = REQUIRED_KEYS - record.address.keys.map(&:to_s)
    add_missing_keys_error(record, missing_keys) if missing_keys.any?
  end

  def validate_geo_keys(record)
    missing_geo_keys = GEO_KEYS - record.address['geo'].keys.map(&:to_s)
    add_missing_geo_keys_error(record, missing_geo_keys) if missing_geo_keys.any?
  end

  def add_missing_keys_error(record, missing_keys)
    record.errors.add(:address, "is missing keys: #{missing_keys.join(', ')}")
  end

  def add_missing_geo_keys_error(record, missing_geo_keys)
    record.errors.add(:address, "geo is missing keys: #{missing_geo_keys.join(', ')}")
  end
end
