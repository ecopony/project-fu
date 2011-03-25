When /^I drag "([^"]*)" down (.+) pixels$/ do |story_title, pixels|
  story = Story.find_by_title(story_title)
  src = page.find("#stories_#{story.id}")
  src.native.drag_and_drop_by(0, pixels) # Still not doing my bidding
end
