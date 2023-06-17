/* small memory module to store image */

module mem #(
	parameter int COL_SIZE = 0,
	parameter int ROW_SIZE = 0
)(
	input logic clk,
	input logic [31:0] rd_addr,
	output logic [23:0] data_out
);

(* rom_style="{distributed | block}" *)
logic [23:0] memory [0:COL_SIZE*ROW_SIZE];

initial begin
	$readmemh("img.mem", memory);
end

assign data_out = memory[rd_addr];

/*always_ff @(posedge clk)begin
	if (we) data_out <= (rd_addr < COL_SIZE*ROW_SIZE) ? memory[rd_addr] : 24'hff0000;
end*/


endmodule
