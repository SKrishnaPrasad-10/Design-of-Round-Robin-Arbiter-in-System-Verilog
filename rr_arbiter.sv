module rr_arbiter(clk, rst, req, gnt);
  input logic [3:0] req;
  output logic [3:0] gnt;
  input logic clk;
  input logic rst;
  
  logic [3:0] gnt_next;
  
  always_ff @(posedge clk or posedge rst) begin
    if(rst)
      gnt <= 4'b0000;
    else
      gnt <= gnt_next;
  end
  
  always_comb begin
    casez(gnt)
      4'b0000 : begin
                  casez(req)
                    4'b???1 : gnt_next = 4'b0001;
                    4'b??10 : gnt_next = 4'b0010;
                    4'b?100 : gnt_next = 4'b0100;
                    4'b1000 : gnt_next = 4'b1000;
                    default : gnt_next = 4'b0000;
                  endcase
                end
       4'b0001 : begin
                  casez(req)
                    4'b??1? : gnt_next = 4'b0010;
                    4'b?10? : gnt_next = 4'b0100;
                    4'b100? : gnt_next = 4'b1000;
                    4'b0001 : gnt_next = 4'b0001;
                    default : gnt_next = 4'b0001;
                  endcase
                end
      4'b0010 : begin
                  casez(req)
                    4'b?1?? : gnt_next = 4'b0100;
                    4'b10?? : gnt_next = 4'b1000;
                    4'b00?1 : gnt_next = 4'b0001;
                    4'b0010 : gnt_next = 4'b0010;
                    default : gnt_next = 4'b0010;
                  endcase
                end
      4'b0100 : begin
                  casez(req)
                    4'b1??? : gnt_next = 4'b1000;
                    4'b0??1 : gnt_next = 4'b0001;
                    4'b0?10 : gnt_next = 4'b0010;
                    4'b0100 : gnt_next = 4'b0100;
                    default : gnt_next = 4'b0100;
                  endcase
                end
      4'b1000 : begin
                  casez(req)
                    4'b???1 : gnt_next = 4'b0001;
                    4'b??10 : gnt_next = 4'b0010;
                    4'b?100 : gnt_next = 4'b0100;
                    4'b1000 : gnt_next = 4'b1000;
                    default : gnt_next = 4'b1000;
                  endcase
                end
      default : gnt_next = gnt;
    endcase
  end
endmodule
