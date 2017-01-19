unit ReportLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  SQLite3, SQLiteTable3, math;

type
  TReport = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    DateFrom: TDateTimePicker;
    Label2: TLabel;
    DateTo: TDateTimePicker;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo: TMemo;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    ProgressBar1: TProgressBar;
    PB_Timer: TTimer;
    SD: TSaveDialog;
    procedure Prepare;
    procedure Button2Click(Sender: TObject);
    procedure CreateReport(Sender: TObject);
    procedure PB_TimerTimer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Report: TReport;
  PB:Integer;
  Tasks_List,Tasks_List_N,Tasks_List_PH,
    P_Tasks_List,P_Tasks_List_N,P_Tasks_List_NS:TStringList;

const
  StrLine=60;

implementation

{$R *.dfm}

uses MainMenu;

{ TReport }

function DevideString(StringToDevide:string; var RightPart:string):string;
var
  I:Integer;
begin
if StringToDevide.Length<=StrLine then
  begin
  DevideString:=StringToDevide;
  RightPart:='';
  exit;
  end;
I:=60;
while (StringToDevide[I]<>' ') and (I>0) do dec(I);
DevideString:=Copy(StringToDevide,0,I-1);
RightPart:=Copy(StringToDevide,I+1,StringToDevide.Length-1);
end;

procedure TReport.Button3Click(Sender: TObject);
begin
if SD.Execute then
  begin
  Memo.Lines.SaveToFile(SD.FileName);
  end;
end;

procedure TReport.CreateReport(Sender: TObject);
var
  Table, Tasks, Org, NIR:TSQLiteTable;
  DateFrom_Str, DateTo_Str:string;
  SpectraReg:integer;
  I: Integer;
  WHERE_Date:string;

const
  MultiSpectra: array [0..1] of string = ('SUM(`Number`)','COUNT(*)');
  DEBUG=false;

  procedure GetDateInterval;
  begin
  DateTimeToString(DateFrom_Str,'yyyy-mm-dd',DateFrom.Date);
  DateTimeToString(DateTo_Str,'yyyy-mm-dd',DateTo.Date);
  WHERE_Date:=' (`Date` BETWEEN "'+DateFrom_Str+'" AND "'+DateTo_Str+'")';
  end;

  procedure M_Add(S:String);
  begin
  Memo.Lines.Add(S);
  end;

  procedure DEBUG_Add(S:String);
  begin
  if DEBUG then Memo.Lines.Add(S);
  end;

  Function To40Symb(S:String):string;
  begin
  if Length(s)<40 then Result:=s+StringOfChar(' ',40-Length(s));
  end;

  procedure TitleShow;
  begin
  M_Add('============================================================');
  M_Add('||                                                        ||');
  M_Add('||             �������� ������������� �������             ||');
  M_Add('||                  ��. �.� �����������                   ||');
  M_Add('||                        ��� ���                         ||');
  M_Add('||                                                        ||');
  M_Add('============================================================');
  M_Add('');
  M_Add('��������� ������:');
  M_Add(' - �������� ������:      '+Config.ReadString('General','Title','ERROR!!!'));
  M_Add(' - �������� ���:         '+
    DateToStr(DateFrom.Date)+' � '+DateToStr(DateTo.Date));
  M_Add(' - ���� �������� ������: '+DateTimeToStr(Now));
  M_Add('');
  M_Add('');
  end;

  procedure CountTotalSpectra;
  begin
  //������ �� ����� ���������� ��������
  Table:=GetTable('SELECT SUM(`Number`) AS NumSpectra FROM `Spectra` WHERE'+
    WHERE_Date+';');
  if Table.Count=0 then
    begin
    Table.Free;
    SpectraReg:=0;
    end
   else
    begin
    SpectraReg:=Table.FieldAsInteger(Table.FieldIndex['NumSpectra']);
    Table.Free;
    end;

  M_Add(' - ���������������� ��������:           '+IntToStr(SpectraReg));
  end;

  procedure CountTotalTime;
  var
    TotalTime:Double;
    TotalTasks: Integer;
    NN:Integer;
    T:Double;
    I:Integer;
  begin
  TotalTime:=0;
  Tasks:=GetTable('SELECT * FROM `Task`');
   if Tasks.Count=0 then
     begin
     Tasks.Free;
     M_Add('!!!  ������� �� ����������!');
     end
    else
     begin
     Tasks_List:=TStringList.Create;
     Tasks_List_N:=TStringList.Create;
     Tasks_List_PH:=TStringList.Create;
     for I := 0 to Tasks.Count-1 do
       begin
       Table:=GetTable('SELECT '+
         MultiSpectra[Tasks.FieldAsInteger(Tasks.FieldIndex['Multispectra'])]+
         ' AS N FROM `Spectra` WHERE (`Task`='+
         IntToStr(Tasks.FieldAsInteger(Tasks.FieldIndex['ID']))+') AND'+
         WHERE_Date+';');

       NN:=Table.FieldAsInteger(Table.FieldIndex['N']);
       T:=Tasks.FieldAsDouble(Tasks.FieldIndex['Time']);

       TotalTime:=TotalTime+NN*T;
       TotalTasks := TotalTasks + NN;
       Tasks_List.Add(To40Symb(' - '+
         UTF8Decode(Tasks.FieldAsString(Tasks.FieldIndex['Name']))+':')+
         FloatToStr(roundTo(NN*T,-1)));
       Tasks_List_N.Add(To40Symb(' - '+
         UTF8Decode(Tasks.FieldAsString(Tasks.FieldIndex['Name']))+':')+
         IntToStr(NN));
       Tasks_List_PH.Add(To40Symb(' - '+
         UTF8Decode(Tasks.FieldAsString(Tasks.FieldIndex['Name']))+':')+
         FloatToStr(roundTo(T,-1)));

       Tasks.Next;
       end;

     M_Add(To40Symb(' - ����� ��������� �����:')+IntToStr(TotalTasks));
     M_Add(To40Symb(' - ����� ����� ������:')+FloatToStr(roundTo(TotalTime, -1))+' �����');
     end;
  Tasks.Free;
  end;

  procedure TotalWorkShow;
  begin
  M_Add('============================================================');
  M_Add('                ����� ���������� �� �������:                ');
  M_Add('');
  M_Add('�� ��������������� ���������� ��������� ��������� ������:   ');

  CountTotalSpectra;

  inc(PB);     //3
  CountTotalTime;
  M_Add('');
  M_Add('');
  end;

  procedure ShowTotalTasks;
  var
    I:Integer;
  begin
  M_Add('============================================================');
  M_Add('                ����� ����� ���������� �����:               ');
  M_Add('');
  for I := 0 to Tasks_List.Count-1 do
    M_Add(Tasks_List[I]);

  M_Add('');
  M_Add('');
  end;

  procedure ShowTotalTasksN;
  var
    I:Integer;
  begin
  M_Add('============================================================');
  M_Add('               ����� ����� ����������� �����:               ');
  M_Add('');
  for I := 0 to Tasks_List_N.Count-1 do
    M_Add(Tasks_List_N[I]);

  M_Add('');
  M_Add('');
  end;

  procedure ShowTaskTime;
  var
    I:Integer;
  begin
  M_Add('============================================================');
  M_Add('               ����� ���������� ����� ������:               ');
  M_Add('');
  for I := 0 to Tasks_List_PH.Count-1 do
    M_Add(Tasks_List_PH[I]);

  M_Add('');
  M_Add('');
  end;

  procedure Organizations;
  var
    I, I1, NN, TotalNN:Integer;
    S1, NSpectra:string;
    TotalTime, T:Double;
    ExtOrg, InnerJoin: string;


    procedure GetTasks;
    var I2:Integer;

    begin
    P_Tasks_List:=TStringList.Create;
    P_Tasks_List_N:=TStringList.Create;
    P_Tasks_List_NS:=TStringList.Create;
    TotalTime:=0;
    TotalNN:=0;

    Tasks:=GetTable('SELECT * FROM `Task`');
    if Tasks.Count=0 then
      begin
      Tasks.Free;
      M_Add('!!!  ������� �� ����������!');
      end
     else
      begin
      for I2 := 0 to Tasks.Count-1 do
        begin

      Table:=GetTable('SELECT '+
         MultiSpectra[Tasks.FieldAsInteger(Tasks.FieldIndex['Multispectra'])]+
         ' AS N FROM `Spectra`' + InnerJoin + ' WHERE (`Task`='+
         IntToStr(Tasks.FieldAsInteger(Tasks.FieldIndex['ID']))+') AND'+
         WHERE_Date+' AND (`Organization`='+ Org.FieldAsString(Org.FieldIndex['ID'])
         +')' + ExtOrg + ';');

       NN:=Table.FieldAsInteger(Table.FieldIndex['N']);
       T:=Tasks.FieldAsDouble(Tasks.FieldIndex['Time']);

       TotalTime:=TotalTime+NN*T;
       inc(TotalNN,NN);

       P_Tasks_List.Add(To40Symb('   - '+
         UTF8Decode(Tasks.FieldAsString(Tasks.FieldIndex['Name']))+':')+
         FloatToStr(roundTo(NN*T,-1))+' �����');
       P_Tasks_List_N.Add(To40Symb('   - '+
         UTF8Decode(Tasks.FieldAsString(Tasks.FieldIndex['Name']))+':')+
         IntToStr(NN));

       Table.Free;


       Table:=GetTable('SELECT SUM(`Number`) AS N FROM `Spectra`' + InnerJoin +
         ' WHERE (`Task`='+
         IntToStr(Tasks.FieldAsInteger(Tasks.FieldIndex['ID']))+') AND'+
         WHERE_Date+' AND (`Organization`='+ Org.FieldAsString(Org.FieldIndex['ID'])
         +')' + ExtOrg + ';');

       P_Tasks_List_NS.Add(To40Symb('   - '+
         UTF8Decode(Tasks.FieldAsString(Tasks.FieldIndex['Name']))+':')+
         Table.FieldAsString(Table.FieldIndex['N']));

       Table.Free;

       Tasks.Next;
        end;
      end;

    for I2 := 0 to P_Tasks_List_NS.Count-1 do
      M_Add(P_Tasks_List_NS[I2]);
    M_Add('');

    M_Add(To40Symb(' - ����� ��������� �����:')+IntToStr(TotalNN));

    for I2 := 0 to P_Tasks_List.Count-1 do
      M_Add(P_Tasks_List_N[I2]);
    M_Add('');

    M_Add(To40Symb(' - ����� ����� ������:')+FloatToStr(roundTo(TotalTime, -1))+' �����');

    for I2 := 0 to P_Tasks_List.Count-1 do
      M_Add(P_Tasks_List[I2]);



    P_Tasks_List.Free;
    P_Tasks_List_N.Free;
    P_Tasks_List_NS.Free;
    end;



    procedure GetNIR(ExternalOrg: string = '0');
    var
      I2: Integer;
    begin
    NIR:=GetTable('SELECT * FROM `NIR` WHERE `External`=' + ExternalOrg);

    if NIR.Count=0 then
      begin
      NIR.Free;
      M_Add('!!!  ��� �� ����������!');
      exit;
      end;

    M_Add(' - ��� �����������');

    for I2 := 0 to NIR.Count-1 do
      begin
      S1:='SELECT COUNT(`Number`) AS N FROM `Spectra` '+
        'WHERE (`Organization`='+Org.FieldAsString(Org.FieldIndex['ID'])+') '+
        'AND (`NIR`='+NIR.FieldAsString(NIR.FieldIndex['ID'])+ ') '+
        'AND'+WHERE_Date;
      Table:=GetTable(S1);

      DEBUG_Add('     ------- DEBUG ------- S1='+S1);

      if (Table.Count=0) or (Table.FieldAsInteger(Table.FieldIndex['N'])=0)
        then begin NIR.Next; Continue; end;

      S1:='   - '+UTF8Decode(NIR.FieldAsString(NIR.FieldIndex['Num'])) + ' (' +
      UTF8Decode(NIR.FieldAsString(NIR.FieldIndex['Comment'])) + ')';
        repeat
        M_Add(DevideString(S1,S1));
        S1:='     '+S1
        until S1='     ';

      if ExternalOrg = '1' then
        begin
        S1:='     - '+UTF8Decode(NIR.FieldAsString(NIR.FieldIndex['ExternalOrganization']));
          repeat
          M_Add(DevideString(S1,S1));
          S1:='       '+S1
          until S1='       ';
        end;

      S1:='     - '+UTF8Decode(NIR.FieldAsString(NIR.FieldIndex['Title']));
        repeat
        M_Add(DevideString(S1,S1));
        S1:='       '+S1
        until S1='       ';

      NIR.Next;
      Table.Free;
      end;

    NIR.Free;
    end;

    function GetSpectraCount(ExternalValue: string = '0'): string;
    begin
      ExtOrg := '';
      InnerJoin := '';

      // � ������ ��� �������� ������ ��������� ������� ��� ������� ���-���
      if Org.FieldAsInteger(Org.FieldIndex['Other']) = 0 then
        begin
        InnerJoin := ' INNER JOIN `NIR` ON (`NIR`.`ID` = `Spectra`.`NIR`)';
        ExtOrg:= ' AND (`External`=' + ExternalValue + ')';
        end;

      Table:=GetTable('SELECT SUM(`Number`) AS NN FROM `Spectra`' + InnerJoin + ' '+
        'WHERE (`Organization`=' + Org.FieldAsString(Org.FieldIndex['ID']) +
        ') AND' + WHERE_Date + ExtOrg);

      if Table.FieldAsString(Table.FieldIndex['NN'])='' then
        begin
        Table.Free;
        Result := 'Next';
        exit;
        end;
      Result := Table.FieldAsString(Table.FieldIndex['NN']);
      Table.Free;
    end;

  begin
  M_Add('============================================================');
  M_Add('                 ���������� �� ������������:                ');
  M_Add('');

  Org:=GetTable('SELECT * FROM `Organization`');

  for I := 0 to Org.Count-1 do
    begin
    Table:=GetTable('SELECT SUM(`Number`) AS NN FROM `Spectra` '+
        'WHERE (`Organization`=' + Org.FieldAsString(Org.FieldIndex['ID']) +
        ') AND' + WHERE_Date);

      if Table.FieldAsString(Table.FieldIndex['NN'])='' then
        begin
        Org.Next;
        Continue;
        end;

    Table.Free;
    M_Add('------------------------------------------------------------');
    S1:=UTF8Decode(Org.FieldAsString(Org.FieldIndex['FullName']));
    repeat
    M_Add(DevideString(S1,S1));
    until S1.Length=0;
    M_Add('');

    NSpectra := GetSpectraCount;
    if NSpectra <> 'Next' then
      begin
      M_Add(To40Symb(' - ����� ����� ��������:') + NSpectra);
      GetTasks;
      GetNIR;
      end;

    if Org.FieldAsInteger(Org.FieldIndex['Other']) = 0 then
      begin
      M_Add('- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ');
      M_Add('������ �� ������� �����������');

      NSpectra := GetSpectraCount('1');
      if NSpectra <> 'Next' then
        begin
        M_Add(To40Symb(' - ����� ����� ��������:') + NSpectra);

        GetTasks;
        GetNIR('1');
        end;

      end;

    Org.Next;
    M_Add('');
    end;
  Org.Free;
  M_Add('');
  end;

begin
PB:=0;
ProgressBar1.Max:=6; //������!
ProgressBar1.Position:=0;
PB_Timer.Enabled:=true;

Memo.Clear;

GetDateInterval;

inc(PB);    //1
TitleShow;

inc(PB);    //2,3
TotalWorkShow;



inc(PB);    //4
ShowTotalTasksN;
ShowTaskTime;
ShowTotalTasks;

inc(PB);    //5
Organizations;

inc(PB);    //6

//�����
Tasks_List.Free;

if ProgressBar1.Visible then ProgressBar1.Visible:=false;
PB_Timer.Enabled:=false;;
end;

procedure TReport.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TReport.PB_TimerTimer(Sender: TObject);
begin
if not ProgressBar1.Visible then ProgressBar1.Visible:=true;

ProgressBar1.Position:=PB;
end;

procedure TReport.Prepare;
var
  SysTime:TSystemTime;
begin
DateTimeToSystemTime(Now,SysTime);
SysTime.wMonth:=1;
SysTime.wDay:=1;
DateFrom.DateTime:=SystemTimeToDateTime(SysTime);
inc(SysTime.wYear);
DateTo.DateTime:=SystemTimeToDateTime(SysTime);
end;

end.
