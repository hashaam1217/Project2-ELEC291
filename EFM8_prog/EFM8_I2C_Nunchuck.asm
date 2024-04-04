;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1170 (Feb 16 2022) (MSVC)
; This file was generated Tue Apr 02 15:27:27 2024
;--------------------------------------------------------
$name EFM8_I2C_Nunchuck
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _main
	public _nunchuck_getdata
	public _nunchuck_init
	public _I2C_stop
	public _I2C_start
	public _I2C_read
	public _I2C_write
	public _Timer4ms
	public __c51_external_startup
	public _nunchuck_init_PARM_1
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_nunchuck_init_buf_1_37:
	ds 6
_nunchuck_init_sloc0_1_0:
	ds 2
_nunchuck_init_sloc1_1_0:
	ds 2
_nunchuck_init_sloc2_1_0:
	ds 2
_main_buf_1_44:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
_nunchuck_init_PARM_1:
	DBIT	1
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:25: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	EFM8_I2C_Nunchuck.c:28: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	EFM8_I2C_Nunchuck.c:29: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	EFM8_I2C_Nunchuck.c:30: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	EFM8_I2C_Nunchuck.c:32: VDM0CN=0x80;       // enable VDD monitor
	mov	_VDM0CN,#0x80
;	EFM8_I2C_Nunchuck.c:33: RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	EFM8_I2C_Nunchuck.c:40: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	EFM8_I2C_Nunchuck.c:41: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	EFM8_I2C_Nunchuck.c:42: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	EFM8_I2C_Nunchuck.c:63: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	EFM8_I2C_Nunchuck.c:64: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	EFM8_I2C_Nunchuck.c:65: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	EFM8_I2C_Nunchuck.c:66: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	EFM8_I2C_Nunchuck.c:67: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	EFM8_I2C_Nunchuck.c:68: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	EFM8_I2C_Nunchuck.c:77: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	EFM8_I2C_Nunchuck.c:78: TH1 = 0x100-((SYSCLK/BAUDRATE)/(12L*2L));
	mov	_TH1,#0xE6
;	EFM8_I2C_Nunchuck.c:79: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	EFM8_I2C_Nunchuck.c:80: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	EFM8_I2C_Nunchuck.c:81: TMOD |=  0x20;
	orl	_TMOD,#0x20
;	EFM8_I2C_Nunchuck.c:82: TR1 = 1; // START Timer1
	setb	_TR1
;	EFM8_I2C_Nunchuck.c:83: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	EFM8_I2C_Nunchuck.c:86: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	EFM8_I2C_Nunchuck.c:87: XBR0 = 0b_0000_0101; // Enable SMBus pins and UART pins P0.4(TX) and P0.5(RX)
	mov	_XBR0,#0x05
;	EFM8_I2C_Nunchuck.c:88: XBR1 = 0X00;
	mov	_XBR1,#0x00
;	EFM8_I2C_Nunchuck.c:89: XBR2 = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	EFM8_I2C_Nunchuck.c:92: CKCON0 |= 0b_0000_0100; // Timer0 clock source = SYSCLK
	orl	_CKCON0,#0x04
;	EFM8_I2C_Nunchuck.c:93: TMOD &= 0xf0;  // Mask out timer 1 bits
	anl	_TMOD,#0xF0
;	EFM8_I2C_Nunchuck.c:94: TMOD |= 0x02;  // Timer0 in 8-bit auto-reload mode
	orl	_TMOD,#0x02
;	EFM8_I2C_Nunchuck.c:96: TL0 = TH0 = 256-(SYSCLK/SMB_FREQUENCY/3);
	mov	_TH0,#0x10
	mov	_TL0,#0x10
;	EFM8_I2C_Nunchuck.c:97: TR0 = 1; // Enable timer 0
	setb	_TR0
;	EFM8_I2C_Nunchuck.c:100: SMB0CF = 0b_0101_1100; //INH | EXTHOLD | SMBTOE | SMBFTE ;
	mov	_SMB0CF,#0x5C
;	EFM8_I2C_Nunchuck.c:101: SMB0CF |= 0b_1000_0000;  // Enable SMBus
	orl	_SMB0CF,#0x80
;	EFM8_I2C_Nunchuck.c:103: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer4ms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 
;i                         Allocated to registers r4 
;k                         Allocated to registers r3 
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:107: void Timer4ms(unsigned char ms)
;	-----------------------------------------
;	 function Timer4ms
;	-----------------------------------------
_Timer4ms:
	mov	r2,dpl
;	EFM8_I2C_Nunchuck.c:112: k=SFRPAGE;
	mov	r3,_SFRPAGE
;	EFM8_I2C_Nunchuck.c:113: SFRPAGE=0x10;
	mov	_SFRPAGE,#0x10
;	EFM8_I2C_Nunchuck.c:115: CKCON1|=0b_0000_0001;
	orl	_CKCON1,#0x01
;	EFM8_I2C_Nunchuck.c:117: TMR4RL = 65536-(SYSCLK/1000L); // Set Timer4 to overflow in 1 ms.
	mov	_TMR4RL,#0xC0
	mov	(_TMR4RL >> 8),#0xE6
;	EFM8_I2C_Nunchuck.c:118: TMR4 = TMR4RL;                 // Initialize Timer4 for first overflow
	mov	_TMR4,_TMR4RL
	mov	(_TMR4 >> 8),(_TMR4RL >> 8)
;	EFM8_I2C_Nunchuck.c:120: TF4H=0; // Clear overflow flag
	clr	_TF4H
;	EFM8_I2C_Nunchuck.c:121: TR4=1;  // Start Timer4
	setb	_TR4
;	EFM8_I2C_Nunchuck.c:122: for (i = 0; i < ms; i++)       // Count <ms> overflows
	mov	r4,#0x00
L003004?:
	clr	c
	mov	a,r4
	subb	a,r2
	jnc	L003007?
;	EFM8_I2C_Nunchuck.c:124: while (!TF4H);  // Wait for overflow
L003001?:
;	EFM8_I2C_Nunchuck.c:125: TF4H=0;         // Clear overflow indicator
	jbc	_TF4H,L003015?
	sjmp	L003001?
L003015?:
;	EFM8_I2C_Nunchuck.c:122: for (i = 0; i < ms; i++)       // Count <ms> overflows
	inc	r4
	sjmp	L003004?
L003007?:
;	EFM8_I2C_Nunchuck.c:127: TR4=0; // Stop Timer4
	clr	_TR4
;	EFM8_I2C_Nunchuck.c:128: SFRPAGE=k;	
	mov	_SFRPAGE,r3
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2C_write'
;------------------------------------------------------------
;output_data               Allocated to registers 
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:132: void I2C_write (unsigned char output_data)
;	-----------------------------------------
;	 function I2C_write
;	-----------------------------------------
_I2C_write:
	mov	_SMB0DAT,dpl
;	EFM8_I2C_Nunchuck.c:135: SI = 0;
	clr	_SI
;	EFM8_I2C_Nunchuck.c:136: while (!SI); // Wait until done with send
L004001?:
	jnb	_SI,L004001?
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2C_read'
;------------------------------------------------------------
;input_data                Allocated to registers 
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:139: unsigned char I2C_read (void)
;	-----------------------------------------
;	 function I2C_read
;	-----------------------------------------
_I2C_read:
;	EFM8_I2C_Nunchuck.c:143: SI = 0;
	clr	_SI
;	EFM8_I2C_Nunchuck.c:144: while (!SI); // Wait until we have data to read
L005001?:
	jnb	_SI,L005001?
;	EFM8_I2C_Nunchuck.c:145: input_data = SMB0DAT; // Read the data
	mov	dpl,_SMB0DAT
;	EFM8_I2C_Nunchuck.c:147: return input_data;
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2C_start'
;------------------------------------------------------------
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:150: void I2C_start (void)
;	-----------------------------------------
;	 function I2C_start
;	-----------------------------------------
_I2C_start:
;	EFM8_I2C_Nunchuck.c:152: ACK = 1;
	setb	_ACK
;	EFM8_I2C_Nunchuck.c:153: STA = 1;     // Send I2C start
	setb	_STA
;	EFM8_I2C_Nunchuck.c:154: STO = 0;
	clr	_STO
;	EFM8_I2C_Nunchuck.c:155: SI = 0;
	clr	_SI
;	EFM8_I2C_Nunchuck.c:156: while (!SI); // Wait until start sent
L006001?:
	jnb	_SI,L006001?
;	EFM8_I2C_Nunchuck.c:157: STA = 0;     // Reset I2C start
	clr	_STA
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'I2C_stop'
;------------------------------------------------------------
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:161: void I2C_stop(void)
;	-----------------------------------------
;	 function I2C_stop
;	-----------------------------------------
_I2C_stop:
;	EFM8_I2C_Nunchuck.c:163: STO = 1;  	// Perform I2C stop
	setb	_STO
;	EFM8_I2C_Nunchuck.c:164: SI = 0;	// Clear SI
	clr	_SI
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'nunchuck_init'
;------------------------------------------------------------
;i                         Allocated to registers r2 
;buf                       Allocated with name '_nunchuck_init_buf_1_37'
;sloc0                     Allocated with name '_nunchuck_init_sloc0_1_0'
;sloc1                     Allocated with name '_nunchuck_init_sloc1_1_0'
;sloc2                     Allocated with name '_nunchuck_init_sloc2_1_0'
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:168: void nunchuck_init(bit print_extension_type)
;	-----------------------------------------
;	 function nunchuck_init
;	-----------------------------------------
_nunchuck_init:
;	EFM8_I2C_Nunchuck.c:173: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:174: I2C_write(0xA4);
	mov	dpl,#0xA4
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:175: I2C_write(0xF0);
	mov	dpl,#0xF0
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:176: I2C_write(0x55);
	mov	dpl,#0x55
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:177: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:178: Timer4ms(1);
	mov	dpl,#0x01
	lcall	_Timer4ms
;	EFM8_I2C_Nunchuck.c:180: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:181: I2C_write(0xA4);
	mov	dpl,#0xA4
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:182: I2C_write(0xFB);
	mov	dpl,#0xFB
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:183: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:184: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:185: Timer4ms(1);
	mov	dpl,#0x01
	lcall	_Timer4ms
;	EFM8_I2C_Nunchuck.c:189: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:190: I2C_write(0xA4);
	mov	dpl,#0xA4
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:191: I2C_write(0xFA); // extension type register
	mov	dpl,#0xFA
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:192: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:193: Timer4ms(3); // 3 ms required to complete acquisition
	mov	dpl,#0x03
	lcall	_Timer4ms
;	EFM8_I2C_Nunchuck.c:195: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:196: I2C_write(0xA5);
	mov	dpl,#0xA5
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:199: for(i=0; i<6; i++)
	mov	r2,#0x00
L008003?:
	cjne	r2,#0x06,L008013?
L008013?:
	jnc	L008006?
;	EFM8_I2C_Nunchuck.c:201: buf[i]=I2C_read();
	mov	a,r2
	add	a,#_nunchuck_init_buf_1_37
	mov	r0,a
	push	ar2
	push	ar0
	lcall	_I2C_read
	mov	a,dpl
	pop	ar0
	pop	ar2
	mov	@r0,a
;	EFM8_I2C_Nunchuck.c:199: for(i=0; i<6; i++)
	inc	r2
	sjmp	L008003?
L008006?:
;	EFM8_I2C_Nunchuck.c:203: ACK=0;
	clr	_ACK
;	EFM8_I2C_Nunchuck.c:204: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:205: Timer4ms(3);
	mov	dpl,#0x03
	lcall	_Timer4ms
;	EFM8_I2C_Nunchuck.c:207: if(print_extension_type)
	jnb	_nunchuck_init_PARM_1,L008002?
;	EFM8_I2C_Nunchuck.c:210: buf[0],  buf[1], buf[2], buf[3], buf[4], buf[5]);
	mov	r2,(_nunchuck_init_buf_1_37 + 0x0005)
	mov	r3,#0x00
	mov	r4,(_nunchuck_init_buf_1_37 + 0x0004)
	mov	r5,#0x00
	mov	_nunchuck_init_sloc0_1_0,(_nunchuck_init_buf_1_37 + 0x0003)
	mov	(_nunchuck_init_sloc0_1_0 + 1),#0x00
	mov	_nunchuck_init_sloc1_1_0,(_nunchuck_init_buf_1_37 + 0x0002)
	mov	(_nunchuck_init_sloc1_1_0 + 1),#0x00
	mov	_nunchuck_init_sloc2_1_0,(_nunchuck_init_buf_1_37 + 0x0001)
	mov	(_nunchuck_init_sloc2_1_0 + 1),#0x00
	mov	r6,_nunchuck_init_buf_1_37
	mov	r7,#0x00
;	EFM8_I2C_Nunchuck.c:209: printf("Extension type: %02x  %02x  %02x  %02x  %02x  %02x\n", 
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	_nunchuck_init_sloc0_1_0
	push	(_nunchuck_init_sloc0_1_0 + 1)
	push	_nunchuck_init_sloc1_1_0
	push	(_nunchuck_init_sloc1_1_0 + 1)
	push	_nunchuck_init_sloc2_1_0
	push	(_nunchuck_init_sloc2_1_0 + 1)
	push	ar6
	push	ar7
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf1
	mov	sp,a
L008002?:
;	EFM8_I2C_Nunchuck.c:215: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:216: I2C_write(0xA4);
	mov	dpl,#0xA4
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:217: I2C_write(0xF0);
	mov	dpl,#0xF0
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:218: I2C_write(0xAA);
	mov	dpl,#0xAA
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:219: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:220: Timer4ms(1);
	mov	dpl,#0x01
	lcall	_Timer4ms
;	EFM8_I2C_Nunchuck.c:222: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:223: I2C_write(0xA4);
	mov	dpl,#0xA4
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:224: I2C_write(0x40);
	mov	dpl,#0x40
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:225: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:226: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:227: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:228: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:229: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:230: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:231: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:232: Timer4ms(1);
	mov	dpl,#0x01
	lcall	_Timer4ms
;	EFM8_I2C_Nunchuck.c:234: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:235: I2C_write(0xA4);
	mov	dpl,#0xA4
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:236: I2C_write(0x40);
	mov	dpl,#0x40
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:237: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:238: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:239: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:240: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:241: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:242: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:243: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:244: Timer4ms(1);
	mov	dpl,#0x01
	lcall	_Timer4ms
;	EFM8_I2C_Nunchuck.c:246: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:247: I2C_write(0xA4);
	mov	dpl,#0xA4
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:248: I2C_write(0x40);
	mov	dpl,#0x40
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:249: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:250: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:251: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:252: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:253: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:254: Timer4ms(1);
	mov	dpl,#0x01
	ljmp	_Timer4ms
;------------------------------------------------------------
;Allocation info for local variables in function 'nunchuck_getdata'
;------------------------------------------------------------
;s                         Allocated to registers r2 r3 r4 
;i                         Allocated to registers r5 
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:257: void nunchuck_getdata(unsigned char * s)
;	-----------------------------------------
;	 function nunchuck_getdata
;	-----------------------------------------
_nunchuck_getdata:
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
;	EFM8_I2C_Nunchuck.c:262: I2C_start();
	push	ar2
	push	ar3
	push	ar4
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:263: I2C_write(0xA4);
	mov	dpl,#0xA4
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:264: I2C_write(0x00);
	mov	dpl,#0x00
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:265: I2C_stop();
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:266: Timer4ms(3); 	// 3 ms required to complete acquisition
	mov	dpl,#0x03
	lcall	_Timer4ms
;	EFM8_I2C_Nunchuck.c:269: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:270: I2C_write(0xA5);
	mov	dpl,#0xA5
	lcall	_I2C_write
	pop	ar4
	pop	ar3
	pop	ar2
;	EFM8_I2C_Nunchuck.c:273: for(i=0; i<6; i++)
	mov	r5,#0x00
L009001?:
	cjne	r5,#0x06,L009010?
L009010?:
	jnc	L009004?
;	EFM8_I2C_Nunchuck.c:275: s[i]=(I2C_read()^0x17)+0x17; // Read and decrypt
	mov	a,r5
	add	a,r2
	mov	r6,a
	clr	a
	addc	a,r3
	mov	r7,a
	mov	ar0,r4
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	push	ar7
	push	ar0
	lcall	_I2C_read
	mov	a,dpl
	pop	ar0
	pop	ar7
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	xrl	a,#0x17
	add	a,#0x17
	mov	r1,a
	mov	dpl,r6
	mov	dph,r7
	mov	b,r0
	lcall	__gptrput
;	EFM8_I2C_Nunchuck.c:273: for(i=0; i<6; i++)
	inc	r5
	sjmp	L009001?
L009004?:
;	EFM8_I2C_Nunchuck.c:277: ACK=0;
	clr	_ACK
;	EFM8_I2C_Nunchuck.c:278: I2C_stop();
	ljmp	_I2C_stop
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;i                         Allocated with name '_main_i_1_44'
;buf                       Allocated with name '_main_buf_1_44'
;read_value                Allocated to registers r2 
;addr                      Allocated to registers 
;------------------------------------------------------------
;	EFM8_I2C_Nunchuck.c:281: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	EFM8_I2C_Nunchuck.c:291: printf("Hello\n");
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	EFM8_I2C_Nunchuck.c:292: printf("addr: %x\n", addr);
	mov	a,#0xEB
	push	acc
	clr	a
	push	acc
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfb
	mov	sp,a
;	EFM8_I2C_Nunchuck.c:293: printf("Hello World\n");
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	EFM8_I2C_Nunchuck.c:295: while (1)
L010002?:
;	EFM8_I2C_Nunchuck.c:298: I2C_start();
	lcall	_I2C_start
;	EFM8_I2C_Nunchuck.c:299: I2C_write(0x75);
	mov	dpl,#0x75
	lcall	_I2C_write
;	EFM8_I2C_Nunchuck.c:300: read_value = I2C_read();
	lcall	_I2C_read
	mov	r2,dpl
;	EFM8_I2C_Nunchuck.c:308: I2C_stop();
	push	ar2
	lcall	_I2C_stop
;	EFM8_I2C_Nunchuck.c:310: printf("WHOAMI: %x\n", read_value);
	mov	r3,#0x00
	push	ar3
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xfb
	mov	sp,a
	sjmp	L010002?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 'Extension type: %02x  %02x  %02x  %02x  %02x  %02x'
	db 0x0A
	db 0x00
__str_1:
	db 'Hello'
	db 0x0A
	db 0x00
__str_2:
	db 'addr: %x'
	db 0x0A
	db 0x00
__str_3:
	db 'Hello World'
	db 0x0A
	db 0x00
__str_4:
	db 'WHOAMI: %x'
	db 0x0A
	db 0x00

	CSEG

end
