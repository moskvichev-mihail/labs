Program Word;  { ������ ������⢠ ᫮� }
  Var
    f: text;              { ��室�� 䠩� }
    name: string[20];     { ��� ����� 䠩�� }
    s:    string;    { ��।��� ��ப� 䠩�� }
    m,n,i,kol: integer;
    b: boolean;
  Procedure Soob(mess: string);
    Begin
      Writeln(mess);
      Readln;   { ��㧠 }
      exec;
      Halt      { ����� }
    End;
  Begin  { �᭮���� �ணࠬ�� }
    if ParamCount<1 then Soob('�� 㪠��� ��室�� 䠩�')
      { � ��������� ��ப� ��� ��ࠬ��஢ }
    else Assign(f,ParamStr(1));
    name:=ParamStr(1);
    {$I-}     { �⪫�祭�� ���뢠��� �� �訡�� ����� }
    Reset(f);
    {$I+}
    if IoResult<>0 then Soob('�訡�� ������ 䠩�� '+name);
    kol:=0;
    While not eof(f) do
      begin
        Readln(f,s);
        m:=Length(s);  { �����  ��।��� ��ப� }
        n:=1;   b:=true;
        While b do
          Begin
            While (s[n]=' ') and (n<=m) do n:=n+1;
              { �ய�� �஡���� }
            While (s[n]<>' ') and (n<=m) do n:=n+1;
              { ��।��� ᫮�� }
            if (s[n-1]<>'-') and (s[n-1]<>' ') and (m>0)
        { �� ����� ��ப�, ��� ��७�� � �஡���� � ���� }
              then kol:=kol+1;
            if n>m then b:=false  { �ਧ��� ��室� �� 横�� }
          end
      end;
      Writeln('������⢮ ᫮� ',kol);
      Readln        { ������⥫쭠� ��㧠 }
  End.
