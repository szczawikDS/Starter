program Starter;

uses
  Vcl.Forms,
  uMain in 'src\uMain.pas' {Main},
  CastaliaPasLex in 'src\CastaliaPasLex.pas',
  CastaliaPasLexTypes in 'src\CastaliaPasLexTypes.pas',
  uParser in 'src\uParser.pas',
  uStructures in 'src\uStructures.pas',
  uSettings in 'src\uSettings.pas',
  uLanguages in 'src\uLanguages.pas',
  Vcl.Themes,
  Vcl.Styles,
  uUpdater in 'src\uUpdater.pas' {frmUpdater},
  uStart in 'src\uStart.pas' {frmStart};

{$R *.res}

begin
  frmStart := TfrmStart.Create(nil);
  frmStart.Show;
  Application.Initialize;
  frmStart.Update;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Starter MaSzyna';
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TMain, Main);
  frmStart.Destroy;

  Application.Run;
end.
