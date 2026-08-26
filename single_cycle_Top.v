'include "program_counter.v"
'include "instruction_memory.v"
'include "register_files.v" 
'include "sign_exxtend.v"
'include "ALU.v"
'include "Control_unit_Top.v"
'include "data_mem.v"
'include "PC_Adder.v"
'include "Mux.v"


module single_cycle_Top(clk,rst);
    input clk,rst;
    wire RegWrite,  MemWrite , ALUSrc,ResultSrc;
    wire [1:0] ImmSrc;
        
    wire [31:0] Mux_out_ReadData,SrcB,RD2_Top,Pc_Plus_Four,ReadData,PC_Top, RD_Instr, RD1_Top, Imm_Ext_Top;
    wire [2:0] ALUControl_Top;
    PC_Module PC(
        .clk(clk),
        .rst(rst),
        .PC(PC_Top),
        .PC_Next(Pc_Plus_Four)

    );
    Mux Mux_Register_to_ALU(
        .a(RD2_Top),
        .b(Imm_Ext_Top),
        .c(SrcB),
        .s(ALUSrc)
    );
    instruction_memory Instruction_Memory(
            .rst(rst),
            .A(PC_Top),
            .RD(RD_Instr)


    );
    reg_file Register_file(
        .A1(RD_Instr[19:15]),
        .A2(),
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
    alu ALU(
        .A(RD1_Top),
        .B(SrcB),
        .ALUControl(ALUControl_Top),
        .Result(),
        .Z(),
        .N(),
        .V(),
        .C()

    ); 
    Control_unit_Top Control_unit_Top(
        .op(RD_Instr[6:0]),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUSrc(ALUSrc),
        .MemWrite(MemWrite),
        .ResultSrc(ResultSrc),
        .branch(),
        .funct3(RD_Instr[14:12]),
        .funct7(),
        .ALUControl(ALUControl_Top)
    );
    data_mem data_mem(
        .clk(clk),
        .rst(rst),
        .A(Result),
        .WE(MemWrite),
        .WD(RD2_Top),
        .RD(ReadData)
    );
    Pc_Adder PC_Adder(
        .a(PC_Top),
        .b(32'd4),
        .c(Pc_Plus_Four);

    );
    Mux Mux_DataMemory_to_Register(
        .a(Result),
        .b(ReadData),
        .c(Mux_out_ReadData),
        .s(ResultSrc)
    );


    