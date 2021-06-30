{
  Starter
  Copyright (C) 2019-2021 Damian Skrzek (szczawik)

  This file is part of Starter.

  Starter is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 3 of the License, or
  (at your option) any later version.

  Starter is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Starter.  If not, see <http://www.gnu.org/licenses/>.
}

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
    chIgnoreIrrevelant: TCheckBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSettingsAdv: TfrmSettingsAdv;

implementation

uses uUtilities, uLanguages, uMain;

{$R *.dfm}

procedure TfrmSettingsAdv.FormCreate(Sender: TObject);
begin
  if Util.Lang <> 'pl' then
    TLanguages.ChangeLanguage(Self,Util.Lang);
end;

procedure TfrmSettingsAdv.FormShow(Sender: TObject);
begin
  chIgnoreIrrevelant.Checked := Main.Settings.IgnoreIrrelevant;
end;

end.
