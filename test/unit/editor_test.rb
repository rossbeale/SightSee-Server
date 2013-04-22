require 'test_helper'

class EditorTest < ActiveSupport::TestCase
  test "save Editor test" do
    editor = Editor.new
    editor.name = "Test Editor"
    editor.email = "test3@test.com"
    assert editor.save, "Saved failed"
  end
  
  test "editor should not save without email" do
    editor = Editor.new
    editor.name = "Test Editor"
    assert !editor.save, "Saved without email"
  end
end
