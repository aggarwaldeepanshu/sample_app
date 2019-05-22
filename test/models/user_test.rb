require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

def setup
	@user=User.new(name: "Deepanshu Aggarwal", email: "user@example.com", password: "abcdefgh", password_confirmation: "abcdefgh")
end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name="  "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email="  "
  	assert_not @user.valid?
  end

  test "name should not be long" do
  	@user.name="a"*51
  	assert_not @user.valid?
  end

  test "email should not be long" do
  	@user.email="a"*244 + "@example.com"
  	assert_not @user.valid?
  end

  test "email validation should accept valid email" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  end
  end

  test "email address should be unique" do
  	duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  #test "email should be lowercase" do
  	#@user.email="D.AGGARWAL276@GMAIL.COM"
  	#@user.save
  	#assert_not @user.valid?
  #end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present(non blank)" do
  	@user.password=@user.password_confirmation=" "*6
  	assert_not @user.valid?
  end

  test "password should have minimum length" do
  	@user.password=@user.password_confirmation="a"*4
  	assert_not @user.valid?
  end
end
