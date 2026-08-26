module data_mem(A , WD3 , clk, WE, RD);
    input [31:0] A,WD;
    input clk,WE;
    output [31:0] RD;
    reg [31:0] data_MEM [1023:0];
    //read
    assign RD = (WE == 1'b0) ? Data_MEM[A] : 32'h00000000;
    //write
    always @(posedge clk) begin
        if(WE)  
            begin
             Data_MEM[A] <= WD;
            end

    end

