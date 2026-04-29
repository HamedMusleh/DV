interface mem_if;

    logic clk;
    logic write;
    logic read;
    logic [7:0] data_in;
    logic [15:0] address;
    logic [8:0] data_out;

    // Checker
    always @(posedge clk) begin
        if (read && write)
            $error("Read and Write together!");
    end

    // Clocking block
    clocking cb @(posedge clk);
        output write, read, data_in, address;
        input data_out;
    endclocking

endinterface
