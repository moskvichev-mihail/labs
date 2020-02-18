PROGRAM Digit(INPUT, OUTPUT);
   
FUNCTION ReadNumber(VAR F: TEXT): INTEGER;
{Преобразует строку цифр из файла, завершающуюся нецифровым символом,
 в соответствующее целочисленное значение N, и возвращает N}
VAR
  OverFlow: CHAR;
  D1: INTEGER;
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
BEGIN{ReadNumber}
D1 := 0;
OverFlow := 'N';
WHILE NOT EOLN(F)
DO
  BEGIN
    D1 := ReadDigit(F);
    IF  D1 <> -1
    THEN
      IF D1 <= (MAXINT - D1) div 10
      THEN
        OverFlow := 'Y'
      ELSE
        D1 := (D1*10) + ReadDigit(F);
    ReadNumber := D1
  END;
WRITELN(F)
END;{ReadNumber}

BEGIN{Digit}
  WRITELN(ReadNumber(INPUT))  
END.{Digit}
