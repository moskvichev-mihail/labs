{14. Составить программу поиска записи с включением в сбалансированном
бинарном дереве поиска(АВЛ-дереве)(11). Москвичёв М. ПС-22}
program AVLaddelem(INPUT, OUTPUT);
type 
  ukaz = ^host;
  host = record
           key, balance, count: integer;
           left, right: ukaz
         end;
          
var 
  tree: ukaz;
  int, select, lvlnum: integer;
  fileInput: text;

  procedure LLrotate(var root: ukaz);
  var
    Lbranch: ukaz;
  begin{LLrotate}
    Lbranch := root^.left;
    if (Lbranch^.balance = -1) then
      begin
        Lbranch^.balance := 0;
        root^.balance := 0
      end
    else
      begin
        Lbranch^.balance := 1;
        root^.balance := -1
      end;
    root^.left := Lbranch^.right;
    Lbranch^.right := root;
    root := Lbranch
  end;{LLrotate}

  procedure RRrotate(var root: ukaz);
  var 
    Rbranch: ukaz;
  begin{RRrotate}
    Rbranch := root^.right;
    if (Rbranch^.balance = 1) then
      begin
        Rbranch^.balance := 0;
        root^.balance := 0
      end
    else
      begin
        Rbranch^.balance := -1;
        root^.balance := 1
      end;
    root^.right := Rbranch^.left;
    Rbranch^.left := root;
    root := Rbranch
  end;{RRrotate}

  procedure LRrotate(var root: ukaz);
  var 
    Lbranch, LRbranch: ukaz;
  begin{LRrotate}
    Lbranch := root^.left;
    LRbranch := Lbranch^.right;
    if (LRbranch^.balance = 1) then
      Lbranch^.balance:=-1
    else
      Lbranch^.balance := 0;
    if (LRbranch^.balance = -1) then
      root^.balance := 1
    else
      root^.balance := 0;
    LRbranch^.balance := 0;
    root^.left := LRbranch^.right;
    Lbranch^.right := LRbranch^.left;
    LRbranch^.left := Lbranch;
    LRbranch^.right := root;
    root := LRbranch
  end;{LRrotate}

  procedure RLrotate(var root: ukaz);
  var
    Rbranch, RLbranch: ukaz;
  begin{RLrotate}
    Rbranch := root^.right;
    RLbranch := Rbranch^.left;
    if (RLbranch^.balance = -1) then
      Rbranch^.balance := 1
    else
      Rbranch^.balance := 0;
    if (RLbranch^.balance = 1) then
      root^.balance := -1
    else
      root^.balance := 0;
    RLbranch^.balance := 0;
    root^.right := RLbranch^.left;
    Rbranch^.left := RLbranch^.right;
    RLbranch^.right := Rbranch;
    RLbranch^.left := root;
    root := RLbranch
  end;{RLrotate}

  procedure RebalanceTree(var root: ukaz; var rebalance: boolean);
  var 
    branch: ukaz;
  begin{RebalanceTree}
    if (root^.balance = -1) then
      begin
  	    branch := root^.left;
	    if (branch^.balance = -1) or (branch^.balance = 0) then
	      begin
		    LLrotate(root);
		    rebalance := false
		  end
	    else if (branch^.balance = 1) then
	      begin
	        LRrotate(root);
		    rebalance := false
	      end
	  end
    else if (root^.balance = 1) then
	  begin
	    branch := root^.right;
	    if (branch^.balance = 1) or (branch^.balance = 0) then
	      begin
		    RRrotate(root);
		    rebalance := false
		  end
        else if (branch^.balance = -1) then
	      begin
	        RLrotate(root);
	        rebalance := false
	      end
	  end
  end;{RebalanceTree}

  procedure TurnLeft(var root: ukaz; var rebalance: boolean);
  begin{TurnLeft}
    case root^.balance of
      -1 : RebalanceTree(root, rebalance);
	  0 : begin
	        root^.balance := -1;
		    rebalance := true
	      end;
	  1 : begin
	        root^.balance := 0;
		    rebalance := false
	      end
    end
  end;{TurnLeft}

  procedure TurnRight(var root: ukaz; var rebalance: boolean);
  begin{TurnRight}
    case root^.balance of
      -1 : begin
	         root^.balance := 0;
		     rebalance := false
           end;
	  0 : begin
	        root^.balance := 1;
		    rebalance := true
	      end;
	  1: RebalanceTree(root, rebalance)
    end
  end;{TurnRight}

  procedure addelem(var root: ukaz; key: integer; var rebalance: boolean);
  var 
    elem: ukaz;
	rebalancethiselem: boolean;
  begin{addelem}
    if (root = nil) then
      begin
        new(elem);
        elem^.left := nil;
        elem^.right := nil;
        elem^.key := key;
        elem^.balance := 0;
        elem^.count := 1;
        rebalance := true;
        root := elem
	  end
    else
      begin
	    if (key < root^.key) then
	      begin
		    addelem(root^.left, key, rebalancethiselem);
		    if (rebalancethiselem) then
              TurnLeft(root, rebalance)
		    else
		      rebalance := false
		   end
	    else if (key > root^.key) then
		  begin
		    addelem(root^.right, key, rebalancethiselem);
		    if (rebalancethiselem) then
              TurnRight(root, rebalance)
		    else
		      rebalance := false
		  end
		else if (key = root^.key) then
          root^.count := root^.count + 1  
      end
  end;{addelem}

  procedure addelement(var root: ukaz; key: integer);
  var 
    rebalance: boolean;
  begin{addelement}
    rebalance := false;
    addelem(root, key, rebalance)
  end;{addelement}

  procedure printTree(root: ukaz; lvlnum: integer);
  var
    i: integer;
  begin{printTree}
    if (root <> NIL) then
      begin
        for i := 1 to lvlnum do
          write('.');
        if root^.count > 1 then
          writeln(root^.key, ', кол-во: ', root^.count)
        else    
          writeln(root^.key);  
	    printTree(root^.left, lvlnum + 1);
	    printTree(root^.right, lvlnum + 1)
	  end 
  end;{printTree}

  procedure showmenu;
  begin{showmenu}
	writeln('1) Добавить элемент в дерево');
	writeln('2) Распечатать дерево в виде корень - левая ветвь - правая ветвь (КЛП)');
    writeln('3) Выход');
	writeln;
	write('Введите команду: ')
  end;{showmenu}
  
  function getint(ident: string): integer;
  var 
    s: integer;
  begin{getint}
    write('Введите ', ident);
    readln(s);
    getint := s
  end;{getint}

begin{AVLaddelem}
  tree := nil;
  lvlnum := 0;
  assign(fileInput, 'in.txt');
  reset(fileInput);
  while (not eof(fileInput)) do
    begin
      readln(fileInput, int);
      addelement(tree, int)
    end;
  close(fileInput); 
  repeat
    showmenu;
    readln(select);
    writeln;
    case select of
	  1: addelement(tree, getint('элемент, который хотите добавить: '));
	  2: printTree(tree, lvlnum)
	end;
  until select = 3
end.{AVLaddelem}
