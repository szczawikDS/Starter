{
  Starter
  Copyright (C) 2019 Damian Skrzek (szczawik)

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

unit uUART;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.ValEdit;

type
  TfrmUART = class(TForm)
    edUART: TEdit;
    Label1: TLabel;
    edUARTTune: TEdit;
    Label2: TLabel;
    chUARTDebug: TCheckBox;
    Label3: TLabel;
    chUART: TCheckBox;
    pnlTopInstr: TPanel;
    chMainenable: TCheckBox;
    chScndenable: TCheckBox;
    chTrainenable: TCheckBox;
    chLocalenable: TCheckBox;
    pnlInstruments: TPanel;
    pnlMiddleInstr: TPanel;
    chRadioVolume: TCheckBox;
    chRadioChannel: TCheckBox;
    Label4: TLabel;
    btnCloseAndSave: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseAndSaveClick(Sender: TObject);
  private
    function BoolToStr(const Value: Boolean): string;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uMain;

{$R *.dfm}

function TfrmUART.BoolToStr(const Value:Boolean):string;
begin
  if Value then
    Result := 'yes'
  else
    Result := 'no';
end;

procedure TfrmUART.btnCloseAndSaveClick(Sender: TObject);
var
  i : Integer;
begin
  if Length(edUART.Text) = 0 then // nie skracac warunku- wpis nie oznacza zalaczenia
    chUART.Checked := False;

  if not chUART.Checked then
    Main.Settings.UART := edUART.Text
  else
  begin
    Main.Settings.UART := EmptyStr;
    Main.Settings.FindParameter('uart','komunikacja uart');
  end;

  i := 0;
  while i <= Main.Settings.Params.Count-1 do
  begin
    if Main.Settings.Params[i].Name = 'uart' then
    begin
      if chUART.Checked then
        Main.Settings.Params[i].Value := edUART.Text
      else
      begin
        Main.Settings.Params.Remove(Main.Settings.Params[i]);
        Continue;
      end;
    end
    else
    if Main.Settings.Params[i].Name = 'uarttune' then
      Main.Settings.Params[i].Value := edUARTtune.Text
    else
    if Main.Settings.Params[i].Name = 'uartdebug' then
      Main.Settings.Params[i].Value := BoolToStr(chUARTDebug.Checked)
    else
      if Main.Settings.Params[i].Name = 'uartfeature' then
      begin
        with Main.Settings.Params[i] do
        begin
          Value := EmptyStr;

          if chMainenable.Checked   then Value := Value + 'main|';
          if chScndenable.Checked   then Value := Value + 'scnd|';
          if chTrainenable.Checked  then Value := Value + 'train|';
          if chLocalenable.Checked  then Value := Value + 'local|';
          if chRadioVolume.Checked  then Value := Value + 'radiovolume|';
          if chRadioChannel.Checked then Value := Value + 'radiochannel|';
        end;
      end;
    Inc(i);
  end;

  Main.Settings.SaveSettings();
end;

procedure TfrmUART.FormCreate(Sender: TObject);
var
  i, y : Integer;
  Par : TStringList;
begin
  if Main.Settings.UART.Length > 0 then
  begin
    chUART.Checked := False;
    edUART.Text := Main.Settings.UART;
  end;

  for i := 0 to Main.Settings.Params.Count-1 do
  begin
    if Main.Settings.Params[i].Name = 'uart' then
    begin
      chUART.Checked := True;
      edUART.Text := Main.Settings.Params[i].Value;
    end
    else
    if Main.Settings.Params[i].Name = 'uarttune' then
      edUARTtune.Text := Main.Settings.Params[i].Value
    else
    if Main.Settings.Params[i].Name = 'uartdebug' then
      chUARTDebug.Checked := Main.Settings.Params[i].Value = 'yes'
    else
    if Main.Settings.Params[i].Name = 'uartfeature' then
    begin
      Par := TStringList.Create;
      ExtractStrings(['|'],[],PChar(Main.Settings.Params[i].Value),Par);

      if Par.Count > 1 then
      begin
        for y := 0 to Par.Count-1 do
          if Par[y] = 'main' then
            chMainenable.Checked := True
          else
          if Par[y] = 'scnd' then
            chScndenable.Checked := True
          else
          if Par[y] = 'train' then
            chTrainenable.Checked := True
          else
          if Par[y] = 'local' then
            chLocalenable.Checked := True
          else
          if Par[y] = 'radiovolume' then
            chRadioVolume.Checked := True
          else
          if Par[y] = 'radiochannel' then
            chRadioChannel.Checked := True;
      end
      else
      begin
        Par.Clear;
        ExtractStrings([' '],[],PChar(Main.Settings.Params[i].Value),Par);

        chMainenable.Checked    := Par[0] = 'yes';
        chScndenable.Checked    := Par[1] = 'yes';
        chTrainenable.Checked   := Par[2] = 'yes';
        chLocalenable.Checked   := Par[3] = 'yes';

        if Par.Count > 4 then
          chRadioVolume.Checked   := Par[4] = 'yes'
        else
          chRadioVolume.Enabled := False;

        if Par.Count > 5 then
          chRadioChannel.Checked  := Par[5] = 'yes'
        else
          chRadioChannel.Enabled := False;
      end;

      Par.Free;
    end;
  end;
end;

end.
