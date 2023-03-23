module FIFO 
#(parameter Addr_width = 5, 
            Data_width = 8)
(
    input wire Wr_enable, clk_write,
    input wire Read_enable, clk_read, rst,
    input wire [Data_width-1:0] data_in,
    output wire [Data_width-1:0] data_out
);

//-------------internal wires--------------------//
wire [Addr_width:0] Wr_addr, Rd_addr, Synch_Rd_point, Synch_Wr_point;
wire [Addr_width-1:0] Wr_point, Rd_point;
wire Full_sig, And_out_Wr, Empty_sig, And_out_Rd;

//------------instatiate our modules-------------//
Binary_counter #(.Addr_width(Addr_width)) B_Wr (
    .clk(clk_write),
    .stop(Full_sig),
    .Enable(Wr_enable),
    .rst(rst),
    .address(Wr_addr)
);

Binary2Gray #(.Addr_width(Addr_width)) B2G_Wr (
    .Binary_address(Wr_addr[Addr_width-1:0]),
    .Gray_pointer(Wr_point)
);

AND2 U1 (
    .in1_and(Wr_enable),
    .in2_and(Full_sig),
    .out_and(And_out_Wr)
);

Full #(.Addr_width(Addr_width)) F1 (
    .Wr_point({Wr_addr[Addr_width],Wr_point}),
    .Synch_Rd_point(Synch_Rd_point),
    .Full_sig(Full_sig)
);

Synchronizer #(.Width(Addr_width)) Sync_wr (
    .syn_in({Wr_addr[Addr_width],Wr_point}),
    .clk(clk_read),
    .rst(rst),
    .syn_out(Synch_Wr_point)
);

Memory #(.Data_width(Data_width), .Addr_width(Addr_width)) Mem1 (
    .Wr_data(data_in),
    .Wr_addr(Wr_addr[Addr_width-1:0]),
    .Rd_addr(Rd_addr[Addr_width-1:0]),
    .Wr_en(And_out_Wr),
    .Rd_en(And_out_Rd),
    .clk(clk_write),
    .rst(rst),
    .Rd_data(data_out)
);

AND2 U2 (
    .in1_and(Read_enable),
    .in2_and(Empty_sig),
    .out_and(And_out_Rd)
);

Synchronizer #(.Width(Addr_width)) Sync_rd (
    .syn_in({Rd_addr[Addr_width],Rd_point}),
    .clk(clk_write),
    .rst(rst),
    .syn_out(Synch_Rd_point)
);

Empty #(.Addr_width(Addr_width)) E1 (
    //.Rd_clk(clk_read),
    //.rst(rst),
    .Synch_Wr_point(Synch_Wr_point),
    .Rd_point({Rd_addr[Addr_width],Rd_point}),
    .Empty_sig(Empty_sig)
);

Binary_counter #(.Addr_width(Addr_width)) B_Rd (
    .clk(clk_read),
    .stop(Empty_sig),
    .Enable(Read_enable),
    .rst(rst),
    .address(Rd_addr)
);

Binary2Gray #(.Addr_width(Addr_width)) B2G_Rd (
    .Binary_address(Rd_addr[Addr_width-1:0]),
    .Gray_pointer(Rd_point)
);
endmodule