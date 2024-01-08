module tb_rr_arbiter();

  // Inputs
  logic [3:0] req;
  logic clk;
  logic rst;

  // Outputs
  logic [3:0] gnt;

  // Instantiate the round-robin arbiter module
  rr_arbiter uut (
    .req(req),
    .gnt(gnt),
    .clk(clk),
    .rst(rst)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    $monitor("req = %b, gnt = %b", req, gnt);
    // Initialize inputs
    rst = 1;
    req = 4'b0000;

    // Apply reset
    #10 rst = 0;

    // Test case 1
    #10 req = 4'b0001; // gnt = 4'b0001
    #10 req = 4'b0010; // gnt = 4'b0010
    #10 req = 4'b0100; // gnt = 4'b0100
    #10 req = 4'b1000; // gnt = 4'b1000

    // Test case 2
    #10 req = 4'b0001; // gnt = 4'b0001
    #10 req = 4'b0100; // gnt = 4'b0100
    #10 req = 4'b1000; // gnt = 4'b1000
    #10 req = 4'b0010; // gnt = 4'b0010


    // End simulation
    #10 $finish;
  end

endmodule
