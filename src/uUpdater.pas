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
  IdTCPConnection, IdTCPClient, IdHTTP, uIdHTTPProgress, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, Vcl.ComCtrls;

type
  TfrmUpdater = class(TForm)
    lbUpdate: TLabel;
    SSL: TIdSSLIOHandlerSocketOpenSSL;
    pbProgress: TProgressBar;
    procedure FormCreate(Sender: TObject);
  private
    procedure AutoUpdate;
    function Ask(const Text: string): Boolean;
    procedure Update(const UpdateFile: TStringList);
    procedure IdHTTPProgressOnChange(Sender : TObject);
  public
    IdHTTPProgress: TIdHTTPProgress;
    const
      AppVersion = 55;
      procedure CheckUpdate(const Beta:Bool;const ReturnInfo:Bool=True);
      class procedure UpdateProgram(const Beta:Bool=False;const ReturnInfo:Bool=True);
  end;

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

procedure TfrmUpdater.CheckUpdate(const Beta:Bool;const ReturnInfo:Bool=True);
var
  UpdateFile : TStringList;
  Version : Integer;
begin
  UpdateFile := TStringList.Create;
  try
    try
      Show;
      Application.ProcessMessages;

      if Beta then
        UpdateFile.Text := IdHTTPProgress.Get('https://www.szczawik.net/maszyna/ver_beta.txt')
      else
        UpdateFile.Text := IdHTTPProgress.Get('https://www.szczawik.net/maszyna/ver.txt');

      if TryStrToInt(UpdateFile[0],Version) then
      begin
        if Version <= AppVersion then
        begin
          if ReturnInfo then
            ShowMessage('Posiadasz najnowsz¹ wersjê.');
        end
        else
        begin
          Hide;
          if Ask('Dostêpna jest nowsza wersja. Zaktualizowaæ program?') then
            Update(UpdateFile);
        end;
      end;
    except
      on E: Exception do
        ShowMessage('Wyst¹pi³ b³¹d podczas aktualizacji programu.' + #13#10 + 'Szczegó³y b³êdu: ' + E.Message);
    end;
  finally
    UpdateFile.Free;
    Hide;
  end;
end;

procedure TfrmUpdater.FormCreate(Sender: TObject);
begin
  IdHTTPProgress := TIdHTTPProgress.Create(Self);
  IdHTTPProgress.IOHandler := SSL;
  IdHTTPProgress.Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
  IdHTTPProgress.Request.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)';
end;

procedure TfrmUpdater.IdHTTPProgressOnChange(Sender: TObject);
begin
  pbProgress.Position := TIdHTTPProgress(Sender).Progress;
  Application.ProcessMessages;
end;

procedure TfrmUpdater.Update(const UpdateFile:TStringList);
var
  Par : TStringList;
  i : Integer;
begin
  pbProgress.Visible := True;
  Show;
  Par := TStringList.Create;
  try
    try
      lbUpdate.Caption := 'Aktualizujê...';
      Main.Cursor := crHourGlass;
      Application.ProcessMessages;

      Par.Delimiter := ' ';
      for i := 1 to UpdateFile.Count-1 do
      begin
        IdHTTPProgress.OnChange := IdHTTPProgressOnChange;

        Par.DelimitedText := UpdateFile[i];
        IdHTTPProgress.DownloadFile('https://www.szczawik.net/maszyna/'+Par[0], Main.DIR + '\' + Par[1]);
      end;

      if FileExists(Main.DIR + '\StarterNew.exe') then
        AutoUpdate;
    except
      on E: Exception do
        ShowMessage('Wyst¹pi³ b³¹d podczas aktualizacji programu.' + #13#10 + 'Szczegó³y b³êdu: ' + E.Message);
    end;
  finally
    pbProgress.Visible := False;
    Main.Cursor := crDefault;
    Par.Free;
  end;
end;

class procedure TfrmUpdater.UpdateProgram(const Beta:Bool=False;const ReturnInfo:Bool=True);
begin
  with TfrmUpdater.Create(nil) do
  try
    CheckUpdate(Beta,ReturnInfo);
  finally
    Free;
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
    on E: Exception do
      ShowMessage('Wyst¹pi³ b³¹d podczas aktualizacji programu.' + #13#10 + 'Szczegó³y b³êdu: ' + E.Message);
  end;
end;

end.
