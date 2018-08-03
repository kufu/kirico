# frozen_string_literal: true

require 'era_ja'
require 'active_support/core_ext/object'
require 'yaml'
require 'kirico/validators/charset_validator'
require 'kirico/validators/sjis_bytesize_validator'
require 'kirico/validators/space_divider_validator'

module Kirico
  module Helper
    # Validator の追加
    ActiveModel::Validations::CharsetValidator = Kirico::CharsetValidator
    ActiveModel::Validations::SjisBytesizeValidator = Kirico::SjisBytesizeValidator
    ActiveModel::Validations::SpaceDividerValidator = Kirico::SpaceDividerValidator

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
    #
    # # 2015/04/09 => 2015
    # def submit_at_year
    #   submit_at.try(:strftime, '%Y')
    # end
    #
    # # 2015/04/09 => 04
    # def submit_at_month
    #   submit_at.try(:strftime, '%m')
    # end
    #
    # 2015/04/09 => 09
    # def submit_at_day
    #   submit_at.try(:strftime, '%d')
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

        define_method("#{attr_name}_era_year") do
          send(attr_name).try(:to_era, '%E')
        end

        define_method("#{attr_name}_month") do
          send(attr_name).try(:strftime, '%m')
        end

        define_method("#{attr_name}_day") do
          send(attr_name).try(:strftime, '%d')
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

    # 10^3 を単位とした値を返すメソッドを生やす
    #
    # 例:
    # def monthly_income_currency_in_k
    #   return nil if object.monthly_income_currency.nil?
    #   return 0 if object.monthly_income_currency == 0
    #   (object.monthly_income_currency.to_f / 1000).round(0)
    # end
    def define_in_k_method(*fields, op: :round, precision: 0)
      fields.each do |attr_name|
        define_method("#{attr_name}_in_k") do
          original = send(attr_name)
          return nil if original.nil?

          # 浮動小数点対応
          n = BigDecimal(original.to_s) / BigDecimal('1000')
          x = case op
              when :round
                n.send(op, precision)
              else
                n.send(op)
              end
          format("%.#{precision}f", x)
        end
      end
    end

    # 左 0 埋めした文字列を帰す
    # def padding_zero_income
    #   return nil if income.nil?
    #   income.to_s.rjust(7, '0')
    # end
    def define_padding_zero_method(*fields, length: 7)
      fields.each do |attr_name|
        define_method("padding_zero_#{attr_name}") do
          original = send(attr_name)
          return nil if original.nil?
          original.to_s.rjust(length, '0')
        end
      end
    end

    # 条件によって表示/非表示を切替えるメソッドを生やす
    #
    # 例:
    #
    # マインナンバーが存在する場合のみ、
    # 現在の給与を出力するメソッドを生やす。
    # define_conditional_display_method :salary do |obj|
    #   obj.my_number_digist.present?
    # end
    #
    # ↓
    #
    # def cond_current_salary
    #   current_salary if obj.my_number_digist.present?
    # end
    def define_conditional_display_method(*fields)
      fields.each do |attr_name|
        define_method("cond_#{attr_name}") do
          public_send(attr_name) if yield(self)
        end
      end
    end
  end
end
