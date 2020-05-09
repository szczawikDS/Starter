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

unit uUpdater;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  IdServerIOHandler, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack;

type
  TfrmUpdater = class(TForm)
    Label1: TLabel;
    HTTP: TIdHTTP;
    SSL: TIdSSLIOHandlerSocketOpenSSL;
  private
    procedure AutoUpdate;
    function Ask(const Text: string): Boolean;
    procedure Update(const UpdateFile: TStringList);
  public
    const
      AppVersion = 21;
      procedure CheckUpdate;
  end;

var
  frmUpdater: TfrmUpdater;

implementation

uses uMain, ShellApi, System.UITypes;

{$R *.dfm}

function TfrmUpdater.Ask(const Text:string):Boolean;
begin
  with CreateMessageDialog(Text, mtCustom, [mbYes, mbNo], mbNo) do
    begin
      try
        TButton(FindComponent('Yes')).Caption:= 'Tak';
        TButton(FindComponent('No')).Caption:= 'Nie';
        ShowModal;
      finally
        Result := ModalResult = mrYes;
        Free;
      end;
    end;
end;

procedure TfrmUpdater.CheckUpdate;
var
  UpdateFile : TStringList;
  Version : Integer;
begin
  UpdateFile := TStringList.Create;
  try
    Show;
    Application.ProcessMessages;

    UpdateFile.Text := HTTP.Get('https://www.szczawik.net/maszyna/ver.txt');

    if TryStrToInt(UpdateFile[0],Version) then
    begin
      if Version <= AppVersion then
        ShowMessage('Posiadasz najnowsz¹ wersjê.')
      else
      begin
        Hide;
        if Ask('Zaktualizowaæ program?') then
          Update(UpdateFile);
      end;
    end;
  finally
    UpdateFile.Free;
    Hide;
  end;
end;

procedure TfrmUpdater.Update(const UpdateFile:TStringList);
var
  Par : TStringList;
  Stream: TMemoryStream;
  i : Integer;
begin
  Show;
  try
    Main.Cursor := crHourGlass;
    Application.ProcessMessages;

    Par := TStringList.Create;
    Par.Delimiter := ' ';

    Stream := TMemoryStream.Create;
    for i := 1 to UpdateFile.Count-1 do
    begin
      Par.DelimitedText := UpdateFile[i];
      Stream.Clear;
      HTTP.Get('http://www.szczawik.net/maszyna/'+Par[0], Stream);
      Stream.SaveToFile(Main.DIR + '\' + Par[1]);
    end;

    if FileExists(Main.DIR + '\StarterNew.exe') then
      AutoUpdate;
  finally
    Main.Cursor := crDefault;
    Stream.Free;
    Par.Free;
  end;
end;

procedure TfrmUpdater.AutoUpdate;
var
  Bat : TStringList;
begin
  try
    Bat := TStringList.Create;
    Bat.Add('@echo off');
    Bat.Add('taskkill /im Starter.exe');
    Bat.Add('rename Starter.exe StarterOld.exe');
    Bat.Add('rename StarterNew.exe Starter.exe');
    Bat.Add('start Starter.exe');
    Bat.Add('taskkill /im update.bat');
    Bat.Add('del update.bat');
    Bat.SaveToFile(Main.DIR + '\update.bat');
    if FileExists(Main.DIR + '\update.bat') then
      ShellExecute(Main.Handle, 'open', 'update.bat', nil, nil, SW_HIDE);
    Bat.Free;
  except

  end;
end;

end.
