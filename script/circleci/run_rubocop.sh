#!/bin/bash -e
test_reports_dir=$CIRCLE_TEST_REPORTS/rubocop
mkdir -p $test_reports_dir
junit_formatter_ruby=$(bundle show rubocop-junit-formatter 2>/dev/null)/lib/rubocop/formatter/junit_formatter.rb

bundle exec rubocop -L | \
circleci tests split --split-by=timings --timings-type=filename | \
xargs bundle exec rubocop -D -R -r $junit_formatter_ruby -c .rubocop.yml --format RuboCop::Formatter::JUnitFormatter --out $test_reports_dir/rubocop.xml
