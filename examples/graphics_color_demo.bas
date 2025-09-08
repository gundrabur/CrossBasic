10 REM Graphics Color Demo - All 16 Colors
20 REM Shows the complete 16-color palette in graphics mode
30 GRAPHICS
40 REM Clear screen with black background
50 COLOR 0
60 RECT 0, 0, 800, 600
70 REM Draw title in white
80 COLOR 1
90 REM Simple title (no text in graphics mode, use rectangles)
100 RECT 300, 50, 200, 20
110 REM Draw color palette grid
120 FOR ROW = 0 TO 3
130   FOR COL = 0 TO 3
140     COLORNUM = ROW * 4 + COL
150     COLOR COLORNUM
160     X = 200 + COL * 100
170     Y = 150 + ROW * 100
180     REM Draw colored rectangle
190     RECT X, Y, 80, 80
200     REM Draw color number indicator (small squares)
210     COLOR 1
220     IF COLORNUM >= 10 THEN GOTO 250
230     REM Single digit - one square
240     RECT X + 5, Y + 5, 8, 8
250     IF COLORNUM < 10 THEN GOTO 280
260     REM Two digits - two squares  
270     RECT X + 5, Y + 5, 8, 8: RECT X + 15, Y + 5, 8, 8
280   NEXT COL
290 NEXT ROW
300 REM Draw some demonstration shapes with different colors
310 COLOR 2
320 CIRCLE 100, 400, 50
330 COLOR 3
340 CIRCLE 200, 400, 50
350 COLOR 4
360 CIRCLE 300, 400, 50
370 COLOR 5
380 LINE 400, 350 TO 500, 450
390 COLOR 6
400 LINE 400, 450 TO 500, 350
410 COLOR 7
420 RECT 550, 375, 100, 50
430 REM Draw border around everything
440 COLOR 15
450 LINE 0, 0 TO 799, 0
460 LINE 799, 0 TO 799, 599
470 LINE 799, 599 TO 0, 599
480 LINE 0, 599 TO 0, 0
490 END
