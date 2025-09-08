1 REM Advanced Lissajous Patterns - Multiple Animated Curves
2 REM This program creates several Lissajous patterns with different parameters
3 REM and demonstrates how frequency ratios affect the curve shapes

10 GRAPHICS
20 CLS
30 COLOR 1

40 PRINT "Advanced Lissajous Pattern Generator"
50 PRINT "==================================="
60 PRINT "Generating multiple animated patterns..."

65 REM Screen setup
70 LET WIDTH = 800
80 LET HEIGHT = 600
90 LET CX = WIDTH / 2
100 LET CY = HEIGHT / 2

105 REM Pattern 1: Classic figure-8 (1:2 ratio)
110 COLOR 2
120 PRINT "Pattern 1: Figure-8 (1:2 ratio)"
130 LET SCALE1 = 80
140 LET X_OFFSET = -200
150 LET Y_OFFSET = -150

160 FOR T = 0 TO 628 STEP 3
170 LET X = CX + X_OFFSET + SCALE1 * SIN(1 * T / 100)
180 LET Y = CY + Y_OFFSET + SCALE1 * SIN(2 * T / 100)
190 PSET X, Y
200 NEXT T

205 REM Pattern 2: Three-leaf rose (3:1 ratio)
210 COLOR 3
220 PRINT "Pattern 2: Three-leaf rose (3:1 ratio)"
230 LET SCALE2 = 80
240 LET X_OFFSET = 200
250 LET Y_OFFSET = -150

260 FOR T = 0 TO 628 STEP 3
270 LET X = CX + X_OFFSET + SCALE2 * SIN(3 * T / 100)
280 LET Y = CY + Y_OFFSET + SCALE2 * SIN(1 * T / 100)
290 PSET X, Y
300 NEXT T

305 REM Pattern 3: Complex knot (5:3 ratio)
310 COLOR 4
320 PRINT "Pattern 3: Complex knot (5:3 ratio)"
330 LET SCALE3 = 80
340 LET X_OFFSET = -200
350 LET Y_OFFSET = 150

360 FOR T = 0 TO 942 STEP 3
370 LET X = CX + X_OFFSET + SCALE3 * SIN(5 * T / 100)
380 LET Y = CY + Y_OFFSET + SCALE3 * SIN(3 * T / 100)
390 PSET X, Y
400 NEXT T

405 REM Pattern 4: Spirograph-like (7:4 ratio with phase)
410 COLOR 5
420 PRINT "Pattern 4: Spirograph-like (7:4 ratio)"
430 LET SCALE4 = 80
440 LET X_OFFSET = 200
450 LET Y_OFFSET = 150
460 LET PHASE = 1.57

470 FOR T = 0 TO 1256 STEP 3
480 LET X = CX + X_OFFSET + SCALE4 * SIN(7 * T / 100 + PHASE)
490 LET Y = CY + Y_OFFSET + SCALE4 * SIN(4 * T / 100)
500 PSET X, Y
510 NEXT T

515 REM Central animated pattern with changing parameters
520 COLOR 6
530 PRINT "Center: Animated morphing pattern"
540 LET BASE_SCALE = 60

545 REM Animation loop with gradually changing frequency ratio
550 FOR ANIM = 0 TO 20
560 LET A_FREQ = 2 + ANIM / 10
570 LET B_FREQ = 3
580 LET CURRENT_SCALE = BASE_SCALE * (1 + ANIM / 40)
590 LET PHASE = ANIM * 31.4 / 100

600 FOR T = 0 TO 628 STEP 8
610 LET X = CX + CURRENT_SCALE * SIN(A_FREQ * T / 100 + PHASE)
620 LET Y = CY + CURRENT_SCALE * SIN(B_FREQ * T / 100)
630 PSET X, Y
640 NEXT T
650 NEXT ANIM

655 REM Add decorative borders and labels
660 COLOR 7
665 REM Top-left frame
670 RECT CX - 240, CY - 190, 160, 160
675 REM Top-right frame
680 RECT CX + 80, CY - 190, 160, 160
685 REM Bottom-left frame
690 RECT CX - 240, CY + 30, 160, 160
695 REM Bottom-right frame
700 RECT CX + 80, CY + 30, 160, 160

705 REM Central circle
710 COLOR 8
720 CIRCLE CX, CY, BASE_SCALE + 20

725 REM Add coordinate reference lines
730 COLOR 9
740 LINE 0, CY TO WIDTH, CY
750 LINE CX, 0 TO CX, HEIGHT

760 COLOR 1
810 PRINT "Lissajous pattern gallery complete!"
820 PRINT "Each pattern shows different frequency ratios:"
830 PRINT "- Figure-8: Simple 1:2 harmonic"
840 PRINT "- Three-leaf: 3:1 complex oscillation"
850 PRINT "- Knot: 5:3 intricate weaving"
860 PRINT "- Spirograph: 7:4 with phase shift"
870 PRINT "- Center: Animated morphing pattern"

880 INPUT "Press Enter to exit...", DUMMY
890 END
