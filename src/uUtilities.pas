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

unit uUtilities;

interface

uses Classes, uStructures;

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
    Log     : TStringList;
    FileVersion : string;
    FileDateStr : string;
    StartApp : TDateTime;


    LAB_CAR_NO            : string;
    LAB_AI_TRAIN          : string;
    LAB_KEY1              : string;
    LAB_KEY2              : string;
    LAB_KEY3              : string;
    LAB_KEY_DESC          : string;
    LAB_WRONG_CONNECTION  : string;
    LAB_TRAIN_NAME        : string;
    LAB_TRAIN_NAME_CHANGE : string;
    LAB_FILE_NOT_FOUND    : string;
    LAB_SAVE_PRESET       : string;
    LAB_SET_PRESET_NAME   : string;

    constructor Create;
    function Ask(const Text: string): Boolean;
    procedure CheckInstallation(const EXECount:Integer);
    procedure EmptyTextures;
    function GetFileVersion(const FileName: string): string;
    procedure OpenFile(const Path:string);
    procedure PrepareLoadingScreen(const LogoPath:string);
    procedure LogAdd(const S:string;const ShowInfo:Boolean=False);
    function MiniPath(const Model: TModel): string;
  private
    procedure StringsLoad;
  end;

function Clamp(const Value, Min, Max:Integer):Integer;
procedure OpenDir(const Path:string);
procedure OpenURL(const URL:string);
function IsParameter(const Name:string):Boolean;

procedure RemoveOldVersion;

procedure RunSimulator(const RunInfo:TRunInfo);
procedure SetFormatSettings;

function CompareVehicleNames(const Item1, Item2: Pointer): Integer;
function CompareTrainNames(const Item1, Item2: Pointer): Integer;

function OmitAccents(const aStr: String): String;
function ContainsOmitAccents(const S1,S2:string):Boolean;
function SameTextOmitAccents(const S1,S2:string):Boolean;
function RandomBoolean:Boolean;

var
  Util  : TUtil;

implementation

uses ShellApi, Vcl.Forms, Windows, Vcl.Graphics, SysUtils, Dialogs, JPEG, uMain,
    uData, StrUtils, uSettingsAdv, StdCtrls, Controls;

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

function IsParameter(const Name:string):Boolean;
var
  i : Integer;
begin
  Result := False;

  for i := 1 to ParamCount do
    if ParamStr(i) = Name then
      Result := True;
end;

procedure TUtil.OpenFile(const Path:string);
begin
  if FileExists(Util.DIR + Path) then
    ShellExecute(Application.Handle,'open',PChar(Util.DIR + Path),nil,nil, SW_SHOWNORMAL)
  else
    ShowMessage('Nie znaleziono pliku: ' + Path);
end;

function TUtil.MiniPath(const Model:TModel):string;
begin
  try
    Result := '';

    if FileExists(DIR + 'textures\mini\' + Model.MiniD + '.bmp') then
      Result := DIR + 'textures\mini\' + Model.MiniD + '.bmp'
    else
      if FileExists(DIR + 'textures\mini\' + Model.Mini + '.bmp') then
        Result := DIR + 'textures\mini\' + Model.Mini + '.bmp';

    if Result.IsEmpty then
      if FileExists(DIR + 'textures\mini\other.bmp') then
        Result := DIR + 'textures\mini\other.bmp';
  except
    LogAdd('Nie uda³o siê wczytaæ miniaturki pojazdu ' + Model.Model);
  end;
end;

procedure RemoveOldVersion;
begin
  try
    if FileExists(Util.DIR + 'StarterOld.exe') then
      DeleteFile(Util.DIR + 'StarterOld.exe');
  except
    on E: Exception do
      Util.Log.Add('Nie uda³o siê usun¹æ poprzedniej wersji Startera. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

function TUtil.Ask(const Text:string):Boolean;
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

  if not Err.IsEmpty then
    Util.Log.Add(Err);
end;

procedure TUtil.EmptyTextures;
var
  MyFile: THandle;
begin
  try
    if not FileExists(Util.Dir + 'dynamic\textures.ini') then
    begin
      MyFile := FileCreate(Util.Dir + 'dynamic\textures.ini');
      FileClose(MyFile);
      Util.Log.Add('Utworzono plik dynamic\textures.ini');
    end;
  except
    Util.Log.Add('Nie uda³o siê utworzyæ pliku: dynamic\textures.ini');
  end;
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
        Util.Log.Add('B³¹d obs³ugi logo. Szczegó³y b³êdu: ' + E.Message);
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

function RandomBoolean:Boolean;
var
  i : Integer;
begin
  i := Random(100);
  Result := i mod 2 = 0;
end;

{ TUtil }

constructor TUtil.Create;
begin
  DIR := ExtractFilePath(ParamStr(0));
  //DIR := 'G:\MaSzyna\pctga\';
  //DIR := 'G:\MaSzyna\';
  Log := TStringList.Create;

  StringsLoad;
  SetFormatSettings;

  {$IFDEF WIN64}
    FileVersion := GetFileVersion(ParamStr(0)) + ' 64-bit' + ' beta';
  {$ELSE}
    FileVersion := GetFileVersion(ParamStr(0)) + ' beta';
  {$ENDIF}

  FileDateStr := FormatDateTime(' dd.mm.yyyy',FileDateToDateTime(FileAge(ParamStr(0))));
end;

procedure TUtil.StringsLoad;
begin
  LAB_TRAIN_NAME        := 'Nazwa poci¹gu';
  LAB_TRAIN_NAME_CHANGE := 'Zmiana nazwy poci¹gu';
  LAB_CAR_NO            := 'Numer wagonu: ';
  LAB_AI_TRAIN          := 'Poci¹g prowadzony przez komputer.';
  LAB_KEY1              := 'Przycisk 1';
  LAB_KEY2              := 'Przycisk 2';
  LAB_KEY3              := 'Przycisk 3';
  LAB_KEY_DESC          := 'Opis funkcji';
  LAB_WRONG_CONNECTION  := 'Niedopuszczalny rodzaj po³¹czenia miêdzy tymi pojazdami.';
  LAB_FILE_NOT_FOUND    := 'Nie znaleziono wybranego pliku.';
  LAB_SAVE_PRESET       := 'Zapis presetu ustawieñ';
  LAB_SET_PRESET_NAME   := 'Nadaj nazwê zestawu ustawieñ:';
end;

function TUtil.GetFileVersion(const FileName: string): string;
var
  iBufferSize: DWORD;
  iDummy: DWORD;
  pBuffer: Pointer;
  pFileInfo: Pointer;
  iVer: array[1..3] of word;
begin
  Result := '';

  iBufferSize := GetFileVersionInfoSize(PChar(FileName), iDummy);
  if (iBufferSize > 0) then
  begin
    Getmem(pBuffer, iBufferSize);
    try
      GetFileVersionInfo(PChar(FileName), 0, iBufferSize, pBuffer);
      VerQueryValue(pBuffer, '\', pFileInfo, iDummy);

      iVer[1] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
      iVer[2] := LoWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionMS);
      iVer[3] := HiWord(PVSFixedFileInfo(pFileInfo)^.dwFileVersionLS);
    finally
      Freemem(pBuffer);
    end;
    Result := Format('%d.%d.%d', [iVer[1], iVer[2], iVer[3]]);
  end;
end;

procedure TUtil.LogAdd(const S:string;const ShowInfo:Boolean=False);
begin
  Log.Add(S);

  if ShowInfo then
    ShowMessage(S);
end;

end.
