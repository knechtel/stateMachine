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
          if(rst == 1)
	    S <= 3'b000;
          else
	    S <= NS;
        end
	/***** STATE *****/
  
  	/***** NEXT STATE *****/
	always @ (*)
		begin
		case ({S})
		3'b000:begin//estado 00
                  
		  dados=3'b001;  
		 
             	  NS=3'b001;
                 end     
                3'b001:begin//estado 01
		 
	
		   
              	   if(ack==0)   
		     NS=3'b001;
                   else
		     NS=3'b010;

		
		   
                end   
                3'b010:begin//estado 10
		   if(ack==1)
		     NS=3'b010;
		   else
		     NS=3'b011;
		   //NS=3'b011;
                end 
                3'b011:begin//estado 11
              	   NS=3'b001;
                end
		3'b100:begin//estado 01
	
		   NS=3'b001;
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


	always @ (*)
		begin
			case ({S})
				3'b000:begin
			          send=0;
		         
				
				end
				3'b001:begin
				   send=1;
				      dados=dados+1;
			        end
				3'b010:begin
				   send =0;
			        end
				3'b011:begin
				   send = 0;
				   
				       
				end
			        3'b100:begin
				   send =0;
				end
			endcase
		end

 
  
endmodule

module periferico(estadoPeriferico,rst2,clk2,dados2,send2,ack1,dadosPeriferico);

  output reg [3:0] estadoPeriferico;//ouput do estado
  input rst2;
  input clk2;
  input [3:0]dados2;
  output
  reg [3:0]dadosPeriferico;
 
  input send2;
   
  output ackPeriferico;
 
  output reg ack1;
   
  reg [3:0] S;//state
  reg [3:0] NS;//next state
  
  /***** STATE *****/
  always @ (posedge clk2)
		begin
		   if(rst2 ==1)
		     S <= 3'b000;
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
		  
		   
		  
		   if(send2==1)
		     NS = 3'b010;
		   else
		     NS = 3'b010;

		    dadosPeriferico=dados2;
                end
		        
                3'b010:begin//estado 10
		   $display("dados ok! ");
		  
		     NS = 3'b000;
                end   
-                3'b011:begin//estado 11
		   
		   NS = 3'b000; 
                end   
		endcase
	     end
	/***** NEXT STATE *****/

        	always @ (*)
		begin
			case ({S})
				3'b000:begin
					estadoPeriferico = 3'b00;
				       
				end
				3'b001:begin
					estadoPeriferico = 3'b01;
					
				end
				3'b010:begin
					estadoPeriferico = 3'b10;
				       
				end
				3'b011:begin
					estadoPeriferico = 3'b11;
					
				end
			endcase
		end
	/***** OUTPUTS *****/

        	always @ (*)
		begin
			case ({S})
				3'b000:begin
				   ack1=0;
				   
				       
				end
				3'b001:begin
				   ack1=1;
				end
				3'b010:begin
				   ack1=0;
				end
				3'b011:begin
				   ack1=0;
		                
	
				end
			endcase
		end
	/***** OUTPUTS *****/

 

endmodule
  
  
	

