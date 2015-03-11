unit AddLabUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  SQLite3, SQLiteTable3;

type
  TAddLab = class(TForm)
    Label1: TLabel;
    FullName: TEdit;
    Query: TADOQuery;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    ShortName: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    Procedure ShowForm;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddLab: TAddLab;

implementation

{$R *.dfm}

uses MainMenu;

procedure TAddLab.Button1Click(Sender: TObject);
begin
if FullName.Text='' then
  begin
  ShowMessage('������� �������� �����������!');
  Exit;
  end;
if ShortName.Text='' then
  begin
  ShowMessage('������� ������������!');
  Exit;
  end;

ExecSQL('INSERT INTO `Laboratory` (`Name`, `FullName`) '+
  'VALUES ('''+ShortName.Text+''','''+FullName.Text+''');');

Close;
end;

procedure TAddLab.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TAddLab.ShowForm;
begin
FullName.Text:='';
ShortName.Text:='';
ShowModal;
end;

end.
