# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'kirico'
require 'csv'
require 'factory_bot'

# データ定義ファイルの配置パスを設定し、定義させる。
FactoryBot.definition_file_paths = %w[./spec/factories]
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
