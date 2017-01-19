# frozen_string_literal: true
require 'era_ja'
require 'active_support/core_ext/object'
require 'yaml'
require 'kirico/validators/charset_validator'
require 'kirico/validators/sjis_bytesize_validator'

module Kirico
  module Helper
    # Validator の追加
    ActiveModel::Validations::CharsetValidator = Kirico::CharsetValidator
    ActiveModel::Validations::SjisBytesizeValidator = Kirico::SjisBytesizeValidator

    # 指定した date 型のフィールドを整形するメソッドを生やす
    #
    # 例:
    #    created_at メソッドを整形
    #
    # # 2015/04/09 => 20150409
    # def fmt_ymd_created_at
    #   return nil if submit_at.nil?
    #   submit_at.try(:to_era, '%Y%m%d')
    # end
    #
    # # 2015/04/09 => 270409
    # def fmt_era_ymd_created_at
    #   return nil if submit_at.nil?
    #   submit_at.try(:to_era, '%E%m%d')
    # end
    #
    # # 2015/04/09 => H
    # def submit_at_era_nengo
    #   submit_at.try(:to_era, '%o%E').try(:[], 0)
    # end
    #
    # # 2015/04/09 => 平成
    # def submit_at_era_nengo_kanji
    #   submit_at.try(:to_era, '%O%E').try(:gsub, /\d+\z/, '')
    # end
    def define_format_date_method(*fields)
      fields.each do |attr_name|
        define_method("fmt_ymd_#{attr_name}") do
          send(attr_name).try(:strftime, '%Y%m%d')
        end

        define_method("fmt_era_ymd_#{attr_name}") do
          send(attr_name).try(:to_era, '%E%m%d')
        end

        define_method("#{attr_name}_era_nengo") do
          send(attr_name).try(:to_era, '%o%E').try(:[], 0)
        end

        define_method("#{attr_name}_era_nengo_kanji") do
          send(attr_name).try(:to_era, '%O%E').try(:gsub, /\d+\z/, '')
        end
      end
    end

    # 指定したフィールドの値と区分値の値とをマッピングする
    # メソッドを生やす。
    # 対応表は models/mappers.ja.yml 参照
    #
    # 例:
    #   cause_cd フィールドをマッピングするメソッド
    #
    #   def mapped_birth_at_era
    #     value = object.send('cause_cd').try(:to_sym)
    #     class_name = object.class.underscore
    #     I18n.t("mappers.#{class_name}")[attr_name][value]
    #   end
    def define_code_mapper_method(*fields)
      fields.each do |attr_name|
        define_method("mapped_#{attr_name}") do
          value = send(attr_name)
          return if value.nil?
          class_name = self.class.name.underscore
          @mappers ||= YAML.load_file(File.join(__dir__, 'mappers.yml'))
          @mappers['mappers'][class_name.to_s].try(:[], attr_name.to_s).try(:[], value.to_s)
        end
      end
    end
  end
end
