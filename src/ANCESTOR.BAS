  100 REM ANCESTOR Program.
  110 REM Prints Charts of Ancestors
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Charts of Ancestors"
  620 TITLE$ = TITLE$ + " ON DISPLAY"
  700 REM Terminate if not called from the Menu
  710 IF COPY2$ = "Melvin O. Duke" THEN 770
  720 COLOR 7,0 : KEY ON : CLS : LOCATE 15,1
  730 PRINT "Cannot run the"
  740 PRINT TITLE$
  750 PRINT "Program, unless selected from the MENU"
  760 END
  770 REM OK
  900 REM Dimension Statements
  940 DIM PERS(31), FORM$(49)
 1000 REM Produce the first screen
 1010 KEY ON : CLS : KEY OFF
 1020 REM Find the title location
 1030 TITLE.POS = 40 - INT(LEN(TITLE$)/2)
 1040 REM Print the title
 1050 LOCATE 4,TITLE.POS : PRINT TITLE$
 1060 LOCATE 5,40-INT(LEN(VERSION$)/2) :  PRINT VERSION$;
 1070 REM Print the Copyright
 1080 LOCATE 20,40-INT(LEN(COPY1$)/2) :  PRINT COPY1$;
 1090 LOCATE 21,40-INT(LEN(COPY2$)/2) :  PRINT COPY2$;
 1700 REM Display the Copyright
 1710 '
 1720 LOCATE 25,1
 1730 PRINT DATADISK$;
 1740 K$ = INKEY$ : IF K$ = "" THEN 1740
 1750 KEY ON : CLS : KEY OFF
 2000 REM ANCESTOR Program Starts Here.
 2010 REM Prevent Common User Errors
 2020 IF PP.FORMS = 1 THEN GENS = 5
 2030 IF GENS <> 5 THEN GENS = 4
 2040 REM Routine to obtain Printer Information
 2050 LOCATE 21,1 : PRINT "Make sure that the Printer is on and Ready"
 2060 LOCATE 22,1 : PRINT "Make sure that the correct Diskette(s) are in place."
 2070 LOCATE 23,1 : PRINT "Then press any key"
 2080 A$ = INKEY$ : IF A$ = "" THEN 2080
 2090 KEY ON : CLS : KEY OFF
 2100 REM Set for Wide Printing
 2110 WIDTH "lpt1:", 132  'For printing Genealogy Forms
 2120 REM Read the Marriage Index
 2130 LOCATE 7,1 : PRINT "Open the Marriage Index"
 2140 OPEN CC.MINDEX$ FOR INPUT AS #2
 2150 INPUT #2, M.COUNT
 2160 IF M.COUNT <> 0 THEN 2210
 2170 PRINT "Marriage Index has no Index Records"
 2180 PRINT "Press any key to return to the Menu"
 2190 A$ = INKEY$ : IF A$ = "" THEN 2190
 2200 GOTO 7680
 2210 DIM PERS.NO(M.COUNT), M.NO(M.COUNT)
 2220 FOR I = 1 TO M.COUNT
 2230 LOCATE 8,1 : PRINT "Reading Marriage Index Record #:";I:
 2240  INPUT #2,PERS.NO(I), M.NO(I)
 2250 NEXT I
 2260 CLOSE #2
 2270 REM Open the Persons File
 2280 LOCATE 10,1 : PRINT "Open the Persons File"
 2290 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2300 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2310 REM open the Marriages File
 2320 LOCATE 12,1 : PRINT "Open the Marriage File"
 2330 OPEN CC.MARRFILE$ AS #2 LEN = 128
 2340 FIELD 2, 5 AS M1$, 5 AS M2$, 5 AS M3$, 5 AS M4$, 11 AS M5$, 18 AS M6$, 16 AS M7$, 16 AS M8$, 45 AS M9$
 2350 REM Obtain a Person Record from the User
 2360 LOCATE 20,1 : INPUT "Enter the Record-number of a Person (0 to quit)";REPLY$
 2370 IF REPLY$ = "0" THEN 7680
 2380 PERS(1) = VAL(REPLY$)
 2390 IF PERS(1) < 1 OR PERS(1) > MAX.PER THEN KEY ON : CLS : LOCATE 19,1 : PRINT "Number is out of range"; : KEY OFF : GOTO 2350
 2400 REM Reset the Printer characteristics for next page if required.
 2410 IF FORMS = 1 THEN 2450  'Don't stop if forms are continuous
 2420 REM process single sheets
 2430 PRINT "Press any key when next form is ready"
 2440 A$ = INKEY$ : IF A$ = "" THEN 2440
 2450 REM Reset paper sensing if required
 2460 IF FORMS = 2 THEN LPRINT PAP.SEN.OFF$;
 2470 REM Reset paper length if required
 2480 IF LENGTH = 1 THEN LPRINT PAP.SHORT$;
 2490 REM Reset Condensed printing if required
 2500 IF WIDE = 1 THEN LPRINT COMPR.ON$;
 2510 KEY ON : CLS : KEY OFF
 2520 GOTO 3160
 2530 REM Routine to Extract Personal Information
 2540 T1! = CVS(F1$) : T1 = T1!
 2550 TEMP1$ = F2$ : TEMP2$ = F2$ : GOSUB 2720  'Rtrim
 2560 T2$ = TEMP2$
 2570 TEMP1$ = F3$ : TEMP2$ = F3$ : GOSUB 2720  'Rtrim
 2580 T3$ = TEMP2$
 2590 T6! = CVS(F6$) : T6 = T6!
 2600 T7! = CVS(F7$) : T7 = T7!
 2610 T8$ = F8$
 2620 TEMP1$ = F9$ : TEMP2$ = F9$ : GOSUB 2720  'Rtrim
 2630 T9$ = TEMP2$
 2640 TEMP1$ = F11$ : TEMP2$ = F11$ : GOSUB 2720  'Rtrim
 2650 T11$ = TEMP2$
 2660 T12$ = F12$
 2670 TEMP1$ = F13$ : TEMP2$ = F13$ : GOSUB 2720  'Rtrim
 2680 T13$ = TEMP2$
 2690 TEMP1$ = F15$ : TEMP2$ = F15$ : GOSUB 2720  'Rtrim
 2700 T15$ = TEMP2$
 2710 RETURN
 2720 REM General RTRIM$ Routine
 2730 FOR J = 1 TO LEN(TEMP1$)-1
 2740  IF RIGHT$(TEMP2$,1) = " " THEN TEMP2$ = LEFT$(TEMP2$,LEN(TEMP2$)-1) :ELSE J = LEN(TEMP1$)-1
 2750 NEXT J
 2760 RETURN
 2770 REM Blank out a Person Record
 2780 T1 = 0
 2790 T2$ = ""
 2800 T3$ = ""
 2810 T4$ = ""
 2820 T5 = 0
 2830 T6 = 0
 2840 T7 = 0
 2850 T8$ = ""
 2860 T9$ = ""
 2870 T10$ = ""
 2880 T11$ = ""
 2890 T12$ = ""
 2900 T13$ = ""
 2910 T14$ = ""
 2920 T15$ = ""
 2930 T16$ = ""
 2940 T17$ = ""
 2950 T18$ = ""
 2960 T19$ = ""
 2970 RETURN
 2980 REM Routine to extract a name
 2990 NM$ = T2$+", "+T3$
 3000 IF COL = 24 THEN NM$ = LEFT$(NM$,48)
 3010 IF COL > 24 THEN NM$ = LEFT$(NM$,23)
 3020 MID$(FORM$(ROW),COL,LEN(NM$))=NM$
 3030 RETURN
 3040 REM Routine to extract a birth-location
 3050 BL$=T9$+", "+T11$
 3060 IF COL = 27 THEN BL$ = LEFT$(BL$,46)
 3070 IF COL > 27 THEN BL$ = LEFT$(BL$,20)
 3080 MID$(FORM$(ROW),COL,LEN(BL$))=BL$
 3090 RETURN
 3100 REM Routine to extract a death-location
 3110 DL$ = T13$+", "+T15$
 3120 IF COL = 27 THEN DL$ = LEFT$(DL$,46)
 3130 IF COL > 27 THEN DL$ = LEFT$(DL$,20)
 3140 MID$(FORM$(ROW),COL,LEN(DL$))=DL$
 3150 RETURN
 3160 REM Routine to Produce a Chart of Ancestors
 3170 REM Test if already formed
 3180 IF PERS(1) = LAST.PERS THEN 7570
 3190 REM Start with all Spaces
 3200 FOR I = 1 TO 49
 3210  FORM$(I) = SPACE$(131)
 3220 NEXT I
 3230 IF PP.FORMS = 1 THEN 3240 :ELSE GOSUB 7770
 3240 REM get 1
 3250 LOCATE 20,1 : PRINT "Processing Person # 1 on the Chart"
 3260 IF PERS(1) = 0 THEN GOSUB 2770 : GOTO 3530
 3270 GET #1, PERS(1) : GOSUB 2530  'Extract 1
 3280 ROW = 22: COL = 1: GOSUB 9660  'for Person Number
 3290 MID$(FORM$(22),1,PLEN) = PNUM$
 3300 IF T2$ = " " AND T3$ = " " THEN 3470
 3310 ROW=23: COL=1: GOSUB 2980
 3320 REM Insert Preparer's Name and Address
 3330 IF PP.FORMS = 1 THEN 3340 :ELSE 3460
 3340 MID$(FORM$(3),1,LEN(PREP1$)) = PREP1$
 3350 MID$(FORM$(5),1,LEN(PREP2$)) = PREP2$
 3360 MID$(FORM$(7),1,LEN(PREP3$)) = PREP3$
 3370 MID$(FORM$(9),1,LEN(PREP4$)) = PREP4$
 3380 MID$(FORM$(42),1,15) = "Person Record: "
 3390 P.NO$ = STR$(PERS(1))
 3400 P.NO$ = RIGHT$(P.NO$,LEN(P.NO$)-1)
 3410 MID$(FORM$(42),16,LEN(P.NO$)) = P.NO$
 3420 MID$(FORM$(43),1,23) = "Prepared on "+DATE$
 3430 MID$(FORM$(43),23,12) = " at "+TIME$
 3440 MID$(FORM$(44),1,42) = "Using Version 6.0 of Genealogy ON DISPLAY."
 3450 GOTO 3470
 3460 MID$(FORM$(1),23,LEN(T2$+T3$)+1) = T3$+" "+T2$
 3470 MID$(FORM$(24),3,11) = T8$
 3480 IF T9$ = " " AND T11$ = " " THEN 3500
 3490 ROW=25: COL=3: GOSUB 3040
 3500 MID$(FORM$(27),3,11) = T12$
 3510 IF T13$ = " " AND T15$ = " " THEN 3530
 3520 ROW=28: COL=3: GOSUB 3100
 3530 PERS(2) = T6
 3540 PERS(3) = T7
 3550 REM get 11
 3560 LOCATE 20,20: PRINT " 2";
 3570 IF PERS(2) = 0 THEN GOSUB 2770 : GOTO 3680
 3580 GET #1, PERS(2) : GOSUB 2530  'Extract 11
 3590 ROW=12: COL=24: GOSUB 9660  'for Person Number
 3600 IF T2$ = " " AND T3$ = " " THEN 3620
 3610 GOSUB 2980
 3620 MID$(FORM$(13),27,11) = T8$
 3630 IF T9$ = " " AND T11$ = " " THEN 3650
 3640 ROW=14: COL=27: GOSUB 3040
 3650 MID$(FORM$(16),27,11) = T12$
 3660 IF T13$ = " " AND T15$ = " " THEN 3680
 3670 ROW=17: COL=27: GOSUB 3100
 3680 PERS(4) = T6
 3690 PERS(5) = T7
 3700 REM get 10
 3710 LOCATE 20,20: PRINT " 3";
 3720 IF PERS(3) = 0 THEN GOSUB 2770 : GOTO 3830
 3730 GET #1, PERS(3) : GOSUB 2530  'Extract 10
 3740 ROW=36: COL=24: GOSUB 9660  'for Person Number
 3750 IF T2$ = " " AND T3$ = " " THEN 3770
 3760 GOSUB 2980
 3770 MID$(FORM$(37),27,11) = T8$
 3780 IF T9$ = " " AND T11$ = " " THEN 3800
 3790 ROW=38: COL=27: GOSUB 3040
 3800 MID$(FORM$(39),27,11) = T12$
 3810 IF T13$ = " " AND T15$ = " " THEN 3830
 3820 ROW=40: COL=27: GOSUB 3100
 3830 PERS(6) = T6
 3840 PERS(7) = T7
 3850 REM get 111
 3860 LOCATE 20,20: PRINT " 4";
 3870 IF PERS(4) = 0 THEN GOSUB 2770 : GOTO 3980
 3880 GET #1, PERS(4) : GOSUB 2530  'Extract 111
 3890 ROW=6: COL=49: GOSUB 9660  'for Person Number
 3900 IF T2$ = " " AND T3$ = " " THEN 3920
 3910 GOSUB 2980
 3920 MID$(FORM$(7),52,11) = T8$
 3930 IF T9$ = " " AND T11$ = " " THEN 3950
 3940 ROW=8: COL=52: GOSUB 3040
 3950 MID$(FORM$(10),52,11) = T12$
 3960 IF T13$ = " " AND T15$ = " " THEN 3980
 3970 ROW=11: COL=52: GOSUB 3100
 3980 PERS(8) = T6
 3990 PERS(9) = T7
 4000 REM get 110
 4010 LOCATE 20,20: PRINT " 5";
 4020 IF PERS(5) = 0 THEN GOSUB 2770 : GOTO 4130
 4030 GET #1, PERS(5) : GOSUB 2530  'Extract 110
 4040 ROW=18: COL=49: GOSUB 9660  'for Person Number
 4050 IF T2$ = " " AND T3$ = " " THEN 4070
 4060 GOSUB 2980
 4070 MID$(FORM$(19),52,11) = T8$
 4080 IF T9$ = " " AND T11$ = " " THEN 4100
 4090 ROW=20: COL=52: GOSUB 3040
 4100 MID$(FORM$(21),52,11) = T12$
 4110 IF T13$ = " " AND T15$ = " " THEN 4130
 4120 ROW=22: COL=52: GOSUB 3100
 4130 PERS(10) = T6
 4140 PERS(11) = T7
 4150 REM get 101
 4160 LOCATE 20,20: PRINT " 6";
 4170 IF PERS(6) = 0 THEN GOSUB 2770 : GOTO 4280
 4180 GET #1, PERS(6) : GOSUB 2530  'Extract 101
 4190 ROW=30: COL=49: GOSUB 9660  'for Person Number
 4200 IF T2$ = " " AND T3$ = " " THEN 4220
 4210 GOSUB 2980
 4220 MID$(FORM$(31),52,11) = T8$
 4230 IF T9$ = " " AND T11$ = " " THEN 4250
 4240 ROW=32: COL=52: GOSUB 3040
 4250 MID$(FORM$(34),52,11) = T12$
 4260 IF T13$ = " " AND T15$ = " " THEN 4280
 4270 ROW=35: COL=52: GOSUB 3100
 4280 PERS(12) = T6
 4290 PERS(13) = T7
 4300 REM get 100
 4310 LOCATE 20,20: PRINT " 7";
 4320 IF PERS(7) = 0 THEN GOSUB 2770 : GOTO 4430
 4330 GET #1, PERS(7) : GOSUB 2530  'Extract 100
 4340 ROW=42: COL=49: GOSUB 9660  'for Person Number
 4350 IF T2$ = " " AND T3$ = " " THEN 4370
 4360 GOSUB 2980
 4370 MID$(FORM$(43),52,11) = T8$
 4380 IF T9$ = " " AND T11$ = " " THEN 4400
 4390 ROW=44: COL=52: GOSUB 3040
 4400 MID$(FORM$(45),52,11) = T12$
 4410 IF T13$ = " " AND T15$ = " " THEN 4430
 4420 ROW=46: COL=52: GOSUB 3100
 4430 PERS(14) = T6
 4440 PERS(15) = T7
 4450 REM get 1111
 4460 LOCATE 20,20: PRINT " 8";
 4470 IF PERS(8) = 0 THEN GOSUB 2770 : GOTO 4580
 4480 GET #1, PERS(8) : GOSUB 2530  'Extract 1111
 4490 ROW=3: COL=74: GOSUB 9660  'for Person Number
 4500 IF T2$ = " " AND T3$ = " " THEN 4520
 4510 GOSUB 2980
 4520 MID$(FORM$(4),77,11) = T8$
 4530 IF T9$ = " " AND T11$ = " " THEN 4550
 4540 ROW=5: COL=77: GOSUB 3040
 4550 MID$(FORM$(7),77,11) = T12$
 4560 IF T13$ = " " AND T15$ = " " THEN 4580
 4570 ROW=8: COL=77: GOSUB 3100
 4580 PERS(16) = T6
 4590 PERS(17) = T7
 4600 REM get 1110
 4610 LOCATE 20,20: PRINT " 9";
 4620 IF PERS(9) = 0 THEN GOSUB 2770 : GOTO 4730
 4630 GET #1, PERS(9) : GOSUB 2530  'Extract 1110
 4640 ROW=9: COL=74: GOSUB 9660  'for Person Number
 4650 IF T2$ = " " AND T3$ = " " THEN 4670
 4660 GOSUB 2980
 4670 MID$(FORM$(10),77,11) = T8$
 4680 IF T9$ = " " AND T11$ = " " THEN 4700
 4690 ROW=11: COL=77: GOSUB 3040
 4700 MID$(FORM$(12),77,11) = T12$
 4710 IF T13$ = " " AND T15$ = " " THEN 4730
 4720 ROW=13: COL=77: GOSUB 3100
 4730 PERS(18) = T6
 4740 PERS(19) = T7
 4750 REM get 1101
 4760 LOCATE 20,20: PRINT "10";
 4770 IF PERS(10) = 0 THEN GOSUB 2770 : GOTO 4880
 4780 GET #1, PERS(10) : GOSUB 2530  'Extract 1101
 4790 ROW=15: COL=74: GOSUB 9660  'for Person Number
 4800 IF T2$ = " " AND T3$ = " " THEN 4820
 4810 GOSUB 2980
 4820 MID$(FORM$(16),77,11) = T8$
 4830 IF T9$ = " " AND T11$ = " " THEN 4850
 4840 ROW=17: COL=77: GOSUB 3040
 4850 MID$(FORM$(19),77,11) = T12$
 4860 IF T13$ = " " AND T15$ = " " THEN 4880
 4870 ROW=20: COL=77: GOSUB 3100
 4880 PERS(20) = T6
 4890 PERS(21) = T7
 4900 REM get 1100
 4910 LOCATE 20,20: PRINT "11";
 4920 IF PERS(11) = 0 THEN GOSUB 2770 : GOTO 5030
 4930 GET #1, PERS(11) : GOSUB 2530  'Extract 1100
 4940 ROW=21: COL=74: GOSUB 9660  'for Person Number
 4950 IF T2$ = " " AND T3$ = " " THEN 4970
 4960 GOSUB 2980
 4970 MID$(FORM$(22),77,11) = T8$
 4980 IF T9$ = " " AND T11$ = " " THEN 5000
 4990 ROW=23: COL=77: GOSUB 3040
 5000 MID$(FORM$(24),77,11) = T12$
 5010 IF T13$ = " " AND T15$ = " " THEN 5030
 5020 ROW=25: COL=77: GOSUB 3100
 5030 PERS(22) = T6
 5040 PERS(23) = T7
 5050 REM get 1011
 5060 LOCATE 20,20: PRINT "12";
 5070 IF PERS(12) = 0 THEN GOSUB 2770 : GOTO 5180
 5080 GET #1, PERS(12) : GOSUB 2530  'Extract 1010
 5090 ROW=27: COL=74: GOSUB 9660  'for Person Number
 5100 IF T2$ = " " AND T3$ = " " THEN 5120
 5110 GOSUB 2980
 5120 MID$(FORM$(28),77,11) = T8$
 5130 IF T9$ = " " AND T11$ = " " THEN 5150
 5140 ROW=29: COL=77: GOSUB 3040
 5150 MID$(FORM$(31),77,11) = T12$
 5160 IF T13$ = " " AND T15$ = " " THEN 5180
 5170 ROW=32: COL=77: GOSUB 3100
 5180 PERS(24) = T6
 5190 PERS(25) = T7
 5200 REM get 1010
 5210 LOCATE 20,20: PRINT "13";
 5220 IF PERS(13) = 0 THEN GOSUB 2770 : GOTO 5330
 5230 GET #1, PERS(13) : GOSUB 2530  'Extract 1010
 5240 ROW=33: COL=74: GOSUB 9660  'for Person Number
 5250 IF T2$ = " " AND T3$ = " " THEN 5270
 5260 GOSUB 2980
 5270 MID$(FORM$(34),77,11) = T8$
 5280 IF T9$ = " " AND T11$ = " " THEN 5300
 5290 ROW=35: COL=77: GOSUB 3040
 5300 MID$(FORM$(36),77,11) = T12$
 5310 IF T13$ = " " AND T15$ = " " THEN 5330
 5320 ROW=37: COL=77: GOSUB 3100
 5330 PERS(26) = T6
 5340 PERS(27) = T7
 5350 REM get 1001
 5360 LOCATE 20,20: PRINT "14";
 5370 IF PERS(14) = 0 THEN GOSUB 2770 : GOTO 5480
 5380 GET #1, PERS(14) : GOSUB 2530  'Extract 1001
 5390 ROW=39: COL=74: GOSUB 9660  'for Person Number
 5400 IF T2$ = " " AND T3$ = " " THEN 5420
 5410 GOSUB 2980
 5420 MID$(FORM$(40),77,11) = T8$
 5430 IF T9$ = " " AND T11$ = " " THEN 5450
 5440 ROW=41: COL=77: GOSUB 3040
 5450 MID$(FORM$(43),77,11) = T12$
 5460 IF T13$ = " " AND T15$ = " " THEN 5480
 5470 ROW=44: COL=77: GOSUB 3100
 5480 PERS(28) = T6
 5490 PERS(29) = T7
 5500 REM get 1001
 5510 LOCATE 20,20: PRINT "15";
 5520 IF PERS(15) = 0 THEN GOSUB 2770 : GOTO 5630
 5530 GET #1, PERS(15) : GOSUB 2530  'Extract 1000
 5540 ROW=45: COL=74: GOSUB 9660  'for Person Number
 5550 IF T2$ = " " AND T3$ = " " THEN 5570
 5560 GOSUB 2980
 5570 MID$(FORM$(46),77,11) = T8$
 5580 IF T9$ = " " AND T11$ = " " THEN 5600
 5590 ROW=47: COL=77: GOSUB 3040
 5600 MID$(FORM$(48),77,11) = T12$
 5610 IF T13$ = " " AND T15$ = " " THEN 5630
 5620 ROW=49: COL=77: GOSUB 3100
 5630 PERS(30) = T6
 5640 PERS(31) = T7
 5650 IF GENS <> 5 THEN 6730
 5660 REM get 11111
 5670 LOCATE 20,20: PRINT "16";
 5680 IF PERS(16) = 0 THEN GOSUB 2770 : GOTO 5720
 5690 GET #1, PERS(16) : GOSUB 2530  'Extract 11111
 5700 ROW=1: COL=98: GOSUB 9660  'for Person Number
 5710 GOSUB 2980
 5720 REM get 11110
 5730 LOCATE 20,20: PRINT "17";
 5740 IF PERS(17) = 0 THEN GOSUB 2770 : GOTO 5780
 5750 GET #1, PERS(17) : GOSUB 2530  'Extract 11110
 5760 ROW=4: COL=98: GOSUB 9660  'for Person Number
 5770 GOSUB 2980
 5780 REM get 11101
 5790 LOCATE 20,20: PRINT "18";
 5800 IF PERS(18) = 0 THEN GOSUB 2770 : GOTO 5840
 5810 GET #1, PERS(18) : GOSUB 2530  'Extract 11101
 5820 ROW=7: COL=98: GOSUB 9660  'for Person Number
 5830 GOSUB 2980
 5840 REM get 11100
 5850 LOCATE 20,20: PRINT "19";
 5860 IF PERS(19) = 0 THEN GOSUB 2770 : GOTO 5900
 5870 GET #1, PERS(19) : GOSUB 2530  'Extract 11100
 5880 ROW=10: COL=98: GOSUB 9660  'for Person Number
 5890 GOSUB 2980
 5900 REM get 11011
 5910 LOCATE 20,20: PRINT "20";
 5920 IF PERS(20) = 0 THEN GOSUB 2770 : GOTO 5970
 5930 GET #1, PERS(20) : GOSUB 2530  'Extract 11011
 5940 IF PP.FORMS = 1 THEN ROW=13 :ELSE ROW=14
 5950 COL=98: GOSUB 9660  'for Person Number
 5960 GOSUB 2980
 5970 REM get 11010
 5980 LOCATE 20,20: PRINT "21";
 5990 IF PERS(21) = 0 THEN GOSUB 2770 : GOTO 6030
 6000 GET #1, PERS(21) : GOSUB 2530  'Extract 11010
 6010 ROW=16: COL=98: GOSUB 9660  'for Person Number
 6020 GOSUB 2980
 6030 REM get 11001
 6040 LOCATE 20,20: PRINT "22";
 6050 IF PERS(22) = 0 THEN GOSUB 2770 : GOTO 6090
 6060 GET #1, PERS(22) : GOSUB 2530  'Extract 11001
 6070 ROW=19: COL=98: GOSUB 9660  'for Person Number
 6080 GOSUB 2980
 6090 REM get 11000
 6100 LOCATE 20,20: PRINT "23";
 6110 IF PERS(23) = 0 THEN GOSUB 2770 : GOTO 6150
 6120 GET #1, PERS(23) : GOSUB 2530  'Extract 11000
 6130 ROW=22: COL=98: GOSUB 9660  'for Person Number
 6140 GOSUB 2980
 6150 REM get 10111
 6160 LOCATE 20,20: PRINT "24";
 6170 IF PERS(24) = 0 THEN GOSUB 2770 : GOTO 6220
 6180 GET #1, PERS(24) : GOSUB 2530  'Extract 10111
 6190 IF PP.FORMS = 1 THEN ROW=25 :ELSE ROW=26
 6200 COL=98: GOSUB 9660  'for Person Number
 6210 GOSUB 2980
 6220 REM get 10110
 6230 LOCATE 20,20: PRINT "25";
 6240 IF PERS(25) = 0 THEN GOSUB 2770 : GOTO 6280
 6250 GET #1, PERS(25) : GOSUB 2530  'Extract 10110
 6260 ROW=28: COL=98: GOSUB 9660  'for Person Number
 6270 GOSUB 2980
 6280 REM get 10101
 6290 LOCATE 20,20: PRINT "26";
 6300 IF PERS(26) = 0 THEN GOSUB 2770 : GOTO 6340
 6310 GET #1, PERS(26) : GOSUB 2530  'Extract 10101
 6320 ROW=31: COL=98: GOSUB 9660  'for Person Number
 6330 GOSUB 2980
 6340 REM get 10100
 6350 LOCATE 20,20: PRINT "27";
 6360 IF PERS(27) = 0 THEN GOSUB 2770 : GOTO 6400
 6370 GET #1, PERS(27) : GOSUB 2530  'Extract 10100
 6380 ROW=34: COL=98: GOSUB 9660  'for Person Number
 6390 GOSUB 2980
 6400 REM get 10011
 6410 LOCATE 20,20: PRINT "28";
 6420 IF PERS(28) = 0 THEN GOSUB 2770 : GOTO 6470
 6430 GET #1, PERS(28) : GOSUB 2530  'Extract 10011
 6440 IF PP.FORMS = 1 THEN ROW=37 :ELSE ROW=38
 6450 COL=98: GOSUB 9660  'for Person Number
 6460 GOSUB 2980
 6470 REM get 10010
 6480 LOCATE 20,20: PRINT "29";
 6490 IF PERS(29) = 0 THEN GOSUB 2770 : GOTO 6530
 6500 GET #1, PERS(29) : GOSUB 2530  'Extract 10010
 6510 ROW=40: COL=98: GOSUB 9660  'for Person Number
 6520 GOSUB 2980
 6530 REM get 10001
 6540 LOCATE 20,20: PRINT "30";
 6550 IF PERS(30) = 0 THEN GOSUB 2770 : GOTO 6590
 6560 GET #1, PERS(30) : GOSUB 2530  'Extract 10001
 6570 ROW=43: COL=98: GOSUB 9660  'for Person Number
 6580 GOSUB 2980
 6590 REM get 10000
 6600 LOCATE 20,20: PRINT "31";
 6610 IF PERS(31) = 0 THEN GOSUB 2770 : GOTO 6650
 6620 GET #1, PERS(31) : GOSUB 2530  'Extract 10000
 6630 ROW=46: COL=98: GOSUB 9660  'for Person Number
 6640 GOSUB 2980
 6650 GOTO 6730
 6660 REM Extract Marriage Information
 6670 TT2! = CVS(M2$) : TT2 = TT2! 'Husband
 6680 TT3! = CVS(M3$) : TT3 = TT3! 'Wife
 6690 REM Position based upon forms
 6700 TT5$ = SPACE$(13)
 6710 IF PP.FORMS = 1 THEN RSET TT5$ = M5$ :ELSE LSET TT5$ = M5$
 6720 RETURN
 6730 REM Find Marriage of Person (1)
 6740 KEY ON : CLS : KEY OFF
 6750 LOCATE 20,1 : PRINT "Processing Marriage of # 1 on Chart"
 6760 FOUND = 0
 6770 FOR L = 1 TO M.COUNT
 6780  IF PERS(1) > PERS.NO(L) THEN 6840
 6790  IF PERS(1) < PERS.NO(L) THEN L = M.COUNT : GOTO 6840
 6800  REM found the marriage
 6810  FOUND = 1
 6820  GET #2, M.NO(L)
 6830  L = M.COUNT
 6840 NEXT L
 6850 IF FOUND = 0 THEN 6980
 6860 REM extract marriage information
 6870 GOSUB 6660  'extract
 6880 MID$(FORM$(26),10,13) = TT5$
 6890 REM identify the spouse
 6900 IF TT2 = PERS(1) THEN SPOUSE = TT3
 6910 IF TT3 = PERS(1) THEN SPOUSE = TT2
 6920 GET #1, SPOUSE
 6930 GOSUB 2530  'Extract Person Info
 6940 MID$(FORM$(29),1,LEN(T2$+T3$)+2) = T2$ + ", " + T3$
 6950 COL = 1
 6960 GOSUB 9660  'Obtain Spouse's Record No.
 6970 MID$(FORM$(30),1,PLEN) = PNUM$
 6980 GOTO 7210
 6990 REM find a marriage
 7000 FOUND = 0
 7010 IF HUSB = 0 THEN 7200  'return
 7020 REM Establish Skip-ahead Start-value and Delta
 7030 START.AT = 1 : DELTA = INT(M.COUNT/10) : IF DELTA = 0 THEN 7080
 7040 REM Add delta and test if too far
 7050 START.AT = START.AT + DELTA
 7060 IF START.AT > 9 * DELTA THEN 7080
 7070 IF HUSB > PERS.NO(START.AT) THEN 7050
 7080 START.AT = START.AT - DELTA
 7090 REM Search Routine
 7100 FOR L = START.AT TO M.COUNT
 7110  IF HUSB > PERS.NO(L) THEN  7190  'next l
 7120  IF HUSB < PERS.NO(L) THEN L = M.COUNT : GOTO 7190  'next l
 7130  REM found one marriage
 7140  GET #2, M.NO(L)
 7150  GOSUB 6660  'Extract marriage info
 7160  IF TT3 <> WIFE THEN 7190 'next l
 7170  FOUND = 1
 7180  L = M.COUNT
 7190 NEXT L
 7200 RETURN
 7210 LOCATE 20,25: PRINT " 2";
 7220 HUSB = PERS(2) : WIFE = PERS(3)
 7230 GOSUB 6990  'Look for marriage
 7240 IF FOUND = 0 THEN 7260
 7250 MID$(FORM$(15),30,13) = TT5$
 7260 LOCATE 20,25: PRINT " 4";
 7270 HUSB = PERS(4) : WIFE = PERS(5)
 7280 GOSUB 6990  'Look for marriage
 7290 IF FOUND = 0 THEN 7310
 7300 MID$(FORM$(9),55,13) = TT5$
 7310 LOCATE 20,25: PRINT " 6";
 7320 HUSB = PERS(6) : WIFE = PERS(7)
 7330 GOSUB 6990  'Look for marriage
 7340 IF FOUND = 0 THEN 7360
 7350 MID$(FORM$(33),55,13) = TT5$
 7360 LOCATE 20,25: PRINT " 8";
 7370 HUSB = PERS(8) : WIFE = PERS(9)
 7380 GOSUB 6990  'Look for marriage
 7390 IF FOUND = 0 THEN 7410
 7400 MID$(FORM$(6),80,13) = TT5$
 7410 LOCATE 20,25: PRINT "10";
 7420 HUSB = PERS(10) : WIFE = PERS(11)
 7430 GOSUB 6990  'Look for marriage
 7440 IF FOUND = 0 THEN 7460
 7450 MID$(FORM$(18),80,13) = TT5$
 7460 LOCATE 20,25: PRINT "12";
 7470 HUSB = PERS(12) : WIFE = PERS(13)
 7480 GOSUB 6990  'Look for marriage
 7490 IF FOUND = 0 THEN 7510
 7500 MID$(FORM$(30),80,13) = TT5$
 7510 LOCATE 20,25: PRINT "14";
 7520 HUSB = PERS(14) : WIFE = PERS(15)
 7530 GOSUB 6990  'Look for marriage
 7540 IF FOUND = 0 THEN 7560
 7550 MID$(FORM$(42),80,13) = TT5$
 7560 REM All Marriages found
 7570 PRINT : PRINT "Ready to Print"
 7580 LPRINT
 7590 REM Print the Chart of Ancestors
 7600 FOR I = 1 TO 49
 7610  PRINT "Printing Line: ";I
 7620  IF GENS <> 5 THEN LPRINT TAB(18); LEFT$(FORM$(I),97) :ELSE LPRINT FORM$(I)
 7630 NEXT I
 7640 LAST.PERS = PERS(1)
 7650 KEY ON : CLS : KEY OFF
 7660 LPRINT FORM.FEED$;
 7670 GOTO 2350  'for next chart
 7680 REM Wrapup
 7690 LPRINT COMPR.OFF$;      'Normal Printing
 7700 LPRINT PAP.SEN.ON$;     'Paper Sensing ON
 7710 LPRINT PAP.LONG$;       'Normal Page of 66 Lines
 7720 CLOSE
 7730 WIDTH "lpt1:",80        'Reset for narrow paper
 7740 KEY ON : CLS : KEY OFF : LOCATE 21,1
 7750 PRINT "End of Program"
 7760 RUN CC.MENU$
 7770 REM Create the Form
 7780 REM Draw the Vertical Lines
 7790 LOCATE 15,1 : PRINT "Drawing the Vertical Lines"
 7800 FOR II = 13 TO 36
 7810  MID$(FORM$(II),23,1) = CHR$(124)
 7820 NEXT II
 7830 FOR II = 7 TO 18
 7840  MID$(FORM$(II),48,1) = CHR$(124)
 7850  MID$(FORM$(II+24),48,1) = CHR$(124)
 7860 NEXT II
 7870 FOR II = 4 TO 9
 7880  MID$(FORM$(II),73,1) = CHR$(124)
 7890  MID$(FORM$(II+12),73,1) = CHR$(124)
 7900  MID$(FORM$(II+24),73,1) = CHR$(124)
 7910  MID$(FORM$(II+36),73,1) = CHR$(124)
 7920 NEXT II
 7930 IF GENS <> 5 THEN 8070
 7940 FOR II = 2 TO 4
 7950  MID$(FORM$(II),97,1) = CHR$(124)
 7960  MID$(FORM$(II+6),97,1) = CHR$(124)
 7970  IF II = 2 THEN 7990
 7980  MID$(FORM$(II+12),97,1) = CHR$(124)
 7990  MID$(FORM$(II+18),97,1) = CHR$(124)
 8000  IF II = 2 THEN 8020
 8010  MID$(FORM$(II+24),97,1) = CHR$(124)
 8020  MID$(FORM$(II+30),97,1) = CHR$(124)
 8030  IF II = 2 THEN 8050
 8040  MID$(FORM$(II+36),97,1) = CHR$(124)
 8050  MID$(FORM$(II+42),97,1) = CHR$(124)
 8060 NEXT II
 8070 REM Draw the Horizontal Lines
 8080 PRINT "Drawing the Horizontal Lines"
 8090 FOR JJ = 1 TO 22
 8100  MID$(FORM$(23),JJ,1) = CHR$(95)
 8110  MID$(FORM$(29),JJ,1) = CHR$(95)
 8120 NEXT JJ
 8130 PRINT "Drawing Lines for Parents"
 8140 FOR II = 12 TO 36 STEP 24
 8150  MID$(FORM$(II),24) = STRING$(24,95)
 8160 NEXT II
 8170 PRINT "Drawing Lines for Grandparents"
 8180 FOR II = 6 TO 42 STEP 12
 8190  MID$(FORM$(II),49) = STRING$(24,95)
 8200 NEXT II
 8210 PRINT "Drawing Lines for Great-grandparents"
 8220 FOR II = 3 TO 45 STEP 6
 8230  MID$(FORM$(II),74) = STRING$(23,95)
 8240 NEXT II
 8250 IF GENS <> 5 THEN 8330
 8260 PRINT "Drawing Lines for Great-great-grandparents"
 8270 FOR II = 1 TO 46 STEP 3
 8280   IF II = 13 OR II = 25 OR II = 37 THEN 8310
 8290   MID$(FORM$(II),98,23) = STRING$(23,95)
 8300   GOTO 8320
 8310   MID$(FORM$(II+1),98,23) = STRING$(23,95)
 8320 NEXT II
 8330 REM Prepare the Title Information
 8340 PRINT "Preparing Titles and Numbers"
 8350 PRINT : PRINT : PRINT : PRINT : PRINT
 8360 MID$(FORM$( 1),1,22) = "Chart of Ancestors of "
 8370 MID$(FORM$( 2),1,15) = "Person Record: "
 8380 P.NO$ = STR$(PERS(1))
 8390 P.NO$ = RIGHT$(P.NO$,LEN(P.NO$)-1)
 8400 MID$(FORM$( 2),16,LEN(P.NO$)) = P.NO$
 8410 MID$(FORM$( 3),1,23) = "Prepared on "+DATE$
 8420 MID$(FORM$( 3),23,12) = " at "+TIME$
 8430 MID$(FORM$( 4),1,42) = "Using Version 6.0 of Genealogy ON DISPLAY."
 8440 IF PREP1$ = "" THEN 8460
 8450 MID$(FORM$( 5),1, 3) = "By:"
 8460 MID$(FORM$( 5),5, LEN(PREP1$)) = PREP1$
 8470 MID$(FORM$( 6),5, LEN(PREP2$)) = PREP2$
 8480 MID$(FORM$( 7),5, LEN(PREP3$)) = PREP3$
 8490 MID$(FORM$( 8),5, LEN(PREP4$)) = PREP4$
 8500 IF CHART.NOS$ = "n" THEN 8520
 8510 MID$(FORM$(22),1,1) = "1"
 8520 MID$(FORM$(24),1,1) = "B"
 8530 MID$(FORM$(25),1,1) = "W"
 8540 MID$(FORM$(26),1,8) = "Married:"
 8550 MID$(FORM$(27),1,1) = "D"
 8560 MID$(FORM$(28),1,1) = "W"
 8570 IF CHART.NOS$ = "n" THEN 8590
 8580 MID$(FORM$(12),21,2) = " 2"
 8590 MID$(FORM$(13),24,2) = "B:"
 8600 MID$(FORM$(14),24,2) = "W:"
 8610 MID$(FORM$(15),24,5) = "Marr:"
 8620 MID$(FORM$(16),24,2) = "D:"
 8630 MID$(FORM$(17),24,2) = "W:"
 8640 IF CHART.NOS$ = "n" THEN 8660
 8650 MID$(FORM$(36),21,2) = " 3"
 8660 MID$(FORM$(37),24,2) = "B:"
 8670 MID$(FORM$(38),24,2) = "W:"
 8680 MID$(FORM$(39),24,2) = "D:"
 8690 MID$(FORM$(40),24,2) = "W:"
 8700 IF CHART.NOS$ = "n" THEN 8720
 8710 MID$(FORM$( 6),46,2) = " 4"
 8720 MID$(FORM$( 7),49,2) = "B:"
 8730 MID$(FORM$( 8),49,2) = "W:"
 8740 MID$(FORM$( 9),49,5) = "Marr:"
 8750 MID$(FORM$(10),49,2) = "D:"
 8760 MID$(FORM$(11),49,2) = "W:"
 8770 IF CHART.NOS$ = "n" THEN 8790
 8780 MID$(FORM$(18),46,2) = " 5"
 8790 MID$(FORM$(19),49,2) = "B:"
 8800 MID$(FORM$(20),49,2) = "W:"
 8810 MID$(FORM$(21),49,2) = "D:"
 8820 MID$(FORM$(22),49,2) = "W:"
 8830 IF CHART.NOS$ = "n" THEN 8850
 8840 MID$(FORM$(30),46,2) = " 6"
 8850 MID$(FORM$(31),49,2) = "B:"
 8860 MID$(FORM$(32),49,2) = "W:"
 8870 MID$(FORM$(33),49,5) = "Marr:"
 8880 MID$(FORM$(34),49,2) = "D:"
 8890 MID$(FORM$(35),49,2) = "W:"
 8900 IF CHART.NOS$ = "n" THEN 8920
 8910 MID$(FORM$(42),46,2) = " 7"
 8920 MID$(FORM$(43),49,2) = "B:"
 8930 MID$(FORM$(44),49,2) = "W:"
 8940 MID$(FORM$(45),49,2) = "D:"
 8950 MID$(FORM$(46),49,2) = "W:"
 8960 IF CHART.NOS$ = "n" THEN 8980
 8970 MID$(FORM$( 3),71,2) = " 8"
 8980 MID$(FORM$( 4),74,2) = "B:"
 8990 MID$(FORM$( 5),74,2) = "W:"
 9000 MID$(FORM$( 6),74,5) = "Marr:"
 9010 MID$(FORM$( 7),74,2) = "D:"
 9020 MID$(FORM$( 8),74,2) = "W:"
 9030 IF CHART.NOS$ = "n" THEN 9050
 9040 MID$(FORM$( 9),71,2) = " 9"
 9050 MID$(FORM$(10),74,2) = "B:"
 9060 MID$(FORM$(11),74,2) = "W:"
 9070 MID$(FORM$(12),74,2) = "D:"
 9080 MID$(FORM$(13),74,2) = "W:"
 9090 IF CHART.NOS$ = "n" THEN 9110
 9100 MID$(FORM$(15),71,2) = "10"
 9110 MID$(FORM$(16),74,2) = "B:"
 9120 MID$(FORM$(17),74,2) = "W:"
 9130 MID$(FORM$(18),74,5) = "Marr:"
 9140 MID$(FORM$(19),74,2) = "D:"
 9150 MID$(FORM$(20),74,2) = "W:"
 9160 IF CHART.NOS$ = "n" THEN 9180
 9170 MID$(FORM$(21),71,2) = "11"
 9180 MID$(FORM$(22),74,2) = "B:"
 9190 MID$(FORM$(23),74,2) = "W:"
 9200 MID$(FORM$(24),74,2) = "D:"
 9210 MID$(FORM$(25),74,2) = "W:"
 9220 IF CHART.NOS$ = "n" THEN 9240
 9230 MID$(FORM$(27),71,2) = "12"
 9240 MID$(FORM$(28),74,2) = "B:"
 9250 MID$(FORM$(29),74,2) = "W:"
 9260 MID$(FORM$(30),74,5) = "Marr:"
 9270 MID$(FORM$(31),74,2) = "D:"
 9280 MID$(FORM$(32),74,2) = "W:"
 9290 IF CHART.NOS$ = "n" THEN 9310
 9300 MID$(FORM$(33),71,2) = "13"
 9310 MID$(FORM$(34),74,2) = "B:"
 9320 MID$(FORM$(35),74,2) = "W:"
 9330 MID$(FORM$(36),74,2) = "D:"
 9340 MID$(FORM$(37),74,2) = "W:"
 9350 IF CHART.NOS$ = "n" THEN 9370
 9360 MID$(FORM$(39),71,2) = "14"
 9370 MID$(FORM$(40),74,2) = "B:"
 9380 MID$(FORM$(41),74,2) = "W:"
 9390 MID$(FORM$(42),74,5) = "Marr:"
 9400 MID$(FORM$(43),74,2) = "D:"
 9410 MID$(FORM$(44),74,2) = "W:"
 9420 IF CHART.NOS$ = "n" THEN 9440
 9430 MID$(FORM$(45),71,2) = "15"
 9440 MID$(FORM$(46),74,2) = "B:"
 9450 MID$(FORM$(47),74,2) = "W:"
 9460 MID$(FORM$(48),74,2) = "D:"
 9470 MID$(FORM$(49),74,2) = "W:"
 9480 IF CHART.NOS$ = "n" OR GENS <> 5 THEN 9650
 9490 MID$(FORM$( 1),95,2) = "16"
 9500 MID$(FORM$( 4),95,2) = "17"
 9510 MID$(FORM$( 7),95,2) = "18"
 9520 MID$(FORM$(10),95,2) = "19"
 9530 MID$(FORM$(14),95,2) = "20"
 9540 MID$(FORM$(16),95,2) = "21"
 9550 MID$(FORM$(19),95,2) = "22"
 9560 MID$(FORM$(22),95,2) = "23"
 9570 MID$(FORM$(26),95,2) = "24"
 9580 MID$(FORM$(28),95,2) = "25"
 9590 MID$(FORM$(31),95,2) = "26"
 9600 MID$(FORM$(34),95,2) = "27"
 9610 MID$(FORM$(38),95,2) = "28"
 9620 MID$(FORM$(40),95,2) = "29"
 9630 MID$(FORM$(43),95,2) = "30"
 9640 MID$(FORM$(46),95,2) = "31"
 9650 RETURN
 9660 REM Routine to Obtain a Usable Person Number for the Chart
 9670 REM Skip if LDS Wide, Single Sheet Forms
 9680 IF PP.FORMS = 1 THEN 9810  'return
 9690 IF CHART.NOS$ <> "n" THEN 9810
 9700 REM Convert the Person Number to a String
 9710 PNUM$ = STR$(T1)
 9720 REM Find its Length
 9730 PLEN = LEN(PNUM$)
 9740 REM Get rid of the leading space for algebraic sign
 9750 PNUM$ = RIGHT$(PNUM$,PLEN-1)
 9760 REM Append a Trailing Space
 9770 PNUM$ = PNUM$ + " "
 9780 REM bypass if column is 1 (person or spouse)
 9790 IF COL = 1 THEN 9810
 9800 MID$(FORM$(ROW),COL-PLEN,PLEN) = PNUM$
 9810 RETURN
 9820 REM Clean User Input Area
 9830 LOCATE 19,1 : PRINT SPACE$(79);
 9840 LOCATE 20,1 : PRINT SPACE$(79);
 9850 LOCATE 21,1 : PRINT SPACE$(79);
 9860 LOCATE 22,1 : PRINT SPACE$(79);
 9870 LOCATE 23,1 : PRINT SPACE$(79);
 9880 RETURN
