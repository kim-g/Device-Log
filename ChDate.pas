unit ChDate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, INIFiles, ShlObj, Data.DB,
  Data.Win.ADODB;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    DB: TADOConnection;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function AppData:string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Config:TINIFile;


const
  PF = '\IOS\UV LOG\';
  CONFIG_FILE = 'config.ini';

implementation

{$R *.dfm}

function TForm1.AppData: string;
var
  PItemID : PItemIDList;
  ansiSbuf : array[0..MAX_PATH] of char;
begin
SHGetSpecialFolderLocation( Form1.Handle, CSIDL_APPDATA, PItemID );
SHGetPathFromIDList( PItemID, @ansiSbuf[0] );
AppData := ansiSbuf;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
ADOQuery1.SQL.Clear;
ADOQuery1.SQL.Add('UPDATE Spectra SET [Date] = "'+Edit1.Text+'"');
ADOQuery1.SQL.Add('WHERE [Date] = DATE();');
ADOQuery1.ExecSQL;
ShowMessage('��������!');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  DB_Name:string;
const
  NF = 'NoFile';
begin
if not DirectoryExists(AppData+PF) then
  ForceDirectories(AppData+PF);
Config:=TINIFile.Create(AppData+PF+CONFIG_FILE);

Caption:=Config.ReadString('General','Title','ERROR!!!');
Application.Title:=Config.ReadString('General','Title','ERROR!!!');

DB_Name := Config.ReadString('General','DBFile',NF);
if DB_Name = NF then
  begin
  ShowMessage('���� ���� ������ �� �����.'+#13#10+
  '����������, ������� ���� � ����� �� � ���������������� ����� "'+AppData+PF+CONFIG_FILE+'"');
  Application.Terminate;
  end;

if not FileExists(DB_Name) then
  begin
  ShowMessage('���� ���� ������ "'+DB_Name+'" �� ����������.'+#13#10+
  '����������, ������� ���� � ����� �� � ���������������� ����� "'+AppData+PF+CONFIG_FILE+'"');
  Application.Terminate;
  end;

DB.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+
  DB_Name+
  ';Mode=Share Deny None;Jet OLEDB:System database="";Jet OLEDB:Registry Path="";'+
  'Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=1;'+
  'Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;'+
  'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;'+
  'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don''t Copy Locale on Compact=False;'+
  'Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False;';
DB.Connected:=true;

end;

end.
