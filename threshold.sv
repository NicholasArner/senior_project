module threshold
#(
	parameter int IMG_HEIGHT = 0,
	parameter int IMG_WIDTH = 0,
	parameter logic [31:0] THRESH = 0
) (
	input logic clk,
	input logic rst,
	input logic [9:0] cx, // pixel positions
	input logic [9:0] cy, 
	
	output logic [23:0] rgb
);

/* states for the SM */

logic [23:0] output_pxl;
logic [31:0] rd_addr; 
logic [23:0] img_pxl;
logic [23:0] new_img_pxl;
logic [7:0] new_r;
logic [7:0] new_g;
logic [7:0] new_b;

// memory where image is stored

mem #(
	.COL_SIZE (IMG_HEIGHT),
	.ROW_SIZE (IMG_WIDTH)
) mem_i (
	.clk (clk),
	.rd_addr (rd_addr),
	.data_out (img_pxl)
);

always_ff @(posedge clk) begin
	rgb <= (cx < IMG_WIDTH && cy < IMG_HEIGHT) ? new_img_pxl : 24'hffC0CB; 
end

/* do the threshholding operation */
always_comb begin
	new_r = (img_pxl[23:16] > THRESH) ? 0 : img_pxl[23:16];
	new_g = (img_pxl[15:8] > THRESH) ? 0 : img_pxl[15:8];
	new_b = (img_pxl[7:0] > THRESH) ? 0 : img_pxl[7:0];
	new_img_pxl = {new_r, new_g, new_b};
end

/* format read address based on x and y pixel positions*/
always_ff @(posedge clk)begin
	rd_addr <= IMG_WIDTH*cy + cx;
end

endmodule
