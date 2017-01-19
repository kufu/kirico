# frozen_string_literal: true
class TestModel
  include ActiveModel::Validations

  def initialize(attributes = {})
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

# For CharsetValidator
class CharSetTestKanji < TestModel
  validates_with Kirico::CharsetValidator, attributes: :my_field, accept: [:kanji]
end

# For SjisBytesizeValidator
class SjisBytesizeTestIs3 < TestModel
  validates_with Kirico::SjisBytesizeValidator, attributes: :my_field, is: 3
end

class SjisBytesizeTestRange3to5 < TestModel
  validates_with Kirico::SjisBytesizeValidator, attributes: :my_field, within: 3..5
end

class SjisBytesizeTestMin5 < TestModel
  validates_with Kirico::SjisBytesizeValidator, attributes: :my_field, minimum: 5
end

class SjisBytesizeTestMax5 < TestModel
  validates_with Kirico::SjisBytesizeValidator, attributes: :my_field, maximum: 5
end

class SjisBytesizeTestMin3Max5 < TestModel
  validates_with Kirico::SjisBytesizeValidator, attributes: :my_field, minimum: 3, maximum: 5
end
