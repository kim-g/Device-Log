unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB;

type
  TAddCond = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Query: TADOQuery;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddCond: TAddCond;

implementation

{$R *.dfm}

uses MainMenu;

procedure TAddCond.Button1Click(Sender: TObject);
begin
ExecSQL('INSERT INTO Conditions (Condition) VALUES ("'+Edit1.Text+'");');

Close;
end;

procedure TAddCond.Button2Click(Sender: TObject);
begin
Close;
end;

end.
