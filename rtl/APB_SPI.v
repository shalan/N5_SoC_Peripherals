/*
     _  _ ___   ___ ___ ___ 
    | \| | __| / __| _ \_ _|
    | .` |__ \ \__ \  _/| | 
    |_|\_|___/ |___/_| |___|              
	Copyright 2020 Mohamed Shalan
	
	Licensed under the Apache License, Version 2.0 (the "License"); 
	you may not use this file except in compliance with the License. 
	You may obtain a copy of the License at:

	http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software 
	distributed under the License is distributed on an "AS IS" BASIS, 
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
	See the License for the specific language governing permissions and 
	limitations under the License.
*/
/*
    APB Interface for SPI Master Controller by Lane Brooks (Ubixum) 
    APB Registers:
        [0x00]  DATA (W): 0-7: data in  
        [0x00]  DATA (R): 0-7: data out  
        [0x08]  CFG (W): 0:cpol, 1:cpha  
        [0x10]  STATUS (R): 0: done       
        [0x18]  CTRL (RW): 0: Start, 1:S Sn    
        [0x20]  PRE (RW) 0-7: SCK PRESCALER 
        [0x30]  IM (RW): Interrups Mask regsiter  
        [0x38]  IC (RW): Interrups Clear regsiter  
*/

`timescale          1ns/1ps
`default_nettype    none

`include            "../rtl/apb_util.vh"

module APB_SPI(
    input wire          PCLK,
    input wire          PRESETn,

    `APB_SLAVE_IFC,

    input  wire         MSI,
    output wire         MSO,
    output wire         SSn,
    output wire         SCK
);

    parameter [4:0]     DATA_REG_OFF    = 5'h0,
                        CFG_REG_OFF     = 5'h1,
                        STATUS_REG_OFF  = 5'h2,
                        CTRL_REG_OFF    = 5'h3,
                        PRE_REG_OFF     = 5'h4,
                        IM_REG_OFF      = 5'h6,
                        IC_REG_OFF      = 5'h7;

    wire        go, 
                cpol, 
                cpha, 
                done, 
                busy, 
                csb;
    
    wire [7:0]  datai, 
                datao, 
                clkdiv;

    `APB_REG(DATA_REG,  8, 0, )
    `APB_REG(CFG_REG,   2, 0, )
    `APB_REG(CTRL_REG,  2, 0, )
    `APB_REG(PRE_REG,   8, 0, )
    `APB_REG(IM_REG,    1, 0, )
    
    reg IC_REG;
    wire IC_REG_sel = (PENABLE & PWRITE & PREADY & PSEL & (PADDR[7:3] == IC_REG_OFF));
    always @(posedge PCLK, negedge PRESETn)
        if(!PRESETn)
            IC_REG <= 1'b0;
        else if(IC_REG_sel)
            IC_REG <= PWDATA[0:0];
        else if(IC_REG)
            IC_REG <= 1'b0;
  
    assign datai          = DATA_REG[7:0];
    assign go             = CTRL_REG[0];
    assign SSn            = ~CTRL_REG[1];
    assign cpol           = CFG_REG[0];
    assign cpha           = CFG_REG[1];
    assign clkdiv         = PRE_REG[7:0];
  
    reg DONE;
    always @(posedge PCLK, negedge PRESETn)
        if(!PRESETn)
            DONE <= 1'b0;
        else if(done)
            DONE <= 1'b1;
        else if(go)
            DONE <= 1'b0;
        else if(IC_REG)
            DONE <= 1'b0;

  spi_master #( .DATA_WIDTH(8),
                .CLK_DIVIDER_WIDTH(8)
            ) 
        SPI_CTRL (
            .clk(PCLK),
            .resetb(PRESETn),
            .CPOL(cpol),
            .CPHA(cpha),
            .clk_divider(clkdiv),

            .go(go),
            .datai(datai),
            .datao(datao),
            //.busy(busy),
            .done(done),

            .dout(MSI),
            .din(MSO),
            //.csb(ss),
            .sclk(SCK)
  );

  assign PRDATA[31:0] = (PADDR[7:3] == IM_REG_OFF)      ? {31'd0, IM_REG}   :
                        (PADDR[7:3] == IC_REG_OFF)      ? {31'd0, IC_REG}   :
                        (PADDR[7:3] == CTRL_REG_OFF)    ? {30'd0, CTRL_REG} :
                        (PADDR[7:3] == CFG_REG_OFF)     ? {30'd0, CFG_REG}  :
                        (PADDR[7:3] == PRE_REG_OFF)     ? {24'd0, PRE_REG}  :
                        (PADDR[7:3] == STATUS_REG_OFF)  ? {31'd0, DONE}     :
                        (PADDR[7:3] == DATA_REG_OFF)    ? {24'd0, datao}    : 32'hDEAD_BEEF;

  assign PREADY = 1'b1;

  assign PIRQ = IM_REG[0] & DONE;

endmodule