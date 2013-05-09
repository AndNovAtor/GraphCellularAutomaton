procedure loadFile(var textFile:text);
  var path,name:string;
  begin
    writeln('Enter full path for a necessary TEXT file. For example, C:\Users\Public');
    readln(path);
    writeln('Enter file name. For example, filename.txt');
    readln(name);
    assign(textFile,path+'\'+name);
  end;
procedure autoLoadFile(var textFile:text;fullPath:string);
  begin
    assign(textFile,fullPath);
  end;
procedure loadFileForRead(var textFile:text);
  begin 
    loadFile(textFile);
    Reset(textFile);
  end;
procedure loadFileForWrite(var textFile:text);
  begin 
    loadFile(textFile);
    Rewrite(textFile);
  end;
procedure autoLoadFileForRead(var textFile:text;fullPath:string);
  begin 
    autoLoadFile(textFile,fullPath);
    Reset(textFile);
  end;
procedure autoLoadFileForWrite(var textFile:text;fullPath:string);
  begin 
    autoLoadFile(textFile,fullPath);
    Rewrite(textFile);
  end;
var inputFile:Text;
begin
  autoLoadFileForRead(inputFile,'D:\Programming\Pascal\[Progi new]\Graph Cellular automaton\inputtextfile.txt');
  close(inputFile);
  autoLoadFileForWrite(inputFile,'D:\Programming\Pascal\[Progi new]\Graph Cellular automaton\inputtextfile.txt');
  write(inputFile,'rrr ');
  writeln(inputFile,'a');
  writeln(inputFile,'f');
  close(inputFile);
end.