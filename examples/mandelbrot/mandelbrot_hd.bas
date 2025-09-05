REM Mandelbrot Set - High Definition Version (Corrected)
REM Functional version without GOTO problems

10 PRINT "Mandelbrot Set - High Definition Version"
20 PRINT "======================================="

REM Initialization
30 GRAPHICS
40 CLS
50 COLOR 1

REM Parameters for good quality
60 LET WIDTH = 200
70 LET HEIGHT = 150
80 LET MAX_ITER = 50

REM Classic Mandelbrot range
90 LET XMIN = -2.0
100 LET XMAX = 1.0
110 LET YMIN = -1.0
120 LET YMAX = 1.0

130 LET XSTEP = (XMAX - XMIN) / WIDTH
140 LET YSTEP = (YMAX - YMIN) / HEIGHT

150 PRINT "Calculating Mandelbrot set..."
160 PRINT "Resolution:"; WIDTH; "x"; HEIGHT
170 PRINT "Iterations:"; MAX_ITER
180 PRINT "Range: x["; XMIN; "to"; XMAX; "]"
190 PRINT "       y["; YMIN; "to"; YMAX; "]"
200 PRINT

REM Main calculation
210 FOR PIXELY = 0 TO HEIGHT - 1
220 LET CY = YMIN + PIXELY * YSTEP

230 FOR PIXELX = 0 TO WIDTH - 1
240 LET CX = XMIN + PIXELX * XSTEP

REM Mandelbrot calculation without GOTO problems
250 LET ZX = 0
260 LET ZY = 0
270 LET COLOR_VAL = 0
280 LET DIVERGED = 0

290 FOR I = 1 TO MAX_ITER
300 LET ZX_NEW = ZX * ZX - ZY * ZY + CX
310 LET ZY_NEW = 2 * ZX * ZY + CY

REM Escape velocity test
320 LET DISTANCE = ZX_NEW * ZX_NEW + ZY_NEW * ZY_NEW
330 IF DISTANCE > 4 AND DIVERGED = 0 THEN LET DIVERGED = I
340 IF DISTANCE > 4 THEN LET I = MAX_ITER

350 LET ZX = ZX_NEW
360 LET ZY = ZY_NEW
370 NEXT I

REM Color determination based on divergence
380 IF DIVERGED = 0 THEN COLOR_VAL = 0
390 IF DIVERGED > 0 AND DIVERGED < 5 THEN COLOR_VAL = 1
400 IF DIVERGED >= 5 AND DIVERGED < 10 THEN COLOR_VAL = 2
410 IF DIVERGED >= 10 AND DIVERGED < 20 THEN COLOR_VAL = 3
420 IF DIVERGED >= 20 AND DIVERGED < 30 THEN COLOR_VAL = 4
430 IF DIVERGED >= 30 THEN COLOR_VAL = 5

REM Draw pixel (centered)
440 COLOR COLOR_VAL
450 PSET PIXELX + 300, PIXELY + 225

460 NEXT PIXELX

REM Progress indicator every 10 lines
470 IF PIXELY / 10 * 10 = PIXELY THEN PRINT "Line"; PIXELY; "of"; HEIGHT; "("; INT(PIXELY * 100 / HEIGHT); "%)"

480 NEXT PIXELY

490 PRINT
500 PRINT "Mandelbrot set complete!"
510 PRINT "Black areas = Mandelbrot set"
520 PRINT "Colored areas = Diverging points"
530 PRINT

540 INPUT "Press Enter to exit...", DUMMY
550 END
