module Alu_decoder(Aluop , op5 , funct3 , funct7 , ALUControl)
    input op5 , funct7;
    input [2:0] funct3;
    output [2:0] ALUControl;

    wire [1,0] concetenation;
    assign concetenation = {op5 , func7};

    assign ALUControl = (Aluop == 2'b00) ? 3'b000:
    (Aluop == 2'b01) ? 3'b001 :
    ((Aluop == 2'b10) & (funct3 == 3'b010) ) ? 3'b101:
    ((Aluop == 2'b10) & (funct3 == 3'b110) ) ? 3'b011:
    ((Aluop == 2'b10) & (funct3 == 3'b111) ) ? 3'b010:
    ((Aluop == 2'b10) & (funct3 == 3'b000) & (concetenation == 2'b11) ) ? 3'b001:
    3'b000;
endmodule