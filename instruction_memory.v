module instruction_memory #(
    parameter MEM_INIT_FILE = ""    
) (A, RD, rst);
    input  [31:0] A;
    input         rst;
    output [31:0] RD;

    reg [31:0] mem [1023:0];

   
    assign RD = (rst == 1'b0) ? 32'h00000000 : mem[A[11:2]];

    initial begin
        if (MEM_INIT_FILE != "")
            $readmemh(MEM_INIT_FILE, mem);   
                                              
        else
            mem[0] = 32'hFFC4A303;   
    end
endmodule
