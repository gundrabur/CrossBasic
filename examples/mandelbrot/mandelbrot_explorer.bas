1 REM Mandelbrot Explorer - Interactive Version
2 REM Explores various interesting regions of the Mandelbrot set

10 PRINT "Mandelbrot Explorer"
20 PRINT "==================="
30 PRINT "Choose a region to explore:"
40 PRINT "1 - Full view of the Mandelbrot set"
50 PRINT "2 - Seahorse Valley"
60 PRINT "3 - Elephant Valley"
70 PRINT "4 - Lightning structure"
80 PRINT "5 - Spiral structure"

90 INPUT "Your choice (1-5): ", CHOICE

100 GRAPHICS
110 CLS

115 REM Parameters depending on choice
120 IF CHOICE = 1 THEN GOSUB 1000
130 IF CHOICE = 2 THEN GOSUB 1100
140 IF CHOICE = 3 THEN GOSUB 1200
150 IF CHOICE = 4 THEN GOSUB 1300
160 IF CHOICE = 5 THEN GOSUB 1400

165 REM Common rendering parameters
170 LET WIDTH = 600
180 LET HEIGHT = 400
190 LET MAX_ITER = 80
200 LET STARTX = 100
210 LET STARTY = 100

220 LET XSTEP = (XMAX - XMIN) / WIDTH
230 LET YSTEP = (YMAX - YMIN) / HEIGHT

240 PRINT "Drawing region:"; REGION_NAME
250 PRINT "Please wait..."

255 REM Main rendering loop
260 FOR Y = 0 TO HEIGHT - 1 STEP 2
270 LET CY = YMIN + Y * YSTEP

280 FOR X = 0 TO WIDTH - 1 STEP 2
290 LET CX = XMIN + X * XSTEP

295 REM Mandelbrot iteration
300 LET ZX = 0
310 LET ZY = 0

320 FOR ITER = 1 TO MAX_ITER
330 LET ZX_OLD = ZX
340 LET ZX = ZX * ZX - ZY * ZY + CX
350 LET ZY = 2 * ZX_OLD * ZY + CY

360 IF ZX * ZX + ZY * ZY > 4 THEN GOTO 380
370 NEXT ITER

380 REM Color selection based on escape velocity
390 LET COLOR_VAL = ITER / 10
400 IF COLOR_VAL > 9 THEN COLOR_VAL = 0
410 IF ITER = MAX_ITER THEN COLOR_VAL = 0

420 COLOR INT(COLOR_VAL)
430 PSET STARTX + X, STARTY + Y

440 NEXT X

445 REM Show progress
450 IF Y / 20 = INT(Y / 20) THEN PRINT "Line"; Y; "of"; HEIGHT

460 NEXT Y

470 PRINT "Complete! Region:"; REGION_NAME
480 PRINT "Would you like to explore another region?"
490 INPUT "Y/N: ", ANSWER

500 IF ANSWER = "Y" OR ANSWER = "y" THEN GOTO 10

510 END

515 REM ========================
516 REM Region Definitions
517 REM ========================

1000 REM Full view
1010 LET XMIN = -2.5
1020 LET XMAX = 1.0
1030 LET YMIN = -1.25
1040 LET YMAX = 1.25
1050 LET REGION_NAME = "Full view"
1060 RETURN

1100 REM Seahorse Valley
1110 LET XMIN = -0.75
1120 LET XMAX = -0.73
1130 LET YMIN = 0.095
1140 LET YMAX = 0.115
1150 LET REGION_NAME = "Seahorse Valley"
1160 RETURN

1200 REM Elephant Valley  
1210 LET XMIN = 0.25
1220 LET XMAX = 0.26
1230 LET YMIN = 0.0
1240 LET YMAX = 0.01
1250 LET REGION_NAME = "Elephant Valley"
1260 RETURN

1300 REM Lightning
1310 LET XMIN = -1.775
1320 LET XMAX = -1.76
1330 LET YMIN = -0.01
1340 LET YMAX = 0.005
1350 LET REGION_NAME = "Lightning"
1360 RETURN

1400 REM Spiral
1410 LET XMIN = -0.16
1420 LET XMAX = -0.14
1430 LET YMIN = 1.025
1440 LET YMAX = 1.045
1450 LET REGION_NAME = "Spiral"
1460 RETURN
