unit AddOrderUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  MainMenu;

type
  TAddOrder = class(TForm)
    Label1: TLabel;
    FName: TEdit;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Query: TADOQuery;
    SName: TEdit;
    Label3: TLabel;
    LName: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Org: TComboBox;
    Lab: TComboBox;
    procedure ShowForm;
    procedure OrgChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddOrder: TAddOrder;
  Org_ID, Lab_ID:TStringList;

implementation

{$R *.dfm}

uses AddSpUnit;

{ TAddOrder }

procedure TAddOrder.Button1Click(Sender: TObject);
begin
if FName.Text='' then
  begin
  ShowMessage('������� �������!');
  Exit;
  end;
if Org.ItemIndex=-1 then
  begin
  ShowMessage('�������� �����������!');
  Exit;
  end;
if (Org_ID[Org.ItemIndex]='1') and (Lab.ItemIndex=-1) then
  begin
  ShowMessage('�������� �����������!');
  Exit;
  end;

if Org_ID[Org.ItemIndex]='1' then
  ExecSQL('INSERT INTO [Name] (FirstName, FathersName, LastName, '+
    'Organization, Laboratory) VALUES ('''+SName.Text+''','''+LName.Text+''','''+
    FName.Text+''','''+Org_ID[Org.ItemIndex]+''','''+Lab_ID[Lab.ItemIndex]+''');')
  else
  ExecSQL('INSERT INTO [Name] (FirstName, FathersName, LastName, '+
    'Organization) VALUES ('''+SName.Text+''','''+LName.Text+''','''+
    FName.Text+''','''+Org_ID[Org.ItemIndex]+''');');
Close;
end;

procedure TAddOrder.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TAddOrder.FormCreate(Sender: TObject);
begin
Org_ID:=TStringList.Create;
Lab_ID:=TStringList.Create;
end;

procedure TAddOrder.OrgChange(Sender: TObject);
begin
Lab.Enabled:=Org_ID[Org.ItemIndex]='1';
Lab.ItemIndex:=-1;
end;

procedure TAddOrder.ShowForm;
begin
FName.Text:='';
SName.Text:='';
LName.Text:='';

AddSp.ShowData(Org,Org_ID, OrgSQL, 'Name','ID');
Org.ItemIndex:=0;

AddSp.ShowData(Lab,Lab_ID,LabSQL,'FullName','ID');

ShowModal;
end;

end.
