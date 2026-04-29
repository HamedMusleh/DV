module adder_tb;

    localparam WIDTH = 8;
    logic clk;
    logic reset;
    logic [WIDTH-1:0] in1, in2;
    logic [WIDTH:0] sum;

    // Queues
    int in_q1[$];
    int in_q2[$];
    int expected_q[$];
    int out_q[$];

    int i;
    int a, b;
    int errors;
    int expected;
    int actual;

    // DUT instantiation
    adder #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .reset(reset),
        .in1(in1),
        .in2(in2),
        .sum(sum)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0, adder_tb);

        clk = 0;
        reset = 1;
        in1 = 0;
        in2 = 0;
        errors = 0;

        // Fill input queues with 100 random values
        for (i = 0; i < 100; i = i + 1) begin
            a = $urandom_range(0, 255);
            b = $urandom_range(0, 255);

            in_q1.push_back(a);
            in_q2.push_back(b);
            expected_q.push_back(a + b);
        end

        // Reset handling
        #12;
        reset = 0;

        // fork/join will create tasks to work as parallel threads
        fork
            driver();
            monitor();
            checker();
        join
    end

    // Driver Task
    task driver;
        begin
            while (in_q1.size() > 0 && in_q2.size() > 0) begin
                @(posedge clk);
                in1 = in_q1.pop_front();
                in2 = in_q2.pop_front();
            end
        end
    endtask

    // Monitor Task
    task monitor;
        begin
            // wait 5 clock cycles after reset before start reading
            repeat (5) @(posedge clk);

            for (i = 0; i < 100; i = i + 1) begin
                @(posedge clk);
                out_q.push_back(sum);
            end
        end
    endtask

    // Checker Task
    task checker;
        begin
            repeat (6) @(posedge clk);

            for (i = 0; i < 100; i = i + 1) begin
                wait (out_q.size() > 0);

                expected = expected_q.pop_front();
                actual   = out_q.pop_front();

                if (expected !== actual) begin
                    $display("ERROR at sample %0d: expected = %0d, actual = %0d", i, expected, actual);
                    errors = errors + 1;
                end
            end

            if (errors == 0)
                $display("TEST PASSED");
            else
                $display("TEST FAILED, total errors = %0d", errors);

            $finish;
        end
    endtask

endmodule
