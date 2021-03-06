unit AddTaskUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  MainMenu;

type
  TAddTask = class(TForm)
    Label1: TLabel;
    Task: TEdit;
    Query: TADOQuery;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Time: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ShowForm;
    procedure TimeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddTask: TAddTask;

implementation

{$R *.dfm}

uses StFunctions;

procedure TAddTask.Button1Click(Sender: TObject);
begin
if Task.Text='' then
  begin
  ShowMessage('������� �������� ������!');
  Exit;
  end;
if Time.Text='' then
  begin
  ShowMessage('������� ����� ���������� ������!');
  Exit;
  end;

ExecSQL('INSERT INTO Task (Name, Time) '+
  'VALUES ("'+Task.Text+'","'+PointToDecimalSeparator(Time.Text)+'");');

Close;
end;

procedure TAddTask.Button2Click(Sender: TObject);
begin
Close
end;

procedure TAddTask.ShowForm;
begin
Task.Text:='';
Time.Text:='';
ShowModal;
end;

procedure TAddTask.TimeChange(Sender: TObject);
begin
Time.Text:=PointToDecimalSeparator(Time.Text);
end;

end.
