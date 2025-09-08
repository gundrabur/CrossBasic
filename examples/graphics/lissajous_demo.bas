1 REM Lissajous Curves - Beautiful Mathematical Patterns
2 REM A Lissajous curve is created by plotting parametric equations:
3 REM X = A * SIN(a*t + phase)
4 REM Y = B * SIN(b*t)
5 REM where a and b are frequency ratios

10 GRAPHICS
20 CLS
30 COLOR 1

40 PRINT "Lissajous Curve Generator"
50 PRINT "========================"
60 PRINT "Drawing beautiful mathematical patterns..."

65 REM Screen center and scaling
70 LET CX = 400
80 LET CY = 300
90 LET SCALE = 150

95 REM First curve: 3:2 frequency ratio
100 COLOR 2
110 PRINT "Drawing 3:2 frequency ratio (red)..."
120 LET A = 3
130 LET B = 2
140 LET PHASE = 0

150 FOR T = 0 TO 628 STEP 2
160 LET X = CX + SCALE * SIN(A * T / 100 + PHASE)
170 LET Y = CY + SCALE * SIN(B * T / 100)
180 PSET X, Y
190 NEXT T

195 REM Second curve: 5:4 frequency ratio with phase shift
200 COLOR 3
210 PRINT "Drawing 5:4 frequency ratio (green)..."
220 LET A = 5
230 LET B = 4
240 LET PHASE = 1.57

250 FOR T = 0 TO 628 STEP 2
260 LET X = CX + (SCALE * 0.8) * SIN(A * T / 100 + PHASE)
270 LET Y = CY + (SCALE * 0.8) * SIN(B * T / 100)
280 PSET X, Y
290 NEXT T

295 REM Third curve: 7:5 frequency ratio
300 COLOR 4
310 PRINT "Drawing 7:5 frequency ratio (blue)..."
320 LET A = 7
330 LET B = 5
340 LET PHASE = 0

350 FOR T = 0 TO 628 STEP 2
360 LET X = CX + (SCALE * 0.6) * SIN(A * T / 100 + PHASE)
370 LET Y = CY + (SCALE * 0.6) * SIN(B * T / 100)
380 PSET X, Y
390 NEXT T

395 REM Fourth curve: Animated effect with changing phase
400 COLOR 5
410 PRINT "Drawing animated 4:3 ratio (yellow)..."
420 LET A = 4
430 LET B = 3

440 FOR PHASE = 0 TO 157 STEP 31
450 FOR T = 0 TO 628 STEP 4
460 LET X = CX + (SCALE * 0.4) * SIN(A * T / 100 + PHASE / 50)
470 LET Y = CY + (SCALE * 0.4) * SIN(B * T / 100)
480 PSET X, Y
490 NEXT T
500 NEXT PHASE

505 REM Add some decorative elements
510 COLOR 6
520 CIRCLE CX, CY, SCALE + 10
530 COLOR 7
540 CIRCLE CX, CY, 5

545 REM Draw coordinate axes for reference
550 COLOR 8
560 LINE CX - SCALE - 20, CY TO CX + SCALE + 20, CY
570 LINE CX, CY - SCALE - 20 TO CX, CY + SCALE + 20

580 COLOR 1
590 PRINT "Lissajous curves complete!"
600 PRINT "These patterns are created by combining"
610 PRINT "sine waves at different frequencies."

620 INPUT "Press Enter to continue...", DUMMY
630 END
