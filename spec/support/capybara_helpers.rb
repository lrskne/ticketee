# New file created 7/20/13 (listing 7.6)
# capybara_helpers.rb
# have_css - makes the module use a CSS selector to attempt to
# find  a tag that matches the conditions.
module CapybaraHelpers
  def assert_no_link_for(text)
    page.should_not(have_css("a", :text => text),
    "Expected not to see the #{text.inspect} link, but did.")
  end
  def assert_link_for(text)
    page.should(have_css("a", :text => text),
    "Expected to see the #{text.inspect} link, but did not.")
  end
end

RSpec.configure do |config|
  config.include CapybaraHelpers, :type => :request
end
