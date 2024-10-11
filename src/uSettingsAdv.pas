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

unit uSettingsAdv;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls;

type
  TfrmSettingsAdv = class(TForm)
    pcAdv: TPageControl;
    tsSettings: TTabSheet;
    pnlMain: TPanel;
    pnlSettingsAdv: TPanel;
    chCompressTex: TCheckBox;
    chIgnoreIrrevelant: TCheckBox;
    chMipmaps: TCheckBox;
    chScaleSpeculars: TCheckBox;
    chShaderGamma: TCheckBox;
    chUseGLES: TCheckBox;
    pnlConvertModels: TPanel;
    lbe3d: TLabel;
    cbConvertmodels: TComboBox;
    pnlLegend: TPanel;
    lbLegend: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Timer: TTimer;
    tsTools: TTabSheet;
    btnRemoveAllTrains: TButton;
    AL: TActionList;
    actRemoveAllTrains: TAction;
    btnAddVehiclesCategory: TButton;
    actAddVehiclesCategory: TAction;
    btnAddVehiclesMMD: TButton;
    actAddVehiclesMMD: TAction;
    tsLog: TTabSheet;
    pnlLog: TPanel;
    lbLogCaption: TLabel;
    meLog: TMemo;
    btnClearLog: TButton;
    pnlSettings2: TPanel;
    chGfxresourcemove: TCheckBox;
    chGfxresourcesweep: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure actRemoveAllTrainsUpdate(Sender: TObject);
    procedure actAddVehiclesCategoryExecute(Sender: TObject);
    procedure actAddVehiclesCategoryUpdate(Sender: TObject);
    procedure actAddVehiclesMMDExecute(Sender: TObject);
    procedure actAddVehiclesMMDUpdate(Sender: TObject);
    procedure actRemoveAllTrainsExecute(Sender: TObject);
  public
      UTF8 : Boolean;
  private
    procedure RefreshLog;
  end;

var
  frmSettingsAdv: TfrmSettingsAdv;

implementation

uses uUtilities, uLanguages, uMain, uStructures;

{$R *.dfm}

procedure TfrmSettingsAdv.actAddVehiclesCategoryExecute(Sender: TObject);
var
  i : Integer;
begin
  try
    for i := 0 to Main.lbTextures.Count-1 do
    begin
      Main.lbTextures.ItemIndex := i;
      Main.AddVehicle(0,nil,False,False);
    end;
  except
    ShowMessage('Wyst¹pi³ b³¹d podczas operacji.');
  end;
end;

procedure TfrmSettingsAdv.actAddVehiclesCategoryUpdate(Sender: TObject);
begin
  actAddVehiclesCategory.Enabled := Main.Train <> nil;
end;

procedure TfrmSettingsAdv.actAddVehiclesMMDExecute(Sender: TObject);
var
  i, y, z : Integer;
  MMD : TStringList;
  Added : Boolean;
begin
  try
    MMD := TStringList.Create;
    try
      Main.lbTextures.ItemIndex := 0;
      for i := 0 to Main.lbTextures.Count-1 do
      begin
        Main.lbTextures.ItemIndex := i;

        for z := 0 to (Main.lbTextures.Items.Objects[Main.lbTextures.ItemIndex] as TTexture).Models.Count-1 do
        begin
          Added := False;
          for y := 0 to MMD.Count-1 do
            if (Main.lbTextures.Items.Objects[Main.lbTextures.ItemIndex] as TTexture).Models[z].Model = MMD[y] then
            begin
              Added := True;
              Break;
            end;

          if not Added then
          begin
            Main.AddVehicle(0,nil,False,False);
            MMD.Add((Main.lbTextures.Items.Objects[Main.lbTextures.ItemIndex] as TTexture).Models[z].Model);
          end;
        end;
      end;
    finally
      MMD.Free;
    end;
  except
    ShowMessage('Wyst¹pi³ b³¹d podczas operacji.');
  end;
end;

procedure TfrmSettingsAdv.actAddVehiclesMMDUpdate(Sender: TObject);
begin
  actRemoveAllTrains.Enabled := Main.Train <> nil;
end;

procedure TfrmSettingsAdv.actRemoveAllTrainsExecute(Sender: TObject);
begin
  if Util.Ask('Usun¹æ wszystkie pojazdy na scenerii?') then
    if not Main.RemoveAllTrains then
      ShowMessage('Wyst¹pi³ b³¹d podczas wykonywania operacji.');
end;

procedure TfrmSettingsAdv.actRemoveAllTrainsUpdate(Sender: TObject);
begin
  actRemoveAllTrains.Enabled := Main.Train <> nil;
end;

procedure TfrmSettingsAdv.btnClearLogClick(Sender: TObject);
begin
  Util.Log.Clear;
  Util.Log.Add('*');
  RefreshLog;
end;

procedure TfrmSettingsAdv.FormCreate(Sender: TObject);
begin
  if Util.Lang <> 'pl' then
    TLanguages.ChangeLanguage(Self,Util.Lang);
end;

procedure TfrmSettingsAdv.FormHide(Sender: TObject);
begin
  Timer.Enabled := False;
end;

procedure TfrmSettingsAdv.FormShow(Sender: TObject);
begin
  chIgnoreIrrevelant.Checked := Main.Settings.IgnoreIrrelevant;

  RefreshLog;
  Timer.Enabled := True;
end;

procedure TfrmSettingsAdv.TimerTimer(Sender: TObject);
begin
  RefreshLog;
end;

procedure TfrmSettingsAdv.RefreshLog;
begin
  if (Util.Log.Count <> meLog.Lines.Count) then
  begin
    meLog.Lines.BeginUpdate;
    meLog.Lines := Util.Log;
    meLog.Lines.EndUpdate;

    meLog.Perform(EM_LINESCROLL, 0, meLog.Lines.Count-1);
  end;
end;

end.
