package transaction_pkg;

    class Transaction;

        // variables
        rand bit [15:0] address;
        rand bit [7:0]  data_in;

        bit [8:0] data_out;
        bit [8:0] expected_data;

        //  static error counter
        static int error = 0;

        // constructor (random)
        function new();
            address = $urandom;
            data_in = $urandom;
        endfunction

        // print data_out
        function void print_data_out();
            $display("[TIME %0t] DATA_OUT = %0h", $time, data_out);
        endfunction

        // static print error
        static function void print_error();
            $display("[TIME %0t] ERROR COUNT = %0d", $time, error);
        endfunction

        // checker
        function void check();
            if (data_out !== expected_data) begin
                error++;
                $display("Mismatch! expected=%0h got=%0h", expected_data, data_out);
            end
        endfunction

        // deep copy
        function Transaction copy();
            Transaction t = new();
            t.address = this.address;
            t.data_in = this.data_in;
            t.expected_data = this.expected_data;
            t.data_out = this.data_out;
            return t;
        endfunction

    endclass

endpackage
