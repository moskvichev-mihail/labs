PROGRAM PaintSymbols(INPUT, OUTPUT);
CONST  
  Line = 5;
  Column = 5;
  MaxMatrixWidth = Line * Column;
  MinMatrixWidth = 1;
  Symbol = 'X';
  Space = ' ';
  C = [1..5, 6, 11, 16, 21..25];
  F = [1..5, 6, 11..15, 16, 21];
  I = [1..5, 8, 13, 18, 21..25];
  T = [1 .. 5, 8, 13, 18, 23];
  Z = [1..5, 10, 13, 17, 21..25];
TYPE
  SetForPainting = SET OF MinMatrixWidth .. MaxMatrixWidth;
VAR
  Ch: CHAR;
  Paint: SetForPainting;
  
PROCEDURE Painting(VAR Paint: SetForPainting);                                                                          
VAR
  Int: INTEGER;
BEGIN{Painting}
  Int := MinMatrixWidth;
  WHILE Int <= MaxMatrixWidth
  DO
    BEGIN
      IF Int IN Paint
      THEN 
        WRITE(Symbol)
      ELSE
        WRITE(Space);
      IF (Int MOD Column) = 0
      THEN
        WRITELN;  
      Int := Int + 1           
    END   
END;{Painting}  

PROCEDURE ReadInAndOutLetters(VAR Paint: SetForPainting);
VAR
  Q: CHAR;
BEGIN{ReadInAndOutLetters}
  READ(INPUT, Q);
  WRITELN(OUTPUT);
  CASE Q OF
    'C': Paint := C;
    'F': Paint := F;
    'I': Paint := I;
    'T': Paint := T;
    'Z': Paint := Z
    ELSE Paint := []  
  END
END;{ReadInAndOutLetters}
  
BEGIN{PaintSymbols}
  ReadInAndOutLetters(Paint); 
  IF Paint <> []
  THEN
    Painting(Paint)
END.{PaintSymbols} 
