# frozen_string_literal: true
require 'active_model'
require 'active_model/validator'

# JIS X 0201 + JIS X 0208（機種依存文字を除く）
module Kirico
  class CharsetValidator < ActiveModel::EachValidator
    REGEXP = /(#{"[^ -~　-〓０-╂亜-腕弌-熙\r\n]".encode("CP932")})/
    def validate_each(record, attribute, value)
      error_chars = retrieve_error_chars(value)

      record.errors.add(attribute, (options[:message] || :e_gov_invalid_charset), error_chars: error_chars.join(', ')) unless error_chars.empty?
    end

    def retrieve_error_chars(value, error_chars = [])
      # value.blank? はタブ文字等の場合でも true となるため注意
      return error_chars if value.nil? || value.empty?

      match = REGEXP.match(value.encode('CP932'))
      return error_chars if match.nil?

      ch = match.captures[0].encode('UTF-8')
      error_chars << ch
      retrieve_error_chars(value.gsub(/#{ch}/, ''), error_chars)
    rescue Encoding::UndefinedConversionError => e
      ch = e.error_char
      error_chars << ch
      retrieve_error_chars(value.gsub(/#{ch}/, ''), error_chars)
    end
  end
end
