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

unit uUpdater;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  IdServerIOHandler, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, uIdHTTPProgress, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, Vcl.ComCtrls, Vcl.Controls;

type
  TfrmUpdater = class(TForm)
    lbUpdate: TLabel;
    SSL: TIdSSLIOHandlerSocketOpenSSL;
    pbProgress: TProgressBar;
    procedure FormCreate(Sender: TObject);
  private
    procedure AutoUpdate;
    procedure UpdateApp(const UpdateFile: TStringList);
    procedure IdHTTPProgressOnChange(Sender : TObject);
  public
    IdHTTPProgress: TIdHTTPProgress;
    const
      AppVersion = 126;
      procedure CheckUpdate(const Beta:Bool;const ReturnInfo:Bool=True);
      class procedure UpdateProgram(const Beta:Bool=False;const ReturnInfo:Bool=True);
  end;

implementation

uses uMain, ShellApi, System.UITypes, uUtilities;

{$R *.dfm}



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

      {$IFDEF WIN64}
        if Beta then
          UpdateFile.Text := IdHTTPProgress.Get('https://www.szczawik.net/maszyna/version64_beta.txt')
        else
          UpdateFile.Text := IdHTTPProgress.Get('https://www.szczawik.net/maszyna/version64.txt');
      {$ELSE}
        if Beta then
          UpdateFile.Text := IdHTTPProgress.Get('https://www.szczawik.net/maszyna/version_beta.txt')
        else
          UpdateFile.Text := IdHTTPProgress.Get('https://www.szczawik.net/maszyna/version.txt');
      {$ENDIF}

      if TryStrToInt(UpdateFile[0],Version) then
      begin
        if Version <= AppVersion then
        begin
          if ReturnInfo then
            ShowMessage(Util.LabelStr(CAP_CURRENT_VERSION));
        end
        else
        begin
          Hide;
          if Util.Ask(Util.LabelStr(CAP_NEWER_VERSION_ASK)) then
            UpdateApp(UpdateFile);
        end;
      end;
    except
      on E: Exception do
      begin
        Util.Log.Add(Util.LabelStr(CAP_UPDATE_FAULT) + ' ' + E.Message);

        if ReturnInfo then
          ShowMessage(Util.LabelStr(CAP_UPDATE_FAULT_EXT) + #13#10 + Util.LabelStr(CAP_FAULT_DETAIL) + ' ' + E.Message);
      end;
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
  IdHTTPProgress.Request.UserAgent := 'Mozilla/5.0';
end;

procedure TfrmUpdater.IdHTTPProgressOnChange(Sender: TObject);
begin
  pbProgress.Position := TIdHTTPProgress(Sender).Progress;
  Application.ProcessMessages;
end;

procedure TfrmUpdater.UpdateApp(const UpdateFile:TStringList);
var
  Par : TStringList;
  Version, i : Integer;
begin
  pbProgress.Visible := True;
  Show;
  Par := TStringList.Create;
  try
    try
      lbUpdate.Caption := Util.LabelStr(CAP_UPDATING);
      Main.Cursor := crHourGlass;
      Application.ProcessMessages;

      Par.Delimiter := ' ';
      for i := 1 to UpdateFile.Count-1 do
      begin
        IdHTTPProgress.OnChange := IdHTTPProgressOnChange;

        Par.DelimitedText := UpdateFile[i];

        if TryStrToInt(Par[0],Version) then
          if Version > AppVersion then
            if ForceDirectories(ExtractFileDir(Util.DIR + '\' + Par[2])) then
              IdHTTPProgress.DownloadFile('https://www.szczawik.net/maszyna/'+Par[1], Util.DIR + '\' + Par[2]);
      end;

      if FileExists(Util.DIR + 'update.bat') then
        AutoUpdate
      else
        ShowMessage(Util.LabelStr(CAP_UPDATED_PROGRAM));
    except
      on E: Exception do
        ShowMessage(Util.LabelStr(CAP_UPDATE_FAULT_EXT) + #13#10 + Util.LabelStr(CAP_FAULT_DETAIL) + ' ' + E.Message);
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
begin
  try
    if FileExists(Util.DIR + 'update.bat') then
      ShellExecute(Main.Handle, 'open', 'update.bat', nil, nil, SW_HIDE);
  except
    on E: Exception do
      ShowMessage(Util.LabelStr(CAP_UPDATE_FAULT_EXT) + #13#10 + Util.LabelStr(CAP_FAULT_DETAIL) + ' ' + E.Message);
  end;
end;

end.
