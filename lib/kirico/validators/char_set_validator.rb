# frozen_string_literal: true
require 'active_model'
require 'active_model/validator'

# [numeric]
# 0~9 の1 バイトの半角文字
#
# [latin]
# アルファベットおよび記号の 1 バイトの半角文字
#
# [katakana]
# カタカナの1バイトの半角文字（スペースを含む）
#
# [kanji]
# 2 バイトの全角文字
# see: http://charset.7jp.net/sjis2.html
#
# 特殊記号（間隔）      8140
# 特殊記号（記述記号）  8141-8164
# 特殊記号（括弧記号）  8165-817A
# 特殊記号（学術記号）  817B-818A
# 特殊記号（単位記号）  818B-8193
# 特殊記号（一般記号）  8194-819E, 819F-81AC
# 数字                  824F-8258
# ローマ字              8260-8279, 8281-829A
# 平仮名                829F-82F1
# 片仮名                8340-8396
# ギリシア文字          839F-83B6, 83BF-83D6
# ロシア文字            8440-8460, 8470-8491
# 漢字                  889F-9872, 989F-EAA4
module Kirico
  class CharsetValidator < ActiveModel::EachValidator
    # REGEXP = /(#{"[^ -~　-〓０-я亜-腕弌-熙\r\n]".encode("CP932")})/
    NUMERIC_CHARS = '0-9'
    LATIN_CHARS = 'A-Za-z'
    KATAKANA_CHARS = ' ｦ-ﾟ'
    KANJI_CHARS = '　-〓０-я亜-腕弌-熙'
    def validate_each(record, attribute, value)
      error_chars = retrieve_error_chars(value)

      record.errors.add(attribute, (options[:message] || :invalid_charset), error_chars: error_chars.join(', ')) unless error_chars.empty?
    end

    def retrieve_error_chars(value, error_chars = [])
      # value.blank? はタブ文字等の場合でも true となるため注意
      return error_chars if value.nil? || value.empty?

      str = "[^#{NUMERIC_CHARS}#{LATIN_CHARS}#{KATAKANA_CHARS}#{KANJI_CHARS}]".encode('CP932')
      regex = /(#{str})/
      match = regex.match(value.encode('CP932'))
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
