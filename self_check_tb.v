`include "single_cycle_Top.v"


module self_check_tb();
    reg clk, rst;
    integer errors = 0;

    single_cycle_Top #(.MEM_INIT_FILE("tools/prog.hex")) dut(.clk(clk), .rst(rst));

    initial clk = 1'b0;
    always #5 clk = ~clk;

    task check_reg(input [4:0] idx, input [31:0] expected);
        begin
            if (dut.Register_file.Registers[idx] !== expected) begin
                $display("FAIL: x%0d = %0d (0x%h), expected %0d (0x%h)",
                    idx, $signed(dut.Register_file.Registers[idx]), dut.Register_file.Registers[idx],
                    $signed(expected), expected);
                errors = errors + 1;
            end else begin
                $display("PASS: x%0d = %0d", idx, $signed(expected));
            end
        end
    endtask

    task check_mem(input [31:0] word_idx, input [31:0] expected);
        begin
            if (dut.data_mem.data_MEM[word_idx] !== expected) begin
                $display("FAIL: mem[%0d] = 0x%h, expected 0x%h", word_idx, dut.data_mem.data_MEM[word_idx], expected);
                errors = errors + 1;
            end else begin
                $display("PASS: mem[%0d] = 0x%h", word_idx, expected);
            end
        end
    endtask

    initial begin
        rst = 1'b0;
        #12;
        rst = 1'b1;

       
        #260;

        $display("---- checking architectural state ----");
        check_reg(1, 5);     // addi
        check_reg(2, 3);     // addi
        check_reg(3, 8);     // add
        check_reg(4, 2);     // sub
        check_reg(5, 1);     // and
        check_reg(6, 7);     // or
        check_reg(7, 1);     // slt (3<5)
        check_reg(13, 4);    // andi
        check_reg(14, 7);    // ori
        check_reg(15, 1);    // slti
        check_reg(8, 8);     // lw
        check_reg(9, 42);    
        check_reg(10, 64);  
       
        if (dut.Register_file.Registers[11] === 32'd77) begin
            $display("FAIL: x11 = 77 -- jal failed to skip the instruction after it");
            errors = errors + 1;
        end else begin
            $display("PASS: x11 != 77 (jal correctly skipped it, value is 0x%h)", dut.Register_file.Registers[11]);
        end
        check_reg(12, 1);   
        check_mem(0, 8);    

        if (errors == 0)
            $display("\nALL CHECKS PASSED");
        else
            $display("\n%0d CHECK(S) FAILED", errors);

        $finish;
    end
endmodule
