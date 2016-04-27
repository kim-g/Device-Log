unit About_IOS_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, shellapi;

type
  TAboutForm = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses MainMenu;

procedure TAboutForm.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
Label1.Caption:='   Электронный журнал для учёта рабочего времени оборудования.'+
  #13#10+'Разработана в Институте органического синтеза'+#13#10+'им. И.Я. Постовского Уральского отделения РАН.'+
  #13#10#13#10+'   Программа распространяется по принципам «как есть» и «не стреляйте в пианиста, он играет как умеет».'+
  #13#10+'По всем вопросам обращаться к Григорию Киму.';

Label3.Caption := CompileYear + ' г.';
end;

procedure TAboutForm.Label2Click(Sender: TObject);
begin
ShellExecute(Handle,'open','mailto:kim-g@ios.uran.ru','','',SW_SHOWNORMAL)
end;

procedure TAboutForm.Label2MouseEnter(Sender: TObject);
begin
Label2.Font.Style:=[fsUnderline];
end;

procedure TAboutForm.Label2MouseLeave(Sender: TObject);
begin
Label2.Font.Style:=[];
end;

end.
