#property copyright     "Copyright © 2021 Artem Maltsev (Vivazzi)"
#property description   "SimpleTest"
#property library


#include <unit_test/unit_test.mqh>


double min(double v_1, double v_2) {
    if (v_1 > v_2) return v_2;

    return v_1;
}


class MyFunctionTest: public TestCase {
    void test_my_function_min() {
        assert_equal(min(4, 10), 4);
        assert_equal(min(8, 1), 1);
        assert_equal(min(5, 0), 5);  // test fails
    }

    void declare_tests() {
        test_my_function_min();
    }
};
