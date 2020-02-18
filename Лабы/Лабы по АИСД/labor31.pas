{ 8. Изделие задано  с  помощью  дерева. Требуется обеспечить 
корректировку   дерева  (включение,  удаление,  переименование 
вершин) в режиме диалога (11). Москвичёв Михаил ПС-22}
program OperationsWithTree(INPUT, OUTPUT);
type
  ukaz = ^host;
  host = record
           key: string;
           level: integer;
           left, right, father: ukaz
         end;

var
  tree, root, prev, temp, curr: ukaz;
  counter, lvlVersh, k: integer;
  int: char;
  str: string;
  work, isExist, isOne: boolean;
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

procedure find(var t: ukaz; st: string);
begin{find}
  if t <> nil then
    begin
      if t^.key = st then
      begin
        curr := t;
        exit;
      end;
      find(t^.left, st);
      find(t^.right, st)
    end
end;{find}

procedure choose(var st: string);
begin{choose}
  writeln('Введите имя элемента: ');
  readln(st);
  curr := nil;
  find(root, st);
  if curr <> nil then
    begin
      writeln('Вы выбрали элемент: ', curr^.key);
      isExist := true
    end
    else writeln('Данный элемент отсутствует в дереве.')
end;{choose}

procedure check(var t: ukaz; st: string);
begin{check}
  isOne := true;
  if t <> nil then
    begin
      if t^.key = st then
      begin
        writeln('Данная вершина уже присутствует в дереве.');
        isOne := false;
        exit
      end;
      check(t^.left, st);
      check(t^.right, st)
    end
end;{check}

procedure insertsmall(var t: ukaz; st: string; int: integer; father: ukaz);
begin{insertsmall}
  if t = nil then
    begin
      new(t);
      t^.key := st;
      t^.left := nil;
      t^.right := nil;
      t^.father := father;
      t^.level := int;
      exit
    end
  else if st < t^.key then insertsmall(t^.left, st, int,  father)
  else insertsmall(t^.right, st, int, father)
end;{insertsmall}

procedure insert(var t: ukaz);
var
  integ: integer;
begin{insert}
  if t <> nil then
    begin
      if t = curr then
        begin
          writeln('Введите имя вершины, которую хотите добавить: ');
          readln(str);
          check(root, str);
          if isOne then
            begin  
              integ := t^.level + 1;
              insertsmall(t, str, integ, t);
              writeln('Вершина успешно добавлена.') 
            end;
          isExist := false
        end;
        insert(t^.left);
        insert(t^.right) 
    end
end;{insert}

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

procedure delete(var t: ukaz);
begin{delete}
  if (t <> nil) then 
  begin
    if curr = t then
    begin
      destroysmall(t);
      writeln('Вершина успешно удалена.');
      isExist := false;
      exit
    end;
    delete(t^.left);
    delete(t^.right)
  end
end;{delete}

procedure rename(var t: ukaz);
var
  s: string;
begin{rename}
  if t <> nil then
  begin
    if t = curr then
      begin
        writeln('Введите новое название вершины: ');
        readln(s);
        check(root, s);
        if isOne then
          begin 
            t^.key := s;
            writeln('Вершина успешно переименована.')
          end;  
        isExist := false;
        exit
      end;  
      rename(t^.left);
      rename(t^.right)  
  end
end;{rename}

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

procedure menu();
begin{menu}
  writeln('1) choose - Выбрать вершину.');
  writeln('2) insert - Добавить вершину.');
  writeln('3) delete - Удалить вершину.');
  writeln('4) rename - Переименовать вершину.');
  writeln('5) print - Напечатать дерево.');
  writeln('0) exit - Выход.');
  isOne := false;
  isExist := false;
  work := true;
  while work do
    begin
      readln(int);
      case int of
        '1': choose(str);
        '2': if isExist then insert(root)
             else writeln('Ошибка. Не выбрана вершина, к которой нужно добавлять.');
        '3': if isExist then delete(root)
             else writeln('Ошибка. Не выбрана вершина, которую нужно удалить.');
        '4': if isExist then rename(root)
             else writeln('Ошибка. Не выбрана вершина, которую нужно переименовать.');
        '5': printTree(root);
        '0': work := false
        else writeln('Данной команды не существует.')
      end
    end
end;{menu}

begin{OperationsWithTree}
  readTreeFromFile();
  menu()
end.{OperationsWithTree}
