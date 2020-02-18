PROGRAM FormatProgram(INPUT, OUTPUT);
VAR
  Ch, Ch1, Ch2, Ch3: CHAR;
PROCEDURE MoveWindow;
BEGIN
  Ch := Ch1;
  Ch1 := Ch2;
  Ch2 := Ch3;
  READ(Ch3)  
END;
PROCEDURE WriteComments;
BEGIN
  IF Ch3 = '{'
  THEN
    BEGIN
      WRITE(Ch3);
      WHILE Ch3 <> '}'
      DO
        BEGIN
          MoveWindow;
          WRITE(Ch3)
        END  
    END
END;    
BEGIN
  READ(Ch3);
  WHILE Ch3 = ' '
  DO
    BEGIN
      READ(Ch3)
    END;  
  IF Ch3 = '{'
  THEN
    BEGIN
      WHILE Ch3 <> '}'
      DO
        BEGIN
          WRITE(Ch3);
          READ(Ch3)
        END;
      WRITELN(Ch3)  
    END;        
  WHILE NOT EOLN
  DO
    BEGIN
      MoveWindow;
      WriteComments; 
      IF (Ch1 = 'G') AND (Ch2 = 'I') AND (Ch3 = 'N') {For BEGIN}
      THEN
        BEGIN
          READ(Ch1);
          WHILE Ch1 = ' '
          DO
            BEGIN
              READ(Ch1)
            END;
          IF Ch1 = '{'
          THEN
            Ch3 := Ch1
          ELSE    
            READ(Ch2, Ch3);
          IF (Ch1 = 'E') AND (Ch2 = 'N') AND (Ch3 = 'D')  {For END}
          THEN
            WRITE('BEGIN')
          ELSE
            WRITELN('BEGIN');
          IF Ch1 = ';'
          THEN
            WRITELN(';');  
          WriteComments     
        END;           
      IF (Ch1 = 'E') AND (Ch2 = 'A') AND (Ch3 = 'D') {For READ and READLN} 
      THEN
        BEGIN
          READ(Ch3);
          IF Ch3 = 'L'
          THEN
            WRITE('  READLN')
          ELSE
            WRITE('  READ')  
        END;  
      IF (Ch1 = 'S') AND (Ch2 = 'E') AND (Ch3 = 'T') {For RESET} 
      THEN
        WRITE('  RESET');
      IF (Ch1 = 'E') AND (Ch2 = 'W') AND (Ch3 = 'R') {For REWRITE} 
      THEN
        BEGIN
         WRITE('  REWRITE');
         READ(Ch1, Ch2, Ch3);
         READ(Ch3)
        END;
      IF (Ch1 = 'I') AND (Ch2 = 'T') AND (Ch3 = 'E') {For WRITE and WRITELN} 
      THEN 
        BEGIN
          READ(Ch3);
          IF Ch3 = 'L'
          THEN
            WRITE('  WRITELN')
          ELSE
            WRITE('  WRITE')  
        END;
      IF Ch3 = '('
      THEN
        BEGIN
          WRITE(Ch3);
          WHILE Ch3 <> ')'
          DO
            BEGIN
              READ(Ch3);
              IF Ch3 = ' '
              THEN
                READ(Ch3)
              ELSE  
                WRITE(Ch3);
              IF Ch3 = ','
              THEN
                WRITE(' ');
              IF Ch3 = ''''
              THEN
                BEGIN
                  READ(Ch3);
                  WRITE(Ch3);
                  WHILE Ch3 <> ''''
                  DO
                    BEGIN
                      READ(Ch3);
                      WRITE(Ch3)
                    END
                END    
            END            
        END;
      IF (Ch1 = 'E') AND (Ch2 = 'N') AND (Ch3 = 'D')
      THEN
        BEGIN
          IF Ch <> ';'
          THEN
            WRITELN;
          WRITE('END.')
        END;
      IF Ch3 = ';'
      THEN
        BEGIN
          WRITE(Ch3);
          READ(Ch3);
          IF Ch3 = ';'
          THEN
            BEGIN
              WRITE(';');
              Ch3 := ' '
            END;    
          WHILE Ch3 = ' '
          DO
            BEGIN
              READ(Ch3)
            END;
          Ch2 := ';';       
          IF Ch3 <> '{'
          THEN
            WRITELN
          ELSE
            BEGIN  
              WriteComments;
              Ch2 := ';';               
              WRITELN
            END;                                              
        END                     
    END   
END.
