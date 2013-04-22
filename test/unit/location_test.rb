require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  test "location should save" do
    editor = Editor.new
    editor.name = "Test Editor"
    editor.email = "test6@test.com"
    editor.save
    
    category = Category.new
    category.name = "New Category"
    category.save
    
    location = Location.new
    location.name = "Test Location"
    location.lat = 44.4
    location.lng = 44.4
    location.editor = editor
    location.categories << category
    
    assert location.save, "Save failed"
  end
  
  test "location should not save without category" do
    editor = Editor.new
    editor.name = "Test Editor"
    editor.email = "test2@test.com"
    editor.save
    
    location = Location.new
    location.name = "Test Location"
    location.lat = 44.4
    location.lng = 44.4
    location.editor = editor
    
    assert !location.save, "Saved without category"
  end
  
end
