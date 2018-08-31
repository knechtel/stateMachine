
`timescale 1ns / 1ps

module testaCpu;
  reg clk;
  reg clk2;
  reg rst;
  reg rst2;
  wire [3:0]dados;
  wire dados2;
  wire send2;
  wire ack;
  wire ack2;
  wire [3:0] dadosPeriferico;
  // Outputs
  wire [1:0] LA;
  wire [1:0] LB;
  // Outputs
  wire [1:0] estadoA;
  wire [1:0] estadoB;
  wire send;
  
  
   // Instantiate the Unit Under Test (UUT)
	machineCPU uut (
      .estadoA(estadoA),
      .estadoB(estadoB),   		
      .rst(rst),
      .clk(clk), 
      .dados(dados), 
      .ack(ack), 
      .send(send)
    
	);
  
    
  	periferico uutPeriferico (
      .LA(LA),			  
      .rst2(rst2),
      .clk2(clk2), 
      .dados2(dados), 
      .ack2(ack2), 
      .send2(send),
      .ack1(ack),
      .dadosPeriferico(dadosPeriferico)
 
	);

    
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  	rst=0;
    rst2 = 0;
    clk  = 0;
    clk2 = 0;
    
     #20
     rst2=1;
     rst=1;
     
     
     
  
  
  end

    
 
   always  #5  clk =  ! clk;
   always  #10  clk2 =  ! clk2;
endmodule
