`define TMR_PORT(num)\
    input   wire            TMR``num``_CCP, \
    output  wire            TMR``num``_PWM

`define TMR_PORT_PCONN(num)\
        .CCP(TMR``num``_CCP),\ 
        .PWM(TMR``num``_PWM)\


`define TMR_PORT_CONN(num)\
        .TMR``num``_CCP(TMR``num``_CCP),\ 
        .TMR``num``_PWM(TMR``num``_PWM)\


`define UART_PORT(num)\
    input wire              UART``num``_RX,\
    output wire             UART``num``_TX


`define UART_PORT_PCONN(num)\
            .Rx(UART``num``_RX),\   
            .Tx(UART``num``_TX)

`define UART_PORT_CONN(num)\
            .UART``num``_RX(UART``num``_RX),\   
            .UART``num``_TX(UART``num``_TX)

`define I2C_PORT(num)\
    input 	wire            I2C``num``_SCLI,\	    
	output 	wire            I2C``num``_SCLO,\	    
	output 	wire            I2C``num``_SCLOE,\  
	input	wire            I2C``num``_SDAI,\      
	output	wire            I2C``num``_SDAO,\	    
	output	wire            I2C``num``_SDAOE   

`define I2C_PORT_PCONN(num)\
            .scl_i(I2C``num``_SCLI),\
            .scl_o(I2C``num``_SCLO),\	    
            .scl_oen_o(I2C``num``_SCLOE),\  
            .sda_i(I2C``num``_SDAI),\      
            .sda_o(I2C``num``_SDAO),\	    
            .sda_oen_o(I2C``num``_SDAOE)  

`define I2C_PORT_CONN(num)\
            .I2C``num``_SCLI(I2C``num``_SCLI),\
            .I2C``num``_SCLO(I2C``num``_SCLO),\	    
            .I2C``num``_SCLOE(I2C``num``_SCLOE),\  
            .I2C``num``_SDAI(I2C``num``_SDAI),\      
            .I2C``num``_SDAO(I2C``num``_SDAO),\	    
            .I2C``num``_SDAOE(I2C``num``_SDAOE) 

`define SPI_PORT(num)\
    input  wire             SPI``num``_MSI,\
    output wire             SPI``num``_MSO,\
    output wire             SPI``num``_SSn,\
    output wire             SPI``num``_SCK   

`define SPI_PORT_PCONN(num)\
            .MSI(SPI``num``_MSI),\
            .MSO(SPI``num``_MSO),\
            .SSn(SPI``num``_SSn),\
            .SCK(SPI``num``_SCK)

`define SPI_PORT_CONN(num)\
            .SPI``num``_MSI(SPI``num``_MSI),\
            .SPI``num``_MSO(SPI``num``_MSO),\
            .SPI``num``_SSn(SPI``num``_SSn),\
            .SPI``num``_SCK(SPI``num``_SCK)

