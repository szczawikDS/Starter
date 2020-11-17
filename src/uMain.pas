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

{$O+}

unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Generics.Collections, System.Generics.Defaults, uStructures,
  Vcl.ComCtrls, uSettings, Vcl.CheckLst, Vcl.Menus, System.Actions, Vcl.ActnList,
  Vcl.Grids, Vcl.Imaging.pngimage, Vcl.Samples.Spin;

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
    Panel2: TPanel;
    pcMissions: TPageControl;
    tsDescription: TTabSheet;
    meMission: TMemo;
    pnlScenario: TPanel;
    imScenario: TImage;
    meDesc: TMemo;
    tsDetails: TTabSheet;
    meTimetable: TMemo;
    tsAttachments: TTabSheet;
    sbAttachments: TScrollBox;
    lbTrains: TListBox;
    pnlTextures: TPanel;
    cbModels: TComboBox;
    lbTextures: TListBox;
    Label32: TLabel;
    btnAddVehicle: TButton;
    pnlVehicleOptions: TPanel;
    AL: TActionList;
    actAddToDepo: TAction;
    actRemoveFromDepot: TAction;
    actAddVehicle: TAction;
    actRemoveVehicle: TAction;
    actCopyCoupler: TAction;
    actStart: TAction;
    actScenarios: TAction;
    actDepo: TAction;
    actSettings: TAction;
    actDefaultSettings: TAction;
    imFacebook: TImage;
    imMaszyna: TImage;
    miPasteFromClipboard: TMenuItem;
    btnCheckUpdate: TButton;
    actCheckUpdate: TAction;
    lbVersion: TLabel;
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
    pnlGraphic: TPanel;
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
    pcConfig: TPageControl;
    pnlConfig: TPanel;
    Panel7: TPanel;
    Label24: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Panel8: TPanel;
    cbDriverType: TComboBox;
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
    pnlCouplerButtons: TPanel;
    btnCopyCoupler: TButton;
    tsWeather: TTabSheet;
    chRefAmbientTemp: TCheckBox;
    lbModelCaption: TLabel;
    lbModel: TLabel;
    pnlMini: TPanel;
    imMini: TImage;
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
    tbDay: TTrackBar;
    Panel27: TPanel;
    Panel23: TPanel;
    pnlOvercast: TPanel;
    tbTemperature: TTrackBar;
    tbFog: TTrackBar;
    pnlVisibility: TPanel;
    lbFogNo: TLabel;
    lbFog: TLabel;
    lbCloudy: TLabel;
    pnlLabelTemperature: TPanel;
    lbTemperature: TLabel;
    pnlLabelDay: TPanel;
    actSpring: TAction;
    actSummer: TAction;
    actAutumn: TAction;
    actWinter: TAction;
    actCurrentDate: TAction;
    actOpenVehicleDir: TAction;
    Usuwszystkiepojazdyzeskadu1: TMenuItem;
    actCopyToClipboard: TAction;
    pmDepot: TPopupMenu;
    miCopyToClipboard2: TMenuItem;
    actPasteFromClipboard: TAction;
    miReplaceTrain: TMenuItem;
    pcTrains: TPageControl;
    tsSCNTrains: TTabSheet;
    pnlTrainsTop: TPanel;
    chOnlyForDriving: TCheckBox;
    chShowAI: TCheckBox;
    Panel26: TPanel;
    lbTrains2: TListBox;
    btnAddToDepo: TButton;
    tsDepoTrains: TTabSheet;
    btnRemoveFromDepot: TButton;
    lbDepot: TListBox;
    Panel1: TPanel;
    Label38: TLabel;
    chGfxresourcesweep: TCheckBox;
    chGfxresourcemove: TCheckBox;
    chUsevbo: TCheckBox;
    chVsync: TCheckBox;
    chShadows: TCheckBox;
    chSmoke: TCheckBox;
    cbSmokeFidelity: TComboBox;
    chSkipRendering: TCheckBox;
    Panel12: TPanel;
    Label18: TLabel;
    Label40: TLabel;
    Label36: TLabel;
    Label43: TLabel;
    Label53: TLabel;
    cbReflectionsFramerate: TComboBox;
    chExtraEffects: TCheckBox;
    chShadowMap: TCheckBox;
    cbGfxrenderer: TComboBox;
    cbShadowMapSize: TComboBox;
    cbShadowRange: TComboBox;
    cbShadowsCabRange: TComboBox;
    chChromaticAberration: TCheckBox;
    chMotionBlur: TCheckBox;
    chEnvmap: TCheckBox;
    cbLang: TComboBox;
    chSkipPipeline: TCheckBox;
    pnlTime: TPanel;
    dtTime: TDateTimePicker;
    Splitter: TSplitter;
    actReplaceTrain: TAction;
    lbVersionCaption: TLabel;
    Label20: TLabel;
    chInputgamepad: TCheckBox;
    Label13: TLabel;
    cbFeedbackmode: TComboBox;
    pnlFeedBackPort: TPanel;
    Label21: TLabel;
    edFeedbackport: TEdit;
    Label17: TLabel;
    Label1: TLabel;
    chDebugmode: TCheckBox;
    cbEXE: TComboBox;
    cbOvercast: TComboBox;
    pmTextures: TPopupMenu;
    miCopyTexture: TMenuItem;
    actCopyTextureName: TAction;
    pmScenarios: TPopupMenu;
    miReloadScenario: TMenuItem;
    actReloadScenarios: TAction;
    actOpenTexDir: TAction;
    miOpenTexDir: TMenuItem;
    actOpenScenarioDir: TAction;
    miOpenScenarioDir: TMenuItem;
    pnlTypes: TPanel;
    btnSearch: TButton;
    cbTypes: TComboBox;
    btnCopyLoadAll: TButton;
    actCopyLoadToAll: TAction;
    miDepo: TMenuItem;
    actOpenDepo: TAction;
    btnAbout: TButton;
    actAbout: TAction;
    pnlLeft: TPanel;
    tvSCN: TTreeView;
    lbBattery: TLabel;
    cbBattery: TComboBox;
    btnCOM: TButton;
    actCOM: TAction;
    btnRestoreWeather: TButton;
    actRestoreWeather: TAction;
    miLoadDepoFromFile: TMenuItem;
    actLoadDepoFromFile: TAction;
    OD: TOpenDialog;
    miChangeName: TMenuItem;
    actChangeName: TAction;
    btnAutoCoupler: TButton;
    actAutoCoupler: TAction;
    tsSoundPhysics: TTabSheet;
    Panel11: TPanel;
    Label19: TLabel;
    chFullphysics: TCheckBox;
    chEnabletraction: TCheckBox;
    chLivetraction: TCheckBox;
    chPhysicslog: TCheckBox;
    chDebuglog: TCheckBox;
    chMultiplelogs: TCheckBox;
    pnlFriction: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    edFriction: TEdit;
    edFieldofview: TEdit;
    chCrashDamage: TCheckBox;
    chDebugLogVis: TCheckBox;
    pnlSound: TPanel;
    Label16: TLabel;
    chSoundenabled: TCheckBox;
    Label6: TLabel;
    lbRadioVolume: TLabel;
    lbGlobalSounds: TLabel;
    lbPositionalsSounds: TLabel;
    lbVehiclesSounds: TLabel;
    lbStarter: TLabel;
    cbCloseApp: TCheckBox;
    cbBigThumbnail: TCheckBox;
    pnlUpdate: TPanel;
    Label34: TLabel;
    Label39: TLabel;
    edUpdateInterval: TSpinEdit;
    pnlLeftMargin1: TPanel;
    pnlLeftMargin2: TPanel;
    pnlLeftMargin3: TPanel;
    Panel22: TPanel;
    Label35: TLabel;
    chPythonThreadedUpload: TCheckBox;
    chPythonEnabled: TCheckBox;
    pnlShadowCabRange: TPanel;
    btnCurrentTime: TButton;
    actCurrentTime: TAction;
    chMouseInversionVertical: TCheckBox;
    chMouseInversionHorizontal: TCheckBox;
    miRemoveVehicle: TMenuItem;
    chFullScreenWindowed: TCheckBox;
    Label8: TLabel;
    cbReflectionsFidelity: TComboBox;
    lbDay: TLabel;
    btnCurrentDate: TButton;
    Label12: TLabel;
    cbMaxcabtexturesize: TComboBox;
    tbGlobalSounds: TTrackBar;
    tbPositionalsSounds: TTrackBar;
    tbVehiclesSounds: TTrackBar;
    tbRadioVolume: TTrackBar;
    tbSoundVolume: TTrackBar;
    miAddTrain: TMenuItem;
    actAddTrain: TAction;
    pnlBottom: TPanel;
    sbTrain: TScrollBox;
    Panel3: TPanel;
    lbTrainMassCaption: TLabel;
    lbTrainMass: TLabel;
    lbTrainBruttoCaption: TLabel;
    lbTrainBrutto: TLabel;
    lnTrainLengthCaption: TLabel;
    lbTrainLength: TLabel;
    lbCountVehiclesCaption: TLabel;
    lbCountVehicles: TLabel;
    lbTrackCaption: TLabel;
    lbTrack: TLabel;
    seLoadCount: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbTrainsClick(Sender: TObject);
    procedure cbFeedbackmodeChange(Sender: TObject);
    procedure cbDriverTypeChange(Sender: TObject);
    procedure cbLoadTypeChange(Sender: TObject);
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
    procedure actAddToDepoExecute(Sender: TObject);
    procedure actAddToDepoUpdate(Sender: TObject);
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
    procedure cbLangChange(Sender: TObject);
    procedure chOnlyForDrivingClick(Sender: TObject);
    procedure imFacebookClick(Sender: TObject);
    procedure imMaszynaClick(Sender: TObject);
    procedure actCheckUpdateExecute(Sender: TObject);
    procedure lbVersionDblClick(Sender: TObject);
    procedure lbVersionClick(Sender: TObject);
    procedure actSaveKeyboardExecute(Sender: TObject);
    procedure actKeyboardExecute(Sender: TObject);
    procedure KeysGridClick(Sender: TObject);
    procedure cbKey1Change(Sender: TObject);
    procedure cbKey2Change(Sender: TObject);
    procedure cbKey3Change(Sender: TObject);
    procedure cbBrakeStateChange(Sender: TObject);
    procedure cbBrakeAdjustChange(Sender: TObject);
    procedure pmTrainsetsPopup(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure edFieldofviewExit(Sender: TObject);
    procedure cbBigThumbnailClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chRefAmbientTempClick(Sender: TObject);
    procedure actRemoveTrainUpdate(Sender: TObject);
    procedure actRemoveTrainExecute(Sender: TObject);
    procedure actCopyLoadUpdate(Sender: TObject);
    procedure actCopyLoadExecute(Sender: TObject);
    procedure lbTexturesDblClick(Sender: TObject);
    procedure actCurrentDateExecute(Sender: TObject);
    procedure actSpringExecute(Sender: TObject);
    procedure actSummerExecute(Sender: TObject);
    procedure actAutumnExecute(Sender: TObject);
    procedure actWinterExecute(Sender: TObject);
    procedure cbModelsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure imMiniMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbTrainDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure sbTrainDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure miOpenVehicleDirClick(Sender: TObject);
    procedure actCopyToClipboardExecute(Sender: TObject);
    procedure actCopyToClipboardUpdate(Sender: TObject);
    procedure lbTexturesClick(Sender: TObject);
    procedure actPasteFromClipboardExecute(Sender: TObject);
    procedure actPasteFromClipboardUpdate(Sender: TObject);
    procedure lbModelDblClick(Sender: TObject);
    procedure tvSCNChange(Sender: TObject; Node: TTreeNode);
    procedure cbGfxrendererChange(Sender: TObject);
    procedure imLangClick(Sender: TObject);
    procedure cbModelsChange(Sender: TObject);
    procedure actReplaceTrainExecute(Sender: TObject);
    procedure pcTrainsChange(Sender: TObject);
    procedure chSoundenabledClick(Sender: TObject);
    procedure cbOvercastChange(Sender: TObject);
    procedure ConfigChange(Sender: TObject);
    procedure actCopyTextureNameExecute(Sender: TObject);
    procedure actReloadScenariosExecute(Sender: TObject);
    procedure actOpenTexDirExecute(Sender: TObject);
    procedure actOpenScenarioDirExecute(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    function PaintVehicle(const Tex:TTexture; const ModelID:Integer=0;const Mini:Boolean=True):TBitmap;
    procedure SelectModel(const Tex: TTexture; const ModelID: Integer=0);
    procedure FormDeactivate(Sender: TObject);
    procedure btnCheckUpdateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actCopyLoadToAllUpdate(Sender: TObject);
    procedure actCopyLoadToAllExecute(Sender: TObject);
    procedure actOpenDepoExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actCOMExecute(Sender: TObject);
    procedure actRestoreWeatherExecute(Sender: TObject);
    procedure actLoadDepoFromFileExecute(Sender: TObject);
    procedure actChangeNameExecute(Sender: TObject);
    procedure actChangeNameUpdate(Sender: TObject);
    procedure pmTexturesPopup(Sender: TObject);
    procedure actRestoreWeatherUpdate(Sender: TObject);
    procedure actAutoCouplerExecute(Sender: TObject);
    procedure actAutoCouplerUpdate(Sender: TObject);
    procedure pcSettingsResize(Sender: TObject);
    procedure actCurrentTimeExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chFullScreenWindowedClick(Sender: TObject);
    procedure btnSettingsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actAddTrainExecute(Sender: TObject);
    procedure seLoadCountChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    SCN : TScenario;
    SelTrain : Integer;
    SelVehicle : Integer;

    procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
    procedure OpenAttachment(Sender: TObject);
    procedure DrawTrain(const Train: TTrain);
    procedure RunSimulator;
    procedure SelectVehicle(Sender: TObject;SelectTex:Boolean=True);
    function PrepareTrainsetDesc(const Trainset: TTrain): string;
    procedure LoadMagazine;
    procedure ChangePange(const PageIndex: Integer);
    procedure DrawVehicle(const Vehicle: TVehicle);
    function SelImage: TImage;
    function GetSelList: TTrain;
    procedure SetSelList(const Value: TTrain);
    procedure SelectTrain;
    function GetCoupler: Integer;
    procedure SelectTexture(const Vehicle: TVehicle); overload;

    procedure SelectCoupler(Coupler: Integer);
    procedure LoadModelData(const PhysicsID:Integer);
    procedure ClearTrainScroll;
    procedure RemoveOldVersion;
    procedure LoadKeysComponents;
    procedure LoadTexData(const Tex: TTexture;const ModelID:Integer=-1);
    procedure OpenFile(const Path: string);
    procedure PrepareLoadingScreen;
    procedure DefaultSettings;
    procedure AdaptMiniSize;
    procedure SetItemDesc(const Trainset: TTrain);
    procedure RemoveVehicle(const Index:Integer);
    procedure AppDeactivate(Sender: TObject);
    procedure AppActivate(Sender: TObject);
    procedure ScenariosList;
    procedure BitmapDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ShapeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure AddVehicle(const Position: Integer;Tex:TTexture=nil;CheckPrev:Boolean=True;CheckNext:Boolean=True);
    procedure OnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitmapDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ShapeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MoveVehicle(const FromPos, ToPos: integer);
    procedure RefreshTrain(const SelPos: Integer=-1);
    procedure Mark(const Image: TImage;const Color:TColor=clYellow);
    procedure LoadVehicle(const Vehicle: TVehicle);
    procedure ReloadSettingsState;
    function UniqueVehicleName(const Vehicle:TVehicle):string; overload;
    procedure miTrainClick(Sender: TObject);
    procedure miAddTrainClick(Sender: TObject);
    function GetMaxCoupler(const Vehicle:TVehicle;LeftCoupler:Boolean=True):Integer;
    procedure Connect(const LeftVehicle: Integer);

    procedure ReplaceTrain(const Vehicles: TObjectList<TVehicle>);
    function CommonCoupler(C1,C2:Integer):Integer;
    function CheckFlag(Flag:Integer):TFlags;
    function LoadsIndex(const LoadName: string): Integer;
    procedure AssignTexToVehicle(Vehicle:TVehicle;const Tex: TTexture);
    procedure AssignBrakeActing(Vehicle: TVehicle);
    procedure AssignBrakeAdjust(Vehicle: TVehicle);
    procedure AssignBrakeState(Vehicle: TVehicle);
    procedure TrainDesc;
    procedure NoSelection;
    procedure CheckInstallation;
    function IsVehicleName(const Name: string): Integer;
    procedure LoadScenery(aSCN: TScenario);
    procedure RemoveFromDepot(const Index: Integer);
    procedure LoadWeather(const aSCN: TScenario);
    procedure AddTrain(const Vehicles: TObjectList<TVehicle>);
    function AssignNextVehicles(Tex: TTexture):Integer;
    function AssignPrevVehicles(Tex: TTexture): Integer;
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    Scenarios   : TObjectList<TScenario>;
    Textures    : TObjectList<TTexture>;
    Physics     : TObjectList<TPhysics>;
    Depot       : TObjectList<TTrain>;
    Loads       : TList<TLoad>;
    Settings    : TSettings;
    DIR         : string;
    MiniFactor  : Integer;
    SelList     : TSelectedList;
    Images      : TObjectList<TBitmap>;
    Errors      : TStringList;
    Lang        : string;
    property Train : TTrain read GetSelList write SetSelList;

    function PrepareNode(const Dyn:TVehicle;const TrainSet:Boolean=True): string;
    procedure SelectTexture(const Tex: TTexture;const ModelID:Integer=0); overload;
    procedure OpenDir(const Path: string);
  end;

var
  Main: TMain;

implementation

uses DateUtils, JPEG, ShellApi, uParser, uSettingsAdv, uUpdater, uSearch, uDepo,
     uUART, uAbout, Clipbrd, StrUtils, CommCtrl{, uInstaller};

{$R *.dfm}

procedure TMain.actAboutExecute(Sender: TObject);
begin
  with TfrmAbout.Create(self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMain.actAddToDepoExecute(Sender: TObject);
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

  TParser.SaveDepot;
  LoadMagazine;
end;

procedure TMain.actAddToDepoUpdate(Sender: TObject);
begin
  actAddToDepo.Enabled := (lbTrains2.ItemIndex >= 0) and (Train <> nil) and (Train.Vehicles.Count > 0);
end;

procedure TMain.actAddTrainExecute(Sender: TObject);
begin
  //
end;

function TMain.IsVehicleName(const Name:string):Integer;
var
  i, y : Integer;
begin
  Result := 0;

  for i := 0 to SCN.Trains.Count-1 do
    for y := 0 to SCN.Trains[i].Vehicles.Count-1 do
      if (SCN.Trains[i].Vehicles[y].Texture <> nil)
        and (SameText(SCN.Trains[i].Vehicles[y].Name,Name)) then
        Inc(Result);

  for i := 0 to SCN.Vehicles.Count-1 do
    if SameText(SCN.Vehicles[i].Name,Name) then
      Inc(Result);
end;

function TMain.UniqueVehicleName(const Vehicle:TVehicle):string;
var
  Suffix, Found : Integer;
begin
  if Vehicle.ReplacableSkin.Length > 0 then
    if not SameText('NONE',Vehicle.ReplacableSkin) then
      Result := Vehicle.ReplacableSkin
    else
      if Vehicle.Texture.Models[Vehicle.ModelID].MiniD.Length > 0 then
        Result := Vehicle.Texture.Models[Vehicle.ModelID].MiniD
      else
        Result := Vehicle.Texture.Models[Vehicle.ModelID].Mini;

  Suffix := 0;

  Found := IsVehicleName(Result);
  while Found > 0 do
  begin
    Suffix := Suffix + Found;
    Found := IsVehicleName(Result + IntToStr(Suffix));
  end;

  if Suffix > 0 then
    Result := Result + IntToStr(Suffix);
end;

procedure TMain.AssignTexToVehicle(Vehicle:TVehicle;const Tex:TTexture);
var
  ModelID, i : Integer;
begin
  ModelID := 0;
  for i := 0 to Tex.Models.Count-1 do
    if SameText(Tex.Models[i].Mini,cbModels.Items[cbModels.ItemIndex]) then
    begin
      ModelID := i;
      Break;
    end;

  Vehicle.ModelID   := ModelID;
  Vehicle.Dir       := Tex.Dir;
  Vehicle.ReplacableSkin := Tex.Plik;
  Vehicle.Texture   := Tex;
  Vehicle.TypeChk   := Tex.Models[ModelID].Model;
  Vehicle.PathName  := Tex.Dir;
  Vehicle.Name      := UniqueVehicleName(Vehicle);
end;

procedure TMain.AddVehicle(const Position:Integer;Tex:TTexture=nil;CheckPrev:Boolean=True;CheckNext:Boolean=True);
var
  Vehicle : TVehicle;
  i : Integer;
  Staffed : Boolean;
begin
  if Tex = nil then
    Tex := (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);

  Vehicle := TVehicle.Create;
  Vehicle.MinDist  := -1;
  Vehicle.MaxDist  := 0;
  Vehicle.Dist     := 0;
  Vehicle.Vel      := 0;
  Vehicle.Settings := '0';

  TryStrToInt(edSway.Text,Vehicle.Sway);
  TryStrToInt(edFlatness.Text,Vehicle.Flatness);
  TryStrToInt(edFlatnessProb.Text,Vehicle.FlatnessProb);
  TryStrToInt(edFlatnessRand.Text,Vehicle.FlatnessRand);

  AssignBrakeActing(Vehicle);
  AssignBrakeAdjust(Vehicle);
  AssignBrakeState(Vehicle);

  Vehicle.LoadType := cbLoadType.Text;
  Vehicle.Loadquantity := seLoadCount.Value;

  Train.Vehicles.Insert(Position,Vehicle);

  AssignTexToVehicle(Vehicle,Tex);

  Vehicle.CabOccupancy := coNobody;
  if Vehicle.Texture.Typ in [TTyp.tyELEKTROWOZ..tyEZT] then
  begin
    if Position > 0 then
    begin
      Staffed := False;
      for i := 0 to Position do
        if Train.Vehicles[i].CabOccupancy in [coHeadDriver..coRearDriver] then
        begin
          Staffed := True;
          Break;
        end;
    end;

    if (Position = 0) or (not Staffed) then
      Vehicle.CabOccupancy := coHeadDriver;
  end;

  Connect(Position-1);
  Connect(Position);
  if (Train.Vehicles.Count = 1) and (Vehicle.Coupler = 0) then
    Vehicle.Coupler := 3;

  if (CheckNext) and (Tex.NextTexID >= 0) then
    AddVehicle(Position+1,Textures[Tex.NextTexID],False,True);

  if (CheckPrev) and (Tex.PrevTexID >= 0) then
  begin
    Vehicle.CabOccupancy := coNobody;
    AddVehicle(Position,Textures[Tex.PrevTexID],True,False);
  end;

  TrainDesc;
  RefreshTrain(Position);
end;

function TMain.CommonCoupler(C1,C2:Integer):Integer;
var
  Fs1,Fs2 : TFlags;
  f : TFlag;
begin
  Result := 0;

  Fs1 := CheckFlag(C1);
  Fs2 := CheckFlag(C2);

  for f in [F1,F2,F4,F8,F16,F32,F64,F128] do
    if (f in Fs1) and (f in Fs2) then
      Result := Result + Integer(f);
end;

function TMain.CheckFlag(Flag:Integer):TFlags;
var
  F : TFlag;
begin
  Result := [];

  F := TFlag(128);
  repeat
    if Flag >= Integer(F) then
    begin
      Include(Result,TFlag(F));
      Dec(Flag,Integer(F));
    end;
    F := TFlag(Integer(F) shr 1);
  until Integer(F) <= 0;
end;

procedure TMain.Connect(const LeftVehicle:Integer);
var
  LeftMax, RightMax : Integer;
begin
  if (LeftVehicle >= 0) and (Train.Vehicles.Count-1 > LeftVehicle) then
  begin
    LeftMax := GetMaxCoupler(Train.Vehicles[LeftVehicle],False);

    if Train.Vehicles.Count-1 > LeftVehicle then
      RightMax  := GetMaxCoupler(Train.Vehicles[LeftVehicle+1])
    else
      RightMax := 3;

    Train.Vehicles[LeftVehicle].Coupler := CommonCoupler(LeftMax,RightMax);
  end;
end;

function TMain.GetMaxCoupler(const Vehicle:TVehicle;LeftCoupler:Boolean=True):Integer;
begin
  if Vehicle.Texture <> nil then
  begin
    if LeftCoupler then
    begin
      if Vehicle.Dist >= 0 then
        Result := Physics[Vehicle.Texture.Models[Vehicle.ModelID].Fiz].AllowedFlagA
      else
        Result := Physics[Vehicle.Texture.Models[Vehicle.ModelID].Fiz].AllowedFlagB;
    end
    else
    begin
      if Vehicle.Dist >= 0 then
        Result := Physics[Vehicle.Texture.Models[Vehicle.ModelID].Fiz].AllowedFlagB
      else
        Result := Physics[Vehicle.Texture.Models[Vehicle.ModelID].Fiz].AllowedFlagA;
    end;
  end
  else
    Result := 3;
end;

procedure TMain.RefreshTrain(const SelPos:Integer=-1);
var
  ScrollPos : Integer;
begin
  ScrollPos := sbTrain.HorzScrollBar.Position;

  if SelPos >= 0 then
    SelVehicle := SelPos;

  DrawTrain(Train);
  sbTrain.HorzScrollBar.Position := ScrollPos;

  SetItemDesc(Train);
end;

procedure TMain.actAddVehicleExecute(Sender: TObject);
begin
  AddVehicle(SelVehicle+1);
end;

procedure TMain.actAddVehicleUpdate(Sender: TObject);
begin
  actAddVehicle.Enabled := (lbTextures.ItemIndex >= 0) and (SelTrain >= 0);
end;

procedure TMain.actAutoCouplerExecute(Sender: TObject);
begin
  Connect(SelVehicle);
  SelectCoupler(Train.Vehicles[SelVehicle].Coupler);
end;

procedure TMain.actAutoCouplerUpdate(Sender: TObject);
begin
  actAutoCoupler.Enabled := (SelVehicle >= 0) and (Train.Vehicles.Count-1 > SelVehicle);
end;

procedure TMain.actAutumnExecute(Sender: TObject);
begin
  tbDay.Position := 297;
end;

procedure TMain.actChangeNameExecute(Sender: TObject);
var
  TrainName : string;
begin
  TrainName := InputBox(
                      'Zmiana nazwy poci¹gu',
                      'Nazwa poci¹gu:',
                      Depot[lbDepot.ItemIndex].TrainName);

  if TrainName.Length > 0 then
  begin
    if Trim(TrainName).Length > 0 then
      Depot[lbDepot.ItemIndex].TrainName := TrainName
    else
      Depot[lbDepot.ItemIndex].TrainName := '';

    TParser.SaveDepot;
    LoadMagazine;
  end;
end;

procedure TMain.actChangeNameUpdate(Sender: TObject);
begin
  actChangeName.Visible := lbDepot.ItemIndex >= 0;
end;

procedure TMain.actCheckUpdateExecute(Sender: TObject);
begin
  TfrmUpdater.UpdateProgram;
end;

procedure TMain.actCOMExecute(Sender: TObject);
begin
  with TfrmUART.Create(self) do
  try
    ShowModal;
  finally
    Free;
  end;
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

    seLoadCount.Value := Train.Vehicles[SelVehicle].Loadquantity;
  end;
end;

procedure TMain.actCopyLoadToAllExecute(Sender: TObject);
var
  i : Integer;
begin
  for i := SelVehicle + 1 to Train.Vehicles.Count-1 do
  begin
    if ContainsText(Physics[Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz].LoadAccepted,cbLoadType.Text) then
    begin
      Train.Vehicles[i].LoadType := cbLoadType.Text;
      Train.Vehicles[i].Loadquantity := seLoadCount.Value;
    end;
  end;
end;

procedure TMain.actCopyLoadToAllUpdate(Sender: TObject);
begin
  actCopyLoadToAll.Enabled := (Train <> nil) and (Train.Vehicles.Count-1 > SelVehicle);
end;

procedure TMain.actCopyLoadUpdate(Sender: TObject);
begin
  actCopyLoad.Enabled := SelVehicle > 0;
end;

procedure TMain.actCopyTextureNameExecute(Sender: TObject);
begin
  if lbTextures.Count > 0 then
    Clipboard.AsText := lbTextures.Items[lbTextures.ItemIndex];
end;

procedure TMain.actCopyToClipboardExecute(Sender: TObject);
var
  i : Integer;
  Str : string;
begin
  str := 'trainset ' + Train.TrainName + ' ' + Train.Track + ' ' + FloatToStr(Train.Dist) + ' ' + FloatToStr(Train.Vel) + #13#10;
  for i := 0 to Train.Vehicles.Count-1 do
    str := str + PrepareNode(Train.Vehicles[i]) + #13#10;
  str := str + 'endtrainset';
  Clipboard.AsText := str;
end;

procedure TMain.actCopyToClipboardUpdate(Sender: TObject);
begin
  actCopyToClipboard.Visible := (Train <> nil) and (Train.Vehicles.Count > 0);
end;

procedure TMain.actCurrentDateExecute(Sender: TObject);
begin
  tbDay.Position := DayOfTheYear(Now);
end;

procedure TMain.actCurrentTimeExecute(Sender: TObject);
begin
  dtTime.Time := TimeOf(Now);
end;

procedure TMain.DefaultSettings;
begin
  cbResolution.ItemIndex := 0;

  chFullScreen.Checked                    := False;
  chInactivepause.Checked                 := True;
  chPause.Checked                         := False;
  chSoundenabled.Checked                  := True;
  chDebugmode.Checked                     := False;
  chGfxresourcesweep.Checked              := False;
  chGfxresourcemove.Checked               := False;
  chShadows.Checked                       := True;
  chVsync.Checked                         := False;
  chUsevbo.Checked                        := True;
  chFullphysics.Checked                   := True;
  chEnabletraction.Checked                := True;
  chLivetraction.Checked                  := True;
  chPhysicslog.Checked                    := False;
  chDebuglog.Checked                      := True;
  chDebugLogVis.Checked                   := True;
  chMultiplelogs.Checked                  := False;
  chInputgamepad.Checked                  := False;
  chMotionBlur.Checked                    := True;
  chEnvmap.Checked                        := True;
  chSmoke.Checked                         := True;
  chExtraEffects.Checked                  := True;
  frmSettingsAdv.chScaleSpeculars.Checked := True;
  chShadowMap.Checked                     := True;
  chPythonEnabled.Checked                 := True;
  chPythonThreadedUpload.Checked          := True;
  chSkipRendering.Checked                 := False;
  chCrashDamage.Checked                   := True;
  chChromaticAberration.Checked           := False;
  chSkipPipeline.Checked                  := False;
  chMouseInversionVertical.Checked        := False;
  chMouseInversionHorizontal.Checked      := False;
  frmSettingsAdv.chCompressTex.Checked    := True;

  cbMouseScale.ItemIndex                := 0;
  cbLang.ItemIndex                      := 0;

  tbSoundVolume.Position                := 15;
  tbRadioVolume.Position                := 10;
  tbVehiclesSounds.Position             := 10;
  tbPositionalsSounds.Position          := 10;
  tbGlobalSounds.Position               := 8;

  cbReflectionsFidelity.ItemIndex       := 0;

  frmSettingsAdv.cbConvertmodels.ItemIndex := 0;

  cbMaxtexturesize.ItemIndex            := 5;
  cbMaxcabtexturesize.ItemIndex         := 0;
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
  cbShadowRange.ItemIndex               := 4;

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

procedure TMain.actKeyboardExecute(Sender: TObject);
begin
  Settings.ReadKeyboard;
  LoadKeysComponents;
  ChangePange(3);
end;

procedure TMain.actLoadDepoFromFileExecute(Sender: TObject);
begin
  if OD.Execute then
  begin
    with TParser.Create do
    try
      ReadDepot(OD.FileName);
      LoadMagazine;
      SaveDepot;
    finally
      Free;
    end;
  end;
end;

procedure TMain.actOpenDepoExecute(Sender: TObject);
var
  Form : TForm;
begin
  Form := Application.FindComponent('frmDepo') as TForm;

  if Form <> nil then
    Form.Show
  else
    with TfrmDepo.Create(Application) do
      Show;
end;

procedure TMain.actOpenScenarioDirExecute(Sender: TObject);
begin
  if (tvSCN.Selected <> nil) and (tvSCN.Selected.Data <> nil) then
    OpenDir(ExtractFileDir( TScenario(tvSCN.Selected.Data).Path));
end;

procedure TMain.actOpenTexDirExecute(Sender: TObject);
begin
  if lbTextures.Count > 0 then
    OpenDir(DIR + 'dynamic\' + (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture).Dir);
end;

procedure TMain.actPasteFromClipboardExecute(Sender: TObject);
var
  ClipTrain : TTrain;
begin
  ClipTrain := TParser.ParseTrainFromClipBoard(Clipboard.AsText);
  if ClipTrain <> nil then
    ReplaceTrain(ClipTrain.Vehicles);
end;

procedure TMain.actPasteFromClipboardUpdate(Sender: TObject);
begin
  actPasteFromClipboard.Visible := (Clipboard.AsText.Length > 50);
end;

procedure TMain.actReloadScenariosExecute(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to Scenarios.Count-1 do
    TParser.ParseScenario(Scenarios[i]);
  if tvSCN.Selected <> nil then
    LoadScenery(TScenario(tvSCN.Selected.Data));
end;

procedure TMain.RemoveFromDepot(const Index:Integer);
begin
  Depot.Extract(Depot[Index]);
  TParser.SaveDepot;
  LoadMagazine;
  if Depot.Count > 0 then
  begin
    SelTrain := lbDepot.ItemIndex;
    SelectTrain;
  end
  else
  begin
    NoSelection;
    ClearTrainScroll;
  end;
end;

procedure TMain.actRemoveFromDepotExecute(Sender: TObject);
begin
  RemoveFromDepot(lbDepot.ItemIndex);
end;

procedure TMain.actRemoveFromDepotUpdate(Sender: TObject);
begin
  actRemoveFromDepot.Enabled := lbDepot.ItemIndex >= 0;
end;

procedure TMain.actRemoveTrainExecute(Sender: TObject);
begin
  if SelList = slSCN then
  begin
    while Train.Vehicles.Count > 0 do
      RemoveVehicle(SelVehicle);

    TrainDesc;
    DrawTrain(Train);
  end
  else
    RemoveFromDepot(lbDepot.ItemIndex);
end;

procedure TMain.RemoveVehicle(const Index:Integer);
begin
  Train.Vehicles.Extract(Train.Vehicles[Index]);

  if Index > Train.Vehicles.Count-1  then
    Dec(SelVehicle);
end;

procedure TMain.actRemoveTrainUpdate(Sender: TObject);
begin
  actRemoveTrain.Visible := (Train <> nil) and (Train.Vehicles.Count > 0);
end;

procedure TMain.actRemoveVehicleExecute(Sender: TObject);
begin
  RemoveVehicle(SelVehicle);

  if SelList = slSCN then
    SetItemDesc(Train)
  else
    if Train.Vehicles.Count > 0 then
      lbDepot.Items[lbDepot.ItemIndex] := PrepareTrainsetDesc(Train)
    else
      RemoveFromDepot(lbDepot.ItemIndex);

  DrawTrain(Train);
end;

procedure TMain.actRemoveVehicleUpdate(Sender: TObject);
begin
  actRemoveVehicle.Enabled := SelVehicle >= 0;
end;

procedure TMain.actReplaceTrainExecute(Sender: TObject);
begin
  //
end;

procedure TMain.actRestoreWeatherExecute(Sender: TObject);
begin
  LoadWeather(TScenario(tvSCN.Selected.Data));
end;

procedure TMain.actRestoreWeatherUpdate(Sender: TObject);
begin
  actRestoreWeather.Enabled := (tvSCN.SelectionCount > 0) and (tvSCN.Selected.Data <> nil);
end;

procedure TMain.actSaveKeyboardExecute(Sender: TObject);
begin
  Settings.SaveKeyboardSettings;
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
  Config : TConfig;
begin
  btnStart.Enabled := False;
  Starter := TStringList.Create;

  Starter.Text := SCN.Other.Text;

  Config := SCN.Config;
  Config.FogEnd       := (tbFog.Max - tbFog.Position) + tbFog.Min;
  Config.Day          := tbDay.Position;
  Config.Temperature  := tbTemperature.Position;
  Config.Time         := dtTime.Time;
  SCN.Config := Config;
  Starter.Text := TParser.ChangeConfig(SCN.Other.Text,SCN.Config);

  if cbBattery.ItemIndex = 1 then
    Train.Vel := 0
  else
    if cbBattery.ItemIndex = 2 then
      if Train.Vel < 0.2 then
        Train.Vel := 0.1;

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
  actStart.Enabled := (SelList = slSCN) and (SelTrain >= 0) and (SelVehicle >= 0)
                      and (Train.Vehicles[SelVehicle].CabOccupancy in [coHeadDriver,coRearDriver,coPassenger])
                      and (cbEXE.ItemIndex >= 0) and (tvSCN.Selected.Data <> nil);
end;

procedure TMain.actSummerExecute(Sender: TObject);
begin
  tbDay.Position := 204;
end;

procedure TMain.actWinterExecute(Sender: TObject);
begin
  tbDay.Position := 15;
end;

procedure TMain.btnCheckUpdateMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssRight in Shift then
    TfrmUpdater.UpdateProgram(True);
end;

procedure TMain.btnHelpClick(Sender: TObject);
var
  Param : TParam;
begin
  Param := Settings.FindParam('lang');

  if (Param <> nil) then
    if SameText(Param.Value,'pl') then
      OpenFile('\readme.html')
    else
      OpenFile('\en-readme.html');
end;

procedure TMain.btnSearchClick(Sender: TObject);
var
  Form : TForm;
begin
  Form := Application.FindComponent('frmSearch') as TForm;

  if Form <> nil then
    Form.Show
  else
    with TfrmSearch.Create(Application) do
      Show;
end;

procedure TMain.btnSettingsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssRight in Shift then
    frmSettingsAdv.Show;
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
  try
    JPG := TJPEGImage.Create;
    FilesList := TStringList.Create;

    if FileExists(Self.DIR + '\textures\logo\' + SCN.Name + '.jpg') then
      JPG.LoadFromFile(Self.DIR + '\textures\logo\' + SCN.Name + '.jpg')
    else
    begin
      FoundFiles := FindFirst(Self.DIR + '\textures\logo\logo*.jpg',faAnyFile,SR);
      while (FoundFiles = 0) do
      begin
        if (SR.Name <> '.') and (SR.Name <> '..') then
          FilesList.Add(SR.Name);

        FoundFiles := FindNext(SR);
      end;
      FindClose(SR);

      JPG.LoadFromFile(Self.DIR + '\textures\logo\' + FilesList[Random(FilesList.Count)]);
    end;

    Bmp := TBitmap.Create;
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

  PrepareLoadingScreen;

  Parameters := '-s ' + '$' + SCN.Name + '.scn';
  Parameters := Parameters + ' -v ' + Train.Vehicles[SelVehicle].Name;
  ZeroMemory(@SEI, SizeOf(SEI));
  SEI.cbSize := SizeOf(SEI);//

  if cbEXE.ItemIndex = 0 then
    SEI.lpFile := PChar(DIR + cbEXE.Items[cbEXE.Items.Count-1])
  else
    SEI.lpFile := PChar(DIR + cbEXE.Text);

  try
    if not FileExists(SEI.lpFile) then
    begin
      raise Exception.Create('Nie znaleziono pliku wykonywalnego (eu07*.exe) symulatora.');
      btnStart.Enabled := True;
    end;

    SEI.lpParameters := PChar(Parameters);
    SEI.lpDirectory := PChar(DIR);
    SEI.nShow := SW_SHOWNORMAL;
    ShellExecuteEx(@SEI);

    if cbCloseApp.Checked then
      Application.Terminate;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TMain.sbTrainDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  AddVehicle(Train.Vehicles.Count);
end;

procedure TMain.sbTrainDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Sender <> Source) and (lbTextures.ItemIndex >= 0) and (SelTrain >= 0);
end;

procedure TMain.AssignBrakeActing(Vehicle:TVehicle);
begin
  case cbBrakeActing.ItemIndex of
    0: Vehicle.Brake := '';
    1: Vehicle.Brake := 'G';
    2: Vehicle.Brake := 'P';
    3: Vehicle.Brake := 'R';
    4: Vehicle.Brake := 'M';
    5: Vehicle.Brake := 'Q';
  end;
end;

procedure TMain.AssignBrakeAdjust(Vehicle:TVehicle);
begin
  case cbBrakeAdjust.ItemIndex of
    0: Vehicle.BrakeAdjust := '';
    1: Vehicle.BrakeAdjust := 'T';
    2: Vehicle.BrakeAdjust := 'H';
    3: Vehicle.BrakeAdjust := 'F';
  end;
end;

procedure TMain.AssignBrakeState(Vehicle:TVehicle);
begin
  case cbBrakeState.ItemIndex of
    0: Vehicle.BrakeState := '';
    1: Vehicle.BrakeState := '0';
    2: Vehicle.BrakeState := '1';
  end;
end;

procedure TMain.cbBrakeActingChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    AssignBrakeActing(Train.Vehicles[SelVehicle]);
end;

procedure TMain.cbBrakeAdjustChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    AssignBrakeAdjust(Train.Vehicles[SelVehicle]);
end;

procedure TMain.cbBrakeStateChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    AssignBrakeState(Train.Vehicles[SelVehicle]);
end;

procedure TMain.cbDriverTypeChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
  begin
    Train.Vehicles[SelVehicle].CabOccupancy := TCabOccupancy(cbDriverType.ItemIndex);
    if Train.Vehicles[SelVehicle].CabOccupancy in [coHeadDriver, coRearDriver, coPassenger] then
      Mark(SelImage)
    else
      Mark(SelImage,clWebLimeGreen);
  end;
end;

procedure TMain.cbFeedbackmodeChange(Sender: TObject);
begin
  pnlFeedBackPort.Visible := cbFeedbackmode.ItemIndex = 3;
  actCOM.Visible := cbFeedbackmode.ItemIndex = 5;
end;

procedure TMain.cbGfxrendererChange(Sender: TObject);
begin
  if cbGfxrenderer.ItemIndex = 1 then
  begin
    chShadowMap.Checked     := False;
    chExtraEffects.Checked  := False;
  end;

  ReloadSettingsState;
end;

procedure TMain.ReloadSettingsState;
begin
  chMotionBlur.Enabled            := cbGfxrenderer.ItemIndex = 0;
  chChromaticAberration.Enabled   := cbGfxrenderer.ItemIndex = 0;

  chUsevbo.Enabled                := cbGfxrenderer.ItemIndex > 0;

  chUsevbo.Enabled                := cbGfxrenderer.ItemIndex > 1;

  chShadowMap.Enabled             := cbGfxrenderer.ItemIndex < 2;
  chExtraEffects.Enabled          := cbGfxrenderer.ItemIndex < 2;

  chShadows.Enabled               := cbGfxrenderer.ItemIndex = 2;

  chEnvmap.Enabled                := cbGfxrenderer.ItemIndex < 3;
  Label53.Enabled                 := cbGfxrenderer.ItemIndex < 3;
  cbShadowsCabRange.Enabled       := cbGfxrenderer.ItemIndex < 3;
  Label36.Enabled                 := cbGfxrenderer.ItemIndex < 3;
  cbShadowMapSize.Enabled         := cbGfxrenderer.ItemIndex < 3;
  Label43.Enabled                 := cbGfxrenderer.ItemIndex < 3;
  cbShadowRange.Enabled           := cbGfxrenderer.ItemIndex < 3;
  Label18.Enabled                 := cbGfxrenderer.ItemIndex < 3;
  cbReflectionsFramerate.Enabled  := cbGfxrenderer.ItemIndex < 3;

  chSkipPipeline.Checked          := cbGfxrenderer.ItemIndex = 1;

  label6.Enabled                  := chSoundenabled.Checked;
  tbSoundVolume.Enabled           := chSoundenabled.Checked;
  tbRadioVolume.Enabled           := chSoundenabled.Checked;
  tbVehiclesSounds.Enabled        := chSoundenabled.Checked;
  tbPositionalsSounds.Enabled     := chSoundenabled.Checked;
  tbGlobalSounds.Enabled          := chSoundenabled.Checked;

  Label14.Enabled                 := not chFullScreenWindowed.Checked;
  cbResolution.Enabled            := not chFullScreenWindowed.Checked;
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
  i : Integer;
begin
  i := cbTypes.ItemIndex;
  Param := Settings.FindParam('lang');

  if (Param <> nil) and (not SameText(Param.Value,cbLang.Text)) then
  begin
    Settings.SaveSettings;
    Settings.ReadOwnSettings;
    Settings.ReadSettings;
  end;

  cbTypes.ItemIndex := i;
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

procedure TMain.cbModelsChange(Sender: TObject);
begin
  if (cbTypes.ItemIndex in [Ord(TTyp.tySZYNOBUS)..Ord(TTyp.tyEZT)])
      or ((cbTypes.ItemIndex = Ord(TTyp.tyELEKTROWOZ)) and (Pos('ET4',cbModels.Items[cbModels.ItemIndex]) > 0)) then
    if lbTextures.Count > lbTextures.Tag then
    begin
      lbTextures.Items.BeginUpdate;
      lbTextures.ItemIndex := lbTextures.Tag;
      lbTextures.Items.EndUpdate;
      lbTexturesClick(nil);
    end;
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
      if SameText(Textures[i].Models[y].Mini,cbModels.Items[cbModels.ItemIndex]) then
      begin
        lbTextures.AddItem(Textures[i].Plik,Textures[i]);
        Break;
      end;

  lbTextures.Sorted := True;
  lbTextures.Items.EndUpdate;
end;

procedure TMain.cbModelsDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  ComboBox: TComboBox;
  ItemWidth : Integer;
begin
  ComboBox := (Control as TComboBox);
  try
    with ComboBox.Canvas do
    begin
      FillRect(Rect);

      ItemWidth := (cbModels.Width-GetSystemMetrics(SM_CYHSCROLL)) shr 1;

      if Images[Index].Handle <> 0 then
        Draw(ItemWidth -(Images[Index].Width shr 1), Rect.Top, Images[Index]);
      Rect := Bounds(
        ItemWidth - (TextWidth(ComboBox.Items[Index]) shr 1),
        Rect.Top+15,
        Rect.Right - Rect.Left,
        Rect.Bottom - Rect.Top);
      DrawText(
        handle,
        PChar(ComboBox.Items[Index]),
        length(ComboBox.Items[index]),
        Rect,
        DT_VCENTER + DT_SINGLELINE);
    end;
  finally
  end;
end;

procedure TMain.cbOvercastChange(Sender: TObject);
var
  Config : TConfig;
begin
  if SCN <> nil then
  begin
    Config := SCN.Config;
    case cbOvercast.ItemIndex of
      0: Config.Overcast := -1.5;
      1: Config.Overcast := 0;
      2: Config.Overcast := 0.3;
      3: Config.Overcast := 0.7;
      4: Config.Overcast := 1.0;
      5: Config.Overcast := 1.1;
      6: Config.Overcast := 1.5;
    end;
    SCN.Config := Config;
  end;
end;

procedure TMain.cbTypesClick(Sender: TObject);
var
  i, y : Integer;
  slModels : TStringList;
  Bitmap : TBitmap;
begin
  slModels := TStringList.Create;
  slModels.Sorted := True;
  slModels.Duplicates := dupIgnore;

  for i := 0 to Textures.Count-1 do
    if Ord(Textures[i].Typ) = cbTypes.ItemIndex then
      for y := 0 to Textures[i].Models.Count-1 do
        slModels.Add(Textures[i].Models[y].Mini);

  if Assigned(Images) then
    Images.Free;
  Images := TObjectList<TBitmap>.Create;
  for i := 0 to slModels.Count-1 do
  begin
    Bitmap := TBitmap.Create;
    if FileExists(DIR + '\textures\mini\' + slModels[i] + '.bmp') then
      Bitmap.LoadFromFile(DIR + '\textures\mini\' + slModels[i] + '.bmp')
    else
      Bitmap.LoadFromFile(DIR + '\textures\mini\other.bmp');
    Images.Add(Bitmap);
  end;

  cbModels.Items.BeginUpdate;
  cbModels.Items.Assign(slModels);
  cbModels.Items.EndUpdate;
  slModels.Free;

  if cbModels.Items.Count > 0 then
  begin
    cbModels.ItemIndex := 0;
    cbModelsClick(self);
  end
  else
    lbTextures.Clear;
end;

procedure TMain.chFullScreenWindowedClick(Sender: TObject);
begin
  ReloadSettingsState;
end;

procedure TMain.chOnlyForDrivingClick(Sender: TObject);
begin
  tvSCNChange(chOnlyForDriving,tvSCN.Selected);
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

procedure TMain.chSoundenabledClick(Sender: TObject);
begin
  ReloadSettingsState;
end;

procedure TMain.clCouplersClick(Sender: TObject);
var
  CouplerOld, Coupler, SelectCouplerMax, NextCouplerMax : Integer;
  Flag : TFlag;
begin
  if SelVehicle = -1 then exit;

  Coupler := GetCoupler;
  CouplerOld := Train.Vehicles[SelVehicle].Coupler;

  if Coupler > CouplerOld then
  begin
    if (Train.Vehicles[SelVehicle].Texture <> nil) then
      SelectCouplerMax  := GetMaxCoupler(Train.Vehicles[SelVehicle],False)
    else
      SelectCouplerMax := 3;

    if (Train.Vehicles[SelVehicle+1].Texture <> nil) then
      NextCouplerMax    := GetMaxCoupler(Train.Vehicles[SelVehicle+1])
    else
      NextCouplerMax := 3;

    Flag := TFlag(Coupler-CouplerOld);

    if (Flag in CheckFlag(SelectCouplerMax)) and (Flag in CheckFlag(NextCouplerMax)) then
    begin
      Train.Vehicles[SelVehicle].Coupler := Coupler;
      clCouplers.Hint := Train.Vehicles[SelVehicle].Coupler.ToString
    end
    else
    begin
      Train.Vehicles[SelVehicle].Coupler := CouplerOld;
      SelectCoupler(CouplerOld);
      ShowMessage('Niedopuszczalny rodzaj po³¹czenia miêdzy tymi pojazdami.');
    end;
  end
  else
  begin
    Train.Vehicles[SelVehicle].Coupler := Coupler;
    clCouplers.Hint := Coupler.ToString;
  end;
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
  pnlBottom.Visible := Pages.ActivePage.PageIndex < tsSettings.PageIndex;

  if PageIndex = 0 then
  begin
    SelList := slSCN;
    pcTrains.ActivePageIndex := 0;
    pcTrainsChange(self);
  end;
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

  if (Dyn.LoadType.Length > 0) and (Dyn.Loadquantity > 0) then
    Result := Result + ' ' + Dyn.LoadType;

  Result := Result + ' enddynamic';
end;

procedure TMain.RemoveOldVersion;
begin
  try
    if FileExists(DIR + 'StarterOld.exe') then
      DeleteFile(DIR + 'StarterOld.exe');
  except
    on E: Exception do
      Errors.Add('Nie uda³o siê usun¹æ poprzedniej wersji Startera. Szczegó³y b³êdu: ' + E.Message);
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

procedure TMain.FormActivate(Sender: TObject);
begin
  AppActivate(Application);
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Settings.SaveSettings;
end;

procedure TMain.CheckInstallation;
var
  Err : string;
begin
  if DirectoryExists(DIR + 'dynamic') = False then
    Err := Err + 'Brak katalogu /dynamic ' + #13#10;

  if DirectoryExists(DIR + 'sounds') = False then
    Err := Err + 'Brak katalogu /sounds ' + #13#10;

  if DirectoryExists(DIR + 'models') = False then
    Err := Err + 'Brak katalogu /models ' + #13#10;

  if DirectoryExists(DIR + 'scenery') = False then
    Err := Err + 'Brak katalogu /scenery ' + #13#10;

  if DirectoryExists(DIR + 'textures') = False then
    Err := Err + 'Brak katalogu /textures ' + #13#10;

  if FileExists(DIR + 'data/load_weights.txt') = False then
    Err := Err + 'Brak informacji o wagach ³adunków.' + #13#10;

  if Scenarios.Count = 0 then
    Err := Err + 'Nie znaleziono scenariuszy.' + #13#10;

  if Textures.Count = 0 then
    Err := Err + 'Nie znaleziono pojazdów.' + #13#10;

  if Physics.Count = 0 then
    Err := Err + 'Nie znaleziono danych taboru.' + #13#10;

  if cbEXE.Items.Count = 0 then
    Err := Err + 'Nie znaleziono pliku wykonywalnego symulatora.' + #13#10;

  if Err.Length > 0 then
    ShowMessage(Err + 'Mo¿liwa b³êdna instalacja symulatora.');

  if Pos('\Program Files',DIR) > 0 then
    Err := Err + 'Program zainstalowany w katalogu Program Files.';

  Errors.Add(Err);
end;

procedure TMain.ConfigChange(Sender:TObject);
begin
  lbDay.Caption := IntToStr(tbDay.Position);
  lbTemperature.Caption := IntToStr(tbTemperature.Position) + '°C';
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  Errors := TStringList.Create;
  Application.OnActivate    := AppActivate;
  Application.OnDeactivate  := AppDeactivate;

  DIR := ExtractFilePath(ParamStr(0));
  //DIR := 'G:\MaSzyna\MaSzyna2009\';
  //DIR := 'G:\MaSzyna\pctga\';
  //DIR := 'G:\MaSzyna\MaSzyna1908\';

  RemoveOldVersion;

  FormatSettings.DecimalSeparator := '.';

  Textures  := TObjectList<TTexture>.Create;
  Physics   := TObjectList<TPhysics>.Create;
  Scenarios := TObjectList<TScenario>.Create();
  Depot     := TObjectList<TTrain>.Create;
  Loads     := TList<TLoad>.Create;

  TParser.LoadData;

  Settings := TSettings.Create;
  Settings.ReadOwnSettings(True);
end;

procedure TMain.ScenariosList;
var
  i, y : Integer;
  Found : boolean;
begin
  i := 0;
  tvSCN.Items.BeginUpdate;

  while i < Scenarios.Count do
  begin
    if Scenarios[i].ID = '-' then
    begin
      tvSCN.Items.AddObject(nil,Scenarios[i].Name,Scenarios[i]);
      Inc(i);
    end
    else
    begin
      Found := False;
      for y := 0 to tvSCN.Items.Count-1 do
      begin
          if SameStr(tvSCN.Items[y].Text, Scenarios[i].ID) then
          begin
            tvSCN.Items.AddChildObject(tvSCN.Items[y],Scenarios[i].Name,Scenarios[i]);
            Inc(i);
            Found := True;
            break;
          end;
      end;

      if not Found then
        tvSCN.Items.Add(nil,Scenarios[i].ID);
    end;
  end;

  tvSCN.Items.EndUpdate;
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

function CompareNames(Item1, Item2: Pointer): Integer;
begin
  if (TTrain(Item1).Vehicles.Count > 0) and (TTrain(Item2).Vehicles.Count > 0) then
    Result := CompareText(TTrain(Item1).Vehicles[0].Name, TTrain(Item2).Vehicles[0].Name)
  else
    Result := -1;
end;

procedure TMain.LoadMagazine;
var
  i : Integer;
begin
  try
    lbDepot.Items.BeginUpdate;
    lbDepot.Clear;

    Depot.Sort(TComparer<TTrain>.Construct(
        function (const L, R: TTrain): integer
        begin
          result := CompareNames(L, R);
        end
    ));

    for i := 0 to Depot.Count-1 do
      if Depot[i].TrainName.Length > 0 then
        lbDepot.AddItem(Depot[i].TrainName + ': ' + PrepareTrainsetDesc(Depot[i]),TObject(i))
      else
        lbDepot.AddItem(PrepareTrainsetDesc(Depot[i]),TObject(i));

    lbDepot.Items.EndUpdate;

    if lbDepot.Count > 0 then
      lbDepot.ItemIndex := lbDepot.Count-1;
  except
    on E: Exception do
    begin
      ShowMessage('B³¹d wczytywania sk³adów z magazynu. Szczegó³y b³êdu: ' + E.Message);
      Errors.Add('B³¹d wczytywania magazynu. Szczegó³y b³êdu: ' + E.Message);
    end;
  end;
end;

procedure TMain.AppActivate(Sender: TObject);
begin
  RegisterHotKey(Handle, VK_DELETE, 0, VK_DELETE);
  RegisterHotKey(Handle, VK_INSERT, 0, VK_INSERT);
  btnStart.Enabled := True;
end;

procedure TMain.AppDeactivate(Sender: TObject);
begin
  UnRegisterHotKey(Handle, VK_DELETE);
  UnRegisterHotKey(Handle, VK_INSERT);
  btnStart.Enabled := False;
end;

procedure TMain.FormDeactivate(Sender: TObject);
begin
  AppDeactivate(Application);
end;

procedure TMain.FormDestroy(Sender: TObject);
//var
//  i : Integer;
begin
  {for i := 0 to Textures.Count-1 do
  begin
    if TTexError.teNoFile in Textures[i].Errors then
      Errors.Add('Brak pliku ' + Textures[i].Dir + '\' + Textures[i].Plik);
    if TTexError.teNoModel in Textures[i].Errors then
      Errors.Add('Brak modelu dla tekstury ' + Textures[i].Dir + '\' + Textures[i].Plik);
    if TTexError.teNoPhysics in Textures[i].Errors then
      Errors.Add('Brak fizyki dla tekstury ' + Textures[i].Dir + '\' + Textures[i].Plik);
    if TTexError.teNoMultimedia in Textures[i].Errors then
      Errors.Add('Brak pliku mulitmediów dla tekstury ' + Textures[i].Dir + '\' + Textures[i].Plik);
  end;}

  Scenarios.Free;
  Textures.Free;
  Physics.Free;
  Depot.Free;
  Loads.Free;

  if Errors.Count > 0 then
    if ForceDirectories(Main.DIR + '\starter') then
      Errors.SaveToFile(Main.DIR + '\starter\bledy.txt');
  Errors.Free;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  DefaultSettings;
  Settings.ReadSettings;
  ReloadSettingsState;
  AdaptMiniSize;

  NoSelection;
  ScenariosList;

  Pages.Pages[0].TabVisible := False;
  Pages.Pages[1].TabVisible := False;
  Pages.Pages[2].TabVisible := False;
  Pages.ActivePageIndex := 0;
  pcVehicleInfo.Left := 0;

  if tvSCN.Items.Count > 0 then
  begin
    if tvSCN.Items[0].Data <> nil then
      tvSCN.Select(tvSCN.Items[0])
    else
      if tvSCN.Items[1].Data <> nil then
        tvSCN.Select(tvSCN.Items[1]);
    tvSCN.SetFocus;
  end;

  LoadMagazine;
  CheckInstallation;
end;

function TMain.GetSelList: TTrain;
begin
  if SelTrain >= 0 then
    if SelList = slSCN then
        Result := SCN.Trains[SelTrain]
    else
	    Result := Depot[SelTrain]
  else
    Result := nil;
end;

procedure TMain.imFacebookClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar('https://www.facebook.com/MaSzynaeu07pl/'),nil,nil, SW_SHOWNORMAL)
end;

procedure TMain.imLangClick(Sender: TObject);
begin
  if cbLang.ItemIndex = 0 then
    cbLang.ItemIndex := 1
  else
    cbLang.ItemIndex := 0;
  cbLangChange(self);
end;

procedure TMain.imMaszynaClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar('https://eu07.pl/'),nil,nil, SW_SHOWNORMAL)
end;

procedure TMain.BitmapDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  if Source is TImage then
    Accept := (Source as TImage).Tag <> (Sender as TImage).Tag
  else
  if Source is TShape then
    Accept := (Source as TShape).Tag <> (Sender as TImage).Tag;
end;

procedure TMain.ShapeDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if X > ((Sender as TShape).Width shr 1) then
    AddVehicle((Sender as TShape).Tag + 1)
  else
    AddVehicle((Sender as TShape).Tag);
end;

procedure TMain.ShapeDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TImage) and ((Source as TImage).Name = 'imMini');
end;

procedure TMain.LoadScenery(aSCN:TScenario);
var
  i : Integer;
  Mini : TJPEGImage;
  Attachment : TButton;
begin
  SelTrain := -1;

  SCN := aSCN;

  if (SCN.Vehicles.Count = 0) and (SCN.Trains.Count = 0) then
    TParser.ParseScenario(SCN);

  while sbAttachments.ControlCount > 0 do
    sbAttachments.Controls[0].Free;

  for i := 0 to SCN.Files.Count-1 do
  begin
    Attachment := TButton.Create(self);
    Attachment.Parent := sbAttachments;
    Attachment.Align := alTop;

    Attachment.Hint := Copy(SCN.Files[i] ,Pos(' ',SCN.Files[i],1)+1,Pos(' ',SCN.Files[i],4)-4);
    Attachment.Caption := Copy(SCN.Files[i] ,Pos(' ',SCN.Files[i],10)+1,SCN.Files[i].Length);
    Attachment.OnClick := OpenAttachment;
  end;

  if FileExists(DIR + '\scenery\images\' + SCN.Image) then
  begin
    Mini := TJPEGImage.Create;
    Mini.LoadFromFile(DIR + '\scenery\images\' + SCN.Image);
    imScenario.Picture.Bitmap.Assign(Mini);
    Mini.Free;
  end;

  lbTrains.Items.BeginUpdate;
  lbTrains2.Items.BeginUpdate;
  lbTrains.Clear;

  meDesc.Lines.BeginUpdate;
  meDesc.Text := SCN.Desc.Text;
  meDesc.Lines.EndUpdate;

  for i := 0 to SCN.Trains.Count-1 do
  begin
    if (not chOnlyForDriving.Checked) or ((SCN.Trains[i].Vehicles.Count > 0)
      and (SCN.Trains[i].Vehicles[0].CabOccupancy in [coHeadDriver,coRearDriver])) then
    begin
      if (chShowAI.Checked) or (not SCN.Trains[I].AI) then
        lbTrains.AddItem(PrepareTrainsetDesc(SCN.Trains[i]),TObject(i));
    end;
  end;
  lbTrains2.Items := lbTrains.Items;

  if lbTrains.Count > 0 then
    lbTrains.ItemIndex := 0
  else
    ClearTrainScroll;

  lbTrains2.Items.EndUpdate;
  lbTrains.Items.EndUpdate;

  LoadWeather(SCN);
  lbTrainsClick(self);
end;

procedure TMain.LoadWeather(const aSCN:TScenario);
begin
  if aSCN.Config.Day > 0 then
    tbDay.Position := aSCN.Config.Day
  else
    tbDay.Position := DayOfTheYear(Now);

  if (aSCN.Config.Temperature >= -50) and (aSCN.Config.Temperature <= 50) then
    tbTemperature.Position := Round(aSCN.Config.Temperature)
  else
    tbTemperature.Position := 15;

  tbFog.Position := (tbFog.Max - aSCN.Config.FogEnd) + tbFog.Min;

  if aSCN.Config.Overcast >= 0 then
  begin
    cbOvercast.ItemIndex := 6;
    if aSCN.Config.Overcast < 1.4 then cbOvercast.ItemIndex := 5;
    if aSCN.Config.Overcast < 1.1 then cbOvercast.ItemIndex := 4;
    if aSCN.Config.Overcast < 0.9 then cbOvercast.ItemIndex := 3;
    if aSCN.Config.Overcast < 0.6 then cbOvercast.ItemIndex := 2;
    if aSCN.Config.Overcast < 0.3 then cbOvercast.ItemIndex := 1;
  end
  else
    cbOvercast.ItemIndex := 0;

  dtTime.Time := aSCN.Config.Time;
end;

procedure TMain.tvSCNChange(Sender: TObject; Node: TTreeNode);
begin
  if (not Assigned(tvSCN.Selected)) or (tvSCN.Selected.Data = nil) then exit;
  if (SCN = TScenario(tvSCN.Selected.Data)) and (Sender <> chOnlyForDriving) then Exit;
  LoadScenery(TScenario(tvSCN.Selected.Data));
end;

procedure TMain.OnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    if Sender is TShape then
    begin
      (Sender as TShape).BeginDrag(True);
      SelectVehicle(Sender);
    end;
  end
  else
    if Button = mbRight then
      if SelList = slSCN then
        pmTrainsets.Popup(Main.Left + pnlBottom.Left + (Sender as TShape).Left + X + 10,Main.Top + pnlBottom.Top + (Sender as TShape).Top + Y)
      else
        pmDepot.Popup(Main.Left + pnlBottom.Left + (Sender as TShape).Left + X + 10,Main.Top + pnlBottom.Top + (Sender as TShape).Top + Y);
end;

procedure TMain.BitmapDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source is TImage then
  begin
    if (Source as TImage).Name = 'imMini' then
    begin
      if X > ((Sender as TImage).Width shr 1) then
        AddVehicle((Sender as TImage).Tag + 1)
      else
        AddVehicle((Sender as TImage).Tag);
    end
    else
      MoveVehicle((Source as TImage).Tag,(Sender as TImage).Tag);
  end
  else
  if Source is TShape then
    MoveVehicle((Source as TShape).Tag,(Sender as TImage).Tag);
end;

procedure TMain.MoveVehicle(const FromPos,ToPos :integer);
begin
  Train.Vehicles.Move(FromPos,ToPos);
  RefreshTrain(ToPos);
end;

procedure TMain.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    SelectVehicle(Sender)
  else
  if Button = mbRight then
    SelectVehicle(Sender,False);
end;

procedure TMain.imMiniMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    imMini.BeginDrag(true);
end;

procedure TMain.KeysGridClick(Sender: TObject);
begin
  cbKey1.ItemIndex := cbKey1.Items.IndexOf(Settings.KeyParams[KeysGrid.Row-1].Key);
  cbKey2.ItemIndex := cbKey2.Items.IndexOf(Settings.KeyParams[KeysGrid.Row-1].Key2);
  cbKey3.ItemIndex := cbKey3.Items.IndexOf(Settings.KeyParams[KeysGrid.Row-1].Key3);
end;

procedure TMain.lbVersionClick(Sender: TObject);
{var
  Installer : TInstaller;}
begin
  {Installer := TInstaller.Create;
  Installer.Install('C:\Users\damia\Desktop\et42-007_1.r_i');
  Installer.Free;}

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
  SelTrain := lbDepot.ItemIndex;
  SelectTrain;
end;

procedure TMain.lbModelDblClick(Sender: TObject);
begin
  if Length(lbModel.Caption) > 0 then
    OpenDir(DIR + lbModel.Hint);
end;

procedure TMain.lbTrainsClick(Sender: TObject);
begin
  if Pages.ActivePageIndex = 0 then
    lbTrains2.ItemIndex := lbTrains.ItemIndex
  else
    lbTrains.ItemIndex := lbTrains2.ItemIndex;

  if lbTrains.ItemIndex >= 0 then
  begin
    SelTrain := Integer(lbTrains.Items.Objects[lbTrains.ItemIndex]);
    SelectTrain;
  end
  else
    NoSelection;
end;

procedure TMain.NoSelection;
begin
  SelTrain    := -1;
  SelVehicle  := -1;
end;

procedure TMain.SelectTrain;
begin
  if Train <> nil then
  begin
    if Train.Vehicles.Count > 0 then
      SelVehicle := 0
    else
      SelVehicle := -1;

    meMission.Lines.BeginUpdate;
    meMission.Clear;
    if Train.AI then
      meMission.Lines.Add('Poci¹g prowadzony przez komputer.');
    meMission.Lines.Add(Train.Desc);
    meMission.Lines.EndUpdate;

    meTimetable.Lines.BeginUpdate;
    meTimetable.Text := '';
    if FileExists(DIR + '\scenery\' + Train.TrainName + '.txt') then
      meTimetable.Lines.LoadFromFile(DIR + '\scenery\' + Train.TrainName + '.txt' );
    meTimetable.Lines.EndUpdate;

    lbTrains2.Hint := Train.Desc;

    DrawTrain(Train);

    lbTrack.Caption := Train.Track;
    if Train.Vel > 0 then
      lbTrack.Caption := lbTrack.Caption + ' (' + FloatToStr(Train.Vel) + 'km/h)';
  end
  else
    ClearTrainScroll;
end;

procedure TMain.ClearTrainScroll;
begin
  while sbTrain.ControlCount > 0 do
    sbTrain.Controls[0].Free;

  sbTrain.HorzScrollBar.Position := 0;
end;

procedure TMain.Mark(const Image:TImage;const Color:TColor=clYellow);
var
  Mark : TShape;
  i : Integer;
begin
  i := 0;
  while i <= sbTrain.ControlCount-1 do
    if sbTrain.Controls[i].ClassType = TShape then
    begin
      sbTrain.Controls[i].Free;
      Break;
    end
    else
      Inc(i);

  Mark := TShape.Create(sbTrain);
  Mark.Brush.Style := bsClear;
  Mark.Pen.Width := 3;
  Mark.Pen.Color := Color;
  Mark.Parent := sbTrain;
  Mark.Left   := Image.Left - 1;
  Mark.Width  := Image.Width + 2;
  Mark.Height := Image.Height + 3;
  Mark.Tag    := Image.Tag;
  Mark.OnDragOver := ShapeDragOver;
  Mark.OnDragDrop := ShapeDragDrop;
  Mark.OnMouseDown := OnMouseDown;
end;

procedure TMain.SelectVehicle(Sender:TObject;SelectTex:Boolean=True);
begin
  if Sender is TImage then
  begin
    SelVehicle := (Sender as TImage).Tag;
    if Train.Vehicles[SelVehicle].CabOccupancy in [coHeadDriver, coRearDriver, coPassenger] then
      Mark(Sender as TImage)
    else
      Mark(Sender as TImage,clWebLimeGreen);
  end
  else
  if Sender is TShape then
    SelVehicle := (Sender as TShape).Tag;

  PaintVehicle(Train.Vehicles[SelVehicle].Texture,Train.Vehicles[SelVehicle].ModelID,SelectTex);

  if SelectTex then
    SelectTexture(Train.Vehicles[SelVehicle]);

  LoadVehicle(Train.Vehicles[SelVehicle]);
end;

procedure TMain.LoadVehicle(const Vehicle : TVehicle);
begin
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

  chReversed.Checked := Vehicle.Dist = -1;
  chRefAmbientTemp.Checked := Vehicle.ThermoDynamic;
  cbLoadType.ItemIndex := cbLoadType.Items.IndexOf(Vehicle.LoadType);

  if Physics[Vehicle.Texture.Models[Vehicle.ModelID].Fiz].MaxLoad > 0 then
    seLoadCount.MaxValue := Physics[Vehicle.Texture.Models[Vehicle.ModelID].Fiz].MaxLoad
  else
    seLoadCount.MaxValue := 0;

  seLoadCount.Value := Vehicle.Loadquantity;
end;

procedure TMain.SelectCoupler(Coupler:Integer);
begin
  clCouplers.Items.BeginUpdate;
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

  clCouplers.Hint := Train.Vehicles[SelVehicle].Coupler.ToString;
  clCouplers.Items.EndUpdate;
end;

procedure TMain.LoadModelData(const PhysicsID:Integer);
begin
  if PhysicsID >= 0 then
  begin
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

procedure TMain.LoadTexData(const Tex:TTexture;const ModelID:Integer=-1);
begin
  if Tex <> nil then
  begin
    lbTexOwner.Caption    := Tex.Owner;
    lbTexStation.Caption  := Tex.Station;
    lbTexRevision.Caption := Tex.Revision;
    lbTexWorks.Caption    := Tex.Works;
    lbTexAuthor.Caption   := Tex.Author;
    lbTexPhoto.Caption    := Tex.Photos;
    if ModelID >= 0 then
    begin
      lbModel.Caption     := Tex.Dir + '\' + Tex.Models[ModelID].Model;
      lbModel.Hint        := 'dynamic\' + Tex.Dir + '\';
    end
    else
      lbModel.Caption := EmptyStr;
  end
  else
  begin
    lbTexOwner.Caption    := EmptyStr;
    lbTexStation.Caption  := EmptyStr;
    lbTexRevision.Caption := EmptyStr;
    lbTexWorks.Caption    := EmptyStr;
    lbTexAuthor.Caption   := EmptyStr;
    lbTexPhoto.Caption    := EmptyStr;
    lbModel.Caption       := EmptyStr;
  end;
end;

procedure TMain.SelectModel(const Tex:TTexture;const ModelID:Integer=0);
begin
  cbTypes.ItemIndex := Ord(Tex.Typ);
  cbTypesClick(self);

  cbModels.ItemIndex := cbModels.Items.IndexOf(Tex.Models[ModelID].Mini);
  cbModelsClick(self);

  LoadModelData(Tex.Models[ModelID].Fiz);
  LoadTexData(Tex,ModelID);
end;

procedure TMain.SelectTexture(const Tex: TTexture;const ModelID:Integer=0);
begin
  SelectModel(Tex,ModelID);
  lbTextures.ItemIndex := lbTextures.Items.IndexOf(Tex.Plik);
  lbTexturesClick(self);
end;

procedure TMain.SelectTexture(const Vehicle:TVehicle);
var
  i : Integer;
begin
  if Textures.Count = 0 then Exit;
    lbTextures.Items.BeginUpdate;
  if Vehicle.Texture <> nil then
  begin
    SelectModel(Vehicle.Texture,Vehicle.ModelID);

    cbLoadType.Items.Clear;
    ExtractStrings([','],[],PChar(Physics[Vehicle.Texture.Models[Vehicle.ModelID].Fiz].LoadAccepted),cbLoadType.Items);

    if not SameText(Vehicle.TypeChk,Vehicle.Texture.Models[Vehicle.ModelID].Model) then
      lbModel.Caption := lbModel.Caption + ' (!)';

    lbTextures.ItemIndex := lbTextures.Items.IndexOf(Vehicle.Texture.Plik);
  end
  else
  begin
    i := 0;
    while (not SameText(Textures[i].Dir,Vehicle.Dir)) and (i < Textures.Count-1) do
      Inc(i);

    if SameText(Textures[i].Dir,Vehicle.Dir) then
      SelectModel(Textures[i])
    else
    begin
      cbTypes.ItemIndex := -1;
      cbModels.ItemIndex := -1;
      lbTextures.ItemIndex := -1;
    end;
  end;
  lbTextures.Items.EndUpdate;
end;

function TMain.LoadsIndex(const LoadName:string):Integer;
var
  i : Integer;
begin
  Result := -1;

  for i := 0 to Loads.Count-1 do
    if SameStr(LoadName,Loads[i].Name) then
    begin
      Result := i;
      Break;
    end;
end;

procedure TMain.DrawTrain(const Train:TTrain);
var
  i, ImageWidth : Integer;
  Image : TImage;
  TrainLength, TrainMass, TrainBrutto : Double;
  LoadIndex : Integer;
begin
  TrainLength := 0;
  TrainMass   := 0;
  TrainBrutto := 0;
  ImageWidth  := 0;

  ClearTrainScroll;
  if Train <> nil then
  begin
    for i := Train.Vehicles.Count-1 downto 0 do
    begin
      if (Train.Vehicles[i].Texture <> nil) and (Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz >= 0) then
      begin
        if (Train.Vehicles[i].CabOccupancy > coRearDriver) or ((Train.Vehicles[i].Texture.Typ = tyEZT)
        or (Train.Vehicles[i].Texture.Typ = tySZYNOBUS))
        or ((Train.Vehicles[i].Texture.Typ <= tyPAROWOZ) and (Train.Vehicles.Count = 1)) then
        begin
          TrainLength := TrainLength + Physics[Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz].Length;
          TrainMass := TrainMass + Physics[Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz].Mass;
        end;
      end;

      Image := TImage.Create(self);
      Image.Parent := sbTrain;
      Image.Align := alLeft;
      Image.Stretch := True;
      Image.Constraints.MaxHeight := 30 * MiniFactor;
      Image.OnMouseDown := ImageMouseDown;
      //Image.OnClick := SelectVehicle;
      Image.OnDragOver := BitmapDragOver;
      Image.OnDragDrop := BitmapDragDrop;
      //Image.OnMouseDown := OnMouseDown;
      Image.Tag := i;
      Image.Name := 'Image' + IntToStr(i);
      Image.Picture.Bitmap.Assign(PaintVehicle(Train.Vehicles[i].Texture,Train.Vehicles[i].ModelID));
      Image.Width := Image.Picture.Bitmap.Width * MiniFactor;

      Inc(ImageWidth,Image.Width);

      if (Train.Vehicles[i].CabOccupancy > coRearDriver)
        or (Train.Vehicles[i].Texture <> nil) and
           (((Train.Vehicles[i].Texture.Typ = tyEZT)
        or (Train.Vehicles[i].Texture.Typ = tySZYNOBUS))
        or ((Train.Vehicles[i].Texture.Typ <= tyPAROWOZ) and (Train.Vehicles.Count = 1))) then
      begin
        LoadIndex := LoadsIndex(Train.Vehicles[i].LoadType);

        if LoadIndex >= 0 then
          TrainBrutto := TrainBrutto + (Train.Vehicles[i].Loadquantity * Loads[LoadIndex].Weight)
        else
          TrainBrutto := TrainBrutto + (Train.Vehicles[i].Loadquantity * 1000);
      end;
    end;
    lbCountVehicles.Caption := IntToStr(Train.Vehicles.Count);
  end
  else
    lbCountVehicles.Caption := '';

  sbTrain.HorzScrollBar.Range := ImageWidth;

  if SelImage <> nil then
    SelectVehicle(SelImage);

  try
    if TrainLength > 0 then
      lbTrainLength.Caption := FloatToStr(TrainLength)
    else
      lbTrainLength.Caption := '';
    if TrainMass > 0 then
    begin
      lbTrainMass.Caption := FloatToStr(TrainMass / 1000);
      lbTrainBrutto.Caption := FloatToStr((TrainMass + TrainBrutto) / 1000);
    end
    else
    begin
      lbTrainMass.Caption   := '';
      lbTrainBrutto.Caption := '';
    end;
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

procedure TMain.seLoadCountChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    Train.Vehicles[SelVehicle].Loadquantity := seLoadCount.Value;
end;

procedure TMain.SetSelList(const Value: TTrain);
begin
  if SelList = slSCN then
    SCN.Trains[SelTrain] := Value
  else
    Depot[SelTrain] := Value;
end;

procedure TMain.WMHotKey(var Msg: TWMHotKey);
begin
  if Msg.HotKey = VK_DELETE then
    btnRemoveVehicle.Click
  else
    if Msg.HotKey = VK_INSERT then btnAddVehicle.Click;
end;

function TMain.PaintVehicle(const Tex:TTexture; const ModelID:Integer=0;const Mini:Boolean=True):TBitmap;
begin
  result := TBitmap.Create;

  if Tex <> nil then
  begin
    if FileExists(DIR + 'textures\mini\' + Tex.Models[ModelID].MiniD + '.bmp') then
      result.LoadFromFile(DIR + '\textures\mini\' + Tex.Models[ModelID].MiniD + '.bmp')
    else
      if FileExists(DIR + 'textures\mini\' + Tex.Models[ModelID].Mini + '.bmp') then
        result.LoadFromFile(DIR + '\textures\mini\' + Tex.Models[ModelID].Mini + '.bmp');
  end;

  if result.Empty then
    if FileExists(DIR + 'textures\mini\other.bmp') then
      result.LoadFromFile(DIR + '\textures\mini\other.bmp');

  if Mini then
    imMini.Picture.Bitmap := result;
end;

procedure TMain.pcSettingsResize(Sender: TObject);
var
  Width : Integer;
begin
  Width := (tsMain.Width div 2) - 270;
  pnlLeftMargin1.Width := Width;
  pnlLeftMargin2.Width := Width;
  pnlLeftMargin3.Width := tsMain.Width div 2 - 450;
end;

procedure TMain.pcTrainsChange(Sender: TObject);
begin
  if pcTrains.ActivePageIndex = 0 then
  begin
    SelList := slSCN;
    if lbTrains.ItemIndex >= 0 then
      SelTrain := Integer(lbTrains.Items.Objects[lbTrains.ItemIndex])
    else
      NoSelection;
  end
  else
  begin
    SelList := slDEPO;
    if lbDepot.ItemIndex >= 0 then
      SelTrain := lbDepot.ItemIndex
    else
      NoSelection;
  end;

  SelectTrain;
end;

procedure TMain.pmTexturesPopup(Sender: TObject);
begin
  miCopyTexture.Visible := lbTextures.Count > 0;
  miOpenTexDir.Visible  := lbTextures.Count > 0;
end;

procedure TMain.pmTrainsetsPopup(Sender: TObject);
var
  MI : TMenuItem;
  i : Integer;
begin
  if lbTrains.Count > 0 then
  begin
    miReplaceTrain.Clear;
    miReplaceTrain.Visible := Depot.Count > 0;
    for i := 0 to Depot.Count-1 do
    begin
      MI := TMenuItem.Create(miReplaceTrain);
      MI.Caption := lbDepot.Items[i];
      MI.Tag := i;
      MI.OnClick := miTrainClick;
      miReplaceTrain.Add(MI);
    end;

    miAddTrain.Clear;
    miAddTrain.Visible := Depot.Count > 0;
    for i := 0 to Depot.Count-1 do
    begin
      MI := TMenuItem.Create(miAddTrain);
      MI.Caption := lbDepot.Items[i];
      MI.Tag := i;
      MI.OnClick := miAddTrainClick;
      miAddTrain.Add(MI);
    end;
  end
  else
    Abort;
end;

procedure TMain.miTrainClick(Sender: TObject);
var
  Index : Integer;
begin
  Index := (Sender as TMenuItem).Tag;
  ReplaceTrain(Depot[Index].Vehicles);
end;

procedure TMain.miAddTrainClick(Sender: TObject);
var
  Index : Integer;
begin
  Index := (Sender as TMenuItem).Tag;
  AddTrain(Depot[Index].Vehicles);
  Connect(Train.Vehicles.Count-Depot[Index].Vehicles.Count-1);
  SelectCoupler(Train.Vehicles[SelVehicle].Coupler);
end;

procedure TMain.ReplaceTrain(const Vehicles:TObjectList<TVehicle>);
begin
  Train.Vehicles.Clear;
  AddTrain(Vehicles);
end;

procedure TMain.AddTrain(const Vehicles:TObjectList<TVehicle>);
var
  Vehicle : TVehicle;
  i : Integer;
begin
  for i := 0 to Vehicles.Count-1 do
  begin
    Vehicle := TVehicle.Create;
    Vehicle.Assign(Vehicles[i]);
    Vehicle.Name := UniqueVehicleName(Vehicle);
    Train.Vehicles.Add(Vehicle);
  end;

  if Train.Vehicles.Count > 0 then
    SelVehicle := 0
  else
    SelVehicle := -1;

  SetItemDesc(Train);
  DrawTrain(Train);
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

procedure TMain.edSwayChange(Sender: TObject);
begin
  if SelVehicle >= 0 then
    TryStrToInt(edSway.Text,Train.Vehicles[SelVehicle].Sway);
end;

procedure TMain.OpenAttachment(Sender:TObject);
begin
  OpenFile((Sender as TButton).Hint);
end;

procedure TMain.OpenDir(const Path:string);
begin
  ShellExecute(Application.Handle,
    PChar('explore'),
    PChar(Path),
    nil,
    nil,
    SW_SHOWNORMAL);
end;

function TMain.PrepareTrainsetDesc(const Trainset:TTrain):string;
var
  i, c : Integer;
begin
  if Trainset.Vehicles.Count > 0 then
  begin
    if (Trainset.Vehicles.First.Texture <> nil) and (Trainset.Vehicles.First.Texture.Typ in [tyELEKTROWOZ..tyEZT]) then
      Result := Trainset.Vehicles.First.Name
    else
      Result := Trainset.Vehicles.First.TypeChk;

    c := 1;
    for i := 1 to Trainset.Vehicles.Count-1 do
      if SameText(Trainset.Vehicles[i-1].TypeChk,Trainset.Vehicles[i].TypeChk)
        and (Trainset.Vehicles[i].Texture <> nil)
        and (Trainset.Vehicles[i-1].Texture <> nil)
        and not (Trainset.Vehicles[i].Texture.Typ in [tyELEKTROWOZ..tyPAROWOZ])  then
      begin
        Inc(c);
        if i = Trainset.Vehicles.Count-1 then
          Result := Result + '(' + IntToStr(c) + ')';
      end
      else
      begin
        if c > 1 then
        begin
          Result := Result + '(' + IntToStr(c) + ')';
          c := 1;
        end;
        if (Trainset.Vehicles[i].Texture <> nil) then
          Result := Result + ' + ' + Trainset.Vehicles[i].Texture.Models[0].Mini
        else
          Result := Result + ' + ' + Trainset.Vehicles[i].TypeChk;
      end;
  end
  else
    Result := 'Wpis bez pojazdów. (Tor: ' + Trainset.Track +')';
end;

procedure TMain.lbTexturesClick(Sender: TObject);
var
  i : Integer;
  Tex : TTexture;
begin
  if lbTextures.ItemIndex >= 0 then
  begin
    Tex := lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture;

    for i := 0 to Tex.Models.Count-1 do
      if SameText(cbModels.Items[cbModels.ItemIndex],Tex.Models[i].Mini) then
      begin
        LoadModelData(Tex.Models[i].Fiz);
        PaintVehicle(Tex,i);
        LoadTexData(Tex,i);
        Break;
      end;
  end;

  lbTextures.Tag := lbTextures.ItemIndex;
end;

procedure TMain.lbTexturesDblClick(Sender: TObject);
var
  Tex : TTexture;
begin
  if (lbTextures.ItemIndex <> -1) and (Train <> nil) and (Train.Vehicles.Count > 0) then
  begin
    Tex := (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);
    LoadModelData(Tex.Models[Train.Vehicles[SelVehicle].ModelID].Fiz);

    if (SelVehicle >= 0) then
    begin
      AssignTexToVehicle(Train.Vehicles[SelVehicle],Tex);
      LoadTexData(Tex,Train.Vehicles[SelVehicle].ModelID);

      if AssignNextVehicles(Tex) + AssignPrevVehicles(Tex) = 2 then
        DrawVehicle(Train.Vehicles[SelVehicle])
      else
        DrawTrain(Train);

      TrainDesc;
    end
    else
      LoadTexData(Tex);
  end;
end;

function TMain.AssignNextVehicles(Tex:TTexture):Integer;
begin
  Result := 1;
  while (SelVehicle + Result < Train.Vehicles.Count) and (SameText(Tex.Dir,Train.Vehicles[SelVehicle+Result].Dir)) and (Tex.NextTexID >= 0) do
  begin
    AssignTexToVehicle(Train.Vehicles[SelVehicle+Result],Textures[Tex.NextTexID]);
    Tex := Textures[Tex.NextTexID];
    Inc(Result);
  end;
end;

function TMain.AssignPrevVehicles(Tex:TTexture):Integer;
begin
  Result := 1;
  while (SelVehicle - Result >= 0) and (SameText(Tex.Dir,Train.Vehicles[SelVehicle-Result].Dir)) and (Tex.PrevTexID >= 0) do
  begin
    AssignTexToVehicle(Train.Vehicles[SelVehicle-Result],Textures[Tex.PrevTexID]);
    Tex := Textures[Tex.PrevTexID];
    Inc(Result);
  end;
end;

procedure TMain.TrainDesc;
begin
  if SelList = slSCN then
    SetItemDesc(Train)
  else
    lbDepot.Items[lbDepot.ItemIndex] := PrepareTrainsetDesc(Train);
end;

procedure TMain.miOpenVehicleDirClick(Sender: TObject);
var
  Tex : TTexture;
begin
  Tex := (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);
  if Tex <> nil then
    OpenDir(DIR + 'dynamic\' + Tex.Dir);
end;

procedure TMain.SetItemDesc(const Trainset:TTrain);
begin
  lbTrains.Items[lbTrains.ItemIndex] := PrepareTrainsetDesc(Trainset);
  lbTrains2.Items[lbTrains2.ItemIndex] := lbTrains.Items[lbTrains.ItemIndex];
end;

end.
