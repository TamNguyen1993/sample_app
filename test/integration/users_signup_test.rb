require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "Invalid sign up information" do
    get signup_path
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path params: { user: { name: "", email: "validEmail@gmail.com", password: "", password_confirmation: "invalid"} }
    end

    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
