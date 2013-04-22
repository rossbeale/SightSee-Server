require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "save Category test" do
    category = Category.new
    category.name = "Test"
    assert category.save, "Saved failed"
  end
end
