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

uses Classes;

type

  TRunInfo = record
    EXE         : string;
    SceneryName : string;
    Vehicle     : string;
    Logo        : string;
  end;

  TUtil = class
    Dir     : string;
    Lang    : string;
    InitSCN : string;
    Errors  : TStringList;
    constructor Create;
    procedure CheckInstallation(const EXECount:Integer);
    procedure OpenFile(const Path:string);
    procedure PrepareLoadingScreen(const LogoPath:string);
  end;

function Clamp(const Value, Min, Max:Integer):Integer;
procedure OpenDir(const Path:string);
procedure OpenURL(const URL:string);

procedure RemoveOldVersion;

procedure RunSimulator(const RunInfo:TRunInfo);
procedure SetFormatSettings;

function CompareVehicleNames(const Item1, Item2: Pointer): Integer;
function CompareTrainNames(const Item1, Item2: Pointer): Integer;

function OmitAccents(const aStr: String): String;
function ContainsOmitAccents(const S1,S2:string):Boolean;
function SameTextOmitAccents(const S1,S2:string):Boolean;

var
  Util  : TUtil;

implementation

uses ShellApi, Vcl.Forms, Windows, Vcl.Graphics, SysUtils, Dialogs, JPEG, uMain,
    uData, uStructures, StrUtils;

function Clamp(const Value, Min, Max:Integer):Integer;
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

procedure TUtil.OpenFile(const Path:string);
begin
  if FileExists(Util.DIR + Path) then
    ShellExecute(Application.Handle,'open',PChar(Util.DIR + Path),nil,nil, SW_SHOWNORMAL)
  else
    ShowMessage('Nie znaleziono pliku: ' + Path);
end;

procedure RemoveOldVersion;
begin
  try
    if FileExists(Util.DIR + 'StarterOld.exe') then
      DeleteFile(Util.DIR + 'StarterOld.exe');
  except
    on E: Exception do
      Util.Errors.Add('Nie uda³o siê usun¹æ poprzedniej wersji Startera. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

procedure TUtil.CheckInstallation(const EXECount:Integer);
var
  Err : string;
begin
  if DirectoryExists(Util.DIR + 'dynamic') = False then
    Err := Err + 'Brak katalogu /dynamic ' + #13#10;

  if DirectoryExists(Util.DIR + 'sounds') = False then
    Err := Err + 'Brak katalogu /sounds ' + #13#10;

  if DirectoryExists(Util.DIR + 'models') = False then
    Err := Err + 'Brak katalogu /models ' + #13#10;

  if DirectoryExists(Util.DIR + 'scenery') = False then
    Err := Err + 'Brak katalogu /scenery ' + #13#10;

  if DirectoryExists(Util.DIR + 'textures') = False then
    Err := Err + 'Brak katalogu /textures ' + #13#10;

  if FileExists(Util.DIR + 'data/load_weights.txt') = False then
    Err := Err + 'Brak informacji o wagach ³adunków.' + #13#10;

  if Data.Scenarios.Count = 0 then
    Err := Err + 'Nie znaleziono scenariuszy.' + #13#10;

  if Data.Textures.Count = 0 then
    Err := Err + 'Nie znaleziono pojazdów.' + #13#10;

  if Data.Physics.Count = 0 then
    Err := Err + 'Nie znaleziono danych taboru.' + #13#10;

  if EXECount = 0 then
    Err := Err + 'Nie znaleziono pliku wykonywalnego symulatora.' + #13#10;

  if Err.Length > 0 then
    ShowMessage(Err + 'Mo¿liwa b³êdna instalacja symulatora.');

  if Pos('\Program Files',Util.DIR) > 0 then
    Err := Err + 'Program zainstalowany w katalogu Program Files.';

  Util.Errors.Add(Err);
end;

procedure TUtil.PrepareLoadingScreen(const LogoPath:string);
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
      if FileExists(Util.DIR + 'textures\logo\' + LogoPath + '.jpg') then
        JPG.LoadFromFile(Util.DIR + 'textures\logo\' + LogoPath + '.jpg')
      else
      begin
        FoundFiles := FindFirst(Util.DIR + 'textures\logo\logo*.jpg',faAnyFile,SR);
        while (FoundFiles = 0) do
        begin
          if (SR.Name <> '.') and (SR.Name <> '..') then
            FilesList.Add(SR.Name);

          FoundFiles := FindNext(SR);
        end;
        FindClose(SR);

        JPG.LoadFromFile(Util.DIR + 'textures\logo\' + FilesList[Random(FilesList.Count)]);
      end;

      Bmp.PixelFormat := pf32bit;
      Bmp.Assign(JPG);
      Bmp.SaveToFile(Util.DIR + 'textures\logo.bmp');
    except
      on E: Exception do
        Util.Errors.Add('B³¹d obs³ugi logo. Szczegó³y b³êdu: ' + E.Message);
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
  if RunInfo.Logo.Length > 0 then
    Util.PrepareLoadingScreen(RunInfo.Logo)
  else
    Util.PrepareLoadingScreen(RunInfo.SceneryName);

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

function CompareVehicleNames(const Item1, Item2: Pointer): Integer;
begin
  if (TTrain(Item1).Vehicles.Count > 0) and (TTrain(Item2).Vehicles.Count > 0) then
    Result := CompareText(TTrain(Item1).Vehicles[0].Name, TTrain(Item2).Vehicles[0].Name)
  else
    Result := -1;
end;

function CompareTrainNames(const Item1, Item2: Pointer): Integer;
begin
  if (TTrain(Item1).Vehicles.Count > 0) and (TTrain(Item2).Vehicles.Count > 0) then
    Result := CompareText(TTrain(Item1).TrainName, TTrain(Item2).TrainName)
  else
    Result := -1;
end;

procedure SetFormatSettings;
begin
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.TimeSeparator    := ':';
  FormatSettings.ShortTimeFormat  := 'GG:mm';
  FormatSettings.LongTimeFormat   := 'GG:mm:ss';
end;

function OmitAccents(const aStr: String): String;
type
  ASCIIString = type AnsiString(1251);
begin
  Result := string(ASCIIString(aStr));
end;

function ContainsOmitAccents(const S1,S2:string):Boolean;
begin
  Result := ContainsText(OmitAccents(S1),OmitAccents(S2));
end;

function SameTextOmitAccents(const S1,S2:string):Boolean;
begin
  Result := SameText(OmitAccents(S1),OmitAccents(S2));
end;

{ TUtil }

constructor TUtil.Create;
begin
  DIR := ExtractFilePath(ParamStr(0));
  //DIR := 'G:\MaSzyna\pctga\';
  Errors := TStringList.Create;

  SetFormatSettings;
end;

end.
