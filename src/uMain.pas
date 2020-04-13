// Starter for MaSzyna
// Author: Damian Skrzek alias szczawik
// First stable version was published 26.09.2019

unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, System.Generics.Defaults,Vcl.ButtonGroup, uStructures,
  Vcl.ComCtrls, uSettings, Vcl.CheckLst, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.Imaging.pngimage, IdTCPConnection, IdTCPClient, IdHTTP, IdBaseComponent,
  IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, Vcl.Grids, Vcl.Samples.Spin, Rtti, TypInfo;

type
  TMain = class(TForm)
    btnStart: TButton;
    pmTrainsets: TPopupMenu;
    pnlMenu: TPanel;
    btnScenarios: TButton;
    btnDepot: TButton;
    btnSettings: TButton;
    pnlMain: TPanel;
    Pages: TPageControl;
    tsStart: TTabSheet;
    tsMagazine: TTabSheet;
    pnlDepot: TPanel;
    pnlDepotTop: TPanel;
    tsSettings: TTabSheet;
    pnlButtons: TPanel;
    btnDefaultSettings: TButton;
    lbScenarios: TListBox;
    Panel2: TPanel;
    pcMissions: TPageControl;
    tsDescription: TTabSheet;
    meMission: TMemo;
    pnlScenariusze: TPanel;
    imScenario: TImage;
    meDesc: TMemo;
    tsDetails: TTabSheet;
    meTimetable: TMemo;
    tsAttachments: TTabSheet;
    sbAttachments: TScrollBox;
    lbTrains: TListBox;
    Panel3: TPanel;
    Panel4: TPanel;
    pnlTextures: TPanel;
    cbTypes: TComboBox;
    cbModels: TComboBox;
    lbTextures: TListBox;
    Label32: TLabel;
    btnAddVehicle: TButton;
    pnlVehicleOptions: TPanel;
    AL: TActionList;
    actAddToMagazine: TAction;
    actReplaceTrain: TAction;
    actRemoveFromDepot: TAction;
    actAddVehicle: TAction;
    actRemoveVehicle: TAction;
    actCopyCoupler: TAction;
    actStart: TAction;
    actScenarios: TAction;
    actDepo: TAction;
    actSettings: TAction;
    actDefaultSettings: TAction;
    actSaveSettings: TAction;
    pnlPociagiTop: TPanel;
    Label33: TLabel;
    chOnlyForDriving: TCheckBox;
    imFacebook: TImage;
    imMaszyna: TImage;
    miPasteFromClipboard: TMenuItem;
    btnCheckUpdate: TButton;
    actCheckUpdate: TAction;
    lbVersion: TLabel;
    pnlAboutTrain: TPanel;
    lbTrainLength: TLabel;
    lbTrainMass: TLabel;
    lbTrainMassCaption: TLabel;
    lnTrainLengthCaption: TLabel;
    actSaveDepot: TAction;
    sbTrain: TScrollBox;
    tsKeyboard: TTabSheet;
    cbKey: TComboBox;
    btnSaveKeyboard: TButton;
    actSaveKeyboard: TAction;
    btnKeybard: TButton;
    actKeyboard: TAction;
    KeysGrid: TStringGrid;
    pnlKeyEdit: TPanel;
    cbKey1: TComboBox;
    cbKey2: TComboBox;
    cbKey3: TComboBox;
    pcSettings: TPageControl;
    tsMain: TTabSheet;
    tsGraphics: TTabSheet;
    pnlPhysic: TPanel;
    pnlGeneral: TPanel;
    Label15: TLabel;
    Label2: TLabel;
    chFullScreen: TCheckBox;
    chInactivepause: TCheckBox;
    chPause: TCheckBox;
    cbMouseScale: TComboBox;
    pnlLang: TPanel;
    Label12: TLabel;
    cbLang: TComboBox;
    pnlGraphic: TPanel;
    Label16: TLabel;
    Label6: TLabel;
    Label31: TLabel;
    chSoundenabled: TCheckBox;
    cbSoundvolume: TComboBox;
    cbRadioVolume: TComboBox;
    pnlGraphicLeft: TPanel;
    Label7: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    cbMaxtexturesize: TComboBox;
    cbSplinefidelity: TComboBox;
    cbAnisotropicfiltering: TComboBox;
    cbMultisampling: TComboBox;
    cbResolution: TComboBox;
    cbPyscreenrendererpriority: TComboBox;
    Panel1: TPanel;
    chGlutfont: TCheckBox;
    chGfxresourcesweep: TCheckBox;
    chGfxresourcemove: TCheckBox;
    chUsevbo: TCheckBox;
    chVsync: TCheckBox;
    chShadows: TCheckBox;
    chSmoke: TCheckBox;
    Label38: TLabel;
    cbSmokeFidelity: TComboBox;
    chMotionBlur: TCheckBox;
    Label20: TLabel;
    Label13: TLabel;
    chInputgamepad: TCheckBox;
    cbFeedbackmode: TComboBox;
    pnlFeedBackPort: TPanel;
    Label21: TLabel;
    edFeedbackport: TEdit;
    Label17: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    chDebugmode: TCheckBox;
    cbEXE: TComboBox;
    cbConvertmodels: TComboBox;
    Panel11: TPanel;
    Label19: TLabel;
    chFullphysics: TCheckBox;
    chEnabletraction: TCheckBox;
    chLivetraction: TCheckBox;
    chLoadtraction: TCheckBox;
    chPhysicslog: TCheckBox;
    chDebuglog: TCheckBox;
    chMultiplelogs: TCheckBox;
    pnlFriction: TPanel;
    Label3: TLabel;
    edFriction: TEdit;
    pnlFieldOfView: TPanel;
    Label4: TLabel;
    edFieldofview: TEdit;
    Panel12: TPanel;
    Label18: TLabel;
    cbReflectionsFramerate: TComboBox;
    chEnvmap: TCheckBox;
    chExtraEffects: TCheckBox;
    chScaleSpeculars: TCheckBox;
    chShadowMap: TCheckBox;
    Label40: TLabel;
    cbGfxrenderer: TComboBox;
    pcConfig: TPageControl;
    pnlConfig: TPanel;
    Panel7: TPanel;
    Label24: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Panel8: TPanel;
    cbDriverType: TComboBox;
    edLoadCount: TEdit;
    chReversed: TCheckBox;
    tsConfig: TTabSheet;
    tsBrake: TTabSheet;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Label26: TLabel;
    cbBrakeState: TComboBox;
    cbBrakeAdjust: TComboBox;
    Label41: TLabel;
    Label42: TLabel;
    cbBrakeActing: TComboBox;
    Label36: TLabel;
    cbShadowMapSize: TComboBox;
    Label43: TLabel;
    cbShadowRange: TComboBox;
    pcOtherSettings: TPageControl;
    tsCoupler: TTabSheet;
    tsCondition: TTabSheet;
    clCouplers: TCheckListBox;
    pnlCondition: TPanel;
    pnlConditionLabels: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    pnlConditionEdits: TPanel;
    edSway: TEdit;
    edFlatness: TEdit;
    edFlatnessRand: TEdit;
    edFlatnessProb: TEdit;
    pcVehicleInfo: TPageControl;
    tsGeneralInfo: TTabSheet;
    tsAboutTex: TTabSheet;
    pnlVehicleLength: TPanel;
    Panel9: TPanel;
    lbMassCaption: TLabel;
    lbMass: TLabel;
    Panel10: TPanel;
    lbVMaxCaption: TLabel;
    lbVMax: TLabel;
    Panel16: TPanel;
    Label25: TLabel;
    lbTexPhoto: TLabel;
    Panel17: TPanel;
    Label37: TLabel;
    lbTexRevision: TLabel;
    Panel18: TPanel;
    Label45: TLabel;
    lbTexStation: TLabel;
    Panel19: TPanel;
    Label47: TLabel;
    lbTexOwner: TLabel;
    Panel20: TPanel;
    Label49: TLabel;
    lbTexAuthor: TLabel;
    Panel21: TPanel;
    Label51: TLabel;
    lbTexWorks: TLabel;
    btnRemoveVehicle: TButton;
    lbLengthCaption: TLabel;
    lbLength: TLabel;
    miCopyToClipboard: TMenuItem;
    miAddToDepo: TMenuItem;
    btnHelp: TButton;
    Panel22: TPanel;
    chPythonThreadedUpload: TCheckBox;
    Label35: TLabel;
    chPythonEnabled: TCheckBox;
    pnlCouplerButtons: TPanel;
    btnCopyCoupler: TButton;
    btnCouplerEZT: TButton;
    actCouplerEZT: TAction;
    chSkipRendering: TCheckBox;
    lbTrainVelocity: TLabel;
    tsWeather: TTabSheet;
    pnlShadowCabRange: TPanel;
    chRefAmbientTemp: TCheckBox;
    lbModelCaption: TLabel;
    lbModel: TLabel;
    Label53: TLabel;
    cbShadowsCabRange: TComboBox;
    lbStarter: TLabel;
    cbCloseApp: TCheckBox;
    cbBigThumbnail: TCheckBox;
    pnlMini: TPanel;
    imMini: TImage;
    chShowAI: TCheckBox;
    actRemoveTrain: TAction;
    pnlLoad: TPanel;
    cbLoadType: TComboBox;
    btnCopyLoad: TButton;
    actCopyLoad: TAction;
    pnlDay: TPanel;
    btnSpring: TButton;
    btnSummer: TButton;
    btnAutumn: TButton;
    Button1: TButton;
    btnCurrentDate: TButton;
    Panel25: TPanel;
    Label34: TLabel;
    Panel6: TPanel;
    btnRemoveFromDepot: TButton;
    btnSaveDepot: TButton;
    lbDepot: TListBox;
    Panel26: TPanel;
    Panel5: TPanel;
    btnReplaceTrainset: TButton;
    btnAddToDepo: TButton;
    lbTrains2: TListBox;
    Splitter1: TSplitter;
    tbDay: TTrackBar;
    Panel27: TPanel;
    Panel23: TPanel;
    pnlOvercast: TPanel;
    tbOvercast: TTrackBar;
    Panel24: TPanel;
    Panel28: TPanel;
    btnCloudless: TButton;
    Button2: TButton;
    btnCloudy: TButton;
    pnlFullCloudy: TButton;
    btnSmallRain: TButton;
    btnBigRain: TButton;
    tbTemperature: TTrackBar;
    tbFog: TTrackBar;
    pnlVisibility: TPanel;
    lbFogNo: TLabel;
    lbFog: TLabel;
    lbCloudy: TLabel;
    pnlLabelTemperature: TPanel;
    lbTemperature: TLabel;
    pnlLabelDay: TPanel;
    lbDay: TLabel;
    actSpring: TAction;
    actSummer: TAction;
    actAutumn: TAction;
    actWinter: TAction;
    actCurrentDate: TAction;
    actCloudless: TAction;
    actPartlyCloudy: TAction;
    actCloudy: TAction;
    actFullCloudy: TAction;
    actLittleRain: TAction;
    actBigRain: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbScenariosClick(Sender: TObject);
    procedure lbTrainsClick(Sender: TObject);
    procedure cbFeedbackmodeChange(Sender: TObject);
    procedure cbDriverTypeChange(Sender: TObject);
    procedure cbLoadTypeChange(Sender: TObject);
    procedure edLoadCountChange(Sender: TObject);
    procedure chReversedClick(Sender: TObject);
    procedure clCouplersClick(Sender: TObject);
    procedure cbTypesClick(Sender: TObject);
    procedure cbModelsClick(Sender: TObject);
    procedure edSwayChange(Sender: TObject);
    procedure edFlatnessChange(Sender: TObject);
    procedure edFlatnessRandChange(Sender: TObject);
    procedure edFlatnessProbChange(Sender: TObject);
    procedure lbDepotClick(Sender: TObject);
    procedure cbBrakeActingChange(Sender: TObject);
    procedure actAddToMagazineExecute(Sender: TObject);
    procedure actAddToMagazineUpdate(Sender: TObject);
    procedure actReplaceTrainExecute(Sender: TObject);
    procedure actReplaceTrainUpdate(Sender: TObject);
    procedure actRemoveFromDepotExecute(Sender: TObject);
    procedure actRemoveFromDepotUpdate(Sender: TObject);
    procedure actAddVehicleExecute(Sender: TObject);
    procedure actAddVehicleUpdate(Sender: TObject);
    procedure actRemoveVehicleExecute(Sender: TObject);
    procedure actRemoveVehicleUpdate(Sender: TObject);
    procedure actCopyCouplerExecute(Sender: TObject);
    procedure actCopyCouplerUpdate(Sender: TObject);
    procedure actStartExecute(Sender: TObject);
    procedure actStartUpdate(Sender: TObject);
    procedure actScenariosExecute(Sender: TObject);
    procedure actDepoExecute(Sender: TObject);
    procedure actSettingsExecute(Sender: TObject);
    procedure actDefaultSettingsExecute(Sender: TObject);
    procedure actSaveSettingsExecute(Sender: TObject);
    procedure cbLangChange(Sender: TObject);
    procedure chOnlyForDrivingClick(Sender: TObject);
    procedure imFacebookClick(Sender: TObject);
    procedure imMaszynaClick(Sender: TObject);
    procedure actCheckUpdateExecute(Sender: TObject);
    procedure lbVersionDblClick(Sender: TObject);
    procedure lbVersionClick(Sender: TObject);
    procedure actSaveDepotExecute(Sender: TObject);
    procedure actSaveKeyboardExecute(Sender: TObject);
    procedure actKeyboardExecute(Sender: TObject);
    procedure KeysGridClick(Sender: TObject);
    procedure cbKey1Change(Sender: TObject);
    procedure cbKey2Change(Sender: TObject);
    procedure cbKey3Change(Sender: TObject);
    procedure cbBrakeStateChange(Sender: TObject);
    procedure cbBrakeAdjustChange(Sender: TObject);
    procedure miCopyToClipboardClick(Sender: TObject);
    procedure miPasteFromClipboardClick(Sender: TObject);
    procedure pmTrainsetsPopup(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure actCouplerEZTUpdate(Sender: TObject);
    procedure actCouplerEZTExecute(Sender: TObject);
    procedure edFieldofviewExit(Sender: TObject);
    procedure cbBigThumbnailClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chRefAmbientTempClick(Sender: TObject);
    procedure lbTexturesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure actRemoveTrainUpdate(Sender: TObject);
    procedure actRemoveTrainExecute(Sender: TObject);
    procedure actCopyLoadUpdate(Sender: TObject);
    procedure actCopyLoadExecute(Sender: TObject);
    procedure lbTexturesDblClick(Sender: TObject);
    procedure lbTexturesMouseLeave(Sender: TObject);
    procedure ConfigChange(Sender: TObject);
    procedure actCurrentDateExecute(Sender: TObject);
    procedure actSpringExecute(Sender: TObject);
    procedure actSummerExecute(Sender: TObject);
    procedure actAutumnExecute(Sender: TObject);
    procedure actWinterExecute(Sender: TObject);
    procedure actCloudlessExecute(Sender: TObject);
    procedure actPartlyCloudyExecute(Sender: TObject);
    procedure actCloudyExecute(Sender: TObject);
    procedure actFullCloudyExecute(Sender: TObject);
    procedure actLittleRainExecute(Sender: TObject);
    procedure actBigRainExecute(Sender: TObject);
  private
    SCN : TScenario;
    SelTrain : Integer;
    SelVehicle : Integer;
    SelectTex : Boolean;

    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;

    procedure OtworzZalacznik(Sender: TObject);
    procedure DrawTrain(const Train: TTrain);
    procedure RunSimulator;
    procedure SelectVehicle(Sender: TObject);
    function PrepareTrainsetDesc(const Trainset: TTrain): string;
    procedure LoadMagazine;
    procedure ChangePange(const PageIndex: Integer);
    procedure DrawVehicle(const Vehicle: TVehicle);
    function PaintVehicle(const Tex:TTexture; const ModelID:Integer=0):TBitmap;
    function SelImage: TImage;
    function GetSelList: TTrain;
    procedure SetSelList(const Value: TTrain);
    procedure SelectTrain;
    function GetCoupler: Integer;
    procedure SelectTexture(const Vehicle: TVehicle);
    procedure SelectCoupler(Coupler: Integer);
    procedure LoadModelData(const PhysicsID:Integer);
    procedure ClearTrainScroll;
    procedure RemoveOldVersion;
    procedure LoadKeysComponents;
    procedure LoadTexData(const Tex: TTexture);
    procedure OpenFile(const Path: string);
    procedure PrepareLoadingScreen;
    procedure DefaultSettings;
    procedure AdaptMiniSize;
    procedure EmptyTexData;
    procedure SetItemDesc(const Trainset: TTrain);
    procedure RemoveVehicle;
    procedure AppDeactivate(Sender: TObject);
    procedure AppActivate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    Scenarios   : TObjectList<TScenario>;
    Textures    : TObjectList<TTexture>;
    Physics     : TObjectList<TPhysics>;
    Depot       : TObjectList<TTrain>;
    ClipTrain   : TTrain;
    Settings    : TSettings;
    DIR         : string;
    MiniFactor  : Integer;
    SelList     : TSelectedList;

    property Train : TTrain read GetSelList write SetSelList;

    function PrepareNode(const Dyn:TVehicle;const TrainSet:Boolean=True): string;
  end;

var
  Main: TMain;

implementation

uses DateUtils, JPEG, ShellApi, uParser, uUpdater, Clipbrd;

{$R *.dfm}

procedure TMain.actAddToMagazineExecute(Sender: TObject);
var
  DepoTrain : TTrain;
  Vehicle : TVehicle;
  i : Integer;
begin
  DepoTrain := TTrain.Create;

  for i := 0 to Train.Vehicles.Count-1 do
  begin
    Vehicle := TVehicle.Create;
    Vehicle.Assign(Train.Vehicles[i]);
    DepoTrain.Vehicles.Add(Vehicle);
  end;
  Depot.Add(DepoTrain);

  with TParser.Create do
  try
    SaveDepot;
  finally
    Free;
  end;

  LoadMagazine;
end;

procedure TMain.actAddToMagazineUpdate(Sender: TObject);
begin
  actAddToMagazine.Enabled := lbTrains2.ItemIndex >= 0;
end;

procedure TMain.actAddVehicleExecute(Sender: TObject);
var
  Vehicle : TVehicle;
  Texture : TTexture;
  ScrollPos : Integer;
begin
  Vehicle := TVehicle.Create;
  Vehicle.MinDist  := -1;
  Vehicle.MaxDist  := 0;

  Texture := (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);

  Vehicle.Dir      := Texture.Dir;
  Vehicle.ReplacableSkin := Texture.Plik;

  Vehicle.Texture := Texture;
  Vehicle.ModelID := 0;
  if Texture.Models[0].MiniD.Length > 0 then
    Vehicle.Name     := Texture.Models[0].MiniD
  else
    Vehicle.Name := Vehicle.ReplacableSkin;

  Vehicle.TypeChk  := Texture.Models[0].Model;
  Vehicle.PathName := Texture.Dir;
  Vehicle.Dist     := 0;
  Vehicle.CabOccupancy := TCabOccupancy(cbDriverType.ItemIndex);
  Vehicle.Vel      := 0;
  Vehicle.Settings := '0';
  Vehicle.Coupler  := 3;
  TryStrToInt(edSway.Text,Vehicle.Sway);
  TryStrToInt(edFlatness.Text,Vehicle.Flatness);
  TryStrToInt(edFlatnessProb.Text,Vehicle.FlatnessProb);
  TryStrToInt(edFlatnessRand.Text,Vehicle.FlatnessRand);

  case cbBrakeActing.ItemIndex of
    0: Vehicle.Brake := EmptyStr;
    1: Vehicle.Brake := 'G';
    2: Vehicle.Brake := 'P';
    3: Vehicle.Brake := 'R';
    4: Vehicle.Brake := 'M';
    5: Vehicle.Brake := 'Q';
  end;

  case cbBrakeState.ItemIndex of
    0: Vehicle.BrakeState := 'N';
    1: Vehicle.BrakeState := '0';
    2: Vehicle.BrakeState := '1';
  end;

  case cbBrakeAdjust.ItemIndex of
    0: Vehicle.BrakeAdjust := 'N';
    1: Vehicle.BrakeAdjust := 'T';
    2: Vehicle.BrakeAdjust := 'H';
    3: Vehicle.BrakeAdjust := 'F';
  end;

  Vehicle.LoadType := cbLoadType.Text;
  Vehicle.Loadquantity := StrToFloat(edLoadCount.Text);

  if SelVehicle <> -1 then
    Train.Vehicles.Insert(SelVehicle+1,Vehicle)
  else
    Train.Vehicles.Add(Vehicle);

  if SelList = slSCN then
    SetItemDesc(Train)
  else
    lbDepot.Items[lbDepot.ItemIndex] := PrepareTrainsetDesc(Train);

  ScrollPos := sbTrain.HorzScrollBar.Position;
  SelVehicle := Train.Vehicles.Count-1;
  DrawTrain(Train);
  sbTrain.HorzScrollBar.Position := ScrollPos;
end;

procedure TMain.actAddVehicleUpdate(Sender: TObject);
begin
  actAddVehicle.Enabled := (lbTextures.ItemIndex >= 0) and (SelTrain >= 0);
end;

procedure TMain.actAutumnExecute(Sender: TObject);
begin
  tbDay.Position := 297;
end;

procedure TMain.actBigRainExecute(Sender: TObject);
begin
  tbOvercast.Position := 15;
end;

procedure TMain.actCheckUpdateExecute(Sender: TObject);
begin
  with TfrmUpdater.Create(self) do
  try
    CheckUpdate;
  finally
    Free;
  end;
end;

procedure TMain.actCloudlessExecute(Sender: TObject);
begin
  tbOvercast.Position := 0;
end;

procedure TMain.actCloudyExecute(Sender: TObject);
begin
  tbOvercast.Position := 7;
end;

procedure TMain.actCopyCouplerExecute(Sender: TObject);
begin
  Train.Vehicles[SelVehicle].Coupler := Train.Vehicles[SelVehicle-1].Coupler;
  SelectCoupler(Train.Vehicles[SelVehicle].Coupler);
end;

procedure TMain.actCopyCouplerUpdate(Sender: TObject);
begin
  actCopyCoupler.Enabled := SelVehicle > 0;
end;

procedure TMain.actCopyLoadExecute(Sender: TObject);
var
  Index : Integer;
begin
  Index := cbLoadType.Items.IndexOf(Train.Vehicles[SelVehicle-1].LoadType);

  if Index >= 0 then
  begin
    cbLoadType.ItemIndex := Index;
    Train.Vehicles[SelVehicle].LoadType := cbLoadType.Text;
    Train.Vehicles[SelVehicle].Loadquantity := Train.Vehicles[SelVehicle-1].Loadquantity;

    edLoadCount.Text := FloatToStr(Train.Vehicles[SelVehicle].Loadquantity);
  end;
end;

procedure TMain.actCopyLoadUpdate(Sender: TObject);
begin
  actCopyLoad.Enabled := SelVehicle > 0;
end;

procedure TMain.actCouplerEZTExecute(Sender: TObject);
begin
  Train.Vehicles[SelVehicle].Coupler := 119;
  SelectCoupler(Train.Vehicles[SelVehicle].Coupler);
end;

procedure TMain.actCouplerEZTUpdate(Sender: TObject);
begin
  actCouplerEZT.Enabled := SelVehicle > 0;
end;

procedure TMain.actCurrentDateExecute(Sender: TObject);
begin
  tbDay.Position := DayOfTheYear(Now);
end;

procedure TMain.DefaultSettings;
begin
  cbResolution.ItemIndex := 0;

  chFullScreen.Checked                  := False;
  chInactivepause.Checked               := True;
  chPause.Checked                       := False;
  chSoundenabled.Checked                := True;
  chDebugmode.Checked                   := False;
  chGlutfont.Checked                    := False;
  chGfxresourcesweep.Checked            := False;
  chGfxresourcemove.Checked             := False;
  chShadows.Checked                     := True;
  chVsync.Checked                       := False;
  chUsevbo.Checked                      := True;
  chFullphysics.Checked                 := True;
  chEnabletraction.Checked              := True;
  chLivetraction.Checked                := True;
  chLoadtraction.Checked                := True;
  chPhysicslog.Checked                  := False;
  chDebuglog.Checked                    := False;
  chMultiplelogs.Checked                := False;
  chInputgamepad.Checked                := True;
  chMotionBlur.Checked                  := True;
  chEnvmap.Checked                      := True;
  chSmoke.Checked                       := True;
  chExtraEffects.Checked                := True;
  chScaleSpeculars.Checked              := True;
  chShadowMap.Checked                   := True;
  chPythonEnabled.Checked               := True;
  chPythonThreadedUpload.Checked        := True;
  chSkipRendering.Checked               := False;

  cbMouseScale.ItemIndex                := 0;
  cbLang.ItemIndex                      := 0;
  cbSoundvolume.ItemIndex               := 0;
  cbRadioVolume.ItemIndex               := 0;
  cbConvertmodels.ItemIndex             := 0;
  cbMaxtexturesize.ItemIndex            := 5;
  cbSplinefidelity.ItemIndex            := 0;
  cbAnisotropicfiltering.ItemIndex      := 3;
  cbMultisampling.ItemIndex             := 2;
  cbPyscreenrendererpriority.ItemIndex  := 0;
  cbFeedbackmode.ItemIndex              := 1;
  cbSmokeFidelity.ItemIndex             := 1;
  cbReflectionsFramerate.ItemIndex      := 0;
  cbShadowsCabRange.ItemIndex           := 3;
  cbGfxrenderer.ItemIndex               := 0;
  cbShadowMapSize.ItemIndex             := 1;
  cbShadowRange.ItemIndex               := 3;

  edFriction.Text     := '1.0';
  edFieldofview.Text  := '45';
  edFeedbackport.Text := '888';
end;

procedure TMain.actDefaultSettingsExecute(Sender: TObject);
begin
  DefaultSettings;
  Settings.SaveSettings;
end;

procedure TMain.actDepoExecute(Sender: TObject);
begin
  ChangePange(1);
end;

procedure TMain.actFullCloudyExecute(Sender: TObject);
begin
  tbOvercast.Position := 10;
end;

procedure TMain.actKeyboardExecute(Sender: TObject);
begin
  Settings.ReadKeyboard;
  LoadKeysComponents;
  ChangePange(3);
end;

procedure TMain.actLittleRainExecute(Sender: TObject);
begin
  tbOvercast.Position := 11;
end;

procedure TMain.actPartlyCloudyExecute(Sender: TObject);
begin
  tbOvercast.Position := 3;
end;

procedure TMain.actRemoveFromDepotExecute(Sender: TObject);
begin
  Depot.Extract(Depot[lbDepot.ItemIndex]);

  with TParser.Create do
  try
    SaveDepot;
  finally
    Free;
  end;

  LoadMagazine;

  if (SelList = slDEPO) then
  begin
    if Depot.Count > 0 then
    begin
      SelTrain := Integer(lbDepot.Items.Objects[lbDepot.ItemIndex]);
      SelectTrain;
    end
    else
    begin
      SelTrain := -1;
      lbTrainsClick(self);
    end;
  end;
end;

procedure TMain.actRemoveFromDepotUpdate(Sender: TObject);
begin
  actRemoveFromDepot.Enabled := lbDepot.ItemIndex >= 0;
end;

procedure TMain.actRemoveTrainExecute(Sender: TObject);
begin
  while Train.Vehicles.Count > 0 do
    RemoveVehicle;

  if SelList = slSCN then
    SetItemDesc(Train)
  else
    lbDepot.Items[lbDepot.ItemIndex] := PrepareTrainsetDesc(Train);

  DrawTrain(Train);
end;

procedure TMain.RemoveVehicle;
begin
  Train.Vehicles.Extract(Train.Vehicles[SelVehicle]);

  if SelVehicle > Train.Vehicles.Count-1  then
    Dec(SelVehicle);
end;

procedure TMain.actRemoveTrainUpdate(Sender: TObject);
begin
  actRemoveTrain.Enabled := Train.Vehicles.Count > 0;
end;

procedure TMain.actRemoveVehicleExecute(Sender: TObject);
begin
  RemoveVehicle;

  if SelList = slSCN then
    SetItemDesc(Train)
  else
    lbDepot.Items[lbDepot.ItemIndex] := PrepareTrainsetDesc(Train);

  DrawTrain(Train);
end;

procedure TMain.actRemoveVehicleUpdate(Sender: TObject);
begin
  actRemoveVehicle.Enabled := SelVehicle >= 0;
end;

procedure TMain.actReplaceTrainExecute(Sender: TObject);
var
  Train : TTrain;
  Vehicle : TVehicle;
  i : Integer;
begin
  Train := SCN.Trains[Integer(lbTrains.Items.Objects[lbTrains.ItemIndex])];
  Train.Vehicles.Clear;

  for i := 0 to Depot[lbDepot.ItemIndex].Vehicles.Count-1 do
  begin
    Vehicle := TVehicle.Create;
    Vehicle.Assign(Depot[lbDepot.ItemIndex].Vehicles[i]);
    Train.Vehicles.Add(Vehicle);
  end;

  SetItemDesc(Train);

  DrawTrain(Train);
end;

procedure TMain.actReplaceTrainUpdate(Sender: TObject);
begin
  actReplaceTrain.Enabled := (lbTrains2.ItemIndex >= 0) and (lbDepot.ItemIndex >= 0);
end;

procedure TMain.actSaveDepotExecute(Sender: TObject);
begin
  with TParser.Create do
  try
    SaveDepot;
  finally
    Free;
  end;
end;

procedure TMain.actSaveKeyboardExecute(Sender: TObject);
begin
  Settings.SaveKeyboardSettings;
end;

procedure TMain.actSaveSettingsExecute(Sender: TObject);
begin
  Settings.SaveSettings;
end;

procedure TMain.actScenariosExecute(Sender: TObject);
begin
  ChangePange(0);
end;

procedure TMain.actSettingsExecute(Sender: TObject);
begin
  ChangePange(2);
end;

procedure TMain.actSpringExecute(Sender: TObject);
begin
  tbDay.Position := 113;
end;

procedure TMain.actStartExecute(Sender: TObject);
var
  Starter : TStringList;
  i,y : Integer;
  SCN : TScenario;
  Parser : TParser;
  Config : TConfig;
begin
  SCN := (lbScenarios.Items.Objects[lbScenarios.ItemIndex] as TScenario);
  Starter := TStringList.Create;

  Starter.Text := SCN.Other.Text;

  Parser := TParser.Create;

  Config := SCN.Config;
  Config.FogEnd := (tbFog.Max - tbFog.Position) + tbFog.Min;
  Config.Day    := tbDay.Position;
  Config.Overcast := tbOvercast.Position;
  Config.Temperature := tbTemperature.Position;
  SCN.Config := Config;

  Starter.Text := Parser.ChangeConfig(SCN.Other.Text,SCN.Config);
  Parser.Free;

  Starter.Add('FirstInit');

  for i := 0 to SCN.Trains.Count-1 do
  begin
    with SCN.Trains[i] do
    begin
      Starter.Add('trainset ' + TrainName + ' ' + Track + ' ' + FloatToStr(Dist) + ' ' + FloatToStr(Vel));

      for y := 0 to Vehicles.Count-1 do
        Starter.Add(PrepareNode(Vehicles[y]));

      Starter.Add(' endtrainset');
      Starter.Add('');
    end;
  end;

  for i := 0 to SCN.Vehicles.Count-1 do
    Starter.Add(PrepareNode(SCN.Vehicles[i],False));

  Starter.SaveToFile(DIR + '\scenery\$' + SCN.Name + '.scn');

  RunSimulator;
end;

procedure TMain.actStartUpdate(Sender: TObject);
begin
  actStart.Enabled := (SelTrain >= 0) and (SelVehicle >= 0)
                      and (Train.Vehicles[SelVehicle].CabOccupancy in [coHeadDriver,coRearDriver,coPassenger])
                      and (cbEXE.ItemIndex >= 0 );
end;

procedure TMain.actSummerExecute(Sender: TObject);
begin
  tbDay.Position := 204;
end;

procedure TMain.actWinterExecute(Sender: TObject);
begin
  tbDay.Position := 15;
end;

procedure TMain.btnHelpClick(Sender: TObject);
begin
  OpenFile('\readme.html');
end;

procedure TMain.OpenFile(const Path:string);
begin
  if FileExists(DIR + Path) then
    ShellExecute(Handle,'open',PChar(DIR + Path),nil,nil, SW_SHOWNORMAL)
  else
    ShowMessage('Nie znaleziono pliku: ' + Path);
end;

procedure TMain.PrepareLoadingScreen;
var
  SR : TSearchRec;
  FoundFiles : Integer;
  FilesList : TStringList;
  JPG : TJPEGImage;
  BMP: TBitmap;
begin
  FilesList := TStringList.Create;
  JPG := TJPEGImage.Create;
  Bmp := TBitmap.Create;
  try
    FoundFiles := FindFirst(Self.DIR + '\textures\logo\*.jpg',faAnyFile,SR);
    while (FoundFiles = 0) do
    begin
      if (SR.Name <> '.') and (SR.Name <> '..') then
        FilesList.Add(SR.Name);

      FoundFiles := FindNext(SR);
    end;
    FindClose(SR);

    JPG.LoadFromFile(Self.DIR + '\textures\logo\' + FilesList[Random(FilesList.Count)]);

    Bmp.PixelFormat := pf32bit;
    Bmp.Assign(JPG);
    Bmp.SaveToFile(Self.DIR + '\textures\logo.bmp');
  finally
    JPG.Free;
    BMP.Free;
    FilesList.Free;
  end;
end;

procedure TMain.RunSimulator;
var
  Parameters : string;
  SEI : TShellExecuteInfo;
begin
  Settings.SaveSettings;

  if FileExists(DIR + cbEXE.Text) then
  begin
    PrepareLoadingScreen;

    Parameters := '-s ' + '$' + SCN.Name + '.scn';
    Parameters := Parameters + ' -v ' + Train.Vehicles[SelVehicle].Name;
    ZeroMemory(@SEI, SizeOf(SEI));
    SEI.cbSize := SizeOf(SEI);
    SEI.lpFile := PChar(DIR + cbEXE.Text);
    SEI.lpParameters := PChar(Parameters);
    SEI.lpDirectory := PChar(DIR);
    SEI.nShow := SW_SHOWNORMAL;
    ShellExecuteEx(@SEI);

    if cbCloseApp.Checked then Application.Terminate;
  end
  else
    ShowMessage('Nie znaleziono pliku wykonywalnego (eu07.exe) symulatora.');
end;

procedure TMain.cbBrakeActingChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
  begin
    case cbBrakeActing.ItemIndex of
      0: Train.Vehicles[SelVehicle].Brake := '';
      1: Train.Vehicles[SelVehicle].Brake := 'G';
      2: Train.Vehicles[SelVehicle].Brake := 'P';
      3: Train.Vehicles[SelVehicle].Brake := 'R';
      4: Train.Vehicles[SelVehicle].Brake := 'M';
      5: Train.Vehicles[SelVehicle].Brake := 'Q';
    end;
  end;
end;

procedure TMain.cbBrakeAdjustChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
  begin
    case cbBrakeAdjust.ItemIndex of
      0: Train.Vehicles[SelVehicle].BrakeAdjust := '';
      1: Train.Vehicles[SelVehicle].BrakeAdjust := 'T';
      2: Train.Vehicles[SelVehicle].BrakeAdjust := 'H';
      3: Train.Vehicles[SelVehicle].BrakeAdjust := 'F';
    end;
  end;
end;

procedure TMain.cbBrakeStateChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
  begin
    case cbBrakeState.ItemIndex of
      0: Train.Vehicles[SelVehicle].BrakeState := '';
      1: Train.Vehicles[SelVehicle].BrakeState := '0';
      2: Train.Vehicles[SelVehicle].BrakeState := '1';
    end;
  end;
end;

procedure TMain.cbDriverTypeChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    Train.Vehicles[SelVehicle].CabOccupancy := TCabOccupancy(cbDriverType.ItemIndex);
end;

procedure TMain.cbFeedbackmodeChange(Sender: TObject);
begin
  edFeedbackport.Enabled := cbFeedbackmode.ItemIndex = 3;
end;

procedure TMain.cbKey1Change(Sender: TObject);
begin
  Settings.KeyParams[KeysGrid.Row-1].Key := cbKey1.Items[cbKey1.ItemIndex];
  KeysGrid.Cells[0,KeysGrid.Row] := cbKey1.Items[cbKey1.ItemIndex];
end;

procedure TMain.cbKey2Change(Sender: TObject);
begin
  Settings.KeyParams[KeysGrid.Row-1].Key2 := cbKey2.Items[cbKey2.ItemIndex];
  KeysGrid.Cells[1,KeysGrid.Row] := cbKey2.Items[cbKey2.ItemIndex];
end;

procedure TMain.cbKey3Change(Sender: TObject);
begin
  Settings.KeyParams[KeysGrid.Row-1].Key3 := cbKey3.Items[cbKey3.ItemIndex];
  KeysGrid.Cells[2,KeysGrid.Row] := cbKey3.Items[cbKey3.ItemIndex];
end;

procedure TMain.cbLangChange(Sender: TObject);
var
  Param : TParam;
begin
  Param := Settings.FindParam('lang');

  if (Param <> nil) and (not SameText(Param.Value,cbLang.Text)) then
  begin
    Settings.SaveSettings;
    Settings.ReadOwnSettings;
    Settings.ReadSettings;
  end;
end;

procedure TMain.cbLoadTypeChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    Train.Vehicles[SelVehicle].LoadType := cbLoadType.Text;
end;

procedure TMain.cbBigThumbnailClick(Sender: TObject);
begin
  AdaptMiniSize;
end;

procedure TMain.cbModelsClick(Sender: TObject);
var
  i, y : Integer;
begin
  if cbModels.ItemIndex = -1 then Exit;

  lbTextures.Items.BeginUpdate;
  lbTextures.Clear;

  for i := 0 to Textures.Count-1 do
    for y := 0 to Textures[i].Models.Count-1 do
      if Textures[i].Models[y].Mini = cbModels.Items[cbModels.ItemIndex] then
      begin
        lbTextures.AddItem(Textures[i].Plik,Textures[i]);
        Break;
      end;

  lbTextures.Sorted := True;
  lbTextures.Items.EndUpdate;
end;

procedure TMain.cbTypesClick(Sender: TObject);
var
  i, y : Integer;
  slModels : TStringList;
begin
  slModels := TStringList.Create;
  slModels.Sorted := True;
  slModels.Duplicates := dupIgnore;

  for i := 0 to Textures.Count-1 do
    if Ord(Textures[i].Typ) = cbTypes.ItemIndex then
      for y := 0 to Textures[i].Models.Count-1 do
        slModels.Add(Textures[i].Models[y].Mini);

  cbModels.Items.BeginUpdate;
  cbModels.Items.Assign(slModels);
  cbModels.Items.EndUpdate;
  slModels.Free;

  if cbModels.Items.Count > 0 then
  begin
    cbModels.ItemIndex := 0;
    cbModelsClick(self);
  end;
end;

procedure TMain.chOnlyForDrivingClick(Sender: TObject);
begin
  lbScenariosClick(chOnlyForDriving);
  if lbTrains2.Count > 0 then
  begin
    lbTrains2.ItemIndex := 0;
    lbTrainsClick(chOnlyForDriving);
  end;
end;

procedure TMain.chRefAmbientTempClick(Sender: TObject);
begin
  if SelVehicle >= 0 then
    Train.Vehicles[SelVehicle].ThermoDynamic := chRefAmbientTemp.Checked;
end;

procedure TMain.chReversedClick(Sender: TObject);
begin
  if SelVehicle >= 0 then
    if chReversed.Checked then
      Train.Vehicles[SelVehicle].Dist := -1
    else
      Train.Vehicles[SelVehicle].Dist := 0;
end;

procedure TMain.clCouplersClick(Sender: TObject);
begin
  if SelVehicle >= 0 then
    Train.Vehicles[SelVehicle].Coupler := GetCoupler;
end;

function TMain.GetCoupler:Integer;
begin
  Result := 0;
  if clCouplers.Checked[0] then Inc(Result,1);
  if clCouplers.Checked[1] then Inc(Result,2);
  if clCouplers.Checked[2] then Inc(Result,4);
  if clCouplers.Checked[3] then Inc(Result,8);
  if clCouplers.Checked[4] then Inc(Result,16);
  if clCouplers.Checked[5] then Inc(Result,32);
  if clCouplers.Checked[6] then Inc(Result,64);
  if clCouplers.Checked[7] then Inc(Result,128);
end;

procedure TMain.ChangePange(const PageIndex:Integer);
begin
  Pages.ActivePageIndex := PageIndex;
  sbTrain.Visible := Pages.ActivePage.PageIndex < tsSettings.PageIndex;

  if PageIndex = 0 then
    lbTrainsClick(self);
end;

function TMain.PrepareNode(const Dyn:TVehicle;const TrainSet:Boolean=True):string;
begin
  Result := 'node ' + FloatToStr(Dyn.MinDist) + ' ' + FloatToStr(Dyn.MaxDist) + ' ' + Dyn.Name +
            ' dynamic ' + Dyn.Dir + ' ' + Dyn.ReplacableSkin + ' ' + Dyn.TypeChk + ' ';

  if not TrainSet then Result := Result + Dyn.PathName + ' ';

  Result := Result + FloatToStr(Dyn.Dist) + ' ';

  case Dyn.CabOccupancy of
    coHeadDriver: Result := Result + 'headdriver ';
    coRearDriver: Result := Result + 'reardriver ';
    coNobody:     Result := Result + 'nobody ';
    coPassenger:  Result := Result + 'passenger ';
  end;

  if TrainSet then
  begin
    Result := Result + IntToStr(Dyn.Coupler);

    if not Dyn.Brake.IsEmpty then
      Result := Result + '.B' + Dyn.Brake + Dyn.BrakeState + Dyn.BrakeAdjust;

    if (Dyn.Sway > 0) or (Dyn.Flatness > 0) or (Dyn.FlatnessRand > 0) or (Dyn.FlatnessProb > 0) then
    begin
      Result := Result + '.W';

      if Dyn.Sway > 0 then
        Result := Result + 'H' + IntToStr(Dyn.Sway);
      if Dyn.Flatness > 0 then
        Result := Result + 'F' + IntToStr(Dyn.Flatness);
      if Dyn.FlatnessRand > 0 then
        Result := Result + 'R' + IntToStr(Dyn.FlatnessRand);
      if Dyn.FlatnessProb > 0 then
        Result := Result + 'P' + IntToStr(Dyn.FlatnessProb);
    end;

    if Dyn.ThermoDynamic then
      Result := Result + '.TA';
  end
  else
    Result := Result + FloatToStr(Dyn.Vel);

  if Dyn.LoadType.Length > 0 then
    Result := Result + ' ' + FloatToStr(Dyn.Loadquantity)
  else
    Result := Result + ' 0';

  if SameText(Dyn.LoadType, 'pantstate') then
    Result := Result + ' 1';

  if Dyn.LoadType.Length > 0 then
    Result := Result + ' ' + Dyn.LoadType;

  Result := Result + ' enddynamic';
end;

procedure TMain.RemoveOldVersion;
begin
  try
    if FileExists(DIR + '\StarterOld.exe') then
      DeleteFile(DIR + '\StarterOld.exe');
  except
    //ShowMessage('Nie uda�o si� usun�� starej wesji programu (StarterOld.exe).');
  end;
end;

procedure TMain.LoadKeysComponents;
var
  i : Integer;
begin
  KeysGrid.RowCount := Settings.KeyParams.Count + 1;
  KeysGrid.Cells[0,0] := 'Przycisk 1';
  KeysGrid.Cells[1,0] := 'Przycisk 2';
  KeysGrid.Cells[2,0] := 'Przycisk 3';
  KeysGrid.Cells[3,0] := 'Opis funkcji';

  for i := 0 to Settings.KeyParams.Count-1 do
  begin
    KeysGrid.Cells[0,i+1] := Settings.KeyParams[i].Key;
    KeysGrid.Cells[1,i+1] := Settings.KeyParams[i].Key2;
    KeysGrid.Cells[2,i+1] := Settings.KeyParams[i].Key3;
    KeysGrid.Cells[3,i+1] := Settings.KeyParams[i].Desc;
  end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Settings.SaveSettings;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  Application.OnActivate    := AppActivate;
  Application.OnDeactivate  := AppDeactivate;

  DIR := ExtractFilePath(ParamStr(0));
  //DIR := 'G:\MaSzyna\MaSzyna2001beta\';
  //DIR := 'G:\MaSzyna\pctga\';
  //DIR := 'G:\MaSzyna\MaSzyna1908\';
  //DIR := 'G:\MaSzyna\MaSzyna pliki\';

  RemoveOldVersion;

  FormatSettings.DecimalSeparator := '.';

  Textures  := TObjectList<TTexture>.Create;
  Physics   := TObjectList<TPhysics>.Create;
  Scenarios := TObjectList<TScenario>.Create();
  Depot     := TObjectList<TTrain>.Create;

  with TParser.Create do
  try
    LoadData;
  finally
    Free;
  end;

  Settings := TSettings.Create;
  Settings.ReadOwnSettings;
  DefaultSettings;
  Settings.ReadSettings;

  AdaptMiniSize;

  SelTrain := -1;
  SelVehicle := -1;
  SelectTex := True;

  for i := 0 to Scenarios.Count-1 do
    lbScenarios.AddItem(Scenarios[i].Name,Scenarios[i]);

  LoadMagazine;

  Pages.Pages[0].TabVisible := False;
  Pages.Pages[1].TabVisible := False;
  Pages.Pages[2].TabVisible := False;
  Pages.ActivePageIndex := 0;

  if lbScenarios.Count > 0 then
  begin
    lbScenarios.ItemIndex := 0;
    lbScenariosClick(self);
  end;
end;

procedure TMain.AdaptMiniSize;
begin
  if cbBigThumbnail.Checked then
  begin
    sbTrain.Height := 84;
    MiniFactor := 2;
    Self.Height := Self.Height + 30;
  end
  else
  begin
    sbTrain.Height := 54;
    MiniFactor := 1;
    Self.Height := Self.Height - 30;
  end;
  if SCN <> nil then
    DrawTrain(Train);
end;

procedure TMain.LoadMagazine;
var
  i : Integer;
begin
  lbDepot.Items.BeginUpdate;
  lbDepot.Clear;

  for i := 0 to Depot.Count-1 do
    lbDepot.AddItem(PrepareTrainsetDesc(Depot[i]),TObject(i));

  lbDepot.Items.EndUpdate;

  if lbDepot.Count > 0 then
    lbDepot.ItemIndex := 0;
end;

procedure TMain.AppActivate(Sender: TObject);
begin
  RegisterHotKey(Handle, VK_DELETE, 0, VK_DELETE);
  RegisterHotKey(Handle, VK_INSERT, 0, VK_INSERT);
end;

procedure TMain.AppDeactivate(Sender: TObject);
begin
  UnRegisterHotKey(Handle, VK_DELETE);
  UnRegisterHotKey(Handle, VK_INSERT);
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  Scenarios.Free;
  Textures.Free;
  Physics.Free;
end;

function TMain.GetSelList: TTrain;
begin
  if SelList = slSCN then
    Result := SCN.Trains[SelTrain]
  else
	  Result := Depot[SelTrain];
end;

procedure TMain.imFacebookClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar('https://www.facebook.com/MaSzynaeu07pl/'),nil,nil, SW_SHOWNORMAL)
end;

procedure TMain.imMaszynaClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar('https://eu07.pl/'),nil,nil, SW_SHOWNORMAL)
end;

procedure TMain.KeysGridClick(Sender: TObject);
begin
  cbKey1.ItemIndex := cbKey1.Items.IndexOf(Settings.KeyParams[KeysGrid.Row-1].Key);
  cbKey2.ItemIndex := cbKey2.Items.IndexOf(Settings.KeyParams[KeysGrid.Row-1].Key2);
  cbKey3.ItemIndex := cbKey3.Items.IndexOf(Settings.KeyParams[KeysGrid.Row-1].Key3);
end;

procedure TMain.lbVersionClick(Sender: TObject);
begin
  Pages.ActivePageIndex := 2;
  btnCheckUpdate.SetFocus;
end;

procedure TMain.lbVersionDblClick(Sender: TObject);
begin
  ShowMessage('Autor programu: szczawik');
end;

procedure TMain.lbDepotClick(Sender: TObject);
begin
  if (lbDepot.ItemIndex < 0) or ((SelList = slDEPO) and (SelTrain = Integer(lbDepot.Items.Objects[lbDepot.ItemIndex]))) then Exit;

  SelList := slDEPO;

  SelTrain := Integer(lbDepot.Items.Objects[lbDepot.ItemIndex]);

  SelectTrain;
end;

procedure TMain.lbTrainsClick(Sender: TObject);
begin
  if Pages.ActivePageIndex = 0 then
    lbTrains2.ItemIndex := lbTrains.ItemIndex
  else
    lbTrains.ItemIndex := lbTrains2.ItemIndex;

  if (lbTrains.ItemIndex < 0) or ((SelList =slSCN) and (SelTrain = Integer(lbTrains.Items.Objects[lbTrains.ItemIndex]))) then Exit;

  SelList := slSCN;

  ClearTrainScroll;

  SelTrain := Integer(lbTrains.Items.Objects[lbTrains.ItemIndex]);

  SelectTrain;
end;

procedure TMain.SelectTrain;
begin
  if Train.Vehicles.Count > 0 then
    SelVehicle := 0
  else
    SelVehicle := -1;

  meMission.Lines.BeginUpdate;
  meMission.Clear;
  if Train.AI then
    meMission.Lines.Add('Poci�g prowadzony przez komputer.');
  meMission.Lines.Add(Train.Desc);
  meMission.Lines.EndUpdate;

  meTimetable.Lines.BeginUpdate;
  meTimetable.Text := '';
  if FileExists(DIR + '\scenery\' + Train.TrainName + '.txt') then
    meTimetable.Lines.LoadFromFile(DIR + '\scenery\' + Train.TrainName + '.txt' );
  meTimetable.Lines.EndUpdate;

  DrawTrain(Train);
end;

procedure TMain.ClearTrainScroll;
begin
  while sbTrain.ControlCount > 0 do
    sbTrain.Controls[0].Free;

  sbTrain.HorzScrollBar.Position := 0;
end;

procedure TMain.SelectVehicle(Sender:TObject);
var
  Mark : TShape;
  i : Integer;
  Vehicle : TVehicle;
begin
  i := 0;
  while i <= sbTrain.ControlCount-1 do
    if sbTrain.Controls[i].ClassType = TShape then
      sbTrain.Controls[i].Free
    else
      Inc(i);

  Mark := TShape.Create(sbTrain);
  Mark.Brush.Style := bsClear;
  Mark.Pen.Width := 3;
  Mark.Pen.Color := clYellow;
  Mark.Parent := sbTrain;
  Mark.Left   := (Sender as TImage).Left - 1;
  Mark.Width  := (Sender as TImage).Width + 2;
  Mark.Height := (Sender as TImage).Height + 3;
  SelVehicle := (Sender as TImage).Tag;
  imMini.Picture.Bitmap := (Sender as TImage).Picture.Bitmap;

  Vehicle := Train.Vehicles[SelVehicle];

  SelectCoupler(Vehicle.Coupler);

  if Vehicle.Brake.IsEmpty then cbBrakeActing.ItemIndex := 0 else
  if Vehicle.Brake = 'G' then cbBrakeActing.ItemIndex := 1 else
  if Vehicle.Brake = 'P' then cbBrakeActing.ItemIndex := 2 else
  if Vehicle.Brake = 'R' then cbBrakeActing.ItemIndex := 3 else
  if Vehicle.Brake = 'M' then cbBrakeActing.ItemIndex := 4 else
  if Vehicle.Brake = 'Q' then cbBrakeActing.ItemIndex := 5;

  if Vehicle.BrakeState.IsEmpty then cbBrakeState.ItemIndex := 0 else
  if Vehicle.BrakeState = 'N' then cbBrakeState.ItemIndex := 0 else
  if Vehicle.BrakeState = '0' then cbBrakeState.ItemIndex := 1 else
  if Vehicle.BrakeState = '1' then cbBrakeState.ItemIndex := 2;

  if Vehicle.BrakeAdjust.IsEmpty then cbBrakeAdjust.ItemIndex := 0 else
  if Vehicle.BrakeAdjust = 'N' then cbBrakeAdjust.ItemIndex := 0 else
  if Vehicle.BrakeAdjust = 'T' then cbBrakeAdjust.ItemIndex := 1 else
  if Vehicle.BrakeAdjust = 'H' then cbBrakeAdjust.ItemIndex := 2 else
  if Vehicle.BrakeAdjust = 'F' then cbBrakeAdjust.ItemIndex := 3;

  if Vehicle.Sway >= 0 then
    edSway.Text := IntToStr(Vehicle.Sway);
  if Vehicle.Flatness >= 0 then
    edFlatness.Text := IntToStr(Vehicle.Flatness);
  if Vehicle.FlatnessRand >= 0 then
    edFlatnessRand.Text := IntToStr(Vehicle.FlatnessRand);
  if Vehicle.FlatnessProb >= 0 then
    edFlatnessProb.Text := IntToStr(Vehicle.FlatnessProb);

  cbDriverType.ItemIndex := Ord(Vehicle.CabOccupancy);

  if SelectTex then
    SelectTexture(Vehicle)
  else
    EmptyTexData;

  chReversed.Checked := Vehicle.Dist = -1;
  chRefAmbientTemp.Checked := Vehicle.ThermoDynamic;
  cbLoadType.ItemIndex := cbLoadType.Items.IndexOf(Vehicle.LoadType);
  edLoadCount.Text := FloatToStr(Vehicle.Loadquantity);
end;

procedure TMain.SelectCoupler(Coupler:Integer);
begin
  clCouplers.CheckAll(cbUnchecked);

  if Coupler >= 128 then
  begin
    clCouplers.Checked[7] := True;
    Dec(Coupler,128);
  end;
  if Coupler >= 64 then
  begin
    clCouplers.Checked[6] := True;
    Dec(Coupler,64);
  end;
  if Coupler >= 32 then
  begin
    clCouplers.Checked[5] := True;
    Dec(Coupler,32);
  end;
  if Coupler >= 16 then
  begin
    clCouplers.Checked[4] := True;
    Dec(Coupler,16);
  end;
  if Coupler >= 8 then
  begin
    clCouplers.Checked[3] := True;
    Dec(Coupler,8);
  end;
  if Coupler >= 4 then
  begin
    clCouplers.Checked[2] := True;
    Dec(Coupler,4);
  end;
  if Coupler >= 2 then
  begin
    clCouplers.Checked[1] := True;
    Dec(Coupler,2);
  end;
  if Coupler >= 1 then
    clCouplers.Checked[0] := True;
end;

procedure TMain.LoadModelData(const PhysicsID:Integer);
begin
  cbLoadType.Items.Clear;

  if PhysicsID >= 0 then
  begin
    ExtractStrings([','],[],PChar(Physics[PhysicsID].LoadAccepted),cbLoadType.Items);
    lbMass.Caption := FloatToStr(Physics[PhysicsID].Mass / 1000);
    lbLength.Caption := FloatToStr(Physics[PhysicsID].Length);
    lbVMax.Caption := FloatToStr(Physics[PhysicsID].VMax);
  end
  else
  begin
    lbMass.Caption    := EmptyStr;
    lbLength.Caption  := EmptyStr;
    lbVMax.Caption    := EmptyStr;
  end;
end;

procedure TMain.LoadTexData(const Tex:TTexture);
begin
  if Tex <> nil then
  begin
    lbTexOwner.Caption    := Tex.Owner;
    lbTexStation.Caption  := Tex.Station;
    lbTexRevision.Caption := Tex.Revision;
    lbTexWorks.Caption    := Tex.Works;
    lbTexAuthor.Caption   := Tex.Author;
    lbTexPhoto.Caption    := Tex.Photos;
  end
  else
    EmptyTexData;
end;

procedure TMain.EmptyTexData;
begin
  lbTexOwner.Caption    := EmptyStr;
  lbTexStation.Caption  := EmptyStr;
  lbTexRevision.Caption := EmptyStr;
  lbTexWorks.Caption    := EmptyStr;
  lbTexAuthor.Caption   := EmptyStr;
  lbTexPhoto.Caption    := EmptyStr;
end;

procedure TMain.SelectTexture(const Vehicle:TVehicle);
var
  i : Integer;
begin
  if Textures.Count = 0 then Exit;

  cbModels.Items.BeginUpdate;
  lbTextures.Items.BeginUpdate;
  cbLoadType.Items.BeginUpdate;
  i := 0;

  if Vehicle.Texture <> nil then
  begin
    cbTypes.ItemIndex := Ord(Vehicle.Texture.Typ);
    cbTypesClick(self);

    cbModels.ItemIndex := cbModels.Items.IndexOf(Vehicle.Texture.Models[Vehicle.ModelID].Mini);

    cbModelsClick(self);
    LoadModelData(Vehicle.Texture.Fiz);
    LoadTexData(Vehicle.Texture);

    lbModel.Caption := Vehicle.Texture.Models[Vehicle.ModelID].Model;

    if not SameText(Vehicle.TypeChk,Vehicle.Texture.Models[Vehicle.ModelID].Model) then
      lbModel.Caption := lbModel.Caption + ' (!)';

    lbTextures.ItemIndex := lbTextures.Items.IndexOf(Vehicle.Texture.Plik);
  end
  else
  begin
    while (not SameText(Textures[i].Dir,Vehicle.Dir)) and (i < Textures.Count-1) do
      Inc(i);

    if SameText(Textures[i].Dir,Vehicle.Dir) then
    begin
      cbTypes.ItemIndex := Ord(Textures[i].Typ);
      cbTypesClick(self);
      cbModels.ItemIndex := cbModels.Items.IndexOf(Textures[i].Models[0].Mini);
      cbModelsClick(self);
      LoadModelData(Textures[i].Fiz);
      LoadTexData(Vehicle.Texture);
      if Vehicle.Texture <> nil then
        lbModel.Caption := Vehicle.Texture.Models[Vehicle.ModelID].Model
      else
        lbModel.Caption := '-';
    end
    else
    begin
      cbTypes.ItemIndex := -1;
      cbModels.ItemIndex := -1;
      lbTextures.ItemIndex := -1;
    end;
  end;

  cbModels.Items.EndUpdate;
  lbTextures.Items.EndUpdate;
  cbLoadType.Items.EndUpdate;
end;

procedure TMain.DrawTrain(const Train:TTrain);
var
  i, ImageWidth : Integer;
  Image : TImage;
  TrainLength, TrainMass : Double;
begin
  ClearTrainScroll;

  TrainLength := 0;
  TrainMass   := 0;
  ImageWidth  := 0;

  for i := Train.Vehicles.Count-1 downto 0 do
  begin
    if (Train.Vehicles[i].Texture <> nil) and (Train.Vehicles[i].Texture.Fiz >= 0) then
    begin
      TrainLength := TrainLength + Physics[Train.Vehicles[i].Texture.Fiz].Length;
      TrainMass   := TrainMass + Physics[Train.Vehicles[i].Texture.Fiz].Mass;
    end;

    Image := TImage.Create(self);
    Image.Parent := sbTrain;
    Image.Align := alLeft;
    Image.Stretch := True;
    Image.Constraints.MaxHeight := 30 * MiniFactor;
    Image.OnClick := SelectVehicle;
    Image.Tag := i;
    Image.Name := 'Image' + IntToStr(i);
    Image.Picture.Bitmap.Assign(PaintVehicle(Train.Vehicles[i].Texture,Train.Vehicles[i].ModelID));
    Image.Width := Image.Picture.Bitmap.Width * MiniFactor;

    Inc(ImageWidth,Image.Width);
  end;

  sbTrain.HorzScrollBar.Range := ImageWidth;

  if SelImage <> nil then
    SelectVehicle(SelImage);

  try
    if TrainLength > 0 then
      lbTrainLength.Caption := FloatToStr(TrainLength)
    else
      lbTrainLength.Caption := '';
    if TrainMass > 0 then
      lbTrainMass.Caption := FloatToStr(TrainMass / 1000)
    else
      lbTrainMass.Caption := '';
    if Train.Vel > 0 then
    begin
      lbTrainVelocity.Caption := FloatToStr(Train.Vel);
      lbTrainVelocity.Caption := 'Pr�dko�� pocz�tkowa: ' + lbTrainVelocity.Caption + 'km/h';
      lbTrainVelocity.Visible := True;
    end
    else
      lbTrainVelocity.Visible := False;
  except
    lbTrainMass.Caption := '';
  end;
end;

procedure TMain.DrawVehicle(const Vehicle:TVehicle);
var
  Image : TImage;
begin
  Image := SelImage;
  if Image <> nil then
  begin
    Image.Picture.Bitmap.Assign(PaintVehicle(Vehicle.Texture,Vehicle.ModelID));
    Image.Width := Image.Picture.Bitmap.Width * MiniFactor;
    SelectVehicle(Image);
  end;
end;

function TMain.SelImage:TImage;
var
  i : Integer;
begin
  Result := nil;
  for i := 0 to sbTrain.ControlCount-1 do
    if sbTrain.Controls[i].ClassType = TImage then
      if (sbTrain.Controls[i] as TImage).Tag = SelVehicle then
      begin
        Result := sbTrain.Controls[i] as TImage;
        Exit;
      end;
end;

procedure TMain.SetSelList(const Value: TTrain);
begin
  if SelList = slSCN then
    SCN.Trains[SelTrain] := Value
  else
    Depot[SelTrain] := Value;
end;

procedure TMain.ConfigChange(Sender:TObject);
begin
  lbDay.Caption := IntToStr(tbDay.Position);
  lbTemperature.Caption := IntToStr(tbTemperature.Position) + '�C';
end;

procedure TMain.WMHotKey(var Msg: TWMHotKey);
begin
  if Msg.HotKey = VK_DELETE then btnRemoveVehicle.Click
  else
  if Msg.HotKey = VK_INSERT then btnAddVehicle.Click;
end;

function TMain.PaintVehicle(const Tex:TTexture; const ModelID:Integer=0):TBitmap;
begin
  result := TBitmap.Create;

  if Tex <> nil then
  begin
    if FileExists(DIR + 'textures\mini\' + Tex.Models[ModelID].MiniD + '.bmp') then
      result.LoadFromFile(DIR + '\textures\mini\' + Tex.Models[ModelID].MiniD + '.bmp')
    else
      if FileExists(DIR + 'textures\mini\' + Tex.Models[ModelID].Mini + '.bmp') then
        result.LoadFromFile(DIR + '\textures\mini\' + Tex.Models[ModelID].Mini + '.bmp')
      else
        if FileExists(DIR + 'textures\mini\' + Tex.Mini + '.bmp') then
          result.LoadFromFile(DIR + '\textures\mini\' + Tex.Mini + '.bmp');
  end;

  if result.Empty then
    if FileExists(DIR + 'textures\mini\other.bmp') then
      result.LoadFromFile(DIR + '\textures\mini\other.bmp');

  imMini.Picture.Bitmap := result;
end;

procedure TMain.pmTrainsetsPopup(Sender: TObject);
begin
  miPasteFromClipboard.Visible := ClipTrain <> nil;
end;

procedure TMain.edFieldofviewExit(Sender: TObject);
var
  Value : Integer;
begin
  if TryStrToInt(edFieldofview.Text,Value) then
  begin
    if (Value < 10) or (Value > 75) then
      edFieldofview.Text := '45';
  end
  else
    edFieldofview.Text := '45';
end;

procedure TMain.edFlatnessChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    TryStrToInt(edFlatness.Text,Train.Vehicles[SelVehicle].Flatness);
end;

procedure TMain.edFlatnessProbChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    TryStrToInt(edFlatnessProb.Text,Train.Vehicles[SelVehicle].FlatnessProb);
end;

procedure TMain.edFlatnessRandChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    TryStrToInt(edFlatnessRand.Text,Train.Vehicles[SelVehicle].FlatnessRand);
end;

procedure TMain.edLoadCountChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    TryStrToFloat(edLoadCount.Text,Train.Vehicles[SelVehicle].Loadquantity);
end;

procedure TMain.edSwayChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    TryStrToInt(edSway.Text,Train.Vehicles[SelVehicle].Sway);
end;

procedure TMain.OtworzZalacznik(Sender:TObject);
begin
  OpenFile((Sender as TButton).Hint);
end;

procedure TMain.lbScenariosClick(Sender: TObject);
var
  i : Integer;
  Mini : TJPEGImage;
  Attachment : TButton;
begin
  if (lbScenarios.ItemIndex < 0) or ((SCN = Scenarios[lbScenarios.ItemIndex]) and (Sender <> chOnlyForDriving)) then Exit;

  SelTrain := -1;

  SCN := TScenario.Create;
  SCN := Scenarios[lbScenarios.ItemIndex];

  while sbAttachments.ControlCount > 0 do
    sbAttachments.Controls[0].Free;

  for i := 0 to SCN.Files.Count-1 do
  begin
    Attachment := TButton.Create(self);
    Attachment.Parent := sbAttachments;
    Attachment.Align := alTop;

    Attachment.Hint := Copy(SCN.Files[i] ,Pos(' ',SCN.Files[i],1)+1,Pos(' ',SCN.Files[i],4)-4);
    Attachment.Caption := Copy(SCN.Files[i] ,Pos(' ',SCN.Files[i],10)+1,SCN.Files[i].Length);
    Attachment.OnClick := OtworzZalacznik;
  end;

  if FileExists(DIR + '\scenery\images\' + SCN.Image) then
  begin
    Mini := TJPEGImage.Create;
    Mini.LoadFromFile(DIR + '\scenery\images\' + SCN.Image);
    imScenario.Picture.Bitmap.Assign(Mini);
  end;

  lbTrains.Items.BeginUpdate;
  lbTrains.Clear;

  meDesc.Lines.BeginUpdate;
  meDesc.Text := SCN.Desc.Text;
  meDesc.Lines.EndUpdate;

  for i := 0 to SCN.Trains.Count-1 do
  begin
    if (not chOnlyForDriving.Checked) or ((SCN.Trains[i].Vehicles.Count > 0) and (SCN.Trains[i].Vehicles[0].CabOccupancy in [coHeadDriver,coRearDriver])) then
    begin
      if (chShowAI.Checked) or (not SCN.Trains[I].AI) then
        lbTrains.AddItem(PrepareTrainsetDesc(SCN.Trains[i]),TObject(i));
    end;
  end;

  lbTrains2.Items := lbTrains.Items;

  if lbTrains.Count > 0 then
    lbTrains.ItemIndex := 0;

  lbTrains.Items.EndUpdate;

  if SCN.Config.Day > 0 then
    tbDay.Position := SCN.Config.Day
  else
    tbDay.Position := DayOfTheYear(Now);

  if (SCN.Config.Temperature >= -50) and (SCN.Config.Temperature <= 50) then
    tbTemperature.Position := Round(SCN.Config.Temperature)
  else
    tbTemperature.Position := 15;

  tbFog.Position := (tbFog.Max - SCN.Config.FogEnd) + tbFog.Min;
  tbOvercast.Position := Round(SCN.Config.Overcast);

  lbTrainsClick(self);
end;

function TMain.PrepareTrainsetDesc(const Trainset:TTrain):string;
var
  i : Integer;
begin
  if Trainset.Vehicles.Count > 0 then
  begin
    Result := Trainset.Vehicles.First.Name;

    for i := 1 to Trainset.Vehicles.Count-1 do
      Result := Result + ' + ' + Trainset.Vehicles[i].TypeChk;
  end
  else
    Result := EmptyStr;
end;

procedure TMain.lbTexturesDblClick(Sender: TObject);
var
  Tex : TTexture;
  i : Integer;
begin
  if lbTextures.ItemIndex <> -1 then
  begin
     Tex := (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);

     LoadModelData(Tex.Fiz);
     LoadTexData(Tex);

     if (SelVehicle >= 0) then
     begin
       for i := 0 to Tex.Models.Count-1 do
         if SameText(cbModels.Items[cbModels.ItemIndex],Tex.Models[i].Mini) then
         begin
           if Tex.Models[i].MiniD.Length > 0 then
             Train.Vehicles[SelVehicle].Name := Tex.Models[i].MiniD
           else
             Train.Vehicles[SelVehicle].Name := Tex.Plik;

           Train.Vehicles[SelVehicle].TypeChk := Tex.Models[i].Model;
           Train.Vehicles[SelVehicle].ModelID := i;
         end;

       Train.Vehicles[SelVehicle].ReplacableSkin := Tex.Plik;
       Train.Vehicles[SelVehicle].Dir := Tex.Dir;
       Train.Vehicles[SelVehicle].PathName := Tex.Dir;
       Train.Vehicles[SelVehicle].Texture := Tex;

       lbModel.Caption := Train.Vehicles[SelVehicle].Texture.Models[Train.Vehicles[SelVehicle].ModelID].Model;

       if SelList = slSCN then
         SetItemDesc(Train)
       else
        lbDepot.Items[lbDepot.ItemIndex] := PrepareTrainsetDesc(Train);

       SelectTex := False;
       DrawVehicle(Train.Vehicles[SelVehicle]);
       SelectTex := True;
     end;
  end;
end;

procedure TMain.lbTexturesMouseLeave(Sender: TObject);
begin
  if lbTextures.ItemIndex >= 0 then
    PaintVehicle(lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);
end;

procedure TMain.lbTexturesMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  Index : Integer;
  Point : TPoint;
begin
  Point.X := X;
  Point.Y := Y;
  Index := lbTextures.ItemAtPos(Point,True);

  if Index >= 0 then
    PaintVehicle(lbTextures.Items.Objects[Index] as TTexture);
end;

procedure TMain.miCopyToClipboardClick(Sender: TObject);
var
  i : Integer;
  Str : string;
begin
  str := EmptyStr;
  for i := 0 to Train.Vehicles.Count-1 do
    str := str + PrepareNode(Train.Vehicles[i]) + #13#10;
  Clipboard.AsText := str;

  ClipTrain := Train;
end;

procedure TMain.SetItemDesc(const Trainset:TTrain);
begin
  lbTrains.Items[lbTrains.ItemIndex] := PrepareTrainsetDesc(Trainset);
  lbTrains2.Items[lbTrains2.ItemIndex] := lbTrains.Items[lbTrains.ItemIndex];
end;

procedure TMain.miPasteFromClipboardClick(Sender: TObject);
begin
  SCN.Trains[Integer(lbTrains.Items.Objects[lbTrains.ItemIndex])].Vehicles := ClipTrain.Vehicles;

  SetItemDesc(ClipTrain);

  DrawTrain(SCN.Trains[Integer(lbTrains.Items.Objects[lbTrains.ItemIndex])]);
end;

end.
