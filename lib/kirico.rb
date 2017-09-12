# frozen_string_literal: true

require 'kirico/version'
require 'kirico/models/application_record'
require 'kirico/models/company_count'
require 'kirico/models/company_identifier'
require 'kirico/models/company'
require 'kirico/models/data_identifier'
require 'kirico/models/data_record22187041'
require 'kirico/models/data_record22257041'
require 'kirico/models/fd_management_record'
require 'kirico/models/helper'
require 'kirico/models/form'
require 'kirico/models/sr_company_count'
require 'kirico/models/sr_fd_management_record'
require 'kirico/csv_generator'

module Kirico
  locale_path = Dir.glob("#{File.dirname(__FILE__)}/kirico/config/locales/*.yml")
  I18n.load_path += locale_path unless I18n.load_path.include?(locale_path)
end
