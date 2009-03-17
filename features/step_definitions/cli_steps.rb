# force_local_lib_override

When /^I execute rbiphonetest for project '(.*)' with options '(.*)'/ do |project_name, arguments|
  setup_active_project_folder project_name
  in_tmp_folder do
    @stdout = File.expand_path("newgem.out")
    system "ruby #{rbiphonetest_cmd} #{arguments} #{project_name} > #{@stdout}"
    force_local_lib_override
  end
end

