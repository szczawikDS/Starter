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

unit uData;

interface

uses System.Generics.Collections, System.Generics.Defaults, uStructures, uParser,
     uUtilities, Classes;

type

TData = class
  Scenarios   : TObjectList<TScenario>;
  Textures    : TObjectList<TTexture>;
  Physics     : TObjectList<TPhysics>;
  Depot       : TObjectList<TTrain>;
  Loads       : TList<TLoad>;

  constructor Create;
  function LoadsIndex(const LoadName:string):Integer;
  private
    procedure TexturesEmptyElement;
end;

function GetMaxCoupler(const Vehicle:TVehicle;LeftCoupler:Boolean=True):Integer;
function GetControlType(const Vehicle:TVehicle;const LeftCoupler:Boolean=True):string;
function GetMultiple(const Vehicles:TObjectList<TVehicle>;const Index:Integer):TList<Integer>;
function MultipleTrain(const Vehicles:TObjectList<TVehicle>;const Index:Integer):TList<TVehicle>;
function StaffedTrain(const Train:TTrain):Boolean;
function PrepareTrainset(const Vehicles:TObjectList<TVehicle>):TStringList;
function PrepareTrainsetDesc(const Trainset:TTrain):string;
function PrepareNode(const Dyn:TVehicle;const TrainSet:Boolean=True):string;
function RecalcTrainParams(const Train:TTrain;const AllVehicles:Boolean=False):TTrainParams;
function IncludeVehicleToMass(const Vehicle:TVehicle;const AllVehicles:Boolean):Boolean;
procedure AutoConnect(Vehicles:TObjectList<TVehicle>;const LeftVehicle:Integer);
function CheckFlag(Flag:Integer):TFlags;
function CommonCoupler(const C1,C2:Integer):Integer;
function CheckMoveVehicle(const Vehicles:TObjectList<TVehicle>; const FromPos,ToPos:Integer):Boolean;
procedure RandomLoad(var Vehicles:TObjectList<TVehicle>);
procedure ReverseMultiple(Vehicles: TObjectList<TVehicle>;const Position:Integer);

var
  Data : TData;

implementation

uses SysUtils, StrUtils;

function GetMaxCoupler(const Vehicle:TVehicle;LeftCoupler:Boolean=True):Integer;
begin
  try
    if Vehicle.Fiz <> nil then
    begin
      if LeftCoupler then
      begin
        if Vehicle.Dist >= 0 then
          Result := Vehicle.Fiz.AllowedFlagA
        else
          Result := Vehicle.Fiz.AllowedFlagB;
      end
      else
        if Vehicle.Dist >= 0 then
          Result := Vehicle.Fiz.AllowedFlagB
        else
          Result := Vehicle.Fiz.AllowedFlagA;
    end
    else
      Result := 3;
  except
    Util.Log.Add('B³¹d sprawdzania wartoœci AllowedFlag. ' +
                    'Nale¿y sprawdziæ plik .fiz dla ' +
                    Vehicle.Texture.Models[Vehicle.ModelID].Model);
  end;
end;

function GetControlType(const Vehicle:TVehicle;const LeftCoupler:Boolean=True):string;
begin
  try
    if Vehicle.Fiz <> nil then
    begin
      if LeftCoupler then
      begin
        if Vehicle.Dist >= 0 then
          Result := Vehicle.Fiz.ControlTypeA
        else
          Result := Vehicle.Fiz.ControlTypeB;
      end
      else
        if Vehicle.Dist >= 0 then
          Result := Vehicle.Fiz.ControlTypeB
        else
          Result := Vehicle.Fiz.ControlTypeA;
    end
    else
      Result := EmptyStr;
  except
    Util.Log.Add('B³¹d sprawdzania wartoœci ControlType. ' +
                    'Nale¿y sprawdziæ plik .fiz dla ' +
                    Vehicle.Texture.Models[Vehicle.ModelID].Model);
  end;
end;

function TData.LoadsIndex(const LoadName:string):Integer;
var
  i : Integer;
begin
  Result := -1;

  for i := 0 to Loads.Count-1 do
    if SameText(LoadName,Loads[i].Name) then
    begin
      Result := i;
      Break;
    end;
end;

function GetMultiple(const Vehicles:TObjectList<TVehicle>;const Index:Integer):TList<Integer>;
var
  i : Integer;
begin
  Result := TList<Integer>.Create;
  Result.Add(Index);

  if Vehicles[Index].Dist <> -1 then
  begin
    i := 0;
    while (Index-i > 0)
      and (Vehicles[Index-i].Texture.PrevTexID = Vehicles[Index-i-1].Texture.ID) do
      begin
        Result.Add(Index-i-1);
        Inc(i);
      end;

    i := 0;
    while (Vehicles.Count-1 > Index+i)
      and (Vehicles[Index+i].Texture.NextTexID = Vehicles[Index+i+1].Texture.ID) do
      begin
        Result.Add(Index+i+1);
        Inc(i);
      end;
  end
  else
  begin
    i := 0;
    while (Index-i > 0)
      and (Vehicles[Index-i].Texture.NextTexID = Vehicles[Index-i-1].Texture.ID) do
      begin
        Result.Add(Index-i-1);
        Inc(i);
      end;

    i := 0;
    while (Vehicles.Count-1 > Index+i)
      and (Vehicles[Index+i].Texture.PrevTexID = Vehicles[Index+i+1].Texture.ID) do
      begin
        Result.Add(Index+i+1);
        Inc(i);
      end;
  end
end;

function MultipleTrain(const Vehicles:TObjectList<TVehicle>;const Index:Integer):TList<TVehicle>;
var
  Indexes : TList<Integer>;
  i : Integer;
begin
  Indexes := GetMultiple(Vehicles,Index);

  Result := TList<TVehicle>.Create;

  for i := 0 to Indexes.Count-1 do
    Result.Add(Vehicles[Indexes[i]]);
end;

function StaffedTrain(const Train:TTrain):Boolean;
begin
  Result := (Train.Vehicles.Count > 0) and
             ((Train.Vehicles.First.CabOccupancy in [coHeadDriver,coRearDriver])
            or (Train.Vehicles.Last.CabOccupancy in [coHeadDriver,coRearDriver]));
end;

function PrepareTrainset(const Vehicles:TObjectList<TVehicle>):TStringList;
var
  i, y : Integer;
  Indexes : TList<Integer>;
begin
  Result := TStringList.Create;

  i := 0;
  while i < Vehicles.Count do
  begin
    if Vehicles[i].Dist >= 0 then
      Result.Add(PrepareNode(Vehicles[i]))
    else
    begin
      Indexes := GetMultiple(Vehicles,i);

      for y := 0 to Indexes.Count-1 do
        Result.Add(PrepareNode(Vehicles[Indexes[y]]));

      Inc(i,Indexes.Count-1);
    end;
    Inc(i);
  end;
end;

function PrepareTrainsetDesc(const Trainset:TTrain):string;
var
  i, c : Integer;
begin
  if Trainset.Vehicles.Count > 0 then
  begin
    if Trainset.Vehicles.First.Texture.Typ in [tyELEKTROWOZ..tyEZT] then
      Result := Trainset.Vehicles.First.Name
    else
      Result := Trainset.Vehicles.First.TypeChk;

    c := 1;
    for i := 1 to Trainset.Vehicles.Count-1 do
      if SameText(Trainset.Vehicles[i-1].Texture.Models[Trainset.Vehicles[i-1].ModelID].Mini,
                     Trainset.Vehicles[i].Texture.Models[Trainset.Vehicles[i].ModelID].Mini)
        and not (Trainset.Vehicles[i].Texture.Typ in [tyELEKTROWOZ..tyPAROWOZ])  then
      begin
        Inc(c);
        if i = Trainset.Vehicles.Count-1 then
          Result := Result + '(' + IntToStr(c) + ')';
      end
      else
      begin
        if c > 1 then
        begin
          Result := Result + '(' + IntToStr(c) + ')';
          c := 1;
        end;
        if Trainset.Vehicles[i].Texture.ID > 0 then
          Result := Result + ' + ' + Trainset.Vehicles[i].Texture.Models[Trainset.Vehicles[i].ModelID].Mini
        else
          Result := Result + ' + ' + Trainset.Vehicles[i].TypeChk;
      end;
  end
  else
    Result := 'Wpis bez pojazdów. (Tor: ' + Trainset.Track +')';
end;

function PrepareNode(const Dyn:TVehicle;const TrainSet:Boolean=True):string;
begin
  Result := 'node ' + FloatToStr(Dyn.MinDist) + ' ' + FloatToStr(Dyn.MaxDist) + ' ' + Dyn.Name;

  if Dyn.Number > 0 then
    Result := Result + '#' + Dyn.Number.ToString;

  Result := Result + ' dynamic ' + Dyn.Dir + ' ' + Dyn.ReplacableSkin + ' ' + Dyn.TypeChk + ' ';

  if not TrainSet then Result := Result + Dyn.PathName + ' ';

  Result := Result + FloatToStr(Dyn.Dist) + ' ';

  case Dyn.CabOccupancy of
    coHeadDriver: Result := Result + 'headdriver ';
    coRearDriver: Result := Result + 'reardriver ';
    coNobody:     Result := Result + 'nobody ';
    coPassenger:  Result := Result + 'passenger ';
  end;

  if TrainSet then
  begin
    Result := Result + IntToStr(Dyn.Coupler);

    if not Dyn.Brake.IsEmpty then
      Result := Result + '.B' + Dyn.Brake + Dyn.BrakeState + Dyn.BrakeAdjust;

    if (Dyn.Sway > 0) or (Dyn.Flatness > 0) or (Dyn.FlatnessRand > 0) or (Dyn.FlatnessProb > 0) then
    begin
      Result := Result + '.W';

      if Dyn.Sway > 0 then
        Result := Result + 'H' + IntToStr(Dyn.Sway);
      if Dyn.Flatness > 0 then
        Result := Result + 'F' + IntToStr(Dyn.Flatness);
      if Dyn.FlatnessRand > 0 then
        Result := Result + 'R' + IntToStr(Dyn.FlatnessRand);
      if Dyn.FlatnessProb > 0 then
        Result := Result + 'P' + IntToStr(Dyn.FlatnessProb);
    end;

    if Dyn.ThermoDynamic then
      Result := Result + '.TA';

    if Dyn.MaxLoad >= 0 then
      Result := Result + '.L' + Dyn.MaxLoad.ToString;
  end
  else
    Result := Result + FloatToStr(Dyn.Vel);

  if Dyn.LoadType.Length > 0 then
    Result := Result + ' ' + FloatToStr(Dyn.Loadquantity)
  else
    Result := Result + ' 0';

  if (Dyn.LoadType.Length > 0) and (Dyn.Loadquantity > 0) then
    Result := Result + ' ' + Dyn.LoadType;

  Result := Result + ' enddynamic';
end;

{ TData }

procedure TData.TexturesEmptyElement;
var
  Tex : TTexture;
  Model : TModel;
begin
  Tex := TTexture.Create;
  Tex.ID := 0;
  Tex.Typ := tyUNKNOWN;
  Tex.PrevTexID := -1;
  Tex.NextTexID := -1;

  Model := TModel.Create;
  Model.Fiz   := nil;
  Tex.Models.Add(Model);
  Textures.Add(Tex);
end;

constructor TData.Create;
begin
  Textures  := TObjectList<TTexture>.Create;
  TexturesEmptyElement;
  Physics   := TObjectList<TPhysics>.Create;
  Scenarios := TObjectList<TScenario>.Create();
  Depot     := TObjectList<TTrain>.Create;
  Loads     := TList<TLoad>.Create;
end;

function RecalcTrainParams(const Train:TTrain;const AllVehicles:Boolean=False):TTrainParams;
var
  i, LoadIndex : Integer;
begin
  Result.Length   := 0;
  Result.Mass     := 0;
  Result.LoadMass := 0;
  if Train <> nil then
  begin
    for i := Train.Vehicles.Count-1 downto 0 do
    begin
      if IncludeVehicleToMass(Train.Vehicles[i],AllVehicles) then
      begin
        Result.Mass := Result.Mass + Train.Vehicles[i].Fiz.Mass;

        if ContainsText(Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz.LoadAccepted,Train.Vehicles[i].LoadType) then
        begin
          LoadIndex := Data.LoadsIndex(Train.Vehicles[i].LoadType);

          if LoadIndex >= 0 then
            Result.LoadMass := Result.LoadMass + (Train.Vehicles[i].Loadquantity * Data.Loads[LoadIndex].Weight)
          else
            Result.LoadMass := Result.LoadMass + (Train.Vehicles[i].Loadquantity * 1000);
        end
        else
          if not Train.Vehicles[i].LoadType.IsEmpty then
            Util.Log.Add(Train.Vehicles[i].Name + ' - zastosowany nieobs³ugiwany ³adunek przez pojazd');
      end;

      if Train.Vehicles[i].Fiz <> nil then
        Result.Length := Result.Length + Train.Vehicles[i].Fiz.Length;
    end;
    Result.CountVehicles := Train.Vehicles.Count;
  end;
end;

function IncludeVehicleToMass(const Vehicle:TVehicle;const AllVehicles:Boolean):Boolean;
begin
  Result := (Vehicle.Fiz <> nil)
            and
            (((Vehicle.CabOccupancy > coRearDriver)
              or (Vehicle.Texture.Typ = tyEZT)
              or (Vehicle.Texture.Typ = tySZYNOBUS))
              or (AllVehicles))
            //and
            //((Vehicle.LoadType.IsEmpty) or (ContainsText(Vehicle.Texture.Models[Vehicle.ModelID].Fiz.LoadAccepted,Vehicle.LoadType)))
            ;
end;

procedure AutoConnect(Vehicles:TObjectList<TVehicle>;const LeftVehicle:Integer);
var
  LeftMax, RightMax : Integer;
  ControlType1, ControlType2 : string;
begin
  if (LeftVehicle >= 0) and (Vehicles.Count-1 > LeftVehicle) then
  begin
    LeftMax       := GetMaxCoupler(Vehicles[LeftVehicle],False);
    ControlType1  := GetControlType(Vehicles[LeftVehicle],False);

    if Vehicles.Count-1 > LeftVehicle then
    begin
      RightMax      := GetMaxCoupler(Vehicles[LeftVehicle+1]);
      ControlType2  := GetControlType(Vehicles[LeftVehicle+1]);
    end
    else
      RightMax := 3;

    Vehicles[LeftVehicle].Coupler := CommonCoupler(LeftMax,RightMax);

    if (F4 in CheckFlag(Vehicles[LeftVehicle].Coupler))
      and (ControlType1 <> ControlType2) then
        Vehicles[LeftVehicle].Coupler := Vehicles[LeftVehicle].Coupler - Ord(F4);
  end;
end;

function CheckFlag(Flag:Integer):TFlags;
var
  F : TFlag;
begin
  Result := [];

  F := TFlag(128);
  repeat
    if Flag >= Integer(F) then
    begin
      Include(Result,TFlag(F));
      Dec(Flag,Integer(F));
    end;
    F := TFlag(Integer(F) shr 1);
  until Integer(F) <= 0;
end;

function CommonCoupler(const C1,C2:Integer):Integer;
var
  Fs1,Fs2 : TFlags;
  f : TFlag;
begin
  Result := 0;

  Fs1 := CheckFlag(C1);
  Fs2 := CheckFlag(C2);

  for f in [F1,F2,F4,F8,F16,F32,F64,F128] do
    if (f in Fs1) and (f in Fs2) then
      Result := Result + Integer(f);
end;

function CheckMoveVehicle(const Vehicles:TObjectList<TVehicle>; const FromPos,ToPos:Integer):Boolean;
begin
  Result := True;
  if FromPos < ToPos then
      if (ToPos > 0) and (ToPos < Vehicles.Count-1)
      and (Vehicles[ToPos].Texture.NextTexID = Vehicles[ToPos+1].Texture.ID) then
        Result := False
    else
      if (ToPos > 0) and (Vehicles[ToPos].Texture.PrevTexID = Vehicles[ToPos-1].Texture.ID) then
        Result := False;
end;

procedure RandomLoad(var Vehicles:TObjectList<TVehicle>);
var
  i : Integer;
  Loads : TStringList;
begin
  for i := 0 to Vehicles.Count-1 do
  begin
    if (Vehicles[i].Texture.Typ >= tySZYNOBUS) then
    begin
      if Vehicles[i].Fiz <> nil then
      begin
        Loads := TStringList.Create;
        Loads.Delimiter := ',';
        Loads.DelimitedText := Vehicles[i].Fiz.LoadAccepted;

        if Loads.Count > 0 then
          Vehicles[i].LoadType := Loads[Random(Loads.Count-1)];
      end;
    end;
  end;
end;

procedure ReverseMultiple(Vehicles: TObjectList<TVehicle>;const Position:Integer);
var
  Indexes : TList<Integer>;
  i : Integer;
begin
  Indexes := GetMultiple(Vehicles,Position);

  for i := 0 to Indexes.Count-1 do
    if Vehicles[Indexes[i]].Dist >= 0 then
      Vehicles[Indexes[i]].Dist := -1
    else
      Vehicles[Indexes[i]].Dist := 0;

  Indexes.Sort;

  for i := 0 to (Indexes.Count div 2) - 1 do
    Vehicles.Exchange(Indexes.First+i,Indexes.Last-i);

  for i := 0 to Indexes.Count-1 do
    AutoConnect(Vehicles,Indexes[i]);
end;

end.
