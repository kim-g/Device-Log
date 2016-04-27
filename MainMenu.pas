{������ ��� ����� ������ ������������

����� � �������� ��� (kim-g@ios.uran.ru)
����������� ����������������� ����������
��������� ������������� ������� ��� ��� ��. �.� �����������

������ IDE RAD STUDIO XE3

������������ ��������� ����������:
* FastReport4
* SQLite3

��� ��������.}

unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB, ShlObj,
  INIFiles, frxClass, frxDBSet, SQLite3, SQLiteTable3, Data.DbxSqlite,
  Data.DBXPool, Data.DBXTrace, Data.FMTBcd, Data.SqlExpr, Vcl.Imaging.GIFImg,
  Vcl.ExtCtrls;

type
  TMainMenuForm = class(TForm)
    Button1: TButton;                               //����������� � �� ��� Fast Report
    Button2: TButton;                               //�������� �������
    LogReport: TfrxReport;                //������ ��� ������
    DB: TSQLConnection;                             //���� ��� ������ �� ������
    LogQuery: TSQLQuery;
    LogDataSet: TfrxDBDataset;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Label3: TLabel;                            //������ �� ����� �� ������.
    procedure Button1Click(Sender: TObject);        //�������� ������
    procedure FormCreate(Sender: TObject);          //����������� � �� � ��������
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);        //���������� �����
  private
    function AppData:string;                        //���������������� ������� AppData ��� Application Data
    procedure Backup;
  public
    { Public declarations }
  end;

  procedure ExecSQL(SQL:string);                    //��������� SQL ������ � ��������� UTF-8
  function GetTable(SQL:string):TSQLiteTable;       //������ ������� ��  SQL ������� � ��������� UTF-8

var
  MainMenuForm: TMainMenuForm;                      //������� ����
  Config:TINIFile;                                  //���������
  SQLite:TSQLiteDatabase;                           //���� ����


const
  PF = '\IOS\UV LOG\';                              //����� � ���������������� ��������
  CONFIG_FILE = 'config.ini';                       //��� ����� � �����������
  CompileYear = '2016';

implementation

{$R *.dfm}

uses AddSpUnit, DB_Structure, About_IOS_Unit, ReportLog;

procedure ExecSQL(SQL:string);
begin
SQLite.ExecSQL(UTF8Encode(SQL));
end;

function GetTable(SQL:string):TSQLiteTable;
begin
GetTable:=SQLite.GetTable(UTF8Encode(SQL))
end;

function TMainMenuForm.AppData: string;             //��������� ������ �������� ������������
var
  PItemID : PItemIDList;
  ansiSbuf : array[0..MAX_PATH] of char;
begin
SHGetSpecialFolderLocation( MainMenuForm.Handle, CSIDL_APPDATA, PItemID );
SHGetPathFromIDList( PItemID, @ansiSbuf[0] );
AppData := ansiSbuf;
end;

procedure TMainMenuForm.Backup;
var
  Table: TSQLiteTable;
  BackupDate: string;
  LastBackup: TDate;
  FileName:string;
begin
// �����������, ����� ��� ��������� �����
Table := GetTable('SELECT * FROM `BackupInfo` ORDER BY `Backup_Date` DESC LIMIT 1');
if Table.Count > 0 then    // ���� �� ������ ���
  begin
  BackupDate := Table.FieldAsString(Table.FieldIndex['Backup_Date']);
  LastBackup := EncodeDate(StrToInt( BackupDate.Substring(0,4)),StrToInt( BackupDate.Substring(5,2)),
  StrToInt( BackupDate.Substring(8,2)));

  // �� ��������� �����. ���� ������ ������ ������, ������ �� ������.
  if LastBackup + 7 > Now then Exit;
  end;

// � ����� ������ ������
Filename := Config.ReadString('General','DBFile','');
FileName := StringReplace(ExtractFileName(FileName),ExtractFileExt(FileName),'',[]);
FileName := Config.ReadString('General','DBBackup','') +
  FileName + ' ' + FormatDateTime('yyyy-mm-dd', Now) + '.db';

// ��������� � ����� � �������
CopyFile(PWideChar(WideString(Config.ReadString('General','DBFile',''))),
  PWideChar(WideString(FileName)), false);

// � ������� ��� � ��
ExecSQL('INSERT INTO `BackupInfo` (`Backup_date`, `Backup_File`) VALUES (Date(), "' +
  FileName + '");');

end;

procedure TMainMenuForm.Button1Click(Sender: TObject);     //�������� ����� ���������� ������
begin
AddSp.ShowAddForm;
end;

procedure TMainMenuForm.Button2Click(Sender: TObject);     //�������� �����
begin
LogQuery.SQL[15] := 'WHERE `Date` LIKE "'+Edit1.Text+'%"';
LogQuery.Active:=true;
LogReport.ShowReport;
end;

procedure TMainMenuForm.Button3Click(Sender: TObject);
begin
Report.Prepare;
Report.ShowModal;
end;

procedure TMainMenuForm.Button4Click(Sender: TObject);     //�������� ���� �� ���������
begin
AboutForm.ShowModal;
end;

procedure TMainMenuForm.Button5Click(Sender: TObject);     //����� �� ���������
begin
Application.Terminate;
end;

procedure TMainMenuForm.FormCreate(Sender: TObject);       //�������� ��
var
  DB_Name:string;       //��� ��
  I:Integer;            //�������
  Table:TSQLiteTable;   //�������
const
  NF = 'NoFile';        //����� �� ����� �� ������.
begin
with (Image1.Picture.Graphic as TGIFImage) do
  begin
  AnimateLoop := glEnabled;
  AnimationSpeed := 100;
  Animate := True;
  end;

{if not DirectoryExists(AppData+PF) then
  ForceDirectories(AppData+PF);  }                 //���� ��� ���� � ����� � �����������, �� ������ ���
Config:=TINIFile.Create(ExtractFilePath(Application.ExeName)+CONFIG_FILE);             //��������� ���� � �����������.

//���������� �������
Caption:=Config.ReadString('General','Title','ERROR!!!');
Application.Title:=Config.ReadString('General','Title','ERROR!!!');
Label2.Caption := Config.ReadString('General','Title','ERROR!!!');

Edit1.Text := IntToStr(CurrentYear);

//��������� ����� ��
DB_Name := Config.ReadString('General','DBFile',NF);

//���������, ���� �� ������ � ����� ������������
if DB_Name = NF then
  begin
  ShowMessage('���� ���� ������ �� �����.'+#13#10+
  '����������, ������� ���� � ����� �� � ���������������� ����� "'+ExtractFilePath(Application.ExeName)+CONFIG_FILE+'"');
  Application.Terminate;
  end;

//���������, ���������� �� ����. ���� ���, �������������, ��� �� ����� ������.
if not FileExists(DB_Name)
  then ShowMessage('���� ���� ������ "'+DB_Name+'" �� ����������.'+#13#10+
  '�������� ������ ���� �� ������ "'+DB_Name+'"');

//��������� ����
SQLite := TSQLiteDatabase.Create(DB_Name);
  //�������� ������������� ������ ������
  try
    for I := 1 to DBS_Tables_Count do
      ExecSQL(DBS_TABLES_QUERY[I]);
    //���������� ���������� �������
    for I := 1 to DBS_FILL_COUNT do
      begin
      Table:=GetTable(DBS_FILL_EMPTY[I]);
      if Table.Count=0 then
        ExecSQL(DBS_FILL[I]);
      Table.Free;
      end;
  except
    ShowMessage('��� �������� ���� ��������� ������.');
    Application.Terminate;
  end;

//��������� ��� �� ��� DB
DB.Params.Values['Database']:=DB_Name;
DB.Connected:=true;

//��������� � ������ �����
Backup;
end;

end.
