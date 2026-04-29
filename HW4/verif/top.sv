module top;
    initial begin
    	$fsdbDumpfile("waves.fsdb");
    	$fsdbDumpvars(0, top);
    end
    mem_if mif();

    my_mem dut(mif);

    test tb(mif);

    initial begin
        mif.clk = 0;
        forever #50 mif.clk = ~mif.clk;
    end

endmodule
