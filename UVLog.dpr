program UVLog;

uses
  Vcl.Forms,
  MainMenu in 'MainMenu.pas' {MainMenuForm},
  AddSpUnit in 'AddSpUnit.pas' {AddSp},
  AddOrgUnit in 'AddOrgUnit.pas' {AddOrg},
  AddLabUnit in 'AddLabUnit.pas' {AddLab},
  AddOrderUnit in 'AddOrderUnit.pas' {AddOrder},
  AddNIR in 'AddNIR.pas' {Add_NIR},
  AddTaskUnit in 'AddTaskUnit.pas' {AddTask},
  StFunctions in 'StFunctions.pas',
  AddUserUnit in 'AddUserUnit.pas' {AddUser},
  Unit2 in 'Unit2.pas' {AddCond},
  SQLite3 in 'SQLite3.pas',
  SQLiteTable3 in 'SQLiteTable3.pas',
  DB_Structure in 'DB_Structure.pas',
  About_IOS_Unit in 'About_IOS_Unit.pas' {AboutForm},
  ReportLog in 'ReportLog.pas' {Report};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainMenuForm, MainMenuForm);
  Application.CreateForm(TAddSp, AddSp);
  Application.CreateForm(TAddOrg, AddOrg);
  Application.CreateForm(TAddLab, AddLab);
  Application.CreateForm(TAddOrder, AddOrder);
  Application.CreateForm(TAdd_NIR, Add_NIR);
  Application.CreateForm(TAddTask, AddTask);
  Application.CreateForm(TAddUser, AddUser);
  Application.CreateForm(TAddCond, AddCond);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TReport, Report);
  Application.Run;
end.
