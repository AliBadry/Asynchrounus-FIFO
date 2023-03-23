module AND2 (
    input wire in1_and, in2_and,
    output wire out_and
);
    assign out_and = in1_and & !(in2_and);    
endmodule