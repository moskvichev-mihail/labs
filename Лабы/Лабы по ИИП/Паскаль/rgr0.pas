PROGRAM Counter(INPUT, OUTPUT);
TYPE
  Conditions = (Space, Say);
  
  ConditionsOfMachine = RECORD
                          Condition: Conditions;
                          Count: INTEGER
                        END;
VAR
  Machine: ConditionsOfMachine; 
  Symbol: CHAR;
  IsSymbol: BOOLEAN; 

PROCEDURE IsItSymbol(VAR Symbol: CHAR; VAR IsSymbol: BOOLEAN);   
BEGIN{IsSymbol}
  IsSymbol := FALSE;
  IF ((Symbol >= 'А') AND (Symbol <= 'я')) OR ((Symbol >= 'A') AND (Symbol <= 'z'))
  THEN
    IsSymbol := TRUE
END;{IsSymbol}

PROCEDURE SwitchingConditionsAndCount(VAR Machine: ConditionsOfMachine; VAR Symbol: CHAR; VAR IsSymbol: BOOLEAN);
BEGIN{SwitchingConditionsAndCount}
  IsSymbol := TRUE;
  IF NOT((NOT IsSymbol) AND (Machine.Condition = Space))
  THEN
    BEGIN
      IsItSymbol(Symbol, IsSymbol);
      IF IsSymbol
      THEN
        Machine.Condition := Say
      ELSE  
        IF (NOT IsSymbol) AND (Machine.Condition = Say)
        THEN
          BEGIN
            Machine.Condition := Space;
            Machine.Count := Machine.Count + 1;
            WRITELN
          END 
    END 
END;{SwitchingConditionsAndCount}

PROCEDURE ReadInAndWriteOut(VAR Machine: ConditionsOfMachine; VAR Symbol: CHAR; VAR IsSymbol: BOOLEAN);
BEGIN{ReadInAndWriteOut}
  Machine.Condition := Space;
  Machine.Count := 0;
  WHILE NOT EOF(INPUT)
  DO
    BEGIN
      READ(Symbol);
      SwitchingConditionsAndCount(Machine, Symbol, IsSymbol);
      IF ((Machine.Condition = Say) AND (IsSymbol))
      THEN
        WRITE(Symbol)      
    END;
    IF ((Machine.Condition = Say) AND (IsSymbol))
    THEN
      WRITELN(OUTPUT);   
  WRITELN('Количество слов в строке: ', Machine.Count)
END;{ReadInAndWriteOut}

BEGIN{Counter}
  ReadInAndWriteOut(Machine, Symbol, IsSymbol)  
END.{Counter}
