`timescale 1ns / 1ps

module tiny_processor_tb;

    reg clk;

    
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

    parameter [3:0]
        MISC_NOP = 4'b0000,
        MISC_LSL = 4'b0001,
        MISC_LSR = 4'b0010,
        MISC_CIR = 4'b0011,
        MISC_CIL = 4'b0100,
        MISC_ASR = 4'b0101,
        MISC_INC = 4'b0110,
        MISC_DEC = 4'b0111;

    // Instantiate the tiny processor
    tiny_processor uut (.clk(clk));

    // Clock generation
    always #5 clk = ~clk;

    initial begin // Binary to decimal conversion.
        clk = 0;

        // Input binary number = 56
        uut.registers[0] = 8'd56;

        // Clear registers
        uut.registers[1] = 0; // Tens
        uut.registers[2] = 0; // Units
        uut.registers[6] = 8'd10; // Will be used for subtraction and comparasion.

        // Copy input to R4
        uut.instruction_mem[0]  = {OPC_LDA, 4'd0};  // Load R0 // Input
        uut.instruction_mem[1]  = {OPC_STA, 4'd4};  // R4 is used as a temperory register.

        // Loop for getting the tens face value.        
        uut.instruction_mem[2]  = {OPC_LDA, 4'd4};  // Load R4
        uut.instruction_mem[3]  = {OPC_CMP, 4'd6};  // Compare with R6 (which we'll set to 10)
        uut.instruction_mem[4]  = {OPC_BR,  4'd12};  // If less, jump to count unit face value
        uut.instruction_mem[5]  = {OPC_SUB, 4'd6};  // Subtract 10
        uut.instruction_mem[6]  = {OPC_STA, 4'd4};  // Store back in R4
        uut.instruction_mem[7] = {OPC_SUB, 4'd4}; // Clears the accumulator
        uut.instruction_mem[8] = {OPC_LDA, 4'd1}; // loading R1
        uut.instruction_mem[9] = {OPC_MISC, MISC_INC}; // incremeting by 1
        uut.instruction_mem[10] = {OPC_STA, 4'd1}; // store back in R1 (tens)
        uut.instruction_mem[11]  = {OPC_JMP, 4'd2};  // Repeat loop

        // Loop for getting the units face value.
        // L12:
        uut.instruction_mem[12] = {OPC_LDA, 4'd4};  // Load R4
        uut.instruction_mem[13] = {OPC_STA, 4'd2};  // Store in R2 (units)

        // HALT
        uut.instruction_mem[14] = {OPC_HLT, OPC_HLT};


        #600;
        
        $finish;
    end

endmodule

