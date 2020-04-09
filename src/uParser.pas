unit uParser;

interface

uses CastaliaPasLex, CastaliaPasLexTypes, uStructures, Classes;

type

  TParser = class
    Lexer:TmwPasLex;
    Errors : TStringList;
  public
    procedure LoadData;
    procedure SaveDepot;
    procedure ReadDepot;
    function ChangeConfig(const Text:string;const Config:TConfig):string;
    constructor Create;
    destructor Destroy; override;
  private
    function TokenFull: string;
    function ParseConfig(const ConfigText:string):TConfig;
    function ParsePociag: TTrain;
    function ParsePojazd(const TrainSet: Boolean=True): TVehicle;
    function ParseScenariusz(const Sciezka: string): TScenario;
    procedure ParseTextures(const Sciezka: string);
    procedure ParseTrainset(var Scenariusz: TScenario;
      const TrainFile: TStringList);
    procedure LoadModels;
    procedure LoadSceneries;
    procedure ParseCoupler(var Vehicle: TVehicle);
    function GetBrakeValue(const Settings:string;Pos:Integer):string;
    procedure ParsePhysics(Physics:TPhysics);
    function IsPhysics(const Name: string): Integer;
    procedure LoadPhysics;
    procedure FindTexture(var Vehicle:TVehicle);
    procedure ParseTextDesc(Tex: TTexture);
    procedure ParseTextureModels(var Tekstura: TTexture);
    procedure SkipComment;
  end;

implementation

uses SysUtils, uMain, Character;

constructor TParser.Create;
begin
  Lexer := TmwPasLex.Create;
  Errors := TStringList.Create;
end;

destructor TParser.Destroy;
begin
  try
    Lexer.Free;
    if Errors.Count > 0 then
      if ForceDirectories(Main.DIR + '\starter') then
        Errors.SaveToFile(Main.DIR + '\starter\bledy.txt');
  Finally
    Errors.Free;
  end;
end;

function TParser.TokenFull:string;
begin
  while (Lexer.TokenID <> ptSpace) and (Lexer.TokenID <> ptCRLF) and (Lexer.TokenID <> ptNull) do
  begin
    Result := Result + Lexer.Token;
    Lexer.Next;
  end;
end;

procedure TParser.LoadData;
begin
  LoadModels;
  LoadPhysics;
  LoadSceneries;
  ReadDepot;
end;

procedure TParser.LoadModels;
var
  SR, SR2 : TSearchRec;
  Ilosc, Ilosc2 : Integer;
begin
  try
    Ilosc := FindFirst(Main.DIR + '\dynamic\*',faDirectory,SR);

    while (Ilosc = 0) do
    begin
      if (SR.Name <> '.') and (SR.Name <> '..') then
      begin
        Ilosc2 := FindFirst(Main.DIR + '\dynamic\'+SR.Name+'\*',faDirectory,SR2);

        while (Ilosc2 = 0) do
        begin
          if (SR2.Name <> '.') and (SR2.Name <> '..') then
          begin
            if FileExists(Main.DIR + '\dynamic\' + SR.Name + '\' + SR2.Name + '\textures.txt') then
              ParseTextures(Main.DIR + '\dynamic\' + SR.Name + '\' + SR2.Name + '\textures.txt');
          end;
          Ilosc2 := FindNext(SR2);
        end;
        FindClose(SR2);
      end;
      Ilosc := FindNext(SR);
    end;
    FindClose(SR);
  except
    Errors.Add('B��d wczytywania taboru.');
  end;
end;

procedure TParser.LoadSceneries;
var
  SR : TSearchRec;
  Ilosc : Integer;
begin
  try
    Ilosc := FindFirst(Main.DIR + '\scenery\*.scn',faAnyFile,SR);

    while (Ilosc = 0) do
    begin
      if Pos('$',SR.Name) <> 1 then
        Main.Scenarios.Add(ParseScenariusz(Main.DIR + '\scenery\' + SR.Name));
      Ilosc := FindNext(SR);
    end;
    FindClose(SR);
  except
    Errors.Add('B��d wczytywania scenerii.');
  end;
end;

function TParser.ParsePociag:TTrain;
begin
  Result := TTrain.Create;
  try
    Lexer.NextNoJunk;
    Result.TrainName := TokenFull;

    Lexer.NextNoJunk;
    Result.Track := TokenFull;

    Lexer.NextNoJunk;
    Result.Dist := StrToFloat(TokenFull);

    Lexer.NextNoJunk;
    Result.Vel := StrToFloat(TokenFull);

    while (not SameText(Lexer.Token, 'endtrainset')) and (Lexer.TokenID <> ptNull) do
    begin
      if (Lexer.TokenID = ptIdentifier) and (Pos('node',Lexer.Token) > 0) then
        Result.Vehicles.Add(ParsePojazd);

      if Pos('//$o',Lexer.Token) > 0 then
        if Pos('-',Lexer.Token) = 6 then
        begin
          Result.AI := True;
          Result.Desc := Copy(Lexer.Token,7,Lexer.TokenLen);
        end
        else
          Result.Desc := Copy(Lexer.Token,6,Lexer.TokenLen);

      Lexer.NextNoSpace;
    end;
  except
    Errors.Add('B��d parsowania sk�adu. Linia ' + IntToStr(Lexer.LineNumber));
  end;
end;

procedure TParser.FindTexture(var Vehicle:TVehicle);
var
  i, y : Integer;
  //Found : Boolean;
begin
  Vehicle.Texture := nil;
  //Found := False;

  for i := 0 to Main.Textures.Count-1 do
    if (SameText(Vehicle.ReplacableSkin,Main.Textures[i].Plik)) and (SameText(Vehicle.Dir,Main.Textures[i].Dir)) then
    begin
      for y := 0 to Main.Textures[i].Models.Count-1 do
      begin
        Vehicle.Texture := Main.Textures[i];
        if SameText(Vehicle.TypeChk,Main.Textures[i].Models[y].Model) then
        begin
          Vehicle.Texture := Main.Textures[i];
          Vehicle.ModelID := y;
          //Found := True;
          Break;
        end;
      end;

      if Vehicle.Texture <> nil then
        Break;
    end;

  {if not Found then
  begin
    Errors.Add('');
    Errors.Add('B��d sparowania tekstura/model:');
    Errors.Add(Main.PrepareNode(Vehicle,True));
  end;}
end;

function TParser.ParsePojazd(const TrainSet:Boolean=True):TVehicle;
begin
  try
    Result := TVehicle.Create;

    Lexer.NextNoJunk;
    Result.MinDist := StrToFloat( TokenFull );

    Lexer.NextNoJunk;
    Result.MaxDist := StrToFloat( TokenFull );

    Lexer.NextNoJunk;
    Result.Name := TokenFull;

    Lexer.NextID(ptIdentifier);
    Lexer.NextID(ptIdentifier);
    Result.Dir := TokenFull;

    Lexer.NextNoJunk;
    Result.ReplacableSkin := ChangeFileExt(TokenFull,'');

    Result.Dir := StringReplace(Result.Dir,'/','\',[]);

    Lexer.NextNoJunk;
    Result.TypeChk := TokenFull;

    Lexer.NextNoJunk;
    if not TrainSet then
    begin
      Result.PathName := TokenFull;
      Lexer.NextNoJunk;
    end;

    Result.Dist := StrToFloat( TokenFull );

    Lexer.NextNoJunk;
    if SameText(Lexer.Token,'headdriver') then Result.CabOccupancy := coHeadDriver else
    if SameText(Lexer.Token,'reardriver') then Result.CabOccupancy := coRearDriver else
    if SameText(Lexer.Token,'nobody')     then Result.CabOccupancy := coNobody     else
    if SameText(Lexer.Token,'passenger')  then Result.CabOccupancy := coPassenger;

    Lexer.NextNoJunk;
    if TrainSet then
    begin
      while (Lexer.TokenID <> ptSpace) and (Lexer.TokenID <> ptCRLF) and (Lexer.TokenID <> ptNull) do
      begin
        Result.Settings := Result.Settings + Lexer.Token;
        Lexer.Next;
      end;

      ParseCoupler(Result);
    end
    else
      Result.Vel := StrToFloat(TokenFull);

    Lexer.NextNoJunk;
    Result.Loadquantity := StrToFloat(TokenFull);

    if Result.Loadquantity > 0 then
    begin
      Lexer.NextID(ptIdentifier);
      Result.LoadType := Lexer.Token;
    end;

    FindTexture(Result);
  except
    Errors.Add('B��d parsowania wpisu. Linia ' + IntToStr(Lexer.LineNumber));
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
    if Pos('.',Vehicle.Settings) = 0 then
      Vehicle.Coupler := StrToInt(Vehicle.Settings)
    else
    begin
      Vehicle.Coupler := StrToInt(Copy(Vehicle.Settings,0,Pos('.',Vehicle.Settings)-1));

      i := Pos('.',Vehicle.Settings) + 1;

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
              Vehicle.Sway := StrToInt(GetBrakeValue(Vehicle.Settings,i+2));

            if Vehicle.Settings[i+1] = 'F' then
              Vehicle.Flatness := StrToInt(GetBrakeValue(Vehicle.Settings,i+2));

            if Vehicle.Settings[i+1] = 'R' then
              Vehicle.FlatnessRand := StrToInt(GetBrakeValue(Vehicle.Settings,i+2));

            if Vehicle.Settings[i+1] = 'P' then
              Vehicle.FlatnessProb := StrToInt(GetBrakeValue(Vehicle.Settings,i+2));
          end;

        Inc(i);
      end;
    end;
  except
    Errors.Add('B��d parsowania sprz�gu ' + Vehicle.Name + '. Linia ' + IntToStr(Lexer.LineNumber));
  end;
end;

function TParser.ParseConfig(const ConfigText:string):TConfig;
begin
  Result.Day := 0;
  Result.Temperature := 15;

  Lexer.Origin := PChar(ConfigText);
  Lexer.Init;

  Lexer.NextNoSpace;
  While Lexer.TokenID <> ptNull do
  begin
    if Lexer.TokenID = ptSlash then
      SkipComment
    else
    begin
      if (Lexer.TokenID = ptIdentifier) then
      begin
        if (SameText(Lexer.Token, 'movelight')) then
        begin
          Lexer.NextNoJunk;
          Result.Day := StrToInt(Lexer.Token);
        end
        else
        begin
          if SameText(Lexer.Token, 'scenario') then
          begin
            if SameText(TokenFull, 'scenario.weather.temperature') then
            begin
              Lexer.NextNoJunk;
              Result.Temperature := StrToFloat(TokenFull);
            end;
          end;
        end;
      end;
    end;
    Lexer.NextNoSpace;
  end;
end;

function TParser.ChangeConfig(const Text:string;const Config:TConfig):string;
var
  EndPointer : integer;
  Day, Temperature : Boolean;
begin
  try
    Lexer.Origin := PChar(Text);
    Lexer.Init;

    result := '';
    EndPointer := 0;

    Day := False;
    Temperature := False;

    Lexer.NextNoSpace;
    While Lexer.TokenID <> ptNull do
    begin
      if (Lexer.TokenID = ptIdentifier) then
      begin
        if (SameText(Lexer.Token, 'movelight')) then
        begin
          result := result + Copy(Text,EndPointer,Lexer.TokenPos-EndPointer);
          Result := Result + #13#10 + 'movelight ' + IntToStr(Config.Day) + ' ';
          Lexer.NextNoJunk;
          EndPointer := Lexer.TokenPos + Lexer.TokenLen + 1;
          Day := True;
        end
        else
        begin
          if SameText(Lexer.Token, 'scenario') then
          begin
            if SameText(TokenFull, 'scenario.weather.temperature') then
            begin
              result := result + Copy(Text,EndPointer,Lexer.TokenPos-EndPointer-27);
              Result := Result + #13#10 + 'scenario.weather.temperature ' + FloatToStr(Config.Temperature) + ' ';
              Lexer.NextNoJunk;
              TokenFull;
              EndPointer := Lexer.TokenPos + Lexer.TokenLen + 1;
              Temperature := True;
            end;
          end;
        end;
      end;

      Lexer.NextNoSpace;
    end;

    Result := Result + Copy(Text,EndPointer,Text.Length);

    if Pos('config',Result) = 0 then
      Result := 'config endconfig' + #13#10 + Result;

    if not Day then
      Insert(#13#10 + 'movelight ' + IntToStr(Config.Day) + ' ',Result, Pos('config',result)+6);

    if not Temperature then
      Insert(#13#10 + 'scenario.weather.temperature ' + FloatToStr(Config.Temperature) + ' ',Result, Pos('config',result)+6);
  except
   Result := Text;
  end;
end;

procedure TParser.SkipComment;
begin
  Lexer.InitAhead;
  if Lexer.AheadTokenID = ptStar then
  begin
    while not ((Lexer.TokenID = ptStar) and (Lexer.AheadTokenID = ptSlash)) and (Lexer.TokenID <> ptNull) do
    begin
      Lexer.NextNoJunk;
      Lexer.AheadNext;
    end;
  end;
end;

function TParser.ParseScenariusz(const Sciezka:string):TScenario;
var
  Plik, FirstInit, IncFirstInit : TStringList;
  FirstInitPos : integer;
  IncludeStr : string;
  Config : TConfig;
begin
  try
    Result := TScenario.Create;
    Result.Name := ExtractFileName( Copy(Sciezka,0,Pos('.scn',Sciezka)-1));

    Plik := TStringList.Create;
    Plik.LoadFromFile(Sciezka);

    FirstInitPos := Pos('FirstInit',Plik.Text);

    Result.Other.Text := Copy(Plik.Text,0,FirstInitPos-1);
    if (Pos('config',Result.Other.Text) > 0) and (Pos('endconfig',Result.Other.Text) > 0) then
    begin
      Result.Config := ParseConfig(Copy(Plik.Text,Pos('config',Result.Other.Text)+6,
                  Pos('endconfig',Result.Other.Text)-12-Pos('config',Result.Other.Text)+6));
    end
    else
    begin
      Config.Day := 0;
      Config.Temperature := 15;
      Result.Config := Config;
    end;


    FirstInit := TStringList.Create;
    FirstInit.Text := Copy(Plik.Text,FirstInitPos,Plik.Text.Length);

    Lexer.Origin := PChar(Plik.Text);
    Lexer.Init;

    Lexer.NextNoSpace;
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
        if Pos('$i', Lexer.Token) > 0 then Result.Image := Copy(Lexer.Token,6,Lexer.TokenLen);
      end
      else
        if Lexer.TokenID = ptSlash then
          SkipComment
        else
        begin
          if (Lexer.TokenID = ptIdentifier) and (SameText(Lexer.Token, 'description')) then
          begin
            while not SameText(Lexer.Token, 'enddescription') and (Lexer.TokenID <> ptNull) do
              Lexer.Next;
          end;

          if (Lexer.TokenID = ptIdentifier) and (SameText(Lexer.Token, 'include')) and (Lexer.TokenPos > FirstInitPos) then
          begin
            Lexer.NextNoJunk;

            IncludeStr := EmptyStr;
            while (not Lexer.IsJunk) and (Lexer.TokenID <> ptNull) do
            begin
              IncludeStr := IncludeStr + Lexer.Token;
              Lexer.Next;
            end;

            if FileExists(Main.DIR + '\scenery\' + IncludeStr) then
            begin
              IncFirstInit := TStringList.Create;
              IncFirstInit.LoadFromFile(Main.DIR + '\scenery\' + IncludeStr);
              FirstInit.Add(IncFirstInit.Text);
              IncFirstInit.Free;
            end;
          end;
        end;

      Lexer.NextNoSpace;
    end;

    ParseTrainset(Result,FirstInit);
    Plik.Free;
  except
    Errors.Add('B��d parsowania ' + Sciezka + ' Linia: ' + IntToStr(Lexer.LineNumber));
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
    begin
      Lexer.InitAhead;
      if Lexer.AheadTokenID = ptStar then
        while not ((Lexer.TokenID = ptStar) and (Lexer.AheadTokenID = ptSlash)) do
        begin
          Lexer.NextNoJunk;
          Lexer.AheadNext;
        end;
    end;

    if (Lexer.TokenID = ptIdentifier) and (Pos('trainset',Lexer.Token) > 0)
        and (Pos('endtrainset',Lexer.Token) = 0) then
    begin
      Pociag := ParsePociag;
      if Pociag.Vehicles.Count > 0 then
        Scenariusz.Trains.Add(Pociag);
    end
    else
      if (Lexer.TokenID = ptIdentifier) and (Lexer.Token = 'node') then
      begin
        Lexer.InitAhead;

        while (Lexer.AheadTokenID <> ptIdentifier) and (Lexer.AheadTokenID <> ptNull) do
          Lexer.AheadNext;

        if not SameText(Lexer.AheadToken,'dynamic') then
          Lexer.AheadNext;

        if SameText(Lexer.AheadToken,'dynamic') then
          Scenariusz.Vehicles.Add(ParsePojazd(False));
      end;

    Lexer.NextNoJunk;
  end;
  except
    Errors.Add('B��d parsowania sk�adu. Linia ' + IntToStr(Lexer.LineNumber));
  end;
end;

procedure TParser.ParseTextureModels(var Tekstura:TTexture);
var
  Token : string;
  Model : TModel;
begin
  while Lexer.TokenID = ptEqual do
  begin
    Lexer.NextNoSpace;

    Model := TModel.Create;

    while (Lexer.TokenID <> ptComma) and (Lexer.TokenID <> ptNull) do
    begin
      Token := Token + Lexer.Token;
      Lexer.Next;
    end;
    Model.Model := Token;
    Token := EmptyStr;
    Lexer.NextNoSpace;

    while (Lexer.TokenID <> ptComma) and (Lexer.TokenID <> ptNull)
      and (Lexer.TokenID <> ptSlashesComment) and (Lexer.TokenID <> ptEqual) do
    begin
      Token := Token + Lexer.Token;
      Lexer.Next;
    end;
    Model.Mini := Token;
    Token := EmptyStr;

    if Lexer.TokenID = ptComma then
    begin
      Lexer.NextNoSpace;
      while (Lexer.TokenID <> ptComma) and (Lexer.TokenID <> ptNull)
            and (Lexer.TokenID <> ptSlashesComment) and (Lexer.TokenID <> ptEqual) do
      begin
        Token := Token + Lexer.Token;
        Lexer.Next;
      end;
      Model.MiniD := Token;
      Token := EmptyStr;
    end;

    Tekstura.Models.Add(Model);
  end;
end;

procedure TParser.ParseTextures(const Sciezka:string);
var
  Plik : TStringList;
  i, y : Integer;
  Tekstura : TTexture;
  Physics : TPhysics;
  Token : string;
  Grupa : TTyp;
begin
  try
    Plik := TStringList.Create;
    Plik.LoadFromFile(Sciezka);

    try
      for i := 0 to Plik.Count-1 do
      begin
        if Pos('#',Plik[i]) = 1 then Continue;
        if Pos('@',Plik[i]) = 1 then Continue;
        if Pos('*',Plik[i]) = 1 then Continue;

        if Pos('!=',Plik[i]) = 1 then
        begin
          Token := Copy(Plik[i],3,1);

          if Token = UpperCase(Copy(Plik[i],3,1)) then
            Grupa := tyWagon
          else
          if SameText(Token,'e') then Grupa := tyELEKTROWOZ else
          if SameText(Token,'s') then Grupa := tySPALINOWOZ else
          if SameText(Token,'p') then Grupa := tyPAROWOZ    else
          if SameText(Token,'z') then Grupa := tyEZT        else
          if SameText(Token,'a') then Grupa := tySZYNOBUS   else
          if SameText(Token,'r') then Grupa := tyROBOCZY    else
          if SameText(Token,'d') then Grupa := tyDREZYNA    else
          if SameText(Token,'t') then Grupa := tyTRAMWAJ    else
          if SameText(Token,'o') then Grupa := tySAMOCHOD   else
          if SameText(Token,'b') then Grupa := tyAUTOBUS    else
          if SameText(Token,'c') then Grupa := tyCIEZAROWKA else
          if SameText(Token,'h') then Grupa := tyOSOBA      else
          if SameText(Token,'f') then Grupa := tyZWIERZE    else
          Grupa := tyINNE;
          Continue;
        end;
        Token := '';

        if Pos('=',Plik[i]) > 0 then
        begin
          Tekstura := TTexture.Create;

          if Pos('026', Plik[i]) > 0 then
            Tekstura := Tekstura;

          Tekstura.Typ := Grupa;
          Tekstura.Dir := ExtractFileDir(Copy(Sciezka,Pos('dynamic',Sciezka)+8,Length(Sciezka)));
          Lexer.Origin := PChar(Plik[i]);
          Lexer.Init;

          while (Lexer.TokenID <> ptEqual) and (Lexer.TokenID <> ptNull) do
          begin
            Token := Token + Lexer.Token;
            Lexer.Next;
          end;
          Tekstura.Plik := Token;

          Tekstura.Plik := ChangeFileExt(Tekstura.Plik,'');

          Token := EmptyStr;

          ParseTextureModels(Tekstura);

          if Lexer.TokenID = ptSlashesComment then
          begin
            Tekstura.Opis := Copy(Lexer.Token,3,Lexer.TokenLen);
            ParseTextDesc(Tekstura);
          end;

          if not (FileExists(Main.DIR + '\dynamic\' + Tekstura.Dir + '\' + Tekstura.Plik + '.mat'))
            and not (FileExists(Main.DIR + '\dynamic\' + Tekstura.Dir + '\' + Tekstura.Plik + '.dds'))
            and not (FileExists(Main.DIR + '\dynamic\' + Tekstura.Dir + '\' + Tekstura.Plik + '.tga'))  then
              Include(Tekstura.Errors,teNoFile);

          for y := 0 to Tekstura.Models.Count-1 do
          begin
            if not FileExists(Main.DIR + '\dynamic\' + Tekstura.Dir + '\' + Tekstura.Models[y].Model + '.fiz')
            and not FileExists(Main.DIR + '\dynamic\' + Tekstura.Dir + '\' + Tekstura.Models[y].Model + 'dumb.fiz')  then
            begin
              Include(Tekstura.Errors,teNoPhysics);
              Tekstura.Fiz := -1;
            end
            else
            begin
              Tekstura.Fiz := IsPhysics(Tekstura.Models[y].Model);
              if Tekstura.Fiz < 0 then
              begin
                Physics := TPhysics.Create;

                if Main.Physics.Count > 0 then
                  Physics.ID := Main.Physics.Last.ID + 1
                else
                  Physics.ID := 0;

                if not FileExists(Main.DIR + '\dynamic\' + Tekstura.Dir + '\' + Tekstura.Models[y].Model + '.fiz') then
                  Tekstura.Models[y].Model := Tekstura.Models[y].Model + 'dumb';

                if FileExists(Main.DIR + '\dynamic\' + Tekstura.Dir + '\' + Tekstura.Models[y].Model + '.fiz') then
                  Physics.Name := Tekstura.Models[y].Model;

                Physics.Dir  := Tekstura.Dir;
                Main.Physics.Add(Physics);
                Tekstura.Fiz := Physics.ID;
              end;
            end;

            if not FileExists(Main.DIR + '\dynamic\' + Tekstura.Dir + '\' + Tekstura.Models[y].Model + '.mmd') then
                Include(Tekstura.Errors,teNoMultimedia);
          end;

          Main.Textures.Add(Tekstura);
        end;
      end;
    finally
      Plik.Free;
    end;
  except
    Errors.Add('B��d parsowania ' + Sciezka + ' Linia: ' + IntToStr(Lexer.LineNumber));
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
      Par.DelimitedText := Tex.Opis;

      Tex.Version   := Par[0];
      Tex.Mark      := Par[1];
      Tex.Owner     := StringReplace(Par[2],'_',' ',[rfReplaceAll]);
      Tex.Station   := StringReplace(Par[3],'_',' ',[rfReplaceAll]);
      Tex.Revision  := StringReplace(Par[4],'_',' ',[rfReplaceAll]);
      Tex.Works     := StringReplace(Par[5],'_',' ',[rfReplaceAll]);
      Tex.Author    := StringReplace(Par[6],'_',' ',[rfReplaceAll]);
      Tex.Photos    := StringReplace(Par[7],'_',' ',[rfReplaceAll]);
    except
      Errors.Add('B��d przetwarzania opisu tekstury: ' + Tex.Opis);
    end;
  finally
    Par.Free;
  end;
end;

function TParser.IsPhysics(const Name:string):Integer;
var
  i : Integer;
begin
  Result := -1;
  i := 0;
  while (i < Main.Physics.Count-1) and (Main.Physics[i].Name <> Name) do
    Inc(i);

  if (Main.Physics.Count > 0) and (Main.Physics[i].Name = Name) then
    Result := Main.Physics[i].ID;
end;

procedure TParser.ParsePhysics(Physics:TPhysics);
var
  PhysicsFile : TStringList;
  Section : TPhysicsSections;
begin
  try
    PhysicsFile := TStringList.Create;
    if FileExists(Main.DIR + '\dynamic\' + Physics.Dir + '\' + Physics.Name + '.fiz') then
      PhysicsFile.LoadFromFile(Main.DIR + '\dynamic\' + Physics.Dir + '\' + Physics.Name + '.fiz')
    else
      if FileExists(Main.DIR + '\dynamic\' + Physics.Dir + '\' + Physics.Name + 'dumb.fiz') then
        PhysicsFile.LoadFromFile(Main.DIR + '\dynamic\' + Physics.Dir + '\' + Physics.Name + 'dumb.fiz');

    Lexer.Origin := PChar(PhysicsFile.Text);
    Lexer.Init;

    While Lexer.TokenID <> ptNull do
    begin
      if (Lexer.TokenID = ptIdentifier) then
      begin
        if Lexer.Token = 'Param'      then Section := psParam;
        if Lexer.Token = 'Load'       then Section := psLoad;
        if Lexer.Token = 'Dimensions' then Section := psDimension;

        case Section of
          psParam:
          begin
            if Lexer.Token = 'M' then
            begin
              Lexer.NextNoJunk;
              Lexer.NextNoJunk;
              Physics.Mass := StrToFloat(Lexer.Token);
            end
            else
            if Lexer.Token = 'Vmax' then
            begin
              Lexer.NextNoJunk;
              Lexer.NextNoJunk;
              Physics.VMax := StrToFloat(Lexer.Token);
            end;
          end;
          psLoad:
          if Lexer.Token = 'LoadAccepted' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;

            while not Lexer.IsJunk do
            begin
              Physics.LoadAccepted := Physics.LoadAccepted + Lexer.Token;
              Lexer.Next;
            end;
          end;
          psDimension:
          if Lexer.Token = 'L' then
          begin
            Lexer.NextNoJunk;
            Lexer.NextNoJunk;
            Physics.Length := StrToFloat(Lexer.Token);
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
  except
    Errors.Add('B��d parsowania ' + Physics.Dir + '\' + Physics.Name + '.fiz Linia: ' + IntToStr(Lexer.LineNumber));
  end;
end;

procedure TParser.LoadPhysics;
var
  i : Integer;
begin
  for i := 0 to Main.Physics.Count-1 do
    ParsePhysics(Main.Physics[i]);
end;

procedure TParser.ReadDepot;
var
  DepotFile : TStringList;
  Pociag : TTrain;
begin
  try
    DepotFile := TStringList.Create;

    if FileExists(Main.DIR + '\starter.ini') then
      DepotFile.LoadFromFile(Main.DIR + '\starter.ini')
    else
      if FileExists(Main.DIR + '\RAINSTED.INI') then
        DepotFile.LoadFromFile(Main.DIR + '\RAINSTED.INI');

    Lexer.Origin := PChar(DepotFile.Text);
    Lexer.Init;

    While Lexer.TokenID <> ptNull do
    begin
      if (Lexer.TokenID = ptIdentifier) and (Pos('TRAINSET',Lexer.Token) > 0) and (Lexer.Token.Length > 8) then
      begin
        Lexer.Next;
        if Lexer.TokenID = ptSquareClose then
        begin
          Pociag := TTrain.Create;
          Pociag.TrainName := 'test';
          Lexer.NextID(ptIdentifier);

          while Lexer.Token = 'node' do
          begin
            Pociag.Vehicles.Add(ParsePojazd);
            Lexer.NextID(ptIdentifier);
            Lexer.NextID(ptIdentifier);
          end;
          Main.Depot.Add(Pociag);
        end;
      end
      else
        Lexer.NextNoJunk;
    end;
  except
    Errors.Add('B��d parsowania magazynu. Linia: ' + IntToStr(Lexer.LineNumber));
  end;
end;

procedure TParser.SaveDepot;
var
  DepotFile : TStringList;
  i, y : Integer;
begin
  try
    DepotFile := TStringList.Create;

    for i := 0 to Main.Depot.Count-1 do
    begin
      DepotFile.Add('[TRAINSET' + IntToStr(i) + ']');
      for y := 0 to Main.Depot[i].Vehicles.Count-1 do
        DepotFile.Add(Format('%.2d=',[y]) + Main.PrepareNode(Main.Depot[i].Vehicles[y]));
    end;

    DepotFile.SaveToFile(Main.DIR + '\starter.ini');
  except
    Errors.Add('B��d zapisu magazynu.');
  end;
end;

end.