`include "Alu_decoder.v"
`include "main_decoder.v"

module Control_unit_Top(op, funct3, funct7, RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, branch, Jump, ALUControl);
    input  [6:0] op, funct7;
    input  [2:0] funct3;
    output       RegWrite, ALUSrc, MemWrite, branch, Jump;
    output [1:0] ImmSrc, ResultSrc;
    output [2:0] ALUControl;

    wire [1:0] Aluop;

    main_decoder Main_Decoder(
        .op(op),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .Aluop(Aluop),
        .ResultSrc(ResultSrc),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .branch(branch),
        .Jump(Jump)
    );

    Alu_decoder Alu_Decoder(
        .op5(op[5]),
        .funct7b5(funct7[5]),
        .funct3(funct3),
        .Aluop(Aluop),
        .ALUControl(ALUControl)
    );
endmodule
