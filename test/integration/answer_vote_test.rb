require 'test_helper'

class AnswerVoteTest < ActionDispatch::IntegrationTest

  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL


  test "the truth" do
    assert true
  end
end
