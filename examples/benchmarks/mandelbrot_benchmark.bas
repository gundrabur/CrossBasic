1 REM Mandelbrot Benchmark - Test graphics performance with TIME function
2 REM This version measures how long the Mandelbrot calculation takes

10 PRINT "Mandelbrot Set Benchmark"
20 PRINT "======================="
30 PRINT

35 REM Parameters for benchmark
40 LET WIDTH = 160
50 LET HEIGHT = 120
60 LET MAX_ITER = 50

70 LET XMIN = -2.0
80 LET XMAX = 1.0
90 LET YMIN = -1.0
100 LET YMAX = 1.0

110 LET XSTEP = (XMAX - XMIN) / WIDTH
120 LET YSTEP = (YMAX - YMIN) / HEIGHT

130 PRINT "Resolution:"; WIDTH; "x"; HEIGHT
140 PRINT "Max iterations:"; MAX_ITER
150 PRINT "Starting benchmark..."
160 PRINT

165 REM Start timing
170 LET START_TIME = TIME()

180 GRAPHICS
190 CLS

200 FOR Y = 0 TO HEIGHT - 1
210 LET CY = YMIN + Y * YSTEP

220 FOR X = 0 TO WIDTH - 1
230 LET CX = XMIN + X * XSTEP

235 REM Mandelbrot calculation
240 LET ZX = 0
250 LET ZY = 0
260 LET COLOR_VAL = 0

270 FOR ITER = 1 TO MAX_ITER
280 LET ZX_NEW = ZX * ZX - ZY * ZY + CX
290 LET ZY_NEW = 2 * ZX * ZY + CY
300 LET DISTANCE = ZX_NEW * ZX_NEW + ZY_NEW * ZY_NEW
310 IF DISTANCE > 4 THEN LET COLOR_VAL = 1
320 IF DISTANCE > 4 THEN LET ITER = MAX_ITER
330 LET ZX = ZX_NEW
340 LET ZY = ZY_NEW
350 NEXT ITER

355 REM Draw pixel
360 COLOR COLOR_VAL
370 PSET X, Y

380 NEXT X
390 NEXT Y

395 REM End timing
400 LET END_TIME = TIME()
410 LET TOTAL_TIME = END_TIME - START_TIME

420 PRINT "Benchmark complete!"
430 PRINT "Total calculation time: "; INT(TOTAL_TIME * 1000); " milliseconds"
440 LET PIXELS = WIDTH * HEIGHT
450 PRINT "Pixels calculated: "; PIXELS
460 LET PIXELS_PER_SEC = PIXELS / TOTAL_TIME
470 PRINT "Performance: "; INT(PIXELS_PER_SEC); " pixels/second"

480 END
