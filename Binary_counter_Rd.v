module Binary_counter_Rd #(
    parameter Addr_width = 5
) (
    input wire clk, stop, Enable, rst,
    //output reg overflow,
    output reg [Addr_width:0] address
);

always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
        address <= 'b0 ;//- 'b1;
        //overflow <= 1'b0;
    end
    else if(Enable && !stop)
    begin
        address <= address+1;
        //if (address == 'b0) begin
        //    overflow <= !overflow;
        //end
    end
end
    
endmodule