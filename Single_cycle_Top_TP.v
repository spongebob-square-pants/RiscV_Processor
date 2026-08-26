module single_cycle_Top_Tb();
    reg clk, rst;

    single_cycle_Top single_cycle_Top(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        $dumpfile("single_cycle.vcd");
        $dumpvars(0, single_cycle_Top_Tb);
    end

   
    initial clk = 1'b0;
    always #50 clk = ~clk;

    initial begin
        rst = 1'b0;
        #150;
        rst = 1'b1;
        #500;
        $finish;
    end
endmodule
