unit StFunctions;

{Version 1.0.1.9}

interface
uses Classes, System.SysUtils;

function PointToDecimalSeparator(S:String):string;
Function EditNumbersDC(Key:char;Text:string):char;
Function EditNumbers(Key:char):char;

type
  Tlog=class (TStringList)
  Procedure AddToLog(S:String='');
  Procedure LogOK;
  procedure Fail(Reason:string='Неизвестно почему :-(');
  Procedure SaveLog(FileName:String);
  Procedure Zero(ProgramName:string);
  end;

var
  Log:TLog;

implementation

{Subversion 1.0.0.1}
function PointToDecimalSeparator(S: string): string;
var
  N:integer;
begin
Result:=S;
N:=pos(',',s);
if N<>0 then Result[N]:=FormatSettings.DecimalSeparator;
N:=pos('.',s);
if N<>0 then Result[N]:=FormatSettings.DecimalSeparator;
end;

Function EditNumbersDC(Key:char;Text:string):char;
var
  i:integer;
  DC:boolean;
begin
Result:=Key;
if not (key in['0'..'9','.',',',#8,#9]) then Result:=#0;
if key in ['.', ','] then
  begin
  Result:=FormatSettings.DecimalSeparator;
  DC:=false;
  for i := 1 to Length(Text) do
    if Text[i]=FormatSettings.DecimalSeparator then DC:=true;
  if DC then Result:=#0;
  end;
end;


Function EditNumbers(Key:char):char;
begin
Result:=Key;
if not (key in['0'..'9',#8,#9]) then Result:=#0;
end;

{Subversion 1.0.0.4}
Procedure TLog.AddToLog(S:String);
begin
if S='' then
  begin
  Add('');
  Exit;
  end;
if S='--' then
  begin
  Add('----------------------------------------------------------');
  Exit;
  end;
if S='==' then
  begin
  Add('==========================================================');
  Exit;
  end;

Add('['+DateTimeToStr(Now)+'] -> '+S);
end;

{Subversion 1.0.0.1}
procedure Tlog.Fail(Reason: string);
begin
self[Count-1]:=self[Count-1]+' -> FAILED -> Причина: '+Reason;
end;

{Subversion 1.0.0.1}
Procedure TLog.LogOK;
begin
self[Count-1]:=self[Count-1]+' -> O.K.';
end;

{Subversion 1.0.0.1}
procedure TLog.SaveLog(FileName: String);
begin
SaveToFile(FileName);
end;

{Subversion 1.0.0.1}
procedure Tlog.Zero(ProgramName: string);
begin
Clear;
Add('Журнал работы программы «'+ProgramName+'»');
Add('');
end;

end.
