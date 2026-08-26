module single_cycle_Top_Tb();
    reg clk,rst;
    single_cycle_Top single_cycle_Top(
        .clk(clk),
        .rst(rst)
    );
    initial begin
        $dumpfile("single cycle.vcd");
        $dumpvars(0);
    end
    always
    begin
        clk = ~clk;
        #50;
    end
    initial
    begin
        rst = 1'b0;
        #150;

        rst = 1'b1;
        #500;
        $finish;
    end
endmodule

