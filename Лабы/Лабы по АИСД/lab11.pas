program number(input, output);
var
  a, del: string;
  i, max: integer;
  fileInput, fileOutput: text;
begin{number}
  assign(fileInput, 'input.txt');
  reset(fileInput);
  assign(fileOutput, 'output.txt');
  rewrite(fileOutput);
  readln(fileInput, max);
  readln(fileInput, a);
  for i := 1 to max do
    begin
      del := a[i];
      if del >= a[i+1] then
        del := a[i+1]
    end;  
  writeln(fileOutput, del)
end.{number}
