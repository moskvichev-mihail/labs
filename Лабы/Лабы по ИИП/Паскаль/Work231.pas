PROGRAM Calc(INPUT, OUTPUT);
TYPE
  Factor = RECORD
             A: REAL;
             B: REAL;
             C: REAL
           END;
  Value = RECORD
            X1: REAL;
            X2: REAL;
            Count: INTEGER
          END;
VAR
  Num: Factor;
  Result, Ct: Value;
  D: REAL;

PROCEDURE ReadFactor(VAR NumberOne, NumberTwo, NumberThree: REAL);
BEGIN
  READ(NumberOne, NumberTwo, NumberThree);
END;

PROCEDURE Factors();
BEGIN      
  Ct.Count := 0;         
  ReadFactor(Num.A, Num.B, Num.C);
  D := ((Num.B * Num.B) - 4 * Num.A * Num.C);
  IF (D = 0)
  THEN 
    BEGIN
      Result.X1 := (-Num.B / (2 * Num.A));
      Ct.Count := 1;
      WRITE('X будет равен - ', Result.X1, '. Кол-во корней - ', Ct.Count)
    END
  ELSE
    IF (D > 0)
    THEN
      BEGIN
        Result.X1 := ((-Num.B + Sqrt(D)) / (2 * Num.A));
        Result.X2 := ((-Num.B - Sqrt(D)) / (2 * Num.A));
        Ct.Count := 2;
        WRITE('Корни уравнения будут равны(Их 2): ', Result.X1, ', ', Result.X2, '. Кол-во корней - ', Ct.Count)
      END 
  ELSE
    WRITE('Дискриминант меньше 0', '. Кол-во корней - ', Ct.Count)
END;

BEGIN
  WHILE NOT EOLN(INPUT)
  DO
    Factors()
END.
