# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kirico'
require 'pry'
require 'csv'
require 'factory_girl'
require 'shoulda-matchers'

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

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    # Choose one or more libraries:
    with.library :active_record
    with.library :active_model
  end
end

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end
