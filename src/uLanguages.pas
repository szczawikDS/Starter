unit uLanguages;

interface

type

  TLanguages = class
  private
    //class procedure SaveLanguage; static;
  public
    class function LoadLanguages:string;
    class procedure ChangeLanguage(const Lang:string);
  end;

implementation

uses System.SysUtils, uMain, System.Classes,
     VCL.StdCtrls, VCL.ActnList, VCL.ComCtrls, VCL.CheckLst;

{ TLanguages }

class procedure TLanguages.ChangeLanguage(const Lang: string);
var
  LangFile : TStringList;
  i, s : Integer;
  Value : string;
  Component : TComponent;
begin
  if FileExists(Main.DIR + '\starter\lang-' + Lang + '.txt') then
  begin
    LangFile := TStringList.Create;
    LangFile.LoadFromFile(Main.DIR + '\starter\lang-' + Lang + '.txt');

    s := -1;
    i := 0;
    while i < LangFile.Count-1 do
    begin
      if Pos('[/',LangFile[i]) > 0 then
        s := -1
      else
      begin
        Component := Main.FindComponent(Copy(LangFile[i],0,Pos('=',LangFile[i])-1));
        Value := Copy(LangFile[i],Pos('=',LangFile[i])+1,LangFile[i].Length);
      end;

      if (s >= 0) and (Component <> nil) then
      begin
        if s = 0 then
          (Component as TLabel).Caption := Value
        else
        if s = 1 then
          (Component as TAction).Caption := Value
        else
        if s = 2 then
          (Component as TTabSheet).Caption := Value
        else
        if s = 3 then
          (Component as TCheckBox).Caption := Value
        else
        if s = 4 then
        begin
          (Component as TComboBox).Items.BeginUpdate;
          (Component as TComboBox).Clear;
          ExtractStrings(['|'],[],PChar(Value),(Component as TComboBox).Items);
          (Component as TComboBox).Items.EndUpdate;
        end
        else
        if s = 5 then
        begin
          (Component as TCheckListBox).Items.BeginUpdate;
          (Component as TCheckListBox).Clear;
          ExtractStrings(['|'],[],PChar(Value),(Component as TCheckListBox).Items);
          (Component as TCheckListBox).Items.EndUpdate;
        end;
      end;

      if LangFile[i] = '[labels]' then s := 0
      else
      if LangFile[i] = '[actions]' then s := 1
      else
      if LangFile[i] = '[tabs]' then s := 2
      else
      if LangFile[i] = '[checks]' then s := 3
      else
      if LangFile[i] = '[combos]' then s := 4
      else
      if LangFile[i] = '[checklists]' then s := 5;

      Inc(i);
    end;
    LangFile.Free;
  end;
end;

class function TLanguages.LoadLanguages:string;
var
  SR : TSearchRec;
  Count : Integer;
begin
  Result := '';

  Count := FindFirst(Main.DIR + '\starter\lang-*.txt',faDirectory,SR);
  while (Count = 0) do
  begin
    if FileExists(Main.DIR + '\starter\' + SR.Name) then
      Result := Result + '|' + Main.DIR + '\starter\' + SR.Name;
    Count := FindNext(SR);
  end;
end;

{class procedure TLanguages.SaveLanguage;
var
  LangFile : TStringList;
  i, y : Integer;
  str : string;
begin
  LangFile := TStringList.Create;
  LangFile.Add('[labels]');
  for i := 0 to Main.ComponentCount -1 do
  begin
    if Main.Components[i].ClassType = TLabel then
      LangFile.Add(Main.Components[i].Name + '=' + (Main.Components[i] as TLabel).Caption  );
  end;
  LangFile.Add('[/labels]');
  LangFile.Add('[actions]');
  for i := 0 to Main.ComponentCount -1 do
  begin
    if Main.Components[i].ClassType = TAction then
      LangFile.Add(Main.Components[i].Name + '=' + (Main.Components[i] as TAction).Caption);
  end;
  LangFile.Add('[/actions]');
  LangFile.Add('[tabs]');
  for i := 0 to Main.ComponentCount -1 do
  begin
    if Main.Components[i].ClassType = TTabSheet then
      LangFile.Add(Main.Components[i].Name + '=' + (Main.Components[i] as TTabSheet).Caption);
  end;
  LangFile.Add('[/tabs]');
  LangFile.Add('[checks]');
  for i := 0 to Main.ComponentCount -1 do
  begin
    if Main.Components[i].ClassType = TCheckBox then
      LangFile.Add(Main.Components[i].Name + '=' + (Main.Components[i] as TCheckBox).Caption);
  end;
  LangFile.Add('[/checks]');
  LangFile.Add('[combos]');
  for i := 0 to Main.ComponentCount -1 do
  begin
    if Main.Components[i].ClassType = TComboBox then
    begin
      str := Main.Components[i].Name + '=';
      for y := 0 to (Main.Components[i] as TComboBox).Items.Count-1 do
        str := str + '|' + (Main.Components[i] as TComboBox).Items[y];
      LangFile.Add(str);
    end;
  end;
  LangFile.Add('[/combo]');
  LangFile.Add('[checklists]');
  for i := 0 to Main.ComponentCount -1 do
  begin
    if Main.Components[i].ClassType = TCheckListBox then
    begin
      str := Main.Components[i].Name + '=';
      for y := 0 to (Main.Components[i] as TCheckListBox).Items.Count-1 do
        str := str + '|' + (Main.Components[i] as TCheckListBox).Items[y];
      LangFile.Add(str);
    end;
  end;
  LangFile.Add('[/checklists]');
  LangFile.SaveToFile(Main.DIR + '\starter\lang-pl.txt');
  LangFile.Free;
end;}

end.
