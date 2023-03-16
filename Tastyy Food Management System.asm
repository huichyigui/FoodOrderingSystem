.386		
.model flat, stdcall	
.stack 4096		

INCLUDE Irvine32.inc   ; initialize the use of library
BUFFER_SIZE	= 6000
ExitProcess PROTO, dwExitCode: DWORD	

;---------------------------- Data Segment ----------------------------------;
.data		;define variables here
sysTime SYSTEMTIME <>

; LOGIN MODULE
LoginLogo1	BYTE		 "     _____            _ ", 0
LoginLogo2	BYTE 13, 10, "    (_   _)          ( )_ ", 0
LoginLogo3	BYTE 13, 10, "      | |    _ _  ___|  _)_   _ _   _", 0
LoginLogo4	BYTE 13, 10, "      | |  / _  )  __) | ( ) ( ) ) ( )", 0
LoginLogo5	BYTE 13, 10, "      | | ( (_| |__  \ |_| (_) | (_) |", 0
LoginLogo6	BYTE 13, 10, "      (_)  \__ _)____/\__)\__  |\__  |", 0
LoginLogo7	BYTE 13, 10, "                         ( )_| | )_| |", 0
LoginLogo8	BYTE 13, 10, "                          \___/ \___/", 0
LoginLogo9	BYTE 13, 10, "           Food Management System ", 0
LoginLogo10 BYTE 13, 10, "----------------------------------------------", 0
LoginLogo11 BYTE 13, 10, "             1. Login as Admin ", 0
LoginLogo12 BYTE 13, 10, "             2. Login as Staff ", 0
LoginLogo13 BYTE 13, 10, "             3. Exit ", 0
LoginLogo14 BYTE 13, 10, "           Enter your choice: ", 0

ErrMsg		BYTE 13, 10, " You have entered an INVALID choice... Please enter again", 0
StfLogHead	BYTE 13, 10, "               Staff Login ", 0	
AdmLogHead	BYTE 13, 10, "               Admin Login ", 0	
LogUsrName	BYTE 13, 10, "             ENTER USERNAME: ", 0
LogUsrPassw BYTE		 "             ENTER PASSWORD: ", 0
AdmPassword	BYTE		 'admin',0
StfPassword	BYTE		 'staff',0
LogInMsg	BYTE 13, 10, "            Log In Successfully!", 0
LogInMsg1	BYTE 13, 10, "            Menu page loading......", 0
LogQuitMsg	BYTE 13, 10, "Fill in the blanks or enter: 1 to return to Login Menu. ", 0
LogEM		BYTE 13, 10, " Invalid user name or password. Please try again. ", 0

; Main Menu
OPTION1		BYTE 13, 10, "           1. View Menu", 0
OPTION2		BYTE 13, 10, "           2. Order Food", 0
OPTION3		BYTE 13, 10, "           3. Logout", 0
menuOption	BYTE 13, 10, "      Enter Option: ", 0
qtyMsg		BYTE 13, 10, "      Enter Quantity: ", 0
intQTY		DWORD ?
strCont     BYTE 13, 10, "Do you wish to continue order? (y = continue, other keys = skip) : ", 0
optionInput	BYTE "*"
ErrMsg0		BYTE 13, 10, " Please only enter 1, 2, or 3 ! Please re-enter your option: ", 0
ErrMsg1		BYTE 13, 10, " Please only enter 1, 2, 3 or 4 ! Please re-enter your option: ", 0
ErrMsg2		BYTE 13, 10, " Please only enter valid positive integer! Please re-enter your quantity: ", 0
ErrMsg3		BYTE 10, 13, " This voucher does not exist. Please try again.", 0

MN1			BYTE 10, 13,"  ___  ___               ___  ___", 0
MN2			BYTE 10, 13,"  |  \/  |      _        |  \/  |", 0
MN3			BYTE 10, 13,"  | .  . |:__ _(_)_,__   | .  . |  ___ _,__   _   _", 0  
MN4			BYTE 10, 13,"  | |\/| |/ _` | |  _ \  | |\/| | / _ \  _ \ | | | |", 0
MN5			BYTE 10, 13,"  | |  | | (_| | | | | | | |  | ||  __/ | | || |_| |", 0
MN6			BYTE 10, 13,"  \_|  |_/\__,_|_|_| |_| \_|  |_/ \___|_| |_| \__,_|", 0
MN7			BYTE 10, 13," ----------------------------------------------------", 0  
MN8			BYTE 10, 13,"  -------------------------------------------------.", 0
MN9			BYTE 10, 13," |                                                  |", 0
MN10		BYTE 10, 13," |  1. Burgers                      Price           |", 0
MN11		BYTE 10, 13," |   * Chicken Burger               RM 10.00        |", 0
MN12		BYTE 10, 13," |   * Deep Sea Fish Burger         RM 20.00        |", 0
MN13		BYTE 10, 13," |   * 10 Tower Burger              RM 30.00        |", 0
MN15		BYTE 10, 13," |                                                  |", 0
MN16		BYTE 10, 13," |  2. Drinks                                       |", 0
MN17		BYTE 10, 13," |   * Coca-Cola Zero Plus          RM 10.00        |", 0
MN18		BYTE 10, 13," |   * Sprite Zero Max              RM 10.00        |", 0
MN19		BYTE 10, 13," |   * Secret Iced Lemon Tea        RM 20.00        |", 0
MN21		BYTE 10, 13," |                                                  |", 0  
MN22		BYTE 10, 13," |  3. Fries                                        |", 0
MN23		BYTE 10, 13," |   * Classic Fries                RM 10.00        |", 0
MN24		BYTE 10, 13," |   * Special Nacho Cheese Fries   RM 20.00        |", 0
MN25		BYTE 10, 13," |   * Premium Import Masala Fries  RM 30.00        |", 0
MN27		BYTE 10, 13," |                                                  |", 0
MN28		BYTE 10, 13,"  -------------------------------------------------.", 0

OR1			BYTE 10, 13,"           _____            ____", 0
OR2			BYTE 10, 13,"          /  _  \ ______    |  |  ___ ______", 0
OR3			BYTE 10, 13,"         /  / \  \|   __|___|  | / _ \|   __|", 0
OR4			BYTE 10, 13,"         \  \_/  /|  |  / ___  ||  __/|  |", 0
OR5			BYTE 10, 13,"          \_____/ |__|  \______| \___||__|", 0
OR6			BYTE 10, 13," |   1. Order Burgers                               |", 0
OR7			BYTE 10, 13," |   2. Order Drinks                                |", 0
OR8			BYTE 10, 13," |   3. Order Fries                                 |", 0
OR9			BYTE 10, 13," |   4. Return To Main Page                         |", 0

BG1			BYTE 10,13,"        ______       ", 0
BG2			BYTE 10,13,"        | ___ \", 0
BG3			BYTE 10,13,"        | |_/ / _   _  _,__  __,_   ___  _,__", 0
BG4			BYTE 10,13,"        | ___ \| | | ||  __|/ _  | / _ \|  __|", 0
BG5			BYTE 10,13,"        | |_/ /| |_| || |  | (_| ||  __/| |", 0
BG6			BYTE 10,13,"        \____/  \__,_||_|   \__, | \___||_|", 0
BG7			BYTE 10,13,"                             __/ |", 0
BG8			BYTE 10,13,"                            |___/", 0  
BG9			BYTE 10,13," ------------------------------------------------------------------", 0
BG10		BYTE 10,13," ----------------------------------------------------------------.", 0
BG11		BYTE 10,13," |                                          _..----._             |", 0 
BG12		BYTE 10,13," | 1. Chicken Burger                      .'   o     '.           |", 0 
BG13		BYTE 10,13," | 2. Deep Sea Fish Burger               /  o          \          |", 0
BG14		BYTE 10,13," | 3. 10 Tower Burger                   |o       o     o|         |", 0
BG15		BYTE 10,13," | 4. Return To Previous Page          /'-.._o,,,,,__.-'\         |", 0
BG16		BYTE 10,13," |                                     \                /         |", 0
BG17		BYTE 10,13," |                                      |``--.......--`'|         |", 0
BG18		BYTE 10,13," |                                       \             /          |", 0
BG19		BYTE 10,13," |                                        ``---------``           |", 0
BG20		BYTE 10,13," |                                                                |", 0
BG21		BYTE 10,13," -----------------------------------------------------------------.", 0

DK1			BYTE 10,13,"            ____                                                 ", 0
DK2			BYTE 10,13,"            |   \         _         _ ", 0
DK3			BYTE 10,13,"            | |\ \  _,__ (_) _,__  | | _", 0  
DK4			BYTE 10,13,"            | | ) )|  __|| ||  _ \ | |/ /", 0
DK5			BYTE 10,13,"            | |/ / | |   | || | | ||   /", 0
DK6			BYTE 10,13,"            |___/  |_|   |_||_| |_||_|\_\", 0
DK7			BYTE 10,13,"------------------------------------------------------------------", 0
DK8			BYTE 10,13," ----------------------------------------------------------------.", 0
DK9			BYTE 10,13," |                                                   __          |", 0
DK10		BYTE 10,13," | 1. Coca-Cola Zero Plus                            /           |", 0
DK11		BYTE 10,13," | 2. Sprite Zero Max                             .-/-.          |", 0
DK12		BYTE 10,13," | 3. Secret Iced Lemon Tea                       |,-,|          |", 0
DK13		BYTE 10,13," | 4. Return To Previous Page                     |   |          |", 0
DK14		BYTE 10,13," |                                                |   |          |", 0
DK15		BYTE 10,13," |                                                \___/          |", 0
DK16		BYTE 10,13," ----------------------------------------------------------------.", 0

FR1			BYTE 10,13,"			______      _", 0 
FR2			BYTE 10,13,"			|  ___|    (_)", 0 
FR3			BYTE 10,13,"			| |_  _,__  _   ___  ___", 0 
FR4			BYTE 10,13,"			|  _||  __|| | / _ \/ __|", 0 
FR5			BYTE 10,13,"			| |  | |   | ||  __/\__ \", 0 
FR6			BYTE 10,13,"			\_|  |_|   |_| \___||___/", 0 
FR7			BYTE 10,13,"------------------------------------------------------------------", 0 
FR8			BYTE 10,13," ----------------------------------------------------------------.", 0 
FR9			BYTE 10,13," |                                           \|\ /| /|_/|//      |", 0 
FR10		BYTE 10,13," | 1. Classic Fries                          |\||-|\||-/|/|      |", 0
FR11		BYTE 10,13," | 2. Special Nacho Cheese Fries             |\||-|\||-/|/|      |", 0
FR12		BYTE 10,13," | 3. Premium Masala Fries                    | './\_/.' |       |", 0
FR13		BYTE 10,13," | 4. Return To Previous Page                 |          |       |", 0
FR14		BYTE 10,13," |                                            |          |       |", 0
FR15		BYTE 10,13," |                                             '.______.'        |", 0
FR16		BYTE 10,13," |                                                               |", 0
FR17		BYTE 10,13," ----------------------------------------------------------------.", 0 

STR1		BYTE 10, 13," You have selected Chicken Burger", 0
STR2		BYTE 10, 13," You have selected Deep Sea Fish Burger ", 0
STR3		BYTE 10, 13," You have selected 10 Tower Burger", 0
STR4		BYTE 10, 13," You have selected Coca-Cola Zero Plus", 0
STR5		BYTE 10, 13," You have selected Sprite Zero Max ", 0
STR6		BYTE 10, 13," You have selected Secret Iced Lemon Tea", 0
STR7		BYTE 10, 13," You have selected Classic Fries", 0
STR8		BYTE 10, 13," You have selected Special Nacho Cheese Fries", 0
STR9		BYTE 10, 13," You have selected Premium Masala Fries", 0

CC1			BYTE 10, 13, " Does customer have voucher code? ", 0
CC2			BYTE 10, 13, " 1. YES     2. NO     ANS: ", 0
CC3			BYTE 10, 13, " Enter Voucher Code (Enter 1 to return) : ", 0
errCC		BYTE 10, 13, " This voucher does not exist. Please try again.", 0
voucherCode	BYTE 'TASTYY', 0
VCAPPLIED	BYTE 10, 13, " Voucher applied successfully! ", 0
MAXINPUT	EQU 10
strTotal	BYTE " The Grand Total Price is RM ", 0
PayTypeTitl	BYTE 10, 13, " Please select your payment type.", 0
PayTypeIpt	BYTE 10, 13, " 1. Cash 2. Credit Card 3. E-Wallet   :", 0

codeIN		BYTE MAXINPUT DUP('*')
InputIn		BYTE '*'
InputSize	DWORD 0
MaxInput	EQU 10
PasMaxInput EQU 5
Asterisk	BYTE '*',0
NameInput	BYTE MaxInput DUP('*')			; input string for change
PassInput	BYTE PasMaxInput DUP('*')		; input string for change

FNAME		BYTE 'OPT', 0
HANDLE1		HANDLE ?
BUFFER1		BYTE BUFFER_SIZE DUP(0)

cashMsg		BYTE 10, 13, " Enter the payment amount: RM ", 0
strCardNum	BYTE 10, 13, " Enter your 4-digit card number (Enter Q to return): ", 0
strCardPin  BYTE 10, 13, " Enter your 4-digit card pin: ", 0
cardPin		BYTE '1234', 0
CCAPPLIED	BYTE 10, 13, " Credit Card applied successfully! ", 0
ErrMsg4		BYTE 10, 13, " WRONG CREDIT CARD INFO!", 0
ErrMsg5		BYTE 10, 13, " Please enter valid amount: RM ", 0
ErrMsg6		BYTE 10, 13, " WRONG E-WALLET PIN!", 0
ErrMsg8 	BYTE 10, 13, " Insufficient amount received. ", 0
strEW		BYTE 10, 13, " Enter your 6-digit E-Wallet pin: ", 0
EEAPPLIED	BYTE 10, 13, " E-Wallet applied successfully! ", 0
ewPIN		BYTE '777777', 0

CrdMaxInput	EQU 4
CrdNoInput	BYTE MaxInput DUP('*')
CrdPinInput BYTE CrdMaxInput DUP('*')

ewMaxInput EQU 6
ewInput	   BYTE ewMaxInput DUP('*')

CK1			BYTE 10, 13, "    ______  __                   __                          __", 0
CK2			BYTE 10, 13, "   /  ____||  |                 |  | __                     |  |", 0
CK3			BYTE 10, 13, "  /  /     |  |____   ___  ____ |  |/  /  _____   __    __ _|  |_", 0
CK4			BYTE 10, 13, " (  (      |   __  \ / _ \/  __||     /  /  _  \ |  |  |  |_    _|", 0
CK5			BYTE 10, 13, "  \  \____ |  |  |  |  __/  (__ |  |\ \ (  (_)  )|  \__|  | |  |", 0
CK6			BYTE 10, 13, "   \ _____||__|  |__|\___|\____||__| \_\ \_____/  \____,__| |__|", 0
CK7			BYTE 10, 13, "----------------------------------------------------------------", 0

IV1			BYTE 10,13,"          _____                 _          ", 0
IV2			BYTE 10,13,"         |_   _|               (_)         ", 0
IV3			BYTE 10,13,"           | |  _ ____   _____  _  ___ ___ ", 0
IV4			BYTE 10,13,"           | | | '_ \ \ / / _ \| |/ __/ _ \", 0
IV5			BYTE 10,13,"          _| |_| | | \ V / (_) | | (_|  __/", 0
IV6			BYTE 10,13,"         |_____|_| |_|\_/ \___/|_|\___\___|", 0
IV7			BYTE 10,13,"-------------------------------------------------", 0
IV8			BYTE 10,13," Total Items Ordered:    ", 0
IV9			BYTE 10,13," Subtotals	    : RM ", 0
IV10		BYTE 10,13," + Service Tax(10%) : RM ", 0
IV11		BYTE 10,13," - Voucher          : RM ", 0
IV12		BYTE 10,13," Grand Total Price  : RM ", 0
IV13		BYTE 10,13,"----------------------PAYMENT-------------------", 0
IV14		BYTE 10,13," Payment Received   : RM ", 0
IV15		BYTE 10,13," Changes            : RM ", 0
IV16		BYTE 10,13,"-------------------------------------------------", 0
IV17		BYTE 10,13," Date               : ", 0
IV18		BYTE 10,13," Time               : ",0
IV19		BYTE 10,13,"-------------------------------------------------", 0

strCont2	BYTE 10,13," Do you want to continue with your next order? (y/n): ", 0
ErrMsg7		BYTE 10,13," Please enter only 'y' or 'n'! Ans: ", 0
colon		BYTE ':', 0
slash		BYTE '/', 0

RP1			BYTE 10, 13, "       ______", 0
RP2			BYTE 10, 13, "       |     \", 0
RP3			BYTE 10, 13, "       |  |\  \                                __", 0
RP4			BYTE 10, 13, "       |  |_\  |  ___  _____   _____  ______ _|  |_", 0
RP5			BYTE 10, 13, "       |      /  / _ \|     \ /  _  \|   ___|_    _|", 0
RP6			BYTE 10, 13, "       |  |\  \ |  __/|  ()  )  (_)  |  |     |  |", 0
RP7			BYTE 10, 13, "       |__| \__\ \___||  ___/ \_____/|__|     |__|", 0
RP8			BYTE 10, 13, "                      |  |", 0
RP9			BYTE 10, 13, "                      |__|", 0
RP10		BYTE 10, 13, "-------------------------------------------------------------", 0
RP11		BYTE 10, 13, "             1. Daily Sales Report", 0
RP12		BYTE 10, 13, "             2. Food Sold Statistic Report", 0
RP13		BYTE 10, 13, "             3. Reset Reports", 0
RP14		BYTE 10, 13, "             4. Logout", 0
RP15		BYTE 10, 13, "-------------------------------------------------------------", 0

TQTY		DWORD 0		; Temporary holds quantity amount
TTQTY		DWORD 0		; Total Quantity to display in checkout
SUBTT		DWORD 0		; Subtotal Amount
PRICE		DWORD 0		; Price of current item
FNVOUCHER	DWORD 0		; Final Voucher Value
ServiceTax	EQU 10		; 10% Service Tax Amount
VoucherDis	EQU 10		; Voucher Discount minus RM10 if applicable
GRDTT		DWORD 0		; Total Payable Amount
CASHRCD		DWORD 0		; Cash Received
CSHBAL		DWORD 0		; Cash Balance Amount

SRFILE		BYTE "Sales Report.txt",0
FRFILE		BYTE "Food Report.txt",0
FILEERR		BYTE "File Creation Failure",0
SRERROR	BYTE "No Report, No sales Has been made. Press anything to return."
intBuffer	DWORD ?

;count the number of time an item has been ordered
F1_COUNT	DWORD 0
F2_COUNT	DWORD 0
F3_COUNT	DWORD 0
B1_COUNT	DWORD 0
B2_COUNT	DWORD 0
B3_COUNT	DWORD 0
D1_COUNT	DWORD 0
D2_COUNT	DWORD 0
D3_COUNT	DWORD 0
TT_COUNT	DWORD 0

FREP1		BYTE 13, "      ______                __   ____                        __   ",0
FREP2		BYTE 13, "     / ____/___  ____  ____/ /  / __ \___  ____  ____  _____/ /_  ",0
FREP3		BYTE 13, "    / /_  / __ \/ __ \/ __  /  / /_/ / _ \/ __ \/ __ \/ ___/ __/  ",0
FREP4		BYTE 13, "   / __/ / /_/ / /_/ / /_/ /  / _, _/  __/ /_/ / /_/ / /  / /_    ",0
FREP5		BYTE 13, "  /_/    \____/\____/\__,_/  /_/ |_|\___/ .___/\____/_/   \__/    ",0
FREP6		BYTE 13, "                                       /_/                        ",0
FREP7		BYTE 13, "+----------------------------------------------------------------+",0
FREP8		BYTE 13, "  BURGERS                                             	        ",0
FREP9		BYTE 13, "    1) Chicken Burgers                               : ",0
FREP10		BYTE 13, "    2) Deep Sea Fish Burger                          : ",0
FREP11		BYTE 13, "    3) 10 Tower Burger                               : ",0
FREP12		BYTE 13, "  DRINKS                                                          ",0
FREP13		BYTE 13, "    4) Coca-Cola Zero Plus                           : ",0
FREP14		BYTE 13, "    5) Sprite Zero Max                               : ",0
FREP15		BYTE 13, "    6) Secret Iced Lemon Tea                         : ",0
FREP16		BYTE 13, "  FRIES                                                           ",0
FREP17		BYTE 13, "    7) Classic Fries                                 : ",0
FREP18		BYTE 13, "    8) Special Nacho Cheese Fries                    : ",0
FREP19		BYTE 13, "    9) Premium Import Masala Fries                   : ",0
FREP20		BYTE 13, "+----------------------------------------------------------------+",0
FREP21		BYTE 13, "  TOTAL                                              : ",0
FREP22		BYTE 13, "+----------------------------------------------------------------+",0

OrderQtyArr	DWORD 0,20 DUP(0) 	;array to store all the order quantity 
GrandTtlArr DWORD 0,20 DUP(0)	;array to store all the order grandtotal
PaymentsArr	DWORD 0,20 DUP(0)	;array to store all the payments method
orderCount	DWORD 0				;keeep count of number of order
DAY_SALES	DWORD 0

SREP1		BYTE 13, "   _____         _      ______  _____     ",0
SREP2		BYTE 13, "  / ____|  /\   | |    |  ____|/ ____|    ",0
SREP3		BYTE 13, " | (___   /  \  | |    | |__  | (___      ",0
SREP4		BYTE 13, "  \___ \ / /\ \ | |    |  __|  \___ \     ",0
SREP5		BYTE 13, "  ____) / ____ \| |____| |____ ____) |  _ ",0
SREP6		BYTE 13, " |_____/_/    \_\______|______|_____/  (_)",0
SREP_LINE	BYTE 13, "===========================================",0
SREP_HEAD	BYTE 13, "   NO.       ITEM       PAY          TOT(RM)",0
SREP_TAIL	BYTE 13, " Total Sales                        :",0
SREP_TAIL2	BYTE 13, " Total Order                        :",0
SREP_BLANK1	BYTE 2 DUP(32),0
SREP_BLANK2	BYTE 9 DUP(32),0
SREP_CASH 	BYTE "CASH",0
SREP_CARD	BYTE "CARD",0
SREP_EWAL	BYTE "EWAL",0


SAVEMSG		BYTE 10,13, "Do you want to save the report?(y = continue, other keys = Return to main) :",0
SAVE_DONE	BYTE 10,13, "REPORT SAVED TO FILE. PRESS ANY KEY TO RETURN...",0
CONF_RESET 	BYTE 10,13, "Are you sure you want to reset? Press 'y' to confirm.",0
RESET_DONE	BYTE 10,13, "The report has been reset", 0

CDEC		BYTE 3 DUP(?)
convertErr	BYTE "Error: number is too large, unable to convert to string",0



;---------------------------- Code Segment -----------------------------------;
.code		
main PROC
	JMP STARTOVER
STARTOVER_1:
	MOV EAX, 4
	SUB orderCount, EAX
STARTOVER:
	; --------Display Logo and Menu--------
	CALL Clrscr						; Reset the variables to 0
	MOV	EAX, 0
	MOV TQTY, EAX
	MOV TTQTY, EAX
	MOV SUBTT, EAX
	MOV FNVOUCHER, EAX
	MOV GRDTT, EAX
	MOV CASHRCD, EAX
	MOV CSHBAL, EAX

	MOV EDX, OFFSET LoginLogo1
	CALL WriteString
	MOV EDX, OFFSET LoginLogo2
	CALL WriteString
	MOV EDX, OFFSET LoginLogo3
	CALL WriteString
	MOV EDX, OFFSET LoginLogo4
	CALL WriteString
	MOV EDX, OFFSET LoginLogo5
	CALL WriteString
	MOV EDX, OFFSET LoginLogo6
	CALL WriteString
	MOV EDX, OFFSET LoginLogo7
	CALL WriteString
	MOV EDX, OFFSET LoginLogo8
	CALL WriteString
	MOV EDX, OFFSET LoginLogo9
	CALL WriteString
	MOV EDX, OFFSET LoginLogo10
	CALL WriteString
	MOV EDX, OFFSET LoginLogo11
	CALL WriteString
	MOV EDX, OFFSET LoginLogo12
	CALL WriteString
	MOV EDX, OFFSET LoginLogo13
	CALL WriteString
	CALL CRLF
LOGININPUT:
	MOV EDX, OFFSET LoginLogo14
	CALL WriteString

	; --------Obtain and display user input, error message--------
	CALL readChar					; Obtain user input
	MOV InputIn, AL	
	CALL writeChar
	CMP InputIn, '1'				; Go to Admin Login if user press 1
	JE ADMINLOGIN
	CMP InputIn, '2'				; Go to Staff Login if user press 2
	JE STAFFLOGIN
	CMP InputIn, '3'				; Quit if user press 3
	JE TERMINATE
	MOV EDX, OFFSET ErrMsg			; If not 1 / 2 / 3, print error message and ask for input again
	CALL writeString
	JMP LOGININPUT

ADMINLOGIN:							; Display Admin Login Header
	MOV EDX, OFFSET LoginLogo10
	CALL WriteString			
	MOV EDX, OFFSET AdmLogHead
	CALL WriteString
	MOV EDX, OFFSET LoginLogo10
	CALL WriteString
	MOV EDX, OFFSET LogQuitMsg
	CALL WriteString
ADMRETRY:
	CALL CRLF						
	MOV EDX, OFFSET LogUsrName		; Display enter username: string
	CALL WriteString
	MOV EDX, OFFSET NameInput			
	MOV ECX, MaxInput
	CALL readString
	CMP NameInput, '1'
	JE STARTOVER

	MOV EDX, OFFSET LogUsrPassw		; Display enter password: string
	CALL WriteString

	MOV ECX, PasMaxInput			; Initiate values for swaping char with *
	MOV ESI, OFFSET PassInput
	MOV EDX, OFFSET Asterisk	

SCANPW:
	CALL readChar
	MOV BYTE PTR [ESI], AL			
	MOV AL, Asterisk
	CALL Writechar
	ADD ESI, 1
	LOOP SCANPW

	MOV ECX, PasMaxInput
	MOV ESI, OFFSET PassInput
PRINTAST:							; Convert typed password and store it inside 
	MOV AL, BYTE PTR [ESI]			; the string for comparison 	
	ADD ESI, 1
	LOOP PRINTAST

	MOV BYTE PTR [ESI], 0			; Terminate admin password string

INVOKE Str_compare,					; Compare and validate both user name and password
	ADDR NameInput,
    ADDR PassInput
	JNE ADMLOGINFAIL
INVOKE Str_compare,					
	ADDR PassInput,
    ADDR AdmPassword
	JNE ADMLOGINFAIL
	JMP ADMINPASS					; Display login successfully message if pass the validation

STAFFLOGIN:							; Display Staff Login Header
	MOV EDX, OFFSET LoginLogo10
	CALL WriteString
	MOV EDX, OFFSET StfLogHead
	CALL WriteString
	MOV EDX, OFFSET LoginLogo10
	CALL WriteString
	MOV EDX, OFFSET LogQuitMsg
	CALL WriteString
STFRETRY:
	CALL CRLF						; Display enter username: string
	MOV EDX, OFFSET LogUsrName			
	CALL WriteString
	MOV EDX, OFFSET NameInput			
	MOV ECX, MaxInput
	CALL readString
	CMP NameInput, '1'
	JE STARTOVER

	MOV EDX, OFFSET LogUsrPassw		; Obtain password input
	CALL WriteString
	MOV ECX, PasMaxInput			; Initiate values for swaping char with *
	MOV ESI, OFFSET PassInput
	MOV EDX, OFFSET Asterisk	

SCANSPW:
	CALL readChar
	MOV BYTE PTR [ESI], AL			
	MOV AL, Asterisk
	CALL Writechar
	ADD ESI, 1
	LOOP SCANSPW

	MOV ECX, PasMaxInput
	MOV ESI, OFFSET PassInput
PRINTSAST:							; Convert typed password and store it inside 
	MOV AL, BYTE PTR [ESI]			; the string for comparison 	
	ADD ESI, 1
	LOOP PRINTSAST

	MOV BYTE PTR [ESI], 0			; Terminate admin password string

INVOKE Str_compare,					; Compare and validate both user name and password
	ADDR NameInput,
    ADDR PassInput
	JNE STFLOGINFAIL
INVOKE Str_compare,					
	ADDR PassInput,
    ADDR StfPassword
	JNE STFLOGINFAIL
	JMP STAFFPASS					; Display login successfully message if pass the validation

ADMLOGINFAIL:
	MOV EDX, OFFSET LogEM
	CALL WriteString
	JMP ADMRETRY

STFLOGINFAIL:
	MOV EDX, OFFSET LogEM
	CALL WriteString
	JMP STFRETRY

ADMINPASS:	
	CALL CRLF
	MOV EDX, OFFSET LogInMsg
	CALL WriteString
	JMP ADMIN

STAFFPASS:	
	CALL CRLF
	MOV EDX, OFFSET LogInMsg
	CALL WriteString
	CALL CRLF
	MOV EDX, OFFSET LogInMsg1
	CALL WriteString	
	MOV  EAX, 1500						; Delay 1.5 sec
    CALL Delay
	JMP MENU

MENU:
		; --------Display Logo and Menu--------
		MOV EAX, 4
		ADD orderCount, EAX	; Increase the order no by 4 because of the size of array is dword; for sales report reasons.
		CALL Clrscr						; Reset the variables to 0
		MOV	EAX, 0
		MOV TQTY, EAX
		MOV TTQTY, EAX
		MOV SUBTT, EAX
		MOV FNVOUCHER, EAX
		MOV GRDTT, EAX
		MOV CASHRCD, EAX
		MOV CSHBAL, EAX

		MOV EDX, OFFSET LoginLogo1
		CALL WriteString
		MOV EDX, OFFSET LoginLogo2
		CALL WriteString
		MOV EDX, OFFSET LoginLogo3
		CALL WriteString
		MOV EDX, OFFSET LoginLogo4
		CALL WriteString
		MOV EDX, OFFSET LoginLogo5
		CALL WriteString
		MOV EDX, OFFSET LoginLogo6
		CALL WriteString
		MOV EDX, OFFSET LoginLogo7
		CALL WriteString
		MOV EDX, OFFSET LoginLogo8
		CALL WriteString
		MOV EDX, OFFSET LoginLogo9
		CALL WriteString
		MOV EDX, OFFSET LoginLogo10
		CALL WriteString

		MOV EDX, OFFSET OPTION1
		CALL WriteString
		MOV EDX, OFFSET OPTION2
		CALL WriteString
		MOV EDX, OFFSET OPTION3
		CALL WriteString
		CALL CRLF
		MOV EDX, OFFSET menuOption
		CALL WriteString
		CALL READCHAR
OPTION_COMPARE:
		MOV optionInput, AL
		CALL WRITECHAR
		CMP optionInput, "1"
		JE FOODMENU
		CMP optionInput, "2"
		JE ORDER
		CMP optionInput, "3"
		JE STARTOVER_1
		MOV EDX, OFFSET errMsg0
		CALL WRITESTRING
		CALL READCHAR
		JMP OPTION_COMPARE
FOODMENU:
		MOV EAX, 4
		SUB orderCount, EAX
		CALL Clrscr
		MOV EDX, OFFSET MN1
		CALL WriteString
		MOV EDX, OFFSET MN2
		CALL WriteString
		MOV EDX, OFFSET MN3
		CALL WriteString
		MOV EDX, OFFSET MN4
		CALL WriteString
		MOV EDX, OFFSET MN5
		CALL WriteString
		MOV EDX, OFFSET MN6
		CALL WriteString
		MOV EDX, OFFSET MN7
		CALL WriteString
		MOV EDX, OFFSET MN8
		CALL WriteString
		MOV EDX, OFFSET MN9
		CALL WriteString
		MOV EDX, OFFSET MN10
		CALL WriteString
		MOV EDX, OFFSET MN11
		CALL WriteString
		MOV EDX, OFFSET MN12
		CALL WriteString
		MOV EDX, OFFSET MN13
		CALL WriteString
		MOV EDX, OFFSET MN15
		CALL WriteString
		MOV EDX, OFFSET MN16
		CALL WriteString
		MOV EDX, OFFSET MN17
		CALL WriteString
		MOV EDX, OFFSET MN18
		CALL WriteString
		MOV EDX, OFFSET MN19
		CALL WriteString
		MOV EDX, OFFSET MN21
		CALL WriteString
		MOV EDX, OFFSET MN22
		CALL WriteString
		MOV EDX, OFFSET MN23
		CALL WriteString
		MOV EDX, OFFSET MN24
		CALL WriteString
		MOV EDX, OFFSET MN25
		CALL WriteString
		MOV EDX, OFFSET MN27
		CALL WriteString
		MOV EDX, OFFSET MN28
		CALL WriteString
		CALL CRLF
		CALL WaitMsg
		JMP MENU
ORDER:
		CALL Clrscr
		MOV EDX, OFFSET OR1
		CALL WriteString
		MOV EDX, OFFSET OR2
		CALL WriteString
		MOV EDX, OFFSET OR3
		CALL WriteString
		MOV EDX, OFFSET OR4
		CALL WriteString
		MOV EDX, OFFSET OR5
		CALL WriteString
		MOV EDX, OFFSET MN7
		CALL WriteString
		MOV EDX, OFFSET MN8
		CALL WriteString
		MOV EDX, OFFSET MN9
		CALL WriteString
		MOV EDX, OFFSET OR6
		CALL WriteString
		MOV EDX, OFFSET OR7
		CALL WriteString
		MOV EDX, OFFSET OR8
		CALL WriteString
		MOV EDX, OFFSET OR9
		CALL WriteString
		MOV EDX, OFFSET MN27
		CALL WriteString
		MOV EDX, OFFSET MN28
		CALL WriteString
		CALL CRLF
		MOV EDX, OFFSET menuOption
		CALL WriteString
		CALL READCHAR
MENU_COMPARE:
		MOV optionInput, AL
		CALL WRITECHAR
		CMP optionInput, "1"
		JE BURGER
		CMP optionInput, "2"
		JE DRINK
		CMP optionInput, "3"
		JE FRIES
		CMP optionInput, "4"
		JE MENU
		MOV EDX, OFFSET ErrMsg1
		CALL WRITESTRING
		CALL READCHAR
		JMP MENU_COMPARE
BURGER:
		CALL Clrscr
		MOV EDX, OFFSET BG1
		CALL WriteString
		MOV EDX, OFFSET BG2
		CALL WriteString
		MOV EDX, OFFSET BG3
		CALL WriteString
		MOV EDX, OFFSET BG4
		CALL WriteString
		MOV EDX, OFFSET BG5
		CALL WriteString
		MOV EDX, OFFSET BG6
		CALL WriteString
		MOV EDX, OFFSET BG7
		CALL WriteString
		MOV EDX, OFFSET BG8
		CALL WriteString
		MOV EDX, OFFSET BG9
		CALL WriteString
		MOV EDX, OFFSET BG10
		CALL WriteString
		MOV EDX, OFFSET BG11
		CALL WriteString
		MOV EDX, OFFSET BG12
		CALL WriteString
		MOV EDX, OFFSET BG13
		CALL WriteString
		MOV EDX, OFFSET BG14
		CALL WriteString
		MOV EDX, OFFSET BG15
		CALL WriteString
		MOV EDX, OFFSET BG16
		CALL WriteString
		MOV EDX, OFFSET BG17
		CALL WriteString
		MOV EDX, OFFSET BG18
		CALL WriteString
		MOV EDX, OFFSET BG19
		CALL WriteString
		MOV EDX, OFFSET BG20
		CALL WriteString
		MOV EDX, OFFSET BG21
		CALL WriteString
		MOV EDX, OFFSET menuOption
		CALL WriteString
		CALL READCHAR
BURGER_COMPARE:
		MOV optionInput, AL
		CALL WRITECHAR
		CMP optionInput, '1'
		JE BURGER1
		CMP optionInput, '2'
		JE BURGER2
		CMP optionInput, '3'
		JE BURGER3
		CMP optionInput, '4'
		JE ORDER
		MOV EDX, OFFSET ErrMsg1
		CALL WRITESTRING
		CALL READCHAR
		JMP BURGER_COMPARE
BURGER1:
		MOV EDX, OFFSET STR1
		CALL WRITESTRING
		MOV EAX, 10
		MOV PRICE, EAX
		XOR EAX, EAX	
		CALL CRLF
		CALL QTY
		MOV EAX, B1_COUNT
		ADD EAX, TQTY
		MOV B1_COUNT,EAX
		JMP CONTINUE
BURGER2:
		MOV EDX, OFFSET STR2
		CALL WRITESTRING
		MOV EAX, 20
		MOV PRICE, EAX
		XOR EAX, EAX
		CALL CRLF
		CALL QTY
		MOV EAX, B2_COUNT
		ADD EAX, TQTY
		MOV B2_COUNT,EAX
		JMP CONTINUE
BURGER3:
		MOV EDX, OFFSET STR3
		CALL WRITESTRING
		MOV EAX, 30
		MOV PRICE, EAX
		XOR EAX, EAX
		CALL CRLF
		CALL QTY
		MOV EAX, B3_COUNT
		ADD EAX, TQTY
		MOV B3_COUNT,EAX
		JMP CONTINUE
DRINK:
		CALL Clrscr
		MOV EDX, OFFSET DK1
		CALL WriteString
		MOV EDX, OFFSET DK2
		CALL WriteString
		MOV EDX, OFFSET DK3
		CALL WriteString
		MOV EDX, OFFSET DK4
		CALL WriteString
		MOV EDX, OFFSET DK5
		CALL WriteString
		MOV EDX, OFFSET DK6
		CALL WriteString
		MOV EDX, OFFSET DK7
		CALL WriteString
		MOV EDX, OFFSET DK8
		CALL WriteString
		MOV EDX, OFFSET DK9
		CALL WriteString
		MOV EDX, OFFSET DK10
		CALL WriteString
		MOV EDX, OFFSET DK11
		CALL WriteString
		MOV EDX, OFFSET DK12
		CALL WriteString
		MOV EDX, OFFSET DK13
		CALL WriteString
		MOV EDX, OFFSET DK14
		CALL WriteString
		MOV EDX, OFFSET DK15
		CALL WriteString
		MOV EDX, OFFSET DK16
		CALL WriteString
		MOV EDX, OFFSET menuOption
		CALL WriteString
		CALL READCHAR
DRINK_COMPARE:
		MOV optionInput, AL
		CALL WRITECHAR
		CMP optionInput, '1'
		JE DRINK1
		CMP optionInput, '2'
		JE DRINK2
		CMP optionInput, '3'
		JE DRINK3
		CMP optionInput, '4'
		JE ORDER
		MOV EDX, OFFSET ErrMsg1
		CALL WRITESTRING
		CALL READCHAR
		JMP DRINK_COMPARE
DRINK1:
		MOV EDX, OFFSET STR4
		CALL WRITESTRING
		MOV EAX, 10
		MOV PRICE, EAX
		XOR EAX, EAX
		CALL CRLF
		CALL QTY
		MOV EAX, D1_COUNT
		ADD EAX, TQTY
		MOV D1_COUNT,EAX
		JMP CONTINUE
DRINK2:
		MOV EDX, OFFSET STR5
		CALL WRITESTRING
		MOV EAX, 10
		MOV PRICE, EAX
		XOR EAX, EAX
		CALL CRLF
		CALL QTY
		MOV EAX, D2_COUNT
		ADD EAX, TQTY
		MOV D2_COUNT,EAX
		JMP CONTINUE
DRINK3:
		MOV EDX, OFFSET STR6
		CALL WRITESTRING
		MOV EAX, 20
		MOV PRICE, EAX
		XOR EAX, EAX
		CALL CRLF
		CALL QTY
		MOV EAX, D3_COUNT
		ADD EAX, TQTY
		MOV D3_COUNT,EAX
		JMP CONTINUE
FRIES:
		CALL Clrscr
		MOV EDX, OFFSET FR1
		CALL WriteString
		MOV EDX, OFFSET FR2
		CALL WriteString
		MOV EDX, OFFSET FR3
		CALL WriteString
		MOV EDX, OFFSET FR4
		CALL WriteString
		MOV EDX, OFFSET FR5
		CALL WriteString
		MOV EDX, OFFSET FR6
		CALL WriteString
		MOV EDX, OFFSET FR7
		CALL WriteString
		MOV EDX, OFFSET FR8
		CALL WriteString
		MOV EDX, OFFSET FR9
		CALL WriteString
		MOV EDX, OFFSET FR10
		CALL WriteString
		MOV EDX, OFFSET FR11
		CALL WriteString
		MOV EDX, OFFSET FR12
		CALL WriteString
		MOV EDX, OFFSET FR13
		CALL WriteString
		MOV EDX, OFFSET FR14
		CALL WriteString
		MOV EDX, OFFSET FR15
		CALL WriteString
		MOV EDX, OFFSET FR16
		CALL WriteString
		MOV EDX, OFFSET FR17
		CALL WriteString
		MOV EDX, OFFSET menuOption
		CALL WriteString
		CALL READCHAR
FRIES_COMPARE:
		MOV optionInput, AL
		CALL WRITECHAR
		CMP optionInput, '1'
		JE FRIES1
		CMP optionInput, '2'
		JE FRIES2
		CMP optionInput, '3'
		JE FRIES3
		CMP optionInput, '4'
		JE ORDER
		MOV EDX, OFFSET ErrMsg1
		CALL WRITESTRING
		CALL READCHAR
		JMP FRIES_COMPARE
FRIES1:
		MOV EDX, OFFSET STR7
		CALL WRITESTRING
		MOV EAX, 10
		MOV PRICE, EAX
		XOR EAX, EAX
		CALL CRLF
		CALL QTY
		MOV EAX, F1_COUNT
		ADD EAX, TQTY
		MOV F1_COUNT,EAX
		JMP CONTINUE
FRIES2:
		MOV EDX, OFFSET STR8
		CALL WRITESTRING
		MOV EAX, 20
		MOV PRICE, EAX
		XOR EAX, EAX
		CALL CRLF
		CALL QTY
		MOV EAX, F2_COUNT
		ADD EAX, TQTY
		MOV F2_COUNT,EAX
		JMP CONTINUE
FRIES3:
		MOV EDX, OFFSET STR9
		CALL WRITESTRING
		MOV EAX, 30
		MOV PRICE, EAX
		XOR EAX, EAX
		CALL CRLF
		CALL QTY
		MOV EAX, F3_COUNT
		ADD EAX, TQTY
		MOV F3_COUNT,EAX
		JMP CONTINUE
QTY:
		MOV EDX, OFFSET qtyMsg
		CALL WRITESTRING
		CALL READINT
QTY_COMPARE:
		CMP AL, 0
		JLE isNegative
		MOV TQTY, EAX
		ADD TTQTY, EAX
		MOV EBX, PRICE
		MUL EBX
		ADD EAX, SUBTT
		MOV SUBTT, EAX
		RET
isNegative:
		MOV EDX, OFFSET errMsg2
		CALL WRITESTRING
		CALL READINT
		JMP QTY_COMPARE
		JNS CONTINUE
		MOV EDX, OFFSET ErrMsg1
		CALL WRITESTRING
		JMP QTY
CONTINUE:
		MOV EDX, OFFSET strCont
		CALL WRITESTRING
		CALL READCHAR
		CALL WRITECHAR
		CMP AL, 'y'
		JE ORDER
		JNE CALCULATE
CALCULATE:
		CALL CRLF
		MOV EDX, OFFSET CC1
		CALL WRITESTRING
		MOV EDX, OFFSET CC2
		CALL WRITESTRING
		CALL READCHAR
		CALL WRITECHAR
		CMP AL, '1'
		JE VOUCHER_COMPARE
		CMP AL, '2'
		JE CHECKOUT
		MOV EDX, OFFSET errMsg
		CALL WRITESTRING
		JMP CALCULATE
VOUCHER_COMPARE:
		MOV EDX, OFFSET CC3
		CALL WRITESTRING
		MOV EDX, OFFSET codeIn
		MOV ECX, MAXINPUT
		CALL READSTRING
		CMP codeIn, '1'
		JE CALCULATE
INVOKE str_compare,
		ADDR codeIn, 
		ADDR voucherCode
		JNE VOUCHERFAIL

		MOV EDX,OFFSET VCAPPLIED
		CALL WRITESTRING
		MOV EAX, FNVOUCHER	
		MOV EBX, VoucherDis	
		ADD EAX, EBX
		MOV FNVOUCHER, EAX 
		MOV EAX, 500					; Delay 0.5 sec
		CALL Delay
		JMP CHECKOUT
VOUCHERFAIL:
		MOV EDX, OFFSET errMsg3
		CALL WRITESTRING
		JMP VOUCHER_COMPARE

CHECKOUT:
		CALL CRLF						; Display Checkout Title
		CALL CRLF
		MOV EAX, 500					; Delay 0.5 sec
		CALL Delay
		MOV EDX, OFFSET CK1
		CALL WRITESTRING
		MOV EDX, OFFSET CK2
		CALL WRITESTRING
		MOV EDX, OFFSET CK3
		CALL WRITESTRING
		MOV EDX, OFFSET CK4
		CALL WRITESTRING
		MOV EDX, OFFSET CK5
		CALL WRITESTRING
		MOV EDX, OFFSET CK6
		CALL WRITESTRING
		MOV EDX, OFFSET CK7
		CALL WRITESTRING

		MOV EDX, OFFSET IV8				; Display Total Ordered Items Quantity
		CALL WRITESTRING
		MOV EAX, TTQTY
		CALL WriteDec

		MOV EDX, OFFSET IV9				; Display Subtotal
		CALL WRITESTRING
		MOV EAX, SUBTT
		CALL WriteDec

		MOV EDX, OFFSET IV10			; Display Service Tax
		CALL WRITESTRING
		MOV EAX, SUBTT
		MOV EBX, ServiceTax	
		MUL EBX
		MOV EBX, 100
		DIV EBX
		MOV EBX, EAX
		CALL WriteDec

		MOV EDX, OFFSET IV11			; Display Voucher Amount
		CALL WRITESTRING
		MOV EAX, FNVOUCHER
		CALL WriteDec

		MOV EDX, OFFSET IV7				; Display Grand Total Amount
		CALL WRITESTRING
		MOV EDX, OFFSET IV12			
		CALL WRITESTRING
		MOV EAX, SUBTT
		ADD EAX, EBX
		MOV EBX, FNVOUCHER
		SUB EAX, EBX
		MOV GRDTT, EAX					; Store the payable amount inside this variable
		CALL WriteDec
		CALL CRLF
		JMP METHOD_COMPARE

METHOD_COMPARE:
		CALL CRLF
		MOV EDX, OFFSET PayTypeTitl	
		CALL WRITESTRING
		CALL CRLF
		MOV EDX, OFFSET PayTypeIpt	
		CALL WRITESTRING

		CALL READCHAR
		CALL WRITECHAR
		CMP AL, '1'
		MOV EBX, orderCount
		MOV PaymentsArr[EBX], 1 ;save 1st payment method to Payments array
		JE CASH
		CMP AL, '2'
		MOV EBX, orderCount
		MOV PaymentsArr[EBX], 2 ;save 2nd payment method to Payments array
		JE CREDITCARD
		CMP AL, '3'
		MOV EBX, orderCount
		MOV PaymentsArr[EBX], 3 ;save 3rd payment method to Payments array
		JE EWALLET
		MOV EDX, OFFSET ErrMsg
		CALL WRITESTRING
		CALL CRLF
		JMP METHOD_COMPARE
CASH:
		CALL CRLF
		MOV EDX, OFFSET strTotal
		CALL WRITESTRING
		MOV EAX, GRDTT
		CALL WriteDec
		CALL CRLF

		MOV EDX, OFFSET cashMsg
		CALL WRITESTRING
		MOV EAX, 0
		CALL READDEC					; Obtain cash received amount
		MOV CASHRCD, EAX
		CALL CRLF
		MOV EAX, 0						; Perform calculation
		MOV EBX, 0
		MOV EAX, CASHRCD
		MOV EBX, GRDTT
		SUB EAX, EBX

CASH_COMPARE:
		CMP EAX, 0
		JL isNegative2
		MOV CSHBAL, EAX
		JMP INVOICE
isNegative2:
		MOV EDX, OFFSET errMsg8
		CALL WRITESTRING
		MOV EDX, OFFSET errMsg5
		CALL WRITESTRING	
		CALL READDEC					; Obtain cash received amount again 
		MOV CASHRCD, EAX
		CALL CRLF
		MOV EAX, 0
		MOV EBX, 0
		MOV EAX, CASHRCD
		MOV EBX, GRDTT
		SUB EAX, EBX
		MOV CSHBAL, EAX
		JMP CASH_COMPARE
CREDITCARD:

		MOV EDX, OFFSET strCardNum
		CALL WRITESTRING
		MOV EDX, OFFSET CrdNoInput
		MOV ECX, MaxInput
		CALL READSTRING
		CMP CrdNoInput, 'Q'
		JE METHOD_COMPARE

		MOV EDX, OFFSET strCardPin
		CALL WRITESTRING
		MOV ECX, CrdMaxInput
		MOV ESI, OFFSET CrdPinInput
		MOV EDX, OFFSET Asterisk
PIN_MASKED:
		CALL READCHAR
		MOV BYTE PTR [ESI], AL
		MOV AL, Asterisk
		CALL WRITECHAR
		ADD ESI, 1
		LOOP PIN_MASKED

		MOV ECX, CrdMaxInput
		MOV ESI, OFFSET CrdPinInput
PIN_STORE:
		MOV AL, BYTE PTR [ESI]
		ADD ESI, 1
		LOOP PIN_STORE

		MOV BYTE PTR [ESI], 0

INVOKE STR_COMPARE,
		ADDR CrdNoInput,
		ADDR CrdPinInput
		JNE INVALID_CARD
INVOKE STR_COMPARE,
		ADDR CrdPinInput,
		ADDR CardPin
		JNE INVALID_CARD
		CALL CRLF
		MOV EAX, GRDTT					; Set the values to be displayed in Final Receipt
		MOV CASHRCD, EAX
		MOV EAX, 0
		MOV CSHBAL, EAX
		MOV EDX, OFFSET CCAPPLIED
		CALL WRITESTRING
		MOV EAX, 1000					; Delay 1 sec
		CALL Delay
		JMP INVOICE
INVALID_CARD:
		MOV EDX, OFFSET ErrMsg4
		CALL WRITESTRING
		JMP CREDITCARD
EWALLET:
		MOV EDX, OFFSET strEW
		CALL WRITESTRING
		MOV ECX, ewMaxInput
		MOV ESI, OFFSET ewInput
		MOV EDX, OFFSET Asterisk
EW_MASKED:
		CALL READCHAR
		MOV BYTE PTR [ESI], AL
		MOV AL, Asterisk
		CALL WRITECHAR
		ADD ESI, 1
		LOOP EW_MASKED

		MOV ECX, ewMaxInput
		MOV ESI, OFFSET ewInput
EW_STORE:
		MOV AL, BYTE PTR [ESI]
		ADD ESI, 1
		LOOP EW_STORE

		MOV BYTE PTR [ESI], 0

INVOKE STR_COMPARE,
		ADDR ewInput,
		ADDR ewPIN
		JNE INVALID_EWALLET
		CALL CRLF
		MOV EAX, GRDTT					; Set the values to be displayed in Final Receipt
		MOV CASHRCD, EAX
		MOV EAX, 0
		MOV CSHBAL, EAX
		MOV EDX, OFFSET EEAPPLIED
		CALL WRITESTRING
		MOV EAX, 1000					; Delay 1 sec
		CALL Delay
		JMP INVOICE
INVALID_EWALLET:
		MOV EDX, OFFSET ErrMsg6
		CALL WRITESTRING
		JMP EWALLET
INVOICE:
		CALL Clrscr						; Display Final Receipt
		MOV EDX, OFFSET IV1
		CALL WriteString
		MOV EDX, OFFSET IV2
		CALL WriteString
		MOV EDX, OFFSET IV3
		CALL WriteString
		MOV EDX, OFFSET IV4
		CALL WriteString
		MOV EDX, OFFSET IV5
		CALL WriteString
		MOV EDX, OFFSET IV6
		CALL WriteString
		MOV EDX, OFFSET IV7
		CALL WriteString

		MOV EDX, OFFSET IV8				; Display Total Ordered Items Quantity
		CALL WriteString
		MOV EBX, orderCount
		MOV EAX, TTQTY
		MOV OrderQtyArr[EBX], EAX		;save tqty in orderqty array 
		CALL WriteDec

		MOV EDX, OFFSET IV9				; Display Subtotal
		CALL WriteString
		MOV EAX, SUBTT
		CALL WriteDec

		MOV EDX, OFFSET IV10			; Display Service Tax
		CALL WriteString
		MOV EAX, SUBTT
		MOV EBX, ServiceTax	
		MUL EBX
		MOV EBX, 100
		DIV EBX
		MOV EBX, EAX
		CALL WriteDec

		MOV EDX, OFFSET IV11			; Display Voucher Amount
		CALL WRITESTRING
		MOV EAX, FNVOUCHER
		CALL WriteDec

		MOV EDX, OFFSET IV12			; Display Total Amount Payable
		CALL WriteString
		MOV EBX, orderCount
		MOV EAX, GRDTT
		ADD	DAY_SALES, EAX				;add grandtotal to daily sales
		MOV GrandTtlArr[EBX], EAX		;save grandtotal to array
		CALL WriteDec

		MOV EDX, OFFSET IV13			; Display Amount Receivable
		CALL WriteString
		MOV EDX, OFFSET IV14
		CALL WriteString
		MOV EAX, CASHRCD
		CALL WriteDec

		MOV EDX, OFFSET IV15			; Display Changes if Any
		CALL WriteString
		MOV EAX, CSHBAL
		CALL WriteDec

		MOV EDX, OFFSET IV16
		CALL WriteString
		MOV EDX, OFFSET IV17			; Display Date and Time
		CALL WriteString
INVOKE GETLOCALTIME, ADDR sysTime
		MOVZX EAX, sysTime.wDay
		CALL WRITEDEC
		MOV AL, slash
		CALL WRITECHAR
		MOVZX EAX, sysTime.wMonth
		CALL WRITEDEC
		MOV AL, slash
		CALL WRITECHAR
		MOVZX EAX, sysTime.wYear
		CALL WRITEDEC
		MOV EDX, OFFSET IV18
		CALL WriteString
INVOKE GETLOCALTIME, ADDR sysTime
		MOVZX EAX, sysTime.wHour 
		CALL WRITEDEC
		MOV AL, colon
		CALL WRITECHAR
		MOVZX EAX, sysTime.wMinute
		CALL WRITEDEC
		MOV AL, colon
		CALL WRITECHAR
		MOVZX EAX, sysTime.wSecond
		CALL WRITEDEC
		MOV EDX, OFFSET IV19
		CALL WriteString
		MOV EDX, OFFSET strCont2
		CALL WRITESTRING
		CALL READCHAR
COMPARE_CONTINUE:
		CMP AL, 'y'
		JE MENU
		CMP AL, 'n'
		JE STARTOVER
		MOV EDX, OFFSET ErrMsg7 
		CALL WRITESTRING
		CALL READCHAR
		JMP COMPARE_CONTINUE

ADMIN: 
		CALL Clrscr
		MOV EDX, OFFSET RP1
		CALL WriteString
		MOV EDX, OFFSET RP2
		CALL WriteString
		MOV EDX, OFFSET RP3
		CALL WriteString
		MOV EDX, OFFSET RP4
		CALL WriteString
		MOV EDX, OFFSET RP5
		CALL WriteString
		MOV EDX, OFFSET RP6
		CALL WriteString
		MOV EDX, OFFSET RP7
		CALL WriteString
		MOV EDX, OFFSET RP8
		CALL WriteString
		MOV EDX, OFFSET RP9
		CALL WriteString
		MOV EDX, OFFSET RP10
		CALL WriteString
		MOV EDX, OFFSET RP11
		CALL WriteString
		MOV EDX, OFFSET RP12
		CALL WriteString
		MOV EDX, OFFSET RP13
		CALL WriteString
		MOV EDX, OFFSET RP14
		CALL WriteString
		MOV EDX, OFFSET RP15
		CALL WriteString
COMPARE_REPORT:
		MOV EDX, OFFSET menuOption
		CALL WRITESTRING
		CALL READCHAR
		CALL WRITECHAR
		CMP AL, '1'
		JE DAILYSALES
		CMP AL, '2'
		JE FOODSTATS
		CMP AL, '3'
		JE RESETREPORTS
		CMP AL, '4'
		JE STARTOVER
		MOV EDX, OFFSET errMsg
		CALL WRITESTRING
		JMP COMPARE_REPORT
		
		
DAILYSALES:
	;generate sales report
	cmp orderCount, 0
	JE SR_ERROR
	JMP REPORT_START
SR_ERROR:
	CALL CRLF
	CALL CRLF
	LEA EDX, SRERROR
	CALL WRITESTRING
	CALL READCHAR
	JMP ADMIN
REPORT_START:	
	CALL CLRscr
	LEA EDX, SREP1
	call writeString
	CALL CRLF
	LEA EDX, SREP2
	call writeString
	CALL CRLF
	LEA EDX, SREP3
	call writeString
	CALL CRLF
	LEA EDX, SREP4
	call writeString
	CALL CRLF
	LEA EDX, SREP5
	call writeString
	CALL CRLF
	LEA EDX, SREP6
	call writeString
	CALL CRLF
	LEA EDX, SREP_LINE
	call writeString
	CALL CRLF
	LEA EDX, SREP_HEAD
	call writeString
	CALL CRLF

	MOV 	EAX, orderCount
	MOV 	EBX, 4
	MOV		EDX, 0
	DIV 	EBX
	MOV 	ECX, EAX 				;set number of iteration to print list
	MOV		ESI, 4
LIST_SALES:
	LEA 	EDX, SREP_BLANK1		;initial spacing
	CALL 	WRITESTRING	
	MOV 	EBX, 4
	MOV		EAX, ESI				;order no
	MOV		EDX, 0
	DIV		EBX
	CALL 	WRITEDEC	
	LEA 	EDX, SREP_BLANK2		;spacing
	CALL 	WRITESTRING	
	MOV 	EAX, OrderQtyArr[ESI]	;item qty
	CALL 	writeDEC
	LEA		EDX, SREP_BLANK2
	CALL 	WRITESTRING
	MOV 	EAX, PaymentsArr[ESI]	;payment type

	CMP		EAX, 1
	JE		PCASH
	CMP 	EAX, 2
	JE		PCARD
	CMP 	EAX, 3
	JE		PEWAL
PCASH:
	LEA 	EDX, SREP_CASH		;cash
	CALL	WRITESTRING
	JMP 	SR_CONT
PCARD:
	LEA		EDX, SREP_CARD		;card
	CALL 	WRITESTRING
	JMP		SR_CONT
PEWAL:
	LEA 	EDX, SREP_EWAL		;e-wallet
	CALL 	WRITESTRING
	JMP 	SR_CONT
	
SR_CONT:
	LEA		EDX, SREP_BLANK2
	CALL	WRITESTRING
	MOV 	EAX, GrandTtlArr[ESI]
	CALL 	WRITEDEC
	CALL 	CRLF
	
	DEC		ECX
	ADD		ESI , 4
	cmp 	ECX, 0
	JNZ		LIST_SALES				;loop to print list
	
	
	LEA 	EDX, SREP_LINE
	call 	WRITESTRING
	call 	CRLF
	LEA		EDX, SREP_TAIL
	call 	WRITESTRING
	MOV 	EAX, DAY_SALES
	CALL 	WRITEDEC
	call 	CRLF
	LEA		EDX, SREP_TAIL2
	call 	WRITESTRING
	MOV 	EAX, orderCount
	MOV 	EDX, 0
	MOV 	EBX, 4
	DIV		EBX
	CALL 	WRITEDEC
	call 	CRLF
	LEA 	EDX, SREP_LINE
	call 	WRITESTRING
	call 	CRLF

	LEA EDX, SAVEMSG
	CALL WRITESTRING
	CALL READCHAR
	CALL WRITECHAR
	CMP AL, "y"
	JE SAVESALESREPORT
	JMP ADMIN
	
SAVESALESREPORT:
	;copy string to buffer like a string builder
	MOV EDI, 0
	MOV ECX, Lengthof SREP1
	MOV ESI, 0

WRITE_SREP1:
	MOV AL, SREP1[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP1

	MOV ESI, 0
	MOV ECX, Lengthof SREP2
	
WRITE_SREP2:
	MOV AL, SREP2[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP2

	MOV ESI, 0
	MOV ECX, Lengthof SREP3

WRITE_SREP3:
	MOV AL, SREP3[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP3

	MOV ESI, 0
	MOV ECX, Lengthof SREP4
	
WRITE_SREP4:
	MOV AL, SREP4[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP4

	MOV ESI, 0
	MOV ECX, Lengthof SREP5
	
WRITE_SREP5:
	MOV AL, SREP5[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP5

	MOV ESI, 0
	MOV ECX, Lengthof SREP6
	
WRITE_SREP6:
	MOV AL, SREP6[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP6

	MOV ESI, 0
	MOV ECX, Lengthof SREP_LINE
	
WRITE_SREP_LINE:
	MOV AL, SREP_LINE[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP_LINE

	MOV ESI, 0
	MOV ECX, Lengthof SREP_HEAD

WRITE_SREP_HEAD:
	MOV AL, SREP_HEAD[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP_HEAD
	MOV AL, 13
	MOV BUFFER1[EDI], AL
	
	MOV EAX, orderCount
	MOV EBX, 4
	MOV EDX, 0
	DIV EBX
	MOV ECX, EAX
	MOV ESI, 4
	PUSH ECX			;temporarily hold value of ECX
	PUSH ESI			;temporarily hold value of ESI

	MOV ESI, 0
	MOV ECX, Lengthof SREP_LINE
	
WRITE_SREP_LINE5:
	MOV AL, SREP_LINE[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	LOOP WRITE_SREP_LINE5
	
WRITE_LIST:
	MOV AL, 13
	MOV BUFFER1[EDI], AL
	INC EDI

	MOV ESI, 0
	MOV ECX, Lengthof SREP_BLANK1
	
WRITE_BLANK1:
	MOV AL, SREP_BLANK1[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	LOOP WRITE_BLANK1
	
	POP ESI
	MOV EAX, ESI 
	PUSH ESI
	MOV EBX, 4
	MOV EDX, 0
	DIV EAX
	CALL CONVERT_DEC_STRING
	MOV ECX, Lengthof CDEC
	MOV ESI, 0
	
WRITE_NO:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	LOOP WRITE_NO
	
	MOV ECX, Lengthof SREP_BLANK2
	MOV ESI, 0
	
WRITE_BLANK2:
	MOV AL, SREP_BLANK2[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	LOOP WRITE_BLANK2
	
	POP ESI
	MOV EAX, OrderQtyArr[ESI]
	PUSH ESI
	CALL CONVERT_DEC_STRING
	MOV ECX, Lengthof CDEC
	MOV ESI, 0

WRITE_ITEM:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	LOOP WRITE_ITEM
	
	MOV ECX, Lengthof SREP_BLANK2
	MOV ESI, 0
	
WRITE_BLANK3:
	MOV AL, SREP_BLANK2[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	LOOP WRITE_BLANK3
	
	POP ESI
	MOV EAX,PaymentsArr[ESI]
	PUSH ESI
	CMP EAX, 1
	JE	WRITE_CASH
	CMP EAX, 2
	JE	WRITE_CARD
	CMP EAX, 3
	JE 	WRITE_EWAL
	
WRITE_CASH:
	MOV AL, 67 ;C
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 65 ;A
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 83 ;S
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 72 ;H
	MOV BUFFER1[EDI], AL
	INC EDI
	JMP WRITE_REPORT_CONT
WRITE_CARD:
	MOV AL, 67 ;C
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 65 ;A
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 82 ;R
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 68 ;D
	MOV BUFFER1[EDI], AL
	INC EDI
	JMP WRITE_REPORT_CONT
WRITE_EWAL:
	MOV AL, 69 ;E
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 87 ;W
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 65 ;A
	MOV BUFFER1[EDI], AL
	INC EDI
	MOV AL, 76 ;L
	MOV BUFFER1[EDI], AL
	INC EDI
	JMP WRITE_REPORT_CONT

WRITE_REPORT_CONT:
	MOV ESI, 0
	MOV ECX, LENGTHOF SREP_BLANK2

WRITE_BLANK4:
	MOV AL, SREP_BLANK2[ESI]
	MOV BUFFER1, AL
	INC EDI
	INC ESI
	LOOP WRITE_BLANK4
	
	POP ESI
	MOV EAX, GrandTtlArr[ESI]
	PUSH ESI
	CALL CONVERT_DEC_STRING
	MOV ECX, Lengthof CDEC
	MOV ESI, 0
	
WRITE_GTOTAL:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	LOOP WRITE_GTOTAL

	INC EDI
	POP ESI			;pop esi, increment by 4 and push it back in
	ADD ESI, 4	
	POP ECX			;pop ecx, decrement it, and push it back in
	DEC ECX
	PUSH ECX
	PUSH ESI
	
	CMP ECX, 0
	JNZ	WRITE_LIST

	MOV ESI,0
	MOV ECX, Lengthof SREP_LINE
	
WRITE_SREP_LINE2:
	MOV AL, SREP_LINE[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	LOOP WRITE_SREP_LINE2
	
	MOV ESI,0
	MOV ECX, Lengthof SREP_TAIL
	
WRITE_TAIL:
	MOV AL, SREP_TAIL[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_TAIL
	
	MOV EAX, DAY_SALES
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, Lengthof CDEC

WRITE_DAY_SALES:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_DAY_SALES
	
	MOV ESI,0
	MOV ECX, Lengthof SREP_LINE

WRITE_SREP_LINE3:
	MOV AL, SREP_LINE[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_SREP_LINE3


;------CREATING AND WRITING FILE-------;
WRITE_FILE:		
	LEA EDX, SRFILE						;Create Text file	
	CALL CreateOutputFIle				
	MOV HANDLE1, EAX
	
;------Check file creation error-------;	
	cmp eax, INVALID_HANDLE_VALUE
	JNE EXECUTE_FILE_WRITE
	MOV edx, OFFSET FILEERR
	CALL WRITESTRING
	JMP FOODSTATS

EXECUTE_FILE_WRITE:
	MOV EDX, OFFSET BUFFER1				;copy content of buffer1 to the text file
	MOV ECX, EDI
	CALL WriteToFile
	mov EAX, HANDLE1
	CALL CLOSEFILE
	CALL CLEAR_BUFFER
	CALL CRLF
	LEA EDX, SAVE_DONE
	CALL WRITESTRING
	CALL READCHAR
	JMP ADMIN




;---------------------FOOD REPORT-----------------------;
FOODSTATS:
	;generate food report and calculate total qty sold
	MOV EBX, 0
	CALL CLRscr
	LEA EDX, FREP1
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP2
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP3
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP4
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP5
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP6
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP7
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP8
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP9
	CALL WRITESTRING
	MOV EAX, B1_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP10
	CALL WRITESTRING
	MOV EAX, B2_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP11
	CALL WRITESTRING
	MOV EAX, B3_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP12
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP13
	CALL WRITESTRING
	MOV EAX, D1_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP14
	CALL WRITESTRING
	MOV EAX, D2_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP15
	CALL WRITESTRING
	MOV EAX, D3_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP16
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP17
	CALL WRITESTRING
	MOV EAX, F1_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP18
	CALL WRITESTRING
	MOV EAX, F2_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP19
	CALL WRITESTRING
	MOV EAX, F3_COUNT
	ADD EBX, EAX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP20
	CALL WRITESTRING
	call CRLF
	LEA EDX, FREP21
	CALL WRITESTRING
	MOV EAX, EBX
	MOV TT_COUNT, EBX
	CALL WRITEDEC
	call CRLF
	LEA EDX, FREP22
	CALL WRITESTRING
	call CRLF

	LEA EDX, SAVEMSG
	CALL WRITESTRING
	CALL READCHAR
	CALL WRITECHAR
	CMP AL, "y"
	JE SAVEFOODREPORT
	JMP ADMIN



SAVEFOODREPORT:
	;copy string to buffer like a string builder
	MOV EDI, 0
	MOV ECX, Lengthof FREP1
	MOV ESI, 0

WRITE_FREP1:
	MOV AL, FREP1[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP1
	MOV ESI, 0
	MOV ECX, Lengthof FREP2

WRITE_FREP2:
	MOV AL, FREP2[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP2
	MOV ESI, 0
	MOV ECX, Lengthof FREP3

WRITE_FREP3:
	MOV AL, FREP3[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP3
	MOV ESI, 0
	MOV ECX, Lengthof FREP4

WRITE_FREP4:
	MOV AL, FREP4[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP4
	MOV ESI, 0
	MOV ECX, Lengthof FREP5

WRITE_FREP5:
	MOV AL, FREP5[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP5
	MOV ESI, 0
	MOV ECX, Lengthof FREP6

WRITE_FREP6:
	MOV AL, FREP6[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP6
	MOV ESI, 0
	MOV ECX, Lengthof FREP7

WRITE_FREP7:
	MOV AL, FREP7[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP7
	MOV ESI, 0
	MOV ECX, Lengthof FREP8

WRITE_FREP8:
	MOV AL, FREP8[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP8
	MOV ESI, 0
	MOV ECX, Lengthof FREP9

WRITE_FREP9:
	MOV AL, FREP9[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP9

	MOV EAX, B1_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_B1:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_B1

	MOV ESI, 0
	MOV ECX, Lengthof FREP10

WRITE_FREP10:
	MOV AL, FREP10[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP10

	MOV EAX, B2_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_B2:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_B2

	MOV ESI, 0
	MOV ECX, Lengthof FREP11

WRITE_FREP11:
	MOV AL, FREP11[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP11

	MOV EAX, B3_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_B3:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_B3

	MOV ESI, 0
	MOV ECX, Lengthof FREP12


WRITE_FREP12:
	MOV AL, FREP12[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP12
	MOV ESI, 0
	MOV ECX, Lengthof FREP13

WRITE_FREP13:
	MOV AL, FREP13[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP13
	
	MOV EAX, D1_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_D1:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_D1

	MOV ESI, 0
	MOV ECX, Lengthof FREP14

WRITE_FREP14:
	MOV AL, FREP14[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP14
	
	MOV EAX, D2_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_D2:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_D2

	MOV ESI, 0
	MOV ECX, Lengthof FREP15

WRITE_FREP15:
	MOV AL, FREP15[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP15
	
	MOV EAX, D3_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_D3:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_D3

	MOV ESI, 0
	MOV ECX, Lengthof FREP16

WRITE_FREP16:
	MOV AL, FREP16[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP16
	MOV ESI, 0
	MOV ECX, Lengthof FREP17

WRITE_FREP17:
	MOV AL, FREP17[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP17
	
	MOV EAX, F1_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_F1:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_F1

	MOV ESI, 0
	MOV ECX, Lengthof FREP18

WRITE_FREP18:
	MOV AL, FREP18[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP18
	
	MOV EAX, F2_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_F2:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_F2

	MOV ESI, 0
	MOV ECX, Lengthof FREP19

WRITE_FREP19:
	MOV AL, FREP19[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP19
	
	MOV EAX, F3_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_F3:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_F3

	MOV ESI, 0
	MOV ECX, Lengthof FREP20

WRITE_FREP20:
	MOV AL, FREP20[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP20
	MOV ESI, 0
	MOV ECX, Lengthof FREP21

WRITE_FREP21:
	MOV AL, FREP21[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP21
	
	MOV EAX, TT_COUNT
	CALL CONVERT_DEC_STRING
	MOV ESI, 0
	MOV ECX, LENGTHOF CDEC

WRITE_TT:
	MOV AL, CDEC[ESI]
	MOV BUFFER1[EDI], AL
	INC ESI
	INC EDI
	Loop WRITE_TT

	MOV ECX, Lengthof FREP22
	MOV ESI, 0

WRITE_FREP22:
	MOV AL, FREP22[ESI]
	MOV BUFFER1[EDI], AL
	INC EDI
	INC ESI
	Loop WRITE_FREP22

WRITE_TO_FILE:
	;Create Text file
	LEA EDX, FRFILE
	call CreateOutputFIle
	MOV HANDLE1, EAX
	
	;Check creation error
	cmp eax, INVALID_HANDLE_VALUE
	JNE WRITESREPORT
	MOV edx, OFFSET FILEERR
	CALL WRITESTRING
	JMP FOODSTATS

WRITESREPORT:
	MOV EDX, OFFSET BUFFER1
	MOV ECX, EDI
	call WriteToFile
	call CLEAR_BUFFER
	mov EAX, HANDLE1
	CALL CLOSEFILE
	CALL CRLF
	LEA EDX, SAVE_DONE
	CALL WRITESTRING
	CALL READCHAR
	JMP ADMIN

CLEAR_BUFFER:
	MOV ECX, LENGTHOF BUFFER1
	MOV EDI, 0
CLEAR_BUFFER2:
	MOV BUFFER1[EDI], 0
	INC EDI
	Loop CLEAR_BUFFER2
	RET
	
RESETREPORTS:
	LEA EDX, CONF_RESET
	CALL writeString
	CALL READCHAR
	CMP AL, "y"
	JNE ADMIN
	MOV EAX, 0
	MOV F1_COUNT, EAX
	MOV F2_COUNT, EAX
	MOV F3_COUNT, EAX
	MOV B1_COUNT, EAX
	MOV B2_COUNT, EAX
	MOV B3_COUNT, EAX
	MOV D1_COUNT, EAX
	MOV D2_COUNT, EAX
	MOV D3_COUNT, EAX
	MOV TT_COUNT, EAX
	MOV orderCount, 0
	MOV DAY_SALES, 0
	MOV ECX, 20
	MOV ESI, 0
Resetarray:
	MOV OrderQtyArr[ESI], EAX
	MOV PaymentsArr[ESI], EAX
	MOV GrandTtlArr[ESI], EAX
	INC ESI
	Loop Resetarray
	LEA EDX, RESET_DONE
	CALL WRITESTRING
	CALL READCHAR
	JMP ADMIN
	
CONVERT_DEC_STRING:
	MOV BH, AL
	MOV ESI, 0
	CMP EAX, 0
	JE	ZEROS
	cmp EAX, 100
	MOV CDEC[ESI], 0		;clear the location
	JAE	hundreds
	JMP tens

hundreds:
	MOV BL, 100
	DIV BL					;divide ax with 100
	mov BH, AH				;save the remainder in bh
	ADD AL, 48				; translate integer to ascii code
	mov CDEC[ESI], AL		; save the ascii code to string location 0
	MOV AX, 0				;clear ax register


tens:
	MOV ESI, 1				;set string location to 1
	MOV CDEC[ESI], 0		;clear the string location
	MOV AL, BH				;mov the remainder(bh) to al
	cmp AL, 10				;compare with 10
	JB	ones				;jump if below 10
	MOV BL, 10
	DIV BL					;divide ax with 10
	MOV BH, AH				;save the remainder in bh
	ADD AL, 48				;translate to ascii code
	MOV CDEC[ESI], AL		; save the ascii code to string location 1

ones:
	MOV ESI,2
	MOV AL, BH				;move the reamainder in BH to al
	ADD AL, 48				;translate integer to ascii code
	MOV CDEC[ESI], AL		;save the ascii code to string location 2
	JMP RETURNSTR			

zeros:
	MOV CDEC[0], 0			;used to convert 0 to ascii code
	MOV CDEC[1], 0
	MOV CDEC[2], 48

RETURNSTR:
	RET						;return to caller

TERMINATE:
	INVOKE ExitProcess,0	

main ENDP	
END main	
