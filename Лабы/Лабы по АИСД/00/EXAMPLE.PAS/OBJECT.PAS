Program ObjectTest;
{ ࠡ�� � �⥪�� � ��।��, �࣠���������� �� ���ᨢ� }
Uses Crt;
  Type
    TStek=Object
        top: integer; {���設� �⥪�; ��� ��।� - �����}
        list: array [1..100] of integer; {���ᨢ ��� ᯨ᪠}
        Constructor Init; {�ॡ����, �.�. ���� ����㠫�� ��⮤�}
        Procedure Dopoln(knew: integer); {knew-������塞� �������}
        Procedure Udal; {㤠����� �� ���設� �⥪�}
        Function GetTop: integer; {������ ���祭�� top}
        Procedure ShowNext(var i: integer); Virtual;
        {�뢮� ᫥���饣� �������, � �⥪� �� ���設� � ��砫�}
        Procedure Show(ind: integer);
        {�뢮� ᯨ᪠ �� ��࠭, ind-���� �������}
    End;
    TOcher=Object(TStek)
        {��砫� ��।� � ��ࢮ� ������� ���ᨢ� list, ����� � top}
        {��楤��� Dopoln, Show, GetTop ��᫥������ �� ��ꥪ� TStek}
        Constructor Init; {�ॡ����, �.�. ���� ����㠫�� ��⮤�}
        Procedure Udal; {㤠����� �� ��砫� - �த������� ��।�}
        Procedure ShowNext(var i: integer); Virtual;
        {�뢮� ᫥���饣� �������, � ��।� �� ��砫� � �����}
    End;
  Var
    Stek: TStek;
    Ocher: TOcher;
    b1,b2: boolean;
    m,n,k: integer;
  Constructor TStek.Init;
    Begin
      top:=0;
    End;
  Procedure TStek.Dopoln;
    Begin
      top:=top+1;
      list[top]:=knew
    End;
  Procedure TStek.Udal;
    Begin
      if top=0 then WriteLn('���᮪ ����, 㤠���� ��祣� !')
      else top:=top-1
    End;
  Function TStek.GetTop; {������ ���祭�� top}
    begin
      GetTop:=top;
    end;
  Procedure TStek.ShowNext; {�⥪ �뢮����� �� ���設� � ��砫�}
    Begin
      Write(list[i],' ');
      i:=i-1;
    End;
  Procedure TStek.Show;
  { ��᫥����� ��ꥪ⮬ TOcher, �뤠� ���ᨢ� list � ࠧ��� ���浪�,}
  { ��������� ����㠫쭮�� TStek.ShowNext � TOcher.ShowNext  }
  Var
    j: integer;
    Begin
      For j:=1 to top do
        ShowNext(ind);
        WriteLn
    End;
  Constructor TOcher.Init;
    Begin
      top:=0;
    End;
  Procedure TOcher.Udal;
  Var
    j: integer;
    Begin
      if top=0 then WriteLn('���᮪ ����, 㤠���� ��祣� !')
      else
        begin
          For j:=1 to top-1 do list[j]:=list[j+1];
          top:=top-1
        end
    End;
  Procedure TOcher.ShowNext; {��।� �뢮����� �� ��砫� � �����}
    Begin
      Write(list[i],' ');
      i:=i+1; {� �⮬ �⫨稥 �� Stek.ShowNext}
    End;
    Begin  { ��砫� �᭮���� �ணࠬ� }
      Stek.Init; {��易⥫쭮 ��� ���樠����樨 ����㠫��� ��⮤��}
      Ocher.Init;
      ClrScr;
      b1:=true;
      While b1 do
        begin
          Writeln(' �롥�� ०��:');
          Writeln('1-ࠡ�� � �⥪��');
          Writeln('2-ࠡ�� � ��।��');
          Writeln('3-����� ࠡ���');
          Readln(m);
          case m of
            1: begin
                 b2:=true;
                 While b2 do
                   begin
                     Writeln('   �롥�� ०�� ࠡ��� � �⥪��:');
                     Writeln('1-���������� � �⥪');
                     Writeln('2-㤠����� �� �⥪�');
                     Writeln('3-�뢮� �� ��࠭');
                     Writeln('4-������ � ������� ����');
                     Readln(n);
                     case n of
                       1: begin  {���������� � �⥪}
                            Write('������ ���� �������(楫�� �᫮): ');
                            ReadLn(k);
                            Stek.Dopoln(k)
                          end;
                       2: Stek.Udal;
                       3: begin
                            k:=Stek.GetTop;
                            if k>0 then Stek.Show(k)
                            else WriteLn('���᮪ ���� !')
                          end;
                       4: b2:=false
                     end
                   end
               end;
            2: begin
                 b2:=true;
                 While b2 do
                   begin
                     Writeln('   �롥�� ०�� ࠡ��� � ��।��:');
                     Writeln('1-���������� � ��।�');
                     Writeln('2-㤠����� �� ��।�');
                     Writeln('3-�뢮� �� ��࠭');
                     Writeln('4-������ � ������� ����');
                     Readln(n);
                     case n of
                       1: begin
                            Write('������ ���� �������(楫�� �᫮): ');
                            ReadLn(k);
                            Ocher.Dopoln(k)
                          end;
                       2: Ocher.Udal;
                       3: begin
                            k:=Ocher.GetTop; {��� �஢�ન �������� ��।�}
                            if k>0 then Ocher.Show(1) {��᫥����� Tstek.Show}
                            else WriteLn('���᮪ ���� !')
                            {�� ����㠫쭮�� ShowNext �뢮� � ��㣮� ���浪�}
                          end;
                       4: b2:=false
                     end
                   end
               end;
            3:   b1:=false
          end
        end
    End.