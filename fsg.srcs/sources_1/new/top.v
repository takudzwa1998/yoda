`timescale 1ns / 1ps

module top(
input  CLK100MHZ,
input [15:0] SW,
output [7:0] SS_CAT,//SevenSegment
output [7:0] SS_AN, //Segment Drivers was [3:0}
output wire [1:0] LED
    );

//----------- BRAM ------------// 
 // Memory IO
reg ena = 1;
reg wea = 0;
reg [7:0] addra=0;
reg [10:0] dina=0; //Set dina to 1, because we are putting data in
wire [10:0] douta;
    
blk_mem_gen_0 your_instance_name (
  .clka(clka),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [8 : 0] addra
  .dina(dina),    // input wire [10 : 0] dina
  .douta(douta)  // output wire [10 : 0] douta
);
//----------- BRAM ------------// 

 reg [12:0] clkdiv = 0;
 reg [12:0] counter = 0;
 
 //-------------Initialise Seven Segment------------------//
reg[3:0] one=1;
reg[3:0] two=2;
reg[3:0] three=3;
reg[3:0] four=4;
reg[3:0] five=5;
reg[3:0] six=6;
reg[3:0] seven=7;
reg[3:0] eight=8;

SS_Driver SS_Driver1(CLK100MHZ, SW, one, two, three, four,
                    five, six, seven, eight,
                    SS_AN, SS_CAT
                    );
 
 //-------------Initialise Seven Segment------------------//	
 
always @(posedge CLK100MHZ)begin

one<=1;two<=2;three<=3;four<=4;
five<=5;six<=6;seven<=7;eight<=8;

clkdiv=clkdiv+1;

    if (clkdiv == 100000)begin
        dina<= counter+1;
        addra<=addra+1;
        two<= 5;
    end
end   

assign LED[1:0] = 1'b1; 

endmodule
