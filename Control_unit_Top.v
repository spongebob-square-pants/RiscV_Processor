'include "Alu_decoder.v"
'include "main_decoder.v"

module Control_unit_Top(op,RegWrite,ImmSrc, ALUSrc, MemWrite, ResultSrc, branch,funct3,funct7,ALUControl);
    input [6:0] op,funct7;
    input [2:0] funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,branch;
    output [1:0] ImmSrc;
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
        .branch(branch)
        

    );
    Alu_decoder Alu_Decoder(
        .Aluop(),
        .funct3(),
        .funct7(),
        .ALUControl(),
        op(op)
    );
endmodule