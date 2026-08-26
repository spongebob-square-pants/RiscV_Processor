`include "program_counter.v"
`include "instruction_memory.v"
`include "register_files.v"
`include "Sign_extend.v"
`include "ALU.v"
`include "Control_unit_Top.v"
`include "data_mem.v"
`include "PC_Adder.v"
`include "Mux.v"

module single_cycle_Top #(
    parameter MEM_INIT_FILE = ""
) (clk, rst);
    input clk, rst;

    wire RegWrite, MemWrite, ALUSrc, branch, Jump, PCSrc;
    wire Z, N, V, C;
    wire [1:0] ImmSrc, ResultSrc;
    wire [2:0] ALUControl;

    wire [31:0] Mux_out_ReadData, SrcB, RD2_Top, Pc_Plus_Four, ReadData;
    wire [31:0] PC_Top, RD_Instr, RD1_Top, Imm_Ext_Top, Result_Top;
    wire [31:0] PC_Branch, PC_Next;

    PC_Module PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_NEXT(PC_Next)
    );

   
    PC_Adder PC_Adder_Plus4(
        .a(PC_Top),
        .b(32'd4),
        .c(Pc_Plus_Four)
    );

    
    PC_Adder PC_Adder_Branch(
        .a(PC_Top),
        .b(Imm_Ext_Top),
        .c(PC_Branch)
    );

    
    assign PCSrc   = Jump | (branch & Z);
    assign PC_Next = PCSrc ? PC_Branch : Pc_Plus_Four;

    instruction_memory #(.MEM_INIT_FILE(MEM_INIT_FILE)) Instruction_Memory(
        .rst(rst),
        .A(PC_Top),
        .RD(RD_Instr)
    );

    reg_file Register_file(
        .A1(RD_Instr[19:15]),
        .A2(RD_Instr[24:20]),
        .A3(RD_Instr[11:7]),
        .WD3(Mux_out_ReadData),
        .WE3(RegWrite),
        .clk(clk),
        .rst(rst),
        .RD1(RD1_Top),
        .RD2(RD2_Top)
    );

    Sign_Extend Sign_Extend(
        .In(RD_Instr),
        .Imm_ext(Imm_Ext_Top),
        .ImmSrc(ImmSrc)
    );

    Mux Mux_Register_to_ALU(
        .a(RD2_Top),
        .b(Imm_Ext_Top),
        .s(ALUSrc),
        .c(SrcB)
    );

    alu ALU(
        .A(RD1_Top),
        .B(SrcB),
        .ALUControl(ALUControl),
        .Result(Result_Top),
        .Z(Z),
        .N(N),
        .V(V),
        .C(C)
    );

    Control_unit_Top Control_unit_Top(
        .op(RD_Instr[6:0]),
        .funct3(RD_Instr[14:12]),
        .funct7(RD_Instr[31:25]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .branch(branch),
        .Jump(Jump),
        .ALUControl(ALUControl)
    );

    data_mem data_mem(
        .clk(clk),
        .A(Result_Top),
        .WE(MemWrite),
        .WD(RD2_Top),
        .RD(ReadData)
    );

  
    assign Mux_out_ReadData = (ResultSrc == 2'b00) ? Result_Top     :
                               (ResultSrc == 2'b01) ? ReadData       :
                               (ResultSrc == 2'b10) ? Pc_Plus_Four   :
                               32'h00000000;

endmodule
