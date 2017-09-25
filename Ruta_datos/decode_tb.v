module decode_tb(

);



reg [4:0] DIR_A, DIR_B, DIR_WRA;
reg [31:0] DI;
reg REG_RD, REG_WR;
reg [15:0] IMD;

 wire [31:0] DOA,DOB;


decode ins_decode(

.DIR_A(DIR_A), 
.DIR_B(DIR_B), 
.DIR_WRA(DIR_WRA),
.DI(DI),
.REG_RD(REG_RD),
.REG_WR(REG_WR),
.IMD(IMD),
.DOA(DOA),
.DOB(DOB)


);


initial 

begin

DIR_A <=0;
DIR_B <=0;
DIR_WRA <=0;
DI <= 0;
REG_RD <= 1;
REG_WR <=1;
IMD <= 0;

#300  DI <= 36;
DIR_WRA <=12;
#100 REG_WR <=0;
#90 REG_WR <=1;

#30 DI <= 5;
DIR_WRA <=15;
#100 REG_WR <=0;
#90 REG_WR <=1;


#40 DIR_A <=12;
DIR_B <=15;
#30 REG_RD <= 0;
#30 REG_RD <= 1;







end








endmodule