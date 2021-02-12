#property copyright "Copyright © 2019-2021 Artem Maltsev (Vivazzi)"
#property link      "https://vivazzi.pro"
#property strict


#include <unit_test/unit_test.mqh>


class MyTest: public TestCase {
    void test_math_abs() {
        assert_equal(MathAbs(-1.25), 1.25);
        assert_equal(MathAbs(2.15), 2.15);
    }

    void test_string_len() {
        assert_equal(StringLen("xxx"), 3);
        assert_equal(StringLen("some string"), 5);
    }

    void declare_tests() {
        test_math_abs();
        test_string_len();
    }
};


int OnInit(){
    MyTest my_test;
    my_test.run();

	return(INIT_SUCCEEDED);
}