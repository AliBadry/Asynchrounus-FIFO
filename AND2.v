module AND2 (
    input wire in1, in2,
    output wire out
);
    assign out = in1 & !(in2);    
endmodule