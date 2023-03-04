module Synchronizer
#(parameter Width = 5)
 (
    input wire [Width:0] in, 
    input wire clk, rst,
    output reg [Width:0] syn_out
);
reg [Width:0] inter; //intermidiate signal between the 2 FF
    always @(posedge clk or negedge rst) begin
        if(!rst)
        begin
            syn_out<='b0;
            inter <= 'b0;
        end
        else
        begin
            inter <= in;
            syn_out <= inter;
        end
    end
endmodule