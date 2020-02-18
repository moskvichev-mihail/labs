{ 8. Изделие задано  с  помощью  дерева. Требуется обеспечить 
корректировку   дерева  (включение,  удаление,  переименование 
вершин) в режиме диалога (10). Москвичёв Михаил ПС-22}
program OperationsWithTree(INPUT, OUTPUT);
type
  ukaz = ^host;
  host = record
           key: string;
           level: integer;
           left, right, father: ukaz
         end;

var
  tree, root, prev, temp: ukaz;
  counter, lvlVersh, k: integer;
  str: string;
  work, isFind, isCheck: boolean;
  fileInput: text;

procedure readTreeFromFile();
begin{readTreeFromFile}
  assign(fileInput, 'in.txt');
  reset(fileInput);
  new(root);
  readln(fileInput, str);
  root^.key := str;
  root^.level := 0;
  root^.father := nil;
  lvlVersh := 0;
  tree := root;
  while not eof(fileInput) do
    begin
      readln(fileInput, str);
      counter := 0;
      while (str[counter + 1] = '*') do counter := counter + 1;
      new(temp);
      temp^.key := Copy(str, counter + 1, length(str) - counter);
      temp^.left := nil;
      temp^.right := nil;
      temp^.level := counter;
      if counter > lvlVersh then
        begin
          tree^.left := temp;
          temp^.father := tree
        end
      else if counter = lvlVersh then
        begin
          tree^.right := temp;
          temp^.father := tree^.father
        end
      else
        begin
          prev := tree;
          for k := 1 to lvlVersh - counter do prev := prev^.father;
          temp^.father := prev^.father;
          prev^.right := temp
        end;
      lvlVersh := counter;
      tree := temp
    end;
  close(fileInput)
end;{readTreeFromFile}

procedure insert(var t: ukaz; st: string; var isfind: boolean);
var
  p, a: ukaz;
  s: string;
  
  procedure check(var v: ukaz; u: string; var w: boolean);
  begin{check}
    if (v <> nil) and (not w) then
      begin
        if v^.key = u then w := true
        else
          begin
            check(v^.left, u, w);
            check(v^.right, u, w)
          end  
      end
  end;{check}
  
begin{insert}
  p := t;  
  if (t <> nil) and (not isfind) then
    begin
      if t^.key = st then 
        begin
          writeln('Введите название новой вершины: ');
          readln(s);
          ischeck := false;
          check(root, s, ischeck);
          while ischeck do
            begin
              writeln('Такая вершина уже есть, введите новое название: ');
              readln(s);
              ischeck := false;
              check(root, s, ischeck)
            end;
          New(a);  
          a^.key := s; 
          a^.left := nil; 
          a^.right := nil;
          a^.father := p;
          a^.level := p^.level + 1;
          if p <> nil then
            begin   
              while p <> nil do
                if a^.key < p^.key then
                  if p^.left = nil then 
                    begin 
                      p^.left := a; 
                      p := a^.left
                    end 
                  else p := p^.left
                    else if p^.right = nil then 
                      begin 
                        p^.right := a; 
                        p := a^.right 
                      end 
                    else p := p^.right
            end;
          isfind := true
        end
      else
        begin
          insert(t^.left, st, isfind);
          insert(t^.right, st, isfind)
        end  
    end 
end;{insert}

procedure insertsmall(var t: ukaz);
var
  s: string;
  a: ukaz;
  ischeck: boolean;
  
  procedure check(v: ukaz; u: string; w: boolean);
  begin{check}
    if (v <> nil) and (not w) then
      begin
        if v^.key = u then w := true
        else
          begin
            check(v^.left, u, w);
            check(v^.right, u, w)
          end  
      end
  end;{check}
  
begin{insertsmall}
  writeln('Введите название вершины для пустого дерева: ');
  readln(s);
  ischeck := false;
  check(root, s, ischeck);
  while ischeck do
    begin
      writeln('Такая вершина уже есть, введите новое название: ');
      readln(s);
      ischeck := false;
      check(root, s, ischeck)
    end;
  New(a);
  a^.key := s;       
  a^.left := nil; 
  a^.right := nil;
  a^.father := nil;
  a^.level := 0;
  root := a
end;{insertsmall}     

procedure find(var t: ukaz; st: string; var isfind: boolean);
begin{find}
  if (t <> nil) and (not isfind) then
    begin
      if t^.key = st then isfind := true
      else
        begin
          find(t^.left, st, isfind);
          find(t^.right, st, isfind)
        end  
    end
end;{find}

procedure rename(var t: ukaz; st: string; var isfind: boolean);
var
  s: string;
  ischeck: boolean;
  
  procedure check(var v: ukaz; u: string; var w: boolean);
  begin{check}
    if (v <> nil) and (not w) then
      begin
        if v^.key = u then w := true
        else
          begin
            check(v^.left, u, w);
            check(v^.right, u, w)
          end  
      end
  end;{check}
  
begin{rename}
  if (t <> nil) and (not isfind) then
    begin
      if t^.key = st then 
        begin
          writeln('Введите новое название вершины: ');
          readln(s);
          ischeck := false;
          check(root, s, ischeck);
          while ischeck do
            begin
              writeln('Такая вершина уже есть, введите новое название: ');
              readln(s);
              ischeck := false;
              check(root, s, ischeck)
            end;
          t^.key := s;
          isfind := true
        end  
      else
        begin
          rename(t^.left, st, isfind);
          rename(t^.right, st, isfind)
        end  
    end
end;{rename}

procedure destroysmall(var t: ukaz);
begin{destroysmall}
  if t <> nil then    
    begin
      destroysmall(t^.left);
      destroysmall(t^.right);
      Dispose(t);
      t := nil
    end
end;{destroysmall}   

procedure delete(var t: ukaz; st: string; isfind: boolean);
var
  p, q, s: ukaz; 
begin{delete}
  if (t <> nil) and (not isfind) then
    begin
      if t^.key = st then 
        begin
          p := t;
          if p = root then
            destroysmall(root)
          else
            begin  
              q := p^.father;
              s := q^.left;
              if (s^.right = p) then
                s^.right := nil
              else if (s^.left = p) then
                s^.left := nil  
              else if (q^.left = p) then
                q^.left := nil
              else if (q^.right = p) then
                q^.right := nil;  
              p^.level := 0;
              p^.key := ''; 
              p^.left := nil;
              p^.right := nil;
              p^.father := nil;
              p := nil;
              Dispose(p)
            end;    
          isfind := true
        end  
      else
        begin
          delete(t^.left, st, isfind);
          delete(t^.right, st, isfind)
        end  
    end
end;{delete}        

procedure printTree(var t: ukaz);
var
  i: integer;
begin{printTree}
  if t <> nil then
    begin
      for i := 1 to t^.level do
        write('.');
      if t^.key <> '' then  
        writeln(t^.key); 
      printTree(t^.left);
      printTree(t^.right)
    end  
end;{printTree}

begin{OperationsWithTree}
  readTreeFromFile();
  writeln('Доступные команды: insert, rename, delete, print, help, exit.');
  str := '';
  work := true;
  while work do
    begin 
      while str = '' do
        readln(str);
      if str = 'insert' then
        begin
          if root = nil then
            insertsmall(root)
          else
            begin  
              writeln('Введите название вершины, к которой добавляется элемент: ');
              readln(str);
              isFind := false;
              insert(root, str, isFind)
            end;  
          isFind := false;
          find(root, str, isFind);
          if isFind then
            writeln('Вершина успешно добавлена.')
          else writeln('Ошибка. Вершина не добавлена.');  
          readln(str)
        end
      else if str = 'rename' then
        begin
          isFind := false;
          writeln('Введите название вершины, которую хотите переименовать: ');
          readln(str);
          find(root, str, isFind);
          if isFind then
            begin
              isFind := false;
              rename(root, str, isFind);
              writeln('Вершина успешно переименована.')
            end
          else writeln('Ошибка. Вершины нет в дереве.');
          readln(str)
        end
      else if str = 'delete' then
        begin
          isFind := false;
          writeln('Введите название вершины, которую хотите удалить: ');
          readln(str);
          find(root, str, isFind);
          if isFind then
            begin
              isFind := false;
              delete(root, str, isFind);
              writeln('Вершина успешно удалена.')
            end
          else writeln('Ошибка. Вершины нет в дереве.');    
          readln(str)
        end
      else if str = 'print' then
        begin
          printTree(root);
          readln(str)
        end    
      else if str = 'help' then
        begin
          writeln('Существующие команды: "insert" - для вставки элемента в дерево, "rename" - для переименования элемента, "delete" - для удаления элемента, "print" -  для печати дерева и "exit" - для выхода из программы.');
          readln(str)
        end
      else if str = 'exit' then
        work := false    
      else
        begin 
          writeln('Данной команды не существует, для вызова справки введите "help".');
          readln(str)
        end   
  end
end.{OperationsWithTree}
