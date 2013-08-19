const
  MAXSTRUCTWIDTH=4;
  MAXSTRUCTHEIGHT=4;
  MAXVERTEXNUM=MAXSTRUCTHEIGHT*MAXSTRUCTWIDTH;
  AREAWIDTH=600;
  AREAHEIGHT=600;
type
  EdgesWeightArr=array [1..MAXVERTEXNUM,1..MAXVERTEXNUM] of shortint;
  GraphStructArr=array [1..MAXSTRUCTWIDTH,1..MAXSTRUCTHEIGHT] of shortint;
  Graph=record
    weightArr:EdgesWeightArr;
    structArr:GraphStructArr;
    vertNum,structWidth,structHeight:byte;
  end;
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

//Var всей программы!!
var gr:graph;

function tryStringToInt(s:string;var num:integer):boolean;
  var err:integer;
  begin
    val(s,num,err);
    tryStringToInt:= err=0;
  end;
function tryStringToShortInt(s:string;var num:shortint):boolean;
  var err,temp:integer;
  begin
    if length(s)>4 then begin
      err:=4;
      num:=;
    end
    else begin
      err:=0;
      val(s,temp,err);
      if (temp>127) or (temp<-128) then begin
        
    end;
    tryStringToShortInt:= (err=0);
  end;
procedure trimStr(var s:string);
  begin
    if s<>'' then begin
      while s[1]=' ' do begin
        if s='' then break;
        if s[1]=' ' then delete(s,1,1);
      end;
      while s[length(s)]=' ' do begin
        if s='' then break;
        if s[length(s)]=' ' then delete(s,length(s),1);
      end;
    end;
  end;
function trimStrFun(s:string):string;
  begin
    trimStr(s);
    trimStrFun:=s;
  end;
procedure readStructure(var f:Text; var gr:Graph);
  var str:string;
      correctDat,EOWeghtArr:boolean;
      spacePos,inpLine:integer;
      line,column:byte;
      c:char;
      gotVertexes:byte;
  begin
    correctDat:=true;
    line:=1;
    gr.vertnum:=0;

  //READ weight array of input graph

    while not EOF(f) and ((line<>gr.vertnum+1) or (line=1)) and correctDat do begin
      readln(f,str);
      //writeln(str);
      trimStr(str);
      column:=1;
      while str<>'' do begin
        if column>MAXVERTEXNUM then begin
          correctDat:=false;
          writeln('There are number of numberes more than max number of vertex in a line in the first part of input file');
          break;
        end;
        if (column>gr.vertnum) and (gr.vertnum<>0) then begin
          correctDat:=false;
          writeln('There are number of numberes more than numbers of vertexes defined from the first line of weight array vertexes in the first part of input file');
          break;
        end;
        spacePos:=pos(' ',str);
        if spacePos=0 then spacePos:=length(str)+1;
{Используется length(str)+1, чтобы всегда работало взятие строки до
spacePos-1 ниже корректно - чтобы не обрезалась цифра в последней итерации,
когда будут только символы в строке}
        if copy(str,1,spacePos-1)='-' then gr.weightArr[line,column]:=127
        else if not tryStringToShortInt(copy(str,1,spacePos-1),gr.weightArr[line,column]) or (gr.weightArr[line,column]<-15) or (gr.weightArr[line,column]>15) then begin
          correctDat:=false;
          if gr.weightArr[line,column]<-15 then  writeln('Got number less than -15 - the minimum of edge weight');
          if gr.weightArr[line,column]>15 then  writeln('Got number greater than 15 - the maximum of edge weight');
          if gr.weightArr[line,column]=0 then writeln('Line has another simbol cipher except');
          break;
        end;
        Inc(column);
        delete(str,1,spacePos-1);
{Используется spacePos-1, поскольку иначе (просто при использовании spacePos)
при последней обработке строки, когда spacePos с нуля заменится на
length+1, и будет выход за границу строки. Пробел уберёт trim ниже}
        trimStr(str);
      end;
      if not correctDat then break;
      if gr.vertnum=0 then gr.vertnum:=column-1;
      if gr.vertnum<2 then begin
        writeln('There are less than two number of vertexes ia a line of input file');
        correctDat:=false;
        break;
      end;
      if (gr.vertnum>=column) then begin
         correctDat:=false;
         writeln('There are number of numberes less than numbers of vertexes defined from the first line of weight array vertexes in the first part of input file');
        break;
      end;
      if not correctDat then break;
      Inc(line);
    end;
    if EOF(f) then begin
      correctDat:=false;
      writeln('Got end of input file, but expected stucture of graph');
    end;
    if not correctDat then
      writeln('Incorrect data in the input file')
    else begin

    //TODO READ structure of input graph

      //for iter:=1 to
      gr.structWidth:=0;
      gr.structHeight:=0;
      line:=1;
      gotVertexes:=0;
      while not EOF(f) and (gotVertexes<>gr.vertnum) and (line<>MAXSTRUCTHEIGHT+1) and correctDat do begin
        readln(f,str);
        //writeln(str);
        trimStr(str);
        column:=1;
        while str<>'' do begin
          if column>MAXSTRUCTWIDTH then begin
            correctDat:=false;
            writeln('There are number of numberes more than max width of graph structure in a line in the second part of input file');
            break;
          end;
          if (column>gr.structWidth) and (gr.structWidth<>0) then begin
            correctDat:=false;
            writeln('There are number of numberes more than numbers of vertexes defined from the second line of weight array vertexes in the second part of input file');
            break;
          end;
          spacePos:=pos(' ',str);
          if spacePos=0 then spacePos:=length(str)+1;
  {Используется length(str)+1, чтобы всегда работало взятие строки до
  spacePos-1 ниже корректно - чтобы не обрезалась цифра в последней итерации,
  когда будут только символы в строке}
          if not tryStringToShortInt(copy(str,1,spacePos-1),gr.structArr[line,column]) then begin
            correctDat:=false;
            writeln('Line has another simbol cipher except');
            break;
          end;
          if gr.structArr[line,column]>gr.vertnum then begin
            correctDat:=false;
            writeln('Got number greater than numbers of the graph vertexes from line in the second part of input file');
            break;
          end;
          if gr.structArr[line,column]<>0 then Inc(gotVertexes);
          Inc(column);
          delete(str,1,spacePos-1);
  {Используется spacePos-1, поскольку иначе (просто при использовании spacePos)
  при последней обработке строки, когда spacePos с нуля заменится на
  length+1, и будет выход за границу строки. Пробел уберёт trim ниже}
          trimStr(str);
        end;
        if gotVertexes>gr.vertnum then begin
          writeln('There are numbers more than numbers of the graph vertexes in the second part of input file');
          correctDat:=false;
          break;
        end;
        if gotVertexes=gr.vertnum then break;
        if gr.structWidth=0 then gr.structWidth:=column-1;
        if gr.structWidth<2 then begin
          writeln('There are less than two number of vertexes ia a line of input file');
          correctDat:=false;
          break;
        end;
        if (gr.structWidth>=column) then begin
           correctDat:=false;
           writeln('There are number of numberes less than numbers of vertexes defined from the first line of weight array vertexes in the second part of input file');
          break;
        end;
        if not correctDat then break;
        Inc(line);
      end;
      gr.structHeight:=line-1;
      if EOF(f) then begin
        correctDat:=false;
        writeln('Got end of input file, but expected data of graphics');
      end;
      //while not EOF(f) and not EO
    end;
  end;


var inputFile:Text;
begin
  autoLoadFileForRead(inputFile,'D:\Programming\Pascal\[Progi new]\GraphCellularAutomaton\inputtextfile.txt');
  writeln(1);
  readStructure(inputFile,gr);
  writeln(11);
  close(inputFile);
end.
