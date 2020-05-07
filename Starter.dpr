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
  uStart in 'src\uStart.pas' {frmStart},
  blcksock in 'src\synapse\blcksock.pas',
  httpsend in 'src\synapse\httpsend.pas',
  synacode in 'src\synapse\synacode.pas',
  synafpc in 'src\synapse\synafpc.pas',
  synaip in 'src\synapse\synaip.pas',
  synautil in 'src\synapse\synautil.pas',
  synsock in 'src\synapse\synsock.pas',
  uUpdater in 'src\uUpdater.pas' {frmUpdater},
  ssl_openssl in 'src\synapse\ssl_openssl.pas',
  ssl_openssl_lib in 'src\synapse\ssl_openssl_lib.pas';

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
  Application.CreateForm(TfrmUpdater, frmUpdater);
  frmStart.Destroy;

  Application.Run;
end.
