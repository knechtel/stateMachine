# stateMachine

Maquina de estados para troca de mensagem entre CPU e periferico.

Temos a imagem a seguir uma imagem da CPU com clock mais lento que o periferico e em seguida o contrário CPU com clock mais rápido que o periferico.

As formas de ondas estão organizadas da seguinte forma:

Os campos marcados são send da CPU,  clock da CPU, ack do periferico e clock do periferico


<img src='https://3.bp.blogspot.com/-3w2sATdUdGg/W4wpioSTQuI/AAAAAAAAD0w/P32bGNBzSy0eE2CTVjxosAfC6cRk-e-YACLcBGAs/s1600/Screen%2BShot%2B2018-09-02%2Bat%2B15.02.37.jpg'/>





CPU clock mais rápido que o periférico:

<img src='https://4.bp.blogspot.com/-9YXyvzgo0m0/W4wrX4z2AcI/AAAAAAAAD08/mbTgJGDrceIuYFmRCwlRSrxkt4MGLEMBACLcBGAs/s1600/Screen%2BShot%2B2018-09-02%2Bat%2B15.22.55.jpg'/>



ferramentas utilizadas Icarus Verilog e GTKWave.



código da CPU:


```
	always @ (*)
		begin
		case ({S})
		3'b000:begin//estado 00
                   dados= 3'b111;
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
		3'b100:begin//estado 100
		   dados= dados+1;
		   send=1;
		   NS=3'b001;
                end 
			endcase
```



código do periferico

``` /***** NEXT STATE *****/
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
		   sendPeriferico = 1;
	           NS = 3'b00; 
                end   
		endcase
```

rodar o projeto: iverilog -o my_design  test.v module.v

  maiquelknechtel@MacBook-Pro-de-Maiquel:~/Desktop/verilog/stateMachine$./my_design 
