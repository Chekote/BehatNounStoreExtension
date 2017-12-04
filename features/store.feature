Feature: Store Values
  In order to maintain state across Behat steps
  As a Behat developer
  I should be able to store and retrieve values across steps

  Background:
    Given a Behat configuration containing:
        """
        default:
          suites:
            default:
              path: "%paths.base%/features"
              contexts:
                - Chekote\BehatNounStoreExtension\Context\StoreContext
        """

  Scenario: Assertion passes when stored value matches
    Given a feature file "features/store_value.feature" containing:
    """
    Feature: Store

        Scenario: Stored value matches
           Given the value "John" is stored as "First Name"
            Then the value stored as "First Name" should be "John"
    """
    When I run Behat
    Then it should pass

  Scenario: Assertion fails when stored value does not match expectation
    Given a feature file "features/store_value.feature" containing:
    """
    Feature: Store

        Scenario: Stored value doesn't match
           Given the value "John" is stored as "First Name"
            Then the value stored as "First Name" should be "Sarah"
    """
    When I run Behat
    Then it should fail with "Expected First Name to be 'Sarah' but got 'John'"

  Scenario: Assertion passes when stored value does not match as expected
    Given a feature file "features/store_value.feature" containing:
    """
    Feature: Store

        Scenario: Stored value doesn't match as expected
           Given the value "John" is stored as "First Name"
            Then the value stored as "First Name" should not be "Sarah"
    """
    When I run Behat
    Then it should pass

  Scenario: Assertion passes when stored value matches after update
    Given a feature file "features/replace_value.feature" containing:
    """
    Feature: Store

        Scenario: Stored value matches after update
           Given the value "John" is stored as "First Name"
             But the value "Mike" is stored as "First Name"
            Then the value stored as "First Name" should not be "John"
             But the value stored as "First Name" should be "Mike"
    """
    When I run Behat
    Then it should pass
