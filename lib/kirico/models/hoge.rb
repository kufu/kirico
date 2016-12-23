# frozen_string_literal: true
require 'virtus'

module Kirico
  class Hoge
    include Virtus.model

    def foo
      'foo'
    end
  end
end
