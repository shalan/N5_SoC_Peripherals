#ifndef TYPES
#define TYPES
typedef uint32 uint32;
typedef vuint32vuint32;
typedef unsigned char uint8;
typedef int int32;
#endif

//change the following based on your SoC Configuration
#define UART0_BASE              0x40000000
#define UART1_BASE              0x40100000
#define I2C0_BASE               0x40200000
#define I2C1_BASE               0x40300000
#define SPI0_BASE               0x40400000
#define SPI1_BASE               0x40500000


// UART Macros
#define UART_DATA_OFF           0x00
#define UART_STATUS_OFF         0x04
#define UART_CTRL_OFF           0x04
#define UART_PRESCALER_OFF      0x08
#define UART_IM_OFF             0x0C
#define UART_TXFIFOTR_OFF       0x10
#define UART_RXFIFOTR_OFF       0x14

vuint32 *const UART0_DATA = (uint32 *)(UART0_BASE + UART_DATA_OFF);
vuint32 *const UART0_STATUS = (uint32 *)(UART0_BASE + UART_STATUS_OFF);
vuint32 *const UART0_CTRL = (uint32 *)(UART0_BASE + UART_CTRL_OFF);
vuint32 *const UART0_PRESCALER = (uint32 *)(UART0_BASE + UART_PRESCALER_OFF);
vuint32 *const UART0_IM = (uint32 *)(UART0_BASE + UART_IM_OFF);
vuint32 *const UART0_TXTH = (uint32 *)(UART0_BASE + UART_TXFIFOTR_OFF);
vuint32 *const UART0_RXTH = (uint32 *)(UART0_BASE + UART_RXFIFOTR_OFF);

vuint32 *const UART1_DATA = (uint32 *)(UART1_BASE + UART_DATA_OFF);
vuint32 *const UART1_STATUS = (uint32 *)(UART1_BASE + UART_STATUS_OFF);
vuint32 *const UART1_CTRL = (uint32 *)(UART1_BASE + UART_CTRL_OFF);
vuint32 *const UART1_PRESCALER = (uint32 *)(UART1_BASE + UART_PRESCALER_OFF);
vuint32 *const UART1_IM = (uint32 *)(UART1_BASE + UART_IM_OFF);
vuint32 *const UART1_TXTH = (uint32 *)(UART1_BASE + UART_TXFIFOTR_OFF);
vuint32 *const UART1_RXTH = (uint32 *)(UART1_BASE + UART_RXFIFOTR_OFF);

// I2C Registers Offsets
#define I2C_PRE_LO_OFF          0x0
#define I2C_PRE_HI_OFF          0x4
#define I2C_CTRL_OFF            0x8
#define I2C_TX_OFF              0xC
#define I2C_RX_OFF              0x10
#define I2C_CMD_OFF             0x14
#define I2C_STAT_OFF            0x18
#define I2C_IM_OFF              0x38

// CMD Register Field masks
#define I2C_CMD_STA             0x80
#define I2C_CMD_STO             0x40
#define I2C_CMD_RD              0x20
#define I2C_CMD_WR              0x10
#define I2C_CMD_ACK             0x08
#define I2C_CMD_IACK            0x01

// CTRL Register Field masks
#define I2C_CTRL_EN             0x80
#define I2C_CTRL_IEN            0x40

// STATUS Register Field masks
#define I2C_STAT_RXACK          0x80
#define I2C_STAT_BUSY           0x40
#define I2C_STAT_AL             0x20
#define I2C_STAT_TIP            0x02
#define I2C_STAT_IF             0x01

vuint32* const I2C0_PRE_LO = (uint32 *) (I2C0_BASE + I2C_PRE_LO_OFF);
vuint32* const I2C0_PRE_HI = (uint32 *) (I2C0_BASE + I2C_PRE_HI_OFF);
vuint32* const I2C0_CTRL = (uint32 *) (I2C0_BASE + I2C_CTRL_OFF);
vuint32* const I2C0_TX = (uint32 *) (I2C0_BASE + I2C_TX_OFF);
vuint32* const I2C0_RX = (uint32 *) (I2C0_BASE + I2C_RX_OFF);
vuint32* const I2C0_CMD = (uint32 *) (I2C0_BASE + I2C_CMD_OFF);
vuint32* const I2C0_STAT = (uint32 *) (I2C0_BASE + I2C_STAT_OFF);
vuint32* const I2C0_IM = (uint32 *) (I2C0_BASE + I2C_IM_OFF);


vuint32* const I2C1_PRE_LO = (uint32 *) (I2C1_BASE + I2C_PRE_LO_OFF);
vuint32* const I2C1_PRE_HI = (uint32 *) (I2C1_BASE + I2C_PRE_HI_OFF);
vuint32* const I2C1_CTRL = (uint32 *) (I2C1_BASE + I2C_CTRL_OFF);
vuint32* const I2C1_TX = (uint32 *) (I2C1_BASE + I2C_TX_OFF);
vuint32* const I2C1_RX = (uint32 *) (I2C1_BASE + I2C_RX_OFF);
vuint32* const I2C1_CMD = (uint32 *) (I2C1_BASE + I2C_CMD_OFF);
vuint32* const I2C1_STAT = (uint32 *) (I2C1_BASE + I2C_STAT_OFF);
vuint32* const I2C1_IM = (uint32 *) (I2C1_BASE + I2C_IM_OFF);

// SPI Macros
#define SPI_DATA_OFF            0x00
#define SPI_CFG_OFF             0x08
#define SPI_STATUS_OFF          0x10
#define SPI_CTRL_OFF            0x18
#define SPI_PRE_OFF             0x20
#define SPI_IM_OFF              0x30
#define SPI_IC_OFF              0x38

// CTRL register fields
#define     SPI_GO_BIT          0x0
#define     SPI_GO_SIZE         0x1
#define     SPI_SS_BIT          0x1
#define     SPI_SS_SIZE         0x1

// CFG register fields
#define     SPI_CPOL_BIT        0x0
#define     SPI_CPOL_SIZE       0x1
#define     SPI_CPHA_BIT        0x1
#define     SPI_CPHA_SIZE       0x1
#define     SPI_CLKDIV_BIT      0x2
#define     SPI_CLKDIV_SIZE     0x8

// status register fields
#define     SPI_DONE_BIT        0x0
#define     SPI_DONE_SIZE       0x1

vunit32 *const SPI0_DATA = (uint32 *)(SPI0_BASE + SPI_DATA_OFF);
vunit32 *const SPI0_CFG = (uint32 *)(SPI0_BASE + SPI_CFG_OFF);
vunit32 *const SPI0_STATUS = (uint32 *)(SPI0_BASE + SPI_STATUS_OFF);
vunit32 *const SPI0_CTRL = (uint32 *)(SPI0_BASE + SPI_CTRL_OFF);
vunit32 *const SPI0_PRE = (uint32 *)(SPI0_BASE + SPI_PRE_OFF);
vunit32 *const SPI0_IM = (uint32 *)(SPI0_BASE + SPI_IM_OFF);
vunit32 *const SPI0_IC = (uint32 *)(SPI0_BASE + SPI_IC_OFF);

vunit32 *const SPI1_DATA = (uint32 *)(SPI1_BASE + SPI_DATA_OFF);
vunit32 *const SPI1_CFG = (uint32 *)(SPI1_BASE + SPI_CFG_OFF);
vunit32 *const SPI1_STATUS = (uint32 *)(SPI1_BASE + SPI_STATUS_OFF);
vunit32 *const SPI1_CTRL = (uint32 *)(SPI1_BASE + SPI_CTRL_OFF);
vunit32 *const SPI1_PRE = (uint32 *)(SPI1_BASE + SPI_PRE_OFF);
vunit32 *const SPI1_IM = (uint32 *)(SPI1_BASE + SPI_IM_OFF);
vunit32 *const SPI1_IC = (uint32 *)(SPI1_BASE + SPI_IC_OFF);