module instruction_memory(A , RD,rst);
    input [31:0] A;
    input rst;
    output [31:0] RD;
    //creation of memory
    reg [31:0] mem [1023:0];

    assign RD = (rst == 1'b0) ? 32'h00000000 : mem[A];
    initial begin
        mem[0] = 32'hFFC4A303;
    end
endmodule




