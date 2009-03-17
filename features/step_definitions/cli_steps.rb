When /^I execute rbiphonetest for project '(.*)' with options '(.*)'/ do |project_name, arguments|
  setup_active_project_folder project_name
  in_tmp_folder do
    @stdout = File.expand_path("newgem.out")
    system "ruby #{rbiphonetest_cmd} #{arguments} #{project_name} > #{@stdout}"
    force_local_lib_override
  end
end

Given /^an existing rbiphonetest scaffold using options '(.*)' \[called '(.*)'\]/ do |arguments, project_name|
  Given "a safe folder"
  Given "I execute rbiphonetest for project '#{project_name}' with options '#{arguments}'"
end

