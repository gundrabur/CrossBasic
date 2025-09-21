1 REM Simple 3D Raytracer - Reflective spheres with checkered floor

10 PRINT "3D Raytracer Demo - Enhanced"
20 PRINT "============================"

30 GRAPHICS
40 CLS

45 REM Higher resolution for better quality
50 LET WIDTH = 320
60 LET HEIGHT = 240
70 LET PIXEL_STEP = 1
75 LET EPS = 0.01

80 REM Sphere 1: Red reflective sphere
90 LET S1X = 0.5
100 LET S1Y = 0
110 LET S1Z = 2.5
120 LET S1R = 0.8

130 REM Sphere 2: Blue reflective sphere  
140 LET S2X = -1.2
150 LET S2Y = 0.5
160 LET S2Z = 1.8
170 LET S2R = 0.6

180 REM Floor plane (y = -1.5) and sky dome (y = 10)
190 LET FLOOR_Y = -1.5
195 LET SKY_Y = 10

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

600 REM Test floor plane (only from above)
610 IF RDY < 0 THEN LET T = (FLOOR_Y - ROY) / RDY
620 IF RDY < 0 AND T > 0.1 AND T < MIN_T THEN MIN_T = T: HIT_TYPE = 3

625 REM Check for horizon/sky (when ray goes up or near horizontal)
626 IF HIT_TYPE = 0 AND RDY >= -0.3 THEN HIT_TYPE = 4

630 REM Calculate final color based on hit
640 IF HIT_TYPE = 1 THEN BASE_COLOR = 2: GOSUB 800
650 IF HIT_TYPE = 2 THEN BASE_COLOR = 5: GOSUB 800  
660 IF HIT_TYPE = 3 THEN COLOR_VAL = BASE_COLOR: GOSUB 900
665 IF HIT_TYPE = 4 OR HIT_TYPE = 0 THEN TEMPY = RDY: GOSUB 2000: COLOR_VAL = SKY_COLOR

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

800 REM Reflection calculation subroutine for spheres
810 LET HX = ROX + RDX * MIN_T
820 LET HY = ROY + RDY * MIN_T
830 LET HZ = ROZ + RDZ * MIN_T

840 REM Calculate surface normal
850 IF HIT_TYPE = 1 THEN NX = (HX - S1X) / S1R: NY = (HY - S1Y) / S1R: NZ = (HZ - S1Z) / S1R
860 IF HIT_TYPE = 2 THEN NX = (HX - S2X) / S2R: NY = (HY - S2Y) / S2R: NZ = (HZ - S2Z) / S2R

870 REM Calculate reflection ray direction
880 LET DOT = RDX * NX + RDY * NY + RDZ * NZ
890 LET RRX = RDX - 2 * DOT * NX
900 LET RRY = RDY - 2 * DOT * NY
910 LET RRZ = RDZ - 2 * DOT * NZ
915 REM Offset reflection ray origin to avoid self-intersection
916 LET R0X = HX + NX * EPS
917 LET R0Y = HY + NY * EPS
918 LET R0Z = HZ + NZ * EPS

920 REM Trace reflection ray (simplified - one bounce)
930 LET REFL_COLOR = 0
940 GOSUB 1100

950 REM Strong reflection for testing - use 90% reflection
960 LET REFL_STRENGTH = 0.9

970 REM If sky/horizon was hit, show it directly (no blending)
980 IF REFL_HIT = 4 THEN COLOR_VAL = REFL_COLOR: RETURN

985 REM Otherwise blend reflection with base color (palette index blend)
990 LET COLOR_VAL = INT(BASE_COLOR * (1 - REFL_STRENGTH) + REFL_COLOR * REFL_STRENGTH)
1000 IF COLOR_VAL > 15 THEN COLOR_VAL = 15
1010 RETURN

900 REM Checkered floor calculation
910 LET HX = ROX + RDX * MIN_T
920 LET HZ = ROZ + RDZ * MIN_T
930 LET CHECKER_X = INT(HX + 10) MOD 2
940 LET CHECKER_Z = INT(HZ + 10) MOD 2
950 IF (CHECKER_X + CHECKER_Z) MOD 2 = 0 THEN BASE_COLOR = 7 ELSE BASE_COLOR = 0
960 LET COLOR_VAL = BASE_COLOR
970 RETURN

1100 REM Trace reflection ray subroutine
1110 REM Input: R0X,R0Y,R0Z (offset origin), RRX,RRY,RRZ (reflection direction)
1120 REM Output: REFL_COLOR
1125 REM Rewritten to use offset origin and proper sky-plane test with horizon tint
1130 LET MIN_RT = 999
1140 LET REFL_HIT = 0

1150 REM Test reflection ray against sphere 1 (skip self-hit by HIT_TYPE check)
1160 LET CX = S1X - R0X
1170 LET CY = S1Y - R0Y
1180 LET CZ = S1Z - R0Z
1190 LET A = 1
1200 LET B = -2 * (CX * RRX + CY * RRY + CZ * RRZ)
1210 LET C = CX * CX + CY * CY + CZ * CZ - S1R * S1R
1220 LET DISC = B * B - 4 * A * C
1230 IF DISC >= 0 THEN LET RT = (-B - SQR(DISC)) / 2
1240 IF DISC >= 0 AND RT > 0.01 AND RT < MIN_RT AND HIT_TYPE <> 1 THEN MIN_RT = RT: REFL_HIT = 1

1250 REM Test reflection ray against sphere 2
1260 LET CX = S2X - R0X
1270 LET CY = S2Y - R0Y
1280 LET CZ = S2Z - R0Z
1290 LET B = -2 * (CX * RRX + CY * RRY + CZ * RRZ)
1300 LET C = CX * CX + CY * CY + CZ * CZ - S2R * S2R
1310 LET DISC = B * B - 4 * A * C
1320 IF DISC >= 0 THEN LET RT = (-B - SQR(DISC)) / 2
1330 IF DISC >= 0 AND RT > 0.01 AND RT < MIN_RT AND HIT_TYPE <> 2 THEN MIN_RT = RT: REFL_HIT = 2

1340 REM Test reflection ray against floor (only when going downward)
1350 IF RRY < 0 THEN LET RT = (FLOOR_Y - R0Y) / RRY
1360 IF RRY < 0 AND RT > 0.01 AND RT < MIN_RT THEN MIN_RT = RT: REFL_HIT = 3

1365 REM Test reflection ray against sky plane (only when going upward)
1366 IF RRY > 0 THEN LET RT = (SKY_Y - R0Y) / RRY
1367 IF RRY > 0 AND RT > 0.01 AND RT < MIN_RT THEN MIN_RT = RT: REFL_HIT = 4

1370 REM Fallback: distant sky if nothing hit
1371 IF REFL_HIT = 0 THEN REFL_HIT = 4

1380 REM Set reflection color based on what was hit
1385 IF REFL_HIT = 1 THEN REFL_COLOR = 2
1390 IF REFL_HIT = 2 THEN REFL_COLOR = 5
1395 IF REFL_HIT = 3 THEN GOSUB 1500
1400 IF REFL_HIT = 4 THEN GOSUB 1600
1410 RETURN

1500 REM Calculate reflected floor color (use offset origin)
1510 LET RHX = R0X + RRX * MIN_RT
1520 LET RHZ = R0Z + RRZ * MIN_RT
1530 LET CHECKER_X = INT(RHX + 10) MOD 2
1540 LET CHECKER_Z = INT(RHZ + 10) MOD 2
1550 IF (CHECKER_X + CHECKER_Z) MOD 2 = 0 THEN REFL_COLOR = 7 ELSE REFL_COLOR = 0
1560 RETURN

1600 REM Sky/horizon color mapping based on reflection direction
1602 LET TEMPY = RRY
1603 GOSUB 2000
1604 LET REFL_COLOR = SKY_COLOR
1605 RETURN

1999 REM Procedural sky/horizon shader used by both primary rays and reflections
2000 REM SKY SHADER: input TEMPY = ray.y, output SKY_COLOR (palette index)
2010 LET V = TEMPY
2020 LET AV = ABS(V)
2030 IF V >= 0 THEN GOTO 2060
2040 REM Slightly below horizon: dark haze
2050 IF AV < 0.05 THEN SKY_COLOR = 8 ELSE SKY_COLOR = 0: RETURN
2060 REM Above horizon: bright band near horizon, then bluish
2070 IF V < 0.03 THEN SKY_COLOR = 15: RETURN
2080 IF V < 0.15 THEN SKY_COLOR = 11: RETURN
2090 SKY_COLOR = 11
2100 RETURN