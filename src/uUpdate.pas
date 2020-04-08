unit uUpdate;

interface

uses
  System.SysUtils, System.Classes, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP;

type
  TdmUpdater = class(TDataModule)
    HTTP: TIdHTTP;
    SSL: TIdSSLIOHandlerSocketOpenSSL;
  private
    procedure Update;
    procedure AutoUpdate;
    { Private declarations }
  public
    { Public declarations }
    const
      AppVersion = 6;
      procedure CheckUpdate;
  end;

var
  dmUpdater: TdmUpdater;

implementation

uses uMain, Dialogs, ShellApi, Windows, Controls, System.UITypes, uProgress;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmUpdater }

procedure TdmUpdater.CheckUpdate;
var
  UpdateFile, Par : TStringList;
  Stream: TMemoryStream;
  i, Version : Integer;
  Progress : TProgress;
begin
  try
    Progress := TProgress.Create(self);
    Progress.ShowModal;

    UpdateFile := TStringList.Create;
    UpdateFile.Text := HTTP.Get('http://www.szczawik.net/maszyna/version2.txt');

    if TryStrToInt(UpdateFile[0],Version) then
    begin
      if Version <= AppVersion then
      begin
        Progress.Close;
        ShowMessage('Posiadasz najnowsz¹ wersjê.');
      end
      else
        if MessageDlg('Zaktualizowaæ program?',mtConfirmation,[TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo],0) = mrYES then
        begin
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

          Stream.Free;
          Par.Free;
          UpdateFile.Free;

          Update;
        end;
    end;
  finally
    Progress.Free;
  end;
end;

procedure TdmUpdater.AutoUpdate;
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

procedure TdmUpdater.Update;
var
  Stream: TMemoryStream;
begin
  Main.Cursor := crHourGlass;
  Stream := TMemoryStream.Create;
  try
    HTTP.Get('http://www.szczawik.net/maszyna/Starter.exe', Stream);
    Stream.SaveToFile(Main.DIR + '\StarterNew.exe');
    AutoUpdate;
  finally
    Stream.Free;
    Main.Cursor := crDefault;
  end;
end;

end.
