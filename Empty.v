module Empty 
#(parameter Addr_width = 5)
(
    //input wire Rd_clk, rst,
    input wire [Addr_width:0] Synch_Wr_point, Rd_point,
    output reg Empty_sig
);

always @(*) begin
    if(Synch_Wr_point == Rd_point)
    begin
        Empty_sig <= 1'b1;
    end
    else
    begin
        Empty_sig <= 1'b0;
    end
end

//------for sequential always block-----------//
/*always @(posedge Rd_clk or negedge rst) begin
    if(!rst)
    begin
        Empty_sig <= 1'b0;
    end
    else if(Synch_Wr_point == Rd_point)
    begin
        Empty_sig <= 1'b1;
    end
    else
    begin
        Empty_sig <= 1'b0;
    end
end*/
endmodule