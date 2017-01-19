# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kirico'
require 'pry'
require 'csv'
require 'factory_girl'

# データ定義ファイルの配置パスを設定し、定義させる。
FactoryGirl.definition_file_paths = %w(./spec/factories)
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
