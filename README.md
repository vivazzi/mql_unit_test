# Unit Test

mql_unit_test package is a simple instrument for unit testing for mql language.

## Installing

Download repo and copy `mql_unit_test/Include/unit_test` folder to `<TERMINAL DIR>/MQL(4/5)/Include`

## Usage

You can use unit tests in your expert or use separated script and run tests separately.

### Unit tests as script

For example, create `SimpleTest.mq4` (or `SimpleTest.mq5`) to `<TERMINAL DIR>/MQL(4/5)/Scripts/tests`:

```mql4
#include <unit_test/unit_test.mqh>

double min(double v_1, double v_2) {
    if (v_1 > v_2) return v_2
    
    return v_1
}

class SimpleTest : public TestCase {
    void test_math_abs() {
        assert_equal(MathAbs(-1.25), 1.25);
        assert_equal(MathAbs(2.15), 2.15);
    }
    
    void test_string_len() {
        assert_equal(StringLen("xxx"), 3);
        assert_equal(StringLen("some string"), 5);  // test fails
    }
    
    void test_my_function_min() {
        assert_equal(min(4, 10), 4);
        assert_equal(min(8, 1), 1);
        assert_equal(min(5, 0), 5);  // test fails
    }
    
    void declare_tests() {
        test_math_abs();
        test_string_len();
        test_my_function_min();
    }
}


void OnStart() {
    SimpleTest test;
    test.run();
}
```

> You can use any name of your test methods. In most language name of test methods start with `test_`. All test methods must be listed in `declare_tests()` of your test class.

Compile and run your script in trading terminal in a window of any trading pair and look test result in `<TERMINAL DIR>/Files/SimpleTest_unit_test.log`.
In log file you can see something like:
```
--- 2022.04.01 12:51: Unit Test: passed tests 5 from 7 (elapsed time: 0 sec) ---
SimpleTest.mq4(25), SimpleTest::test_string_len(): 11 != 5
SimpleTest.mq4(31), SimpleTest::test_my_function_min(): 0 != 5
```

Log file consist of next information:

- finished date of test,
- passed and total tests,
- elapsed time,
- list of failed tests.

To change a name of log file, use method `set_output_file_path()`:

```mql4
SimpleTest test;
test.set_output_file_path("my_test.log");
test.run();
```


### Unit tests in your Expert

Maybe you will want to include tests to your Expert. Then it can look like:

```mql4
#define DEBUG;

#ifdef DEBUG
    #include "my_expert/tests.mqh"
#endif

int OnInit(){
    ...
    
    #ifdef DEBUG
        MyTest my_test;
        my_test.run();
    #endif
    
    ...
    
    return(INIT_SUCCEEDED);
}
```

Where `test.mqh` will have some tests.

> Note, example has `#define` constructions. Use `DEBUG` when you develop your Expert and comment `#define DEBUG;` when you are going to release your Expert to not include useless code in compiled file.

## Examples

There are some examples of unit tests in this repo: `mql_unit_test/Scripts/example_tests/`

## Run test of Unit test

1. Copy `mql_unit_test/Scripts/tests/` folder to `<TERMINAL DIR>/MQL(4/5)/Scripts/`
2. Compile `TestUnitTest.mq4` and run `TestUnitTest.ex4` in terminal in a window of any trading pair.
3. Look test result in `<TERMINAL DIR>/MQL(4/5)/Files/TestUnitTest_unit_test.log` and `<TERMINAL DIR>/MQL(4/5)/Files/TestUnitTest_MyFunctionTest_unit_test.log`

# CONTRIBUTING

To reporting bugs or suggest improvements, please use the [issue tracker](https://github.com/vivazzi/mql_unit_test/issues).

Thank you very much, that you would like to contribute to mql_unit_test. Thanks to the [present, past and future contributors](https://github.com/vivazzi/mql_unit_test/contributors).

If you think you have discovered a security issue in our code, please do not create issue or raise it in any public forum until we have had a chance to deal with it.
**For security issues use security@vuspace.pro**


# LINKS

- Project's home: https://github.com/vivazzi/mql_unit_test
- Report bugs and suggest improvements: https://github.com/vivazzi/mql_unit_test/issues
- Author's site, Artem Maltsev: https://vivazzi.pro
    
# LICENCE

Copyright © 2022 Artem Maltsev and contributors.

MIT licensed.
