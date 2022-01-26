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

unit uTextureBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.StdCtrls, uStructures, Vcl.Menus;

type
  TfrmTextureBase = class(TForm)
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
    pmMenu: TPopupMenu;
    miOpenDir: TMenuItem;
    miCopy: TMenuItem;
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
    procedure sgDepoDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure miOpenDirClick(Sender: TObject);
    procedure pmMenuPopup(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgDepoDblClick(Sender: TObject);
    procedure sgDepoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miCopyClick(Sender: TObject);
  private
    { Private declarations }
    SortColumn : Integer;
    Cell : string;
    const
      TYPES : array[0..31] of String = (
        ('Elektrowóz'), ('Spalinowóz'), ('Parowóz'), ('Szynobus'), ('EZT'), ('Roboczy'),
        ('Drezyna'), ('Tramwaj'), ('Wagon A'), ('Wagon B'), ('Wagon D'), ('Wagon E'),
        ('Wagon F'), ('Wagon G'), ('Wagon H'), ('Wagon I'), ('Wagon L'), ('Wagon P'), ('Wagon R'),
        ('Wagon S'), ('Wagon U'), ('Wagon V'), ('Wagon W'), ('Wagon X'), ('Wagon Z'),
        ('Ciê¿arówka'), ('Autobus'), ('Samochód'), ('Cz³owiek'), ('Zwierzê'), ('Inny'), ('Nieznany')
        );
    function CheckFilters(const Tex: TTexture;const ModelID:Integer=0): Boolean;
    function AdaptRevDate(RevStr: string): TDate;
  public
    { Public declarations }
  end;

implementation

uses uMain, uLanguages, Clipbrd, uUtilities, uData;

{$R *.dfm}

procedure TfrmTextureBase.cbOperatorClick(Sender: TObject);
begin
  lbTypesClick(self);
end;

procedure TfrmTextureBase.edAuthorChange(Sender: TObject);
begin
  if (cbAuthor.Checked) and (Length(edAuthor.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.edMiniChange(Sender: TObject);
begin
  if (cbMini.Checked) and (Length(edMini.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.edModelChange(Sender: TObject);
begin
  if (cbModel.Checked) and (Length(edModel.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.edOperatorChange(Sender: TObject);
begin
  if (cbOperator.Checked) and (Length(edOperator.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.edPhotoChange(Sender: TObject);
begin
  if (cbPhoto.Checked) and (Length(edPhoto.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.edStationChange(Sender: TObject);
begin
  if (cbStation.Checked) and (Length(edStation.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.edTexNameChange(Sender: TObject);
begin
  if (cbTexName.Checked) and (Length(edTexName.Text) > 1) then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(self);
end;

procedure TfrmTextureBase.FormCreate(Sender: TObject);
begin
  TLanguages.ChangeLanguage(Self,Util.Lang);

  sgDepo.Cells[0,0] := 'Lp.';
  sgDepo.Cells[1,0] := 'Tekstura';
  sgDepo.Cells[2,0] := 'Miniatura';
  sgDepo.Cells[3,0] := 'Podgl¹d';
  sgDepo.Cells[4,0] := 'Model';
  sgDepo.Cells[5,0] := 'Operator';
  sgDepo.Cells[6,0] := 'Stacja';
  sgDepo.Cells[7,0] := 'Data rewizji';
  sgDepo.Cells[8,0] := 'Autor';
  sgDepo.Cells[9,0] := 'Zdjêcia';

  sgModels.Cells[0,0] := 'Lp.';
  sgModels.Cells[1,0] := 'Kategoria';
  sgModels.Cells[2,0] := 'Œcie¿ka dostêpu';
end;

procedure TfrmTextureBase.FormShow(Sender: TObject);
begin
  lbTypes.ItemIndex := 0;
  lbTypesClick(self);
end;

function tfrmTextureBase.AdaptRevDate(RevStr:string):TDate;
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

function TfrmTextureBase.CheckFilters(const Tex:TTexture;const ModelID:Integer=0):Boolean;
var
  Rev : TDate;
begin
  Rev := AdaptRevDate(Tex.Revision);

  Result := False;
  if (not cbOperator.Checked) or (SameTextOmitAccents(Tex.Owner,edOperator.Text)) then
  if (not cbAuthor.Checked)   or (ContainsOmitAccents(Tex.Author,edAuthor.Text)) then
  if (not cbPhoto.Checked)    or (ContainsOmitAccents(Tex.Photos,edPhoto.Text)) then
  if (not cbTexName.Checked)  or (ContainsOmitAccents(Tex.Plik,edTexName.Text)) then
  if (not cbMini.Checked)     or (ContainsOmitAccents(Tex.Models[ModelID].MiniD,edMini.Text)) then
  if (not cbModel.Checked)    or (ContainsOmitAccents(Tex.Models[ModelID].Model,edModel.Text)) then
  if (not cbStation.Checked)  or (ContainsOmitAccents(Tex.Station,edStation.Text)) then
  if (not cbRevStart.Checked) or (Rev >= dtRevStart.Date) then
  if (not cbRevEnd.Checked)   or (Rev <= dtRevEnd.Date) then
    Result := True;
end;

procedure TfrmTextureBase.dtRevEndChange(Sender: TObject);
begin
  if cbRevEnd.Checked then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.dtRevStartChange(Sender: TObject);
begin
  if cbRevStart.Checked then
    lbTypesClick(self);
end;

procedure TfrmTextureBase.lbTypesClick(Sender: TObject);
var
  i, y, z : Integer;
  f : Boolean;
begin
  sgModels.RowCount := 1;
  for i := 0 to Data.Textures.Count-1 do
    for y := 0 to Data.Textures[i].Models.Count-1 do
      if CheckFilters(Data.Textures[i],y) then
        if Ord(Data.Textures[i].Typ) = lbTypes.ItemIndex then
        begin
          f := False;
          for z := 1 to sgModels.RowCount-1 do
              if SameText(Data.Textures[i].Models[y].Mini,sgModels.Cells[1,z]) then
                f := True;
          if not f then
          begin
            sgModels.RowCount := sgModels.RowCount + 1;
            sgModels.Cells[0,sgModels.RowCount-1] := IntToStr(sgModels.RowCount-1) + '.';
            sgModels.Cells[1,sgModels.RowCount-1] := Data.Textures[i].Models[y].Mini;
            sgModels.Cells[2,sgModels.RowCount-1] := Data.Textures[i].Dir;
          end;
        end;
  if sgModels.RowCount > 1 then
    sgModels.FixedRows := 1;
  sgModelsClick(self);
end;

procedure TfrmTextureBase.miCopyClick(Sender: TObject);
begin
  Clipboard.AsText := Cell;
end;

procedure TfrmTextureBase.miOpenDirClick(Sender: TObject);
begin
  OpenDir(Util.DIR + 'dynamic\' + (sgModels.Cells[2,sgModels.Row]));
end;

procedure TfrmTextureBase.pmMenuPopup(Sender: TObject);
begin
  miOpenDir.Visible := sgModels.RowCount > 1;
end;

procedure TfrmTextureBase.sgDepoDblClick(Sender: TObject);
var
  i, y : Integer;
begin
  if sgDepo.Row > 0 then
  begin
    for i := 0 to Data.Textures.Count-1 do
      for y := 0 to Data.Textures[i].Models.Count-1 do
        if (Data.Textures[i].Plik = sgDepo.Cells[1,sgDepo.Row])
        and (Data.Textures[i].Models[y].Model = sgDepo.Cells[4,sgDepo.Row]) then
          Main.SelectTexture(Data.Textures[i],y);
    Self.Close;
  end;
end;

procedure TfrmTextureBase.sgDepoDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  ACanvas : TCanvas;
  B : TBitmap;

  S: string;
  RectForText: TRect;
begin
  if (ACol = 3) and (ARow > 0) then
  begin
    aCanvas := (Sender as TStringGrid).Canvas;
    aCanvas.FillRect(Rect);

    B := TBitmap.Create;
    if sgDepo.Cells[2,ARow].Length > 0 then
      B.LoadFromFile(Util.DIR + '\textures\mini\' + sgDepo.Cells[2,ARow] + '.bmp')
    else
      B.LoadFromFile(Util.DIR + '\textures\mini\other.bmp');

    aCanvas.Draw(Rect.Left, Rect.Top, B);
  end;

  if (ACol = SortColumn) and (ARow = 0) then
  begin
    S := sgDepo.Cells[ACol, ARow];
    sgDepo.Canvas.FillRect(Rect);
    sgDepo.Canvas.Font.Color := clYellow;
    RectForText := Rect;
    InflateRect(RectForText, -6, -8);
    sgDepo.Canvas.TextRect(RectForText,S);
  end;
end;

procedure SortStringGrid(var GenStrGrid: TStringGrid; ThatCol: Integer);
const
  TheSeparator = '@';
var
  CountItem, I, J, K, ThePosition: integer;
  MyList: TStringList;
  MyString, TempString: string;
begin
  CountItem := GenStrGrid.RowCount;

  MyList        := TStringList.Create;
  MyList.Sorted := False;
  try
    for I := 1 to (CountItem - 1) do
      MyList.Add(GenStrGrid.Rows[I].Strings[ThatCol] + TheSeparator +
        GenStrGrid.Rows[I].Text);

    Mylist.Sort;

    for K := 1 to Mylist.Count do
    begin
      MyString := MyList.Strings[(K - 1)];
      ThePosition := Pos(TheSeparator, MyString);
      TempString  := '';
      TempString := Copy(MyString, (ThePosition + 1), Length(MyString));
      MyList.Strings[(K - 1)] := '';
      MyList.Strings[(K - 1)] := TempString;
    end;

    for J := 1 to (CountItem - 1) do
      GenStrGrid.Rows[J].Text := IntToStr(J) + '.' + Copy(MyList.Strings[(J - 1)],Pos('.',MyList.Strings[(J - 1)])+1,200);
  finally
    MyList.Free;
  end;
end;

procedure TfrmTextureBase.sgDepoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ACol, ARow: Integer;
begin
  if sgDepo <> nil then
  begin
    sgDepo.MouseToCell(X, Y, ACol, ARow);

    if ARow <= sgDepo.FixedRows-1 then
    begin
      SortColumn := ACol;
      SortStringGrid(sgDepo,ACol);
    end;

    miCopy.Visible := ARow > 0;

    if ARow > 0 then
      Cell := sgDepo.Cells[ACol,ARow];
  end;
end;

procedure TfrmTextureBase.sgModelsClick(Sender: TObject);
var
  i, y : Integer;
begin
  sgDepo.RowCount := 1;
  for i := 0 to Data.Textures.Count-1 do
    for y := 0 to Data.Textures[i].Models.Count-1 do
    begin
      if CheckFilters(Data.Textures[i],y) then
        if SameText(Data.Textures[i].Models[y].Mini,sgModels.Cells[1,sgModels.Row]) then
        begin
          sgDepo.RowCount := sgDepo.RowCount + 1;
          sgDepo.Cells[0,sgDepo.RowCount-1] := IntToStr(sgDepo.RowCount-1) + '.';
          sgDepo.Cells[1,sgDepo.RowCount-1] := Data.Textures[i].Plik;

          if FileExists(Util.DIR + '\textures\mini\' + Data.Textures[i].Models[y].MiniD + '.bmp') then
            sgDepo.Cells[2,sgDepo.RowCount-1] := Data.Textures[i].Models[y].MiniD
          else
            if FileExists(Util.DIR + '\textures\mini\' + Data.Textures[i].Models[y].Mini + '.bmp') then
              sgDepo.Cells[2,sgDepo.RowCount-1] := Data.Textures[i].Models[y].Mini;

          sgDepo.Cells[4,sgDepo.RowCount-1] := Data.Textures[i].Models[y].Model;
          sgDepo.Cells[5,sgDepo.RowCount-1] := Data.Textures[i].Owner;
          sgDepo.Cells[6,sgDepo.RowCount-1] := Data.Textures[i].Station;
          sgDepo.Cells[7,sgDepo.RowCount-1] := Data.Textures[i].Revision;
          sgDepo.Cells[8,sgDepo.RowCount-1] := Data.Textures[i].Author;
          sgDepo.Cells[9,sgDepo.RowCount-1] := Data.Textures[i].Photos;
        end;
    end;
  if sgDepo.RowCount > 1 then
    sgDepo.FixedRows := 1;

  SortStringGrid(sgDepo,SortColumn);
end;

end.
