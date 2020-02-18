PROGRAM Equation2(INPUT, OUTPUT);
TYPE
  Coefficients = RECORD
                   A, B, C: REAL;
                   Existence: BOOLEAN
                 END;
  Roots = RECORD
            X1, X2: REAL;
            Check: BOOLEAN
          END;
VAR
  K: Coefficients;
  X: Roots;

PROCEDURE ReadCoefficients(VAR K: Coefficients);
BEGIN{ReadCoefficients}
  K.Existence := TRUE;
  READ(K.A, K.B, K.C);
  WRITELN(OUTPUT);
  IF K.A = 0
  THEN
    K.Existence := FALSE
END;{ReadCoefficients}

PROCEDURE CalculateDiskr(VAR K: Coefficients; VAR X: Roots);
VAR
  Diskr: REAL;
BEGIN{CalculateDiskr}
  X.Check := TRUE;
  IF K.Existence
  THEN
    BEGIN
      Diskr := ((K.B * K.B) - (4 * K.A * K.C));
      IF Diskr > 0
      THEN
        BEGIN
          X.X1 := ((- K.B + Sqrt(Diskr)) / (2 * K.A));
          X.X2 := ((- K.B - Sqrt(Diskr)) / (2 * K.A))
        END
      ELSE
        IF Diskr < 0
        THEN
          X.Check := FALSE
        ELSE
          IF Diskr = 0
          THEN
            BEGIN
              X.X1 := ((- K.B) / (2 * K.A));
              X.X2 := X.X1
            END
    END
  ELSE
    WRITELN('Введённое Вами уравнение не является квадратным.')                              
END;{CalculateDiskr}

PROCEDURE CheckingForAvailability(VAR X: Roots);
BEGIN{CheckingForAvailability}
  IF X.Check
  THEN
    IF X.X1 = X.X2
    THEN
      WRITELN('2 одинаковых корня: x1 = x2 = ', X.X1: 4: 2)
    ELSE  
      WRITELN('2 различных корня: x1 = ', X.X1: 4: 2, '; ', 'x2 = ', X.X2: 4: 2)
  ELSE    
    WRITELN('Нет действительных корней.')       
END;{CheckingForAvailability}

BEGIN{Equation2}
  ReadCoefficients(K);
  CalculateDiskr(K, X);
  IF K.Existence
  THEN
    CheckingForAvailability(X)
END.{Equation2}   
