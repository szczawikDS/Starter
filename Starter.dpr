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
  uUpdater in 'src\uUpdater.pas' {frmUpdater},
  uSearch in 'src\uSearch.pas' {frmSearch},
  uTextureBase in 'src\uTextureBase.pas' {frmTextureBase},
  uAbout in 'src\uAbout.pas' {frmAbout},
  uIdHTTPProgress in 'components\uIdHTTPProgress.pas',
  uUART in 'src\uUART.pas' {frmUART},
  uSettingsAdv in 'src\uSettingsAdv.pas' {frmSettingsAdv},
  uTexRandomizer in 'src\uTexRandomizer.pas' {frmTexRandomizer},
  uDepot in 'src\uDepot.pas',
  uLexer in 'src\uLexer.pas',
  uUtilities in 'src\uUtilities.pas',
  uData in 'src\uData.pas';

{$R *.res}

begin
  frmStart := TfrmStart.Create(nil);
  frmStart.Show;
  Application.Initialize;
  frmStart.Update;

  Util := TUtil.Create;
  TData.Load;

  Application.MainFormOnTaskbar := True;
  Application.Title := 'Starter MaSzyna';
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TfrmSettingsAdv, frmSettingsAdv);
  frmStart.Destroy;

  Application.Run;
end.
