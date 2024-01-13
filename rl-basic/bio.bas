    10 CLS 
    15 PRINT "Datum TT,MM,JJJJ ";: INPUT t,m,j
    16 IF t > 31 OR t < 1 THEN  GOTO 15
    17 IF m > 12 OR m < 1 THEN  GOTO 15
    18 IF j < 1987 OR j > 2000 THEN  GOTO 15
    19 IF j / 4 =  INT (j / 4) AND t > 28 AND t < 30 AND m = 2 THEN  GOTO 25
    20 IF m = 2 AND t > 28 THEN  GOTO 15
    25 CLS 
    26 z1 = 0
    30 LOCATE 60,0: PRINT t;".";m;".";j
    40 PRINT "Datum des zu ermittelden Wochentages ": INPUT a,b,c
    41 IF a > 31 OR a < 1 THEN  GOTO 40
    42 IF b > 12 OR b < 1 THEN  GOTO 40
    43 IF c < 1900 OR c > 2000 THEN  GOTO 40
    44 IF c / 4 =  INT (c / 4) AND a > 28 AND a < 30 AND b = 2 THEN  GOTO 46
    45 IF b = 2 AND a > 28 THEN  GOTO 40
    46 CLS 
    47 PAGE 3,3: CLPG 
    48 a$ =  STR$ (t) + "." +  STR$ (m) + "." +  STR$ (j)
    49 WRITE 360,495,$11,a$
    50 IF c = 1925 OR c = 1953 OR c = 1981 THEN  GOTO 200
    55 IF c = 1903 OR c = 1931 OR c = 1959 OR c = 1987 THEN  GOTO 200
    60 IF c = 1914 OR c = 1942 OR c = 1970 OR c = 1998 THEN  GOTO 200
    65 IF c = 1926 OR c = 1954 OR c = 1982 THEN  GOTO 300
    70 IF c = 1909 OR c = 1937 OR c = 1965 OR c = 1993 THEN  GOTO 300
    75 IF c = 1915 OR c = 1943 OR c = 1971 OR c = 1999 THEN  GOTO 300
    80 IF c = 1927 OR c = 1955 OR c = 1983 THEN  GOTO 400
    85 IF c = 1910 OR c = 1938 OR c = 1966 OR c = 1994 THEN  GOTO 400
    90 IF c = 1921 OR c = 1949 OR c = 1977 THEN  GOTO 400
    95 IF c = 1901 OR c = 1929 OR c = 1957 OR c = 1985 THEN  GOTO 500
   100 IF c = 1907 OR c = 1935 OR c = 1963 OR c = 1991 THEN  GOTO 500
   105 IF c = 1918 OR c = 1946 OR c = 1974 THEN  GOTO 500
   110 IF c = 1902 OR c = 1930 OR c = 1958 OR c = 1986 THEN  GOTO 600
   115 IF c = 1913 OR c = 1941 OR c = 1969 OR c = 1997 THEN  GOTO 600
   120 IF c = 1919 OR c = 1947 OR c = 1975 THEN  GOTO 600
   125 IF c = 1905 OR c = 1933 OR c = 1961 OR c = 1989 THEN  GOTO 700
   130 IF c = 1911 OR c = 1939 OR c = 1967 OR c = 1995 THEN  GOTO 700
   135 IF c = 1922 OR c = 1950 OR c = 1978 THEN  GOTO 700
   140 IF c = 1906 OR c = 1934 OR c = 1962 OR c = 1990 THEN  GOTO 800
   145 IF c = 1900 OR c = 1917 OR c = 1945 OR c = 1973 THEN  GOTO 800
   150 IF c = 1923 OR c = 1951 OR c = 1979 THEN  GOTO 800
   152 IF c = 1928 OR c = 1956 OR c = 1984 THEN  GOTO 1000
   154 IF c = 1904 OR c = 1932 OR c = 1960 OR c = 1988 THEN  GOTO 1100
   156 IF c = 1908 OR c = 1936 OR c = 1964 OR c = 1992 THEN  GOTO 1200
   158 IF c = 1912 OR c = 1940 OR c = 1968 OR c = 1996 THEN  GOTO 1300
   160 IF c = 1916 OR c = 1944 OR c = 1972 OR c = 2000 THEN  GOTO 1400
   162 IF c = 1920 OR c = 1948 OR c = 1976 THEN  GOTO 1500
   164 IF c = 1924 OR c = 1952 OR c = 1980 THEN  GOTO 1600
   200 IF b = 1 OR b = 10 THEN  LET x = a + 4
   205 IF b = 2 OR b = 3 OR b = 11 THEN  LET x = a
   210 IF b = 4 OR b = 7 THEN  LET x = a + 3
   215 IF b = 5 THEN  LET x = a + 5
   220 IF b = 6 THEN  LET x = a + 1
   225 IF b = 8 THEN  LET x = a + 6
   230 IF b = 9 OR b = 12 THEN  LET x = a + 2
   235 GOTO 2000
   300 IF b = 1 OR b = 10 THEN  LET x = a + 5
   310 IF b = 2 OR b = 3 OR b = 11 THEN  LET x = a + 1
   320 IF b = 4 OR b = 7 THEN  LET x = a + 4
   330 IF b = 5 THEN  LET x = a + 6
   340 IF b = 6 THEN  LET x = a + 2
   350 IF b = 8 THEN  LET x = a
   360 IF b = 9 OR b = 12 THEN  LET x = a + 3
   370 GOTO 2000
   400 IF b = 1 OR b = 10 THEN  LET x = a + 6
   410 IF b = 2 OR b = 3 OR b = 11 THEN  LET x = a + 2
   420 IF b = 4 OR b = 7 THEN  LET x = a + 5
   430 IF b = 5 THEN  LET x = a
   440 IF b = 6 THEN  LET x = a + 3
   450 IF b = 8 THEN  LET x = a + 1
   460 IF b = 9 OR b = 12 THEN  LET x = a + 4
   470 GOTO 2000
   500 IF b = 1 OR b = 10 THEN  LET x = a + 2
   510 IF b = 2 OR b = 3 OR b = 11 THEN  LET x = a + 5
   520 IF b = 4 OR b = 7 THEN  LET x = a + 1
   530 IF b = 5 THEN  LET x = a + 3
   540 IF b = 6 THEN  LET x = a + 6
   550 IF b = 8 THEN  LET x = a + 4
   560 IF b = 9 OR b = 12 THEN  LET x = a
   570 GOTO 2000
   600 IF b = 1 OR b = 10 THEN  LET x = a + 3
   610 IF b = 2 OR b = 3 OR b = 11 THEN  LET x = a + 6
   620 IF b = 4 OR b = 7 THEN  LET x = a + 2
   630 IF b = 5 THEN  LET x = a + 4
   640 IF b = 6 THEN  LET x = a
   650 IF b = 8 THEN  LET x = a + 5
   660 IF b = 9 OR b = 12 THEN  LET x = a + 1
   670 GOTO 2000
   700 IF b = 1 OR b = 10 THEN  LET x = a
   710 IF b = 2 OR b = 3 OR b = 11 THEN  LET x = a + 3
   720 IF b = 4 OR b = 7 THEN  LET x = a + 6
   730 IF b = 5 THEN  LET x = a + 1
   740 IF b = 6 THEN  LET x = a + 4
   750 IF b = 8 THEN  LET x = a + 2
   760 IF b = 9 OR b = 12 THEN  LET x = a + 5
   770 GOTO 2000
   800 IF b = 1 OR b = 10 THEN  LET x = a + 1
   810 IF b = 2 OR b = 3 OR b = 11 THEN  LET x = a + 4
   820 IF b = 4 OR b = 7 THEN  LET x = a
   830 IF b = 5 THEN  LET x = a + 2
   840 IF b = 6 THEN  LET x = a + 5
   850 IF b = 8 THEN  LET x = a + 3
   860 IF b = 9 OR b = 12 THEN  LET x = a + 6
   870 GOTO 2000
  1000 IF b < 3 THEN  GOTO 700
  1010 IF b > 2 THEN  GOTO 800
  1100 IF b < 3 THEN  GOTO 300
  1110 IF b > 2 THEN  GOTO 400
  1200 IF b < 3 THEN  GOTO 600
  1210 IF b > 2 THEN  GOTO 200
  1300 IF b < 3 THEN  GOTO 800
  1310 IF b > 2 THEN  GOTO 500
  1400 IF b < 3 THEN  GOTO 400
  1410 IF b > 2 THEN  GOTO 700
  1500 IF b < 3 THEN  GOTO 200
  1510 IF b > 2 THEN  GOTO 300
  1600 IF b < 3 THEN  GOTO 500
  1610 IF b > 2 THEN  GOTO 600
  2000 IF x = 1 OR x = 8 OR x = 15 OR x = 22 OR x = 29 OR x = 36 THEN  LET a$ = "Sonntag"
  2010 IF x = 2 OR x = 9 OR x = 16 OR x = 23 OR x = 30 OR x = 37 THEN  LET a$ = "Montag"
  2020 IF x = 3 OR x = 10 OR x = 17 OR x = 24 OR x = 31 THEN  LET a$ = "Dienstag"
  2030 IF x = 4 OR x = 11 OR x = 18 OR x = 25 OR x = 32 THEN  LET a$ = "Mittwoch"
  2040 IF x = 5 OR x = 12 OR x = 19 OR x = 26 OR x = 33 THEN  LET a$ = "Donnerstag"
  2050 IF x = 6 OR x = 13 OR x = 20 OR x = 27 OR x = 34 THEN  LET a$ = "Freitag"
  2060 IF x = 7 OR x = 14 OR x = 21 OR x = 28 OR x = 35 THEN  LET a$ = "Sonnabend"
  2100 IF c > j THEN  GOTO 2200
  2110 IF c < j THEN  GOTO 2210
  2120 IF c = j AND b < m THEN  GOTO 2210
  2130 IF c = j AND b > m THEN  GOTO 2200
  2140 IF c = j AND b = m AND a < t THEN  GOTO 2210
  2150 IF c = j AND b = m AND a > t THEN  GOTO 2200
  2160 IF c = j AND b = m AND a = t THEN  GOTO 2220
  2200 z$ = "Der " +  STR$ (a) + "." +  STR$ (b) + "." +  STR$ (c) + " ist ein " + a$ + "."
  2202 WRITE 140,400,$11,z$
  2205 GOTO 2240
  2210 z$ = "Der " +  STR$ (a) + "." +  STR$ (b) + "." +  STR$ (c) + " war ein " + a$ + "."
  2212 WRITE 140,400,$11,z$
  2215 GOTO 2240
  2220 z$ = "Heute ist " + a$ + ", der " +  STR$ (a) + "." +  STR$ (b) + "." +  STR$ (c) + " ."
  2222 WRITE 140,400,$11,z$
  2230 GOTO 2240
  2240 GOTO 2300
  2300 IF c = j THEN  GOTO 3610
  2303 IF c > j THEN  GOTO 3610
  2306 FOR z = c + 1 TO j - 1
  2307   IF c + 1 > j - 1 THEN  GOTO 2325
  2310   z1 = z1 + 365
  2320   IF z / 4 =  INT (z / 4) THEN  LET z1 = z1 + 1
  2325 NEXT 
  2330 IF c = j AND b = m THEN  GOTO 2400
  2335 IF b = 1 THEN  LET z1 = z1 + 334 + (31 - a)
  2340 IF b = 2 THEN  LET z1 = z1 + 306 + (28 - a)
  2342 IF b = 3 THEN  LET z1 = z1 + 275 + (31 - a)
  2344 IF b = 4 THEN  LET z1 = z1 + 245 + (30 - a)
  2346 IF b = 5 THEN  LET z1 = z1 + 214 + (31 - a)
  2348 IF b = 6 THEN  LET z1 = z1 + 184 + (30 - a)
  2350 IF b = 7 THEN  LET z1 = z1 + 153 + (31 - a)
  2352 IF b = 8 THEN  LET z1 = z1 + 122 + (31 - a)
  2354 IF b = 9 THEN  LET z1 = z1 + 92 + (30 - a)
  2356 IF b = 10 THEN  LET z1 = z1 + 61 + (31 - a)
  2358 IF b = 11 THEN  LET z1 = z1 + 31 + (30 - a)
  2360 IF b = 12 THEN  LET z1 = z1 + (31 - a)
  2362 IF m = 1 THEN  LET z1 = z1 + t
  2364 IF m = 2 THEN  LET z1 = z1 + 31 + t
  2366 IF m = 3 THEN  LET z1 = z1 + 59 + t
  2368 IF m = 4 THEN  LET z1 = z1 + 90 + t
  2370 IF m = 5 THEN  LET z1 = z1 + 120 + t
  2372 IF m = 6 THEN  LET z1 = z1 + 151 + t
  2374 IF m = 7 THEN  LET z1 = z1 + 181 + t
  2376 IF m = 8 THEN  LET z1 = z1 + 212 + t
  2378 IF m = 9 THEN  LET z1 = z1 + 243 + t
  2380 IF m = 10 THEN  LET z1 = z1 + 273 + t
  2382 IF m = 11 THEN  LET z1 = z1 + 304 + t
  2384 IF m = 12 THEN  LET z1 = z1 + 334 + t
  2386 IF b = 2 AND c / 4 =  INT (c / 4) AND a < 29 THEN  LET z1 = z1 + 1
  2387 IF b = 1 AND c / 4 =  INT (c / 4) THEN  LET z1 = z1 + 1
  2388 IF m > 2 AND j / 4 =  INT (j / 4) THEN  LET z1 = z1 + 1
  2390 IF b = 2 AND c / 4 =  INT (c / 4) AND a < 29 THEN  GOTO 2450
  2395 IF b = 1 AND c / 4 =  INT (c / 4) THEN  GOTO 2450
  2400 GOSUB 3000
  2449 RETURN 
  2450 GOSUB 3000
  2470 RETURN 
  3000 g = z1 - ( INT (z1 / 33) * 33)
  3010 s = z1 - ( INT (z1 / 28) * 28)
  3020 k = z1 - ( INT (z1 / 23) * 23)
  3050 a$ =  STR$ (z1) + " Tage."
  3100 WRITE 140,370,$11,a$
  3200 IF g = 0 OR g = 33 THEN  LET x = 100
  3205 IF g = 1 OR g = 32 THEN  LET x = 96.9
  3210 IF g = 2 OR g = 31 THEN  LET x = 90.9
  3215 IF g = 3 OR g = 30 THEN  LET x = 84.8
  3220 IF g = 4 OR g = 29 THEN  LET x = 78.8
  3225 IF g = 5 OR g = 28 THEN  LET x = 72.7
  3230 IF g = 6 OR g = 27 THEN  LET x = 66.6
  3235 IF g = 7 OR g = 26 THEN  LET x = 60.6
  3240 IF g = 8 OR g = 25 THEN  LET x = 54.5
  3245 IF g = 9 OR g = 24 THEN  LET x = 48.5
  3250 IF g = 10 OR g = 23 THEN  LET x = 42.4
  3255 IF g = 11 OR g = 22 THEN  LET x = 36.4
  3260 IF g = 12 OR g = 21 THEN  LET x = 30.3
  3265 IF g = 13 OR g = 20 THEN  LET x = 24.2
  3270 IF g = 14 OR g = 19 THEN  LET x = 18.2
  3275 IF g = 15 OR g = 18 THEN  LET x = 12.1
  3280 IF g = 16 OR g = 17 THEN  LET x = 0
  3300 FOR y = 100 TO 150 STEP 2
  3310   CONNECT (y,0) - (y,x * 3)
  3315   CONNECT (y,x * 3) - (y + 10,x * 3 + 5)
  3320 NEXT 
  3321 a$ =  STR$ (x) + " % "
  3322 WRITE y - 30,x * 3 + 30,$11,a$
  3323 WRITE y - 30,x * 3 + 10,$11,"Geist"
  3325 q = 0
  3330 CONNECT (y,q) - (y + 10,q + 5)
  3336 q = q + 3
  3340 IF q > x * 3 THEN  GOTO 3360
  3350 GOTO 3330
  3360 IF s = 0 OR s = 28 THEN  LET x = 100
  3365 IF s = 1 OR s = 27 THEN  LET x = 92.8
  3370 IF s = 2 OR s = 26 THEN  LET x = 85.7
  3375 IF s = 3 OR s = 25 THEN  LET x = 78.6
  3380 IF s = 4 OR s = 24 THEN  LET x = 71.4
  3385 IF s = 5 OR s = 23 THEN  LET x = 64.3
  3390 IF s = 6 OR s = 22 THEN  LET x = 57.1
  3395 IF s = 7 OR s = 21 THEN  LET x = 50
  3400 IF s = 8 OR s = 20 THEN  LET x = 42.9
  3405 IF s = 9 OR s = 19 THEN  LET x = 35.7
  3410 IF s = 10 OR s = 18 THEN  LET x = 28.6
  3415 IF s = 11 OR s = 17 THEN  LET x = 21.4
  3420 IF s = 12 OR s = 16 THEN  LET x = 14.3
  3425 IF s = 13 OR s = 15 THEN  LET x = 7.1
  3430 IF s = 14 THEN  LET x = 0
  3450 FOR y = 200 TO 250 STEP 2
  3455   CONNECT (y,0) - (y,x * 3)
  3460   CONNECT (y,x * 3) - (y + 10,x * 3 + 5)
  3465 NEXT 
  3467 WRITE y - 30,x * 3 + 10,$11,"Seele"
  3468 a$ =  STR$ (x) + " %"
  3469 WRITE y - 30,x * 3 + 30,$11,a$
  3470 q = 0
  3475 CONNECT (y,q) - (y + 10,q + 5)
  3480 q = q + 3
  3485 IF q > x * 3 THEN  GOTO 3500
  3490 GOTO 3475
  3500 IF k = 0 OR k = 23 THEN  LET x = 100
  3505 IF k = 1 OR k = 22 THEN  LET x = 95.6
  3510 IF k = 2 OR k = 21 THEN  LET x = 86.9
  3515 IF k = 3 OR k = 20 THEN  LET x = 78.3
  3520 IF k = 4 OR k = 19 THEN  LET x = 69.6
  3525 IF k = 5 OR k = 18 THEN  LET x = 60.9
  3530 IF k = 6 OR k = 17 THEN  LET x = 52.2
  3535 IF k = 7 OR k = 16 THEN  LET x = 43.5
  3540 IF k = 8 OR k = 15 THEN  LET x = 34.8
  3545 IF k = 9 OR k = 14 THEN  LET x = 26.1
  3550 IF k = 10 OR k = 13 THEN  LET x = 17.4
  3555 IF k = 11 OR k = 12 THEN  LET x = 0
  3560 FOR y = 300 TO 350 STEP 2
  3565   CONNECT (y,0) - (y,x * 3)
  3570   CONNECT (y,x * 3) - (y + 10,x * 3 + 5)
  3575 NEXT 
  3577 WRITE y - 31,x * 3 + 10,$11,"Koerper"
  3578 a$ =  STR$ (x) + " %"
  3579 WRITE y - 30,x * 3 + 30,$11,a$
  3580 q = 0
  3585 CONNECT (y,q) - (y + 10,q + 5)
  3590 q = q + 3
  3595 IF q > x * 3 THEN  GOTO 3610
  3600 GOTO 3585
  3610 WRITE 0,0,$11,"weiter = w"
  3620 a$ =  INKEY$ 
  3630 IF a$ = "w" THEN  GOTO 25
  3640 GOTO 3620
