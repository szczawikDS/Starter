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

unit uSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uStructures, Vcl.ExtCtrls,
  Vcl.CheckLst, Vcl.ComCtrls;

type
  TfrmSearch = class(TForm)
    lbSearch: TLabel;
    edText: TEdit;
    lbExample: TLabel;
    lbList: TListBox;
    rgFilters: TRadioGroup;
    cbSearchType: TComboBox;
    Label1: TLabel;
    pnlDate: TPanel;
    dtRevEnd: TDateTimePicker;
    Label3: TLabel;
    dtRevStart: TDateTimePicker;
    Label2: TLabel;
    procedure edTextChange(Sender: TObject);
    procedure rgFiltersClick(Sender: TObject);
    procedure lbListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbListDblClick(Sender: TObject);
    procedure cbSearchTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    VehicleType : set of TTyp;
    procedure AddItem(const Tex: TTexture);
    function AdaptRevDate(RevStr: string): TDate;
  public
    { Public declarations }
  end;

implementation

uses uMain, uLanguages, uData, uUtilities;

{$R *.dfm}

procedure TfrmSearch.cbSearchTypeChange(Sender: TObject);
begin
  if cbSearchType.ItemIndex = 5 then
  begin
    pnlDate.Visible   := True;
    lbSearch.Visible  := False;
    edText.Visible    := False;
    lbExample.Visible := False;
  end
  else
  begin
    pnlDate.Visible   := False;
    lbSearch.Visible  := True;
    edText.Visible    := True;
    lbExample.Visible := True;
  end;

  edTextChange(self);
end;

function TfrmSearch.AdaptRevDate(RevStr:string):TDate;
var
  fs: TFormatSettings;
begin
  try
    Result := 0;
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

procedure TfrmSearch.edTextChange(Sender: TObject);
var
  i, y : Integer;
  Rev : TDate;
begin
  lbList.Items.BeginUpdate;
  lbList.Clear;
  if (Length(edText.Text) > 1) or (cbSearchType.ItemIndex = 5) then
  begin
    for i := 0 to Data.Textures.Count-1 do
      if (rgFilters.ItemIndex = 0) or (Data.Textures[i].Typ in VehicleType) then
        case cbSearchType.ItemIndex of
          0: if ContainsOmitAccents(Data.Textures[i].Plik,edText.Text) then
            AddItem(Data.Textures[i]);

          1: for y := 0 to Data.Textures[i].Models.Count-1 do
               if ContainsOmitAccents(Data.Textures[i].Models[y].MiniD,edText.Text) then
                 AddItem(Data.Textures[i]);

          2: if SameTextOmitAccents(Data.Textures[i].Owner,edText.Text) then
            AddItem(Data.Textures[i]);

          3: if ContainsOmitAccents(Data.Textures[i].Author,edText.Text) then
            AddItem(Data.Textures[i]);

          4: if ContainsOmitAccents(Data.Textures[i].Photos,edText.Text) then
            AddItem(Data.Textures[i]);

          5:begin
              Rev := AdaptRevDate(Data.Textures[i].Revision);
              if (Rev >= dtRevStart.Date) and (Rev <= dtRevEnd.Date) then
                AddItem(Data.Textures[i]);
            end;

          6: for y := 0 to Data.Textures[i].Models.Count-1 do
               if SameTextOmitAccents(Data.Textures[i].Models[y].Model,edText.Text) then
                 AddItem(Data.Textures[i]);

          7: for y := 0 to Data.Textures[i].Models.Count-1 do
               if Data.Textures[i].Models[y].Fiz <> nil then
                 if Pos(LowerCase(edText.Text),LowerCase(Data.Textures[i].Models[y].Fiz.LoadAccepted)) > 0 then
                   AddItem(Data.Textures[i]);

          8: if ContainsOmitAccents(Data.Textures[i].Station,edText.Text) then
               AddItem(Data.Textures[i]);
        end;
  end;

  lbList.Items.EndUpdate;
end;

procedure TfrmSearch.AddItem(const Tex:TTexture);
begin
  if Tex.Models[0].MiniD.Length > 0 then
    lbList.AddItem(Tex.Plik + ' [' + Tex.Models[0].MiniD + ']',Tex)
  else
    lbList.AddItem(Tex.Plik,Tex);
end;

procedure TfrmSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(self);
end;

procedure TfrmSearch.FormCreate(Sender: TObject);
begin
  if Util.Lang <> 'pl' then
    TLanguages.ChangeLanguage(Self,Util.Lang);
  cbSearchType.ItemIndex := 0;
end;

procedure TfrmSearch.lbListClick(Sender: TObject);
begin
  if lbList.ItemIndex >= 0 then
    Main.SelectTexture(TTexture(lbList.Items.Objects[lbList.ItemIndex]));
end;

procedure TfrmSearch.lbListDblClick(Sender: TObject);
begin
  Main.lbTexturesDblClick(self);
end;

procedure TfrmSearch.rgFiltersClick(Sender: TObject);
begin
  case rgFilters.ItemIndex of
    0: VehicleType := [];
    1: VehicleType := [tyELEKTROWOZ];
    2: VehicleType := [tySPALINOWOZ];
    3: VehicleType := [tyEZT];
    4: VehicleType := [tyA,tyB,tyD,tyE,tyF,tyG,tyH,tyL,tyP,tyR,tyS,tyU,tyV,tyW,tyX,tyZ];
  end;
  edTextChange(self);
end;

end.
