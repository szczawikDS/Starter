unit uSettings;

interface

uses CastaliaPasLex, CastaliaPasLexTypes, System.Generics.Collections, System.Generics.Defaults;

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
    Lexer : TmwPasLex;
    function GetParamName: string;
    function GetParamValue: string;
    procedure SetCheckState(const State: Boolean; const ParamIndex: Integer);
    procedure ResolutionList;
    procedure SaveOwnSettings;
    procedure LoadEXE;
    procedure FindParameter(const Name: string;const Desc:string);
    procedure AddParam(const Name: String;const Desc:string);
    procedure CheckParams;
  public
    Params : TObjectList<TParam>;
    KeyParams : TObjectList<TKeyParam>;

    procedure ReadOwnSettings;
    procedure ReadSettings;
    procedure ReadKeyboard;
    procedure SaveSettings;
    procedure SaveKeyboardSettings;
    constructor Create;
    destructor Destroy; override;
    function FindKey(const Key:string):Integer;
    function FindParam(const Name: string): TParam;
  end;

implementation

uses uMain, Classes, WinTypes, ShellApi, uLanguages, SysUtils, Vcl.Forms, Dialogs;

constructor TSettings.Create;
begin
  Params := TObjectList<TParam>.Create;
end;

destructor TSettings.Destroy;
begin
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
  while (Lexer.TokenID <> ptSpace) and (Lexer.TokenID <> ptCRLF) do
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
  Ilosc := FindFirst(Main.DIR + '*.exe',faAnyFile,SR);
  while (Ilosc = 0) do
  begin
    if (SR.Name <> 'Starter.exe') and (SR.Name <> 'RAINSTED.exe') then
      if FileExists(Main.DIR + SR.Name) then
        Main.cbEXE.Items.Add(SR.Name);

    Ilosc := FindNext(SR);
  end;
  System.SysUtils.FindClose(SR);
  Main.cbEXE.Items.EndUpdate;
end;

procedure TSettings.ResolutionList;
var
  DM: TDevMode;
  FindResolution: Bool;
  i, y : Integer;
  Resolution : string;
begin
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

  if FileExists(Main.DIR + 'eu07_input-keyboard.ini') then
    Settings.LoadFromFile(Main.DIR + 'eu07_input-keyboard.ini');

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

procedure TSettings.ReadSettings;
var
  Token, ParWidth, ParHeight : string;
  Settings, Par : TStringList;
  Param : TParam;
  i : Integer;
  Val : Double;
begin
  try
    Params.Free;
    Params := TObjectList<TParam>.Create();

    Settings := TStringList.Create;
    ResolutionList;

    if FileExists(Main.DIR + 'eu07.ini') then
      Settings.LoadFromFile(Main.DIR + 'eu07.ini')
    else
      Main.actDefaultSettingsExecute(self);

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
      if Params[i].Name = 'soundenabled' then
        Main.chSoundenabled.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'enabletraction' then
        Main.chEnabletraction.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'livetraction' then
        Main.chLivetraction.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'loadtraction' then
        Main.chLoadtraction.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'physicslog' then
        Main.chPhysicslog.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'debuglog' then
        Main.chDebuglog.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'multiplelogs' then
        Main.chMultiplelogs.Checked := Params[i].Value = 'yes'
      else
      if Params[i].Name = 'input.gamepad' then
        Main.Chinputgamepad.Checked := Params[i].Value = 'yes'
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
        Main.chScaleSpeculars.Checked := Params[i].Value = 'yes'
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
      if Params[i].Name = 'mousescale' then
      begin
        Par := TStringList.Create;
        ExtractStrings([' '],[],PChar(Params[i].Value),Par);
        Main.cbMouseScale.ItemIndex := 0;
        if StrToFloat(Par[0]) < 1.3 then
          Main.cbMouseScale.ItemIndex := 1
        else
        if StrToFloat(Par[0]) > 1.9 then
          Main.cbMouseScale.ItemIndex := 2;
        if StrToFloat(Par[0]) > 2.7 then
          Main.cbMouseScale.ItemIndex := 3;
        Par.Free;
      end
      else
      if Params[i].Name = 'feedbackmode' then
      begin
        Main.cbFeedbackmode.ItemIndex := StrToInt(Params[i].Value);
        Main.edFeedbackport.Enabled := Main.cbFeedbackmode.ItemIndex = 3;
      end
      else
      if Params[i].Name = 'feedbackport' then Main.edFeedbackport.Text := Params[i].Value else
      if Params[i].Name = 'friction' then Main.edFriction.Text := Params[i].Value else
      if Params[i].Name = 'fieldofview' then Main.edFieldofview.Text := Params[i].Value else
      if Params[i].Name = 'sound.volume' then
      begin
        if StrToFloat(Params[i].Value) < 1.2 then Main.cbSoundvolume.ItemIndex := 1;
        if StrToFloat(Params[i].Value) < 1.8 then Main.cbSoundvolume.ItemIndex := 0;
        if StrToFloat(Params[i].Value) > 1.7 then Main.cbSoundvolume.ItemIndex := 2;
      end
      else
      if Params[i].Name = 'sound.volume.radio' then
      begin
        if StrToFloat(Params[i].Value) < 0.6 then Main.cbRadioVolume.ItemIndex := 1;
        if StrToFloat(Params[i].Value) > 0.5 then Main.cbRadioVolume.ItemIndex := 0;
        if StrToFloat(Params[i].Value) = 1.0 then Main.cbRadioVolume.ItemIndex := 2;
      end
      else
      if Params[i].Name = 'gfx.reflections.framerate' then
      begin
        if StrToFloat(Params[i].Value) < 2 then Main.cbReflectionsFramerate.ItemIndex := 0;
        if StrToFloat(Params[i].Value) > 1 then Main.cbReflectionsFramerate.ItemIndex := 1;
        if StrToFloat(Params[i].Value) > 4 then Main.cbReflectionsFramerate.ItemIndex := 2;
        if StrToFloat(Params[i].Value) > 14 then Main.cbReflectionsFramerate.ItemIndex := 3;
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
      if Params[i].Name = 'multisampling' then Main.cbMultisampling.ItemIndex := StrToInt(Params[i].Value) else
      if Params[i].Name = 'gfx.smoke.fidelity' then Main.cbSmokeFidelity.ItemIndex := StrToInt(Params[i].Value)-1 else  // round?
      if Params[i].Name = 'convertmodels' then Main.cbConvertmodels.ItemIndex := StrToInt(Params[i].Value) else
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
      if Params[i].Name = 'splinefidelity' then Main.cbSplinefidelity.ItemIndex := StrToInt(Params[i].Value)-1 else
      if Params[i].Name = 'lang' then
        Main.cbLang.ItemIndex := Main.cbLang.Items.IndexOf(UpperCase(Params[i].Value)) else
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

  except
    on E: Exception do ShowMessage('B³¹d wczytywania ustawieñ (plik eu07.ini).' + #13#10
                                    + 'Parametr: ' + Params[i].Name + #13#10
                                    + 'B³êdna wartoœæ: ' + Params[i].Value + #13#10
                                    + 'Szczegó³y b³êdu:' + #13#10 + E.Message);
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

  if Main.cbCloseApp.Checked then
    Settings.Add('AutoClosingApp=yes')
  else
    Settings.Add('AutoClosingApp=no');

  if Main.cbBigThumbnail.Checked then
    Settings.Add('MiniPic=yes')
  else
    Settings.Add('MiniPic=no');

  if Main.cbEXE.ItemIndex >= 0 then
    Settings.Add('exe=' + Main.cbEXE.Items[Main.cbEXE.ItemIndex]);

  if Main.WindowState = wsMaximized then
    Settings.Add('WindowMaximized=yes');

  if ForceDirectories(Main.DIR + '\starter') then
    Settings.SaveToFile(Main.DIR + '\starter\starter.ini');
  Settings.Free;
end;

procedure TSettings.ReadOwnSettings;
var
  Settings : TStringList;
  ParName, ParValue : string;
  i : Integer;
begin
  LoadEXE;

  if FileExists(Main.DIR + '\starter\starter.ini') then
  begin
    Settings := TStringList.Create;
    Settings.LoadFromFile(Main.DIR + '\starter\starter.ini');
    for i := 0 to Settings.Count-1 do
    begin
      ParName := Copy(Settings[i],0,Pos('=',Settings[i])-1);
      ParValue := Copy(Settings[i],Pos('=',Settings[i])+1,Settings[i].Length);

      if SameText(ParName,'lang') then
        TLanguages.ChangeLanguage(ParValue)
      else if SameText(ParName,'AutoClosingApp') then
        Main.cbCloseApp.Checked := ParValue = 'yes'
      else if SameText(ParName,'MiniPic') then
        Main.cbBigThumbnail.Checked := ParValue = 'yes'
      else if SameText(ParName,'exe') then
        Main.cbEXE.ItemIndex := Main.cbEXE.Items.IndexOf(ParValue)
      else if SameText(ParName,'WindowMaximized') then
        if ParValue = 'yes' then Main.WindowState := wsMaximized;
    end;

    Settings.Free;
  end;

  if Main.cbEXE.ItemIndex < 0 then
    Main.cbEXE.ItemIndex := 0;
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

procedure TSettings.FindParameter(const Name:string;const Desc:string);
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
begin
  FindParameter('width','(800) szerokoœæ ekranu');
  FindParameter('height','(600) wysokoœæ ekranu');
  FindParameter('fullscreen','(no) yes: tryb pe³noekranowy');
  FindParameter('inactivepause','(yes) zatrzymanie programu, jeœli nie jest aktywnym oknem');
  FindParameter('pause','(no) yes: zatrzymanie symulacji zaraz po wczytaniu');
  FindParameter('shadows','(yes) renderowanie cieni');
  FindParameter('shadowtune','parametry shadowmapy (rozdzielczoœæ, nieu¿ywany, promieñ projekcji, nieu¿ywany)');
  FindParameter('vsync','(no) ogranicznik klatek go 60 lub 30 fps zaleznie od wydajnoœci');
  FindParameter('usevbo','(yes) Tryb renderowania VBO lub DisplayList');
  FindParameter('gfxrenderer','(full/legacy/simple) pe³ny lub uproszczony tryb renderowania, mo¿e poprawiæ wydajnoœæ');
  FindParameter('fullphysics','obliczanie fizyki ze zwiêkszon¹ dok³adnoœci¹. wy³¹czenie mo¿e spowodowaæ dziwne zachowania');
  FindParameter('dynamiclights','(7) 1-7 iloœæ œwiate³ OpenGL przydzielanych pojazdom w scenie; przy starych kartach graficznych zmiejszyæ do 3');
  FindParameter('gfx.skippipeline','(no) Ustawia uproszczony tryb renderowania bezpoœrednio do backbuffera. Wy³¹cza prawid³ow¹ implementacjê HDR i wszystkie efekty takie jak motionblur. Ustawienia z kategorii framebuffer, format i postfx bêd¹ ignorowane.');
  FindParameter('gfx.shadowmap.enabled','(yes) renderowanie cieni w rendererze shaderowym');
  FindParameter('gfx.extraeffects','(yes) Dodatkowe efekty realizowane przez shadery (np. mapowanie paralaksy)');
  FindParameter('gfx.shadows.cab.range','Promieñ zasiêgu Ÿróde³ cieni z zewn¹trz kabiny, w metrach. Wp³ywa odwrotnie proporcjonalnie na ostroœæ cieni');
  FindParameter('gfx.envmap.enabled','(yes) Odbicia realizowane globaln¹ cubemap¹');
  FindParameter('gfx.reflections.framerate','(1/300) Czêstotliwoœæ odœwie¿ania odbiæ otoczenia');
  FindParameter('gfx.postfx.motionblur.enabled','(yes) Rozmycie powodowane ruchem');
  FindParameter('gfx.smoke','(yes) Wyœwietlanie dymu');
  FindParameter('gfx.smoke.fidelity','(1) 1-4 Mno¿nik iloœci cz¹stek dymu');
  FindParameter('scalespeculars','skalowanie sk³adowej specular materia³ów dla kompatybilnoœci ze starymi modelami');
  FindParameter('gfx.resource.sweep','usuwanie nieu¿ywanych tekstur z opengl, zalecane wy³¹czenie gdy pamiêæ karty graficznej jest wystarczaj¹ca');
  FindParameter('gfx.resource.move','tryb konserwacji pamiêci przy usuwaniu nieu¿ywanych tekstur, mo¿e powodowaæ problemy na niektórych kartach');
  FindParameter('debugmode','(no) yes: wy³¹cza logikê rozmyt¹ s³u¿¹c¹ do detekcji awarii, w³¹cza klawisze pomocnicze');
  FindParameter('soundenabled','(yes) no: wy³¹cza odgrywanie dŸwiêków przestrzennych');
  FindParameter('enabletraction','(yes) no: wy³¹cza ³amanie pantografu');
  FindParameter('livetraction','(yes) no: lokomotywy elektryczne bêd¹ mia³y zasilanie, jeœli tylko podnios¹ pantografy');
  FindParameter('loadtraction','(yes) no: wy³¹cza ³adowanie elementów trakcji elektrycznej');
  FindParameter('physicslog','(no) yes: w³¹cza zapisywanie parametrów fizycznych dla wszystkich obsadzonych przez AI lub cz³owieka pojazdów');
  FindParameter('debuglog','(3=yes) informacje o uruchamianiu i przebiegu dzia³ania symulacji: +1 - do pliku log.txt, +2 - wyœwietlanie w oknie, +4 - nazwy torów');
  FindParameter('multiplelogs','(no) zapisywanie logów do katalogu /logs/ bez nadpisywania po ka¿dym uruchomieniu symulacji');
  FindParameter('input.gamepad','(yes) no: ignorowanie sygna³u z gamepada, przydatne dla u¿ytkowników PoKeys');
  FindParameter('mousescale','(3.2 0.5) czu³oœæ myszy, mo¿na dawaæ ujemne dla odwrócenia kierunku');
  FindParameter('feedbackmode','(1) 0 - wy³¹czone, 1 - za³¹czone sterowanie diodami klawiatury (Caps Lock - CA/SHP, Scroll Lock - jazda na oporach rozruchowych), 2 - (Caps - CA, Scroll -SHP), 3 - LPT, 4 - PoKeys55, 5 - COM');
  FindParameter('feedbackport','adres (dziesiêtnie) bazowy portu LPT dla feedbackmode 3 (zapalanie kontrolek wyjœciami LPT)');
  FindParameter('friction','(1.0) mno¿nik dla wspó³czynnika tarcia');
  FindParameter('fieldofview','(45) 15-75 k¹t widzenia kamery w pionie');
  FindParameter('sound.volume','globalna g³oœnoœæ dŸwiêków');
  FindParameter('maxtexturesize','(16384) skalowanie zbyt du¿ych tekstur do podanego rozmiaru');
  FindParameter('multisampling','(2) wyg³adzanie krawêdzi (poprawia obraz, ale obni¿a FPS): 0 - wy³aczone, 1 - dwukrotne, 2 - czterokrotne, 3 - oœmiokrotne');
  FindParameter('convertmodels','(135) tworzenie plików modeli binarnych E3D z T3D: 0 - wy³¹czone, +1 - nowe Opacity, +2 - z optymalizacj¹, +4 - z bananami, +128 - rozszerzony pod exe C++, niekompatybilny ze starymi');
  FindParameter('anisotropicfiltering','(8) 1-16 jakoœæ filtrowania anizotropowego tekstur');
  FindParameter('pyscreenrendererpriority','(normal, lower, lowest, idle) priorytet w¹tku pythonowego renderera. Odci¹¿a procesor zmniejszaj¹c odœwie¿anie ekranów w lokomotywach.');
  FindParameter('splinefidelity','(1) 1-4 dodatkowy podzia³ trajektorii na ³ukach, zwiêkszaj¹cy kr¹g³oœæ');
  FindParameter('lang','(pl) jêzyk dla napisów');
  FindParameter('python.threadedupload','(yes) wysylanie wygenerowanych obrazow ekranow przy uzyciu osobnego watku');
  FindParameter('python.enabled','(domyslnie yes) wylacza w ogole generowanie tekstur przy uzyciu pythona');
  FindParameter('gfx.skiprendering','(domyslnie no) wylacza w ogole wizualizacje symulacji, pozostawiajac jedynie ui');
  FindParameter('crashdamage','(domyslnie yes) w³¹cza uszkodzenia sprzêgów i wykolejenia od zderzeñ');
  FindParameter('gfx.postfx.chromaticaberration.enabled','(domyslnie no) Efekt aberracji chromatycznej');
end;

procedure TSettings.SaveSettings;
var
  Settings, Par : TStringList;
  i : Integer;
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
    if Params[i].Name = 'soundenabled'                  then SetCheckState(Main.chSoundenabled.Checked,i) else
    if Params[i].Name = 'enabletraction'                then SetCheckState(Main.chEnabletraction.Checked,i) else
    if Params[i].Name = 'livetraction'                  then SetCheckState(Main.chLivetraction.Checked,i) else
    if Params[i].Name = 'loadtraction'                  then SetCheckState(Main.chLoadtraction.Checked,i) else
    if Params[i].Name = 'physicslog'                    then SetCheckState(Main.chPhysicslog.Checked,i) else
    if Params[i].Name = 'debuglog'                      then SetCheckState(Main.chDebuglog.Checked,i) else
    if Params[i].Name = 'multiplelogs'                  then SetCheckState(Main.chMultiplelogs.Checked,i) else
    if Params[i].Name = 'input.gamepad'                 then SetCheckState(Main.chInputgamepad.Checked,i) else
    if Params[i].Name = 'gfx.postfx.motionblur.enabled' then SetCheckState(Main.chMotionBlur.Checked,i) else
    if Params[i].Name = 'gfx.envmap.enabled'            then SetCheckState(Main.chEnvmap.Checked,i) else
    if Params[i].Name = 'gfx.smoke'                     then SetCheckState(Main.chSmoke.Checked,i) else
    if Params[i].Name = 'gfx.extraeffects'              then SetCheckState(Main.chExtraEffects.Checked,i) else
    if Params[i].Name = 'scalespeculars'                then SetCheckState(Main.chScaleSpeculars.Checked,i) else
    if Params[i].Name = 'gfx.shadowmap.enabled'         then SetCheckState(Main.chShadowMap.Checked,i) else
    if Params[i].Name = 'python.threadedupload'         then SetCheckState(Main.chPythonThreadedUpload.Checked,i) else
    if Params[i].Name = 'python.enabled'                then SetCheckState(Main.chPythonEnabled.Checked,i) else
    if Params[i].Name = 'gfx.skiprendering'             then SetCheckState(Main.chSkipRendering.Checked,i) else
    if Params[i].Name = 'crashdamage'                   then SetCheckState(Main.chCrashDamage.Checked,i) else
    if Params[i].Name = 'gfx.postfx.chromaticaberration.enabled'  then SetCheckState(Main.chChromaticAberration.Checked,i) else
    if Params[i].Name = 'gfx.skippipeline'              then SetCheckState(Main.chSkipPipeline.Checked,i) else
    if Params[i].Name = 'mousescale' then
    begin
      case Main.cbMouseScale.ItemIndex of
        0: Params[i].Value := '1.5 0.5';
        1: Params[i].Value := '1.0 0.5';
        2: Params[i].Value := '2.3 0.5';
        3: Params[i].Value := '3.2 0.5';
      end;
    end
    else
    if Params[i].Name = 'feedbackmode'  then Params[i].Value := IntToStr(Main.cbFeedbackmode.ItemIndex) else
    if Params[i].Name = 'feedbackport'  then Params[i].Value := Main.edFeedbackport.Text else
    if Params[i].Name = 'friction'      then Params[i].Value := Main.edFriction.Text else
    if Params[i].Name = 'fieldofview'   then Params[i].Value := Main.edFieldofview.Text else
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
    begin
      case Main.cbSoundvolume.ItemIndex of
        0: Params[i].Value := '1.5';
        1: Params[i].Value := '1.0';
        2: Params[i].Value := '2.0';
      end;
    end
    else
    if Params[i].Name = 'sound.volume.radio' then
    begin
      case Main.cbRadioVolume.ItemIndex of
        0: Params[i].Value := '0.6';
        1: Params[i].Value := '0.3';
        2: Params[i].Value := '1.0';
      end;
    end
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
    if Params[i].Name = 'multisampling'         then Params[i].Value := IntToStr(Main.cbMultisampling.ItemIndex) else
    if Params[i].Name = 'convertmodels'         then Params[i].Value := IntToStr(Main.cbConvertmodels.ItemIndex) else
    if Params[i].Name = 'gfx.smoke.fidelity'    then Params[i].Value := IntToStr(Main.cbSmokeFidelity.ItemIndex+1)
    else
    if Params[i].Name = 'anisotropicfiltering'  then
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
      //Params[i].Value := Main.tbShadowRange.Position.ToString;
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
    if Params[i].Name = 'splinefidelity' then Params[i].Value := IntToStr(Main.cbSplinefidelity.ItemIndex+1) else
    if Params[i].Name = 'lang' then Params[i].Value := LowerCase(Main.cbLang.Text);

    if Pos('//',Params[i].Desc) > 0 then
    begin
      if Params[i].Name.Length = 0 then
        Settings.Add(Params[i].Desc)
      else
        Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) + #9#9 + Params[i].Desc);
    end
    else
      Settings.Add(Params[i].Name + ' ' + Trim(Params[i].Value) + #9#9 + '//' + Params[i].Desc);
  end;

  Settings.SaveToFile(Main.DIR + 'eu07.ini');
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

  Settings.SaveToFile(Main.DIR + 'eu07_input-keyboard.ini');
end;

end.
