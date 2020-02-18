PROGRAM AverageScore(INPUT, OUTPUT);
CONST
  NumberOfScores = 4;
  ClassSize = 4;
  MinScore = 0;
  MaxScore = 100;
TYPE
  Score = MinScore .. MaxScore;
VAR
  WhichScore: 1 .. NumberOfScores;
  Overflow: BOOLEAN;
  Student: 1 .. ClassSize;
  NextScore: Score;
  Q: CHAR;
  Ave, TotalScore, ClassTotal: INTEGER;
BEGIN {AverageScore}
  ClassTotal := 0;
  Overflow := FALSE;
  WRITELN('Student averages: ');
  Student := 1;
  WHILE (Student <= ClassSize) AND (NOT Overflow)
  DO
    BEGIN
      TotalScore := 0;
      WhichScore := 1;
      READ(Q);
      WHILE Q <> ' '
      DO
        BEGIN
          WRITE(Q);  
          READ(Q)
        END; 
      WHILE (WhichScore <= NumberOfScores) AND (NOT Overflow)
      DO
        BEGIN
          READ(NextScore);
          IF (NextScore >= MinScore) AND (NextScore <= MaxScore)
          THEN
            BEGIN
              TotalScore := TotalScore + NextScore;
              WhichScore := WhichScore + 1
            END
          ELSE
            Overflow := TRUE  
        END;
      READLN;
      Student := Student + 1;
      TotalScore := TotalScore * 10;
      Ave := TotalScore DIV NumberOfScores;
      IF NOT Overflow
      THEN
        BEGIN
          IF Ave MOD 10 >= 5
          THEN
            WRITELN(' ', Ave DIV 10 + 1)
          ELSE
            WRITELN(' ', Ave DIV 10);
          ClassTotal := ClassTotal + TotalScore
        END  
    END;  
  IF Overflow
  THEN
    WRITE(' Overflow')
  ELSE
    BEGIN
      WRITELN;
      WRITELN ('Class average: ');
      ClassTotal := ClassTotal DIV (ClassSize * NumberOfScores);
      WRITELN(ClassTotal DIV 10, '.', ClassTotal MOD 10:1)
    END  
END.{AverageScore}
