PROGRAM IsPrime(INPUT, OUTPUT);
VAR
  Num: INTEGER;
  Check: BOOLEAN;

PROCEDURE CheckOnPrime(VAR Num: INTEGER; VAR Check: BOOLEAN);
BEGIN{CheckOnPrime}
  IF (Num / 2 = 1) OR (Num / 3 = 1) OR (Num / 5 = 1) OR (Num / 7 = 1)
  THEN
    Check := FALSE
  ELSE  
    IF (Num MOD 2 = 0) OR (Num MOD 3 = 0) OR (Num MOD 5 = 0) OR (Num MOD 7 = 0)
    THEN
      Check := TRUE 
    ELSE
      Check := FALSE                    
END;{CheckOnPrime}

PROCEDURE WritingPrime(VAR Check: BOOLEAN);
BEGIN{WritingPrime}
  IF Check = FALSE
  THEN
    WRITELN('Prime')
  ELSE
    WRITELN('Not prime')  
END;{WritingPrime}

BEGIN{IsPrime}
  READ(Num);
  WRITELN;
  CheckOnPrime(Num, Check);
  WritingPrime(Check)  
END.{IsPrime}
