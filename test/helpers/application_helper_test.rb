require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  def setup
    @base_title = I18n.t("base_title")
  end

  test "full title helper" do
    assert_equal full_title, @base_title
    assert_equal full_title("Help"), "Help | #{@base_title}"
  end
end
