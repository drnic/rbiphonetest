Feature: Generate, compile and test Objective-C classes with Ruby tests
  In order to reduce the cost of development and maintenance of Objective-C projects
  As an Objective-C developer
  I want a generator for new Objective-C models/classes that are covered by Ruby tests

  Scenario: Generate a single model and its default tests should pass
    Given an existing rbiphonetest scaffold using options '' [called 'my_project']
    When I invoke 'model' generator with arguments 'Person'
    Then file 'Classes/Person.m' is created
    And file 'Classes/Person.h' is created
    And file 'test/test_person.rb' is created
    When I invoke task 'rake test'
    Then all 1 tests pass
  
  Scenario: Generate a single model and its default tests should pass, for rspec project
    Given an existing rbiphonetest scaffold using options '--test-with=rspec' [called 'my_project']
    When I invoke 'model' generator with arguments 'Person'
    Then file 'Classes/Person.m' is created
    And file 'Classes/Person.h' is created
    And file 'spec/person_spec.rb' is created
    When I invoke task 'rake spec'
    Then all 1 tests pass
