# frozen_string_literal: true

require 'active_model'
require 'active_model/validator'
require 'active_model/validations/format'

# 文字種別を検証する
#
# 設定例:
#   validate :name, space_divider: { space: :full_width  }
#   validate :name_yomi, space_divider: { space: :half_width  }
#   validate :name, space_divider: { space: :both_width  }
#
# space に指定可能なオプション:
#
# :full_width
# 全角スペース
#
# :half_width
# 半角スペース
#
# :both_width（デフォルト）
# 半角、全角問わない
module Kirico
  class SpaceDividerValidator < ActiveModel::EachValidator
    HALF_WIDTH_SPACE_RULE  = ' '
    FULL_WIDTH_SPACE_RULE  = '　'
    BOTH_WIDTH_SPACE_RULE  = '[ 　]'

    def self.regexp(space_divider_rule)
      /\A[^\p{blank}]+(#{space_divider_rule}[^\p{blank}]+)+\z/
    end

    CHECKS = {
      half_width: regexp(HALF_WIDTH_SPACE_RULE),
      full_width: regexp(FULL_WIDTH_SPACE_RULE),
      both_width: regexp(BOTH_WIDTH_SPACE_RULE)
    }.freeze

    def check_validity!
      raise ArgumentError, "Invalid space option #{space_option}. Specify the :full_width, half_width, or :both_width." unless CHECKS.keys.include?(space_option)
    end

    def validate_each(record, attribute, value)
      record.errors.add(attribute, (options[:message] || :invalid_space_divider), space_type: space_type_i18n) if value.to_s !~ CHECKS[space_option]
    end

    private

    def space_option
      options[:space] || :both_width
    end

    def space_type_i18n
      I18n.t('space_type')[space_option]
    end
  end
end
