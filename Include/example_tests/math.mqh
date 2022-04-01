#property copyright     "Copyright © 2021 Artem Maltsev (Vivazzi)"
#property description   "SimpleTest"
#property library


#include <unit_test/unit_test.mqh>


class MathTest: public TestCase {
    void test_math_abs() {
        assert_equal(MathAbs(-1.25), 1.25);
        assert_equal(MathAbs(2.15), 2.15);
    }

    void declare_tests() {
        test_math_abs();
    }
};
