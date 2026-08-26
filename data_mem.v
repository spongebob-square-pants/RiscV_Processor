module data_mem(A, WD, clk, WE, RD);
    input  [31:0] A, WD;
    input         clk, WE;
    output [31:0] RD;

    reg [31:0] data_MEM [1023:0];

    
    assign RD = data_MEM[A[11:2]];

    always @(posedge clk) begin
        if (WE)
            data_MEM[A[11:2]] <= WD;
    end
endmodule
