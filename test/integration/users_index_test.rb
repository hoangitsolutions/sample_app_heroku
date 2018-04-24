require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users :michael
    @non_admin = users(:archer)
  end

  test "index as admin including pagination and delete links" do
    log_in_as @admin
    get users_path
    assert_template "users/index"
    assert_select "div.pagination"
    first_page_of_users = User.paginate(page: 1, per_page: Settings.user.number_items_per_page)
    first_page_of_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      assert_select "a[href=?]", user_path(user), text: I18n.t("users.index.delete") unless user == @admin
    end
    assert_difference "User.count", -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select "a", text: I18n.t("users.index.delete"), count: 0
  end
end
