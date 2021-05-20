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
     uUtilities;

type

TData = class
  Scenarios   : TObjectList<TScenario>;
  Textures    : TObjectList<TTexture>;
  Physics     : TObjectList<TPhysics>;
  Depot       : TObjectList<TTrain>;
  Loads       : TList<TLoad>;

  constructor Create;
  class procedure Load;
  function LoadsIndex(const LoadName:string):Integer;
end;

function GetMaxCoupler(const Vehicle:TVehicle;LeftCoupler:Boolean=True):Integer;
function GetControlType(const Vehicle:TVehicle;const LeftCoupler:Boolean=True):string;
function PrepareTrainsetDesc(const Trainset:TTrain):string;
function PrepareNode(const Dyn:TVehicle;const TrainSet:Boolean=True):string;
function RecalcTrainParams(const Train:TTrain;const AllVehicles:Boolean=False):TTrainParams;
function IncludeVehicleToMass(const Vehicle:TVehicle;const AllVehicles:Boolean):Boolean;
procedure Connect(Train:TTrain;const LeftVehicle:Integer);
function CheckFlag(Flag:Integer):TFlags;
function CommonCoupler(C1,C2:Integer):Integer;

var
  Data : TData;

implementation

uses SysUtils;

function GetMaxCoupler(const Vehicle:TVehicle;LeftCoupler:Boolean=True):Integer;
begin
  try
  if Vehicle.Texture <> nil then
  begin
    if LeftCoupler then
    begin
      if Vehicle.Dist >= 0 then
        Result := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.AllowedFlagA
      else
        Result := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.AllowedFlagB;
    end
    else
    begin
      if Vehicle.Dist >= 0 then
        Result := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.AllowedFlagB
      else
        Result := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.AllowedFlagA;
    end;
  end
  else
    Result := 3;
  except
    Util.Errors.Add('B³¹d sprawdzania wartoœci AllowedFlag. ' +
                    'Nale¿y sprawdziæ plik .fiz dla ' +
                    Vehicle.Texture.Models[Vehicle.ModelID].Model);
  end;
end;

function GetControlType(const Vehicle:TVehicle;const LeftCoupler:Boolean=True):string;
begin
  try
    if Vehicle.Texture <> nil then
    begin
      if LeftCoupler then
      begin
        if Vehicle.Dist >= 0 then
          Result := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.ControlTypeA
        else
          Result := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.ControlTypeB;
      end
      else
      begin
        if Vehicle.Dist >= 0 then
          Result := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.ControlTypeB
        else
          Result := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.ControlTypeA;
      end;
    end
    else
      Result := EmptyStr;
  except
    Util.Errors.Add('B³¹d sprawdzania wartoœci ControlType. ' +
                    'Nale¿y sprawdziæ plik .fiz dla ' +
                    Vehicle.Texture.Models[Vehicle.ModelID].Model);
  end;
end;

function TData.LoadsIndex(const LoadName:string):Integer;
var
  i : Integer;
begin
  Result := -1;

  for i := 0 to Data.Loads.Count-1 do
    if SameText(LoadName,Data.Loads[i].Name) then
    begin
      Result := i;
      Break;
    end;
end;

function PrepareTrainsetDesc(const Trainset:TTrain):string;
var
  i, c : Integer;
begin
  if Trainset.Vehicles.Count > 0 then
  begin
    if (Trainset.Vehicles.First.Texture <> nil) and (Trainset.Vehicles.First.Texture.Typ in [tyELEKTROWOZ..tyEZT]) then
      Result := Trainset.Vehicles.First.Name
    else
      Result := Trainset.Vehicles.First.TypeChk;

    c := 1;
    for i := 1 to Trainset.Vehicles.Count-1 do
      if (Trainset.Vehicles[i].Texture <> nil) and (Trainset.Vehicles[i-1].Texture <> nil)
        and SameText(Trainset.Vehicles[i-1].Texture.Models[Trainset.Vehicles[i-1].ModelID].Mini,
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
        if (Trainset.Vehicles[i].Texture <> nil) then
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

constructor TData.Create;
begin
  Textures  := TObjectList<TTexture>.Create;
  Physics   := TObjectList<TPhysics>.Create;
  Scenarios := TObjectList<TScenario>.Create();
  Depot     := TObjectList<TTrain>.Create;
  Loads     := TList<TLoad>.Create;
end;

class procedure TData.Load;
begin
  Data := TData.Create;
  TParser.LoadData;
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
      if Train.Vehicles[i].Texture <> nil then
      begin
        if IncludeVehicleToMass(Train.Vehicles[i],AllVehicles) then
        begin
          Result.Mass := Result.Mass + Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz.Mass;

          LoadIndex := Data.LoadsIndex(Train.Vehicles[i].LoadType);

          if LoadIndex >= 0 then
            Result.LoadMass := Result.LoadMass + (Train.Vehicles[i].Loadquantity * Data.Loads[LoadIndex].Weight)
          else
            Result.LoadMass := Result.LoadMass + (Train.Vehicles[i].Loadquantity * 1000);
        end;
        Result.Length := Result.Length + Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz.Length;
      end;
    end;
    Result.CountVehicles := Train.Vehicles.Count;
  end;
end;

function IncludeVehicleToMass(const Vehicle:TVehicle;const AllVehicles:Boolean):Boolean;
begin
  Result := (Vehicle.Texture <> nil) and
            (Vehicle.Texture.Models[Vehicle.ModelID].Fiz <> nil) and
            (((Vehicle.CabOccupancy > coRearDriver)
            or (Vehicle.Texture.Typ = tyEZT)
            or (Vehicle.Texture.Typ = tySZYNOBUS))
            or (AllVehicles));
end;

procedure Connect(Train:TTrain;const LeftVehicle:Integer);
var
  LeftMax, RightMax : Integer;
  ControlType1, ControlType2 : string;
begin
  if (LeftVehicle >= 0) and (Train.Vehicles.Count-1 > LeftVehicle) then
  begin
    LeftMax       := GetMaxCoupler(Train.Vehicles[LeftVehicle],False);
    ControlType1  := GetControlType(Train.Vehicles[LeftVehicle],False);

    if Train.Vehicles.Count-1 > LeftVehicle then
    begin
      RightMax      := GetMaxCoupler(Train.Vehicles[LeftVehicle+1]);
      ControlType2  := GetControlType(Train.Vehicles[LeftVehicle+1]);
    end
    else
      RightMax := 3;

    Train.Vehicles[LeftVehicle].Coupler := CommonCoupler(LeftMax,RightMax);

    if (F4 in CheckFlag(Train.Vehicles[LeftVehicle].Coupler))
      and (ControlType1 <> ControlType2) then
        Train.Vehicles[LeftVehicle].Coupler := Train.Vehicles[LeftVehicle].Coupler - Ord(F4);
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

function CommonCoupler(C1,C2:Integer):Integer;
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

end.
