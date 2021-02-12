#property copyright     "Copyright © 2021 Artem Maltsev (Vivazzi)"
#property link          "https://vivazzi.pro"
#property version		"1.00"
#property description   "mql_unit_test is a simple instrument for unit testing."
#property library

#define assert_equal(v_1, v_2) _assert_equal(__FILE__, __FUNCTION__, __LINE__, (v_1), (v_2))

class TestCase {
protected:
    string errors[];
    uint error_len;

    uint tests_number;
    uint successful_tests_number;

    uint start_time;

    // changed parameters
    string output_file_path;

public:
    TestCase() {
        error_len = 0;
        tests_number = 0;
        successful_tests_number = 0;
        output_file_path = MQLInfoString(MQL_PROGRAM_NAME) + "_unit_test_log.txt";
        start_time = GetTickCount();
    }

    void set_output_file_path(string _output_file_name){
        output_file_path = _output_file_name;
    };

    void add_error(string error) {
        error_len++;
        ArrayResize(errors, error_len);
        errors[error_len-1] = error;
    }

    template<typename T1,typename T2>
    void _assert_equal(string file, string func_sig, string line, T1 v_1, T2 v_2){
        tests_number++;
        // ex: TestFunc.mq4(38), MyTest::test_string_len(): 11 != 5
        if (v_1 != v_2) add_error(file + "(" + line + "), " + func_sig + "(): " + (string)v_1 + " != " + (string)v_2);
        else successful_tests_number++;
    }

    string pretty_time(int ms) {
        return (string)(ms/1000) + " sec";
    }

    bool check_file(int h_file) {
        if (h_file < 0) {
            Comment(output_file_path + ": Error with file creation (error: " + (string)GetLastError() + ")");
            return false;
        }

        return true;
    }

    bool init_log_file() {
        int handle = FileOpen(output_file_path, FILE_WRITE, ";");
        if (!check_file(handle)) return false;

        FileWrite(handle, StringFormat("--- %s: Unit Test: running... ---", TimeToString(TimeLocal())));
        FileClose(handle);

        return true;
    }

    virtual void declare_tests(){}

    void run(){
        if (!init_log_file()) return;

        declare_tests();

        // write log
        int handle = FileOpen(output_file_path, FILE_WRITE, ";");

        if (check_file(handle)) {
            FileWrite(
                handle,
                StringFormat("--- %s: Unit Test: passed tests %d from %d (elapsed time: %s) ---",
                             TimeToString(TimeLocal()), successful_tests_number, tests_number, pretty_time(GetTickCount() - start_time))
            );

            for (uint i=0;i<error_len;i++) FileWrite(handle, errors[i]);

            FileClose(handle);
        }
    };
};