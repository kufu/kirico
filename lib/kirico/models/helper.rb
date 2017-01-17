# frozen_string_literal: true
module Kirico
  module Helper
    # 指定した date 型のフィールドを整形するメソッドを生やす
    #
    # 例:
    #    created_at メソッドを整形
    #
    # # 2015/04/09 => 20150409
    # def fmt_created_at
    #   return nil if submit_at.nil?
    #   submit_at.try(:to_era, '%Y%m%d')
    # end
    def define_format_date_method(*fields)
      fields.each do |attr_name|
        define_method("fmt_#{attr_name}") do
          return nil if send(attr_name).nil?
          send(attr_name).strftime('%Y%m%d')
        end
      end
    end
  end
end
