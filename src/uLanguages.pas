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
    //class procedure SaveLanguage(Form:TForm;const Lang:string); static;
  public
    class function LoadLanguages:string;
    class procedure ChangeLanguage(Form:TForm;const Lang: string); overload;
  end;

implementation

uses System.SysUtils, uMain, System.Classes, StrUtils,
     VCL.StdCtrls, VCL.ActnList, VCL.ComCtrls, VCL.CheckLst, ExtCtrls, typinfo, uUtilities;

{ TLanguages }

class procedure TLanguages.ChangeLanguage(Form:TForm;const Lang: string);
var
  Comp : TComponent;
  LangFile : TStringList;
  Value, Prop : string;
  i : Integer;
begin
  if FileExists(Util.DIR + 'starter\lang-' + Lang + '.txt') then
  begin
    LangFile := TStringList.Create;
    LangFile.LoadFromFile(Util.DIR + 'starter\lang-' + Lang + '.txt');

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
            if Comp.ClassType = TComboBox then
            begin
              Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
              (Comp as TComboBox).Items.Text := StringReplace(Value,'|',#13#10,[rfReplaceAll]);
            end
            else
            if Comp.ClassType = TListBox then
            begin
              Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
              (Comp as TListBox).Items.Text := StringReplace(Value,'|',#13#10,[rfReplaceAll]);
            end
            else
            if Comp.ClassType = TRadioGroup then
            begin
              Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
              (Comp as TRadioGroup).Items.Text := StringReplace(Value,'|',#13#10,[rfReplaceAll]);
            end
            else
            if Comp.ClassType = TCheckListBox then
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
    if Form.Components[i].ClassType = TLabel then
    begin
      sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TLabel).Caption);
      if (Form.Components[i] as TLabel).Hint.Length > 0 then
        sl.Add( Form.Components[i].Name + '.Hint=' + (Form.Components[i] as TLabel).Hint);
    end;
    if Form.Components[i].ClassType = TAction then
    begin
      sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TAction).Caption);
      if (Form.Components[i] as TAction).Hint.Length > 0 then
        sl.Add( Form.Components[i].Name + '.Hint=' + (Form.Components[i] as TAction).Hint);
    end;
    if Form.Components[i].ClassType = TTabSheet then
    begin
      sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TTabSheet).Caption);
    end;
    if Form.Components[i].ClassType = TCheckBox then
    begin
      sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TCheckBox).Caption);
      if (Form.Components[i] as TCheckBox).Hint.Length > 0 then
        sl.Add( Form.Components[i].Name + '.Hint=' + (Form.Components[i] as TCheckBox).Hint);
    end;
    if Form.Components[i].ClassType = TComboBox then
    begin
      if (Form.Components[i] as TComboBox).Items.Count > 0 then
        sl.Add( Form.Components[i].Name + '.Items.Text=' + StringReplace((Form.Components[i] as TComboBox).Items.Text,#13#10,'|',[rfReplaceAll]));
    end;
    if Form.Components[i].ClassType = TCheckListBox then
    begin
      if (Form.Components[i] as TCheckListBox).Items.Count > 0 then
        sl.Add( Form.Components[i].Name + '.Items.Text=' + StringReplace((Form.Components[i] as TCheckListBox).Items.Text,#13#10,'|',[rfReplaceAll]));
    end;
    if Form.Components[i].ClassType = TRadioGroup then
    begin
      if (Form.Components[i] as TRadioGroup).Items.Count > 0 then
        sl.Add( Form.Components[i].Name + '.Items.Text=' + StringReplace((Form.Components[i] as TRadioGroup).Items.Text,#13#10,'|',[rfReplaceAll]));
    end;
    if Form.Components[i].ClassType = TPanel then
    begin
      if ((Form.Components[i] as TPanel).ShowCaption) and (Length((Form.Components[i] as TPanel).Caption)>0) then
      begin
        sl.Add( Form.Components[i].Name + '.Caption=' + (Form.Components[i] as TPanel).Caption);
        if (Form.Components[i] as TPanel).Hint.Length > 0 then
          sl.Add( Form.Components[i].Name + '.Hint=' + (Form.Components[i] as TPanel).Hint);
      end;
    end;
    if Form.Components[i].ClassType = TListBox then
    begin
      if (Form.Components[i] as TListBox).Items.Count > 0 then
        sl.Add( Form.Components[i].Name + '.Items.Text=' + StringReplace((Form.Components[i] as TListBox).Items.Text,#13#10,'|',[rfReplaceAll]));
    end;
  end;

  sl.SaveToFile(DIR + '\starter\' + Lang + '.txt');
end;}

end.
