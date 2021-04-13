unit uSettingsAdv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmSettingsAdv = class(TForm)
    pnlMain: TPanel;
    lbe3d: TLabel;
    cbConvertmodels: TComboBox;
    chCompressTex: TCheckBox;
    chScaleSpeculars: TCheckBox;
    chUseGLES: TCheckBox;
    chShaderGamma: TCheckBox;
    chMipmaps: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettingsAdv: TfrmSettingsAdv;

implementation

uses uUtilities, uLanguages;

{$R *.dfm}

procedure TfrmSettingsAdv.FormCreate(Sender: TObject);
begin
  if Util.Lang <> 'pl' then
    TLanguages.ChangeLanguage(Self,Util.Lang);
end;

end.
