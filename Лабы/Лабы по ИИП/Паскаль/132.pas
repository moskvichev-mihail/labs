PROGRAM LexicoProgram(INPUT, OUTPUT);
VAR
  ChResults: CHAR;
PROCEDURE Lexico(VAR Result: CHAR);
{Result 0, 1, 2 если лексикографический порядок F1 =, <, > чем F2       
соответственно. Фактические параметры, соответствующие F1 и F2, 
должны быть различными}
VAR 
  Ch1, Ch2: CHAR;
  F1, F2: TEXT;
BEGIN {Lexico}
  ASSIGN(F1, 'F:\Новая папка\F1.dat');
  ASSIGN(F2, 'F:\Новая папка\F2.dat');
  RESET(F1);
  RESET(F2);
  Result := '0';
  WHILE (NOT EOLN(F1) AND NOT EOLN(F2)) AND (Result = '0')
  DO
    BEGIN
      READ(F1, Ch1);
      READ(F2, Ch2);
      IF(Ch1 < Ch2) 
      THEN {Ch1 < Ch2 или F1 короче F2} 
        Result := '1'
      ELSE
        IF(Ch1 > Ch2) 
        THEN {Ch1 > Ch2 или F2 короче F1}  
          Result := '2'      
    END; {WHILE}       
  IF ((Result = '0') AND NOT EOLN(F1) AND EOLN(F2))
  THEN   
    Result := '2'
  ELSE
    IF ((Result = '0') AND EOLN(F1) AND NOT EOLN(F2))
    THEN
      Result := '1';
END; {Lexico}
BEGIN  
  Lexico(ChResults);
  WRITE(ChResults)
END.
