1 REM Simple 3D Raytracer - Functional version for spheres

10 PRINT "3D Raytracer Demo"
20 PRINT "================="

30 GRAPHICS
40 CLS

45 REM Small resolution for fast calculation
50 LET WIDTH = 100
60 LET HEIGHT = 80
70 LET STEP = 2

80 REM Sphere 1: Red sphere at center
90 LET S1X = 0
100 LET S1Y = 0
110 LET S1Z = 3
120 LET S1R = 1

130 REM Sphere 2: Blue sphere
140 LET S2X = -1.5
150 LET S2Y = -0.5
160 LET S2Z = 2.5
170 LET S2R = 0.7

180 PRINT "Casting rays for 3D spheres..."
190 PRINT "Resolution:"; WIDTH; "x"; HEIGHT

200 FOR Y = 0 TO HEIGHT - 1 STEP STEP
210 FOR X = 0 TO WIDTH - 1 STEP STEP

220 REM Calculate ray direction
230 LET RDX = (2 * X / WIDTH - 1) * 1.33
240 LET RDY = -(2 * Y / HEIGHT - 1)
250 LET RDZ = 1

260 REM Normalize ray
270 LET LEN = SQR(RDX * RDX + RDY * RDY + RDZ * RDZ)
280 LET RDX = RDX / LEN
290 LET RDY = RDY / LEN
300 LET RDZ = RDZ / LEN

310 REM Ray origin
320 LET ROX = 0
330 LET ROY = 0
340 LET ROZ = -3

350 REM Test sphere 1 intersection
360 LET CX = S1X - ROX
370 LET CY = S1Y - ROY
380 LET CZ = S1Z - ROZ
390 LET A = RDX * RDX + RDY * RDY + RDZ * RDZ
400 LET B = -2 * (CX * RDX + CY * RDY + CZ * RDZ)
410 LET C = CX * CX + CY * CY + CZ * CZ - S1R * S1R
420 LET DISC = B * B - 4 * A * C

430 LET COLOR_VAL = 0
440 IF DISC >= 0 THEN LET COLOR_VAL = 2

450 REM Test sphere 2 intersection
460 LET CX = S2X - ROX
470 LET CY = S2Y - ROY
480 LET CZ = S2Z - ROZ
490 LET A = RDX * RDX + RDY * RDY + RDZ * RDZ
500 LET B = -2 * (CX * RDX + CY * RDY + CZ * RDZ)
510 LET C = CX * CX + CY * CY + CZ * CZ - S2R * S2R
520 LET DISC = B * B - 4 * A * C

530 IF DISC >= 0 THEN LET COLOR_VAL = 4

540 REM Set color and draw
550 COLOR COLOR_VAL
560 PSET X, Y

570 NEXT X

580 REM Progress every 10 lines
590 IF Y MOD 10 = 0 THEN PRINT "Line"; Y; "of"; HEIGHT

600 NEXT Y

610 PRINT "Raytracing complete!"
620 PRINT "Red and blue spheres rendered"
630 INPUT "Press Enter to exit...", DUMMY
640 END
