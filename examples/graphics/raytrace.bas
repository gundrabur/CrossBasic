1 REM Simple 3D Raytracer - Reflective spheres with checkered floor

10 PRINT "3D Raytracer Demo - Enhanced"
20 PRINT "============================"

30 GRAPHICS
40 CLS

45 REM Higher resolution for better quality
50 LET WIDTH = 320
60 LET HEIGHT = 240
70 LET PIXEL_STEP = 1

80 REM Sphere 1: Red reflective sphere
90 LET S1X = 0.5
100 LET S1Y = 0
110 LET S1Z = 3
120 LET S1R = 0.8

130 REM Sphere 2: Blue reflective sphere  
140 LET S2X = -1.2
150 LET S2Y = 0.5
160 LET S2Z = 2.2
170 LET S2R = 0.6

180 REM Floor plane (y = -1.5)
190 LET FLOOR_Y = -1.5

200 PRINT "Rendering reflective spheres with checkered floor..."
210 PRINT "Resolution:"; WIDTH; "x"; HEIGHT

220 FOR Y = 0 TO HEIGHT - 1 STEP PIXEL_STEP
230 FOR X = 0 TO WIDTH - 1 STEP PIXEL_STEP

240 REM Calculate primary ray direction
250 LET RDX = (2 * X / WIDTH - 1) * 1.33
260 LET RDY = -(2 * Y / HEIGHT - 1)
270 LET RDZ = 1

280 REM Normalize ray
290 LET LEN = SQR(RDX * RDX + RDY * RDY + RDZ * RDZ)
300 LET RDX = RDX / LEN
310 LET RDY = RDY / LEN
320 LET RDZ = RDZ / LEN

330 REM Ray origin
340 LET ROX = 0
350 LET ROY = 0
360 LET ROZ = -4

370 REM Find closest intersection
380 LET MIN_T = 999
390 LET HIT_TYPE = 0
400 LET COLOR_VAL = 0

410 REM Test sphere 1
420 LET CX = S1X - ROX
430 LET CY = S1Y - ROY
440 LET CZ = S1Z - ROZ
450 LET A = 1
460 LET B = -2 * (CX * RDX + CY * RDY + CZ * RDZ)
470 LET C = CX * CX + CY * CY + CZ * CZ - S1R * S1R
480 LET DISC = B * B - 4 * A * C
490 IF DISC >= 0 THEN LET T = (-B - SQR(DISC)) / 2
500 IF DISC >= 0 AND T > 0.1 AND T < MIN_T THEN MIN_T = T: HIT_TYPE = 1

510 REM Test sphere 2
520 LET CX = S2X - ROX
530 LET CY = S2Y - ROY
540 LET CZ = S2Z - ROZ
550 LET B = -2 * (CX * RDX + CY * RDY + CZ * RDZ)
560 LET C = CX * CX + CY * CY + CZ * CZ - S2R * S2R
570 LET DISC = B * B - 4 * A * C
580 IF DISC >= 0 THEN LET T = (-B - SQR(DISC)) / 2
590 IF DISC >= 0 AND T > 0.1 AND T < MIN_T THEN MIN_T = T: HIT_TYPE = 2

600 REM Test floor plane
610 IF RDY < 0 THEN LET T = (FLOOR_Y - ROY) / RDY
620 IF RDY < 0 AND T > 0.1 AND T < MIN_T THEN MIN_T = T: HIT_TYPE = 3

630 REM Calculate final color based on hit
640 IF HIT_TYPE = 1 THEN COLOR_VAL = 2: GOSUB 800
650 IF HIT_TYPE = 2 THEN COLOR_VAL = 5: GOSUB 800  
660 IF HIT_TYPE = 3 THEN GOSUB 900

670 REM Set pixel color
680 COLOR COLOR_VAL
690 PSET X, Y

700 NEXT X

710 REM Progress indicator
720 IF Y MOD 20 = 0 THEN PRINT "Line"; Y; "of"; HEIGHT

730 NEXT Y

740 PRINT "Raytracing complete!"
750 PRINT "Reflective spheres with checkered floor rendered"
760 INPUT "Press Enter to exit...", DUMMY
770 END

800 REM Reflection calculation subroutine
810 LET HX = ROX + RDX * MIN_T
820 LET HY = ROY + RDY * MIN_T
830 LET HZ = ROZ + RDZ * MIN_T

840 REM Calculate normal and reflection
850 IF HIT_TYPE = 1 THEN NX = (HX - S1X) / S1R: NY = (HY - S1Y) / S1R: NZ = (HZ - S1Z) / S1R
860 IF HIT_TYPE = 2 THEN NX = (HX - S2X) / S2R: NY = (HY - S2Y) / S2R: NZ = (HZ - S2Z) / S2R

870 REM Simple reflection - just add brightness based on angle
880 LET DOT = -(RDX * NX + RDY * NY + RDZ * NZ)
890 IF DOT > 0.5 THEN COLOR_VAL = COLOR_VAL + 2
895 RETURN

900 REM Checkered floor calculation
910 LET HX = ROX + RDX * MIN_T
920 LET HZ = ROZ + RDZ * MIN_T
930 LET CHECKER_X = INT(HX + 10) MOD 2
940 LET CHECKER_Z = INT(HZ + 10) MOD 2
950 IF (CHECKER_X + CHECKER_Z) MOD 2 = 0 THEN COLOR_VAL = 7 ELSE COLOR_VAL = 0
960 RETURN
