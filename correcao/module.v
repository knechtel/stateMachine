`timescale 1ns / 1ps


module machineCPU(estadoCPU,rst,clk,dados,ack,send);
   output reg [3:0] estadoCPU;
  
  
  input rst;
  input clk;
  output
  reg [3:0]dados;
  input ack;
  output reg send;

   

  reg [3:0] S;//state
  reg [3:0] NS;//next state
  
	/***** STATE *****/
	always @ (posedge clk)
	begin
          if(rst == 0)
	    S <= 2'b00;
          else
	    S <= NS;
        end
	/***** STATE *****/
  
  	/***** NEXT STATE *****/
	always @ (*)
		begin
		case ({S})
		3'b000:begin//estado 00
                   dados= 3'b111;
		   send=1;
		   NS=3'b001;
             	  
                 end     
                3'b001:begin//estado 01
              	   if(ack==1)   
		     NS=3'b001;
                   else
		     NS=3'b010;
		   
                end   
                3'b010:begin//estado 10
		   send=0;
		   NS=3'b011;
                end 
                3'b011:begin//estado 11
              	   if(ack==0)
		      NS=3'b100;
		   else
		      NS=3'b011;
                end
		3'b100:begin//estado 01
		   dados= dados+1;
		   send=1;
		   NS=3'b001;
		    $display("aquiii d%",send);
                end 
			endcase
		end
	/***** NEXT STATE *****/

   	always @ (*)
		begin
			case ({S})
				3'b000:begin
					estadoCPU = 3'b00;
				
				end
				3'b001:begin
					estadoCPU = 3'b001;
				
				end
				3'b010:begin
					estadoCPU = 3'b010;
					
				end
				3'b011:begin
					estadoCPU = 3'b011;
				       
				end
			        3'b100:begin
					estadoCPU = 3'b100;
				       
				end
			endcase
		end
	/***** OUTPUTS *****/
 
  
endmodule

module periferico(estadoPeriferico,rst2,clk2,dados2,send2,ack1,dadosPeriferico,sendPeriferico,ackPeriferico);

  output reg [1:0] estadoPeriferico;
  input rst2;
  input clk2;
  input [3:0]dados2;
  output
  reg [3:0]dadosPeriferico;
 
  input send2;
   
  output reg ackPeriferico;
  output reg  sendPeriferico;
 
  output reg ack1;
   
  reg [3:0] S;//state
  reg [3:0] NS;//next state
  
  /***** STATE *****/
  always @ (posedge clk2)
		begin
		   if(rst2 ==0)
		      S <= 2'b00;
          	   else
		      S <= NS;
		    
		end
  /***** STATE *****/
  
  /***** NEXT STATE *****/
	always @ (*)
	    begin
		case ({S})
		3'b000:begin//estado 00	
		 
 	   
		   if(send2==1)
		     NS = 3'b001;
		   else
		     NS = 3'b000;

		 
                end     
                3'b001:begin//estado 01
		   $display("dados ok! ");
		   dadosPeriferico=dados2+1;
		   ack1=1;
		   sendPeriferico=1;
		   
		   NS = 3'b010;
                end
		        
                3'b010:begin//estado 10
		   $display("dados ok! ");
		   if(send2==1)
		     NS = 3'b011;
		   else
		     NS = 3'b010;
                end   
                3'b011:begin//estado 11
		   ack1=0;
		   NS = 3'b00; 
                end   
		endcase
	     end
	/***** NEXT STATE *****/

        	always @ (*)
		begin
			case ({S})
				3'b000:begin
					estadoPeriferico = 2'b00;
				       
				end
				3'b001:begin
					estadoPeriferico = 2'b01;
					
				end
				3'b010:begin
					estadoPeriferico = 2'b10;
				       
				end
				3'b011:begin
					estadoPeriferico = 2'b11;
					
				end
			endcase
		end
	/***** OUTPUTS *****/
 

endmodule
  
  
	

