1 REM Simple Lissajous Curves - Interactive Demo
2 REM This program demonstrates the basic concept of Lissajous curves
3 REM with clear visual separation and step-by-step drawing

10 GRAPHICS
20 CLS
30 COLOR 1

40 PRINT "Simple Lissajous Curves Demo"
50 PRINT "============================="
60 PRINT ""
70 PRINT "A Lissajous curve is created by plotting:"
80 PRINT "X = sin(A * t)"
90 PRINT "Y = sin(B * t)"
100 PRINT "where A and B are frequency multipliers"
110 PRINT ""

115 REM Set up the drawing area
120 LET CENTER_X = 400
130 LET CENTER_Y = 300
140 LET RADIUS = 120

145 REM Draw the first simple curve: 1:1 ratio (circle)
150 COLOR 2
160 PRINT "Drawing 1:1 ratio (circle)..."
170 FOR T = 0 TO 628 STEP 4
180 LET X = CENTER_X + RADIUS * SIN(T / 100)
190 LET Y = CENTER_Y + RADIUS * SIN(T / 100)
200 PSET X, Y
210 NEXT T

220 INPUT "Press Enter for next pattern...", DUMMY
230 CLS

235 REM Draw the second curve: 1:2 ratio (figure-8)
240 COLOR 3
250 PRINT "Drawing 1:2 ratio (figure-8)..."
260 FOR T = 0 TO 628 STEP 3
270 LET X = CENTER_X + RADIUS * SIN(1 * T / 100)
280 LET Y = CENTER_Y + RADIUS * SIN(2 * T / 100)
290 PSET X, Y
300 NEXT T

310 INPUT "Press Enter for next pattern...", DUMMY
320 CLS

325 REM Draw the third curve: 2:3 ratio
330 COLOR 4
340 PRINT "Drawing 2:3 ratio (complex loop)..."
350 FOR T = 0 TO 942 STEP 3
360 LET X = CENTER_X + RADIUS * SIN(2 * T / 100)
370 LET Y = CENTER_Y + RADIUS * SIN(3 * T / 100)
380 PSET X, Y
390 NEXT T

400 INPUT "Press Enter for next pattern...", DUMMY
410 CLS

415 REM Draw the fourth curve: 3:4 ratio
420 COLOR 5
430 PRINT "Drawing 3:4 ratio (intricate pattern)..."
440 FOR T = 0 TO 1256 STEP 3
450 LET X = CENTER_X + RADIUS * SIN(3 * T / 100)
460 LET Y = CENTER_Y + RADIUS * SIN(4 * T / 100)
470 PSET X, Y
480 NEXT T

490 INPUT "Press Enter for final comparison...", DUMMY

495 REM Show all patterns together in smaller size
500 CLS
510 COLOR 1
520 PRINT "All Lissajous patterns together:"

525 REM Small scale factor for comparison view
530 LET SMALL_RADIUS = 60

535 REM Pattern positions
540 LET POS1_X = 200
550 LET POS1_Y = 200
560 LET POS2_X = 600
570 LET POS2_Y = 200
580 LET POS3_X = 200
590 LET POS3_Y = 450
600 LET POS4_X = 600
610 LET POS4_Y = 450

615 REM Draw all four patterns
620 COLOR 2
630 FOR T = 0 TO 628 STEP 6
640 LET X = POS1_X + SMALL_RADIUS * SIN(T / 100)
650 LET Y = POS1_Y + SMALL_RADIUS * SIN(T / 100)
660 PSET X, Y
670 NEXT T

680 COLOR 3
690 FOR T = 0 TO 628 STEP 6
700 LET X = POS2_X + SMALL_RADIUS * SIN(1 * T / 100)
710 LET Y = POS2_Y + SMALL_RADIUS * SIN(2 * T / 100)
720 PSET X, Y
730 NEXT T

740 COLOR 4
750 FOR T = 0 TO 942 STEP 6
760 LET X = POS3_X + SMALL_RADIUS * SIN(2 * T / 100)
770 LET Y = POS3_Y + SMALL_RADIUS * SIN(3 * T / 100)
780 PSET X, Y
790 NEXT T

800 COLOR 5
810 FOR T = 0 TO 1256 STEP 6
820 LET X = POS4_X + SMALL_RADIUS * SIN(3 * T / 100)
830 LET Y = POS4_Y + SMALL_RADIUS * SIN(4 * T / 100)
840 PSET X, Y
850 NEXT T

855 REM Add labels
860 COLOR 1
870 PRINT "1:1 (circle)     1:2 (figure-8)"
880 PRINT ""
890 PRINT ""
900 PRINT ""
910 PRINT ""
920 PRINT ""
930 PRINT ""
940 PRINT ""
950 PRINT ""
960 PRINT "2:3 (complex)    3:4 (intricate)"

970 INPUT "Press Enter to exit...", DUMMY
980 END
