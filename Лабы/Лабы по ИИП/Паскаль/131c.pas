PROGRAM BubbleSort(INPUT, OUTPUT);
{��������� ������ ������ INPUT � OUTPUT}
VAR
  Sorted: CHAR;
  F1, F2: TEXT;
PROCEDURE Copy(VAR InputF, OutputF: TEXT);
VAR
  H1: CHAR;
BEGIN{Copy}
  WHILE NOT EOLN(InputF)
  DO
    BEGIN
      READ(InputF, H1);
      WRITE(OutputF, H1)
    END;
  WRITELN(OutputF)
END;{Copy}
PROCEDURE Sort(VAR NoSortingF, SortingF: TEXT);
VAR
  Q1, Q2: CHAR;
BEGIN{Sort}
  IF NOT EOF(NoSortingF)
  THEN
    BEGIN
      READ(NoSortingF, Q1);
      WHILE NOT EOLN(NoSortingF)
      DO {�� ������� ���� ��� ������� �������� ��� Ch1,Ch2}
        BEGIN
          READ(NoSortingF, Q2);
          {�������   min(Ch1,Ch2) �  F2, ���������
                  ��������������� �������}
          IF Q1 <= Q2
          THEN
            BEGIN
              WRITE(SortingF, Q1);
              Q1 := Q2
            END
          ELSE
            BEGIN
              WRITE(SortingF, Q2);
              Sorted := 'N'
            END
        END;
      WRITELN(SortingF, Q1) {������� ��������� ������ � F2}
    END
END;{Sort}
BEGIN{BubbleSort}
  {�������� INPUT � F1}
  REWRITE(F1);
  Copy(INPUT, F1);
  Sorted := 'N';
  WHILE Sorted = 'N'
  DO
    BEGIN
      {�������� F1 � F2,�������� �����������������
        � �e��������� ������ �������e ������� �� �������}
      Sorted := 'Y';
      RESET(F1);
      REWRITE(F2);
      Sort(F1, F2);
      {�������� F2 � F1}
      RESET(F2);
      REWRITE(F1);
      Sort(F2, F1)
    END;
  {�������� F1 � OUTPUT}
  RESET(F1);
  Copy(F1, OUTPUT)
END.{BubbleSort}
