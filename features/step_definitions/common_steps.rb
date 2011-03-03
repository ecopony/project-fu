Given /^I am logged in as a user$/ do
  @user = Factory.create(:user,
                         :password => "user_password",
                         :password_confirmation => "user_password"
  )

  Given %{login happens}
end

Given /^I am logged in as a project owner$/ do
  @user = Factory.create(:user,
                         :password => "user_password",
                         :password_confirmation => "user_password"
  )

  @project.project_memberships.create(:user => @user, :role => 'owner')

  Given %{login happens}
end

Given /^I am logged in as a project member$/ do
  @user = Factory.create(:user,
                         :password => "user_password",
                         :password_confirmation => "user_password"
  )

  @project.project_memberships.create(:user => @user, :role => 'member')  

  Given %{login happens}
end

Given /^login happens/ do
  Given %{I go to login}
  And %{I fill in "Login" with "#{@user.login}"}
  And %{I fill in "Password" with "#{@user.password}"}
  And %{I press "Sign in"}
end

Given /^I am logged out$/ do
  Given %{I go to logout}
end

Given(/^I have a user "([^\"]*)" identified by "([^\"]*)"$/) do |login, password|
  @user = Factory.create(:user,
    :login => login,
    :password => password,
    :password_confirmation => password
  )
end

