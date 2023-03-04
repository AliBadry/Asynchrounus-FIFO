module Memory
#(parameter Data_width = 8,
            Addr_width = 5)
(
    input wire [Data_width-1:0] Wr_data,
    input wire [Addr_width-1:0] Wr_addr, Rd_addr,
    input wire Wr_en, Rd_en, clk, rst,
    output reg [Data_width-1:0] Rd_data
);
integer i;
reg [Data_width-1:0]    Mem     [(2**Addr_width)-1:0];

always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
        for ( i=0;i<2**Addr_width ;i=i+1 ) begin
            Mem[i] <= 'b0;
            Rd_data <= 'b0;
        end
    end
    else if (Wr_en || Rd_en) begin
        if (Wr_en) begin
            Mem[Wr_addr] <= Wr_data;
        end
        if (Rd_en) begin
            Rd_data <= Mem[Rd_addr];
        end
    end
end
    
endmodule