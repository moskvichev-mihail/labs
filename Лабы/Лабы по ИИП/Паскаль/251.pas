PROGRAM InsertionSort(INPUT, OUTPUT);
CONST
  Max = 20;
  ListEnd = 0;
TYPE
  RecArray = ARRAY [1 .. Max] OF
                   RECORD
                     Key: CHAR;
                     Next: 0 .. Max
                   END;
VAR
  Arr: RecArray;
  Extra: CHAR;
  First, Index, Prev, Curr: 0 .. Max;
  Found: BOOLEAN;

PROCEDURE CalcIndex;
BEGIN
  Found := FALSE;
  WHILE (Curr <> ListEnd) AND NOT(Found)
  DO
    BEGIN
      IF Arr[Index].Key > Arr[Curr].Key
      THEN
        BEGIN
          Prev := Curr; 
          Curr := Arr[Prev].Next
        END
      ELSE
        Found := TRUE
    END
END;
    
PROCEDURE Insert;  
BEGIN
  Prev := ListEnd;
  Curr := First;
  READ(Arr[Index].Key);
  CalcIndex;{Поиск позиции вставки}
  Arr[Index].Next := Curr;
  IF Prev = ListEnd
  THEN
    First := Index
  ELSE
    Arr[Prev].Next := Index;
END;

PROCEDURE PrintList;
BEGIN
  Index := First;
  WHILE Index <> ListEnd
  DO
    BEGIN
      WRITE(Arr[Index].Key);
      Index := Arr[Index].Next
    END
END;
     
BEGIN {InsertionSort}
  First := ListEnd;
  Index := 0;
  WHILE NOT(EOLN)
  DO
    BEGIN {Поместить запись в список}      
      Index := Index + 1;
      IF Index <= Max
      THEN
        Insert{Вставить запись в список}
      ELSE
        BEGIN
          READ(Extra);
          WRITELN('Сообщение содержит: ', Extra, '. Игнорируем.')
        END  
    END;
  PrintList;{Распечатка Списка} 
  WRITELN 
END. {InsertionSort}                  
