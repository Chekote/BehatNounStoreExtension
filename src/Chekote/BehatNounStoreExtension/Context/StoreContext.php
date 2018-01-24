<?php

declare(strict_types=1);

namespace Chekote\BehatNounStoreExtension\Context;

use Behat\Behat\Context\Context;
use Chekote\NounStore\Store;
use Exception;
use RuntimeException;

/**
 * Context for testing the Noun Store Extension.
 */
class StoreContext implements Context
{
    /** @var Store the store instance */
    protected $store;

    /**
     * Constructor.
     */
    public function __construct()
    {
        $this->store = new Store();
    }

    /**
     * Resets the store before each Scenario.
     *
     * @BeforeScenario
     */
    public function reset()
    {
        $this->store->reset();

        // @todo: implement store initialization hook
    }

    /**
     * Ensures that the specified value is stored under the specified key.
     *
     * @Given the value :value is stored as :key
     *
     * @param string $key   the key to store the value under
     * @param string $value the value to store
     */
    public function ensureValueIsStored(string $key, string $value): void
    {
        $this->store->set($key, $value);
    }

    /**
     * Asserts that the specified value is (or is not) stored under the specified key.
     *
     * @Then the value stored as :key should be :value
     * @Then the value stored as :key should :not be :value
     *
     * @param  string           $key      the key to check.
     * @param  mixed            $expected the expected value.
     * @param  bool             $not      true if the check should be inverted.
     * @throws Exception        If a value is not stored for $key.
     * @throws RuntimeException If the stored value does not match the expected value.
     */
    public function assertValueIsStored(string $key, $expected, bool $not = false): void
    {
        $actual = $this->store->assertHas($key);

        if (!$not && $actual !== $expected) {
            throw new RuntimeException(
                sprintf(
                    "Expected $key to be '%s' but got '%s'",
                    print_r($expected, true),
                    print_r($actual, true)
                )
            );
        }

        if ($not && $actual == $expected) {
            throw new RuntimeException(
                sprintf(
                    "Expected $key not to be '%s' but it was",
                    print_r($expected, true)
                )
            );
        }
    }
}
