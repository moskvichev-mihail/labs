UNIT InsSort2;
INTERFACE
  CONST
    MaxWord = 50;
    Max = 125;
    ListEnd = 0;
  TYPE 
    RecArray = ARRAY [1 .. Max] OF
                     RECORD
                       WorD: STRING[MaxWord];
                       Number: INTEGER;
                       Next: 0 .. Max;
                     END;                  

  PROCEDURE InsertionSort2(StrWord: STRING); 
  PROCEDURE PrintList;                       

IMPLEMENTATION
  TYPE 
  Tree = ^NodeType;
  NodeType = RECORD
               Key: CHAR;
               LLink, RLink: Tree;
             END;
VAR
  Root: Tree;
  Ch: CHAR;
  
PROCEDURE Insert(VAR Ptr: Tree; Data: CHAR);
BEGIN{Insert}
  IF Ptr = NIL
  THEN
    BEGIN {Создаем лист со значением Data}
      NEW(Ptr);
      Ptr^.Key := Data;
      Ptr^.LLink := NIL;
      Ptr^.RLink := NIL;
    END
  ELSE
    IF Ptr^.Key > Data
    THEN
      Insert(Ptr^.LLink, Data)
    ELSE
      Insert(Ptr^.RLink, Data)
END;{Insert}

PROCEDURE TreeSort();
BEGIN {TreeSort}
  Root := NIL;
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      Insert(Root, Ch)
    END;
  PrintTree(Root);
  WRITELN
END;{TreeSort}

PROCEDURE PrintTree(Ptr: Tree);
BEGIN {PrintTree}
  IF Ptr <> NIL
  THEN  {Печатает поддерево слева, вершину, поддерево справа}
    BEGIN
      PrintTree(Ptr^.LLink);
      WRITE(Ptr^.Key);
      PrintTree(Ptr^.RLink);
    END;  
END;{PrintTree}

BEGIN{InsSort2}
END.{InsSort2}
