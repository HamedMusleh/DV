module adder #(
 parameter WIDTH = 8
)(
 input logic clk,
 input logic reset,
 input logic [WIDTH-1:0] in1,
 input logic [WIDTH-1:0] in2,
 output logic [WIDTH:0] sum
);
 logic [WIDTH:0] temp_sum;
 logic [WIDTH:0] sum_pipe [0:4];
 integer i;
 assign temp_sum = in1 + in2 ;
 always_ff @(posedge clk or posedge reset) begin
 if (reset) begin
 for (i = 0; i < 5; i++) begin
 sum_pipe[i] <= '0;
 end
 end
 else begin
 sum_pipe[0] <= temp_sum;
 for (i = 1; i < 5; i++) begin
 sum_pipe[i] <= sum_pipe[i-1];
 end
 end
 end
 assign sum = sum_pipe[4];
endmodule
