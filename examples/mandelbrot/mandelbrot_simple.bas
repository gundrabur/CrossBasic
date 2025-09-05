REM Mandelbrot-Simple - Functional version without GOTO problems

10 PRINT "Mandelbrot Set (Simple)"
20 PRINT "======================"

30 GRAPHICS
40 CLS

REM Small resolution for fast calculation
50 LET WIDTH = 100
60 LET HEIGHT = 80
70 LET MAX_ITER = 30

80 LET XMIN = -2.0
90 LET XMAX = 1.0
100 LET YMIN = -1.0
110 LET YMAX = 1.0

120 LET XSTEP = (XMAX - XMIN) / WIDTH
130 LET YSTEP = (YMAX - YMIN) / HEIGHT

140 PRINT "Calculating Mandelbrot set..."
150 PRINT "Resolution:"; WIDTH; "x"; HEIGHT

160 FOR Y = 0 TO HEIGHT - 1
170 LET CY = YMIN + Y * YSTEP

180 FOR X = 0 TO WIDTH - 1
190 LET CX = XMIN + X * XSTEP

REM Mandelbrot calculation without GOTO
200 LET ZX = 0
210 LET ZY = 0
220 LET COLOR_VAL = 0

230 FOR ITER = 1 TO MAX_ITER
240 LET ZX_NEW = ZX * ZX - ZY * ZY + CX
250 LET ZY_NEW = 2 * ZX * ZY + CY

260 LET DISTANCE = ZX_NEW * ZX_NEW + ZY_NEW * ZY_NEW
270 IF DISTANCE > 4 THEN LET COLOR_VAL = 1
280 IF DISTANCE > 4 THEN LET ITER = MAX_ITER

290 LET ZX = ZX_NEW
300 LET ZY = ZY_NEW
310 NEXT ITER

REM Set color and draw
320 COLOR COLOR_VAL
330 PSET X + 300, Y + 200

340 NEXT X

REM Progress every 10 lines
350 IF Y / 10 * 10 = Y THEN PRINT "Line"; Y; "of"; HEIGHT

360 NEXT Y

370 PRINT "Mandelbrot set complete!"
380 INPUT "Press Enter to exit...", DUMMY
390 END
