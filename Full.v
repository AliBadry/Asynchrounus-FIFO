module Full
#(parameter Addr_width = 5)
(
    //input wire Wr_clk, rst,
    input wire [Addr_width:0] Wr_point, Synch_Rd_point,
    output reg Full_sig
);

always @(*) begin
   if((Wr_point[Addr_width] != Synch_Rd_point[Addr_width]) && Wr_point[Addr_width-1:0] == Synch_Rd_point[Addr_width-1:0])
    begin
        Full_sig <= 1'b1;
    end
    else
    begin
        Full_sig <= 1'b0;
    end
end

//-----for sequential always block-------------//
/*always @(posedge Wr_clk or negedge rst) begin
    if(!rst)
    begin
        Full_sig <= 1'b0;
    end
    else if((Wr_point[Addr_width] != Synch_Rd_point[Addr_width]) && Wr_point[Addr_width-1:0] == Synch_Rd_point[Addr_width-1:0])
    begin
        Full_sig <= 1'b1;
    end
end*/
    
endmodule