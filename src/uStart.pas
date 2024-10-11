{
  Starter
  Copyright (C) 2019-2020 Damian Skrzek (szczawik)

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

unit uStart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.WinXCtrls;

type
  TfrmStart = class(TForm)
    Image1: TImage;
    lbProgress: TLabel;
    pbProgress: TProgressBar;
  private
    class var FInstance: TfrmStart;
  public
    class function GetInstance: TfrmStart;
    procedure UpdateLabel(aCaption: string);
  end;

implementation

{$R *.dfm}

class function TfrmStart.GetInstance: TfrmStart;
begin
  if not Assigned(FInstance) then
    FInstance := TfrmStart.Create(nil );
  Result := FInstance;
end;

procedure TfrmStart.UpdateLabel(aCaption: string);
begin
  if Assigned(FInstance) then
  begin
    Self.lbProgress.Caption := aCaption;
    pbProgress.StepIt;
    Application.ProcessMessages;
  end;
end;

end.
