/*
     _  _ ___   _____ __  __ ___ _______ 
    | \| | __| |_   _|  \/  | _ \__ /_  )
    | .` |__ \   | | | |\/| |   /|_ \/ / 
    |_|\_|___/   |_| |_|  |_|_|_\___/___|
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
TMR : 32-bit up counter
	CMP: Timer CMP register
	CAPTURE: Capture Register 
    PRE: 16-bit Clock prescalar (timer_clk = clk / (PRE+1))
    OVF: Timer overflow (TMR>=CMP)
	OVF_CLR: Control signal to clear the TMROV flag
    EN: ENable
    MODE: 1: Periodic, 0: One-shot
    UD: Up/Down
    TC: Timer/Counter
    CP: Enable Capture Mode
    PNE: Posedge or Negede - Counter/Capture
    BE: Both Edges - Counter/Capture
    PWMEN: PWM Enable

    APB Interface for N5 TIMER32 
    APB Registers:
        [0x00]  TMR (R): The Timer current value  
        [0x08]  CAPTURE (R): The Capture Value (CP mode only)
        [0x10]  CMP (RW): The Compare Register
        [0x18]  PRESCALE (RW): Clock Prescaler (16-bit)
        [0x20]  LOAD (RW): Load Register
        [0x28]  CONFIG (RW): 0: MODE, 1:U/D, 2:T/C, 3:CP, 4-5: Capture Event (1x: both, 00: Falling, 01: Rising)
        [0x30]  CNTRL (RW): 0:EN, 1: PWMEN
        [0x38]  STATUS (R): 0: OVF, 1: CMPF, 2: Ext Event        
        [0x40]  IM (RW): Interrups Mask regsiter  
        [0x48]  IC (RW): Interrups Clear regsiter  
*/

`timescale          1ns/1ps
`default_nettype    none

`include            "../rtl/apb_util.vh"

module APB_TMR32(
    input wire          PCLK,
    input wire          PRESETn,

    `APB_SLAVE_IFC,
    
    input   wire        CCP, 
    output  wire        PWM
);

    parameter [4:0]     TMR_REG_OFF     = 5'h0,
                        CAP_REG_OFF     = 5'h1,
                        CMP_REG_OFF     = 5'h2,
                        PRE_REG_OFF     = 5'h3,
                        LOAD_REG_OFF    = 5'h4,
                        CFG_REG_OFF     = 5'h5,
                        CTRL_REG_OFF    = 5'h6,
                        STATUS_REG_OFF  = 5'h7,
                        IM_REG_OFF      = 5'h8,
                        IC_REG_OFF      = 5'h9;

    `APB_REG(CMP_REG,  32, 0, )
    `APB_REG(PRE_REG,  16, 0, )
    `APB_REG(LOAD_REG, 32, 0, )
    `APB_REG(CFG_REG,   6, 0, )
    `APB_REG(CTRL_REG,  2, 0, )
    `APB_REG(IM_REG,    3, 0, )
    
    reg [2:0] IC_REG;
    wire IC_REG_sel = (PENABLE & PWRITE & PREADY & PSEL & (PADDR[4:2] == IC_REG_OFF));
    always @(posedge PCLK, negedge PRESETn)
        if(!PRESETn)
            IC_REG <= 'h0;
        else if(IC_REG_sel)
            IC_REG <= PWDATA[2:0];
        else if(IC_REG != 'h0)
            IC_REG <= 'h0;
  
    wire [31:0] TMR_REG,
                CAP_REG;
    wire [2:0]  STATUS_REG;

    wire ovf, cmpf, eevf;
    wire ovf_clr    = IC_REG[0];
    wire cmpf_clr   = IC_REG[1];
    wire eevf_clr   = IC_REG[2];
    wire en         = CTRL_REG[0];
    wire pwmen      = CTRL_REG[1];
    wire mode       = CFG_REG[0];
    wire ud         = CFG_REG[1];
    wire tc         = CFG_REG[2];
    wire cp         = CFG_REG[3];
    wire pne        = CFG_REG[4];
    wire be         = CFG_REG[5];

    TMR32 TMR(
		.clk(PCLK),
		.rst_n(PRESETn),
		.TMR(TMR_REG),
        .CAPTURE(CAP_REG),
		.PRE(PRE_REG),
		.CMP(CMP_REG),
        .LOAD(LOAD_REG),
		.OVF(ovf),
		.CMPF(cmpf),
        .EEVF(eevf),        
        .OVF_CLR(ovf_clr),
        .CMPF_CLR(cmpf_clr),
        .EEVF_CLR(eevf_clr),
		.EN(en),
        .MODE(mode),       
        .UD(ud),         
        .TC(tc),         
        .CP(cp),         
        .PNE(pne),       
        .BE(be),         
        .PWMEN(pwmen),   
        .EXTPIN(CCP), 
        .PWMPIN(PWM)
	);

    assign PRDATA[31:0] =   (PADDR[7:3] == TMR_REG_OFF)     ? {TMR_REG}             :
                            (PADDR[7:3] == CAP_REG_OFF)     ? {CAP_REG_OFF}         :
                            (PADDR[7:3] == CMP_REG_OFF)     ? {CMP_REG}             :
                            (PADDR[7:3] == PRE_REG_OFF)     ? {16'd0, PRE_REG_OFF}  :
                            (PADDR[7:3] == LOAD_REG_OFF)    ? {LOAD_REG}            :
                            (PADDR[7:3] == CFG_REG_OFF)     ? {26'd0, CFG_REG}      :
                            (PADDR[7:3] == CTRL_REG_OFF)    ? {30'd0, CTRL_REG}     : 
                            (PADDR[7:3] == STATUS_REG_OFF)  ? {29'd0, STATUS_REG}   : 
                            (PADDR[7:3] == IM_REG_OFF)      ? {29'd0, IM_REG}       : 
                            (PADDR[7:3] == IC_REG_OFF)      ? {29'd0, IC_REG}       : 
                            32'hDEAD_BEEF;

    assign PREADY = 1'b1;

    assign PIRQ = |(IM_REG & STATUS_REG);

    assign STATUS_REG = {eevf, cmpf, ovf};;

endmodule