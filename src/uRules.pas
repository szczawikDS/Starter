{
  Starter
  Copyright (C) 2019 Damian Skrzek (szczawik)

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

unit uRules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, System.Generics.Collections;

type
  TfrmRules = class(TForm)
    lbRules: TListBox;
    Timer: TTimer;
    btnSave: TButton;
    AL: TActionList;
    actAdd: TAction;
    actSave: TAction;
    actButtonClick: TAction;
    pnlBottom: TPanel;
    cbTypes: TComboBox;
    cbModels: TComboBox;
    btnAdd: TButton;
    pnlButtons: TPanel;
    sbButtons: TScrollBox;
    procedure FormShow(Sender: TObject);
    procedure lbRulesClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure cbTypesChange(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actAddUpdate(Sender: TObject);
    procedure actButtonClickExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Rules : TList<TStringList>;
    RuleElement : string;
    procedure AddButon(const Name: string);
    procedure ClearButtons;
    procedure LoadButtons;
    procedure LoadFile(const FilePath: string);
    procedure RefreshList;
    procedure AddRule(RuleStr: string = '');
    procedure Buttons(const Rule: TStringList);
    procedure Delete(const RuleIndex:integer;const RuleElement: string);
    function NameIsInRule(const RuleIndex: Integer;
      const Name: string): Boolean;
    procedure RuleAddElement(const RuleIndex: Integer;
      const ElementName: string);
    procedure SaveRules;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRules: TfrmRules;

implementation

uses uUtilities, uData, uMain, uStructures, uLanguages;

{$R *.dfm}

procedure TfrmRules.FormCreate(Sender: TObject);
begin
  if Util.Lang <> 'pl' then
    TLanguages.ChangeLanguage(Self,Util.Lang);

  Rules := TList<TStringList>.Create;
end;

procedure TfrmRules.FormDestroy(Sender: TObject);
begin
  Rules.Free;
end;

procedure TfrmRules.AddRule(RuleStr : string = '');
var
  Rule : TStringList;
begin
  Rule        := TStringList.Create;
  Rule.Sorted := True;

  ExtractStrings([','],[],PChar(RuleStr),Rule);
  Rules.Add(Rule);
end;

procedure TfrmRules.LoadFile(const FilePath:string);
var
  RulesFile : TStringList;
  i : Integer;
begin
  if FileExists(FilePath) then
  begin
    RulesFile := TStringList.Create;
    RulesFile.LoadFromFile(FilePath);

    for i := 0 to RulesFile.Count-1 do
      AddRule(RulesFile[i]);

    AddRule;
  end;
end;

procedure TfrmRules.RefreshList;
var
  i, y, ItemIndex : Integer;
  Rule : string;
begin
  ItemIndex := lbRules.ItemIndex;

  lbRules.Items.BeginUpdate;
  lbRules.Items.Clear;

  for i := 0 to Rules.Count-1 do
  begin
    Rule := EmptyStr;

    for y := 0 to Rules[i].Count-1 do
      Rule := Rule + ' ' + Rules[i][y];

    lbRules.Items.Add(Rule);
  end;

  lbRules.Items.EndUpdate;

  if Rules.Count > ItemIndex then
    lbRules.ItemIndex := ItemIndex
  else
    lbRules.ItemIndex := 0;
end;

procedure TfrmRules.FormShow(Sender: TObject);
begin
  LoadFile(Util.DIR + 'starter\reguly.txt');
  RefreshList;

  cbTypes.Items   := Main.cbTypes.Items;
  cbModels.Items  := Main.cbModels.Items;

  if cbTypes.Items.Count > 0 then
    cbTypes.ItemIndex := 0;
end;

procedure TfrmRules.LoadButtons;
begin
  ClearButtons;

  if lbRules.ItemIndex >= 0 then
    Buttons(Rules[lbRules.ItemIndex])
end;

procedure TfrmRules.lbRulesClick(Sender: TObject);
begin
  LoadButtons;
end;

procedure TfrmRules.TimerTimer(Sender: TObject);
begin
  Delete(lbRules.ItemIndex,RuleElement);
  RefreshList;
  LoadButtons;

  Timer.Enabled := False;
end;

function TfrmRules.NameIsInRule(const RuleIndex:Integer;const Name:string):Boolean;
begin
  Result := Rules[RuleIndex].IndexOf(Name) >= 0;
end;

procedure TfrmRules.RuleAddElement(const RuleIndex:Integer;const ElementName:string);
begin
  Rules[RuleIndex].Add(ElementName);

  RefreshList;
  LoadButtons;
end;

procedure TfrmRules.actAddExecute(Sender: TObject);
begin
  if NameIsInRule(lbRules.ItemIndex,cbModels.Text) then
    ShowMessage('Taki pojazd jest ju¿ w tej regule.')
  else
    RuleAddElement(lbRules.ItemIndex,cbModels.Text);
end;

procedure TfrmRules.Buttons(const Rule:TStringList);
var
  i : Integer;
begin
  SendMessage(sbButtons.Handle, WM_SETREDRAW, 0, 0);

  try
    for i := 0 to Rule.Count-1 do
      AddButon(Rule[i]);
  finally
    SendMessage(sbButtons.Handle, WM_SETREDRAW, 1, 0);
    RedrawWindow(sbButtons.Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_FRAME or RDW_ALLCHILDREN);
  end;
end;

procedure TfrmRules.cbTypesChange(Sender: TObject);
var
  i, y : Integer;
  OrdType : Integer;
  slModels : TStringList;
begin
  slModels := TStringList.Create;
  try
    slModels.Sorted := True;
    slModels.Duplicates := dupIgnore;

    for i := 0 to Data.Textures.Count-1 do
    begin
      if (Main.chHideArchivalVehicles.Checked) and (Data.Textures[i].Archive) then Continue;
      OrdType := Ord(Data.Textures[i].Typ);

      if Data.Textures[i].Typ = tyOSOBA then
        slModels := slModels;

      if Data.Textures[i].Typ = tyZWIERZE then
        slModels := slModels;

      if OrdType = cbTypes.ItemIndex then
        if data.Textures[i].PrevTexID < 0 then
          for y := 0 to Data.Textures[i].Models.Count-1 do
            slModels.Add(Data.Textures[i].Models[y].Mini);
    end;

    cbModels.Items.BeginUpdate;
    cbModels.Items.Assign(slModels);
    cbModels.Items.EndUpdate;

    if cbModels.Items.Count > 0 then
      cbModels.ItemIndex := 0;

  finally
    slModels.Free;
  end;
end;

procedure TfrmRules.ClearButtons;
begin
  while sbButtons.ControlCount > 0 do
    sbButtons.Controls[0].Free;
end;

procedure TfrmRules.actAddUpdate(Sender: TObject);
begin
  actAdd.Enabled := (lbRules.ItemIndex >= 0) and (cbModels.ItemIndex >= 0);
end;

procedure TfrmRules.Delete(const RuleIndex:integer;const RuleElement:string);
var
  i : Integer;
begin
  i := 0;

  while i < Rules[RuleIndex].Count do
    if AnsiSameText(Rules[RuleIndex][i],RuleElement) then
    begin
      Rules[RuleIndex].Delete(i);

      if Rules[RuleIndex].Count = 0 then
        Rules.Remove(Rules[RuleIndex]);
    end
    else
      Inc(i);
end;

procedure TfrmRules.actButtonClickExecute(Sender: TObject);
begin
  if Util.Ask('Usun¹æ wybrany element regu³y?'{Util.LabelStr(CAP_SET_CHANGED)}) then
  begin
    RuleElement := ((Sender as TAction).ActionComponent as TButton).Caption;
    Timer.Enabled := True;
  end;
end;

procedure TfrmRules.SaveRules;
var
  i : Integer;
  RulesFile : TStringList;
begin
  RulesFile := TStringList.Create;

  for i := 0 to Rules.Count-1 do
    if Rules[i].Count > 0 then
    begin
      Rules[i].Delimiter := ',';
      RulesFile.Add(Rules[i].DelimitedText);
    end;

  RulesFile.SaveToFile(Util.DIR + 'starter\reguly.txt');
  RulesFile.Free;
end;

procedure TfrmRules.actSaveExecute(Sender: TObject);
begin
  if Util.Ask('Zapisaæ ustalone regu³y?'{Util.LabelStr(CAP_SET_CHANGED)}) then
    SaveRules;
end;

procedure TfrmRules.AddButon(const Name:string);
var
  Button : TButton;
begin
  Button                  := TButton.Create(sbButtons);
  Button.Parent           := sbButtons;
  Button.Align            := alLeft;
  Button.AlignWithMargins := True;
  Button.Action           := actButtonClick;
  Button.Caption          := UpperCase(Name);
  Button.Width            := Canvas.TextWidth(Button.Caption) + 10;

  if Button.Width < 50 then
    Button.Width          := 50;

  Button.Left             := Button.Width * sbButtons.ControlCount;
  Button.Name             := 'btn' + sbButtons.ControlCount.ToString;

  Button.OnClick          := actButtonClickExecute;
end;

end.
