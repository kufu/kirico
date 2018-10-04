#!/bin/bash -e
test_reports_dir=$CIRCLE_TEST_REPORTS/rspec
mkdir -p $test_reports_dir

circleci tests glob "spec/**/*_spec.rb" | \
circleci tests split --split-by=timings --timings-type=filename | \
xargs bundle exec rspec --color --format RspecJunitFormatter --out $test_reports_dir/hanica.xml --format progress --require spec_helper --tag ~type:profiling --profile --
