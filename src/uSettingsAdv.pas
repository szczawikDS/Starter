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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettingsAdv: TfrmSettingsAdv;

implementation

uses uMain, uLanguages;

{$R *.dfm}

procedure TfrmSettingsAdv.FormCreate(Sender: TObject);
begin
  if Main.Lang <> 'pl' then
    TLanguages.ChangeLanguage(Self,Main.Lang);
end;

end.
