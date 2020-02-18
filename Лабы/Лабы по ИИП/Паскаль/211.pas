PROGRAM Prime(INPUT, OUTPUT);
CONST
  Min = 2;
  Max = 100;
VAR
  Numbers: SET OF Min .. Max;
  Divide, Digit: INTEGER;
BEGIN
  Numbers := [Min .. Max];
  Digit := Min;
  WRITE('Итоговые простые числа: ');
  WHILE Digit <= Max
  DO
    BEGIN
      IF Digit IN Numbers
      THEN
        BEGIN     
          Divide := Digit * Digit;   
          WHILE Divide <= Max
          DO
            BEGIN
              Numbers := Numbers - [Divide];
              Divide := Divide + Digit
            END;  
          WRITE(Digit, ' ')
        END;    
      Digit := Digit + 1;
    END; 
  WRITELN
END.             
