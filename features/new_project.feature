Feature: Created a new Objective-C project that can be tested by Ruby tests
  In order to reduce the cost of development and maintenance of Objective-C projects
  As an Objective-C developer
  I want a generator for new Objective-C libraries that are covered by Ruby tests

  Scenario: Generate new project (defaults test/unit)
    Given a safe folder
    When I execute rbiphonetest for project 'my_project' with options ''
    Then file 'Rakefile' is created
    And Rakefile can display tasks successfully
    And file 'test/test_helper.rb' is created
  
  Scenario: Generate new test/unit project
    Given a safe folder
    When I execute rbiphonetest for project 'my_project' with options '--test-with=test_unit'
    Then file 'Rakefile' is created
    And Rakefile can display tasks successfully
    And file 'test/test_helper.rb' is created

Scenario: Generate new rspec project
    Given a safe folder
    When I execute rbiphonetest for project 'my_project' with options '--test-with=rspec'
    Then file 'Rakefile' is created
    And Rakefile can display tasks successfully
    And file 'spec/spec_helper.rb' is created

