
`timescale 1ns / 1ps
//iverilog -o my_design  test.v module.v
module testaCpu;
  reg clk;
  reg clk2;
  reg rst;
  reg rst2;
   
  wire [3:0] dados;
  wire dados2;
  wire ack;
   
   
  wire [3:0] dadosPeriferico;
  // Outputs
  wire [3:0] estadoPeriferico;

  // Outputs
  wire [3:0] estadoCPU;
  wire send;
  
   // Instantiate the Unit Under Test (UUT)
	machineCPU uut (
      .estadoCPU(estadoCPU),   		
      .rst(rst),
      .clk(clk), 
      .dados(dados), 
      .ack(ack), 
      .send(send)
	);
  
    
  	periferico uutPeriferico (
      .estadoPeriferico(estadoPeriferico),			  
      .rst2(rst2),
      .clk2(clk2), 
      .dados2(dados),  
      .send2(send),
      .ack1(ack),
      .dadosPeriferico(dadosPeriferico)				  
    
 
	);

    
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
     clk  = 0;
     clk2 = 0;
   
     rst=1;
     rst2=1;
   
     #20 
     rst=0;
     rst2 =0;
   
  
     
  
  end

    
 
   always  #5  clk =  ! clk;
   always  #8  clk2 =  ! clk2;
endmodule
