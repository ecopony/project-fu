Given /^I am logged in as a user$/ do
  @user = Factory.create(:user,
    :email => "testuser@project-fu.com",
    :password => "user_password",
    :password_confirmation => "user_password"
  )

  Given %{I go to login}
  And %{I fill in "user_email" with "#{@user.email}"}
  And %{I fill in "user_password" with "#{@user.password}"}
  And %{I press "Sign in"}
end

Given /^I am logged out$/ do
  Given %{I go to logout}
end

