# frozen_string_literal: true

require 'active_model'
require 'active_model/validator'

# SJIS 換算の文字長を検証する
# SJIS 変換不可文字が設定された場合は 1 文字としてカウントする
#
# 設定例:
#   validate :address, sjis_bytesize: { in: 1..30 }
#
# 参考:  https://github.com/rails/rails/blob/fe1f4b2ad56f010a4e9b93d547d63a15953d9dc2/activemodel/lib/active_model/validations/length.rb
module Kirico
  class SjisBytesizeValidator < ActiveModel::EachValidator
    MESSAGES  = { is: :wrong_length_in_bytes, minimum: :too_short_in_bytes, maximum: :too_long_in_bytes }.freeze
    CHECKS    = { is: :==, minimum: :>=, maximum: :<= }.freeze

    RESERVED_OPTIONS = %i(minimum maximum within is too_short too_long)

    def initialize(options)
      range = (options.delete(:in) || options.delete(:within))
      if range
        raise ArgumentError, ':in and :within must be a Range' unless range.is_a?(Range)
        options[:minimum] = range.min
        options[:maximum] = range.max
      end

      if options[:allow_blank] == false && options[:minimum].nil? && options[:is].nil?
        options[:minimum] = 1
      end

      super
    end

    def check_validity!
      keys = CHECKS.keys & options.keys

      if keys.empty?
        raise ArgumentError, 'Range unspecified. Specify the :in, :within, :maximum, :minimum, or :is option.'
      end

      keys.each do |key|
        value = options[key]

        unless (value.is_a?(Integer) && value >= 0) || value == Float::INFINITY
          raise ArgumentError, ":#{key} must be a nonnegative Integer or Infinity"
        end
      end
    end

    def validate_each(record, attribute, value = '')
      value_length = value.to_s.encode('CP932', undef: :replace).bytesize

      errors_options = options.except(*RESERVED_OPTIONS)

      CHECKS.each do |key, validity_check|
        check_value = options[key]
        next unless check_value

        if !value.nil? || skip_nil_check?(key)
          next if value_length.send(validity_check, check_value)
        end

        errors_options[:count] = check_value

        default_message = options[MESSAGES[key]]
        errors_options[:message] ||= default_message if default_message

        record.errors.add(attribute, MESSAGES[key], errors_options)
      end
    end

    private

    def skip_nil_check?(key)
      key == :maximum && options[:allow_nil].nil? && options[:allow_blank].nil?
    end
  end
end
