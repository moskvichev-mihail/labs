PROGRAM BuildIndex1(INPUT, OUTPUT);
CONST
  MaxWord = 50;
  Max = 125;
  ListEnd = 0;
  Increment = 1;
  
TYPE  
  AvtomatWithMemory = RECORD
                        Status: BOOLEAN;
                        Count: INTEGER
                      END;

  RecArray = ARRAY [1 .. Max] OF
                   RECORD
                     Wd: STRING[MaxWord];
                     Number: INTEGER;
                     Next: 0 .. Max;
                   END;       

VAR
  Avtomat: AvtomatWithMemory;
  ManyChar: SET OF CHAR;
  Ch: CHAR;
  StringWord: STRING[MaxWord];
  FIn: TEXT;
  Arr: RecArray;
  First, Index, Prev, Carr: 0 .. Max;
  Found: BOOLEAN; 

PROCEDURE InsertionSort(VAR StringWord: STRING);

PROCEDURE InsertionPosition(VAR Restart: BOOLEAN);
BEGIN
  Found := FALSE;
  WHILE (Carr <> 0) AND NOT(Found) AND NOT(Restart)
  DO
    BEGIN
      IF Arr[Index].Wd > Arr[Carr].Wd
      THEN
        BEGIN
          Prev := Carr; 
          Carr := Arr[Prev].Next;
        END
      ELSE
        IF Arr[Index].Wd = Arr[Carr].Wd
        THEN
          BEGIN
            Restart := TRUE;
            Arr[Carr].Number := Arr[Carr].Number + 1
          END
        ELSE  
          Found := TRUE
    END
END;

PROCEDURE Insert;  
VAR
  Restart: BOOLEAN;  
BEGIN
  Prev := 0;
  Carr := First;
  Restart := FALSE;
  InsertionPosition(Restart);{Поиск позиции вставки} 
  IF NOT(Restart)
  THEN
    BEGIN
      Arr[Index].Next := Carr;  
      Arr[Index].Number := 1;
      IF Prev = 0
      THEN
        First := Index
      ELSE
        Arr[Prev].Next := Index
    END
  ELSE
    Index := Index - 1       
END;

BEGIN {InsertionSort}
 {Поместить запись в список}      
  Index := Index + 1;
  IF (Index <= Max)
  THEN
    BEGIN
      Arr[Index].Wd := StringWord;
      Insert{Вставить запись в список}
    END
END; {InsertionSort}

PROCEDURE OutputList;
BEGIN
  Index := First;
  First := 0;
  WHILE Index <> ListEnd
  DO
    BEGIN
      WRITELN(Arr[Index].Wd, ' ', Arr[Index].Number);
      First := First + 1;
      Index := Arr[Index].Next
    END 
END;
  
PROCEDURE Engine(VAR Avtomat: AvtomatWithMemory);
BEGIN
  IF (Ch IN ManyChar) AND NOT(Avtomat.Status)
  THEN
    BEGIN
     StringWord := StringWord + Ch;      
     Avtomat.Count := Avtomat.Count + 1;
     Avtomat.Status := TRUE
    END
  ELSE
    IF Ch IN ManyChar
    THEN
      StringWord := StringWord + Ch
    ELSE
      IF (Avtomat.Status) AND NOT(EOLN(FIn))
      THEN
        BEGIN
          InsertionSort(StringWord);
          StringWord := '';
          Avtomat.Status := FALSE
        END 
END;

BEGIN {BuildIndex}
  ASSIGN(FIn, 'in.txt');
  First := 0;
  Index := 0;
  RESET(FIn);
  ManyChar := ['A'  .. 'z', 'А' .. 'я'];
  Avtomat.Count := 0;
  Avtomat.Status := FALSE;
  WHILE NOT(EOF(FIn))
  DO
    BEGIN
      READ(FIn, Ch);  
      Engine(Avtomat)      
    END;
  OutputList;{Распечатка Списка}
  WRITELN('Количество не повторяющихся слов: ', First);
  WRITELN('Количество Всего Слов: ', Avtomat.Count);
END. {BuildIndex}
