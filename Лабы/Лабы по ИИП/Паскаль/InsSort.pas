UNIT InsSort; 
INTERFACE 
  CONST
    MaxWord = 50;
    Max = 125;  
            
  TYPE
    EntranceString = STRING[MaxWord];
      
  PROCEDURE InsertionSort(StringWord: STRING);
  PROCEDURE PrintList;
  FUNCTION LowCase(Q: CHAR): CHAR;                      

IMPLEMENTATION
  CONST   
    ListEnd = 0; 
    EnglishCapsLock = ['A'  .. 'Z'];
    RussianCapsLock = ['À' .. 'ß']; 
    
  TYPE
    RecArray = ARRAY [1 .. Max] OF
                 RECORD
                   Wordd: EntranceString;
                   Num: INTEGER;
                   Next: 0 .. Max;
                 END; 
                 
  VAR
    First, Index, Prev, Curr: 0 .. Max;
    Found: BOOLEAN;
    Arr: RecArray;
    
  FUNCTION LowCase(Q: CHAR): CHAR;
  BEGIN{LowCase}
    IF (Q IN EnglishCapsLock) OR (Q IN RussianCapsLock)
    THEN
      LowCase := CHR(ORD(Q) + 32)
    ELSE
      LowCase := Q   
  END;{LowCase}  
    
  PROCEDURE InsertPositionIndex(VAR CountDuplicateWord: BOOLEAN; StringWord: STRING);
  BEGIN{InsertPositionIndex}
    Found := FALSE;
    WHILE (Curr <> 0) AND (NOT(Found)) AND (NOT(CountDuplicateWord))
    DO
      BEGIN
        IF StringWord > Arr[Curr].Wordd
        THEN
          BEGIN
            Prev := Curr;
            Curr := Arr[Prev].Next;
          END
        ELSE
          IF StringWord = Arr[Curr].Wordd
          THEN
            BEGIN
              CountDuplicateWord := TRUE;
              Arr[Curr].Num := Arr[Curr].Num + 1
            END
          ELSE  
            Found := TRUE
      END
  END;{InsertPositionIndex}

  PROCEDURE InsertionSort(StringWord: STRING);
  VAR
    CountDuplicateWord: BOOLEAN;  
  BEGIN{InsertionSort}
    Prev := 0;
    Curr := First;
    CountDuplicateWord := FALSE;
    InsertPositionIndex(CountDuplicateWord, StringWord);
    IF NOT(CountDuplicateWord)
    THEN
      BEGIN
        Index := Index + 1;
        IF (Index <= Max)
        THEN
          BEGIN
            Arr[Index].Wordd := StringWord;
            Arr[Index].Next := Curr;  
            Arr[Index].Num := 1;
            IF Prev = 0
            THEN
              First := Index
            ELSE
              Arr[Prev].Next := Index
          END    
      END     
  END;{InsertionSort}
  
  PROCEDURE PrintList; 
  BEGIN{PrintList}
    Index := First;
    WHILE Index <> ListEnd
    DO
      BEGIN
        WRITELN(Arr[Index].Wordd, ': ', Arr[Index].Num, ';');
        Index := Arr[Index].Next
      END 
  END;{PrintList}
  
BEGIN{InsSort}
END.{InsSort}
