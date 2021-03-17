# N5_SoC_Peripherals
This repo contains a set of digital peripherals that can be used to build System on a Chips (SoCs).
Currenly, it has:
- A 32-bit Timer/Counter with Input Capture support and PWM generation with the following features
  - 32-bit timer with 16-bit prescaler (periodic and one-shot)
  - 32-bit event counter (external pin)
  - 32-bit Input Capture with 16-bit prescaler (Edge: Positive, Negative or Both)
  - 32-bit PWM Generator
  - APB Interface
- APB UART that supports only 8N1 format with the following features:
  - 16-byte TX and RX FIFOs with programmable thresholds
  - 16-bit prescaler (PR) for programable baud rate generation
-  APB Interface for SPI Master Controller by Lane Brooks (Ubixum) 
-  APB Interface for I2C Master Controller by Open Cores
