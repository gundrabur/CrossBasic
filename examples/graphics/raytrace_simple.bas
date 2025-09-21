1 REM Simple 3D Raytracer Demo
2 REM Renders spheres using basic raytracing
3 REM A visual demonstration of 3D graphics

10 GRAPHICS
20 CLS
30 COLOR 1

40 PRINT "3D Raytracer Demo"
50 PRINT "=================="
60 PRINT "Rendering spheres..."

70 REM Screen size
80 LET SW = 800
90 LET SH = 600

100 REM Camera position
110 LET CAMZ = -3

120 REM Sphere properties
130 LET S1X = 0
140 LET S1Y = 0  
150 LET S1Z = 2
160 LET S1R = 1

170 LET S2X = -1.5
180 LET S2Y = -0.5
190 LET S2Z = 1.5
200 LET S2R = 0.7

210 LET S3X = 1
220 LET S3Y = 0.5
230 LET S3Z = 3
240 LET S3R = 0.8

250 PRINT "Casting rays and rendering..."

260 FOR Y = 0 TO SH - 1 STEP 8
270 FOR X = 0 TO SW - 1 STEP 8

280 REM Calculate ray direction  
290 LET RDX = (2 * X / SW - 1) * 1.33
300 LET RDY = -(2 * Y / SH - 1)
310 LET RDZ = 1

320 REM Normalize (simplified)
330 LET LEN = SQR(RDX * RDX + RDY * RDY + RDZ * RDZ)
340 LET RDX = RDX / LEN
350 LET RDY = RDY / LEN
360 LET RDZ = RDZ / LEN

370 REM Ray origin
380 LET ROX = 0
390 LET ROY = 0
400 LET ROZ = CAMZ

410 REM Test sphere 1 (red)
420 LET CX = S1X - ROX
430 LET CY = S1Y - ROY
440 LET CZ = S1Z - ROZ
450 LET A = RDX * RDX + RDY * RDY + RDZ * RDZ
460 LET B = -2 * (CX * RDX + CY * RDY + CZ * RDZ)
470 LET C = CX * CX + CY * CY + CZ * CZ - S1R * S1R
480 LET DISC = B * B - 4 * A * C

490 LET HIT = 0
500 IF DISC >= 0 THEN LET HIT = 1
510 IF HIT = 1 THEN COLOR 2
520 IF HIT = 1 THEN PSET X, Y
530 IF HIT = 1 THEN GOTO 740

540 REM Test sphere 2 (blue)
550 LET CX = S2X - ROX
560 LET CY = S2Y - ROY
570 LET CZ = S2Z - ROZ
580 LET A = RDX * RDX + RDY * RDY + RDZ * RDZ
590 LET B = -2 * (CX * RDX + CY * RDY + CZ * RDZ)
600 LET C = CX * CX + CY * CY + CZ * CZ - S2R * S2R
610 LET DISC = B * B - 4 * A * C

620 LET HIT = 0
630 IF DISC >= 0 THEN LET HIT = 1
640 IF HIT = 1 THEN COLOR 4
650 IF HIT = 1 THEN PSET X, Y
660 IF HIT = 1 THEN GOTO 740

670 REM Test sphere 3 (green)
680 LET CX = S3X - ROX
690 LET CY = S3Y - ROY
700 LET CZ = S3Z - ROZ
710 LET A = RDX * RDX + RDY * RDY + RDZ * RDZ
720 LET B = -2 * (CX * RDX + CY * RDY + CZ * RDZ)
730 LET C = CX * CX + CY * CY + CZ * CZ - S3R * S3R
735 LET DISC = B * B - 4 * A * C

737 LET HIT = 0
738 IF DISC >= 0 THEN LET HIT = 1
739 IF HIT = 1 THEN COLOR 3
740 IF HIT = 1 THEN PSET X, Y

750 NEXT X

760 REM Progress indicator
770 IF Y MOD 80 = 0 THEN PRINT "Row "; Y; " complete..."

780 NEXT Y

790 COLOR 1
800 PRINT "Raytracing complete!"
810 PRINT "Scene shows 3 spheres:"
820 PRINT "- Red sphere (center)"
830 PRINT "- Blue sphere (left)"
840 PRINT "- Green sphere (right)"

850 INPUT "Press Enter to continue...", DUMMY
860 END