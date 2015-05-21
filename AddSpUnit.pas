unit AddSpUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Samples.Spin, Vcl.Buttons, SQLite3, SQLiteTable3;

type
  TAddSp = class(TForm)
    Org: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Lab: TComboBox;
    Label4: TLabel;
    OrderName: TComboBox;
    Label5: TLabel;
    NIR: TComboBox;
    Label6: TLabel;
    Task: TComboBox;
    Label7: TLabel;
    Subst: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Number: TSpinEdit;
    Label10: TLabel;
    User: TComboBox;
    Button1: TButton;
    Button2: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Cond: TComboBox;
    SpeedButton7: TSpeedButton;
    procedure ShowAddForm;
    procedure FormCreate(Sender: TObject);
    procedure ShowData(ComboBox:TComboBox; ID: TStringList;
      SQL_Query, NameString, IDString: string);
    procedure ShowDataMin(ComboBox:TComboBox;
      SQL_Query, NameString: string);
    procedure OrderNameShow;
    procedure OrgSelect(Sender: TObject);
    procedure LabSelect(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckIfCorrect;
    procedure OrderNameSelect(Sender: TObject);
    procedure NIRSelect(Sender: TObject);
    procedure TaskSelect(Sender: TObject);
    procedure SubstChange(Sender: TObject);
    procedure CondChange(Sender: TObject);
    procedure NumberChange(Sender: TObject);
    procedure UserChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private

  public
    { Public declarations }
  end;

var
  AddSp: TAddSp;
  OrgID, LabID, OrderNameID, NIRID, TaskID, UserID:TStringList;           //Списки значений ID для отдельных ComboBox
  Query:TStringList;                                                      // ---- Уже не нужно ---- //

const
  //Запросы по наполнению ComboBox
  OrgSQL='SELECT `ID`,`Name` FROM `Organization` ORDER BY `Other`, `Name`;';
  LabSQL='SELECT `ID`, `FullName` FROM `Laboratory` ORDER BY `First` DESC, `FullName`;';
  NIRSQL='SELECT `ID`, `Num` || '' ('' || `Comment` || '')'' AS NumComment FROM `NIR` ORDER BY `First` DESC, `Num`;';
  TaskSQL='SELECT `ID`, `Name` FROM `Task` ORDER BY `Name`;';
  UserSQL='SELECT `ID`, `LastName` || '' '' || `FirstName` || '' '' || `FathersName` AS FName FROM `User` ORDER BY `LastName`';
  CondSQL='SELECT `Condition` FROM `Conditions` ORDER BY `Condition`;';

implementation

{$R *.dfm}

uses MainMenu, AddOrgUnit, AddLabUnit, AddOrderUnit, AddNIR, AddTaskUnit,
  AddUserUnit, Unit2;

{ TAddSp }

procedure TAddSp.Button1Click(Sender: TObject);
var
  s:String;                  //Временная переменная для создания запроса
  s1:String;                 //Временная переменная для создания запроса
  Table:TSQLiteTable;        //Таблица
  SysTime:TSystemTime;
  MaxNo:Integer;
  TempS1:string;
begin
DateTimeToSystemTime(Date,SysTime);
Table:=GetTable('SELECT MAX(`No`) AS MaxNo FROM `Spectra` WHERE `Year`='+IntToStr(SysTime.wYear)+';');
if Table.Count=0 then
  begin
  Table.Free;
  MaxNo:=0;
  end;

TempS1:=Table.FieldAsString(Table.FieldIndex['MaxNo']);
if TempS1='' then TempS1:='0';

MaxNo:=StrToInt(UTF8Decode(TempS1));
inc(MaxNo);

s:='INSERT INTO `Spectra` (`No`,`Date`, `Year`, `Organization`, `Laboratory`, ';
s:=s+'`Name`, `Subst`, `Conditions`, `Number`, `Task`, `User`, `NIR`';
s:=s+')';
s1:='VALUES ('+IntToStr(MaxNo)+', DATE(), '+IntToStr(SysTime.wYear)+', '+OrgID[Org.ItemIndex]+', ';
if OrgID[Org.ItemIndex]='1' then s1:=s1+LabID[Lab.ItemIndex]+', ' else s1:=s1+'1, ';
s1:=s1+OrderNameID[OrderName.ItemIndex]+', "'+Subst.Text+'", "'+
  Cond.Text+'", '+IntToStr(Number.Value)+', '+TaskID[Task.ItemIndex]+', '+
  UserID[User.ItemIndex];
s1:=s1+', '+NIRID[NIR.ItemIndex];
S1:=S1+');';

ExecSQL(S+' '+S1);

ShowMessage('Запись о соединении '+Subst.Text+' успешно добавлена.');

if Config.ReadBool('Zeroing','Subst',false) then Subst.Text:='';
if Config.ReadBool('Zeroing','Cond',false) then Cond.Text:='';
if Config.ReadBool('Zeroing','Number',true) then Number.Value:=0;
CheckIfCorrect;

TempS1:=Config.ReadString('Zeroing','Autofocus','Subst');
if TempS1='Subst' then Subst.SetFocus else
  if TempS1='Task' then Task.SetFocus;

end;

procedure TAddSp.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TAddSp.CheckIfCorrect;
var
  Correct:boolean;
begin
Correct := true;
if Org.ItemIndex=-1 then Correct:=false;
if (OrgID[Org.ItemIndex]='1') and ((Lab.ItemIndex=-1) or (Lab.ItemIndex=0)) then Correct:=false;
if OrderName.ItemIndex=-1 then Correct:=false;
if Task.ItemIndex=-1 then Correct:=false;
if User.ItemIndex=-1 then Correct:=false;
if Number.Value=0 then Correct:=false;


Button1.Enabled:=Correct;
end;

procedure TAddSp.CondChange(Sender: TObject);
begin
CheckIfCorrect;
end;

procedure TAddSp.FormCreate(Sender: TObject);
begin
OrgID:=TStringList.Create;
LabID:=TStringList.Create;
OrderNameID:=TStringList.Create;
NIRID:=TStringList.Create;
TaskID:=TStringList.Create;
UserID:=TStringList.Create;
Query:=TStringList.Create;
end;

procedure TAddSp.FormDestroy(Sender: TObject);
begin
OrgID.Free;
LabID.Free;
OrderNameID.Free;
NIRID.Free;
TaskID.Free;
UserID.Free;
Query.Free;
end;

procedure TAddSp.LabSelect(Sender: TObject);
begin
OrderNameShow;
CheckIfCorrect;
end;

procedure TAddSp.NIRSelect(Sender: TObject);
begin
CheckIfCorrect;
end;

procedure TAddSp.NumberChange(Sender: TObject);
begin
CheckIfCorrect;
end;

procedure TAddSp.OrderNameSelect(Sender: TObject);
begin
CheckIfCorrect;
end;

procedure TAddSp.OrderNameShow;
var
  S:string;
begin
S:='SELECT `ID`, `LastName` || '' '' || `FirstName` || '' '' || `FathersName` AS FName '+
  'FROM `Name` ';

if OrgID[Org.ItemIndex]='1' then
  begin
  if LabID[Lab.ItemIndex]<>'1' then
    begin
    s:=s+'WHERE `Laboratory` = '+LabID[Lab.ItemIndex];
    OrderName.Enabled:=true;
    end
   else
    begin
    s:=s+'WHERE NULL';
    OrderName.Enabled:=false;
    end;
  end
 else
  begin
  s:=s+'WHERE `Organization` = '+OrgID[Org.ItemIndex];
  OrderName.Enabled:=true;
  end;
s:=s + ' ORDER BY `LastName`, `FirstName`;';

ShowData(OrderName,OrderNameID,s,
  'FName','ID');
end;

procedure TAddSp.OrgSelect(Sender: TObject);
begin
if OrgID[Org.ItemIndex]='1' then
  begin
  Lab.Enabled:=true;
  ShowData(Lab,LabID,LabSQL,
  'FullName','ID');
  Lab.ItemIndex:=0;
  OrderNameShow;
  end
 else
  begin
  Lab.Enabled:=false;
  Lab.Items.Clear;
  LabID.Clear;
  OrderNameShow;
  end;

CheckIfCorrect;
end;


procedure TAddSp.ShowAddForm;
begin
//Organization
ShowData(Org,OrgID,OrgSQL,
  'Name','ID');
  Org.ItemIndex:=0;        //0 - ИОС!!!
//Laboratory
ShowData(Lab,LabID,LabSQL,
  'FullName','ID');
Lab.ItemIndex:=0;
//Orderer name
OrderNameShow;
//NIR
ShowData(NIR,NIRID,NIRSQL,
  'NumComment','ID');
NIR.ItemIndex:=0;
//Task
ShowData(Task,TaskID,TaskSQL,
  'Name','ID');
Subst.Text:='';
ShowDataMin(Cond,CondSQL, 'Condition');
Cond.Text:='';
ShowData(User,UserID,UserSQL,
  'FName','ID');
Cond.text:='';
CheckIfCorrect;
Show;
end;

procedure TAddSp.ShowDataMin(ComboBox: TComboBox; SQL_Query, NameString: string);
var
  Table:TSQLiteTable;
  I: Integer;
begin
ComboBox.Items.Clear;
Table:=GetTable(SQL_Query);
for I := 0 to Table.Count-1 do
  begin
  ComboBox.Items.Add(UTF8Decode(Table.FieldAsString(Table.FieldIndex[NameString])));
  Table.Next;
  end;
Table.Free;
end;

procedure TAddSp.ShowData(ComboBox: TComboBox; ID: TStringList; SQL_Query,
  NameString, IDString: string);
var
  Table:TSQLiteTable;
  I: Integer;
begin
ComboBox.Items.Clear;
ID.Clear;
Table:=GetTable(SQL_Query);
if Table.Count=0 then
  begin
  Table.Free;
  exit;
  end;

for I := 0 to Table.Count-1 do
  begin
  ComboBox.Items.Add(UTF8Decode(Table.FieldAsString(Table.FieldIndex[NameString])));
  ID.Add(UTF8Decode(Table.FieldAsString(Table.FieldIndex[IDString])));
  Table.Next;
  end;
Table.Free;
end;

procedure TAddSp.SpeedButton1Click(Sender: TObject);
begin
AddOrg.ShowForm;

ShowData(Org,OrgID,OrgSQL,
  'Name','ID');
  Org.ItemIndex:=0;        //0 - ИОС!!!
//Laboratory
ShowData(Lab,LabID,LabSQL,
  'FullName','ID');
Lab.ItemIndex:=0;
//Orderer name
OrderNameShow;
CheckIfCorrect;
end;

procedure TAddSp.SpeedButton2Click(Sender: TObject);
begin
AddLab.ShowForm;

//Laboratory
ShowData(Lab,LabID,LabSQL,
  'FullName','ID');
Lab.ItemIndex:=0;
//Orderer name
OrderNameShow;
CheckIfCorrect;
end;

procedure TAddSp.SpeedButton3Click(Sender: TObject);
begin
AddOrder.ShowForm;
OrderNameShow;
CheckIfCorrect;
end;

procedure TAddSp.SpeedButton4Click(Sender: TObject);
begin
Add_NIR.ShowForm;
ShowData(NIR,NIRID,NIRSQL,
  'NumComment','ID');
NIR.ItemIndex:=0;
CheckIfCorrect;
end;

procedure TAddSp.SpeedButton5Click(Sender: TObject);
begin
AddTask.ShowForm;
ShowData(Task,TaskID,TaskSQL,
  'Name','ID');
CheckIfCorrect;
end;

procedure TAddSp.SpeedButton6Click(Sender: TObject);
begin
AddUser.ShowForm;
ShowData(User,UserID,UserSQL,
  'FName','ID');
CheckIfCorrect;
end;

procedure TAddSp.SpeedButton7Click(Sender: TObject);
begin
AddCond.ShowModal;
ShowDataMin(Cond, CondSQL, 'Condition');
CheckIfCorrect;
end;

procedure TAddSp.SubstChange(Sender: TObject);
begin
CheckIfCorrect;
end;

procedure TAddSp.TaskSelect(Sender: TObject);
begin
CheckIfCorrect;
end;

procedure TAddSp.UserChange(Sender: TObject);
begin
CheckIfCorrect;
end;

end.
