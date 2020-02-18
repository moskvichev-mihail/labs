PROGRAM CountString(INPUT, OUTPUT);
USES InsSort;
CONST
  MultiplicityOfChar = ['A' .. 'z', 'А' .. 'я'];
  Dash = '-';
  
TYPE  
  Conditions = (Delimiter, Hyphen, WritingWord);
  
  ConditionsOfMachine =  RECORD
                           Condition: Conditions;
                           WorD: EntranceString;
                           Count: INTEGER
                         END; 
            
VAR
  Machine: ConditionsOfMachine;
  Ch: CHAR;  
  FIn: TEXT;                      
                       
PROCEDURE Calc(VAR Machine: ConditionsOfMachine; Ch: CHAR);
BEGIN{Calc}
  IF (Ch IN MultiplicityOfChar) AND (Machine.Condition = Delimiter)
  THEN
    BEGIN
      Machine.WorD := Ch;
      Machine.Count := Machine.Count + 1; 
      Machine.Condition := WritingWord
    END
  ELSE IF (Ch IN MultiplicityOfChar) AND (Machine.Condition = Hyphen)
  THEN
    BEGIN
      Machine.WorD  := Machine.WorD  + Dash + Ch;
      Machine.Condition := WritingWord
    END  
  ELSE IF (Ch IN MultiplicityOfChar) AND (NOT(Machine.Condition = Hyphen)) 
  THEN
    BEGIN
      Machine.WorD  := Machine.WorD  + Ch;
      Machine.Condition := WritingWord
    END  
  ELSE IF (Ch = Dash) AND (Machine.Condition = WritingWord)
  THEN
    Machine.Condition := Hyphen 
  ELSE IF (Machine.Condition = WritingWord) OR (Machine.Condition = Hyphen)
  THEN  
    BEGIN
      InsertionSort(Machine.WorD);
      Machine.WorD  := '';
      Machine.Condition := Delimiter
    END
END;{Calc}

PROCEDURE Sorting(VAR Machine: ConditionsOfMachine);
BEGIN{Sorting}
  IF (Machine.Condition = WritingWord) OR (Machine.Condition = Hyphen)
  THEN
    InsertionSort(Machine.WorD)
END;{Sorting} 

BEGIN{CountString}
  ASSIGN(FIn, 'in.txt');
  RESET(FIn);
  Machine.Count := 0;
  Machine.Condition := Delimiter;
  WHILE NOT(EOF(FIn))
  DO
    BEGIN
      READ(FIn, Ch);
      Ch := LowCase(Ch);
      Calc(Machine, Ch)      
    END;
  Sorting(Machine);
  PrintList;
  WRITELN;  
  WRITELN('Количество слов равно: ', Machine.Count, '.') 
END.{CountString}
