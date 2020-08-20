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

unit uDepo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.StdCtrls, uStructures, Vcl.Menus;

type
  TfrmDepo = class(TForm)
    sgDepo: TStringGrid;
    pnlSelect: TPanel;
    sgModels: TStringGrid;
    spSplitter: TSplitter;
    lbTypes: TListBox;
    pnlFilters: TPanel;
    pnlLeft: TPanel;
    Panel3: TPanel;
    edTexName: TEdit;
    cbTexName: TCheckBox;
    pnlOwner: TPanel;
    edOperator: TEdit;
    cbOperator: TCheckBox;
    Panel4: TPanel;
    edMini: TEdit;
    cbMini: TCheckBox;
    Panel5: TPanel;
    Panel6: TPanel;
    cbRevStart: TCheckBox;
    Panel10: TPanel;
    cbRevEnd: TCheckBox;
    dtRevStart: TDateTimePicker;
    dtRevEnd: TDateTimePicker;
    Panel1: TPanel;
    edAuthor: TEdit;
    cbAuthor: TCheckBox;
    Panel2: TPanel;
    edPhoto: TEdit;
    cbPhoto: TCheckBox;
    Panel7: TPanel;
    edStation: TEdit;
    cbStation: TCheckBox;
    Panel8: TPanel;
    edModel: TEdit;
    cbModel: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure sgModelsClick(Sender: TObject);
    procedure lbTypesClick(Sender: TObject);
    procedure edOperatorChange(Sender: TObject);
    procedure cbOperatorClick(Sender: TObject);
    procedure edAuthorChange(Sender: TObject);
    procedure edPhotoChange(Sender: TObject);
    procedure edTexNameChange(Sender: TObject);
    procedure edMiniChange(Sender: TObject);
    procedure dtRevStartChange(Sender: TObject);
    procedure dtRevEndChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edModelChange(Sender: TObject);
    procedure edStationChange(Sender: TObject);
  private
    { Private declarations }
    const
      TYPES : array[0..30] of String = (
        ('Elektrow�z'), ('Spalinow�z'), ('Parow�z'), ('Szynobus'), ('EZT'), ('Roboczy'),
        ('Drezyna'), ('Tramwaj'), ('Wagon A'), ('Wagon B'), ('Wagon D'), ('Wagon E'),
        ('Wagon F'), ('Wagon G'), ('Wagon H'), ('Wagon L'), ('Wagon P'), ('Wagon R'),
        ('Wagon S'), ('Wagon U'), ('Wagon V'), ('Wagon W'), ('Wagon X'), ('Wagon Z'),
        ('Ci�ar�wka'), ('Autobus'), ('Samoch�d'), ('Cz�owiek'), ('Zwierz�'), ('Inny'), ('Nieznany')
        );
    function CheckFilters(const Tex: TTexture;const ModelID:Integer=0): Boolean;
    function AdaptRevDate(RevStr: string): TDate;
  public
    { Public declarations }
  end;

var
  frmDepo: TfrmDepo;

implementation

uses uMain, strUtils;

{$R *.dfm}

procedure TfrmDepo.cbOperatorClick(Sender: TObject);
begin
  lbTypesClick(self);
end;

procedure TfrmDepo.edAuthorChange(Sender: TObject);
begin
  if (cbAuthor.Checked) and (Length(edAuthor.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmDepo.edMiniChange(Sender: TObject);
begin
  if (cbMini.Checked) and (Length(edMini.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmDepo.edModelChange(Sender: TObject);
begin
  if (cbModel.Checked) and (Length(edModel.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmDepo.edOperatorChange(Sender: TObject);
begin
  if (cbOperator.Checked) and (Length(edOperator.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmDepo.edPhotoChange(Sender: TObject);
begin
  if (cbPhoto.Checked) and (Length(edPhoto.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmDepo.edStationChange(Sender: TObject);
begin
  if (cbStation.Checked) and (Length(edStation.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmDepo.edTexNameChange(Sender: TObject);
begin
  if (cbTexName.Checked) and (Length(edTexName.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmDepo.FormCreate(Sender: TObject);
var
  i, y, z, l : Integer;
  f : Boolean;
begin
  sgDepo.Cells[0,0] := 'Lp.';
  sgDepo.Cells[1,0] := 'Tekstura';
  sgDepo.Cells[2,0] := 'Miniatura';
  sgDepo.Cells[3,0] := 'Model';
  sgDepo.Cells[4,0] := 'Operator';
  sgDepo.Cells[5,0] := 'Stacja';
  sgDepo.Cells[6,0] := 'Data rewizji';
  sgDepo.Cells[7,0] := 'Autor';
  sgDepo.Cells[8,0] := 'Zdj�cia';

  sgModels.Cells[0,0] := 'Lp.';
  sgModels.Cells[1,0] := 'Kategoria';
  sgModels.Cells[2,0] := '�cie�ka dost�pu';
end;

procedure TfrmDepo.FormShow(Sender: TObject);
begin
  lbTypes.ItemIndex := 0;
  lbTypesClick(self);
end;

function tFrmDepo.AdaptRevDate(RevStr:string):TDate;
var
  fs: TFormatSettings;
begin
  try
    Result := 0;
    if (cbRevStart.Checked) or (cbRevEnd.Checked) then
      if RevStr.Length = 10 then
      begin
        fs := TFormatSettings.Create;
        fs.DateSeparator := '.';
        fs.ShortDateFormat := 'dd.MM.yyyy';
        RevStr := StringReplace(RevStr,'xx','01',[rfReplaceAll]);
        Result := StrToDateTime(RevStr, fs);
      end;
  except
    Result := 0;
  end;
end;

function TfrmDepo.CheckFilters(const Tex:TTexture;const ModelID:Integer=0):Boolean;
var
  Rev : TDate;
begin
  Rev := AdaptRevDate(Tex.Revision);

  Result := False;
  if (not cbOperator.Checked) or (SameText(Tex.Owner,edOperator.Text)) then
  if (not cbAuthor.Checked)   or (ContainsText(Tex.Author,edAuthor.Text)) then
  if (not cbPhoto.Checked)    or (ContainsText(Tex.Photos,edPhoto.Text)) then
  if (not cbTexName.Checked)  or (ContainsText(Tex.Plik,edTexName.Text)) then
  if (not cbMini.Checked)     or (ContainsText(Tex.Models[ModelID].MiniD,edMini.Text)) then
  if (not cbModel.Checked)    or (ContainsText(Tex.Models[ModelID].Model,edModel.Text)) then
  if (not cbStation.Checked)  or (ContainsText(Tex.Station,edStation.Text)) then
  if (not cbRevStart.Checked) or (Rev >= dtRevStart.Date) then
  if (not cbRevEnd.Checked)   or (Rev <= dtRevEnd.Date) then
    Result := True;
end;

procedure TfrmDepo.dtRevEndChange(Sender: TObject);
begin
  if cbRevEnd.Checked then
    lbTypesClick(self);
end;

procedure TfrmDepo.dtRevStartChange(Sender: TObject);
begin
  if cbRevStart.Checked then
    lbTypesClick(self);
end;

procedure TfrmDepo.lbTypesClick(Sender: TObject);
var
  i, y, z : Integer;
  f : Boolean;
begin
  sgModels.RowCount := 1;
  for i := 0 to Main.Textures.Count-1 do
    for y := 0 to Main.Textures[i].Models.Count-1 do
      if CheckFilters(Main.Textures[i],y) then
        if Ord(Main.Textures[i].Typ) = lbTypes.ItemIndex then
        begin
          f := False;
          for z := 1 to sgModels.RowCount-1 do
              if SameText(Main.Textures[i].Models[y].Mini,sgModels.Cells[1,z]) then
                f := True;
          if not f then
          begin
            sgModels.RowCount := sgModels.RowCount + 1;
            sgModels.Cells[0,sgModels.RowCount-1] := IntToStr(sgModels.RowCount-1) + '.';
            sgModels.Cells[1,sgModels.RowCount-1] := Main.Textures[i].Models[y].Mini;
            sgModels.Cells[2,sgModels.RowCount-1] := Main.Textures[i].Dir;
          end;
        end;
  if sgModels.RowCount > 1 then
    sgModels.FixedRows := 1;
  sgModelsClick(self);
end;

procedure TfrmDepo.sgModelsClick(Sender: TObject);
var
  i, y : Integer;
begin
  sgDepo.RowCount := 1;
  for i := 0 to Main.Textures.Count-1 do
    for y := 0 to Main.Textures[i].Models.Count-1 do
    begin
      if CheckFilters(Main.Textures[i],y) then
        if SameText(Main.Textures[i].Models[y].Mini,sgModels.Cells[1,sgModels.Row]) then
        begin
          sgDepo.RowCount := sgDepo.RowCount + 1;
          sgDepo.Cells[0,sgDepo.RowCount-1] := IntToStr(sgDepo.RowCount-1) + '.';
          sgDepo.Cells[1,sgDepo.RowCount-1] := Main.Textures[i].Plik;
          sgDepo.Cells[2,sgDepo.RowCount-1] := Main.Textures[i].Models[y].MiniD;
          sgDepo.Cells[3,sgDepo.RowCount-1] := Main.Textures[i].Models[y].Model;
          sgDepo.Cells[4,sgDepo.RowCount-1] := Main.Textures[i].Owner;
          sgDepo.Cells[5,sgDepo.RowCount-1] := Main.Textures[i].Station;
          sgDepo.Cells[6,sgDepo.RowCount-1] := Main.Textures[i].Revision;
          sgDepo.Cells[7,sgDepo.RowCount-1] := Main.Textures[i].Author;
          sgDepo.Cells[8,sgDepo.RowCount-1] := Main.Textures[i].Photos;
        end;
    end;
  if sgDepo.RowCount > 1 then
    sgDepo.FixedRows := 1;
end;

end.
