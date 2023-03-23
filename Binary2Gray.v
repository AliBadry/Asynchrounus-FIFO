module Binary2Gray #(
    parameter Addr_width = 5
) (
    input wire [Addr_width-1:0] Binary_address,
    output wire [Addr_width-1:0]  Gray_pointer
);
assign Gray_pointer[Addr_width-1] = Binary_address [Addr_width-1];


genvar i;
// -----------generating parametrized number of xor gates to -------------//
// ----------------convert the binary to gray converter-------------------//
for ( i=0 ;i< Addr_width-1; i=i+1) begin
    XOR2 U0 (.xor_in1(Binary_address[i]), .xor_in2(Binary_address[i+1]), .xor_out(Gray_pointer[i]));
end

    
endmodule