# frozen_string_literal: true
require 'kirico/version'
require 'kirico/models/changing_address_record'
require 'kirico/models/company_count'
require 'kirico/models/company_identifier'
require 'kirico/models/company'
require 'kirico/models/data_identifier'
require 'kirico/models/fd_management_record'
require 'kirico/models/helper'
require 'kirico/csv_generator'

module Kirico
  locale_path = Dir.glob(File.dirname(__FILE__) + '/kirico/config/locales/*.yml')
  I18n.load_path += locale_path unless I18n.load_path.include?(locale_path)
end
