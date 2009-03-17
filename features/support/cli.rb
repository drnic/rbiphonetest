module CliHelpers
  def rbiphonetest_cmd
    @rbiphonetest_cmd ||= File.expand_path(File.dirname(__FILE__) + "/../../../bin/rbiphonetest")
  end
end

World { |world| world.extend CliHelpers }

