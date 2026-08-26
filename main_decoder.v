module main_decoder(op, RegWrite, MemWrite, Aluop, ResultSrc, ALUSrc, ImmSrc, branch, Jump);
    input  [6:0] op;
    output       RegWrite, MemWrite, ALUSrc, branch, Jump;
    output [1:0] ImmSrc, Aluop, ResultSrc;

   
    localparam LOAD   = 7'b0000011;
    localparam STORE  = 7'b0100011;
    localparam RTYPE  = 7'b0110011;
    localparam BRANCH = 7'b1100011;
    localparam OPIMM  = 7'b0010011;   
    localparam JAL_OP = 7'b1101111;

    assign RegWrite  = (op==LOAD) | (op==RTYPE) | (op==OPIMM) | (op==JAL_OP);
    assign MemWrite  = (op==STORE);
    assign ALUSrc    = (op==LOAD) | (op==STORE) | (op==OPIMM);
    
    assign ResultSrc = (op==LOAD)   ? 2'b01 :
                        (op==JAL_OP)? 2'b10 :
                        2'b00;
    assign branch    = (op==BRANCH);
    assign Jump      = (op==JAL_OP);
    assign ImmSrc    = (op==STORE)  ? 2'b01 :   // S-type
                        (op==BRANCH)? 2'b10 :   // B-type
                        (op==JAL_OP)? 2'b11 :   // J-type
                        2'b00;                   // I-type (load / op-imm / default)
    assign Aluop     = ((op==RTYPE) | (op==OPIMM)) ? 2'b10 :   
                        (op==BRANCH)                ? 2'b01 :  
                        2'b00;                                  

endmodule
