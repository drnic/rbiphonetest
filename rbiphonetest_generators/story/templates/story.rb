require File.dirname(__FILE__) + "/story_helper"

with_steps_for(:<%= name %>) do
  run_local_story "<%= name %>_story"
end