PROGRAM Digit(INPUT, OUTPUT);
   
FUNCTION ReadDigit(VAR F: TEXT): INTEGER;
{Считывает текущий символ из файла, если он - цифра, возвращает его
преобразуя в значение типа INTEGER.
Если считанный символ не цифра возвращается -1}
VAR
  Ch: CHAR;
  D: INTEGER;
BEGIN{ReadDigit}
  D := -1;
  IF NOT EOLN(F)
  THEN
    BEGIN
      READ(F, Ch);
      IF Ch = '0' THEN  D := 0 ELSE
      IF Ch = '1' THEN  D := 1 ELSE
      IF Ch = '2' THEN  D := 2 ELSE
      IF Ch = '3' THEN  D := 3 ELSE
      IF Ch = '4' THEN  D := 4 ELSE
      IF Ch = '5' THEN  D := 5 ELSE
      IF Ch = '6' THEN  D := 6 ELSE
      IF Ch = '7' THEN  D := 7 ELSE
      IF Ch = '8' THEN  D := 8 ELSE
      IF Ch = '9' THEN  D := 9
    END;
  ReadDigit := D 
END;{ReadDigit}

BEGIN{Digit}
  WRITELN(ReadDigit(INPUT))  
END.{Digit}
