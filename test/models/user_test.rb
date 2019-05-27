require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup 
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be presence" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" *244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should follow the specific email format" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
    foo@bar_baz.com foo@bar+baz.com]

    invalid_addresses.each do |invalid_address| 
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup 
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as lower_case before save" do
    mixed_case_email = "tamDolaKL@GmAil.COm"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "user password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid? 
  end

  test "user password should have a minimum lengh" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end



end
