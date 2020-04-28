unit uUpdater;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.StdCtrls;

type
  TfrmUpdater = class(TForm)
    SSL: TIdSSLIOHandlerSocketOpenSSL;
    HTTP: TIdHTTP;
    Label1: TLabel;
  private
    procedure UpdateApp;
    procedure AutoUpdate;
    function Ask(const Text: string): Boolean;
  public
    const
      AppVersion = 19;
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
  UpdateFile, Par : TStringList;
  Stream: TMemoryStream;
  i, Version : Integer;
begin
  try
    Show;
    Application.ProcessMessages;

    UpdateFile := TStringList.Create;
    UpdateFile.Text := HTTP.Get('https://www.szczawik.net/maszyna/version2.txt');

    if TryStrToInt(UpdateFile[0],Version) then
    begin
      if Version <= AppVersion then
        ShowMessage('Posiadasz najnowsz¹ wersjê.')
      else
      begin
        Hide;
        if Ask('Zaktualizowaæ program?') then
        begin
          Show;
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

          Stream.Free;
          Par.Free;
          UpdateFile.Free;

          UpdateApp;
        end;
      end;
    end;
  finally
    Hide;
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

procedure TfrmUpdater.UpdateApp;
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
