Feature: Store Values
  In order to maintain state history across Behat steps
  As a Behat developer
  I should be able to store and retrieve multiple values for the same key across steps

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

  Scenario: Assertion passes for multiple values under one key
    Given a feature file "features/store_value.feature" containing:
    """
    Feature: Store

        Scenario: Stored multiple values match
           Given the value "John" is stored as "First Name"
             And the value "Michael" is stored as "First Name"
             And the value "Sarah" is stored as "First Name"
             And the value "Alice" is stored as "First Name"
             And the value "Christian" is stored as "First Name"
            Then the value stored as "1st First Name" should be "John"
             And the value stored as "2nd First Name" should be "Michael"
             And the value stored as "3rd First Name" should be "Sarah"
             And the value stored as "4th First Name" should be "Alice"
             And the value stored as "5th First Name" should be "Christian"
    """
    When I run Behat
    Then it should pass
