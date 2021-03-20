# Unit Test

mql_unit_test package is a simple instrument for unit testing for mql language.

## Installing

Download repo and copy `mql_unit_test/Include/unit_test.mqh` folder to `<TERMINAL DIR>/MQL(4/5)/Include`

## Usage

Create expert with a name, for example, `MyExpert`:

```mql4
#include <unit_test/unit_test.mqh>

double min(double v_1, double v_2) {
    if (v_1 > v_2) return v_2
    
    return v_1
}

class MyTest : public TestCase {
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


int OnInit(){
    ...
    
    MyTest my_test;
    my_test.run();
}
```

You can use any name of your test methods. In most language name of test methods start with `test_`. All test methods must be listed in `declare_tests()` of your test class.

Compile and run this your expert in terminal in a window of any trading pair and look test result in `<TERMINAL DIR>/Files/MyExpert_unit_test_log.txt`.
In log file you can see something like:
```
--- 2021.02.18 15:53: Unit Test: passed tests 5 from 7 (elapsed time: 0 sec) ---
MyExpert.mq4(24), MyTest::test_string_len(): 11 != 5
MyExpert.mq4(30), MyTest::test_my_function_min(): 0 != 5
```

In log file you can see next information:

- finished date of test,
- passed and total tests,
- elapsed time,
- list of failed tests.

To change a name fo log file, use method `set_output_file_path()`:

```mql4
MyTest my_test;
my_test.set_output_file_path("my_test_log.txt");
my_test.run();
```

## Run test of Unit test

1. Copy `mql_unit_test/Experts/TestUnitTest.mq4` to `<TERMINAL DIR>/MQL(4/5)/Experts`
2. Compile `TestUnitTest.mq4` and run `TestUnitTest.ex4` in terminal in a window of any trading pair.
3. Look test result in `<TERMINAL DIR>/Files/TestUnitTest_unit_test_log.txt`

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

Copyright © 2021 Artem Maltsev and contributors.

MIT licensed.
