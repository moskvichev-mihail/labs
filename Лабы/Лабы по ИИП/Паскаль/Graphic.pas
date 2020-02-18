PROGRAM Graphic(INPUT, OUTPUT);
CONST  
  Length = 5;
  Column = 5;
  Max = Length * Column;
  Min = 1;
TYPE
  SetForDraw = SET OF Min .. Max;
VAR
  Ch: CHAR;
  Graph: SetForDraw;
  
  PROCEDURE Draw(VAR Graphic: SetForDraw);                                                                          
  VAR
    I: INTEGER;
  BEGIN
    I := Min;
    WHILE I <= Max
    DO
      BEGIN
        IF I IN Graphic
        THEN 
          WRITE('X')
        ELSE
          WRITE(' ');
        IF (I MOD Length) = 0
        THEN
          WRITELN;  
        I := I + 1           
      END   
  END;  
  
BEGIN
  READ(Ch);
  WRITELN;
  CASE Ch OF
    'F': Graph := [1 .. 5, 6, 11 .. 15, 16, 21];
    'N': Graph := [1, 6, 11, 16, 21, 7, 13, 19, 5, 10, 15, 20, 25];
    'I': Graph := [3, 8, 13, 18, 23];
    'T': Graph := [1 .. 5, 8, 13, 18, 23];
    'E': Graph := [1 .. 5, 6, 11 .. 15, 16, 21 .. 25];
    ELSE Graph := []
  END; 
  IF Graph <> []
  THEN
    Draw(Graph);
END.  

