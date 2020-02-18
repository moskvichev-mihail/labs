{20. –еализовать алгоритм ѕрима нахождени€ остовного дерева и 
проиллюстрировать по шагам этапы его выполнени€(10). ћосквичЄв ћ. ѕ—-22}
program algoritmPrima(INPUT, OUTPUT);
const
  maxn = 100;
  infinity = 100000;
var
  i, j, u, v, n, c, min, prev1, prev2, sum: integer;
  incident, weight: array[1..maxn, 1..maxn] of integer;
  numIncident, incurtree, parent, distancetomintree: array[1..maxn] of integer;
  fileInput: text;

{ѕо€снени€ переменных:
incident - списки инцидентности; incident[i] - список смежных вершин вершины i
numIncident[i] - количество вершин, инцидентных i-той вершине
weight[i,j] - вес ребра, соедин€ющего вершины i и j
incurtree - множество вершин, уже вход€щих в текущее минимальное покрывающее дерево
distancetomintree[i] - рассто€ние вершины до текущего минимального покрывающего дерева
parent[i] - родитель i-ой вершины в построенном минимальном покрывающем дереве}

begin
  {граф задан так: перва€ строка файла - количество вершин. 
  ¬ каждой следующей строке - три числа u, v, c. 
  Ёто означает, что в графе существует ребро u -> v. c - стоимость}
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
  {граф прочитан}
  writeln('Ќахождение минимального остовного дерева начинаетс€ с 1 вершины.');
  writeln('–€дом со стоимостью в скобках указываетс€ вершина, из которой и можно попасть в указанную вершину.');
  writeln;
  sum := 0;
  for i := 1 to n do distancetomintree[i]:= infinity;
  distancetomintree[1] := 0;
  for i := 1 to n do
    begin
      min := infinity;
      if i <> n then
        writeln(i, ' итераци€: ');
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
              write(v, ' вершина-', distancetomintree[v], '(', parent[v], '); ');
              if prev1 > distancetomintree[v] then
                begin
                  writeln('ћетка ', prev1, '(', prev2, ') ', 'при вершине ', v, ' сменилась на метку ', distancetomintree[v], '(', parent[v], ');');
                  if prev1 <> infinity then sum := sum - prev1
                end  
            end  
        end;
      writeln  
    end;   
  writeln('ѕолучившиес€ св€зи в графе: ');  
  for i := 2 to n do writeln(i, '-', parent[i]);
  writeln('ќбща€ стоимость - ', sum)
end.
