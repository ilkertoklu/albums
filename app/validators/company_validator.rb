class CompanyValidator < ActiveModel::Validator
  REQUIRED_KEYS = %i[name catchPhrase bs].freeze

  def validate(record)
    validate_required_keys(record)
  end

  private

  def validate_required_keys(record)
    company_keys = record.company.symbolize_keys.keys
    missing_keys = REQUIRED_KEYS - company_keys
    add_missing_keys_error(record, missing_keys) if missing_keys.any?
  end

  def add_missing_keys_error(record, missing_keys)
    record.errors.add(:company, "is missing keys: #{missing_keys.join(', ')}")
  end
end
