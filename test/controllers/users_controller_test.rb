require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@base_title="Ruby on Rails Sample App"
	end
  test "should get new" do
    #get users_new_url
    get signup_path
    assert_response :success
    assert_select "title", "Sign Up|#{@base_title}"
  end

end
