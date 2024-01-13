    10 CLPG :k = 1:t = 1
    20 start!
    30 FOR col% = 0 TO 255 STEP k
    40   COLOR  = c%:c% = (c% + 1) MOD 256
    50   frame!
    60   CONNECT (col%,col%) - (511 - col%,col%) - (511 - col%,511 - col%) - (col%,511 - col%) - (col%,col%)
    65   CONNECT (col% + c%,col% + c%) - (511 - c% - col%,col% + c%) - (511 - c% - col%,511 - c% - col%) - (col% + c%,511 - c% - col%) - (col% + c%,col% + c%)
    70 NEXT 
    80 k = k + t: IF k < 1 THEN t = 1:k = 1
    90 IF k > 150 THEN t =  - 1
   100 GOTO start!
