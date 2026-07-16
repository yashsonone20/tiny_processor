`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.06.2025 21:16:08
// Design Name: 
// Module Name: tiny_processor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tiny_processor(input clk
);

    // Instruction memory and general-purpose registers
    reg [7:0] instruction_mem [0:15];
    reg [7:0] registers [0:15];
    
    // Special purpose registers
    reg [7:0] acc;   // Accumulator
    reg [7:0] ext;   // Extension (for multiplication overflow)
    reg       carry_flag;
    reg [3:0] pc;    // Program counter

    // Instruction opcodes
    parameter [3:0]
        OPC_MISC = 4'b0000,
        OPC_ADD  = 4'b0001,
        OPC_SUB  = 4'b0010,
        OPC_MUL  = 4'b0011,
        OPC_AND  = 4'b0101,
        OPC_XOR  = 4'b0110,
        OPC_CMP  = 4'b0111,
        OPC_BR   = 4'b1000,
        OPC_LDA  = 4'b1001,
        OPC_STA  = 4'b1010,
        OPC_JMP  = 4'b1011,
        OPC_HLT  = 4'b1111;

    // miscellaneous operations (when opcode = 0000)
    parameter [3:0]
        MISC_NOP = 4'b0000,
        MISC_LSL = 4'b0001,
        MISC_LSR = 4'b0010,
        MISC_CIR = 4'b0011,
        MISC_CIL = 4'b0100,
        MISC_ASR = 4'b0101,
        MISC_INC = 4'b0110,
        MISC_DEC = 4'b0111;

    initial pc = 0;

    always @(posedge clk) begin
        case (instruction_mem[pc][7:4])

            OPC_MISC: begin
                case (instruction_mem[pc][3:0])
                    MISC_NOP: pc = pc + 1;
                    MISC_LSL: begin acc = acc << 1; pc = pc + 1; end
                    MISC_LSR: begin acc = acc >> 1; pc = pc + 1; end
                    MISC_CIR: begin acc = {acc[0], acc[7:1]}; pc = pc + 1; end
                    MISC_CIL: begin acc = {acc[6:0], acc[7]}; pc = pc + 1; end
                    MISC_ASR: begin acc = {acc[7], acc[7:1]}; pc = pc + 1; end
                    MISC_INC: begin acc = acc + 1; if (acc == 0) carry_flag = ~carry_flag; pc = pc + 1; end
                    MISC_DEC: begin acc = acc - 1; if (acc == 8'hFF) carry_flag = ~carry_flag; pc = pc + 1; end
                    default:  pc = 4'bxxxx;
                endcase
            end

            OPC_ADD: begin
                {carry_flag, acc} = acc + registers[instruction_mem[pc][3:0]];
                pc = pc + 1;
            end

            OPC_SUB: begin
                {carry_flag, acc} = acc - registers[instruction_mem[pc][3:0]];
                pc = pc + 1;
            end

            OPC_MUL: begin
                {ext, acc} = acc * registers[instruction_mem[pc][3:0]];
                pc = pc + 1;
            end

            OPC_AND: begin
                acc= acc & registers[instruction_mem[pc][3:0]];
                pc = pc + 1;
            end

            OPC_XOR:begin
                acc = acc ^ registers[instruction_mem[pc][3:0]];
                pc = pc + 1;
            end

            OPC_CMP:begin
                carry_flag = (acc<registers[instruction_mem[pc][3:0]]);
                pc = pc + 1;
            end

            OPC_BR:begin
                if (carry_flag) pc=instruction_mem[pc][3:0];
                else pc = pc + 1;
            end

            OPC_LDA:begin
                acc = registers[instruction_mem[pc][3:0]];
                pc = pc + 1;
            end

            OPC_STA:begin
                registers[instruction_mem[pc][3:0]] = acc;
                pc = pc + 1;
            end

            OPC_JMP: begin
                pc= instruction_mem[pc][3:0];
            end

            OPC_HLT: begin
                if (instruction_mem[pc][3:0] == OPC_HLT)
                    pc= pc;  // Stay halted
                else
                    pc = 4'bxxxx;
            end

            default: pc = 4'bxxxx;

        endcase
    end

endmodule
