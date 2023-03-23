module XOR2 (
    input wire xor_in1, xor_in2,
    output wire xor_out
);
    assign xor_out = xor_in1^xor_in2;
endmodule