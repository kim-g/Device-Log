unit AddUserUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  MainMenu;

type
  TAddUser = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LName: TEdit;
    FName: TEdit;
    SName: TEdit;
    Query: TADOQuery;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ShowForm;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddUser: TAddUser;

implementation

{$R *.dfm}

procedure TAddUser.Button1Click(Sender: TObject);
begin
if LName.Text='' then
  begin
  ShowMessage('������� �������!');
  Exit;
  end;

ExecSQL('INSERT INTO [User] (FirstName, FathersName, LastName) '+
  'VALUES ("'+FName.Text+'","'+SName.Text+'","'+LName.Text+'");');

Close;
end;

procedure TAddUser.Button2Click(Sender: TObject);
begin
Close
end;

procedure TAddUser.ShowForm;
begin
LName.Text:='';
FName.Text:='';
SName.Text:='';
ShowModal;
end;

end.
