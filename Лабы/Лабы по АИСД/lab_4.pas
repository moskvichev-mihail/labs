{20. ����������� �������� ����� ���������� ��������� ������ � 
����������������� �� ����� ����� ��� ����������(10). ��������� �. ��-22}
program algoritmPrima(INPUT, OUTPUT);
const
  maxn = 100;
  infinity = 100000;
var
  i, j, u, v, n, c, min, prev1, prev2, sum: integer;
  incident, weight: array[1..maxn, 1..maxn] of integer;
  numIncident, incurtree, parent, distancetomintree: array[1..maxn] of integer;
  fileInput: text;

{��������� ����������:
incident - ������ �������������; incident[i] - ������ ������� ������ ������� i
numIncident[i] - ���������� ������, ����������� i-��� �������
weight[i,j] - ��� �����, ������������ ������� i � j
incurtree - ��������� ������, ��� �������� � ������� ����������� ����������� ������
distancetomintree[i] - ���������� ������� �� �������� ������������ ������������ ������
parent[i] - �������� i-�� ������� � ����������� ����������� ����������� ������}

begin
  {���� ����� ���: ������ ������ ����� - ���������� ������. 
  � ������ ��������� ������ - ��� ����� u, v, c. 
  ��� ��������, ��� � ����� ���������� ����� u -> v. c - ���������}
  assign(fileInput, 'in1.txt'); 
  reset(fileInput);
  readln(fileInput, n);
  while not eof(fileInput) do 
    begin
      read(fileInput, u);
      read(fileInput, v);
      readln(fileInput, c);
      inc(numIncident[u]); 
      incident[u, numIncident[u]] := v;
      inc(numIncident[v]); 
      incident[v, numIncident[v]] := u;
      weight[u, v] := c; 
      weight[v, u] := c
    end;
  close(fileInput);
  {���� ��������}
  writeln('���������� ������������ ��������� ������ ���������� � 1 �������.');
  writeln('����� �� ���������� � ������� ����������� �������, �� ������� � ����� ������� � ��������� �������.');
  writeln;
  sum := 0;
  for i := 1 to n do distancetomintree[i]:= infinity;
  distancetomintree[1] := 0;
  for i := 1 to n do
    begin
      min := infinity;
      if i <> n then
        writeln(i, ' ��������: ');
      for j := 1 to n do 
        if (incurtree[j] = 0) and (distancetomintree[j] < min) then 
        begin
          min := distancetomintree[j];
          u := j
        end;
      incurtree[u] := 1;
      for j := 1 to numIncident[u] do 
        begin  
          v := incident[u, j];
          prev1 := distancetomintree[v];
          prev2 := parent[v];
          if (incurtree[v] = 0) and (weight[u, v] < distancetomintree[v]) then 
            begin
              parent[v] := u; 
              distancetomintree[v] := weight[u, v];
              sum := sum + distancetomintree[v];
              write(v, ' �������-', distancetomintree[v], '(', parent[v], '); ');
              if prev1 > distancetomintree[v] then
                begin
                  writeln('����� ', prev1, '(', prev2, ') ', '��� ������� ', v, ' ��������� �� ����� ', distancetomintree[v], '(', parent[v], ');');
                  if prev1 <> infinity then sum := sum - prev1
                end  
            end  
        end;
      writeln  
    end;   
  writeln('������������ ����� � �����: ');  
  for i := 2 to n do writeln(i, '-', parent[i]);
  writeln('����� ��������� - ', sum)
end.
