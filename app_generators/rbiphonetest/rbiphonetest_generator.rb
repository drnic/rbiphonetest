class RbiphonetestGenerator < RubiGen::Base

  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options :author => nil,
                  :test_framework => 'test_unit'

  attr_reader :name, :module_name
  attr_reader :test_framework

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name             = base_name.gsub("-", "_")
    @module_name      = name.camelize
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory ''
      BASEDIRS.each { |path| m.directory path }

      # Create stubs
      m.template_copy_each ["Rakefile"]
      m.file           "dot_autotest", ".autotest"
      
      # Selecting a test framework
      case test_framework
      when "test_unit"
        m.dependency "install_test_unit", [name], :destination => destination_root, :collision => :force
      when "rspec"
        m.dependency "install_rspec", [name], :destination => destination_root, :collision => :force
      end
      
      m.dependency "install_rubigen_scripts", [destination_root, 'rbiphonetest', 'iphone', test_framework],
        :shebang => options[:shebang], :collision => :force
    end
  end

  protected
    def banner
      <<-EOS
Want to write iPhone unit tests? Want to write them in Ruby? 
Run this generator in the root folder of your Xcode project for your iPhone app.

USAGE: #{spec.name} name
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      opts.on("-s", "--test-with=TEST_FRAMEWORK", String,
              "Select your preferred testing framework.",
              "Options: test_unit (default), rspec.") { |x| options[:test_framework] = x }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
      @test_framework    = options[:test_framework] || "test_unit"
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      Classes
      tasks
    )
end
