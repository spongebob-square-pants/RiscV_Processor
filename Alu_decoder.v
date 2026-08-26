module Alu_decoder(op5, funct7b5, funct3, Aluop, ALUControl);
    input        op5;
    input        funct7b5;
    input  [2:0] funct3;
    input  [1:0] Aluop;
    output [2:0] ALUControl;

    
    
    wire RtypeSub;
    assign RtypeSub = funct7b5 & op5;

    assign ALUControl = (Aluop == 2'b00) ? 3'b000 :                                                // lw/sw  -> add
                         (Aluop == 2'b01) ? 3'b001 :                                                // beq    -> subtract
                         ((Aluop == 2'b10) & (funct3 == 3'b000)) ? (RtypeSub ? 3'b001 : 3'b000) :   // add/sub
                         ((Aluop == 2'b10) & (funct3 == 3'b010)) ? 3'b101 :                          // slt
                         ((Aluop == 2'b10) & (funct3 == 3'b110)) ? 3'b011 :                          // or
                         ((Aluop == 2'b10) & (funct3 == 3'b111)) ? 3'b010 :                          // and
                         3'b000;
endmodule
