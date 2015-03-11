unit AddOrgUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB;

type
  TAddOrg = class(TForm)
    Label1: TLabel;
    FullName: TEdit;
    Label2: TLabel;
    ShortName: TEdit;
    Button1: TButton;
    Button2: TButton;
    Query: TADOQuery;
    procedure Button2Click(Sender: TObject);
    procedure ShowForm;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddOrg: TAddOrg;

implementation

{$R *.dfm}

uses MainMenu;

procedure TAddOrg.Button1Click(Sender: TObject);
begin
if FullName.Text='' then
  begin
  ShowMessage('������� ������ ������������ �����������!');
  Exit;
  end;
if ShortName.Text='' then
  begin
  ShowMessage('������� ������������ �����������!');
  Exit;
  end;

ExecSQL('INSERT INTO Organization (Name, FullName, Other) '+
  'VALUES ("'+ShortName.Text+'","'+FullName.Text+'",1);');

Close;
end;

procedure TAddOrg.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TAddOrg.ShowForm;
begin
FullName.Text:='';
ShortName.Text:='';
ShowModal;
end;

end.
