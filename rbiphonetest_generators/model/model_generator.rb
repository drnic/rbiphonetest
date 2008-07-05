class ModelGenerator < RubiGen::Base

  default_options :author => nil

  attr_reader :name, :class_name
  attr_reader :installed_frameworks

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @name = args.shift.underscore
    @class_name = @name.camelcase
    extract_options
    extract_test_frameworks
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory 'Classes'

      # Create stubs
      m.template "model.h",  "Classes/#{class_name}.h"
      m.template "model.m",  "Classes/#{class_name}.m"
      
      # It is possible for 2+ test frameworks to be installed.
      # Current behaviour is to generate test stubs for all of them
      # and let the developer delete files they don't want
      if installed_frameworks.include? "test_unit"
        m.dependency "model_test_unit", [name], :destination => destination_root, :collision => :force
      end
      if installed_frameworks.include? "rspec"
        m.dependency "model_rspec", [name], :destination => destination_root, :collision => :force
      end
    end
  end

  protected
    def banner
      <<-EOS
Creates an NSObject model (header and implementation files) 
plus a Ruby test file (either test/unit or rspec).

USAGE: #{$0} #{spec.name} name
EOS
    end

    def add_options!(opts)
      # opts.separator ''
      # opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |options[:author]| }
      # opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end
    
    # Attempts to determine which test framework is being used
    # Else prompts user
    def extract_test_frameworks
      @installed_frameworks = []
      @installed_frameworks << "test_unit" if Dir[File.join(destination_root, "test")].length > 0
      @installed_frameworks << "rspec" if Dir[File.join(destination_root, "spec")].length > 0
        
      if @installed_frameworks.length == 0
        # no test-related files created
        puts <<-EOS
WARNING: you do not have a test-framework installed.
Run either:
  script/generate install_test_unit
  script/generate install_rspec

and then rerun this generator.
        EOS
      end
    end
end