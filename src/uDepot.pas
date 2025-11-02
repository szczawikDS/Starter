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

unit uDepot;

interface

uses Classes, uParser;

type
  TDepot = class(TLexParser)
  public
    class procedure ReadDepot(const Path:string='');
    class procedure SaveDepot;
  end;

  TDepotThread = class(TThread)
  protected
   procedure Execute; override;
  end;

implementation

uses uMain, uStructures, SysUtils, CastaliaPasLexTypes, uData, uUtilities;

{ TDepot }

class procedure TDepot.ReadDepot(const Path: string);
var
  DepotFile : TStringList;
  Pociag : TTrain;
  TrainName : string;
begin
  with TDepot.Create do
  try
    try
      DepotFile := TStringList.Create;

      if Path.IsEmpty then
      begin
        if FileExists(Util.DIR + 'starter\magazyn.ini') then
          DepotFile.LoadFromFile(Util.DIR + 'starter\magazyn.ini')
        else
          if FileExists(Util.DIR + 'starter.ini') then
            DepotFile.LoadFromFile(Util.DIR + 'starter.ini')
          else
            if FileExists(Util.DIR + 'RAINSTED.INI') then
              DepotFile.LoadFromFile(Util.DIR + 'RAINSTED.INI');
      end
      else
        if FileExists(Path) then
              DepotFile.LoadFromFile(Path);

      Lexer.Origin := PChar(DepotFile.Text);
      Lexer.Init;

      Lexer.NextNoJunk;

      While Lexer.TokenID <> ptNull do
      begin
        if Lexer.TokenID = ptSquareOpen then
        begin
          Lexer.NextNoJunk;
          if (Lexer.TokenID = ptIdentifier) and (Pos('TRAINSET',Lexer.Token) > 0) and (Lexer.Token.Length > 8) then
          begin
            Pociag := TTrain.Create;

            Lexer.Next;
            if Lexer.TokenID = ptEqual then
            begin
              TrainName := GetToken([ptSquareClose]);
              Pociag.TrainName := Copy(TrainName,2,TrainName.Length);
            end
            else
              Pociag.TrainName := '';

            Lexer.NextNoJunk;
            Lexer.NextID(ptIdentifier);

            while Lexer.Token = 'node' do
            begin
              Pociag.Vehicles.Add(ParseVehicle);
              Lexer.NextID(ptIdentifier);
              Lexer.NextNoJunk;
              if Lexer.TokenID <> ptSquareOpen then
                Lexer.NextID(ptIdentifier);
            end;
            Data.Depot.Add(Pociag);
          end
          else
            Lexer.NextNoJunk;
        end
        else
          Lexer.Next;
      end;
    except
      Util.Log.Add(Util.LabelStr(LOG_DEPO_PARSE_FAULT) + ' ' + IntToStr(Lexer.LineNumber));
    end;
  finally
    Free;
  end;
end;

class procedure TDepot.SaveDepot;
var
  DepotFile : TStringList;
  i, y : Integer;
begin
  try
    DepotFile := TStringList.Create;

    for i := 0 to Data.Depot.Count-1 do
    begin
      if Data.Depot[i].Vehicles.Count > 0 then
      begin
        DepotFile.Add('[TRAINSET' + IntToStr(i) + '=' + Data.Depot[i].TrainName + ']');
        for y := 0 to Data.Depot[i].Vehicles.Count-1 do
          DepotFile.Add(Format('%.2d=',[y]) + PrepareNode(Data.Depot[i].Vehicles[y]));
      end;
    end;

    DepotFile.SaveToFile(Util.DIR + 'starter\magazyn.ini');
  except
    Util.Log.Add(Util.LabelStr(LOG_DEPO_SAVE_FAULT));
  end;
end;

{ TDepotTest }

procedure TDepotThread.Execute;
begin
  inherited;
  FreeOnTerminate := True;
  TDepot.ReadDepot;
  Synchronize(Main.LoadMagazine);
end;

end.
