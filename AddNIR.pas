unit AddNIR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  SQLite3, SQLiteTable3, MainMenu;

type
  TAdd_NIR = class(TForm)
    Label1: TLabel;
    NIR: TEdit;
    Label2: TLabel;
    Comment: TEdit;
    Button1: TButton;
    Button2: TButton;
    Query: TADOQuery;
    Label3: TLabel;
    NIR_Title: TEdit;
    Label4: TLabel;
    ExtOrgName: TEdit;
    IsExternal: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ShowForm;
    procedure IsExternalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Add_NIR: TAdd_NIR;

implementation

{$R *.dfm}

procedure TAdd_NIR.Button1Click(Sender: TObject);
begin
if NIR.Text='' then
  begin
  ShowMessage('Введите номер НИР!');
  Exit;
  end;

if NIR_Title.Text='' then
  begin
  ShowMessage('Введите название НИР!');
  Exit;
  end;

// Если имеется сторонняя организация, то проверим, чтобы её название было
if IsExternal.Checked and (ExtOrgName.Text = '') then
  begin
  ShowMessage('Введите название сторонней организации!');
  Exit;
  end;

  //И добавим в БД в зависимости от наличии сторонней орг-ции
if IsExternal.Checked then
  ExecSQL('INSERT INTO `NIR` (`Num`, `Comment`, `Title`, `External`, `ExternalOrganization`) '+
    'VALUES ('''+NIR.Text+''','''+Comment.Text+''','''+NIR_Title.Text+''', 1, ''' + ExtOrgName.Text + ''');')
else
  ExecSQL('INSERT INTO `NIR` (`Num`, `Comment`, `Title`, `External`, `ExternalOrganization`) '+
    'VALUES ('''+NIR.Text+''','''+Comment.Text+''','''+NIR_Title.Text+''', 0, '''');');
Close;
end;

procedure TAdd_NIR.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TAdd_NIR.IsExternalClick(Sender: TObject);
begin
Label4.Enabled := IsExternal.Checked;
ExtOrgName.Enabled := IsExternal.Checked;
end;

procedure TAdd_NIR.ShowForm;
begin
NIR.Text:='';
Comment.Text:='';
ShowModal;
end;

end.
