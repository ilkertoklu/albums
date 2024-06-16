class CompanyValidator < ActiveModel::Validator
  def validate(record)
    required_keys = %w[name catchPhrase bs]
    missing_keys = required_keys - record.company.keys.map(&:to_s)
    record.errors.add(:company, "is missing keys: #{missing_keys.join(', ')}") if missing_keys.any?
  end
end
