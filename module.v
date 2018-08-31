`timescale 1ns / 1ps


module machineCPU(estadoA,estadoB,rst,clk,dados,ack,send);
  output reg [1:0] estadoA;//Luz rua A
  output reg [1:0] estadoB;
  
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
              
                   dados=3'b110;
             	   send=1; 
                   NS=3'b001;
		   $display("send d%",send);
                 end     
                3'b001:begin//estado 01
              	   if(ack==1)   
		     NS=3'b001;
                   else
		     NS=3'b010;
		   
                end   
                3'b010:begin//estado 01
		   send=0;
		   
              	   dados=dados+1;	
                   NS=3'b011;
                end 
                3'b011:begin//estado 01
              	   if(ack==0)
		      NS=3'b000;
		   else
		      NS=3'b011;
                end 
			endcase
		end
	/***** NEXT STATE *****/

   	always @ (*)
		begin
			case ({S})
				3'b000:begin
					estadoA = 3'b00;
				
				end
				3'b001:begin
					estadoA = 3'b001;
				
				end
				3'b010:begin
					estadoA = 3'b010;
					
				end
				3'b011:begin
					estadoA = 3'b011;
				       
				end
			        3'b100:begin
					estadoA = 3'b100;
				       
				end
			endcase
		end
	/***** OUTPUTS *****/
 
  
endmodule

module periferico(LA,rst2,clk2,dados2,ack2,send2,ack1,dadosPeriferico);

  output reg [1:0] LA;//ouput do estado
  input rst2;
  input clk2;
  input [3:0]dados2;
  output
  reg [3:0]dadosPeriferico;
  output ack2;
  reg ack2;
  output send2;
  
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
		   dadosPeriferico=dados2;
		   ack1=1;
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
		   dadosPeriferico= 3'b000;
                   NS = 3'b00; 
                end   
		endcase
	     end
	/***** NEXT STATE *****/

        	always @ (*)
		begin
			case ({S})
				3'b000:begin
					LA = 2'b00;
				       
				end
				3'b001:begin
					LA = 2'b01;
					
				end
				3'b010:begin
					LA = 2'b10;
				       
				end
				3'b011:begin
					LA = 2'b11;
					
				end
			endcase
		end
	/***** OUTPUTS *****/
 

endmodule
  
  
	

