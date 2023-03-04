module Binary_counter #(
    parameter Addr_width = 5
) (
    input wire clk, stop, Enable, rst,
    //output reg overflow,
    output reg [Addr_width:0] address
);

always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
        address <= 'b0;
    end
    else if(Enable && !stop)
    begin
        address <= address+1;
    end
end
    
endmodule