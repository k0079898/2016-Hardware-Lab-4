module Q1_FSM(red, state, green, CLK, RESET); //Team17, Coded by 104062261
	output red;
	output [1:0] state;
	input green, CLK, RESET;
	//Team17, Coded by 104062261
	reg       red;
	reg [1:0] state, n_state;
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	parameter S3 = 2'b11;
	always@(posedge CLK or negedge RESET) begin
	  if(!RESET) begin
	    state <= S0;
	  end else begin
	    state <= n_state;
	  end
	end
    always@(*) begin
      case (state)
        S0 : if(green) n_state = S1;
             else      n_state = S0;
        S1 : if(green) n_state = S2;
             else      n_state = S1;
        S2 : if(green) n_state = S0;
             else      n_state = S3;
        S3 : if(green) n_state = S1;
             else      n_state = S2;
      endcase
    end
    always@(*) begin
      case (state)
        S0 : red = 1'b0;
        S1 : red = 1'b1;
        S2 : red = 1'b0;
        S3 : red = 1'b1;
      endcase
    end
    //Team17, Coded by 104062261
endmodule


module Q2_FSM(red, state, green, CLK, RESET); //Team17, Coded by 104062261
	output red;
	output [1:0] state;
	input green, CLK, RESET;
	//Team17, Coded by 104062261
	reg       red;
    reg [1:0] state, n_state;
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
	always@(posedge CLK or negedge RESET) begin
      if(!RESET) begin
        state <= S0;
      end else begin
        state <= n_state;
      end
    end
    always@(*) begin
      case (state)
        S0 : if(green) n_state = S1;
             else      n_state = S0;
        S1 : if(green) n_state = S2;
             else      n_state = S1;
        S2 : if(green) n_state = S1;
             else      n_state = S0;
      endcase
    end
    always@(*) begin
      case (state)
        S0 : red = ~green;
        S1 : red = green;
        S2 : red = 1'b1;
      endcase
    end
    //Team17, Coded by 104062261
endmodule


module Q3_Sequence_Detector(out, in, CLK, RESET); //Team17, Coded by 104062261
	output out;
	input in, CLK, RESET;
	//Team17, Coded by 104062261
	reg       out,value;
	reg [1:0] state, n_state,count;
	parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;
    always@(posedge CLK or negedge RESET) begin
      if(!RESET) begin
        state <= S0;
        count <= 0;
      end else begin
        state <= n_state;
        if (count==3) begin
          count <= 0;
        end else begin
          count <= count + 1;
        end
      end
    end	
    always@(*) begin
      case (state)
        S0 : if(in) n_state = S1;
             else   n_state = S0;
        S1 : if(in) n_state = S1;
             else   n_state = S2;
        S2 : if(in) n_state = S1;
             else   n_state = S3;
        S3 : if(in) n_state = S1;
             else   n_state = S0;             
      endcase
    end
    always@(*) begin
      case (state)
        S3 : value = in;
        default : value = 1'b0;
      endcase
    end
    always@(*) begin
      case (count)
        2'b11 : out = value;
        default : out = 1'b0;
      endcase
    end    
	//Team17, Coded by 104062261
endmodule

module Q4_Memory(DOUT, CLK, REN, WEN, ADDR, DIN); //Team17, Coded by 104062261
	output [7:0] DOUT;
	input CLK, REN, WEN;
	input [5:0] ADDR;
	input [7:0] DIN;
    //Team17, Coded by 104062261
    reg [7:0] MEM [0:63];
    reg [7:0] DOUT;
    always @(posedge CLK) begin
      if(!REN) begin
        DOUT <= MEM[ADDR];
      end else begin
        DOUT <= 8'd0;
      end
    end
    always @(*) begin
      if(REN && !WEN) begin
        MEM[ADDR] = DIN;
      end
    end
    //Team17, Coded by 104062261
endmodule

module Q5_Traffic_Light_Controller(HW_light, LR_light, CLK, RESET, LR_has_Car); //Team17, Coded by 104062261
	output [2:0] HW_light;
	output [2:0] LR_light;
	input CLK, RESET, LR_has_Car;
    //Team17, Coded by 104062261
    parameter HGLR  = 3'b000;
    parameter HYLR  = 3'b001;
    parameter HRLR1 = 3'b010;
    parameter HRLG  = 3'b011;
    parameter HRLY  = 3'b100;
    parameter HRLR2 = 3'b101;
    reg [5:0] cycle,n_cycle;
    reg [3:0] state,n_state;
    reg [2:0] HW_light,LR_light;
    always@(posedge CLK or negedge RESET) begin
      if(!RESET) begin
        state <= HGLR;
        cycle <= 24;
      end else begin
        state <= n_state;
        if(cycle!=0) cycle <= cycle - 1;
        else begin
          case (n_state)
            HGLR  : if(state==HGLR) cycle <= 0;
                    else if(state==HRLR2) cycle <= 24;
            HYLR  : cycle <= 4;
            HRLR1 : cycle <= 0;
            HRLG  : cycle <= 24;
            HRLY  : cycle <= 4;
            HRLR2 : cycle <= 0;
          endcase
        end
      end
    end
   always@(*) begin
     case (state)
        HGLR  : if(cycle==0 && LR_has_Car==1) n_state=HYLR;
                else n_state=HGLR;
        HYLR  : if(cycle==0) n_state=HRLR1;
                else n_state=HYLR;
        HRLR1 : if(cycle==0) n_state=HRLG;
                else n_state=HRLR1;
        HRLG  : if(cycle==0) n_state=HRLY;
                else n_state=HRLG;
        HRLY  : if(cycle==0) n_state=HRLR2;
                else n_state=HRLY;
        HRLR2 : if(cycle==0) n_state=HGLR;
                else n_state=HRLR2;   
      endcase
    end
    always@(*) begin
      case (state)
        HGLR  : begin
                  HW_light=3'b001;
                  LR_light=3'b100;
                end
        HYLR  : begin
                  HW_light=3'b010;
                  LR_light=3'b100;
                end
        HRLR1 : begin
                  HW_light=3'b100;
                  LR_light=3'b100;
                end
        HRLG  : begin
                  HW_light=3'b100;
                  LR_light=3'b001;
                end  
        HRLY  : begin
                  HW_light=3'b100;
                  LR_light=3'b010;
                end  
        HRLR2 : begin
                  HW_light=3'b100;
                  LR_light=3'b100;
                end  
      endcase
    end
    //Team17, Coded by 104062261
endmodule

module OQ1_Stopwatch(AN, Seg, Dot, CLK, Start, RESET); //Team17, Coded by 104062261
	output [3:0] AN;
	output [6:0] Seg;
	output Dot;
	input CLK, Start, RESET;
	//Team17, Coded by 104062261
	parameter R = 2'b00;
    parameter W = 2'b01;
    parameter C = 2'b10;	
	reg  [23:0] divider_ds;
	reg  [16:0] divider_ms=0;
	reg  [6:0]  Seg_Temp;
	reg  [3:0]  D3=4'b1111,D2=4'b1111,D1=4'b1111,D0=4'b1111,D_Temp=4'b0000,AN_Temp=4'b1110;
	reg  [1:0]  state,n_state;
	reg         dp;
	wire        RTC_ds,RTC_ms;
	always @(posedge CLK) begin
	  if(divider_ms==100000) divider_ms <= 0;
      else divider_ms <= divider_ms + 1;
    end
    assign RTC_ms = ((divider_ms == 100000)?1'b1:1'b0);
	always @(posedge CLK or posedge RESET) begin
      if(RESET) divider_ds <= 0;
      else if(divider_ds==10000000) divider_ds <= 0;
      else if(state==C) divider_ds <= divider_ds + 1;
    end
    assign RTC_ds = ((divider_ds == 10000000)?1'b1:1'b0);
	always@(posedge CLK or posedge RESET) begin
      if(RESET) begin
        state <= R;
        D3 <= 0;
        D2 <= 0;
        D1 <= 0;
        D0 <= 0;
      end else begin
        state <= n_state;
        if(RTC_ds) begin
          if(D0 == 9) begin
            D0 <= 0;
            if(D1 == 9) begin
              D1 <= 0;
              if(D2 == 9) begin
                D2 <= 0;
                if(D3 == 9) begin
                  D3 <= 0;                  
                end else begin
                  D3 <= D3 + 1;
                end                    
              end else begin
                D2 <= D2 + 1;
              end      
            end else begin
              D1 <= D1 + 1;
            end
          end else begin
            D0 <= D0 + 1;
          end
        end      
      end
    end
    always@(*) begin
      case (state)
        R : if(RESET) n_state = R;
            else if(Start && !RESET) n_state = C;
            else if(!Start && !RESET) n_state = W;
        W : if(RESET) n_state = R;
            else if(Start && !RESET) n_state = C;
            else if(!Start && !RESET) n_state = W;
        C : if(RESET) n_state = R;
            else n_state = C;        
      endcase
    end
    always@(posedge RTC_ms) begin
      case(AN_Temp)
        4'b0111 : begin
                    D_Temp = D0;
                    AN_Temp <= 4'b1110;
                    dp <= 1;
                  end
        4'b1110 : begin
                    D_Temp = D1;
                    AN_Temp <= 4'b1101;
                    dp <= 0;
                  end
        4'b1101 : begin
                    D_Temp = D2;
                    AN_Temp <= 4'b1011;
                    dp <= 1;
                  end
        4'b1011 : begin
                    D_Temp = D3;
                    AN_Temp <= 4'b0111;
                    dp <= 1;
                  end
      endcase
    end    
    always @(*) begin
        case(D_Temp)
          0 : Seg_Temp=7'b1000000;//0
          1 : Seg_Temp=7'b1111001;//1
          2 : Seg_Temp=7'b0100100;//2
          3 : Seg_Temp=7'b0110000;//3
          4 : Seg_Temp=7'b0011001;//4
          5 : Seg_Temp=7'b0010010;//5
          6 : Seg_Temp=7'b0000010;//6
          7 : Seg_Temp=7'b1111000;//7
          8 : Seg_Temp=7'b0000000;//8
          9 : Seg_Temp=7'b0011000;//9
          default : Seg_Temp=7'b0111111;//-
      endcase
    end
    assign Seg = Seg_Temp;
    assign AN = AN_Temp;
    assign Dot = dp;
	//Team17, Coded by 104062261
endmodule

module OQ2_PingPong_Counter(Out, Direction, CLK, RESET, Enable, FLIP, MAX, MIN); //Team17, Coded by 103062162
	output [3:0] Out;
	output Direction;
	input CLK, RESET, Enable, FLIP;
	input [3:0] MAX;
	input [3:0] MIN;
	//Team17, Coded by 103062162
	reg [3:0] counter;
	reg Direction = 0;
    always @(posedge CLK or negedge RESET) begin 
      if ( RESET == 0 ) begin
        counter = MIN;
      end else begin
        //if ( Enable == 1 & MAX > MIN) begin 
        if ( Enable==1 && MAX>MIN && counter<=MAX && counter>=MIN ) begin //Bug fixed, by 104062261
          if ( (counter == MAX & Direction == 0) || (counter == MIN & Direction == 1) || FLIP==1) begin
            Direction = ~Direction;
          end
          if (Direction == 0) begin
            counter = counter + 1'b1;
          end else begin
            counter = counter - 1'b1;
          end
        end
      end
    end
    assign Out = counter;
    //Team17, Coded by 103062162
endmodule


