

module AuthFeaturesHelper
  def sign_up_user(username)
    visit "/users/new"
    fill_in "username", with: username
    fill_in "password", with: "abcdef"
    click_button "Sign Up"
  end

  def sign_up_as_john
    sign_up_user("john")
  end

  def sign_in(username)
    visit "/session/new"
    fill_in "username", with: username
    fill_in "password", with: "abcdef"
    click_button "Sign In"
  end

  def sign_in_as_john
    sign_in("john")
  end

  def create_goal_with_jill
    let(:jill) { User.create!(username: 'jill_bruce', password: 'abcdef') }
    let(:jill_goal) { jill.goals.create!(title: 'Run 5 Miles', private_goal: true) }
  end

  def make_goal(title, status)
    visit "/goals/new"

    fill_in "Title", with: title
    choose "private"
    click_button "Create Goal"
  end

  def sign_out
    click_button "Sign Out"
  end
  # def create_goal(goal)
  #   click_button "Add Goal"
  #   fill_in "Title", with: goal
  #   click_button "Create Goal"
  # end
end
