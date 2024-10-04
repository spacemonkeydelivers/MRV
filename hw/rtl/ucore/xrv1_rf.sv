module xrv1_rf
#(
    parameter DATA_WIDTH_P = 32,
    parameter rf_addr_width_p = 5,
    parameter rf_size_lp = (1 << rf_addr_width_p)
) (
    ////////////////////////////////////////////////////////////////////////////////
    input logic                             clk_i,
    input logic                             rst_i,
    ////////////////////////////////////////////////////////////////////////////////
    // Read port 0
    ////////////////////////////////////////////////////////////////////////////////
    input logic [rf_addr_width_p-1:0]       rs0_addr_i,
    output logic [DATA_WIDTH_P-1:0]         rs0_data_o,
    ////////////////////////////////////////////////////////////////////////////////
    // Read port 1
    ////////////////////////////////////////////////////////////////////////////////
    input logic [rf_addr_width_p-1:0]       rs1_addr_i,
    output logic [DATA_WIDTH_P-1:0]         rs1_data_o,
    ////////////////////////////////////////////////////////////////////////////////
    // Write port 0
    ////////////////////////////////////////////////////////////////////////////////
    input logic                             rd_w_en_i,
    input logic [rf_addr_width_p-1:0]       rd_addr_i,
    input logic [DATA_WIDTH_P-1:0]          rd_data_i
    ////////////////////////////////////////////////////////////////////////////////
);
    ////////////////////////////////////////////////////////////////////////////////
    logic [rf_size_lp-1:0][DATA_WIDTH_P-1:0] rf_mem;
    ////////////////////////////////////////////////////////////////////////////////
    assign rs0_data_o = rs0_addr_i == 'b0 ? 'b0 : rf_mem[rs0_addr_i];
    assign rs1_data_o = rs1_addr_i == 'b0 ? 'b0 : rf_mem[rs1_addr_i];
    ////////////////////////////////////////////////////////////////////////////////
    always_ff @(posedge clk_i) begin
        if (rd_w_en_i)
            rf_mem[rd_addr_i] <= rd_data_i;
    end
    ////////////////////////////////////////////////////////////////////////////////
    function [DATA_WIDTH_P - 1:0] read_reg;
        /* verilator public */
        input integer reg_addr;
        read_reg = rf_mem[reg_addr];
    endfunction
    ////////////////////////////////////////////////////////////////////////////////
endmodule
