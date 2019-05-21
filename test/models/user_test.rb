require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

def setup
	@user=User.new(name: "Deepanshu Aggarwal", email: "d.aggarwal276@gmail.com")
end

  test "should be valid" do
  	assert @user.valid?
  end
end
