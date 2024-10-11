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

unit uTexRandomizer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uStructures, System.Generics.Collections,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls;

type
  TTexFilter = class
    Typ           : TTyp;
    Mini          : TStringList;
    ModelID       : Integer;
    Owner         : string;
    Drive         : Boolean;
    RevDate       : Integer;
    RevTolerance  : Integer;
    Multiple      : Boolean;
    Model         : string;
    Wreck         : Boolean;
    constructor Create;
  end;

  TTexStock = class
    Stock   : TStringList;
    constructor Create;
  end;

  TTexRandomizer = class
    procedure RandomTex(Trains:TObjectList<TTrain>); overload;
    procedure RandomTex(Vehicles:TObjectList<TVehicle>); overload;
  private
    TexStock : TList<TTexStock>;
    RevisionTolerance : Integer;
    RevYear : Integer;
    WithoutArchival : Boolean;
    procedure MultipleAssign(Vehicles:TObjectList<TVehicle>; Index: Integer;const Tex: TTexture);
    function FindSimilarTex(TexFilter:TTexFilter):TList<Integer>;
    function FilterForm:Boolean;
    procedure LoadTexStock;
  public
    constructor Create;
  end;

  TfrmTexRandomizer = class(TForm)
    lbEra: TLabel;
    pnlEra: TPanel;
    Panel1: TPanel;
    btnOK: TButton;
    seTexAgeDiff: TSpinEdit;
    chRevDiff: TCheckBox;
    rbTextureRevYear: TRadioButton;
    rbUserYear: TRadioButton;
    seYear: TSpinEdit;
    lbTestVersion: TLabel;
    chWithoutArchival: TCheckBox;
    procedure rbUserYearClick(Sender: TObject);
    procedure chRevDiffClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uMain, uData, uUtilities;

{$R *.dfm}

{ TexRandomizer }

procedure TTexRandomizer.LoadTexStock;
var
  TexStockFile : TStringList;
  Stock : TTexStock;
  i : Integer;
begin
  try
    if FileExists(Util.DIR + 'starter\reguly.txt') then
    begin
      TexStockFile := TStringList.Create;
      TexStockFile.LoadFromFile(Util.DIR + 'starter\reguly.txt');

      for i := 0 to TexStockFile.Count-1 do
      begin
        if Pos('#',TexStockFile[i]) <> 1 then
        begin
          Stock := TTexStock.Create;
          ExtractStrings([','],[],PChar(TexStockFile[i]),Stock.Stock);
          TexStock.Add(Stock);
        end;
      end;
    end;
  except
    on E: Exception do
        Util.Log.Add('B³¹d wczytywania regu³ (starter\reguly.txt). Szczegó³y b³êdu: ' + E.Message);
  end;
end;

function TTexRandomizer.FindSimilarTex(TexFilter:TTexFilter):TList<Integer>;
var
  i, y : Integer;
  RevDate, ModelID : Integer;
  Accept : Boolean;
  //s : string;
begin
  Result := TList<Integer>.Create;
    try
    for i := 0 to Data.Textures.Count-1 do
      if (Data.Textures[i].Typ = TexFilter.Typ) and (Data.Textures[i].Errors = [])
        and ((Data.Textures[i].Archive = False) or (WithoutArchival = False)) then
        Result.Add(Data.Textures[i].ID);

    i := 0;
    while i < Result.Count do
    begin
      if Data.Textures[Result[i]].Models.Count > TexFilter.ModelID then
        ModelID := TexFilter.ModelID
      else
        ModelID := 0;

      Accept := False;
      y := 0;
      while y < TexFilter.Mini.Count do
      begin
        if {(not TexFilter.Multiple) and} (SameText(TexFilter.Mini[y],Data.Textures[Result[i]].Models[ModelID].Mini))
          {or (TexFilter.Multiple) and (SameText(TexFilter.Model,Main.Textures[Result[i]].Models[ModelID].Model))} then
        begin
          Accept := True;
          Break;
        end
        else
          Inc(y);
      end;

      if not Accept then
        Result.Delete(i)
      else
        Inc(i);
    end;

    if (TexFilter.Owner.Length > 0) then
    begin
      i := 0;
      while i < Result.Count do
        if TexFilter.Owner <> Data.Textures[Result[i]].Owner then
          Result.Delete(i)
        else
          Inc(i);

      if (TexFilter.RevTolerance > 0) then
      begin
        i := 0;
        while i < Result.Count do
        begin
          if RevYear > 0 then
            TexFilter.RevDate := RevYear;

          if (TryStrToInt(Copy(Data.Textures[Result[i]].Revision,7,4),RevDate)) then
          begin
            if (RevDate >= TexFilter.RevDate - TexFilter.RevTolerance)
                and (RevDate <= TexFilter.RevDate + TexFilter.RevTolerance) then
              Inc(i)
            else
              Result.Delete(i);
          end
          else
            Result.Delete(i);
        end;
      end;
    end;

    {s := '';
    for i := 0 to Result.Count-1 do
        s := s + #13#10 + Main.Textures[Result[i]].Plik;
    ShowMessage(s);}
  except
    on E: Exception do
        Util.Log.Add('B³¹d wyszukiwania tekstur. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

procedure TTexRandomizer.RandomTex(Vehicles:TObjectList<TVehicle>);
var
  i, y : Integer;
  MatchTextures : TList<Integer>;
  TexFilter : TTexFilter;
begin
  Randomize;

  TexFilter := TTexFilter.Create;
  try
    i := -1;
    while i < Vehicles.Count-1 do
    begin
      Inc(i);
      TexFilter.Mini.Clear;
      TexFilter.Owner := EmptyStr;
      TexFilter.Drive := Vehicles[i].CabOccupancy in [coHeadDriver,coRearDriver];
      if Vehicles[i].Texture.ID > 0 then
      begin
        if ((Vehicles[i].Texture.PrevTexID < 0)
          and (Vehicles[i].Texture.NextTexID < 0))
        and ((Vehicles[i].Texture.Typ in [TTyp.tySZYNOBUS..TTyp.tyEZT])
          or ((Vehicles[i].Texture.Typ = TTyp.tyELEKTROWOZ)
            and ((Pos('ET4',Vehicles[i].Texture.Plik) > 0) or (Pos('112E',Vehicles[i].Texture.Plik) > 0)))) then
          Continue;

        if (Pos('112E',Vehicles[i].Texture.Plik) > 0) then Continue;

        if Vehicles[i].Texture.PrevTexID > 0 then Continue;
        {TexFilter.Multiple      := Vehicles[i].Texture.NextTexID >= 0;
        if TexFilter.Multiple then
          TexFilter.Model := Vehicles[i].Texture.Models[Vehicles[i].ModelID].Model;}

        TexFilter.Typ           := Vehicles[i].Texture.Typ;
        TexFilter.Mini.Add(Vehicles[i].Texture.Models[Vehicles[i].ModelID].Mini);
        TexFilter.ModelID       := Vehicles[i].ModelID;

        TexFilter.Wreck := (Pos('wreck',Vehicles[i].Texture.Plik) > 0)
                        or (Pos('wrak',Vehicles[i].Texture.Plik) > 0);

        if (TexFilter.Typ <> tyEZT) and (TexFilter.Typ <> tySZYNOBUS) then
          TexFilter.Owner       := Vehicles[i].Texture.Owner;

        if TryStrToInt(Copy(Vehicles[i].Texture.Revision,7,4),TexFilter.RevDate) then
          TexFilter.RevTolerance := RevisionTolerance
        else
          continue;
      end
      else
      begin
        if Pos('road\',Vehicles[i].Dir) > 0 then
          TexFilter.Typ   := tySAMOCHOD
        else
        if Pos('river\',Vehicles[i].Dir) > 0 then
          TexFilter.Typ   := tyINNE
        else
        if TexFilter.Drive then
        begin
          TexFilter.Typ   := tySPALINOWOZ;
          TexFilter.Mini.Add('st44');
        end
        else
        begin
          if (i > 0) and (Vehicles[i-1].CabOccupancy > coRearDriver) then
          begin
            TexFilter.Typ     := Vehicles[i-1].Texture.Typ;
            TexFilter.Mini.Add(Vehicles[i-1].Texture.Models[Vehicles[i-1].ModelID].Mini);
            TexFilter.ModelID := Vehicles[i-1].ModelID;
          end
          else
          if (Vehicles.Count-1 > i) and (Vehicles[i+1].CabOccupancy > coRearDriver) then
          begin
            TexFilter.Typ     := Vehicles[i+1].Texture.Typ;
            TexFilter.Mini.Add(Vehicles[i+1].Texture.Models[Vehicles[i+1].ModelID].Mini);
            TexFilter.ModelID := Vehicles[i+1].ModelID;
          end
          else
          begin
            TexFilter.Typ     := tyA;
            TexFilter.Mini.Add('A_112A');
            TexFilter.ModelID := 0;
          end;
        end;
      end;

      if TexFilter.Mini.Count = 0 then TexFilter.Mini.Add('empty');

      for y := 0 to TexStock.Count-1 do
        if Pos(UpperCase(TexFilter.Mini[0]),UpperCase(TexStock[y].Stock.Text)) > 0 then
        begin
          TexFilter.Mini.AddStrings(TexStock[y].Stock);
          Break;
        end;

      MatchTextures := FindSimilarTex(TexFilter);

      if MatchTextures.Count > 1 then
        MultipleAssign(Vehicles,i,Data.Textures[MatchTextures[Random(MatchTextures.Count)]]);
    end;
  finally
    TexFilter.Free;
  end;
end;

procedure TTexRandomizer.RandomTex(Trains: TObjectList<TTrain>);
var
  i, y : Integer;
begin
  RevYear           := -1;
  RevisionTolerance := -1;
  Main.selTrain := 0;
  if FilterForm then
    for i := 0 to Trains.Count-1 do
    begin
      RandomTex(Trains[i].Vehicles);
      for y := 0 to Trains[i].Vehicles.Count-1 do
        if (Trains[i].Vehicles[y].Texture.Typ = tyEZT)
         or (Trains[i].Vehicles[y].CabOccupancy = coHeadDriver) then
            AutoConnect(Main.Train.Vehicles,y);
      Inc(Main.SelTrain);
    end;
end;

constructor TTexRandomizer.Create;
begin
  TexStock := TList<TTexStock>.Create;
  LoadTexStock;
end;

function TTexRandomizer.FilterForm:Boolean;
var
  frmTexRandomizer : TfrmTexRandomizer;
begin
  Result := True;
  frmTexRandomizer := TfrmTexRandomizer.Create(nil);
  try
    if frmTexRandomizer.ShowModal = mrOk then
    begin
      if frmTexRandomizer.chRevDiff.Checked then
      begin
        RevisionTolerance := frmTexRandomizer.seTexAgeDiff.Value;

        if frmTexRandomizer.rbTextureRevYear.Checked then
          RevYear := -1
        else
          RevYear := frmTexRandomizer.seYear.Value;
      end
      else
        RevisionTolerance := -1;

      WithoutArchival := frmTexRandomizer.chWithoutArchival.Checked;
    end
    else
      Result := False;

  finally
    frmTexRandomizer.Free;
  end;
end;

procedure TTexRandomizer.MultipleAssign(Vehicles:TObjectList<TVehicle>;Index:Integer;const Tex:TTexture);
begin
  try
    if (Vehicles[Index].Texture = Tex) then Exit;
    if (Vehicles[Index].Texture.Typ in [TTyp.tyELEKTROWOZ..tyEZT])
        and ((Main.IsVehicleName(Tex.Models[Vehicles[Index].ModelID].MiniD) > 0)
            or (Main.IsVehicleName(Tex.Plik) > 0)) then Exit;

    Main.AssignTexToVehicle(Vehicles[Index],Tex);

    Inc(Index);
    if (Tex.NextTexID >= 0) then
      if Vehicles.Count = Index then
        Main.AddVehicle(Index,Data.Textures[Tex.NextTexID],False,True)
      else
        if (Vehicles[Index].Texture.PrevTexID < 0) then
          Main.AddVehicle(Index,Data.Textures[Tex.NextTexID],False,True)
        else
          MultipleAssign(Vehicles,Index,Data.Textures[Tex.NextTexID]);

    Index := 0;
    while (Vehicles.Count-1 > Index) do
    begin
      if (Vehicles[Index].Texture.NextTexID < 0) and (Vehicles[Index+1].Texture.PrevTexID > 0)  then
        Main.RemoveVehicles(Index+1,Vehicles);

      Inc(Index);
    end;
  except
    on E: Exception do
        Util.Log.Add('B³¹d edycji pojazdu. Szczegó³y b³êdu: ' + E.Message);
  end;
end;

procedure TfrmTexRandomizer.chRevDiffClick(Sender: TObject);
begin
  seTexAgeDiff.Enabled := chRevDiff.Checked;
end;

procedure TfrmTexRandomizer.rbUserYearClick(Sender: TObject);
begin
  seYear.Enabled := rbUserYear.Checked;
end;

{ TTexStock }

constructor TTexStock.Create;
begin
  Stock := TStringList.Create;
end;

{ TTexFilter }

constructor TTexFilter.Create;
begin
  Mini := TStringList.Create;
end;

end.
