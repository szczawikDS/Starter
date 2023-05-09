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

unit uStructures;

interface

uses System.Generics.Collections, System.Generics.Defaults, CastaliaPasLexTypes,
      Classes;

type
  TFlag = (F128 = 128,F64 = 64,F32 = 32,F16 = 16,F8 = 8,F4 = 4,F2 = 2,F1 = 1);
  TFlags = set of TFlag;

  TTrainParams = record
    Length        : Double;
    Mass          : Double;
    LoadMass      : Double;
    CountVehicles : Integer;
  end;

  TTyp = (tyELEKTROWOZ,tySPALINOWOZ,tyPAROWOZ,tySZYNOBUS,tyEZT,
          tyA, tyB, tyD, tyE, tyF, tyG, tyH, tyI, tyL, tyP, tyR, tyS, tyU, tyV, tyW, tyX, tyZ,
          tyROBOCZY,tyDREZYNA, tyTRAMWAJ,tySAMOCHOD,tyAUTOBUS,tyCIEZAROWKA,tyOSOBA,tyZWIERZE,
          tyPROTOTYP, tyINNE, tyUNKNOWN);

  TVehicleType = record
      Sign  : Char;
      Typ   : TTyp;
    end;

  TCabOccupancy = (coHeadDriver,coRearDriver,coPassenger,coNobody);

  TTexError = (teNoFile,teNoModel,teNoPhysics,teNoMultimedia);
  TTexErrors = set of TTexError;

  TPhysicsSections = (psOther,psParam,psLoad,psDimension,psWheels,psBrake,psBuffCoupl,psBuffCouplA,psBuffCouplB,psCntrl);

  TSelectedList = (slSCN,slDEPO);

  TModifierKey = (mkShift, mkCtrl);
  TModifierKeys = set of TModifierKey;

  TPhysicsInc = class
    Path    : string;
    Params  : TStringList;
    constructor Create;
    //destructor Destroy;
  end;

  TPhysics = class
    Name          : string;
    Dir           : string;
    Mass          : Double;
    VMax          : Double;
    Length        : Double;
    LoadAccepted  : string;
    MaxLoad       : Integer;
    AllowedFlagA  : Integer;
    AllowedFlagB  : Integer;
    ControlTypeA  : string;
    ControlTypeB  : string;
  end;

  TModel = class
    Model : string;
    Mini  : string;
    MiniD : string;
    Fiz   : TPhysics;
  end;

  TTexture = class
    ID    : Integer;
    Plik  : string;
    Models  : TObjectList<TModel>;
    Desc  : string;
    Dir   : string;
    Typ    : TTyp;
    Errors : TTexErrors;
    Version   : string;
    Mark      : string;
    Owner     : string;
    Station   : string;
    Revision  : string;
    Works     : string;
    Author    : string;
    Photos    : string;
    NextTexID : Integer;
    PrevTexID : Integer;
    Crew      : Integer;
    Archive   : Boolean;
  private
    function GetFirstIndex: Integer;
  public
    constructor Create;
    property FirstIndex : Integer read GetFirstIndex;
  end;

  TVehicleParams = record
    Brake           : string;
    BrakeState      : string;
    BrakeAdjust     : string;
    Sway            : Integer; // wezykowanie
    Flatness        : Integer; // podkucie x mm
    FlatnessRand    : Integer; // podkucie losowe 0-x mm
    FlatnessProb    : Integer; // prawdopodobienstwo poducia
    Wheel           : Char;
    Loadquantity    : Integer;
    LoadType        : string;
    ThermoDynamic   : Boolean;
  end;

  TVehicle = class(TPersistent)
  public
    MinDist         : Double;
    MaxDist         : Double;
    Name            : string;
    Dir             : string;
    ReplacableSkin  : string;
    TypeChk         : string;
    PathName        : string;
    Dist            : Double;
    CabOccupancy    : TCabOccupancy;
    Vel             : Double;
    Settings        : string;
    Coupler         : Integer;
    Brake           : string;
    BrakeState      : string;
    BrakeAdjust     : string;
    Sway            : Integer; // wezykowanie
    Flatness        : Integer; // podkucie x mm
    FlatnessRand    : Integer; // podkucie losowe 0-x mm
    FlatnessProb    : Integer; // prawdopodobienstwo poducia
    Wheel           : Char;
    Loadquantity    : Integer;
    LoadType        : string;
    ThermoDynamic   : Boolean;
    Texture         : TTexture;
    ModelID         : Integer;
    Number          : Integer;
    MaxLoad         : Integer;
  private
    function GetPhysics: TPhysics;
    function GetModel: TModel;
  public
    property Fiz    : TPhysics read GetPhysics;
    property Model  : TModel read GetModel;
  {public
    property MinDist  : Double read FMinDist write FMinDist;
    property MaxDist  : Double read FMaxDist write FMaxDist;
    property Name  : string read FName write FName;
    property Dir  : string read FDir write FDir;
    property ReplacableSkin  : string read FReplacableSkin write FReplacableSkin;
    property TypeChk  : string read FFypeChk write FFypeChk;
    property PathName  : string read FPathName write FPathName;
    property Dist  : Double read FDist write FDist;
    property CabOccupancy  : TCabOccupancy read FCabOccupancy write FCabOccupancy;
    property Vel  : Double read FVel write FVel;
    property Settings  : string read FSettings write FSettings;
    property Coupler  : Integer read FCoupler write FCoupler;
    property Brake  : string read FBrake write FBrake;
    property BrakeState  : string read FBrakeState write FBrakeState;
    property BrakeAdjust  : string read FBrakeAdjust write FBrakeAdjust;
    property Sway  : Integer read FSway write FSway;
    property Flatness  : Integer read FFlatness write FFlatness;
    property FlatnessRand  : Integer read FFlatnessRand write FFlatnessRand;
    property FlatnessProb  : Integer read FFlatnessProb write FFlatnessProb;
    property Wheel  : Char read FWheel write FWheel;
    property Loadquantity  : Double read FLoadquantity write FLoadquantity;
    property LoadType  : string read FLoadType write FLoadType;
    property Tekstura  : TTekstura read FTekstura write FTekstura;}
  Protected
     procedure AssignTo(Dest: TPersistent); override;
  end;

  TTrain = class(TPersistent)
  public
    TrainName : string;
    Track     : string;
    Dist      : Double;
    Vel       : Double;
    Vehicles  : TObjectList<TVehicle>;
    Desc      : string; // $o
    AI        : Boolean;
    TimeTable : string;
    Logo      : string;
    Mini      : string;
    Irrelevant: Boolean;
  {public
    property TrainName  : string read FTrainName write FTrainName;
    property Track      : string read FTrack write FTrack;
    property Dist       : Double read FDist write FDist;
    property Vel        : Double read FVel write FVel;
    property Vehicles   : TObjectList<TVehicle> read FVehicles write FVehicles;
    property Desc       : string read FDesc write FDesc;
    property AI         : Boolean read FAI write FAI;
    property TimeTable  : string read FTimeTable write FTimeTable;}
    constructor Create;
  end;

  TConfig = record
    Day         : Integer;
    Temperature : Double;
    FogStart    : Integer;
    FogEnd      : Integer;
    Overcast    : Double;
    StartTime   : TTime;
    Time        : TTime;
    Other       : string;
  end;

  TScenario = class
  private
    FID          : string;       // $id - dla grupowania scenariuszy
    FPath        : string;
    FName        : string;
    FTitle       : string;       // $n
    FDesc        : TStringList;  // $d
    FImage       : string;       // $i
    FFiles       : TStringList;  // $f
    FTrains      : TObjectList<TTrain>;
    FVehicles    : TObjectList<TVehicle>;
    FOther       : TStringList;
    FConfig      : TConfig;
    FOld         : Boolean;
    procedure SetDesc(const Value: TStringList);
    procedure SetFiles(const Value: TStringList);
    procedure SetTrains(const Value: TObjectList<TTrain>);
    procedure SetVehicles(const Value: TObjectList<TVehicle>);
    procedure SetOther(const Value: TStringList);
  public
    property ID          : string read FID write FID;
    property Path        : string read FPath write FPath;
    property Name        : string read FName write FName;
    property Title       : string read FTitle write FTitle;         // $n
    property Desc        : TStringList read FDesc write SetDesc;    // $d
    property Image       : string read FImage write FImage;         // $i
    property Files       : TStringList read FFiles write SetFiles;  // $f
    property Trains      : TObjectList<TTrain> read FTrains write SetTrains;
    property Vehicles    : TObjectList<TVehicle> read FVehicles write SetVehicles;
    property Other       : TStringList read FOther write SetOther;
    property Config      : TConfig read FConfig write FConfig;
    property Old         : Boolean read FOld write FOld;
    constructor Create;
  end;

  TKey = class
    Name : string;
    Desc : string;
    ModifierKeys : TModifierKeys;
  end;

  TLoad = class
    Name    : string;
    Weight  : Integer;
  end;

  TSList = class(TStringList)
    public
      constructor Create;// override;
  end;

const
  Waggons: array[0..16] of TVehicleType =
  (
    (Sign: 'B'; Typ: tyB),
    (Sign: 'E'; Typ: tyE),
    (Sign: 'A'; Typ: tyA),
    (Sign: 'S'; Typ: tyS),
    (Sign: 'F'; Typ: tyF),
    (Sign: 'G'; Typ: tyG),
    (Sign: 'R'; Typ: tyR),
    (Sign: 'U'; Typ: tyU),
    (Sign: 'W'; Typ: tyW),
    (Sign: 'X'; Typ: tyX),
    (Sign: 'Z'; Typ: tyZ),
    (Sign: 'D'; Typ: tyD),
    (Sign: 'H'; Typ: tyH),
    (Sign: 'I'; Typ: tyI),
    (Sign: 'L'; Typ: tyL),
    (Sign: 'P'; Typ: tyP),
    (Sign: 'V'; Typ: tyV)
  );

  Engines: array[0..31] of TVehicleType =
  (
    (Sign: '*'; Typ: tyUNKNOWN),
    (Sign: 'z'; Typ: tyEZT),
    (Sign: 'e'; Typ: tyELEKTROWOZ),
    (Sign: 's'; Typ: tySPALINOWOZ),
    (Sign: 'a'; Typ: tySZYNOBUS),
    (Sign: 'B'; Typ: tyB),
    (Sign: 'E'; Typ: tyE),
    (Sign: 'A'; Typ: tyA),
    (Sign: 'S'; Typ: tyS),
    (Sign: 'F'; Typ: tyF),
    (Sign: 'G'; Typ: tyG),
    (Sign: 'R'; Typ: tyR),
    (Sign: 'U'; Typ: tyU),
    (Sign: 'r'; Typ: tyROBOCZY),
    (Sign: 'W'; Typ: tyW),
    (Sign: 'X'; Typ: tyX),
    (Sign: 'd'; Typ: tyDREZYNA),
    (Sign: 'o'; Typ: tySAMOCHOD),
    (Sign: 'b'; Typ: tyAUTOBUS),
    (Sign: 'c'; Typ: tyCIEZAROWKA),
    (Sign: 'Z'; Typ: tyZ),
    (Sign: 'D'; Typ: tyD),
    (Sign: 'H'; Typ: tyH),
    (Sign: 'I'; Typ: tyI),
    (Sign: 'L'; Typ: tyL),
    (Sign: 'P'; Typ: tyP),
    (Sign: 'V'; Typ: tyV),
    (Sign: 't'; Typ: tyTRAMWAJ),
    (Sign: 'h'; Typ: tyOSOBA),
    (Sign: 'f'; Typ: tyZWIERZE),
    (Sign: 'p'; Typ: tyPAROWOZ),
    (Sign: 'x'; Typ: tyPROTOTYP)
  );

implementation

uses uData, uUtilities, SysUtils;

constructor TScenario.Create;
begin
  Desc := TStringList.Create;
  Files := TStringList.Create;
  Other := TStringList.Create;

  Trains := TObjectList<TTrain>.Create();
  Vehicles := TObjectList<TVehicle>.Create();
end;

constructor TTrain.Create;
begin
  Vehicles := TObjectList<TVehicle>.Create();
end;

procedure TScenario.SetFiles(const Value: TStringList);
begin
  FFiles := Value;
end;

procedure TScenario.SetOther(const Value: TStringList);
begin
  FOther := Value;
end;

procedure TScenario.SetDesc(const Value: TStringList);
begin
  FDesc := Value;
end;

procedure TScenario.SetTrains(const Value: TObjectList<TTrain>);
begin
  FTrains := Value;
end;

procedure TScenario.SetVehicles(const Value: TObjectList<TVehicle>);
begin
  FVehicles := Value;
end;

constructor TTexture.Create;
begin
  Models := TObjectList<TModel>.Create();
end;

procedure TVehicle.AssignTo(Dest: TPersistent);
var MyDestObj : TVehicle;
begin
  MyDestObj := Dest as TVehicle;

  MyDestObj.MinDist        := Self.MinDist;
  MyDestObj.MaxDist        := Self.MaxDist;
  MyDestObj.Name           := Self.Name;
  MyDestObj.Dir            := Self.Dir;
  MyDestObj.ReplacableSkin := Self.ReplacableSkin;
  MyDestObj.TypeChk        := Self.TypeChk;
  MyDestObj.PathName       := Self.PathName;
  MyDestObj.Dist           := Self.Dist;
  MyDestObj.CabOccupancy   := Self.CabOccupancy;
  MyDestObj.Vel            := Self.Vel;
  MyDestObj.Settings       := Self.Settings;
  MyDestObj.Coupler        := Self.Coupler;
  MyDestObj.Brake          := Self.Brake;
  MyDestObj.BrakeState     := Self.BrakeState;
  MyDestObj.BrakeAdjust    := Self.BrakeAdjust;
  MyDestObj.Sway           := Self.Sway;
  MyDestObj.Flatness       := Self.Flatness;
  MyDestObj.FlatnessRand   := Self.FlatnessRand;
  MyDestObj.FlatnessProb   := Self.FlatnessProb;
  MyDestObj.Wheel          := Self.Wheel;
  MyDestObj.Loadquantity   := Self.Loadquantity;
  MyDestObj.LoadType       := Self.LoadType;
  MyDestObj.Texture        := Self.Texture;
  MyDestObj.ThermoDynamic  := Self.ThermoDynamic;
  MyDestObj.Number         := Self.Number;
  MyDestObj.MaxLoad        := Self.MaxLoad;
  ModelID                  := Self.ModelID;
end;

{ TPhysicsInc }

constructor TPhysicsInc.Create;
begin
  Params := TStringList.Create;
end;

{destructor TPhysicsInc.Destroy;
begin
  Params.Free;
  inherited;
end;}

function TVehicle.GetModel: TModel;
begin
  if Self.Texture <> nil then
    Result := Self.Texture.Models[ModelID]
  else
    Result := nil;
end;

function TVehicle.GetPhysics: TPhysics;
begin
  if Self.Texture <> nil then
    Result := Self.Texture.Models[Self.ModelID].Fiz
  else
    Result := nil;
end;

function TTexture.GetFirstIndex: Integer;
var
  i : Integer;
begin
  i := 0;
  while (Self.ID-i > 0)
    and (Data.Textures[Self.ID-i-1].NextTexID = Data.Textures[Self.ID-i].ID) do
    Inc(i);
  Result := Self.ID - i;
end;

{ TSList }

constructor TSList.Create;
begin
  inherited;
  if IsParameter('utf8') then
    Self.DefaultEncoding := TEncoding.UTF8;
end;

end.
