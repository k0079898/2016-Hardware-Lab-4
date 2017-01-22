//Team17 Testbench
`timescale 1ns/10ps
module Tb_Q1; //Team17, Coded by 104062261
  reg        CLK, RESET, green;
  wire       red;
  wire [1:0] state;
  Q1_FSM Q1(red, state, green, CLK, RESET);
  always begin
    #20
    CLK = ~CLK;
  end
  initial begin
    CLK = 0;
    RESET = 1;
    #40  RESET = 0;
    #40  green = 0;
         RESET = 1;
    #80  green = 1;
    #40  green = 0;
    #80  green = 1;
    #280 green = 0;
    #40  green = 1;
    #80  RESET = 0;
    #80  RESET = 1;
  end
endmodule

module Tb_Q2; //Team17, Coded by 104062261
  reg        CLK, RESET, green;
  wire       red;
  wire [1:0] state;
  Q2_FSM Q2(red, state, green, CLK, RESET);
  always begin
    #20
    CLK = ~CLK;
  end
  initial begin
    CLK = 0;
    RESET = 1;
    #40  RESET = 0;
    #40  green = 0;
         RESET = 1;
    #80  green = 1;
    #40  green = 0;
    #80  green = 1;
    #120 green = 0;
    #80  green = 1;
    #40  RESET = 0;
    #80  RESET = 1;
  end
endmodule

module Tb_Q3; //Team17, Coded by 104062261
  reg   CLK, RESET, in;
  wire  out;
  Q3_Sequence_Detector Q3(out, in, CLK, RESET);
  always begin
    #20
    CLK = ~CLK;
  end
  initial begin
    CLK = 0;
    RESET = 1;
    #40  RESET = 0;
         in    = 1;
    #40  RESET = 1;
    #40  in    = 0;
    #40  in    = 0;
    #40  in    = 1;
    #40  in    = 0;
    #40  in    = 0;
    #40  in    = 1;
    #40  in    = 0;
    #40  in    = 1;
    #40  in    = 0;
    #40  in    = 0;
    #40  in    = 1;
    #40  in    = 0;
    #40  in    = 1;
    #40  in    = 1;
    #40  in    = 0;
    #40  in    = 1;
    #40  in    = 0;
    #40  in    = 0;
    #40  in    = 1;  
  end
endmodule

module Tb_Q4; //Team17, Coded by 104062261
  wire [7:0]  DOUT;
  reg         CLK, REN, WEN;
  reg  [5:0]  ADDR;
  reg  [7:0]  DIN;
  Q4_Memory Q4(DOUT, CLK, REN, WEN, ADDR, DIN);
  always begin
    #20
    CLK = ~CLK;
  end   
  initial begin
    CLK  = 0;
    WEN  = 1;
    REN  = 1;
    ADDR = 6'b0;
    DIN  = 8'b0;
    #40  WEN  = 0;
         ADDR = 63;
         DIN  = 4;
    #40  ADDR = 45;
         DIN  = 8;
    #40  ADDR = 8;
         DIN  = 35;
    #40  ADDR = 26;
         DIN  = 77;
    #40  WEN  = 1;
         ADDR = 0;
         DIN  = 0;
    #120 REN  = 0;
         ADDR = 8;
    #40  ADDR = 26;
    #40  ADDR = 63;
    #40  ADDR = 45;
    #40  REN  = 1;
         ADDR = 0;
    #80  WEN  = 0;
         REN  = 0;
         ADDR = 26;
    #40  ADDR = 63;
    #40  WEN  = 1;
  end  
endmodule

module Tb_Q5; //Team17, Coded by 104062261
  wire [2:0] HW_light,LR_light;
  reg        CLK, RESET, LR_has_Car;
  Q5_Traffic_Light_Controller Q5(HW_light, LR_light, CLK, RESET, LR_has_Car);
  initial begin
    CLK = 0;
    RESET = 1;
    LR_has_Car = 0;
    #5 RESET = 0;
    #5 RESET = 1;
    #300 LR_has_Car = 1;
    #10 LR_has_Car = 0;
  end
  always begin
    #5
    CLK = ~CLK;
  end
endmodule

module Tb_OQ2; //Team17, Coded by 103062162
  reg CLK, RESET, Enable, FLIP;
  reg [3:0] MAX, MIN;
  wire Direction;
  wire [3:0] Out;
  OQ2_PingPong_Counter OQ2(Out, Direction, CLK, RESET, Enable, FLIP, MAX, MIN);
  initial begin
    CLK = 0;
	FLIP = 0;
	MIN = 3;
	MAX = 9;
    RESET = 1;
    Enable = 0;
    #20 Enable = 1;
    RESET = 0;
    #20 RESET = 1;
    #40 Enable = 0;
    #40 Enable = 1;
    #40 FLIP = 1;
    #40 FLIP = 0;
    #20 MAX = 3;
    #80 MAX = 7;
    #80 MIN = 6;
    #80 MIN = 4;
        MAX = 3;
    #80 MIN = 3;
        MAX = 9;
    #80 MAX = 5;
    #80 MAX = 9;
        MIN = 7;
    #80 MIN = 4;
  end
  always begin
    #20
    CLK = ~CLK;
  end
endmodule

