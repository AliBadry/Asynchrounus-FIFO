module FIFO 
#(parameter Addr_width = 5, 
            Data_width = 8)
(
    input wire Wr_en, Wr_clk,
    input wire Rd_en, Rd_clk, rst,
    input wire [Data_width-1:0] Wr_data,
    output wire [Data_width-1:0] Rd_data
);

//-------------internal wires--------------------//
wire [Addr_width:0] Wr_addr, Rd_addr, Synch_Rd_point, Synch_Wr_point;
wire [Addr_width-1:0] Wr_point, Rd_point;
wire Full_sig, And_out_Wr, Empty_sig, And_out_Rd;

//------------instatiate our modules-------------//
Binary_counter_Wr #(.Addr_width(Addr_width)) B_Wr (
    .clk(Wr_clk),
    .stop(Full_sig),
    .Enable(Wr_en),
    .rst(rst),
    //.overflow(Wr_point[Addr_width]),
    .address(Wr_addr)
);

Binary2Gray #(.Addr_width(Addr_width)) B2G_Wr (
    .Binary_address(Wr_addr[Addr_width-1:0]),
    .Gray_pointer(Wr_point)
);

AND2 U1 (
    .in1(Wr_en),
    .in2(Full_sig),
    .out(And_out_Wr)
);

Full #(.Addr_width(Addr_width)) F1 (
    //.Wr_clk(Wr_clk),
    //.rst(rst),
    .Wr_point({Wr_addr[Addr_width],Wr_point}),
    .Synch_Rd_point(Synch_Rd_point),
    .Full_sig(Full_sig)
);

Synchronizer #(.Width(Addr_width)) Sync_wr (
    .in({Wr_addr[Addr_width],Wr_point}),
    .clk(Rd_clk),
    .rst(rst),
    .syn_out(Synch_Wr_point)
);

Memory #(.Data_width(Data_width), .Addr_width(Addr_width)) Mem1 (
    .Wr_data(Wr_data),
    .Wr_addr(Wr_addr[Addr_width-1:0]),
    .Rd_addr(Rd_addr[Addr_width-1:0]),
    .Wr_en(And_out_Wr),
    .Rd_en(And_out_Rd),
    .clk(Wr_clk),
    .rst(rst),
    .Rd_data(Rd_data)
);

AND2 U2 (
    .in1(Rd_en),
    .in2(Empty_sig),
    .out(And_out_Rd)
);

Synchronizer #(.Width(Addr_width)) Sync_rd (
    .in({Rd_addr[Addr_width],Rd_point}),
    .clk(Wr_clk),
    .rst(rst),
    .syn_out(Synch_Rd_point)
);

Empty #(.Addr_width(Addr_width)) E1 (
    //.Rd_clk(Rd_clk),
    //.rst(rst),
    .Synch_Wr_point(Synch_Wr_point),
    .Rd_point({Rd_addr[Addr_width],Rd_point}),
    .Empty_sig(Empty_sig)
);

Binary_counter_Rd #(.Addr_width(Addr_width)) B_Rd (
    .clk(Rd_clk),
    .stop(Empty_sig),
    .Enable(Rd_en),
    .rst(rst),
    //.overflow(Rd_point[Addr_width]),
    .address(Rd_addr)
);

Binary2Gray #(.Addr_width(Addr_width)) B2G_Rd (
    .Binary_address(Rd_addr[Addr_width-1:0]),
    .Gray_pointer(Rd_point)
);
endmodule