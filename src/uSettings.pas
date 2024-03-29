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

unit uSettings;

interface

uses CastaliaPasLex, CastaliaPasLexTypes, System.Generics.Collections, System.Generics.Defaults, Classes;

type
  TParam = class
    Name : string;
    Value: string;
    Desc : string;
  end;

  TKeyParam = class
    Name  : string;
    Desc  : string;
    Key   : string;
    Key2  : string;
    Key3  : string;
  end;

  TSettings = class
  private
    DebugLogTrack     : Boolean;
    DebugLogSpeed     : Boolean;
    SettingsAge       : TDateTime;
    //////////////////////////////

    Lexer : TmwPasLex;
    function GetParamName: string;
    function GetParamValue: string;
    procedure SetCheckState(const State: Boolean; const ParamIndex: Integer);
    procedure ResolutionList;
    procedure SaveOwnSettings;
    procedure LoadEXE;

    procedure AddParam(const Name: String;const Desc:string);
    procedure CheckParams;
    procedure RemoveParam(const Name: String);
  public
    Params : TObjectList<TParam>;
    KeyParams : TObjectList<TKeyParam>;

    UART : string;
    IgnoreIrrelevant  : Boolean;
    UTF8 : Boolean;

    procedure LoadPresets;
    procedure ReadOwnSettings(const FirstRun:boolean=False);
    procedure ReadSettings(const Path:string='');
    procedure ReadKeyboard;
    procedure SaveSettings(const Path:string='eu07.ini');
    procedure SaveKeyboardSettings;
    constructor Create;
    destructor Destroy; override;
    function FindKey(const Key:string):Integer;
    function FindParam(const Name: string): TParam;
    procedure FindParameter(const Name: string;const Desc:string='');
    procedure ChangeHDR(const Reinhard:Boolean=True);
    procedure CheckSettingsFile;
  end;

implementation

uses uMain, uSettingsAdv, WinTypes, uLanguages, SysUtils, Vcl.Forms,
     Dialogs, DateUtils, uUpdater, uUtilities, StdCtrls;

constructor TSettings.Create;
begin
  inherited;
  Params := TObjectList<TParam>.Create;
end;

destructor TSettings.Destroy;
begin
  inherited;
  SaveSettings;
  Params.Free;
end;

function TSettings.FindKey(const Key: string): Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to Main.cbKey.Items.Count-1 do
  begin
    if CompareText(Key,Main.cbKey.Items[i]) = 0 then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TSettings.FindParam(const Name:string):TParam;
var
  i : Integer;
begin
  Result := nil;
  for i := 0 to Params.Count-1 do
    if SameStr(Name,Params[i].Name) then
    begin
      Result := Params[i];
      Break;
    end;
end;

function TSettings.GetParamName:string;
begin
  Result := '';
  while not Lexer.IsSpace do
  begin
    Result := Result + Lexer.Token;
    Lexer.Next;
  end;
end;

function TSettings.GetParamValue:string;
begin
  Result := '';
  while (Lexer.TokenID <> ptSlashesComment) and (Lexer.TokenID <> ptCRLF) do
  begin
    Result := Result + Lexer.Token;
    Lexer.Next;
  end;
end;

procedure TSettings.LoadEXE;
var
  SR : TSearchRec;
  Ilosc : Integer;
begin
  Main.cbEXE.Items.BeginUpdate;
  Main.cbEXE.Clear;
  Ilosc := FindFirst(Util.DIR + 'eu07*.exe',faAnyFile,SR);
  while (Ilosc = 0) do
  begin
    if FileExists(Util.DIR + SR.Name) then
      Main.cbEXE.Items.Add(SR.Name);

    Ilosc := FindNext(SR);
  end;
  System.SysUtils.FindClose(SR);

  if Main.cbEXE.Items.Count > 0 then
    Main.cbEXE.Items.Add('Autom.');

  Main.cbEXE.Items.EndUpdate;
end;

procedure TSettings.ResolutionList;
var
  DM: TDevMode;
  FindResolution: Bool;
  i, y : Integer;
  Resolution : string;
begin
  Main.cbResolution.Items.BeginUpdate;

  i := 0;
  while EnumDisplaySettings(nil, i, DM) do
  begin
    Inc(i);

    if (DM.dmPelsWidth >= 800) and (DM.dmPelsHeight >= 600) then
    begin
      Resolution := Format('%d x %d', [DM.dmPelsWidth, DM.dmPelsHeight]);

      FindResolution := False;
      for y := 0 to Main.cbResolution.Items.Count-1 do
        if Resolution = Main.cbResolution.Items[y] then
        begin
          FindResolution := True;
          Break;
        end;

      if not FindResolution then
        Main.cbResolution.Items.Add(Format('%d x %d', [DM.dmPelsWidth, DM.dmPelsHeight]));
    end;
  end;

  Main.cbResolution.Items.EndUpdate;
end;

procedure TSettings.ReadKeyboard;
var
  Settings, Par : TStringList;
  KeyParam : TKeyParam;
  i : Integer;
begin
  KeyParams.Free;
  KeyParams := TObjectList<TKeyParam>.Create();

  Settings := TStringList.Create;

  if FileExists(Util.DIR + 'eu07_input-keyboard.ini') then
    Settings.LoadFromFile(Util.DIR + 'eu07_input-keyboard.ini');

  for i := 0 to Settings.Count-1 do
  begin
    Par := TStringList.Create;
    ExtractStrings([' '],[],PChar(Copy(Settings[i],0,Pos('//',Settings[i])-1)),Par);

    if Par.Count > 0 then
    begin
      KeyParam := TKeyParam.Create;
      KeyParam.Name := Par[0];
      KeyParam.Desc := Copy(Settings[i],Pos('//',Settings[i])+3,70);

      if Par.Count = 2 then
        KeyParam.Key := Par[1]
      else
      begin
        if (Par.Count > 3) then
        begin
          if (Par[1] <> 'shift') and (Par[1] <> 'ctrl') then
          begin
            KeyParam.Key := Par[1];
            KeyParam.Key2 := Par[3];
            KeyParam.Key3 := Par[2];
          end
          else
          begin
            KeyParam.Key := Par[3];
            KeyParam.Key2 := Par[1];
            KeyParam.Key3 := Par[2];
          end;
        end
        else
        begin
          if (Par[1] <> 'shift') and (Par[1] <> 'ctrl') then
          begin
            KeyParam.Key := Par[1];
            KeyParam.Key2 := Par[2];
          end
          else
          begin
            KeyParam.Key := Par[2];
            KeyParam.Key2 := Par[1];
          end;
        end;
      end;

      KeyParams.Add(KeyParam);
    end;

    Par.Free;
  end;
end;

procedure TSettings.LoadPresets;
var
  SR : TSearchRec;
  C : Integer;
begin
  Main.cbPreset.Items.BeginUpdate;
  Main.cbPreset.Items.Clear;
  C := FindFirst(Util.DIR + 'starter\#*.ini',faDirectory,SR);
  while (C = 0) do
  begin
    if (SR.Name <> '.') and (SR.Name <> '..') then
      Main.cbPreset.Items.Add(Copy(SR.Name,2,Length(SR.Name)-5));

    C := FindNext(SR);
  end;
  SysUtils.FindClose(SR);

  Main.cbPreset.Items.EndUpdate;

  if Main.cbPreset.Items.Count > 0 then
    Main.cbPreset.ItemIndex := 0;
end;

procedure TSettings.ReadSettings(const Path:string='');
var
  Token, ParWidth, ParHeight : string;
  Settings, Par : TStringList;
  Param : TParam;
  i, ValInt : Integer;
  Val : Double;
begin
  try
    Params.Free;
    Params := TObjectList<TParam>.Create();

    Settings := TStringList.Create;
    ResolutionList;

    if Path.IsEmpty then
    begin
      if FileExists(Util.DIR + 'eu07.ini') then
      begin
        Settings.LoadFromFile(Util.DIR + 'eu07.ini');
        SettingsAge := FileDateToDateTime(FileAge(Util.DIR + 'eu07.ini'));
      end
      else
        Main.actDefaultSettingsExecute(self);
    end
    else
      if FileExists(Util.DIR + 'eu07.ini') then
        Settings.LoadFromFile(Util.DIR + 'starter\' + Path + '.ini');

    Lexer := TmwPasLex.Create;

    Lexer.Origin := PChar(Settings.Text);
    Lexer.Init;

    Lexer.NextNoSpace;
    while Lexer.TokenID <> ptNull do
    begin
      Param := TParam.Create;

      if Lexer.TokenID = ptSlashesComment then
      begin
        Param.Desc := Lexer.Token;
      end
      else
      begin
        Param.Name := GetParamName;

        Lexer.NextNoSpace;
        Param.Value:= Trim(GetParamValue);

        if Pos('zmq.address',Param.Name) > 0 then
          Param.Value := Param.Value + Lexer.Token
        else
          if Lexer.TokenID = ptSlashesComment then Param.Desc := Lexer.Token;
      end;

      Lexer.NextNoSpace;
      Params.Add(Param);
    end;

     Settings.Free;
     Lexer.Free;

    for i := 0 to Params.Count-1 do
    begin
      if Params[i].Name = 'width' then ParWidth := Params[i].Value else
      if Params[i].Name = 'height' then ParHeight := Params[i].Value else
      if Params[i].Name = 'fullscreenwindowed' then
        Main.chFullScreenWindowed.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'fullscreen' then
        Main.chFullScreen.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'inactivepause' then
        Main.chInactivepause.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'pause' then
        Main.chPause.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'shadows' then
        Main.chShadows.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'vsync' then
        Main.chVsync.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'usevbo' then
        Main.chUsevbo.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'fullphysics' then
        Main.chFullphysics.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.resource.sweep' then
        Main.chGfxresourcesweep.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.resource.move' then
        Main.chGfxresourcemove.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'debugmode' then
        Main.chDebugmode.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'ai.trainman' then
        Main.chTrainMan.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'soundenabled' then
        Main.chSoundenabled.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'enabletraction' then
        Main.chEnabletraction.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'livetraction' then
        Main.chLivetraction.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'physicslog' then
        Main.chPhysicslog.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'multiplelogs' then
        Main.chMultiplelogs.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'input.gamepad' then
        Main.Chinputgamepad.Checked := Params[i].Value = 'no'
      else
      if Params[i].Name = 'gfx.postfx.motionblur.enabled' then
        Main.chMotionBlur.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.envmap.enabled' then
        Main.chEnvmap.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.smoke' then
        Main.chSmoke.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.extraeffects' then
        Main.chExtraEffects.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'scalespeculars' then
        frmSettingsAdv.chScaleSpeculars.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.shadowmap.enabled' then
        Main.chShadowMap.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'python.threadedupload' then
        Main.chPythonThreadedUpload.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'python.enabled' then
        Main.chPythonEnabled.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.skiprendering' then
        Main.chSkipRendering.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'crashdamage' then
        Main.chCrashDamage.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.postfx.chromaticaberration.enabled' then
        Main.chChromaticAberration.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.skippipeline' then
        Main.chSkipPipeline.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.angleplatform' then
        Main.chAngle.Checked := Params[i].Value = 'vulkan'
      else
      if Params[i].Name = 'compresstex' then
        frmSettingsAdv.chCompressTex.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.usegles' then
        frmSettingsAdv.chUseGLES.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'gfx.shadergamma' then
        frmSettingsAdv.chShaderGamma.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'python.mipmaps' then
        frmSettingsAdv.chMipmaps.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'debuglog' then
      begin
        if Params[i].Value = 'yes' then ValInt := 3 else
        if Params[i].Value = 'no' then ValInt := 0
        else
          TryStrToInt(Params[i].Value,ValInt);

        DebugLogTrack := False;
        DebugLogSpeed := False;
        Main.chDebuglog.Checked := False;
        Main.chDebugLogVis.Checked := False;
        if ValInt >= 8 then
        begin
          DebugLogSpeed := True;
          Dec(ValInt,8);
        end;
        if ValInt >= 4 then
        begin
          DebugLogTrack := True;
          Dec(ValInt,4);
        end;
        if ValInt >= 2 then
        begin
          Main.chDebugLogVis.Checked := True;
          Dec(ValInt,2);
        end;
        if ValInt >= 1 then
          Main.chDebuglog.Checked := True;
      end
      else
      if Params[i].Name = 'mousescale' then
      begin
        Par := TStringList.Create;
        ExtractStrings([' '],[],PChar(Params[i].Value),Par);
        Main.cbMouseScale.ItemIndex := 0;
        if Abs(StrToFloat(Par[0])) < 1.3 then
          Main.cbMouseScale.ItemIndex := 1
        else
        if Abs(StrToFloat(Par[0])) > 1.9 then
          Main.cbMouseScale.ItemIndex := 2;
        if Abs(StrToFloat(Par[0])) > 2.7 then
          Main.cbMouseScale.ItemIndex := 3;

        Main.chMouseInversionHorizontal.Checked := StrToFloat(Par[0]) < 0;
        Main.chMouseInversionVertical.Checked   := StrToFloat(Par[1]) < 0;

        Par.Free;
      end
      else
      if Params[i].Name = 'feedbackmode' then
      begin
        Main.cbFeedbackmode.ItemIndex := StrToInt(Params[i].Value);
        Main.pnlFeedbackport.Visible := Main.cbFeedbackmode.ItemIndex = 3;
        Main.actCOM.Visible := Main.cbFeedbackmode.ItemIndex = 5;
      end
      else
      if Params[i].Name = 'feedbackport' then Main.edFeedbackport.Text := Params[i].Value else
      if Params[i].Name = 'friction' then Main.edFriction.Text := Params[i].Value else
      if Params[i].Name = 'fieldofview' then Main.edFieldofview.Text := Params[i].Value else
      if Params[i].Name = 'fpslimit' then
      begin
        Main.seFPSLimit.Value := StrToInt(Params[i].Value);
        Main.chFPSLimiter.Checked := True;
      end
      else
      if Params[i].Name = 'sound.volume' then
        Main.tbSoundVolume.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'sound.volume.radio' then
        Main.tbRadioVolume.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'sound.volume.vehicle' then
        Main.tbVehiclesSounds.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'sound.volume.positional' then
        Main.tbPositionalsSounds.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'sound.volume.ambient' then
        Main.tbGlobalSounds.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'sound.volume.paused' then
        Main.tbVolumePaused.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'gfx.shadow.angle.min' then
        Main.tbShadowSize.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'brakestep' then
        Main.tbBrakeStep.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'brakespeed' then
        Main.tbBrakeSpeed.Position := Round(StrToFloat(Params[i].Value) * 10)
      else
      if Params[i].Name = 'gfx.reflections.framerate' then
      begin
        if StrToFloat(Params[i].Value) < 2 then Main.cbReflectionsFramerate.ItemIndex := 0;
        if StrToFloat(Params[i].Value) > 1 then Main.cbReflectionsFramerate.ItemIndex := 1;
        if StrToFloat(Params[i].Value) > 4 then Main.cbReflectionsFramerate.ItemIndex := 2;
        if StrToFloat(Params[i].Value) > 14 then Main.cbReflectionsFramerate.ItemIndex := 3;
        if StrToFloat(Params[i].Value) > 43 then Main.cbReflectionsFramerate.ItemIndex := 4;
      end
      else
      if Params[i].Name = 'gfx.shadows.cab.range' then
      begin
        Val := StrToFloat(Params[i].Value);
        if Val = 0 then Main.cbShadowsCabRange.ItemIndex := 0 else
        if Val > 0 then Main.cbShadowsCabRange.ItemIndex := 1;
        if Val > 15 then Main.cbShadowsCabRange.ItemIndex := 2;
        if Val > 25 then Main.cbShadowsCabRange.ItemIndex := 3;
        if Val > 40 then Main.cbShadowsCabRange.ItemIndex := 4;
        if Val > 80 then Main.cbShadowsCabRange.ItemIndex := 5;
      end
      else
      if Params[i].Name = 'gfxrenderer' then
      begin
        if Params[i].Value = 'full'   then Main.cbGfxrenderer.ItemIndex := 0 else
        if Params[i].Value = 'legacy' then Main.cbGfxrenderer.ItemIndex := 2 else
        if Params[i].Value = 'simple' then Main.cbGfxrenderer.ItemIndex := 3;
      end
      else
      if Params[i].Name = 'maxtexturesize' then
      begin
        case StrToInt(Params[i].Value) of
          512:    Main.cbMaxtexturesize.ItemIndex := 0;
          1024:   Main.cbMaxtexturesize.ItemIndex := 1;
          2048:   Main.cbMaxtexturesize.ItemIndex := 2;
          4096:   Main.cbMaxtexturesize.ItemIndex := 3;
          8192:   Main.cbMaxtexturesize.ItemIndex := 4;
          16384:  Main.cbMaxtexturesize.ItemIndex := 5;
        end;
      end
      else
      if Params[i].Name = 'maxcabtexturesize' then
      begin
        case StrToInt(Params[i].Value) of
          512:    Main.cbMaxcabtexturesize.ItemIndex := 1;
          1024:   Main.cbMaxcabtexturesize.ItemIndex := 2;
          2048:   Main.cbMaxcabtexturesize.ItemIndex := 3;
          4096:   Main.cbMaxcabtexturesize.ItemIndex := 4;
        end;
        if Main.cbMaxcabtexturesize.ItemIndex <= 0 then
          Main.cbMaxcabtexturesize.ItemIndex := 0;
      end
      else
      if Params[i].Name = 'gfx.reflections.fidelity' then
        Main.cbReflectionsFidelity.ItemIndex := StrToInt(Params[i].Value) else
      if Params[i].Name = 'multisampling' then Main.cbMultisampling.ItemIndex := StrToInt(Params[i].Value) else
      if Params[i].Name = 'gfx.smoke.fidelity' then Main.cbSmokeFidelity.ItemIndex := StrToInt(Params[i].Value)-1 else
      if Params[i].Name = 'convertmodels' then
        frmSettingsAdv.cbConvertmodels.Text := Params[i].Value
      else
      if Params[i].Name = 'anisotropicfiltering' then
      begin
        case StrToInt(Params[i].Value) of
          1:  Main.cbAnisotropicfiltering.ItemIndex := 0;
          2:  Main.cbAnisotropicfiltering.ItemIndex := 1;
          4:  Main.cbAnisotropicfiltering.ItemIndex := 2;
          8:  Main.cbAnisotropicfiltering.ItemIndex := 3;
          16: Main.cbAnisotropicfiltering.ItemIndex := 4;
        end;
      end
      else
      if Params[i].Name = 'pyscreenrendererpriority' then
      begin
        if Params[i].Value = 'normal' then Main.cbPyscreenrendererpriority.ItemIndex := 0
        else
        if Params[i].Value = 'lower' then Main.cbPyscreenrendererpriority.ItemIndex := 1
        else
        if Params[i].Value = 'lowest' then Main.cbPyscreenrendererpriority.ItemIndex := 2
        else
        if Params[i].Value = 'idle' then Main.cbPyscreenrendererpriority.ItemIndex := 3
        else
        if Params[i].Value = 'off' then Main.cbPyscreenrendererpriority.ItemIndex := 4;
      end
      else
      if Params[i].Name = 'gfx.drawrange.factor.max' then
        Main.cbDrawRange.ItemIndex := Round(StrToFloat(Params[i].Value))-1
      else
      if Params[i].Name = 'gfx.shadow.rank.cutoff' then
        Main.cbShadowRank.ItemIndex := Round(StrToFloat(Params[i].Value))-1
      else
      if Params[i].Name = 'gfx.framebuffer.fidelity' then
        Main.cbBuffer.ItemIndex := StrToInt(Params[i].Value)-1
      else
      if Params[i].Name = 'splinefidelity' then Main.cbSplinefidelity.ItemIndex := StrToInt(Params[i].Value)-1 else
      if Params[i].Name = 'lang' then
      begin
        if Main.cbLang.Items.IndexOf(UpperCase(Params[i].Value)) < 0 then
          Main.cbLang.Items.Add(UpperCase(Params[i].Value));

        Main.cbLang.ItemIndex := Main.cbLang.Items.IndexOf(UpperCase(Params[i].Value))
      end
      else
      if Params[i].Name = 'shadowtune' then
      begin
        Par := TStringList.Create;
        ExtractStrings([' '],[],PChar(Params[i].Value),Par);
        if Par.Count > 0 then
        begin
          if Par[0] = '1024' then Main.cbShadowMapSize.ItemIndex := 0
          else
          if Par[0] = '2048' then Main.cbShadowMapSize.ItemIndex := 1
          else
          if Par[0] = '4096' then Main.cbShadowMapSize.ItemIndex := 2
          else
          if Par[0] = '8192' then Main.cbShadowMapSize.ItemIndex := 3;

          if StrToInt(Par[2]) >= 400 then Main.cbShadowRange.ItemIndex := 4
          else
          if StrToInt(Par[2]) >= 250 then Main.cbShadowRange.ItemIndex := 3
          else
          if StrToInt(Par[2]) >= 150 then Main.cbShadowRange.ItemIndex := 2
          else
          if StrToInt(Par[2]) >= 50 then Main.cbShadowRange.ItemIndex := 1
          else
            Main.cbShadowRange.ItemIndex := 0;
        end
        else
        begin
          Main.cbShadowMapSize.ItemIndex := 1;
          Main.cbShadowRange.ItemIndex := 1
        end;

        Par.Free;
      end;
    end;
    Main.cbResolution.ItemIndex := Main.cbResolution.Items.IndexOf(ParWidth + ' x ' + ParHeight);
    if Main.cbResolution.ItemIndex = -1 then
      Main.cbResolution.ItemIndex := Main.cbResolution.Items.Count-1;

    if (Main.cbGfxrenderer.ItemIndex = 0) and (Main.chSkipPipeline.Checked) then
      Main.cbGfxrenderer.ItemIndex := 1;

    if Main.cbBuffer.ItemIndex = -1 then Main.cbBuffer.ItemIndex := 3;
  except
    on E: Exception do
    begin
      Token := 'B��d wczytywania ustawie� (plik eu07.ini).' + #13#10;

      if i < Params.Count-1 then
        Token := Token + 'Parametr: ' + Params[i].Name + #13#10
                       + 'B��dna warto��: ' + Params[i].Value + #13#10;
      Token := Token + 'Szczeg�y b��du:' + #13#10 + E.Message;

      ShowMessage(Token);
      Util.Log.Add(Token);
    end;
  end;
end;

procedure TSettings.SetCheckState(const State:Boolean; const ParamIndex:Integer);
begin
  if State then
    Params[ParamIndex].Value := 'yes'
  else
    Params[ParamIndex].Value := 'no';
end;

procedure TSettings.SaveOwnSettings;
var
  Settings : TStringList;
begin
  Settings := TStringList.Create;
  Settings.Add('lang=' + LowerCase(Main.cbLang.Text));

  if not Main.cbCloseApp.Checked then
    Settings.Add('AutoClosingApp=no');

  if Main.cbBigThumbnail.Checked then
    Settings.Add('MiniPic=yes');

  if not Main.chOnlyForDriving.Checked then
    Settings.Add('OnlyForDriving=no');

  if Main.chShowAI.Checked then
    Settings.Add('ShowAI=yes');

  if Main.chAutoExpandTree.Checked then
    Settings.Add('AutoExpandTree=yes');

  if Main.chHideArchival.Checked then
    Settings.Add('HideArchival=yes');

  if not Main.chHideArchivalVehicles.Checked then
    Settings.Add('HideArchivalVehicles=no');

  if Main.miSortByVehicleName.Checked then
    Settings.Add('SortByVehicleName=yes')
  else
    Settings.Add('SortByVehicleName=no');

  if frmSettingsAdv.chIgnoreIrrevelant.Checked then
    Settings.Add('IgnoreIrrevelant=yes');

  if Main.chLogExt.Checked then
    Settings.Add('LogExt=yes');

  if UART.Length > 0 then
    Settings.Add('UART=' + UART);

  if Main.cbEXE.ItemIndex >= 0 then
    Settings.Add('exe=' + Main.cbEXE.Items[Main.cbEXE.ItemIndex]);

  if Main.WindowState = wsMaximized then
    Settings.Add('WindowMaximized=yes');

  Settings.Add('Battery=' + Main.cbBattery.ItemIndex.ToString);
  Settings.Add('LastUpdate=' + IntToStr(Main.lbVersion.Tag));
  Settings.Add('UpdateInterval=' + Main.edUpdateInterval.Text);
  Settings.Add('HDR=' +  Main.cbHDR.ItemIndex.ToString);
  if Main.tvSCN.Selected <> nil then
    Settings.Add('InitSCN=' + Main.tvSCN.Selected.Text);

  if UTF8 then
    Settings.Add('utf8=yes');

  if ForceDirectories(Util.DIR + 'starter') then
    Settings.SaveToFile(Util.DIR + 'starter\starter.ini');
  Settings.Free;
end;

procedure TSettings.ReadOwnSettings(const FirstRun:boolean=False);
var
  Settings : TStringList;
  ParName, ParValue : string;
  i : Integer;
begin
  try
    LoadEXE;

    if FileExists(Util.DIR + 'starter\starter.ini') then
    begin
      Settings := TStringList.Create;
      Settings.LoadFromFile(Util.DIR + 'starter\starter.ini');
      for i := 0 to Settings.Count-1 do
      begin
        ParName := Copy(Settings[i],0,Pos('=',Settings[i])-1);
        ParValue := Copy(Settings[i],Pos('=',Settings[i])+1,Settings[i].Length);

        if SameText(ParName,'lang') then
        begin
          Util.Lang := ParValue;
          if not ((FirstRun) and (ParValue = 'pl')) then
            TLanguages.ChangeLanguage(Main,ParValue);
        end
        else if SameText(ParName,'AutoClosingApp') then
          Main.cbCloseApp.Checked := ParValue = 'yes'
        else if SameText(ParName,'MiniPic') then
          Main.cbBigThumbnail.Checked := ParValue = 'yes'
        else if SameText(ParName,'OnlyForDriving') then
          Main.chOnlyForDriving.Checked := ParValue = 'yes'
        else if SameText(ParName,'ShowAI') then
          Main.chShowAI.Checked := ParValue = 'yes'
        else if SameText(ParName,'AutoExpandTree') then
          Main.chAutoExpandTree.Checked := ParValue = 'yes'
        else if SameText(ParName,'HideArchival') then
          Main.chHideArchival.Checked := ParValue = 'yes'
        else if SameText(ParName,'HideArchivalVehicles') then
          Main.chHideArchivalVehicles.Checked := ParValue <> 'no'
        else if SameText(ParName,'UART') then
          UART := ParValue
        else if SameText(ParName,'SortByVehicleName') then
        begin
          Main.miSortByTrackName.Checked    := ParValue = 'no';
          Main.miSortByVehicleName.Checked  := ParValue = 'yes';
        end
        else if SameText(ParName,'exe') then
          Main.cbEXE.ItemIndex := Main.cbEXE.Items.IndexOf(ParValue)
        else if SameText(Parname,'Battery') then
          Main.cbBattery.ItemIndex := StrToInt(ParValue)
        else
        if SameText(ParName,'WindowMaximized') then
         begin
           if ParValue = 'yes' then Main.WindowState := wsMaximized;
         end
        else if SameText(ParName,'LastUpdate') then
          Main.lbVersion.Tag := StrToInt(ParValue)
        else if SameText(ParName,'UpdateInterval') then
          Main.edUpdateInterval.Value := StrToInt(ParValue)
        else if SameText(ParName,'InitSCN') then
          Util.InitSCN := ParValue
        else if SameText(ParName,'IgnoreIrrevelant') then
          IgnoreIrrelevant := ParValue = 'yes'
        else if SameText(ParName,'LogExt') then
          Main.chLogExt.Checked := ParValue = 'yes'
        else if SameText(ParName,'HDR') then
          Main.cbHDR.ItemIndex := StrToInt(ParValue);
      end;

      Settings.Free;
    end;

    if Main.lbVersion.Tag < DaysBetween(Now,0)- Abs(StrToInt(Main.edUpdateInterval.Text))+1 then
    begin
      if StrToInt(Main.edUpdateInterval.Text) >= 0 then
        TfrmUpdater.UpdateProgram(False,False)
      else
        TfrmUpdater.UpdateProgram(True,False);

      Main.lbVersion.Tag := DaysBetween(Now,0);
    end;

    if Main.cbEXE.ItemIndex < 0 then
      Main.cbEXE.ItemIndex := 0;
  except
    on E: Exception do
    begin
      ShowMessage('B��d wczytywania ustawie� (plik starter\starter.ini).' + #13#10
                                    + 'Szczeg�y b��du:' + #13#10 + E.Message);
      Util.Log.Add('B��d wczytywania ustawie� (plik starter\starter.ini).' + #13#10
                                    + 'Szczeg�y b��du:' + #13#10 + E.Message);
    end;
  end;
end;

procedure TSettings.AddParam(const Name:String;const Desc:string);
var
  Param : TParam;
begin
  Param := TParam.Create;
  Param.Name := Name;
  Param.Desc := Desc;
  Params.Add(Param);
end;

procedure TSettings.RemoveParam(const Name:String);
var
  i : Integer;
begin
  i := 0;
  while (Params[i].Name <> Name) and (i < Params.Count-1) do
    Inc(i);

  if Params[i].Name = Name then
    Params.Extract(Params[i]);
end;

procedure TSettings.FindParameter(const Name:string;const Desc:string='');
var
  i : Integer;
begin
  if Params.Count > 0 then
  begin
    i := 0;
    while (i < Params.Count-1) and (Name <> Params[i].Name) do
      Inc(i);

    if Name <> Params[i].Name then
      AddParam(Name,Desc);
  end
  else
    AddParam(Name,Desc);
end;

procedure TSettings.CheckParams;
var
  P : TParam;
begin
  FindParameter('width','(800) szeroko�� ekranu');
  FindParameter('height','(600) wysoko�� ekranu');
  FindParameter('fullscreenwindowed','(no) yes: automatyczna rozdzielczosc');
  FindParameter('fullscreen','(no) yes: tryb pe�noekranowy');
  FindParameter('inactivepause','(yes) zatrzymanie programu, je�li nie jest aktywnym oknem');
  FindParameter('pause','(no) yes: zatrzymanie symulacji zaraz po wczytaniu');
  FindParameter('shadows','(yes) renderowanie cieni');
  FindParameter('shadowtune','parametry shadowmapy (rozdzielczo��, nieu�ywany, promie� projekcji, nieu�ywany)');
  FindParameter('vsync','(no) ogranicznik klatek go 60 lub 30 fps zaleznie od wydajno�ci');
  FindParameter('usevbo','(yes) Tryb renderowania VBO lub DisplayList');
  FindParameter('gfxrenderer','(full/legacy/simple) pe�ny lub uproszczony tryb renderowania, mo�e poprawi� wydajno��');
  FindParameter('fullphysics','obliczanie fizyki ze zwi�kszon� dok�adno�ci�. wy��czenie mo�e spowodowa� dziwne zachowania');
  FindParameter('dynamiclights','(7) 1-7 ilo�� �wiate� OpenGL przydzielanych pojazdom w scenie; przy starych kartach graficznych zmiejszy� do 3');
  FindParameter('gfx.skippipeline','(no) Ustawia uproszczony tryb renderowania bezpo�rednio do backbuffera. Wy��cza prawid�ow� implementacj� HDR i wszystkie efekty takie jak motionblur. Ustawienia z kategorii framebuffer, format i postfx b�d� ignorowane.');
  FindParameter('gfx.shadowmap.enabled','(yes) renderowanie cieni w rendererze shaderowym');
  FindParameter('gfx.extraeffects','(yes) Dodatkowe efekty realizowane przez shadery (np. mapowanie paralaksy)');
  FindParameter('gfx.shadows.cab.range','Promie� zasi�gu �r�de� cieni z zewn�trz kabiny, w metrach. Wp�ywa odwrotnie proporcjonalnie na ostro�� cieni');
  FindParameter('gfx.envmap.enabled','(yes) Odbicia realizowane globaln� cubemap�');
  FindParameter('gfx.reflections.framerate','(1/300) Cz�stotliwo�� od�wie�ania odbi� otoczenia');
  FindParameter('gfx.postfx.motionblur.enabled','(yes) Rozmycie powodowane ruchem');
  FindParameter('gfx.smoke','(yes) Wy�wietlanie dymu');
  FindParameter('gfx.smoke.fidelity','(1) 1-4 Mno�nik ilo�ci cz�stek dymu');
  FindParameter('scalespeculars','skalowanie sk�adowej specular materia��w dla kompatybilno�ci ze starymi modelami');
  FindParameter('gfx.resource.sweep','usuwanie nieu�ywanych tekstur z opengl, zalecane wy��czenie gdy pami�� karty graficznej jest wystarczaj�ca');
  FindParameter('gfx.resource.move','tryb konserwacji pami�ci przy usuwaniu nieu�ywanych tekstur, mo�e powodowa� problemy na niekt�rych kartach');
  FindParameter('debugmode','(no) yes: wy��cza logik� rozmyt� s�u��c� do detekcji awarii, w��cza klawisze pomocnicze');
  FindParameter('ai.trainman','wirtualny manewrowy');
  FindParameter('soundenabled','(yes) no: wy��cza odgrywanie d�wi�k�w przestrzennych');
  FindParameter('enabletraction','(yes) no: wy��cza �amanie pantografu');
  FindParameter('livetraction','(yes) no: lokomotywy elektryczne b�d� mia�y zasilanie, je�li tylko podnios� pantografy');
  FindParameter('physicslog','(no) yes: w��cza zapisywanie parametr�w fizycznych dla wszystkich obsadzonych przez AI lub cz�owieka pojazd�w');
  FindParameter('debuglog','(3=yes) informacje o uruchamianiu i przebiegu dzia�ania symulacji: +1 - do pliku log.txt, +2 - wy�wietlanie w oknie, +4 - nazwy tor�w');
  FindParameter('multiplelogs','(no) zapisywanie log�w do katalogu /logs/ bez nadpisywania po ka�dym uruchomieniu symulacji');
  FindParameter('input.gamepad','(yes) no: ignorowanie sygna�u z gamepada, przydatne dla u�ytkownik�w PoKeys');
  FindParameter('mousescale','(3.2 0.5) czu�o�� myszy, mo�na dawa� ujemne dla odwr�cenia kierunku');
  FindParameter('feedbackmode','(1) 0 - wy��czone, 1 - za��czone sterowanie diodami klawiatury (Caps Lock - CA/SHP, Scroll Lock - jazda na oporach rozruchowych), 2 - (Caps - CA, Scroll -SHP), 3 - LPT, 4 - PoKeys55, 5 - COM');
  FindParameter('feedbackport','adres (dziesi�tnie) bazowy portu LPT dla feedbackmode 3 (zapalanie kontrolek wyj�ciami LPT)');
  FindParameter('friction','(1.0) mno�nik dla wsp�czynnika tarcia');
  FindParameter('fieldofview','(45) 15-75 k�t widzenia kamery w pionie');
  FindParameter('sound.volume','globalna g�o�no�� d�wi�k�w');
  FindParameter('sound.volume.vehicle','wzgledna glosnosc dzwiekow wydawanych przez pojazdy, gdzie X jest mnoznikiem w przedziale 0-1');
  FindParameter('sound.volume.positional','wzgledna glosnosc pozycjonowanych dzwiekow emitowanych przez eventy scenerii, gdzie X jest mnoznikiem w przedziale 0-1');
  FindParameter('sound.volume.ambient','wzgledna glosnosc dzwiekow globalnych (o ujemnym zakresie) emitowanych przez eventy scenerii, gdzie X jest mnoznikiem w przedziale 0-1');
  FindParameter('sound.volume.paused','stopien wyciszenia dzwieku przy zalaczonej pauzie');
  FindParameter('maxtexturesize','(16384) skalowanie zbyt du�ych tekstur do podanego rozmiaru');
  FindParameter('multisampling','(2) wyg�adzanie kraw�dzi (poprawia obraz, ale obni�a FPS): 0 - wy�aczone, 1 - dwukrotne, 2 - czterokrotne, 3 - o�miokrotne');
  FindParameter('convertmodels','(135) tworzenie plik�w modeli binarnych E3D z T3D: 0 - wy��czone, +1 - nowe Opacity, +2 - z optymalizacj�, +4 - z bananami, +128 - rozszerzony pod exe C++, niekompatybilny ze starymi');
  FindParameter('anisotropicfiltering','(8) 1-16 jako�� filtrowania anizotropowego tekstur');
  FindParameter('pyscreenrendererpriority','(normal, lower, lowest, idle) priorytet w�tku pythonowego renderera. Odci��a procesor zmniejszaj�c od�wie�anie ekran�w w lokomotywach.');
  FindParameter('splinefidelity','(1) 1-4 dodatkowy podzia� trajektorii na �ukach, zwi�kszaj�cy kr�g�o��');
  FindParameter('lang','(pl) j�zyk dla napis�w');
  FindParameter('python.threadedupload','(yes) wysylanie wygenerowanych obrazow ekranow przy uzyciu osobnego watku');
  FindParameter('python.enabled','(domyslnie yes) wylacza w ogole generowanie tekstur przy uzyciu pythona');
  FindParameter('gfx.skiprendering','(domyslnie no) wylacza w ogole wizualizacje symulacji, pozostawiajac jedynie ui');
  FindParameter('crashdamage','(domyslnie yes) w��cza uszkodzenia sprz�g�w i wykolejenia od zderze�');
  FindParameter('gfx.postfx.chromaticaberration.enabled','(domyslnie no) Efekt aberracji chromatycznej');
  FindParameter('compresstex','(yes) ��da od sterownika kompresji �adowanych tekstur tga');
  FindParameter('gfx.reflections.fidelity','(0) malowanie odbic. 1: +modele stat. 2:+modele stat. i pojazdy');
  FindParameter('python.mipmaps','(yes) Tworzenie mipmap dla tekstur generowanych skryptami pythona');
  FindParameter('gfx.usegles','');
  FindParameter('gfx.shadergamma','');
  FindParameter('gfx.drawrange.factor.max','');
  FindParameter('gfx.shadow.rank.cutoff','');
  FindParameter('gfx.shadow.angle.min','');
  FindParameter('brakestep','pr�dko�� przesuwania zaworu hamulca');

  if Main.cbMaxcabtexturesize.ItemIndex > 0 then
    FindParameter('maxcabtexturesize','skalowanie tekstur kabiny do podanego rozmiaru')
  else
    RemoveParam('maxcabtexturesize');

  if not Main.chAngle.Checked then
    RemoveParam('gfx.angleplatform')
  else
    FindParameter('gfx.angleplatform','');

  if Main.chFPSLimiter.Checked then
    FindParameter('fpslimit','ograniczenie fps')
  else
    RemoveParam('fpslimit');

  if frmSettingsAdv.chUseGLES.State = cbGrayed then
    RemoveParam('gfx.usegles');

  if frmSettingsAdv.chShaderGamma.State = cbGrayed then
    RemoveParam('gfx.shadergamma');

  if frmSettingsAdv.chMipmaps.State = cbGrayed then
    RemoveParam('python.mipmaps');

  if frmSettingsAdv.chUseGLES.State = cbGrayed then
    RemoveParam('gfx.usegles');

  if Main.cbBuffer.ItemIndex < 3 then
    FindParameter('gfx.framebuffer.fidelity')
  else
  begin // wlasne, usuwamy fidelity, uzytkownik moze sobie recznie wpisac framebuffer
    P := FindParam('gfx.framebuffer.fidelity');
    if P <> nil then
      Params.Remove(P);
  end;
end;

procedure TSettings.SaveSettings(const Path:string='eu07.ini');
var
  Settings, Par : TStringList;
  i, Value : Integer;
begin
  SaveOwnSettings;
  Settings := TStringList.Create;

  CheckParams;

  for i := 0 to Params.Count-1 do
  begin
    if Params[i].Name = 'width' then
    begin
      Par := TStringList.Create;
      ExtractStrings(['x'],[' '],PChar(Main.cbResolution.Items[Main.cbResolution.ItemIndex]),Par);
      if Par.Count > 0 then
        Params[i].Value := Par[0];
      Par.Free;
    end
    else
    if Params[i].Name = 'height' then
    begin
      Par := TStringList.Create;
      ExtractStrings(['x'],[' '],PChar(Main.cbResolution.Items[Main.cbResolution.ItemIndex]),Par);
      if Par.Count > 1 then
        Params[i].Value := Par[1];
      Par.Free;
    end
    else
    if Params[i].Name = 'fullscreenwindowed'            then SetCheckState(Main.chFullScreenWindowed.Checked,i) else
    if Params[i].Name = 'fullscreen'                    then SetCheckState(Main.chFullScreen.Checked,i) else
    if Params[i].Name = 'inactivepause'                 then SetCheckState(Main.chInactivepause.Checked,i) else
    if Params[i].Name = 'pause'                         then SetCheckState(Main.chPause.Checked,i) else
    if Params[i].Name = 'shadows'                       then SetCheckState(Main.chShadows.Checked,i) else
    if Params[i].Name = 'vsync'                         then SetCheckState(Main.chVsync.Checked,i) else
    if Params[i].Name = 'usevbo'                        then SetCheckState(Main.chUsevbo.Checked,i) else
    if Params[i].Name = 'fullphysics'                   then SetCheckState(Main.chFullphysics.Checked,i) else
    if Params[i].Name = 'gfx.resource.sweep'            then SetCheckState(Main.chGfxresourcesweep.Checked,i) else
    if Params[i].Name = 'gfx.resource.move'             then SetCheckState(Main.chGfxresourcemove.Checked,i) else
    if Params[i].Name = 'debugmode'                     then SetCheckState(Main.chDebugmode.Checked,i) else
    if Params[i].Name = 'ai.trainman'                   then SetCheckState(Main.chTrainMan.Checked,i) else
    if Params[i].Name = 'soundenabled'                  then SetCheckState(Main.chSoundenabled.Checked,i) else
    if Params[i].Name = 'enabletraction'                then SetCheckState(Main.chEnabletraction.Checked,i) else
    if Params[i].Name = 'livetraction'                  then SetCheckState(Main.chLivetraction.Checked,i) else
    if Params[i].Name = 'physicslog'                    then SetCheckState(Main.chPhysicslog.Checked,i) else
    if Params[i].Name = 'multiplelogs'                  then SetCheckState(Main.chMultiplelogs.Checked,i) else
    if Params[i].Name = 'input.gamepad'                 then SetCheckState(not Main.chInputgamepad.Checked,i) else
    if Params[i].Name = 'gfx.postfx.motionblur.enabled' then SetCheckState(Main.chMotionBlur.Checked,i) else
    if Params[i].Name = 'gfx.envmap.enabled'            then SetCheckState(Main.chEnvmap.Checked,i) else
    if Params[i].Name = 'gfx.smoke'                     then SetCheckState(Main.chSmoke.Checked,i) else
    if Params[i].Name = 'gfx.extraeffects'              then SetCheckState(Main.chExtraEffects.Checked,i) else
    if Params[i].Name = 'scalespeculars'                then SetCheckState(frmSettingsAdv.chScaleSpeculars.Checked,i) else
    if Params[i].Name = 'gfx.shadowmap.enabled'         then SetCheckState(Main.chShadowMap.Checked,i) else
    if Params[i].Name = 'python.threadedupload'         then SetCheckState(Main.chPythonThreadedUpload.Checked,i) else
    if Params[i].Name = 'python.enabled'                then SetCheckState(Main.chPythonEnabled.Checked,i) else
    if Params[i].Name = 'gfx.skiprendering'             then SetCheckState(Main.chSkipRendering.Checked,i) else
    if Params[i].Name = 'crashdamage'                   then SetCheckState(Main.chCrashDamage.Checked,i) else
    if Params[i].Name = 'gfx.postfx.chromaticaberration.enabled'  then SetCheckState(Main.chChromaticAberration.Checked,i) else
    if Params[i].Name = 'gfx.skippipeline'              then SetCheckState(Main.chSkipPipeline.Checked,i) else
    if Params[i].Name = 'compresstex'                   then SetCheckState(frmSettingsAdv.chCompressTex.Checked,i) else
    if Params[i].Name = 'gfx.usegles'                   then SetCheckState(frmSettingsAdv.chUseGLES.Checked,i) else
    if Params[i].Name = 'gfx.shadergamma'               then SetCheckState(frmSettingsAdv.chShaderGamma.Checked,i) else
    if Params[i].Name = 'python.mipmaps'                then SetCheckState(frmSettingsAdv.chMipmaps.Checked,i) else
    if Params[i].Name = 'mousescale' then
    begin
      if Main.chMouseInversionHorizontal.Checked then
        Params[i].Value := '-'
      else
        Params[i].Value := '';

      case Main.cbMouseScale.ItemIndex of
        0: Params[i].Value := Params[i].Value + '1.5';
        1: Params[i].Value := Params[i].Value + '1.0';
        2: Params[i].Value := Params[i].Value + '2.3';
        3: Params[i].Value := Params[i].Value + '3.2';
      end;

      if Main.chMouseInversionVertical.Checked then
        Params[i].Value := Params[i].Value + ' -0.5'
      else
        Params[i].Value := Params[i].Value + ' 0.5';
    end
    else
    if Params[i].Name = 'feedbackmode'  then Params[i].Value := IntToStr(Main.cbFeedbackmode.ItemIndex) else
    if Params[i].Name = 'feedbackport'  then Params[i].Value := Main.edFeedbackport.Text else
    if Params[i].Name = 'friction'      then Params[i].Value := Main.edFriction.Text else
    if Params[i].Name = 'fieldofview'   then Params[i].Value := Main.edFieldofview.Text else
    if Params[i].Name = 'fpslimit'      then Params[i].Value := Main.seFPSLimit.Text else
    if Params[i].Name = 'gfxrenderer'  then
    begin
      case Main.cbGfxrenderer.ItemIndex of
        0..1: Params[i].Value := 'full';
        2: Params[i].Value := 'legacy';
        3: Params[i].Value := 'simple';
      end;
    end
    else
    if Params[i].Name = 'sound.volume'  then
      Params[i].Value := FloatToStr(Main.tbSoundVolume.Position / 10)
    else
    if Params[i].Name = 'sound.volume.radio' then
      Params[i].Value := FloatToStr(Main.tbRadioVolume.Position / 10)
    else
    if Params[i].Name = 'sound.volume.vehicle' then
      Params[i].Value := FloatToStr(Main.tbVehiclesSounds.Position / 10)
    else
    if Params[i].Name = 'sound.volume.positional' then
      Params[i].Value := FloatToStr(Main.tbPositionalsSounds.Position / 10)
    else
    if Params[i].Name = 'sound.volume.ambient' then
      Params[i].Value := FloatToStr(Main.tbGlobalSounds.Position / 10)
    else
    if Params[i].Name = 'sound.volume.paused' then
      Params[i].Value := FloatToStr(Main.tbVolumePaused.Position / 10)
    else
    if Params[i].Name = 'gfx.shadow.angle.min' then
      Params[i].Value := FloatToStr(Main.tbShadowSize.Position / 10)
    else
    if Params[i].Name = 'brakestep' then
      Params[i].Value := FloatToStr(Main.tbBrakeStep.Position / 10)
    else
    if Params[i].Name = 'brakespeed' then
      Params[i].Value := FloatToStr(Main.tbBrakeSpeed.Position / 10)
    else
    if Params[i].Name = 'maxtexturesize' then
    begin
      case Main.cbMaxtexturesize.ItemIndex of
        0: Params[i].Value := '512';
        1: Params[i].Value := '1024';
        2: Params[i].Value := '2048';
        3: Params[i].Value := '4096';
        4: Params[i].Value := '8192';
        5: Params[i].Value := '16384';
      end;
    end
    else
    if Params[i].Name = 'maxcabtexturesize' then
    begin
      case Main.cbMaxcabtexturesize.ItemIndex of
        1: Params[i].Value := '512';
        2: Params[i].Value := '1024';
        3: Params[i].Value := '2048';
        4: Params[i].Value := '4096';
      end;
    end
    else
    if Params[i].Name = 'multisampling' then Params[i].Value := IntToStr(Main.cbMultisampling.ItemIndex) else
    if Params[i].Name = 'convertmodels' then
      Params[i].Value := frmSettingsAdv.cbConvertmodels.Text
    else
    if Params[i].Name = 'gfx.smoke.fidelity' then Params[i].Value := IntToStr(Main.cbSmokeFidelity.ItemIndex+1)
    else
    if Params[i].Name = 'anisotropicfiltering' then
    begin
      case Main.cbAnisotropicfiltering.ItemIndex of
        0: Params[i].Value := '1';
        1: Params[i].Value := '2';
        2: Params[i].Value := '4';
        3: Params[i].Value := '8';
        4: Params[i].Value := '16';
      end;
    end
    else
    if Params[i].Name = 'pyscreenrendererpriority' then
    begin
      case Main.cbPyscreenrendererpriority.ItemIndex of
        0: Params[i].Value := 'normal';
        1: Params[i].Value := 'lower';
        2: Params[i].Value := 'lowest';
        3: Params[i].Value := 'idle';
        4: Params[i].Value := 'off';
      end;
    end
    else
    if Params[i].Name = 'gfx.shadows.cab.range' then
    begin
      case Main.cbShadowsCabRange.ItemIndex of
        0: Params[i].Value := '0';
        1: Params[i].Value := '10';
        2: Params[i].Value := '20';
        3: Params[i].Value := '30';
        4: Params[i].Value := '50';
        5: Params[i].Value := '100';
      end;
    end
    else
    if Params[i].Name = 'gfx.reflections.framerate' then
    begin
      case Main.cbReflectionsFramerate.ItemIndex of
        0: Params[i].Value := '1';
        1: Params[i].Value := '3';
        2: Params[i].Value := '10';
        3: Params[i].Value := '25';
        4: Params[i].Value := '60';
      end;
    end
    else
    if Params[i].Name = 'shadowtune' then
    begin
      case Main.cbShadowMapSize.ItemIndex of
        0: Params[i].Value := '1024';
        1: Params[i].Value := '2048';
        2: Params[i].Value := '4096';
        3: Params[i].Value := '8192';
      end;

      case Main.cbShadowRange.ItemIndex of
       -1: Params[i].Value := Params[i].Value + ' 250 400 300';
        0: Params[i].Value := Params[i].Value + ' 250 25 300';
        1: Params[i].Value := Params[i].Value + ' 250 50 300';
        2: Params[i].Value := Params[i].Value + ' 250 150 300';
        3: Params[i].Value := Params[i].Value + ' 250 250 300';
        4: Params[i].Value := Params[i].Value + ' 250 400 300';
      end;
    end
    else
    if Params[i].Name = 'gfx.angleplatform' then
    begin
      Params[i].Value := 'vulkan';
    end
    else
    if Params[i].Name = 'gfx.drawrange.factor.max' then
    begin
      Params[i].Value := IntToStr(Main.cbDrawRange.ItemIndex+1);
    end
    else
    if Params[i].Name = 'gfx.shadow.rank.cutoff' then
    begin
      Params[i].Value := IntToStr(Main.cbShadowRank.ItemIndex+1);
    end
    else
    if Params[i].Name = 'debuglog' then
    begin
      Value := 0;
      if DebugLogSpeed then Inc(Value,8);
      if DebugLogTrack then Inc(Value,4);
      if Main.chDebugLogVis.Checked then Inc(Value,2);
      if Main.chDebuglog.Checked then Inc(Value);
      Params[i].Value :=  IntToStr(Value);
    end
    else
    if Params[i].Name = 'gfx.reflections.fidelity' then Params[i].Value := IntToStr(Main.cbReflectionsFidelity.ItemIndex) else
    if Params[i].Name = 'splinefidelity' then Params[i].Value := IntToStr(Main.cbSplinefidelity.ItemIndex+1) else
    if Params[i].Name = 'lang' then Params[i].Value := LowerCase(Main.cbLang.Text) else
    if Params[i].Name = 'gfx.framebuffer.fidelity' then Params[i].Value := IntToStr(Main.cbBuffer.ItemIndex+1);

    if Pos('//',Params[i].Desc) > 0 then
    begin
      if (Params[i].Name.Length = 0) then
        Settings.Add(Params[i].Desc)
      else
      begin
        case Params[i].Name.Length + Trim(Params[i].Value).Length + 1 of
           0..7: Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) + #9#9#9#9#9#9 + Params[i].Desc);
          8..15: Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) +   #9#9#9#9#9 + Params[i].Desc);
         16..23: Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) +     #9#9#9#9 + Params[i].Desc);
         24..31: Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) +       #9#9#9 + Params[i].Desc);
         32..39: Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) +         #9#9 + Params[i].Desc);
         40..47: Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) +           #9 + Params[i].Desc);
         else Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) + ' ' + Params[i].Desc);
        end;
      end;
    end
    else
      if Params[i].Desc.IsEmpty then
        Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value))
      else
        Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) + #9#9 + '//' + Params[i].Desc);
  end;

  Settings.SaveToFile(Util.DIR + Path);

  if Path = 'eu07.ini' then
    SettingsAge := FileDateToDateTime(FileAge(Util.DIR + 'eu07.ini'));

  Settings.Free;
end;

procedure TSettings.SaveKeyboardSettings;
var
  i : Integer;
  Settings : TStringList;
begin
  Settings := TStringList.Create;

  for i := 0 to KeyParams.Count-1 do
    Settings.Add(KeyParams[i].Name + ' ' + ' ' + KeyParams[i].Key2 + ' ' + KeyParams[i].Key3 + ' ' + KeyParams[i].Key + ' // ' + KeyParams[i].Desc);

  Settings.SaveToFile(Util.DIR + 'eu07_input-keyboard.ini');
end;

procedure TSettings.ChangeHDR(const Reinhard:Boolean=True);
begin
  try
    if Reinhard then
      CopyFile(PChar(Util.Dir + 'starter\Reinhard.glsl'),PChar(Util.Dir + 'shaders\tonemapping.glsl'),False)
    else
      CopyFile(PChar(Util.Dir + 'starter\ACESFilm.glsl'),PChar(Util.Dir + 'shaders\tonemapping.glsl'),False);
  except
    on E: Exception do
      ShowMessage('Wyst�pi� b��d przy pr�bie zmiany algorytmu. Szczeg�y b��du: ' + E.Message);
  end;
end;

procedure TSettings.CheckSettingsFile;
var
  FileName   : string;
  FileDate   : Integer;
  LastChange : TDateTime;
begin
  FileName := Util.DIR + 'eu07.ini';
  FileDate := FileAge(FileName);

  if FileDate > 0 then
  begin
    LastChange := FileDateToDateTime(FileDate);

    if LastChange > SettingsAge then
      if Util.Ask('Wykryto zewn�trzne zmiany w ustawieniach symulatora. Czy wczyta� ustawienia ponownie?') then
        ReadSettings()
      else
        SettingsAge := LastChange;
  end;
end;

end.
