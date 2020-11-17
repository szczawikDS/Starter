unit uSettingsAdv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmSettingsAdv = class(TForm)
    pnlMain: TPanel;
    Label8: TLabel;
    cbConvertmodels: TComboBox;
    chCompressTex: TCheckBox;
    chScaleSpeculars: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettingsAdv: TfrmSettingsAdv;

implementation

{$R *.dfm}

end.
