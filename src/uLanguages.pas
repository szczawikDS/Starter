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

unit uLanguages;

interface

uses VCL.Forms;

type
  TLanguages = class
  private
    class procedure ChangeLabels(const Lang: string); static;
    //class procedure ChangeIniLanguage(const Lang: string); static;
    //class procedure SaveLanguage(Form:TForm;const Lang:string); static;
  public
    class function LoadLanguages:string;
    class procedure FillLangLabels; static;
    class procedure ChangeLanguage(Form:TForm;const Lang: string); overload;
    class procedure ChangeIniLanguage(const Lang: string);
  end;

implementation

uses System.SysUtils, uMain, System.Classes, StrUtils,
     VCL.StdCtrls, VCL.ActnList, VCL.ComCtrls, VCL.CheckLst, ExtCtrls, typinfo, uUtilities;

{ TLanguages }

class procedure TLanguages.FillLangLabels;
begin
  Util.LabelsArray[ 0,0] := 'LAB_CAR_NO';
  Util.LabelsArray[ 1,0] := 'LAB_AI_TRAIN';
  Util.LabelsArray[ 2,0] := 'LAB_KEY1';
  Util.LabelsArray[ 3,0] := 'LAB_KEY2';
  Util.LabelsArray[ 4,0] := 'LAB_KEY3';
  Util.LabelsArray[ 5,0] := 'LAB_KEY_DESC';
  Util.LabelsArray[ 6,0] := 'LAB_WRONG_CONNECTION';
  Util.LabelsArray[ 7,0] := 'LAB_TRAIN_NAME';
  Util.LabelsArray[ 8,0] := 'LAB_TRAIN_NAME_CHANGE';
  Util.LabelsArray[ 9,0] := 'LAB_FILE_NOT_FOUND';
  Util.LabelsArray[10,0] := 'LAB_SAVE_PRESET';
  Util.LabelsArray[11,0] := 'LAB_SET_PRESET_NAME';
  Util.LabelsArray[12,0] := 'LAB_RANDOM_TEX_EXCEPT';
  Util.LabelsArray[13,0] := 'LAB_LOAD_SETTINGS';
  Util.LabelsArray[14,0] := 'LAB_LOAD_SCENERIES';
  Util.LabelsArray[15,0] := 'CAP_START_NO_EXE';
  Util.LabelsArray[16,0] := 'CAP_START_NO_SCN';
  Util.LabelsArray[17,0] := 'CAP_START_GO_SEL_TRAIN';
  Util.LabelsArray[18,0] := 'CAP_START_SEL_TRAIN';
  Util.LabelsArray[19,0] := 'CAP_START_SEL_VEHICLE';
  Util.LabelsArray[20,0] := 'CAP_START_NO_STAFF';
  Util.LabelsArray[21,0] := 'CAP_NO_VEHICLES';
  Util.LabelsArray[22,0] := 'LOG_NOT_FOUND_EXE_1';
  Util.LabelsArray[23,0] := 'LOG_NOT_FOUND_EXE_2';
  Util.LabelsArray[24,0] := 'LOG_INTERNAL_ERROR';
  Util.LabelsArray[25,0] := 'LOG_DEPO_LOAD_EXCEPT';
  Util.LabelsArray[26,0] := 'LOG_SCN_MINI_LOAD_FAULT';
  Util.LabelsArray[27,0] := 'LOG_TEX_NO_FILE';
  Util.LabelsArray[28,0] := 'LOG_TEX_NO_MODEL';
  Util.LabelsArray[29,0] := 'LOG_TEX_NO_PHYSICS';
  Util.LabelsArray[30,0] := 'LOG_TEX_NO_MULTIMEDIA';
  Util.LabelsArray[31,0] := 'LOG_CHECK_VALUE_FAULT';
  Util.LabelsArray[32,0] := 'LOG_CHECK_PHYSICS_FILE';
  Util.LabelsArray[33,0] := 'LOG_UNSUPPORTED_LOAD';
  Util.LabelsArray[34,0] := 'LOG_DEPO_PARSE_FAULT';
  Util.LabelsArray[35,0] := 'LOG_DEPO_SAVE_FAULT';
  Util.LabelsArray[36,0] := 'LOG_PHYSICS_PARSE_FAULT';
  Util.LabelsArray[37,0] := 'CAP_LOAD_SETTINGS_FAULT';
  Util.LabelsArray[38,0] := 'CAP_PARAMETER';
  Util.LabelsArray[39,0] := 'CAP_INVALID_VALUE';
  Util.LabelsArray[40,0] := 'CAP_FAULT_DETAIL';
  Util.LabelsArray[41,0] := 'CAP_ALGORITHM_FAULT';
  Util.LabelsArray[42,0] := 'CAP_SET_CHANGED';
  Util.LabelsArray[43,0] := 'CAP_FILE_NOT_FOUND';
  Util.LabelsArray[44,0] := 'CAP_LOAD_MINI_FAULT';
  Util.LabelsArray[45,0] := 'CAP_REMOVE_OLD_VER_FAULT';
  Util.LabelsArray[46,0] := 'CAP_YES';
  Util.LabelsArray[47,0] := 'CAP_NO';
  Util.LabelsArray[48,0] := 'CAP_NO_DIR';
  Util.LabelsArray[49,0] := 'CAP_NO_WEIGHTS';
  Util.LabelsArray[50,0] := 'CAP_NO_SCN';
  Util.LabelsArray[51,0] := 'CAP_NO_VEHICLES_2';
  Util.LabelsArray[52,0] := 'CAP_NO_PHYSICS';
  Util.LabelsArray[53,0] := 'CAP_NO_EXE';
  Util.LabelsArray[54,0] := 'CAP_ERRORS';
  Util.LabelsArray[55,0] := 'CAP_PROGRAM_FILES';
  Util.LabelsArray[56,0] := 'CAP_CREATE_FILE_FAULT';
  Util.LabelsArray[57,0] := 'CAP_LOGO_FAULT';
  Util.LabelsArray[58,0] := 'CAP_CURRENT_VERSION';
  Util.LabelsArray[59,0] := 'CAP_NEWER_VERSION_ASK';
  Util.LabelsArray[60,0] := 'CAP_UPDATE_FAULT';
  Util.LabelsArray[61,0] := 'CAP_UPDATE_FAULT_EXT';
  Util.LabelsArray[62,0] := 'CAP_UPDATED_PROGRAM';
  Util.LabelsArray[63,0] := 'CAP_UPDATING';
  Util.LabelsArray[64,0] := 'CAP_OPERATION_FAULT';
  Util.LabelsArray[65,0] := 'CAP_REMOVE_ALL_VEHICLES';
  Util.LabelsArray[66,0] := 'CAP_LOADING_DEPOT';
  Util.LabelsArray[67,0] := 'CAP_LOADING_PHYSICS';
  Util.LabelsArray[68,0] := 'CAP_LOADING_SCN';
  Util.LabelsArray[69,0] := 'CAP_LOADING_WEIGHTS';

  Util.LabelsArray[70,0] := 'LOG_PHYSICS_PARSE_FAULT';
  Util.LabelsArray[71,0] := 'LOG_PHYSICS_PARSE_FAULT';
  Util.LabelsArray[72,0] := 'LOG_PHYSICS_PARSE_FAULT';
  Util.LabelsArray[73,0] := 'LOG_PHYSICS_PARSE_FAULT';
  Util.LabelsArray[74,0] := 'LOG_PHYSICS_PARSE_FAULT';
  Util.LabelsArray[75,0] := 'LOG_PHYSICS_PARSE_FAULT';
end;

class procedure TLanguages.ChangeLabels(const Lang:string);
var
  LangFile : TStringList;
  i, y : Integer;
  s : string;
begin
  if FileExists(Util.DIR + 'starter\lang-' + Lang + '.txt') then
  begin
    LangFile := TStringList.Create;
    LangFile.LoadFromFile(Util.DIR + 'starter\lang-' + Lang + '.txt');

    i := 0;
    while (Pos('[labels]',LangFile[i]) = 0) and (i < LangFile.Count-1) do
        Inc(i);

    if Pos('[labels]',LangFile[i]) > 0 then
    begin
      Inc(i);

      while (Pos('=',LangFile[i]) > 0) and (i < LangFile.Count-1) do
      begin
        s := Copy(LangFile[i],0,Pos('=',LangFile[i])-1);

        y := 0;
        while (Pos(s,Util.LabelsArray[y,0]) = 0) and (Pos('=',LangFile[i]) > 0) do
          Inc(y);

        if (Pos(s,Util.LabelsArray[y,0]) > 0) then
          Util.LabelsArray[y,1] := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);

        Inc(i);
      end;

    end;
  end;
end;

class procedure TLanguages.ChangeLanguage(Form:TForm;const Lang: string);
var
  Comp : TComponent;
  LangFile : TStringList;
  Value, Prop : string;
  i : Integer;
begin
  ChangeLabels(Lang);

  if FileExists(Util.DIR + 'starter\lang-' + Lang + '.txt') then
  begin
    LangFile := TStringList.Create;
    LangFile.LoadFromFile(Util.DIR + 'starter\lang-' + Lang + '.txt');

    i := 0;
    while (Pos('[' + Form.Name,LangFile[i]) = 0) and (i < LangFile.Count-1) do
        Inc(i);

    if Pos('[' + Form.Name,LangFile[i]) > 0 then
    begin
      Inc(i);
      Form.Caption := LangFile[i];
      Inc(i);

      while (i < LangFile.Count) and (Pos('=',LangFile[i]) > 0) do
      begin
        Comp := Form.FindComponent(Copy(LangFile[i],0,Pos('.',LangFile[i])-1));
        if Comp <> nil then
        begin
          Prop := Copy(LangFile[i],Pos('.',LangFile[i])+1,PosEx('=',LangFile[i],Pos('.',LangFile[i])+1) - Pos('.',LangFile[i])-1  );
          if Prop = 'Items.Text' then
          begin
            if Comp is TComboBox then
            begin
              Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
              (Comp as TComboBox).Items.Text := StringReplace(Value,'|',#13#10,[rfReplaceAll]);
            end
            else
            if Comp is TListBox then
            begin
              Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
              (Comp as TListBox).Items.Text := StringReplace(Value,'|',#13#10,[rfReplaceAll]);
            end
            else
            if Comp is TRadioGroup then
            begin
              Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
              (Comp as TRadioGroup).Items.Text := StringReplace(Value,'|',#13#10,[rfReplaceAll]);
            end
            else
            if Comp is TCheckListBox then
            begin
              Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
              (Comp as TCheckListBox).Items.Text := StringReplace(Value,'|',#13#10,[rfReplaceAll]);
            end
          end
          else
          begin
            Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
            SetStrProp(Comp,Prop,Value);
          end;
        end;
        //else
        //  Value := Copy(LangFile[i],0,Pos('.',LangFile[i])-1);
        Inc(i);
      end;
    end;
  end;
end;

class procedure TLanguages.ChangeIniLanguage(const Lang:string);
var
  LangFile : TStringList;
  Prop : string;
  i, y : Integer;
begin
  if FileExists(Util.DIR + 'starter\lang-' + Lang + '.txt') then
  begin
    LangFile := TStringList.Create;
    LangFile.LoadFromFile(Util.DIR + 'starter\lang-' + Lang + '.txt');

    i := 0;
    while (Pos('<' + 'eu07_input-keyboard.ini',LangFile[i]) = 0) and (i < LangFile.Count-1) do
        Inc(i);

    if Pos('<' + 'eu07_input-keyboard.ini',LangFile[i]) > 0 then
    begin
      Inc(i);

      while (i <= LangFile.Count-1) and (Pos('=',LangFile[i]) > 0) do
      begin
        Prop := Copy(LangFile[i],0,Pos('=',LangFile[i])-1);

        for y := 0 to Main.Settings.KeyParams.Count-1 do
          if Main.Settings.KeyParams[y].Name = Prop then
          begin
            Main.Settings.KeyParams[y].Desc := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
            Break;
          end;

        Inc(i);
      end;

    end;
  end;
end;

class function TLanguages.LoadLanguages:string;
var
  SR : TSearchRec;
  Count : Integer;
begin
  Result := '';

  Count := FindFirst(Util.DIR + '\starter\lang-*.txt',faDirectory,SR);
  while (Count = 0) do
  begin
    if FileExists(Util.DIR + '\starter\' + SR.Name) then
      Result := Result + '|' + Util.DIR + '\starter\' + SR.Name;
    Count := FindNext(SR);
  end;
end;

{class procedure TLanguages.SaveLanguage(Form:TForm;const Lang:string);
var
  i : integer;
  sl : tstringlist;
begin
  sl := tstringlist.Create;

  for i := 0 to Form.ComponentCount-1 do
  begin
    if Form.Components[i] is TLabel then
    begin
      sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TLabel).Caption);
      if (Form.Components[i] as TLabel).Hint.Length > 0 then
        sl.Add( Form.Components[i].Name + '.Hint=' + (Form.Components[i] as TLabel).Hint);
    end;
    if Form.Components[i] is TAction then
    begin
      sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TAction).Caption);
      if (Form.Components[i] as TAction).Hint.Length > 0 then
        sl.Add( Form.Components[i].Name + '.Hint=' + (Form.Components[i] as TAction).Hint);
    end;
    if Form.Components[i] is TTabSheet then
    begin
      sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TTabSheet).Caption);
    end;
    if Form.Components[i] is TCheckBox then
    begin
      sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TCheckBox).Caption);
      if (Form.Components[i] as TCheckBox).Hint.Length > 0 then
        sl.Add( Form.Components[i].Name + '.Hint=' + (Form.Components[i] as TCheckBox).Hint);
    end;
    if Form.Components[i] is TComboBox then
    begin
      if (Form.Components[i] as TComboBox).Items.Count > 0 then
        sl.Add( Form.Components[i].Name + '.Items.Text=' + StringReplace((Form.Components[i] as TComboBox).Items.Text,#13#10,'|',[rfReplaceAll]));
    end;
    if Form.Components[i] is TCheckListBox then
    begin
      if (Form.Components[i] as TCheckListBox).Items.Count > 0 then
        sl.Add( Form.Components[i].Name + '.Items.Text=' + StringReplace((Form.Components[i] as TCheckListBox).Items.Text,#13#10,'|',[rfReplaceAll]));
    end;
    if Form.Components[i] is TRadioGroup then
    begin
      if (Form.Components[i] as TRadioGroup).Items.Count > 0 then
        sl.Add( Form.Components[i].Name + '.Items.Text=' + StringReplace((Form.Components[i] as TRadioGroup).Items.Text,#13#10,'|',[rfReplaceAll]));
    end;
    if Form.Components[i] is TPanel then
    begin
      if ((Form.Components[i] as TPanel).ShowCaption) and (Length((Form.Components[i] as TPanel).Caption)>0) then
      begin
        sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TPanel).Caption);
        if (Form.Components[i] as TPanel).Hint.Length > 0 then
          sl.Add( Form.Components[i].Name + '.Hint=' + (Form.Components[i] as TPanel).Hint);
      end;
    end;
    if Form.Components[i] is TListBox then
    begin
      if (Form.Components[i] as TListBox).Items.Count > 0 then
        sl.Add( Form.Components[i].Name + '.Items.Text=' + StringReplace((Form.Components[i] as TListBox).Items.Text,#13#10,'|',[rfReplaceAll]));
    end;
  end;

  sl.SaveToFile(DIR + '\starter\' + Lang + '.txt');
end;}

end.
