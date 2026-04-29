module my_mem (	
    input logic        clk,
    input  logic        write,
    input  logic        read,
    input  logic [7:0]  data_in,
    input  logic [15:0] address,
    output logic [8:0]  data_out
);

    logic [8:0] mem_array [logic [15:0]];

    always @(posedge clk) begin
        if (write)
            mem_array[address] <= {^data_in, data_in};  // even parity + data
        else if (read)
            data_out <= mem_array[address];
    end

endmodule
