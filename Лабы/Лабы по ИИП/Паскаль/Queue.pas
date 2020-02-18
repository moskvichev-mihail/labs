UNIT Queue;
INTERFACE
  PROCEDURE CleanQ; {�������������}
  PROCEDURE AddQ(VAR Elt: CHAR);  {��������� � �������}
  PROCEDURE DelQ;  {������ ������}
  PROCEDURE HeadQ(VAR Elt: CHAR); {������}
  PROCEDURE WriteQ; {�������� ���������� �� ������� � OUTPUT}
  PROCEDURE CheckEmpty(VAR IsEmpty: CHAR); {�������� �� ������� Y/N}
  
IMPLEMENTATION
  VAR
    Q, Temp: TEXT;
    
  PROCEDURE CopyOpen(VAR F1, F2: TEXT);
 {��������� ������ �� F1 � F2 ��� RESET ��� REWRITE;
  ����� ������� F1 ������ ���� ����� ��� ������,� F2 ��� ������,
  �� ������� ������ � ���� ������ ����� ���� �� ����� }
  VAR
    Ch: CHAR;
  BEGIN {CopyOpen}
    WHILE NOT EOLN(F1)
    DO
      BEGIN
        READ(F1, Ch);
        WRITE(F2, Ch)
      END
  END;{CopyOpen}
  
  PROCEDURE CleanQ;{Q := <,/,R>}
  BEGIN {CleanQ}
    REWRITE(Q);
    WRITELN(Q);
    RESET(Q)
  END;{CleanQ}
  
  PROCEDURE AddQ(VAR Elt: CHAR);
  {Q = <,x/,R>,��� x ������ � Elt = a -->
   Q = <,xa/,R> }
  VAR
    Temp: TEXT;
  BEGIN {AddQ}
    REWRITE(Temp);
    CopyOpen(Q, Temp);
    WRITELN(Temp, Elt);
    RESET(Temp);
    REWRITE(Q);
    CopyOpen(Temp, Q);
    WRITELN(Q);
    RESET(Q)
  END;{AddQ}
  
  PROCEDURE DelQ;
  {(Q = <,/,R> -->)|
   (Q = <,ax/,R>,��� a ������ � x ������  -->
     Q:= <,x/,R> }
  VAR
    Ch: CHAR;
  BEGIN {DelQ}
  {������� ������ ������� �� Q};
    READ(Q, Ch);
    IF NOT EOF(Q)
    THEN {�� ������}
      BEGIN
        REWRITE(Temp);
        CopyOpen(Q, Temp);
        WRITELN(Temp);
        {�������� Temp � Q}
        RESET(Temp);
        REWRITE(Q);
        CopyOpen(Temp, Q);
        WRITELN(Q);
      END;
    RESET(Q)
  END;{DelQ}
  
  PROCEDURE HeadQ(VAR Elt: CHAR);
  {(Q = <,/,R> --> Elt := '#')|
   (Q = <,ax/,R>,��� a ������ � x ������  -->
     Elt:= 'a' }
  BEGIN  {HeadQ}
    IF NOT EOLN(Q)
    THEN
      READ(Q, Elt)
    ELSE
      Elt := '#';
    RESET(Q)
  END;{HeadQ}
  
  PROCEDURE WriteQ;
  { (Q = <,x/,R> � OUTPUT =<y,,W>,��� y � x ������  -->
     OUTPUT := <y&x/,,W> }
  BEGIN {WriteQ}
    CopyOpen(Q, OUTPUT);
    WRITELN(OUTPUT);
    RESET(Q)
  END;{WriteQ}
  
  PROCEDURE CheckEmpty(VAR IsEmpty: CHAR);
  BEGIN{CheckEmpty}
    IF EOLN(Q)
    THEN
      IsEmpty := 'Y'
    ELSE
      IsEmpty := 'N'
  END;{CheckEmpty}
  
BEGIN{Queue}
END.{Queue}
