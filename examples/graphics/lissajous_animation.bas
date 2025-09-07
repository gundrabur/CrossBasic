1 REM Real-time Lissajous Animation - Dynamic Parameter Changes
2 REM This program shows how Lissajous curves change as parameters vary
3 REM Creates a mesmerizing animation effect

10 GRAPHICS
20 CLS
30 COLOR 1

40 PRINT "Real-time Lissajous Animation"
50 PRINT "============================="
60 PRINT "Watch how curves change with varying parameters!"
70 PRINT ""

75 REM Animation parameters
80 LET CENTER_X = 400
90 LET CENTER_Y = 300
100 LET BASE_SCALE = 100
110 LET STEPS = 3

120 PRINT "Starting animation..."
130 PRINT "Parameters will change continuously..."

135 REM Main animation loop
140 FOR CYCLE = 1 TO 5

150 PRINT "Animation cycle"; CYCLE; "of 5"

155 REM Slowly changing frequency ratios
160 FOR FREQ_MULT = 10 TO 50 STEP 2

165 REM Calculate current frequencies
180 LET FREQ_A = FREQ_MULT / 10
190 LET FREQ_B = 30 / 10

195 REM Calculate current scale (pulsing effect)
200 LET CURRENT_SCALE = BASE_SCALE * (1 + 0.3 * SIN(FREQ_MULT / 5))

205 REM Calculate phase shift
210 LET PHASE = FREQ_MULT * 15.7 / 100

215 REM Choose color based on cycle
220 LET CURRENT_COLOR = CYCLE + 1
230 IF CURRENT_COLOR > 9 THEN LET CURRENT_COLOR = 2
240 COLOR CURRENT_COLOR

245 REM Clear previous curve periodically
250 IF FREQ_MULT / 6 * 6 = FREQ_MULT THEN CLS

255 REM Draw the current Lissajous curve
260 FOR T = 0 TO 628 STEP STEPS
270 LET X = CENTER_X + CURRENT_SCALE * SIN(FREQ_A * T / 100 + PHASE)
280 LET Y = CENTER_Y + CURRENT_SCALE * SIN(FREQ_B * T / 100)
290 PSET X, Y
300 NEXT T

310 NEXT FREQ_MULT
320 NEXT CYCLE

325 REM Final spectacular multi-curve display
330 CLS
340 COLOR 1
350 PRINT "Grand finale - Multiple curves simultaneously!"

355 REM Draw several curves with different parameters at once
360 LET CURVES = 5

370 FOR CURVE_NUM = 1 TO CURVES
380 COLOR CURVE_NUM + 1

385 REM Each curve has different parameters
390 LET A_FREQ = CURVE_NUM
400 LET B_FREQ = CURVES + 1 - CURVE_NUM
410 LET SCALE = BASE_SCALE * (0.5 + 0.1 * CURVE_NUM)
420 LET PHASE = CURVE_NUM * 62.8 / CURVES

430 FOR T = 0 TO 628 * B_FREQ STEP 4
440 LET X = CENTER_X + SCALE * SIN(A_FREQ * T / 100 + PHASE)
450 LET Y = CENTER_Y + SCALE * SIN(B_FREQ * T / 100)
460 PSET X, Y
470 NEXT T
480 NEXT CURVE_NUM

485 REM Add central reference point
490 COLOR 9
500 CIRCLE CENTER_X, CENTER_Y, 5

505 REM Create a decorative border effect
510 FOR BORDER = 1 TO 3
520 COLOR BORDER + 6
530 CIRCLE CENTER_X, CENTER_Y, BASE_SCALE + BORDER * 20
540 NEXT BORDER

550 COLOR 1
560 PRINT ""
570 PRINT "Animation complete!"
580 PRINT "This demonstrates how Lissajous curves"
590 PRINT "change with different frequency ratios,"
600 PRINT "phases, and scaling factors."
610 PRINT ""
620 PRINT "Mathematical beauty in motion!"

630 INPUT "Press Enter to exit...", DUMMY
640 END
