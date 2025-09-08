10 REM Unified Color System Demo
20 REM Shows text and graphics using the same 16-color palette
30 PRINT "CrossBasic Unified Color System Demo"
40 PRINT "==================================="
50 PRINT ""
60 PRINT "Testing text colors 0-15:"
70 FOR I = 0 TO 15
80   TEXTCOLOR I
90   PRINT "Color "; I; " - Text sample"
100 NEXT I
110 RESETCOLOR
120 PRINT ""
130 PRINT "Now opening graphics window..."
140 PRINT "Same colors 0-15 will be shown in graphics mode"
150 PRINT ""
160 REM Initialize graphics
170 GRAPHICS
180 REM Draw background
190 COLOR 0
200 RECT 0, 0, 800, 600
210 REM Draw title area
220 COLOR 1
230 RECT 250, 20, 300, 40
240 REM Draw color palette demonstration
250 FOR I = 0 TO 15
260   COLOR I
270   COL = I - (I / 8) * 8
280   ROW = I / 8
290   X = 50 + COL * 90
300   Y = 100 + ROW * 120
290   REM Draw rectangle
300   RECT X, Y, 80, 40
310   REM Draw circle below it
320   CIRCLE X + 40, Y + 70, 20
330 NEXT I
340 REM Draw some decorative elements
350 COLOR 2
360 LINE 50, 350 TO 750, 350
370 COLOR 3
380 LINE 50, 360 TO 750, 360
390 COLOR 4
400 LINE 50, 370 TO 750, 370
410 REM Frame the whole display
420 COLOR 15
430 RECT 10, 10, 780, 580
440 REM Final text message
450 RESETCOLOR
460 PRINT "Graphics window shows the same 16 colors!"
470 PRINT "Press Enter in this window to continue..."
480 INPUT "", DUMMY
490 PRINT ""
500 TEXTCOLOR 10
510 PRINT "Both text and graphics now use the unified"
520 TEXTCOLOR 11
530 PRINT "16-color palette (0-15) for consistency!"
540 RESETCOLOR
550 PRINT ""
560 PRINT "Demo completed successfully!"
570 END
