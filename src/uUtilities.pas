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
  TLabels = (LAB_CAR_NO,LAB_AI_TRAIN,LAB_KEY1,LAB_KEY2,LAB_KEY3,LAB_KEY_DESC,
      LAB_WRONG_CONNECTION,LAB_TRAIN_NAME,LAB_TRAIN_NAME_CHANGE,
      LAB_FILE_NOT_FOUND,LAB_SAVE_PRESET,LAB_SET_PRESET_NAME,LAB_RANDOM_TEX_EXCEPT,

      LAB_LOAD_SETTINGS,LAB_LOAD_SCENERIES,CAP_START_NO_EXE,
      CAP_START_NO_SCN,CAP_START_GO_SEL_TRAIN,CAP_START_SEL_TRAIN,
      CAP_START_SEL_VEHICLE,CAP_START_NO_STAFF,CAP_NO_VEHICLES,

      LOG_NOT_FOUND_EXE,LOG_INTERNAL_ERROR,LOG_DEPO_LOAD_EXCEPT,LOG_SCN_MINI_LOAD_FAULT,

      LOG_TEX_NO_FILE,LOG_TEX_NO_MODEL,LOG_TEX_NO_PHYSICS,LOG_TEX_NO_MULTIMEDIA,

      LOG_LOAD_SCN,LOG_PARSE_SCN,

      LOG_NO_FILE,LOG_NO_MODEL,LOG_NO_PHYSICS,LOG_NO_MULTIMEDIA,LOG_CHECK_VALUE_FAULT,
      LOG_CHECK_PHYSICS_FILE,LOG_UNSUPPORTED_LOAD,

      LOG_DEPO_PARSE_FAULT,LOG_DEPO_SAVE_FAULT,LOG_PHYSICS_PARSE_FAULT,

      CAP_LOAD_SETTINGS_FAULT,CAP_PARAMETER,CAP_INVALID_VALUE,CAP_FAULT_DETAIL,
      CAP_ALGORITHM_FAULT,CAP_SET_CHANGED, CAP_FILE_NOT_FOUND, CAP_LOAD_MINI_FAULT,
      CAP_REMOVE_OLD_VER_FAULT,
      CAP_YES,CAP_NO,CAP_NO_DIR,CAP_NO_WEIGHTS,CAP_NO_SCN,CAP_NO_VEHICLES_2,CAP_NO_PHYSICS,
      CAP_NO_EXE,CAP_ERRORS,CAP_PROGRAM_FILES,CAP_CREATE_FILE_FAULT,CAP_LOGO_FAULT,
      CAP_CURRENT_VERSION,CAP_NEWER_VERSION_ASK,CAP_UPDATE_FAULT,CAP_UPDATE_FAULT_EXT,
      CAP_UPDATED_PROGRAM,CAP_UPDATING, CAP_OPERATION_FAULT, CAP_REMOVE_ALL_VEHICLES,
      CAP_LOADING_DEPOT,CAP_LOADING_PHYSICS,CAP_LOADING_SCN,CAP_LOADING_WEIGHTS,
      CAP_LOAD_MODELS_FAULT,CAP_LOAD_SCN_FAULT,CAP_PARSE_TRAIN_FAULT,CAP_VEHICLE_FAULT,
      CAP_LOAD_WEIGHTS_FAULT,CAP_VEHICLE_SYNTAX_FAULT,CAP_VEHICLE_PARSE_FAULT,CAP_STRINT_SYNTAX_FAULT,
      CAP_STRFLOAT_SYNTAX_FAULT,CAP_CONFIG_PARSE_FAULT,CAP_ATMO_PARSE_FAULT,
      CAP_PARSE_SCN,CAP_PARSE_SCN_FAULT,CAP_PARSE_TRAINSET_FAULT,CAP_PARSE_TEXTURES_FAULT,
      CAP_PARSE_TEX_DESC_FAULT,CAP_PARSE_PHYSICS_FAULT);

  LabelsSet = set of TLabels;

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

    var
      LabelsArray : array[0..75,0..1] of String;

    constructor Create;
    function Ask(const Text: string): Boolean;
    procedure CheckInstallation(const EXECount:Integer);
    procedure EmptyTextures;
    function GetFileVersion(const FileName:string;StrFormat:string='%d.%d.%d'): string;
    procedure OpenFile(const Path:string);
    procedure PrepareLoadingScreen(const LogoPath:string);
    procedure LogAdd(const S:string;const ShowInfo:Boolean=False);
    function MiniPath(const Model: TModel): string;
    function LabelStr(const ID: TLabels): string;
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
    ShowMessage(Format(LabelStr(CAP_FILE_NOT_FOUND), [Path]));
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
    LogAdd(Format(LabelStr(CAP_LOAD_MINI_FAULT), [Model.Model]));
  end;
end;

procedure RemoveOldVersion;
begin
  try
    if FileExists(Util.DIR + 'StarterOld.exe') then
      DeleteFile(Util.DIR + 'StarterOld.exe');
  except
    on E: Exception do
      Util.Log.Add(Format(Util.LabelStr(CAP_REMOVE_OLD_VER_FAULT), [E.Message]));
  end;
end;

function TUtil.Ask(const Text:string):Boolean;
begin
  with CreateMessageDialog(Text, mtCustom, [mbYes, mbNo], mbNo) do
    begin
      try
        TButton(FindComponent('Yes')).Caption:= Util.LabelStr(CAP_YES);
        TButton(FindComponent('No')).Caption:= Util.LabelStr(CAP_NO);
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
    Err := Err + Format(LabelStr(CAP_NO_DIR), ['/dynamic']) + #13#10;

  if DirectoryExists(Util.DIR + 'sounds') = False then
    Err := Err + Format(LabelStr(CAP_NO_DIR), ['/sounds']) + #13#10;

  if DirectoryExists(Util.DIR + 'models') = False then
    Err := Err + Format(LabelStr(CAP_NO_DIR), ['/models']) + #13#10;

  if DirectoryExists(Util.DIR + 'scenery') = False then
    Err := Err + Format(LabelStr(CAP_NO_DIR), ['/scenery']) + #13#10;

  if DirectoryExists(Util.DIR + 'textures') = False then
    Err := Err + Format(LabelStr(CAP_NO_DIR), ['/textures']) + #13#10;

  if FileExists(Util.DIR + 'data/load_weights.txt') = False then
    Err := Err + LabelStr(CAP_NO_WEIGHTS) + #13#10;

  if Data.Scenarios.Count = 0 then
    Err := Err + LabelStr(CAP_NO_SCN) + #13#10;

  if Data.Textures.Count = 0 then
    Err := Err + LabelStr(CAP_NO_VEHICLES_2) + #13#10;

  if Data.Physics.Count = 0 then
    Err := Err + LabelStr(CAP_NO_PHYSICS) + #13#10;

  if EXECount = 0 then
    Err := Err + LabelStr(CAP_NO_EXE) + #13#10;

  if Err.Length > 0 then
    ShowMessage(Err + LabelStr(CAP_ERRORS));

  if Pos('\Program Files',Util.DIR) > 0 then
    Err := Err + LabelStr(CAP_PROGRAM_FILES);

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
    Util.Log.Add(Format(LabelStr(CAP_CREATE_FILE_FAULT), ['dynamic\textures.ini']));
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
        Util.Log.Add(Format(LabelStr(CAP_LOGO_FAULT), [E.Message]));
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
var
  FileDate : TDateTime;
begin
  DIR := ExtractFilePath(ParamStr(0));
  //DIR := 'C:\MaSzyna\';
  Log := TStringList.Create;

  StringsLoad;
  SetFormatSettings;

  {$IFDEF WIN64}
    FileVersion := GetFileVersion(ParamStr(0)) + ' 64-bit'{ + ' beta'};
  {$ELSE}
    FileVersion := GetFileVersion(ParamStr(0)) {+ ' beta'};
  {$ENDIF}

  FileAge(ParamStr(0),FileDate);
  FileDateStr := FormatDateTime(' dd.mm.yyyy',FileDate);
end;

procedure TUtil.StringsLoad;
begin
  LabelsArray[Ord(LAB_TRAIN_NAME),1]        := 'Nazwa poci¹gu';
  LabelsArray[Ord(LAB_TRAIN_NAME_CHANGE),1] := 'Zmiana nazwy poci¹gu';
  LabelsArray[Ord(LAB_CAR_NO),1]            := 'Numer wagonu:';
  LabelsArray[Ord(LAB_AI_TRAIN),1]          := 'Poci¹g prowadzony przez komputer.';
  LabelsArray[Ord(LAB_KEY1),1]              := 'Przycisk 1';
  LabelsArray[Ord(LAB_KEY2),1]              := 'Przycisk 2';
  LabelsArray[Ord(LAB_KEY3),1]              := 'Przycisk 3';
  LabelsArray[Ord(LAB_KEY_DESC),1]          := 'Opis funkcji';
  LabelsArray[Ord(LAB_WRONG_CONNECTION),1]  := 'Niedopuszczalny rodzaj po³¹czenia miêdzy tymi pojazdami.';
  LabelsArray[Ord(LAB_FILE_NOT_FOUND),1]    := 'Nie znaleziono wybranego pliku.';
  LabelsArray[Ord(LAB_SAVE_PRESET),1]       := 'Zapis presetu ustawieñ';
  LabelsArray[Ord(LAB_SET_PRESET_NAME),1]   := 'Nadaj nazwê zestawu ustawieñ:';
  LabelsArray[Ord(LAB_RANDOM_TEX_EXCEPT),1] := 'Wyst¹pi³ b³¹d przy losowaniu tekstur. Szczegó³y b³êdu:';

  LabelsArray[Ord(LAB_LOAD_SETTINGS),1]       := 'Wczytywanie ustawieñ...';
  LabelsArray[Ord(LAB_LOAD_SCENERIES),1]      := 'Tworzenie listy scenariuszy...';

  LabelsArray[Ord(CAP_START_NO_EXE),1]        := 'Brak wybranego exe w ustawieniach';
  LabelsArray[Ord(CAP_START_NO_SCN),1]        := 'Brak wybranego scenariusza';
  LabelsArray[Ord(CAP_START_GO_SEL_TRAIN),1]  := 'PrzejdŸ do wyboru sk³adu';
  LabelsArray[Ord(CAP_START_SEL_TRAIN),1]     := 'Wybierz sk³ad do prowadzenia';
  LabelsArray[Ord(CAP_START_SEL_VEHICLE),1]   := 'Wybierz pojazd do prowadzenia';
  LabelsArray[Ord(CAP_START_NO_STAFF),1]      := 'Brak obsady pojazdu';
  LabelsArray[Ord(CAP_NO_VEHICLES),1]         := 'Wpis bez pojazdów. (Tor: %s)';

  LabelsArray[Ord(LOG_NOT_FOUND_EXE),1]       := 'Nie znaleziono pliku wykonywalnego (%s) symulatora.';
  LabelsArray[Ord(LOG_INTERNAL_ERROR),1]      := 'B³¹d wewnêtrzny Startera.';
  LabelsArray[Ord(LOG_DEPO_LOAD_EXCEPT),1]    := 'B³¹d wczytywania magazynu. Szczegó³y b³êdu:';
  LabelsArray[Ord(LOG_SCN_MINI_LOAD_FAULT),1] := 'Nie uda³o siê wczytaæ miniaturki scenariusza';

  LabelsArray[Ord(LOG_TEX_NO_FILE),1]         := 'Brak pliku';
  LabelsArray[Ord(LOG_TEX_NO_MODEL),1]        := 'Brak modelu dla tekstury';
  LabelsArray[Ord(LOG_TEX_NO_PHYSICS),1]      := 'Brak fizyki dla tekstury';
  LabelsArray[Ord(LOG_TEX_NO_MULTIMEDIA),1]   := 'Brak pliku mulitmediów dla tekstury';

  LabelsArray[Ord(LOG_LOAD_SCN),1]            := '£adowanie scenerii';
  LabelsArray[Ord(LOG_PARSE_SCN),1]           := 'Parsowanie scenerii';

  LabelsArray[Ord(LOG_NO_FILE),1]             := 'brak pliku tekstury.';
  LabelsArray[Ord(LOG_NO_MODEL),1]            := 'brak pliku modelu.';
  LabelsArray[Ord(LOG_NO_PHYSICS),1]          := 'brak pliku fizyki.';
  LabelsArray[Ord(LOG_NO_MULTIMEDIA),1]       := 'brak pliku multimediów.';
  LabelsArray[Ord(LOG_CHECK_VALUE_FAULT),1]   := 'B³¹d sprawdzania wartoœci';
  LabelsArray[Ord(LOG_CHECK_PHYSICS_FILE),1]  := 'Nale¿y sprawdziæ plik .fiz dla';
  LabelsArray[Ord(LOG_UNSUPPORTED_LOAD),1]    := 'zastosowany nieobs³ugiwany ³adunek przez pojazd';

  LabelsArray[Ord(LOG_DEPO_PARSE_FAULT),1]    := 'B³¹d parsowania magazynu. Linia:';
  LabelsArray[Ord(LOG_DEPO_SAVE_FAULT),1]     := 'B³¹d zapisu magazynu.';
  LabelsArray[Ord(LOG_PHYSICS_PARSE_FAULT),1] := 'B³¹d prztwarzania elementu fizyki. Token:';

  LabelsArray[Ord(CAP_LOAD_SETTINGS_FAULT),1] := 'B³¹d wczytywania ustawieñ (plik %s).';
  LabelsArray[Ord(CAP_PARAMETER),1]           := 'Parametr:';
  LabelsArray[Ord(CAP_INVALID_VALUE),1]       := 'B³êdna wartoœæ:';
  LabelsArray[Ord(CAP_FAULT_DETAIL),1]        := 'Szczegó³y b³êdu:';
  LabelsArray[Ord(CAP_ALGORITHM_FAULT),1]     := 'Wyst¹pi³ b³¹d przy próbie zmiany algorytmu. Szczegó³y b³êdu:';
  LabelsArray[Ord(CAP_SET_CHANGED),1]         := 'Wykryto zewnêtrzne zmiany w ustawieniach symulatora. Czy wczytaæ ustawienia ponownie?';

  LabelsArray[Ord(CAP_FILE_NOT_FOUND),1]      := 'Nie znaleziono pliku: %s';
  LabelsArray[Ord(CAP_LOAD_MINI_FAULT),1]     := 'Nie uda³o siê wczytaæ miniaturki pojazdu %s';
  LabelsArray[Ord(CAP_REMOVE_OLD_VER_FAULT),1]:= 'Nie uda³o siê usun¹æ poprzedniej wersji Startera. Szczegó³y b³êdu: %s';


  LabelsArray[Ord(CAP_YES),1]                 := 'Tak';
  LabelsArray[Ord(CAP_NO),1]                  := 'Nie';
  LabelsArray[Ord(CAP_NO_DIR),1]              := 'Brak katalogu %s';
  LabelsArray[Ord(CAP_NO_WEIGHTS),1]          := 'Brak informacji o wagach ³adunków.';
  LabelsArray[Ord(CAP_NO_SCN),1]              := 'Nie znaleziono scenariuszy.';
  LabelsArray[Ord(CAP_NO_VEHICLES_2),1]       := 'Nie znaleziono pojazdów.';
  LabelsArray[Ord(CAP_NO_PHYSICS),1]          := 'Nie znaleziono danych taboru.';
  LabelsArray[Ord(CAP_NO_EXE),1]              := 'Nie znaleziono pliku wykonywalnego symulatora.';
  LabelsArray[Ord(CAP_ERRORS),1]              := 'Mo¿liwa b³êdna instalacja symulatora.';
  LabelsArray[Ord(CAP_PROGRAM_FILES),1]       := 'Program zainstalowany w katalogu Program Files.';
  LabelsArray[Ord(CAP_CREATE_FILE_FAULT),1]   := 'Nie uda³o siê utworzyæ pliku: %s';
  LabelsArray[Ord(CAP_LOGO_FAULT),1]          := 'B³¹d obs³ugi logo. Szczegó³y b³êdu: %s';
  LabelsArray[Ord(CAP_CURRENT_VERSION),1]     := 'Posiadasz najnowsz¹ wersjê.';
  LabelsArray[Ord(CAP_NEWER_VERSION_ASK),1]   := 'Dostêpna jest nowsza wersja. Zaktualizowaæ program?';
  LabelsArray[Ord(CAP_UPDATE_FAULT),1]        := 'B³¹d aktualizacji';
  LabelsArray[Ord(CAP_UPDATE_FAULT_EXT),1]    := 'Wyst¹pi³ b³¹d podczas aktualizacji programu.';
  LabelsArray[Ord(CAP_UPDATED_PROGRAM),1]     := 'Program zosta³ zaktualizowany.';
  LabelsArray[Ord(CAP_UPDATING),1]            := 'Aktualizujê...';
  LabelsArray[Ord(CAP_OPERATION_FAULT),1]     := 'Wyst¹pi³ b³¹d podczas operacji.';
  LabelsArray[Ord(CAP_REMOVE_ALL_VEHICLES),1] := 'Usun¹æ wszystkie pojazdy na scenerii?';

  LabelsArray[Ord(CAP_LOADING_DEPOT),1]       := 'Wczytywanie taboru...';
  LabelsArray[Ord(CAP_LOADING_PHYSICS),1]     := 'Wczytywanie fizyki...';
  LabelsArray[Ord(CAP_LOADING_SCN),1]         := 'Wczytywanie scenerii...';
  LabelsArray[Ord(CAP_LOADING_WEIGHTS),1]     := 'Wczytywanie ³adunków...';

  LabelsArray[Ord(CAP_REMOVE_ALL_VEHICLES),1] := 'Usun¹æ wszystkie pojazdy na scenerii?';
  LabelsArray[Ord(CAP_REMOVE_ALL_VEHICLES),1] := 'Usun¹æ wszystkie pojazdy na scenerii?';
  LabelsArray[Ord(CAP_REMOVE_ALL_VEHICLES),1] := 'Usun¹æ wszystkie pojazdy na scenerii?';
  LabelsArray[Ord(CAP_REMOVE_ALL_VEHICLES),1] := 'Usun¹æ wszystkie pojazdy na scenerii?';


end;

function TUtil.LabelStr(const ID:TLabels):string;
begin
  Result := LabelsArray[Ord(ID),1];
end;

function TUtil.GetFileVersion(const FileName: string;StrFormat:string='%d.%d.%d'): string;
var
  iBufferSize, iDummy: DWORD;
  pBuffer, pFileInfo: Pointer;
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
    Result := Format(StrFormat, [iVer[1], iVer[2], iVer[3]]);
  end;
end;

procedure TUtil.LogAdd(const S:string;const ShowInfo:Boolean=False);
begin
  Log.Add(S);

  if ShowInfo then
    ShowMessage(S);
end;

end.
