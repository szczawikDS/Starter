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

unit uParser;

interface

uses CastaliaPasLexTypes, uStructures, uLexer, Classes;

type

  TParser = class(TLexer)
  public
    class procedure LoadData;
    class function ChangeConfig(const Text:string;const Config:TConfig):string;
    class procedure ParseScenario(SCN:TScenario);
    class function ParseTrainFromClipBoard(const Trainset:string):TTrain;
  protected
    function ParseVehicle(const TrainSet: Boolean=True): TVehicle;
  private
    procedure ParseConfig(var Config: TConfig);
    function ParseTrain: TTrain;
    procedure ParseAtmo(var Config: TConfig);
    procedure LoadWeights;
    function ScenarioName(const Path: string): TScenario;
    procedure ParseTextures(const Path: string);
    procedure ParseTrainset(var Scenariusz: TScenario;
      const TrainFile: TStringList);
    procedure LoadModels;
    procedure LoadSceneries;
    procedure ParseCoupler(var Vehicle: TVehicle);
    function GetBrakeValue(const Settings:string;Pos:Integer):string;
    procedure ParsePhysics(Physics:TPhysics;Path:string='';const aParams:TStringList=nil);
    function IsPhysics(const Dir:string;const Name: string):TPhysics;
    procedure LoadPhysics;
    procedure FindTexture(var Vehicle:TVehicle);
    procedure ParseTextDesc(Tex: TTexture);
    procedure ParseTextureModels(var Tex: TTexture);
  end;

implementation

uses SysUtils, uMain, uUtilities, Character, Math, System.Generics.Collections,
    System.Generics.Defaults {$IFDEF DEBUG},System.Diagnostics{$ENDIF}, uData, uStart;

{$IFDEF DEBUG}
procedure Measure;
var
  Stopwatch: TStopwatch;
  i : Integer;
begin
  Stopwatch := TStopwatch.StartNew;
  //
  i := Stopwatch.ElapsedMilliseconds;
  i := 0;
end;
{$ENDIF}

class procedure TParser.LoadData;
begin
  with TParser.Create do
  try
    LoadModels;
    LoadPhysics;
    LoadSceneries;
    LoadWeights;
  finally
    Free;
  end;
end;

procedure TParser.LoadModels;
var
  SR, SR2 : TSearchRec;
  Ilosc, Ilosc2 : Integer;
begin
  try
    Ilosc := FindFirst(Util.DIR + 'dynamic\*',faDirectory,SR);

    while (Ilosc = 0) do
    begin
      if (SR.Name <> '.') and (SR.Name <> '..') then
      begin
        Ilosc2 := FindFirst(Util.DIR + 'dynamic\'+SR.Name+'\*',faDirectory,SR2);

        while (Ilosc2 = 0) do
        begin
          if (SR2.Name <> '.') and (SR2.Name <> '..') then
            if FileExists(Util.DIR + 'dynamic\' + SR.Name + '\' + SR2.Name + '\textures.txt') then
              ParseTextures(Util.DIR + 'dynamic\' + SR.Name + '\' + SR2.Name + '\textures.txt');

          Ilosc2 := FindNext(SR2);
        end;
        FindClose(SR2);
      end;
      Ilosc := FindNext(SR);
    end;
    FindClose(SR);
  except
    on E: Exception do
      Util.Errors.Add('B³¹d wczytywania taboru. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

procedure TParser.LoadSceneries;
var
  SR : TSearchRec;
  Ilosc : Integer;
begin
  try
    Ilosc := FindFirst(Util.DIR + 'scenery\*.scn',faAnyFile,SR);

    while (Ilosc = 0) do
    begin
      if SR.Name[1] <> '$' then
        Data.Scenarios.Add(ScenarioName(Util.DIR + 'scenery\' + SR.Name));
      Ilosc := FindNext(SR);
    end;

    FindClose(SR);
  except
    Util.Errors.Add('B³¹d wczytywania scenerii ' + SR.Name);
  end;
end;

class function TParser.ParseTrainFromClipBoard(const Trainset:string):TTrain;
begin
  try
    TParser.Create;

    with TParser.Create do
    try
      Lexer.Origin := PChar(Trainset);
      Lexer.Init;

      Lexer.NextNoJunk;

      Result := ParseTrain;
    finally
      Free;
    end;
  except
    Result := nil;
  end;
end;

function TParser.ParseTrain:TTrain;
begin
  Result := TTrain.Create;
  try
    Lexer.NextNoJunk;
    Result.TrainName := GetToken();

    Lexer.NextNoJunk;
    Result.Track := GetToken;

    Lexer.NextNoJunk;
    Result.Dist := StrToFloat(GetToken);

    Lexer.NextNoJunk;
    Result.Vel := StrToFloat(GetToken);

    while (not SameText(Lexer.Token, 'endtrainset')) and (Lexer.TokenID <> ptNull) do
    begin
      if Lexer.TokenID = ptSlash then
          SkipComment;

      if (Lexer.TokenID = ptIdentifier) and (Pos('node',Lexer.Token) > 0) then
        Result.Vehicles.Add(ParseVehicle);

      if Pos('//$o',Lexer.Token) > 0 then
        if Pos('-',Lexer.Token) = 6 then
        begin
          Result.AI := True;
          Result.Desc := Copy(Lexer.Token,7,Lexer.TokenLen);
        end
        else
          Result.Desc := Copy(Lexer.Token,6,Lexer.TokenLen);

      if Pos('//$r',Lexer.Token) > 0 then
        Result.TimeTable := Copy(Lexer.Token,6,Lexer.TokenLen);

      Lexer.NextNoSpace;
    end;
  except
    on E: Exception do
      Util.Errors.Add('B³¹d parsowania sk³adu. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

procedure TParser.FindTexture(var Vehicle:TVehicle);
var
  i, y : Integer;
  Found : Boolean;
begin
  Vehicle.Texture := nil;
  Found := False;

  for i := 0 to Data.Textures.Count-1 do
    if (CompareText(Vehicle.ReplacableSkin,Data.Textures[i].Plik)=0) and
       (CompareText(Vehicle.Dir,Data.Textures[i].Dir)=0) then
    begin
      for y := 0 to Data.Textures[i].Models.Count-1 do
      begin
        Vehicle.Texture := Data.Textures[i];
        if CompareText(Vehicle.TypeChk,Data.Textures[i].Models[y].Model) = 0 then
        begin
          Vehicle.Texture := Data.Textures[i];
          Vehicle.ModelID := y;
          Found := True;
          Break;
        end;
      end;

      if Vehicle.Texture <> nil then
        Break;
    end;

  if not Found then
  begin
    Util.Errors.Add('');
    Util.Errors.Add('B³¹d sparowania tekstura/model:');
    Util.Errors.Add(PrepareNode(Vehicle,True));
  end;
end;

procedure TParser.LoadWeights;
var
  LoadWeights : TStringList;
  Load : TLoad;
  LoadName : string;
begin
  LoadWeights := TStringList.Create;
  try
    if FileExists(Util.DIR + 'data\load_weights.txt') then
    begin
      LoadWeights.LoadFromFile(Util.DIR + 'data\load_weights.txt');

      Lexer.Origin := PChar(LoadWeights.Text);
      Lexer.Init;

      Lexer.NextNoSpace;
      While Lexer.TokenID <> ptNull do
      begin
        if Lexer.TokenID = ptIdentifier then
        begin
          Load := TLoad.Create;
          LoadName := GetToken;
          Load.Name := Copy(LoadName,0,Pos(':',LoadName)-1);
          Lexer.NextNoJunk;
          Load.Weight := StrToInt(Lexer.Token);
          Data.Loads.Add(Load);
        end;
        Lexer.NextNoSpace;
      end;
    end;
  except
    Util.Errors.Add('B³¹d wczytywania wag jednostek ³adunków.');
    LoadWeights.Free;
  end;
end;

function TParser.ParseVehicle(const TrainSet:Boolean=True):TVehicle;
var
  Position : Integer;
begin
  try
    Result := TVehicle.Create;

    Lexer.NextNoJunk;
    Result.MinDist := StrToFloat( GetToken );

    Lexer.NextNoJunk;
    Result.MaxDist := StrToFloat( GetToken );

    Lexer.NextNoJunk;
    Result.Name := GetToken;

    Position := Pos('#',Result.Name);
    if Position > 0 then
    begin
      Result.Number := StrToInt(Copy(Result.Name,Position+1,Result.Name.Length));
      Result.Name := Copy(Result.Name,0,Position-1);
    end
    else
      Result.Number := 0;

    Lexer.NextID(ptIdentifier);

    if not SameText('dynamic',Lexer.Token) then
      Util.Errors.Add('B³¹d sk³adniowy wpisu pojazdu ' + Result.Name + ', wyra¿enie ' + Lexer.Token);

    Lexer.NextID(ptIdentifier);
    Result.Dir := GetToken;

    Lexer.NextNoJunk;
    Result.ReplacableSkin := ChangeFileExt(GetToken,'');

    Result.Dir := StringReplace(Result.Dir,'/','\',[]);

    Lexer.NextNoJunk;
    Result.TypeChk := GetToken;

    Lexer.NextNoJunk;
    if not TrainSet then
    begin
      Result.PathName := GetToken;
      Lexer.NextNoJunk;
    end;

    Result.Dist := StrToFloat( GetToken );

    Lexer.NextNoJunk;
    if SameText(Lexer.Token,'headdriver') then Result.CabOccupancy := coHeadDriver else
    if SameText(Lexer.Token,'reardriver') then Result.CabOccupancy := coRearDriver else
    if SameText(Lexer.Token,'nobody')     then Result.CabOccupancy := coNobody     else
    if SameText(Lexer.Token,'passenger')  then Result.CabOccupancy := coPassenger  else
    if SameText(Lexer.Token,'connected')  then Result.CabOccupancy := coNobody;

    Lexer.NextNoJunk;
    if TrainSet then
    begin
      Result.Settings := GetToken([ptSpace,ptCRLF]);
      ParseCoupler(Result);
    end
    else
      Result.Vel := StrToFloat(GetToken);

    Lexer.NextNoJunk;
    Result.Loadquantity := StrToInt(GetToken);

    if Result.Loadquantity > 0 then
    begin
      Lexer.NextNoJunk;
      Result.LoadType := GetToken;
    end;

    FindTexture(Result);
  except
    on E: Exception do
      Util.Errors.Add('B³¹d parsowania wpisu pojazdu ' + Result.Name + ' . Szczegó³y b³êdu: ' + E.Message);
  end;
end;

function TParser.GetBrakeValue(const Settings:string;Pos:Integer):string;
begin
  result := '';
  while (IsNumber(Settings[Pos])) and (Pos <= Settings.Length) do
  begin
    result := result + Settings[Pos];
    Inc(Pos);
  end;
end;

procedure TParser.ParseCoupler(var Vehicle : TVehicle);
var
  i : Integer;
  Wheels, Brakes : Boolean;
begin
  try
    i := Pos('.',Vehicle.Settings);

    if i = 0 then
      Vehicle.Coupler := StrToInt(Vehicle.Settings)
    else
    begin
      Vehicle.Coupler := StrToInt(Copy(Vehicle.Settings,0,i-1));

      Inc(i);
      Vehicle.Sway := -1;
      Vehicle.Flatness := -1;
      Vehicle.FlatnessRand := -1;
      Vehicle.FlatnessProb := -1;

      Brakes := False;
      Wheels := False;
      while (i <= Vehicle.Settings.Length) or (IsNumber(Vehicle.Settings[i])) do
      begin
        if Vehicle.Settings[i] = '.' then
        begin
          Brakes := False;
          Wheels := False;
        end
        else
          if Vehicle.Settings[i] = 'B' then
          begin
            Brakes := True;
            Vehicle.Brake := Vehicle.Settings[i+1];
          end
          else
            if Vehicle.Settings[i] = 'W' then
              Wheels := True
            else
              if (not Brakes) and (not Wheels) and (Vehicle.Settings[i] = 'T') then
                Vehicle.ThermoDynamic := Vehicle.Settings[i+1] = 'A';

        if Brakes then
        begin
          if Vehicle.Settings[i] = '0' then
            Vehicle.BrakeState := Vehicle.Settings[i] else
          if Vehicle.Settings[i] = '1' then
            Vehicle.BrakeState := Vehicle.Settings[i] else
          if Vehicle.Settings[i] = 'T' then
            Vehicle.BrakeAdjust := Vehicle.Settings[i] else
          if Vehicle.Settings[i] = 'H' then
            Vehicle.BrakeAdjust := Vehicle.Settings[i] else
          if Vehicle.Settings[i] = 'F' then
            Vehicle.BrakeAdjust := Vehicle.Settings[i];
        end
        else
          if Wheels then
          begin
            if Vehicle.Settings[i+1] = 'H' then
              Vehicle.Sway := StrToInt(GetBrakeValue(Vehicle.Settings,i+2)) else
            if Vehicle.Settings[i+1] = 'F' then
              Vehicle.Flatness := StrToInt(GetBrakeValue(Vehicle.Settings,i+2)) else
            if Vehicle.Settings[i+1] = 'R' then
              Vehicle.FlatnessRand := StrToInt(GetBrakeValue(Vehicle.Settings,i+2)) else
            if Vehicle.Settings[i+1] = 'P' then
              Vehicle.FlatnessProb := StrToInt(GetBrakeValue(Vehicle.Settings,i+2));
          end;

        Inc(i);
      end;
    end;

    if Vehicle.Coupler < 0 then
      Vehicle.Coupler := Abs(Vehicle.Coupler) + 128;

  except
    Util.Errors.Add('B³¹d parsowania sprzêgu ' + Vehicle.Name + ', linia ' + IntToStr(Lexer.LineNumber));
  end;
end;

procedure TParser.ParseConfig(var Config: TConfig);
var
  Token : string;
begin
  try
    Config.Day := 0;
    Config.Temperature := 15;
    Config.Other := '';

    Lexer.NextNoSpace;
    While (Lexer.Token <> 'endconfig') and (Lexer.TokenID <> ptNull) do
    begin
      if Lexer.TokenID = ptSlash then
        SkipComment
      else
      begin
        if (SameText(Lexer.Token, 'movelight')) then
        begin
          Lexer.NextNoJunk;
          Config.Day := StrToInt(GetToken);
        end
        else
        if SameText(Lexer.Token, 'scenario') then
        begin
          Token := GetToken;
          if SameText(Token, 'scenario.weather.temperature') then
          begin
            Lexer.NextNoJunk;
            Config.Temperature := StrToFloat(GetToken);
          end
          else
          begin
            if SameText(Token, 'scenario.time.override') then
            begin
              Lexer.NextNoJunk;
              GetToken;
            end;
          end;
        end
        else
          Config.Other := Config.Other + Lexer.Token + ' ';
      end;
      Lexer.NextNoSpace;
    end;
  except
    on E: Exception do
      Util.Errors.Add('B³¹d parsowania sekcji config. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

class function TParser.ChangeConfig(const Text:string;const Config:TConfig):string;
var
  EndPointer, ConfigPos : integer;
  AtmoStr, Token : string;
begin
  try
    with TParser.Create do
    try
      Lexer.Origin := PChar(Text);
      Lexer.Init;

      result := '';
      EndPointer := 0;

      Lexer.NextNoSpace;
      While Lexer.TokenID <> ptNull do
      begin
        if (Lexer.TokenID = ptIdentifier) then
        begin
          if (SameText(Lexer.Token, 'config')) then
          begin
            result := result + Copy(Text,EndPointer,Lexer.TokenPos-EndPointer);

            while not SameText(Lexer.Token, 'endconfig') do
              Lexer.NextNoJunk;

            EndPointer := Lexer.TokenPos + Lexer.TokenLen + 1;
          end;
          //////////////////////////
          if (SameText(Lexer.Token, 'movelight')) then
          begin
            result := result + Copy(Text,EndPointer,Lexer.TokenPos-EndPointer);
            Lexer.NextNoJunk;
            EndPointer := Lexer.TokenPos + Lexer.TokenLen + 1;
          end
          else
          if SameText(Lexer.Token, 'scenario') then
          begin
            Token := GetToken;
            if SameText(Token, 'scenario.weather.temperature') then
            begin
              result := result + Copy(Text,EndPointer,Lexer.TokenPos-EndPointer-27);
              Lexer.NextNoJunk;
              GetToken;
              EndPointer := Lexer.TokenPos + Lexer.TokenLen + 1;
            end
            else
            if SameText(Token, 'scenario.time.override') then
            begin
              result := result + Copy(Text,EndPointer,Lexer.TokenPos-EndPointer-22);
              Lexer.NextNoJunk;
              GetToken;
              EndPointer := Lexer.TokenPos + Lexer.TokenLen + 1;
            end;
          end;
          /////////////////
          if SameText(Lexer.Token, 'time') then
          begin
            result := result + Copy(Text,EndPointer,Lexer.TokenPos-EndPointer-1);
            while not SameText(Lexer.Token, 'endtime') do
              Lexer.NextNoJunk;
            GetToken;
            EndPointer := Lexer.TokenPos + Lexer.TokenLen + 1;
          end
          else
          if SameText(Lexer.Token, 'atmo') then
          begin
            result := result + Copy(Text,EndPointer,Lexer.TokenPos-EndPointer-1);

            while not SameText(Lexer.Token, 'endatmo') do
              Lexer.NextNoJunk;

            EndPointer := Lexer.TokenPos + Lexer.TokenLen + 1;
          end;
        end;

        Lexer.NextNoSpace;
      end;

      Result := Result + Copy(Text,EndPointer,Text.Length);
      Result := 'config ' + #13#10 + 'endconfig' + #13#10 + Result;
      ConfigPos := 8;

      Insert(#13#10 + 'time ' + FormatDateTime('h:MM',Config.StartTime) + ' 0 0 endtime ',Result, ConfigPos + 11);

      AtmoStr := #13#10 + 'atmo 0 0 0 ' + IntToStr(Config.FogEnd) + ' ' + IntToStr(Config.FogEnd) + ' 0 0 0';
      AtmoStr := AtmoStr + ' ' + FloatToStr(Config.Overcast) + ' endatmo';
      Insert(AtmoStr,Result, ConfigPos + 11);

      Insert(#13#10 + Config.Other ,Result, ConfigPos);
      Insert(#13#10 + 'movelight ' + IntToStr(Config.Day) + ' ',Result, ConfigPos);
      Insert(#13#10 + 'scenario.weather.temperature ' + FloatToStr(Config.Temperature) + ' ',Result, ConfigPos);
      Insert(#13#10 + 'scenario.time.override ' + FormatDateTime('h:MM',Config.Time) + ' ',Result, ConfigPos);
    finally
      Free;
    end;
  except
    Result := Text;
  end;
end;

procedure TParser.ParseAtmo(var Config:TConfig);
begin
  try
    Lexer.NextNoJunk;
    Lexer.NextNoJunk;
    Lexer.NextNoJunk;
    Lexer.NextNoJunk;
    Config.FogStart := Clamp(StrToInt(Lexer.Token),10,2500);
    Lexer.NextNoSpace;
    Config.FogEnd := Clamp(StrToInt(Lexer.Token),Config.FogStart,2500);
    Config.FogEnd := RandomRange(Config.FogStart,Config.FogEnd);

    if Config.FogEnd > 0 then
    begin
      Lexer.NextNoJunk;
      Lexer.NextNoJunk;
      Lexer.NextNoJunk;
    end;

    Lexer.NextNoSpace;

    if Lexer.Token <> 'endatmo' then
      Config.Overcast := StrToFloat(GetToken);
  except
    on E: Exception do
      Util.Errors.Add('B³¹d parsowania wpisu atmo. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

function TParser.ScenarioName(const Path:string):TScenario;
var
  Plik : TStringList;
begin
  Result := TScenario.Create;
  Result.ID := '-';
  Result.Path := Path;
  Result.Name := ExtractFileName(Path);
  Result.Name := Copy(Result.Name,0,Result.Name.Length-4);

  Plik := TStringList.Create;
  Plik.LoadFromFile(Path);

  Lexer.Origin := PChar(Plik.Text);
  Lexer.Init;

  While Lexer.TokenID <> ptNull do
  begin
    if Lexer.TokenID = ptSlashesComment then
      begin
        if Pos('$n', Lexer.Token) > 0 then Result.Title := Copy(Lexer.Token,6,Lexer.TokenLen)
        else
        if Pos('$d', Lexer.Token) > 0 then Result.Desc.Add(Copy(Lexer.Token,6,Lexer.TokenLen))
        else
        if Pos('$f', Lexer.Token) > 0 then Result.Files.Add(Copy(Lexer.Token,6,Lexer.TokenLen))
        else
        if Pos('$i', Lexer.Token) > 0 then Result.Image := Copy(Lexer.Token,6,Lexer.TokenLen)
        else
        if Pos('$l', Lexer.Token) > 0 then Result.ID := Copy(Lexer.Token,6,Lexer.TokenLen);
      end
      else
        if Lexer.TokenID = ptSlash then
          SkipComment;

    Lexer.NextNoSpace;

    if (Lexer.TokenID = ptIdentifier) and (Lexer.Token = 'FirstInit') then
      Exit;
  end;
end;

class procedure TParser.ParseScenario(SCN:TScenario);
var
  Plik, FirstInit, IncFirstInit : TStringList;
  FirstInitPos : integer;
  IncludeStr : string;
  Config : TConfig;
begin
  with TParser.Create do
  try
    try
      Plik := TStringList.Create;
      Plik.LoadFromFile(SCN.Path);

      FirstInitPos := Pos('FirstInit',Plik.Text);
      SCN.Other.Text := Copy(Plik.Text,0,FirstInitPos-1);

      SCN.Trains.Free;
      SCN.Trains := TObjectList<TTrain>.Create;
      SCN.Vehicles.Free;
      SCN.Vehicles := TObjectList<TVehicle>.Create;

      Config.Day          := 0;
      Config.Temperature  := 15;
      Config.Time         := Now;

      Config.StartTime    := StrToTime('10:30');
      Config.Overcast     := 0;

      FirstInit := TStringList.Create;
      FirstInit.Text := Copy(Plik.Text,FirstInitPos,Plik.Text.Length);

      Lexer.Origin := PChar(Plik.Text);
      Lexer.Init;

      Lexer.NextNoSpace;
      While Lexer.TokenID <> ptNull do
      begin
        if Lexer.TokenID = ptSlash then
          SkipComment
        else
        begin
          if Lexer.TokenID = ptIdentifier then
          begin
            if SameText(Lexer.Token, 'description') then
              while not SameText(Lexer.Token, 'enddescription') and (Lexer.TokenID <> ptNull) do
                Lexer.Next;

            if SameText(Lexer.Token,'config') then
              ParseConfig(Config)
            else
            if SameText(Lexer.Token,'atmo') then
              ParseAtmo(Config)
            else
            if SameText(Lexer.Token,'time') then
            begin
              Lexer.NextNoJunk;
              Config.Time := StrToTime(GetToken);
              Config.StartTime := Config.Time;
            end;

            SCN.Config := Config;

            if (SameText(Lexer.Token, 'include')) and (Lexer.TokenPos > FirstInitPos) then
            begin
              Lexer.NextNoJunk;

              IncludeStr := EmptyStr;
              while (not Lexer.IsJunk) and (Lexer.TokenID <> ptNull) do
              begin
                IncludeStr := IncludeStr + Lexer.Token;
                Lexer.Next;
              end;

              if FileExists(Util.DIR + 'scenery\' + IncludeStr) then
              begin
                IncFirstInit := TStringList.Create;
                IncFirstInit.LoadFromFile(Util.DIR + 'scenery\' + IncludeStr);
                FirstInit.Add(IncFirstInit.Text);
                IncFirstInit.Free;
              end;
            end;
          end;
        end;

        Lexer.NextNoSpace;
      end;

      ParseTrainset(SCN,FirstInit);
      Plik.Free;
    except
      on E: Exception do
        Util.Errors.Add('B³¹d parsowania ' + SCN.Path + ', linia: ' + IntToStr(Lexer.LineNumber) + ' Szczegó³y b³êdu: ' + E.Message);
    end;
  finally
    Free;
  end;
end;

procedure TParser.ParseTrainset(var Scenariusz:TScenario;const TrainFile:TStringList);
var
  Pociag : TTrain;
begin
  try
    Lexer.Origin := PChar(TrainFile.Text);
    Lexer.Init;

    While Lexer.TokenID <> ptNull do
    begin
      if Lexer.TokenID = ptSlash then
        SkipComment;

      if Lexer.TokenID = ptIdentifier then
      begin
        if (Pos('trainset',Lexer.Token) > 0) and (Pos('endtrainset',Lexer.Token) = 0) then
        begin
          Pociag := ParseTrain;
          Scenariusz.Trains.Add(Pociag);
        end
        else
          if Lexer.Token = 'node' then
          begin
            Lexer.InitAhead;

            while (Lexer.AheadTokenID <> ptIdentifier) and (Lexer.AheadTokenID <> ptNull) do
              Lexer.AheadNext;

            if not SameText(Lexer.AheadToken,'dynamic') then
              Lexer.AheadNext;

            if SameText(Lexer.AheadToken,'dynamic') then
              Scenariusz.Vehicles.Add(ParseVehicle(False));
          end;
      end;

      Lexer.NextNoJunk;
    end;
  except
    on E: Exception do
      Util.Errors.Add('B³¹d parsowania sk³adu. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

procedure TParser.ParseTextureModels(var Tex:TTexture);
var
  Sign : Char;
  Model : TModel;
begin
  try
    while Lexer.TokenID = ptEqual do
    begin
      Lexer.NextNoSpace;

      Model := TModel.Create;
      Model.Model := GetToken([ptComma]);
      Lexer.NextNoSpace;
      Model.Mini := GetToken([ptComma,ptSlashesComment,ptEqual]);

      if Tex.Typ = tyUnknown then
      begin
        Sign := Model.Mini[1];
        Sign := UpperCase(Sign)[1];

        if Sign = 'B' then Tex.Typ := tyB else
        if Sign = 'E' then Tex.Typ := tyE else
        if Sign = 'A' then Tex.Typ := tyA else
        if Sign = 'S' then Tex.Typ := tyS else
        if Sign = 'F' then Tex.Typ := tyF else
        if Sign = 'G' then Tex.Typ := tyG else
        if Sign = 'R' then Tex.Typ := tyR else
        if Sign = 'U' then Tex.Typ := tyU else
        if Sign = 'W' then Tex.Typ := tyW else
        if Sign = 'X' then Tex.Typ := tyX else
        if Sign = 'Z' then Tex.Typ := tyZ else
        if Sign = 'D' then Tex.Typ := tyD else
        if Sign = 'H' then Tex.Typ := tyH else
        if Sign = 'I' then Tex.Typ := tyI else
        if Sign = 'L' then Tex.Typ := tyL else
        if Sign = 'P' then Tex.Typ := tyP else
        if Sign = 'V' then Tex.Typ := tyV;
      end;

      if Lexer.TokenID = ptComma then
      begin
        Lexer.NextNoSpace;
        Model.MiniD := GetToken([ptComma,ptSlashesComment,ptEqual,ptSpace]);
      end;

      Tex.Models.Add(Model);
    end;
  except
    Util.Errors.Add('B³¹d parsowania textures.txt dla ' + Tex.Dir + '\' + Tex.Plik + ', linia: ' + IntToStr(Lexer.LineNumber));
  end;
end;

procedure TParser.ParseTextures(const Path:string);
var
  Plik : TStringList;
  i, y, Crew, CrewCount : Integer;
  Tex : TTexture;
  Physics : TPhysics;
  Token : string;
  Grupa : TTyp;
begin
  try
    Plik := TStringList.Create;
    Plik.LoadFromFile(Path);

    Crew := 0;

    try
      for i := 0 to Plik.Count-1 do
      begin
        if Pos('#',Plik[i]) = 1 then Continue else
        if Pos('@',Plik[i]) = 1 then Continue else
        if Pos('*',Plik[i]) = 1 then Continue else
        if Pos('^',Plik[i]) = 1 then
        begin
          Crew := StrToInt(Copy(Plik[i],2,1))-1;
          CrewCount := 0;
        end
        else
        if Pos('!=',Plik[i]) = 1 then
        begin
          Token := Copy(Plik[i],3,1);

          if Token = '*' then
            Grupa := tyUnknown else
          if Token='z' then Grupa := tyEZT        else
          if Token='e' then Grupa := tyELEKTROWOZ else
          if Token='s' then Grupa := tySPALINOWOZ else
          if Token='a' then Grupa := tySZYNOBUS   else
          if Token='B' then Grupa := tyB else
          if Token='E' then Grupa := tyE else
          if Token='A' then Grupa := tyA else
          if Token='S' then Grupa := tyS else
          if Token='F' then Grupa := tyF else
          if Token='G' then Grupa := tyG else
          if Token='R' then Grupa := tyR else
          if Token='U' then Grupa := tyU else
          if Token='r' then Grupa := tyROBOCZY    else
          if Token='W' then Grupa := tyW else
          if Token='X' then Grupa := tyX else
          if Token='d' then Grupa := tyDREZYNA    else
          if Token='o' then Grupa := tySAMOCHOD   else
          if Token='b' then Grupa := tyAUTOBUS    else
          if Token='c' then Grupa := tyCIEZAROWKA else
          if Token='Z' then Grupa := tyZ else
          if Token='D' then Grupa := tyD else
          if Token='H' then Grupa := tyH else
          if Token='I' then Grupa := tyI else
          if Token='L' then Grupa := tyL else
          if Token='P' then Grupa := tyP else
          if Token='V' then Grupa := tyV else
          if Token='t' then Grupa := tyTRAMWAJ    else
          if Token='h' then Grupa := tyOSOBA      else
          if Token='f' then Grupa := tyZWIERZE    else
          if Token='p' then Grupa := tyPAROWOZ    else
          if Token='x' then Grupa := tyPROTOTYP   else
          Grupa := tyINNE;
          Continue;
        end;
        Token := '';

        if Pos('=',Plik[i]) > 0 then
        begin
          Tex := TTexture.Create;
          Tex.ID := Data.Textures.Count;
          Tex.NextTexID := -1;
          Tex.PrevTexID := -1;
          if Crew > 0 then
          begin
            if (CrewCount > 0) and (CrewCount <= Crew) then
            begin
              Tex.PrevTexID := Data.Textures.Count-1;
              Data.Textures[Data.Textures.Count-1].NextTexID := Data.Textures.Count;
            end;
            Inc(CrewCount);

            if CrewCount > Crew then
                CrewCount := 0;
          end;

          Tex.Typ := Grupa;
          Tex.Dir := ExtractFileDir(Copy(Path,Pos('dynamic',Path)+8,Length(Path)));
          Lexer.Origin := PChar(Plik[i]);
          Lexer.Init;

          Tex.Plik := GetToken([ptEqual]);
          Tex.Plik := ChangeFileExt(Tex.Plik,'');

          Token := EmptyStr;

          ParseTextureModels(Tex);

          if Lexer.TokenID = ptSlashesComment then
          begin
            Tex.Desc := Copy(Lexer.Token,3,Lexer.TokenLen);
            ParseTextDesc(Tex);
          end;

          for y := 0 to Tex.Models.Count-1 do
          begin
            if FileExists(Util.DIR + 'dynamic\' + Tex.Dir + '\' + Tex.Models[y].Model + '.fiz') or
               FileExists(Util.DIR + 'dynamic\' + Tex.Dir + '\' + Tex.Models[y].Model + 'dumb.fiz') then
            begin
              Tex.Models[y].Fiz := IsPhysics(Tex.Dir,Tex.Models[y].Model);
              if Tex.Models[y].Fiz = nil then
              begin
                Physics := TPhysics.Create;

                if not FileExists(Util.DIR + 'dynamic\' + Tex.Dir + '\' + Tex.Models[y].Model + '.fiz') then
                  Tex.Models[y].Model := Tex.Models[y].Model + 'dumb';

                Physics.Name := Tex.Models[y].Model;
                Physics.Dir  := Tex.Dir;
                Data.Physics.Add(Physics);
                Tex.Models[y].Fiz := Data.Physics.Last;
              end;
            end
            else
            begin
              Include(Tex.Errors,teNoPhysics);
              Tex.Models[y].Fiz := nil;
            end;

            if not FileExists(Util.DIR + 'dynamic\' + Tex.Dir + '\' + Tex.Models[y].Model + '.mmd') then
                Include(Tex.Errors,teNoMultimedia);
          end;

          Data.Textures.Add(Tex);
        end;
      end;
    finally
      Plik.Free;
    end;
  except
    on E: Exception do
      Util.Errors.Add('B³¹d parsowania ' + Path + ', szczegó³y b³êdu: ' + E.Message);
  end;
end;

procedure TParser.ParseTextDesc(Tex:TTexture);
var
  Par : TStringList;
begin
  Par := TStringList.Create;
  try
    try
      Par.Delimiter := ',';
      Par.DelimitedText := Tex.Desc;

      Tex.Version   := Par[0];
      Tex.Mark      := Par[1];
      Tex.Owner     := StringReplace(Par[2],'_',' ',[rfReplaceAll]);
      Tex.Station   := StringReplace(Par[3],'_',' ',[rfReplaceAll]);
      Tex.Revision  := StringReplace(Par[4],'_',' ',[rfReplaceAll]);
      Tex.Works     := StringReplace(Par[5],'_',' ',[rfReplaceAll]);
      Tex.Author    := StringReplace(Par[6],'_',' ',[rfReplaceAll]);
      Tex.Photos    := StringReplace(Par[7],'_',' ',[rfReplaceAll]);
    except
      Util.Errors.Add('B³¹d przetwarzania opisu tekstury: ' + Tex.Desc);
    end;
  finally
    Par.Free;
  end;
end;

function TParser.IsPhysics(const Dir:string;const Name:string):TPhysics;
var
  i : Integer;
begin
  Result := nil;

  for i := Data.Physics.Count-1 downto 0 do
    if (CompareText(Data.Physics[i].Name,Name) = 0) and (CompareText(Data.Physics[i].Dir,Dir) = 0) then
    begin
      Result := Data.Physics[i];
      Break;
    end;
end;

procedure TParser.ParsePhysics(Physics:TPhysics;Path:string='';const aParams:TStringList=nil);
var
  PhysicsFile : TStringList;
  Section : TPhysicsSections;
  Params : TList<TPhysicsInc>;
  Par : TPhysicsInc;
  i : Integer;
begin
  try
    Params := TList<TPhysicsInc>.Create;

    if aParams = nil then
      Physics.AllowedFlagB := -1;

    PhysicsFile := TStringList.Create;
    if Path.Length = 0 then
    begin
      if FileExists(Util.DIR + 'dynamic\' + Physics.Dir + '\' + Physics.Name + '.fiz') then
        PhysicsFile.LoadFromFile(Util.DIR + 'dynamic\' + Physics.Dir + '\' + Physics.Name + '.fiz')
      else
        if FileExists(Util.DIR + 'dynamic\' + Physics.Dir + '\' + Physics.Name + 'dumb.fiz') then
          PhysicsFile.LoadFromFile(Util.DIR + 'dynamic\' + Physics.Dir + '\' + Physics.Name + 'dumb.fiz');
    end
    else
      if FileExists(Util.DIR + 'dynamic\' + Physics.Dir + '\' + Path) then
        PhysicsFile.LoadFromFile(Util.DIR + 'dynamic\' + Physics.Dir + '\' + Path);

    Lexer.Origin := PChar(PhysicsFile.Text);
    Lexer.Init;

    While Lexer.TokenID <> ptNull do
    begin
      if (Lexer.TokenID = ptIdentifier) then
      begin
        if Lexer.Token = 'include' then
        begin
          Lexer.NextNoJunk;

          Par := TPhysicsInc.Create;
          Par.Path := GetToken;

          Lexer.NextNoJunk;
          while Lexer.Token <> 'end' do
          begin
            Par.Params.Add(GetToken);
            Lexer.NextNoJunk;
          end;
          Params.Add(Par);
        end;

        if Lexer.Token = 'Param'      then Section := psParam       else
        if Lexer.Token = 'Load'       then Section := psLoad        else
        if Lexer.Token = 'Dimensions' then Section := psDimension   else
        if Lexer.Token = 'BuffCoupl'  then  Section := psBuffCoupl  else
        if Lexer.Token = 'BuffCoupl1' then  Section := psBuffCouplA else
        if Lexer.Token = 'BuffCoupl2' then  Section := psBuffCouplB;

        case Section of
          psParam:
          begin
            if Lexer.Token = 'M' then
            begin
              Lexer.NextNoJunk;
              Lexer.NextNoJunk;
              Physics.Mass := StrToFloat(GetToken(aParams));
            end
            else
            if Lexer.Token = 'Vmax' then
            begin
              Lexer.NextNoJunk;
              Lexer.NextNoJunk;
              Physics.VMax := StrToFloat(GetToken(aParams));
            end;
          end;
          psLoad:
          if Lexer.Token = 'LoadAccepted' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;
            Physics.LoadAccepted := GetToken(aParams);
          end
          else
          if Lexer.Token = 'MaxLoad' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;
            Physics.MaxLoad := Trunc(StrToFloat(GetToken(aParams)));
          end;
          psDimension:
          if Lexer.Token = 'L' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;
            Physics.Length := StrToFloat(GetToken(aParams));
          end;
          psBuffCoupl..psBuffCouplA:
          if Lexer.Token = 'AllowedFlag' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;
            Physics.AllowedFlagA := StrToInt(GetToken(aParams));

            if Physics.AllowedFlagA < 0 then
              Physics.AllowedFlagA := Abs(Physics.AllowedFlagA) + 128
          end
          else
          if Lexer.Token = 'ControlType' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;
            Physics.ControlTypeA := GetToken(aParams);
          end;
          psBuffCouplB:
          if Lexer.Token = 'AllowedFlag' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;
            Physics.AllowedFlagB := StrToInt(GetToken(aParams));

            if Physics.AllowedFlagB < 0 then
              Physics.AllowedFlagB := Abs(Physics.AllowedFlagB) + 128;
          end
          else
          if Lexer.Token = 'ControlType' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;
            Physics.ControlTypeB := GetToken(aParams);
          end;
        end;
      end
      else
      begin
        if Lexer.Token = '#' then
        begin
          while (Lexer.TokenID <> ptCRLF) and (Lexer.TokenID <> ptNull) do
            Lexer.Next;
          Section := psOther;
        end;

        if Lexer.TokenID = ptCRLF then
          Section := psOther;
      end;

      Lexer.NextNoJunk;
    end;

    for i := 0 to Params.Count-1 do
      ParsePhysics(Physics,Params[i].Path,Params[i].Params);

    if (aParams = nil) and (Physics.AllowedFlagB = -1) then
    begin
      Physics.AllowedFlagB := Physics.AllowedFlagA;
      Physics.ControlTypeB := Physics.ControlTypeA;
    end;

    if aParams <> nil then
      aParams.Free;

    Params.Free;
  except
    Util.Errors.Add('B³¹d parsowania ' + Physics.Dir + '\' + Physics.Name + '.fiz, linia: ' + IntToStr(Lexer.LineNumber));
  end;
end;

procedure TParser.LoadPhysics;
var
  i : Integer;
begin
  for i := 0 to Data.Physics.Count-1 do
    ParsePhysics(Data.Physics[i]);
end;

end.
