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

unit uUtilities;

interface

type

  TRunInfo = record
    EXE         : string;
    SceneryName : string;
    Vehicle     : string;
  end;

function Clamp(const Value:Integer;const Min:Integer; const Max:Integer):Integer;
procedure OpenDir(const Path:string);
procedure OpenURL(const URL:string);
procedure OpenFile(const Path:string);
procedure RemoveOldVersion;
procedure CheckInstallation;
procedure PrepareLoadingScreen(const LogoPath:string);
procedure RunSimulator(const RunInfo:TRunInfo);

implementation

uses ShellApi, Vcl.Forms, Windows, Vcl.Graphics, SysUtils, Dialogs, JPEG, Classes, uMain;

function Clamp(const Value:Integer;const Min:Integer; const Max:Integer):Integer;
begin
  Result := Value;
  if Value < Min then
    Result := Min
  else
    if Value > Max then
      Result := Max;
end;

procedure OpenDir(const Path:string);
begin
  ShellExecute(Application.Handle,
    PChar('explore'),
    PChar(Path),
    nil,
    nil,
    SW_SHOWNORMAL);
end;

procedure OpenURL(const URL:string);
begin
  ShellExecute(Application.Handle,'open',PChar(URL),nil,nil, SW_SHOWNORMAL);
end;

procedure OpenFile(const Path:string);
begin
  if FileExists(Main.DIR + Path) then
    ShellExecute(Application.Handle,'open',PChar(Main.DIR + Path),nil,nil, SW_SHOWNORMAL)
  else
    ShowMessage('Nie znaleziono pliku: ' + Path);
end;

procedure RemoveOldVersion;
begin
  try
    if FileExists(Main.DIR + 'StarterOld.exe') then
      DeleteFile(Main.DIR + 'StarterOld.exe');
  except
    on E: Exception do
      Main.Errors.Add('Nie uda³o siê usun¹æ poprzedniej wersji Startera. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

procedure CheckInstallation;
var
  Err : string;
begin
  if DirectoryExists(Main.DIR + 'dynamic') = False then
    Err := Err + 'Brak katalogu /dynamic ' + #13#10;

  if DirectoryExists(Main.DIR + 'sounds') = False then
    Err := Err + 'Brak katalogu /sounds ' + #13#10;

  if DirectoryExists(Main.DIR + 'models') = False then
    Err := Err + 'Brak katalogu /models ' + #13#10;

  if DirectoryExists(Main.DIR + 'scenery') = False then
    Err := Err + 'Brak katalogu /scenery ' + #13#10;

  if DirectoryExists(Main.DIR + 'textures') = False then
    Err := Err + 'Brak katalogu /textures ' + #13#10;

  if FileExists(Main.DIR + 'data/load_weights.txt') = False then
    Err := Err + 'Brak informacji o wagach ³adunków.' + #13#10;

  if Main.Scenarios.Count = 0 then
    Err := Err + 'Nie znaleziono scenariuszy.' + #13#10;

  if Main.Textures.Count = 0 then
    Err := Err + 'Nie znaleziono pojazdów.' + #13#10;

  if Main.Physics.Count = 0 then
    Err := Err + 'Nie znaleziono danych taboru.' + #13#10;

  if Main.cbEXE.Items.Count = 0 then
    Err := Err + 'Nie znaleziono pliku wykonywalnego symulatora.' + #13#10;

  if Err.Length > 0 then
    ShowMessage(Err + 'Mo¿liwa b³êdna instalacja symulatora.');

  if Pos('\Program Files',Main.DIR) > 0 then
    Err := Err + 'Program zainstalowany w katalogu Program Files.';

  Main.Errors.Add(Err);
end;

procedure PrepareLoadingScreen(const LogoPath:string);
var
  SR : TSearchRec;
  FoundFiles : Integer;
  FilesList : TStringList;
  JPG : TJPEGImage;
  BMP: Vcl.Graphics.TBitmap;
begin
  JPG := TJPEGImage.Create;
  FilesList := TStringList.Create;
  Bmp := Vcl.Graphics.TBitmap.Create;
  try
    try
      if FileExists(Main.DIR + 'textures\logo\' + LogoPath + '.jpg') then
        JPG.LoadFromFile(Main.DIR + 'textures\logo\' + LogoPath + '.jpg')
      else
      begin
        FoundFiles := FindFirst(Main.DIR + 'textures\logo\logo*.jpg',faAnyFile,SR);
        while (FoundFiles = 0) do
        begin
          if (SR.Name <> '.') and (SR.Name <> '..') then
            FilesList.Add(SR.Name);

          FoundFiles := FindNext(SR);
        end;
        FindClose(SR);

        JPG.LoadFromFile(Main.DIR + 'textures\logo\' + FilesList[Random(FilesList.Count)]);
      end;

      Bmp.PixelFormat := pf32bit;
      Bmp.Assign(JPG);
      Bmp.SaveToFile(Main.DIR + 'textures\logo.bmp');
    except
      on E: Exception do
        Main.Errors.Add('B³¹d obs³ugi logo. Szczegó³y b³êdu: ' + E.Message);
    end;
  finally
    JPG.Free;
    BMP.Free;
    FilesList.Free;
  end;
end;

procedure RunSimulator(const RunInfo:TRunInfo);
var
  Parameters : string;
  SEI : TShellExecuteInfo;
begin
  PrepareLoadingScreen(RunInfo.SceneryName);

  try
    Parameters := '-s ' + '$' + RunInfo.SceneryName + '.scn';
    Parameters := Parameters + ' -v ' + RunInfo.Vehicle;
    ZeroMemory(@SEI, SizeOf(SEI));
    SEI.cbSize := SizeOf(SEI);
    SEI.lpFile := PChar(RunInfo.EXE);
    SEI.lpParameters := PChar(Parameters);
    SEI.lpDirectory := PChar( ExtractFileDir(RunInfo.EXE));
    SEI.nShow := SW_SHOWNORMAL;
    ShellExecuteEx(@SEI);
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

end.
