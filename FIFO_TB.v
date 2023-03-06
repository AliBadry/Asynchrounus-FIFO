`timescale 1ns/1ps
module FIFO_TB 
#(parameter Addr_width = 5,
            Data_width = 8)
();
    reg Wr_en_tb, Wr_clk_tb;
    reg Rd_en_tb, Rd_clk_tb, rst_tb;
    reg [Data_width-1:0] Wr_data_tb;
    wire [Data_width-1:0] Rd_data_tb;
    integer i;

    initial begin
        rst_tb = 1'b1;
        Wr_en_tb = 1'b0;
        Rd_en_tb = 1'b0;
        Wr_data_tb = 'b0;

        #9
        rst_tb = 1'b0;
        #13
        rst_tb = 1'b1;
        //--------------check the read of the empety fifo-----------//
        #17
        Rd_en_tb = 1'b1;
        if(FIFO_TB.DUT.Empty_sig == 1'b1)
        begin
            $display("The FIFO is empty which is correct!!");
        end
        else
        begin
            $display("The FIFO is not empty which is incorrect!!");
            $stop;
        end
        //------------write two data in the fifo--------------//
        #10
        Rd_en_tb = 1'b0;
        Wr_en_tb = 1'b1;
        Wr_data_tb = 'b01001101;
        #10
        Wr_en_tb = 1'b1;
        Wr_data_tb = 'b11111111;
        #10
        Wr_en_tb = 1'b0;
        #40
        #5
        
        Rd_en_tb = 1'b1;
        //--------------read the two data in the fifo to make it empety---------//
        #10
        if (Rd_data_tb == 'b01001101) begin
            $display("The first output is correct");
        end
        else
        begin
            $display("The first output is incorrect");
            $stop;
        end
        #10
        if (Rd_data_tb == 'b11111111) begin
            $display("The second output is correct");
        end
        else
        begin
            $display("The second output is incorrect");
            $stop;
        end
        #10
        Rd_en_tb = 1'b0;
        #10
        //----------------Fill the fifo to rise the full flag-------//
        for (i=0 ; i<32;i=i+1 ) begin
            
            Wr_en_tb = 1'b1;
            Wr_data_tb = 'b01001101+i;
            #10;
        end
        //----------------check the full flag-------------//
        #40
        Wr_en_tb = 1'b0;
        if (FIFO_TB.DUT.Full_sig == 1'b1) begin
            $display("The FIFO is full");
        end
        else
        begin
            $display("The FIFO is not full");
            $stop;
        end
        //-------------read all the fifo and check the empty----------//
        #10
        Rd_en_tb = 1'b1;
        #512
        if (FIFO_TB.DUT.Empty_sig == 1'b1) begin
            $display("The FIFO is empty");
        end
        else
        begin
            $display("The FIFO is not empty");
            $stop;
        end
        $stop;

    end

    initial begin
        Wr_clk_tb = 1'b0;
        forever  #5 Wr_clk_tb = !Wr_clk_tb;       
    end

    initial begin
        Rd_clk_tb = 1'b0;
        forever  #8 Rd_clk_tb = !Rd_clk_tb;       
    end

    FIFO #( .Addr_width(Addr_width), .Data_width(Data_width)) DUT (
        .Wr_enable(Wr_en_tb),
        .clk_write(Wr_clk_tb),
        .Read_enable(Rd_en_tb),
        .clk_read(Rd_clk_tb),
        .rst(rst_tb),
        .data_in(Wr_data_tb),
        .data_out(Rd_data_tb)
    );
endmodule