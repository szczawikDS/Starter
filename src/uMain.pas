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

//{$O+}
{$INLINE AUTO}

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
    actCopyLoad: TAction;
    Panel27: TPanel;
    Panel23: TPanel;
    pnlOvercast: TPanel;
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
    edFriction: TEdit;
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
    lbReflectionsFidelity: TLabel;
    cbReflectionsFidelity: TComboBox;
    lbMaxCabTexSize: TLabel;
    cbMaxcabtexturesize: TComboBox;
    tbGlobalSounds: TTrackBar;
    tbPositionalsSounds: TTrackBar;
    tbVehiclesSounds: TTrackBar;
    tbRadioVolume: TTrackBar;
    tbSoundVolume: TTrackBar;
    miAddTrain: TMenuItem;
    actAddTrain: TAction;
    sbTrain: TScrollBox;
    pnlInfoTrain: TPanel;
    lbTrainMassCaption: TLabel;
    lbTrainMass: TLabel;
    lnTrainLengthCaption: TLabel;
    lbTrainLength: TLabel;
    seLoadCount: TSpinEdit;
    cbLoadType: TComboBox;
    btnLoadMenu: TButton;
    pmLoad: TPopupMenu;
    miCopyLoadToAllNext: TMenuItem;
    miCopyLoad: TMenuItem;
    actSetMaxLoadToAll: TAction;
    miSetMaxLoadToAll: TMenuItem;
    lbCountVehiclesCaption: TLabel;
    lbCountVehicles: TLabel;
    lbTrainBruttoCaption: TLabel;
    lbTrainBrutto: TLabel;
    lbTrackCaption: TLabel;
    lbTrack: TLabel;
    pnlDay: TPanel;
    cbSeason: TComboBox;
    seDay: TSpinEdit;
    pnlLabelDay: TPanel;
    pnlLabelTemperature: TPanel;
    lbTemperature: TLabel;
    tbTemperature: TTrackBar;
    pnlVisibility: TPanel;
    lbFogNo: TLabel;
    lbFog: TLabel;
    tbFog: TTrackBar;
    lbCloudy: TLabel;
    cbOvercast: TComboBox;
    lbTime: TLabel;
    pnlSceneryCaption: TPanel;
    btnRandomTex: TButton;
    actRandomTex: TAction;
    Panel3: TPanel;
    Label4: TLabel;
    edFieldofview: TEdit;
    Sortujwedug1: TMenuItem;
    miSortByVehicleName: TMenuItem;
    miSortByTrackName: TMenuItem;
    chTrainMan: TCheckBox;
    pnlSettingsSet: TPanel;
    cbPreset: TComboBox;
    btnPreset: TButton;
    actPreset: TAction;
    btnPresetShow: TButton;
    actPresetShow: TAction;
    chAngle: TCheckBox;
    actANGLE: TAction;
    actSetNumber: TAction;
    chAutoExpandTree: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lbTrainsClick(Sender: TObject);
    procedure cbFeedbackmodeChange(Sender: TObject);
    procedure cbDriverTypeChange(Sender: TObject);
    procedure cbLoadTypeChange(Sender: TObject);
    procedure chReversedClick(Sender: TObject);
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
    procedure edFieldofview2Exit(Sender: TObject);
    procedure cbBigThumbnailClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chRefAmbientTempClick(Sender: TObject);
    procedure actRemoveTrainUpdate(Sender: TObject);
    procedure actRemoveTrainExecute(Sender: TObject);
    procedure actCopyLoadUpdate(Sender: TObject);
    procedure actCopyLoadExecute(Sender: TObject);
    procedure lbTexturesDblClick(Sender: TObject);
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
    procedure actSetMaxLoadToAllExecute(Sender: TObject);
    procedure btnLoadMenuClick(Sender: TObject);
    procedure actSetMaxLoadToAllUpdate(Sender: TObject);
    procedure cbSeasonChange(Sender: TObject);
    procedure seDayChange(Sender: TObject);
    procedure actRandomTexExecute(Sender: TObject);
    procedure actRandomTexUpdate(Sender: TObject);
    procedure actAddTrainUpdate(Sender: TObject);
    procedure cbTypesChange(Sender: TObject);
    procedure clCouplersMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure miSortByVehicleNameClick(Sender: TObject);
    procedure miSortByTrackNameClick(Sender: TObject);
    procedure actPresetExecute(Sender: TObject);
    procedure actPresetShowExecute(Sender: TObject);
    procedure actANGLEExecute(Sender: TObject);
    procedure pcSettingsChange(Sender: TObject);
    procedure actSetNumberExecute(Sender: TObject);
    procedure actSetNumberUpdate(Sender: TObject);
    procedure tvSCNCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
  private
    SCN : TScenario;

    SelVehicle : Integer;

    procedure OpenAttachment(Sender: TObject);
    procedure DrawTrain(const Train: TTrain);
    procedure LaunchSimulator;
    procedure SelectVehicle(const Sender: TObject;const SelectTex:Boolean=True);
    procedure ChangePage(const PageIndex: Integer);
    procedure DrawVehicle(const Vehicle: TVehicle);
    function SelImage: TImage;
    function GetSelList: TTrain;
    procedure SetSelList(const Value: TTrain);
    procedure SelectTrain;
    function GetCoupler: Integer;
    procedure SelectTexture(const Vehicle: TVehicle); overload;
    procedure SelectCoupler(Coupler: Integer);
    procedure LoadModelData(const Physics:TPhysics);
    procedure ClearTrainScroll;
    procedure LoadKeysComponents;
    procedure LoadTexData(const Tex: TTexture;const ModelID:Integer=-1);
    procedure DefaultSettings;
    procedure AdaptMiniSize;
    procedure SetItemDesc(const Trainset: TTrain);
    procedure AppDeactivate(Sender: TObject);
    procedure AppActivate(Sender: TObject);

    procedure BitmapDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ShapeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
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
    procedure ReplaceTrain(const Vehicles: TObjectList<TVehicle>);
    procedure AssignBrakeActing(Vehicle: TVehicle);
    procedure AssignBrakeAdjust(Vehicle: TVehicle);
    procedure AssignBrakeState(Vehicle: TVehicle);
    procedure TrainDesc;
    procedure NoSelection;
    procedure LoadScenery(const aSCN: TScenario);
    procedure RemoveFromDepot(const Index: Integer);
    procedure LoadWeather(const aSCN: TScenario);
    procedure AddTrain(const Vehicles: TObjectList<TVehicle>);
    function AssignNextVehicles(Tex: TTexture):Integer;
    function AssignPrevVehicles(Tex: TTexture): Integer;
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoadTrainParams;
    procedure LoadTrains(const Trains: TList<TTrain>);
    procedure RemoveVehicle(const Index:Integer;Indexes:TList<Integer>=nil);
    procedure MatchOccupancy(Vehicle: TVehicle;const Position: Integer);
    procedure BitmapMouseEnter(Sender: TObject);
  public
    Settings    : TSettings;
    MiniFactor  : Integer;
    SelList     : TSelectedList;
    Images      : TObjectList<TBitmap>;
    SelTrain : Integer;
    property Train : TTrain read GetSelList write SetSelList;
    procedure SelectTexture(const Tex: TTexture;const ModelID:Integer=0); overload;
    procedure AssignTexToVehicle(Vehicle:TVehicle;const Tex: TTexture);
    function IsVehicleName(const Name: string): Integer;
    procedure AddVehicle(const Position: Integer;Tex:TTexture=nil;const CheckPrev:Boolean=True;const CheckNext:Boolean=True);
    procedure RemoveVehicles(const Index: Integer;Vehicles:TList<TVehicle>=nil);
    procedure LoadMagazine;
    procedure ScenariosList;
  end;

var
  Main: TMain;

implementation

uses DateUtils, JPEG, uParser, uSettingsAdv, uUpdater, uSearch, uTextureBase, uDepot,
     uUART, uAbout, Clipbrd, StrUtils, uTexRandomizer, uUtilities, uData {, uInstaller};

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
  DepoTrain.TrainName := InputBox(
                        'Nazwa poci�gu',
                        'Nazwa poci�gu:',
                        Train.TrainName);

  for i := 0 to Train.Vehicles.Count-1 do
  begin
    Vehicle := TVehicle.Create;
    Vehicle.Assign(Train.Vehicles[i]);
    DepoTrain.Vehicles.Add(Vehicle);
  end;
  Data.Depot.Add(DepoTrain);

  TDepot.SaveDepot;
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

procedure TMain.actAddTrainUpdate(Sender: TObject);
begin
  actAddTrain.Enabled := (Train <> nil) and (Train.Vehicles.Count > 0);
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
  Result := '';

  if Vehicle.Texture <> nil then
    if (Vehicle.Texture.Models[Vehicle.ModelID].MiniD.Length > 0) then
    if Vehicle.Texture.Models[Vehicle.ModelID].MiniD <> Vehicle.Texture.Models[Vehicle.ModelID].Mini then
      Result := Vehicle.Texture.Models[Vehicle.ModelID].MiniD;

  if Result.Length = 0 then
    if (Vehicle.ReplacableSkin.Length > 0) and (not SameText('NONE',Vehicle.ReplacableSkin)) then
      Result := Vehicle.ReplacableSkin
    else
      Result := Vehicle.Name;

  Suffix := 0;
  Found := IsVehicleName(Result);
  while Found > 0 do
  begin
    Suffix := Suffix + Found;
    Found := IsVehicleName(Result + '_' + IntToStr(Suffix));
  end;

  if Suffix > 0 then
    Result := Result + '_' + IntToStr(Suffix);
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

  if Tex.Typ < tySZYNOBUS then
    Vehicle.Loadquantity := 0;
end;

procedure TMain.MatchOccupancy(Vehicle:TVehicle;const Position:Integer);
var
  Staff : Boolean;
  i : Integer;
begin
  Vehicle.CabOccupancy := coNobody;
  Staff := False;
  if Vehicle.Texture.Typ in [TTyp.tyELEKTROWOZ..tyEZT] then
  begin
    if Position > 0 then
      for i := 0 to Position do
        if Train.Vehicles[i].CabOccupancy in [coHeadDriver..coRearDriver] then
        begin
          Staff := True;
          Break;
        end;

    if (Position = 0) or (not Staff) then
      Vehicle.CabOccupancy := coHeadDriver;
  end;
end;

procedure TMain.AddVehicle(const Position:Integer;Tex:TTexture=nil;const CheckPrev:Boolean=True;const CheckNext:Boolean=True);
var
  Vehicle : TVehicle;
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

  if Position > Train.Vehicles.Count then
    Train.Vehicles.Insert(Train.Vehicles.Count-1,Vehicle)
  else
    Train.Vehicles.Insert(Position,Vehicle);

  AssignTexToVehicle(Vehicle,Tex);
  MatchOccupancy(Vehicle,Position);
  Connect(Train,Position-1);
  Connect(Train,Position);
  if (Train.Vehicles.Count = 1) and (Vehicle.Coupler = 0) then
    Vehicle.Coupler := 3;

  if (CheckNext) and (Tex.NextTexID >= 0) then
    AddVehicle(Position+1,Data.Textures[Tex.NextTexID],False,True);

  if (CheckPrev) and (Tex.PrevTexID >= 0) then
  begin
    Vehicle.CabOccupancy := coNobody;
    AddVehicle(Position,Data.Textures[Tex.PrevTexID],True,False);
  end;

  if (CheckNext) then
  begin
    TrainDesc;
    RefreshTrain(Position);
  end;
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
var
  SkipMultiple : Integer;
begin
  SkipMultiple := 1;
  while Train.Vehicles.Count > SelVehicle + SkipMultiple do
    if (Train.Vehicles[SelVehicle+SkipMultiple-1].Texture <> nil)
       and (Train.Vehicles[SelVehicle+SkipMultiple].Texture <> nil) then
    begin
      if Train.Vehicles[SelVehicle+SkipMultiple-1].Texture.ID = Train.Vehicles[SelVehicle+SkipMultiple].Texture.PrevTexID then
        Inc(SkipMultiple)
      else
        Break;
    end
    else
      Break;

  AddVehicle(SelVehicle+SkipMultiple);
end;

procedure TMain.actAddVehicleUpdate(Sender: TObject);
begin
  actAddVehicle.Enabled := (lbTextures.ItemIndex >= 0) and (SelTrain >= 0);
end;

procedure TMain.actANGLEExecute(Sender: TObject);
begin
  if chAngle.Checked then
  begin
    frmSettingsAdv.chUseGLES.Checked      := True;
    frmSettingsAdv.chShaderGamma.Checked  := True;
    frmSettingsAdv.chCompressTex.Checked  := False;
    chPythonThreadedUpload.Checked        := False;
    frmSettingsAdv.chMipmaps.Checked      := False;
  end;
end;

procedure TMain.actAutoCouplerExecute(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to Train.Vehicles.Count-1 do
    Connect(Train,i);

  SelectCoupler(Train.Vehicles[SelVehicle].Coupler);
end;

procedure TMain.actAutoCouplerUpdate(Sender: TObject);
begin
  actAutoCoupler.Enabled := (Train <> nil) and (Train.Vehicles.Count > 1);
end;

procedure TMain.actChangeNameExecute(Sender: TObject);
var
  TrainName : string;
begin
  TrainName := InputBox(
                      'Zmiana nazwy poci�gu',
                      'Nazwa poci�gu:',
                      Data.Depot[lbDepot.ItemIndex].TrainName);

  if TrainName.Length > 0 then
  begin
    if Trim(TrainName).Length > 0 then
      Data.Depot[lbDepot.ItemIndex].TrainName := TrainName
    else
      Data.Depot[lbDepot.ItemIndex].TrainName := '';

    TDepot.SaveDepot;
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

    LoadTrainParams;
  end;
end;

procedure TMain.actCopyLoadToAllExecute(Sender: TObject);
var
  i : Integer;
begin
  for i := SelVehicle + 1 to Train.Vehicles.Count-1 do
  begin
    if Train.Vehicles[i].Texture <> nil  then
      if ContainsText(Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz.LoadAccepted,cbLoadType.Text) then
      begin
        Train.Vehicles[i].LoadType := cbLoadType.Text;
        Train.Vehicles[i].Loadquantity := seLoadCount.Value;
      end;
  end;

  LoadTrainParams;
end;

procedure TMain.actCopyLoadToAllUpdate(Sender: TObject);
begin
  actCopyLoadToAll.Enabled := (SelVehicle >= 0) and (Train.Vehicles.Count-1 > SelVehicle) and (Train.Vehicles[SelVehicle].LoadType.Length > 0);
end;

procedure TMain.actCopyLoadUpdate(Sender: TObject);
begin
  actCopyLoad.Enabled := SelVehicle > 0;
end;

procedure TMain.actCopyTextureNameExecute(Sender: TObject);
begin
  if lbTextures.ItemIndex >= 0 then
    Clipboard.AsText := lbTextures.Items[lbTextures.ItemIndex];
end;

procedure TMain.actCopyToClipboardExecute(Sender: TObject);
var
  i : Integer;
  Str, TrainName : string;
begin
  if Train.TrainName.Length = 0 then
    TrainName := 'none'
  else
    TrainName := StringReplace(Train.TrainName,' ','_',[rfReplaceAll]);

  if Train.Track.Length = 0 then
    Train.Track := 'none';

  str := 'trainset ' + TrainName + ' ' + Train.Track + ' ' + FloatToStr(Train.Dist) + ' ' + FloatToStr(Train.Vel) + #13#10;
  for i := 0 to Train.Vehicles.Count-1 do
    str := str + PrepareNode(Train.Vehicles[i]) + #13#10;
  str := str + 'endtrainset';
  Clipboard.AsText := str;
end;

procedure TMain.actCopyToClipboardUpdate(Sender: TObject);
begin
  actCopyToClipboard.Visible := (Train <> nil) and (Train.Vehicles.Count > 0);
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
  tbGlobalSounds.Position               := 10;

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
  ChangePage(1);
end;

procedure TMain.actKeyboardExecute(Sender: TObject);
begin
  Settings.ReadKeyboard;
  LoadKeysComponents;
  ChangePage(3);
end;

procedure TMain.actLoadDepoFromFileExecute(Sender: TObject);
begin
  if OD.Execute then
  begin
    TDepot.ReadDepot(OD.FileName);
    LoadMagazine;
    TDepot.SaveDepot;
  end;
end;

procedure TMain.actOpenDepoExecute(Sender: TObject);
var
  Form : TForm;
begin
  Form := Application.FindComponent('frmTextureBase') as TForm;

  if Form <> nil then
    Form.Show
  else
    with TfrmTextureBase.Create(Application) do
      Show;
end;

procedure TMain.actOpenScenarioDirExecute(Sender: TObject);
begin
  if (tvSCN.Selected <> nil) and (tvSCN.Selected.Data <> nil) then
    OpenDir(ExtractFileDir( TScenario(tvSCN.Selected.Data).Path));
end;

procedure TMain.actOpenTexDirExecute(Sender: TObject);
begin
  if lbTextures.ItemIndex >= 0 then
    OpenDir(Util.DIR + 'dynamic\' + (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture).Dir);
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
  actPasteFromClipboard.Visible := (Clipboard.AsText.Length > 100) and (Pos('dynamic',Clipboard.AsText) > 0);
end;

procedure TMain.actPresetExecute(Sender: TObject);
begin
  Settings.ReadSettings('#' + cbPreset.Items[cbPreset.ItemIndex]);
  ReloadSettingsState;
end;

procedure TMain.actPresetShowExecute(Sender: TObject);
begin
  cbPreset.Visible  := not cbPreset.Visible;
  btnPreset.Visible := not btnPreset.Visible;
end;

procedure TMain.actRandomTexExecute(Sender: TObject);
var
  TexRandomizer : TTexRandomizer;
  Index : Integer;
begin
  Index := lbTrains.ItemIndex;

  TexRandomizer := TTexRandomizer.Create;
  try
    try
    TexRandomizer.RandomTex(SCN.Trains);

    LoadTrains(SCN.Trains);
    lbTrains.ItemIndex := Index;
    lbTrainsClick(self);
    except
      on E: Exception do
        Util.Errors.Add('Wyst�pi� b��d przy losowaniu tekstur. Szczeg�y b��du: ' + E.Message);
    end;
  finally
    TexRandomizer.Free;
  end;
end;

procedure TMain.actRandomTexUpdate(Sender: TObject);
begin
  actRandomTex.Enabled := lbTrains.Count > 0;
end;

procedure TMain.actReloadScenariosExecute(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to Data.Scenarios.Count-1 do
    TParser.ParseScenario(Data.Scenarios[i]);
  if (tvSCN.Selected <> nil) and (tvSCN.Selected.Data <> nil) then
    LoadScenery(TScenario(tvSCN.Selected.Data));
end;

procedure TMain.RemoveFromDepot(const Index:Integer);
begin
  Data.Depot.Extract(Data.Depot[Index]);
  TDepot.SaveDepot;
  LoadMagazine;
  if Data.Depot.Count > 0 then
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

procedure TMain.RemoveVehicle(const Index:Integer;Indexes:TList<Integer>=nil);
var
  i : Integer;
begin
  if Indexes <> nil then
  begin
    Indexes.Sort(
      TComparer<Integer>.Construct(
        function(const Left, Right: Integer): Integer
        begin
          Result := Right-Left;
        end
      )
    );

    for i := 0 to Indexes.Count-1 do
      Train.Vehicles.Extract(Train.Vehicles[Indexes[i]]);
  end
  else
    Train.Vehicles.Extract(Train.Vehicles[Index]);

  while SelVehicle > Train.Vehicles.Count-1 do
    Dec(SelVehicle);
end;

procedure TMain.actRemoveTrainUpdate(Sender: TObject);
begin
  actRemoveTrain.Visible := (Train <> nil) and (Train.Vehicles.Count > 0);
end;

procedure TMain.actRemoveVehicleExecute(Sender: TObject);
begin
  RemoveVehicles(SelVehicle);

  if SelList = slSCN then
    SetItemDesc(Train)
  else
    if Train.Vehicles.Count > 0 then
      lbDepot.Items[lbDepot.ItemIndex] := PrepareTrainsetDesc(Train)
    else
      RemoveFromDepot(lbDepot.ItemIndex);

  DrawTrain(Train);
end;

procedure TMain.RemoveVehicles(const Index:Integer;Vehicles:TList<TVehicle>=nil);
var
  Indexes : TList<Integer>;
  i : Integer;
begin
  if Vehicles = nil then Vehicles := Train.Vehicles;

  Indexes := TList<Integer>.Create;
  Indexes.Add(Index);

  if Vehicles[Index].Texture <> nil then
  begin
    i := 0;
    while (Index-i > 0) and (Vehicles[Index-i-1].Texture <> nil)
      and (Vehicles[Index-i].Texture.PrevTexID = Vehicles[Index-i-1].Texture.ID) do
      begin
        Indexes.Add(Index-i-1);
        Inc(i);
      end;

    i := 0;
    while (Vehicles.Count-1 > Index+i) and (Vehicles[Index+i+1].Texture <> nil)
      and (Vehicles[Index+i].Texture.NextTexID = Vehicles[Index+i+1].Texture.ID) do
      begin
        Indexes.Add(Index+i+1);
        Inc(i);
      end;
  end;

  RemoveVehicle(Index,Indexes);
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
  ChangePage(0);
end;

procedure TMain.actSetMaxLoadToAllExecute(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to Train.Vehicles.Count-1 do
  begin
    if (Train.Vehicles[i].Texture <> nil) and (Train.Vehicles[i].Texture.Typ >= tySZYNOBUS) then
      if Train.Vehicles[i].LoadType.Length > 0 then
        if Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz <> nil then
          Train.Vehicles[i].Loadquantity := Train.Vehicles[i].Texture.Models[Train.Vehicles[i].ModelID].Fiz.MaxLoad;
  end;
  seLoadCount.Value := Train.Vehicles[SelVehicle].Loadquantity;
  LoadTrainParams;
end;

procedure TMain.actSetMaxLoadToAllUpdate(Sender: TObject);
begin
  actSetMaxLoadToAll.Enabled := SelVehicle >= 0;
end;

procedure TMain.actSetNumberExecute(Sender: TObject);
var
  Number : string;
begin
  Number := Train.Vehicles[SelVehicle].Number.ToString;
  Number := InputBox('Numer wagonu','Numer wagonu:',Number);

  if Number = '' then
    Number := '0';

  TryStrToInt(Number,Train.Vehicles[SelVehicle].Number);
  DrawVehicle(Train.Vehicles[SelVehicle]);
end;

procedure TMain.actSetNumberUpdate(Sender: TObject);
begin
  actSetNumber.Enabled := SelVehicle >= 0;
end;

procedure TMain.actSettingsExecute(Sender: TObject);
begin
  ChangePage(2);
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
  Config.Day          := seDay.Value;
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

  Starter.SaveToFile(Util.DIR + 'scenery\$' + SCN.Name + '.scn');
  Starter.Free;
  LaunchSimulator;
end;

procedure TMain.actStartUpdate(Sender: TObject);
begin
  actStart.Enabled := (SelList = slSCN) and (SelTrain >= 0) and (SelVehicle >= 0) and (Train <> nil)
                      and (Train.Vehicles[SelVehicle].CabOccupancy in [coHeadDriver,coRearDriver,coPassenger])
                      and (cbEXE.ItemIndex >= 0) and (tvSCN.Selected.Data <> nil);
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
      Util.OpenFile('\readme.html')
    else
      Util.OpenFile('\en-readme.html');
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

procedure TMain.btnLoadMenuClick(Sender: TObject);
var
  Point : TPoint;
begin
  GetCursorPos(Point);
  pmLoad.Popup(Point.X,Point.Y);
end;

procedure TMain.LaunchSimulator;
var
  RunInfo : TRunInfo;
begin
  Settings.SaveSettings;

  RunInfo.SceneryName := SCN.Name;
  RunInfo.Vehicle     := Train.Vehicles[SelVehicle].Name;

  if cbEXE.ItemIndex = 0 then
    RunInfo.EXE := PChar(Util.DIR + cbEXE.Items[cbEXE.Items.Count-1])
  else
    RunInfo.EXE := PChar(Util.DIR + cbEXE.Text);

  if FileExists(RunInfo.EXE) then
  begin
    RunSimulator(RunInfo);

    if cbCloseApp.Checked then
      Application.Terminate;
  end
  else
  begin
    btnStart.Enabled := True;
    ShowMessage('Nie znaleziono pliku wykonywalnego (' + ExtractFileName( RunInfo.EXE) + ') symulatora.');
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

  for i := 0 to Data.Textures.Count-1 do
    for y := 0 to Data.Textures[i].Models.Count-1 do
      if SameText(Data.Textures[i].Models[y].Mini,cbModels.Items[cbModels.ItemIndex]) then
      begin
        lbTextures.AddItem(Data.Textures[i].Plik,Data.Textures[i]);
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

      if (Images.Count > Index) and (Images[Index].Handle <> 0) then
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
  except
    Util.Errors.Add('B��d wewn�trzny Startera. Index: ' + Index.ToString + ' Images.Count: '
                + Images.Count.ToString + ' Combo.Count: ' + ComboBox.Items.Count.ToString);
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

procedure TMain.cbSeasonChange(Sender: TObject);
begin
  case cbSeason.ItemIndex of
    0: seDay.Value := DayOfTheYear(Now);
    1: seDay.Value := 113;
    2: seDay.Value := 204;
    3: seDay.Value := 297;
    4: seDay.Value := 15;
  end;
end;

procedure TMain.cbTypesChange(Sender: TObject);
var
  i, y : Integer;
  OrdType : Integer;
  slModels : TStringList;
  Bitmap : TBitmap;
begin
  slModels := TStringList.Create;
  try
    slModels.Sorted := True;
    slModels.Duplicates := dupIgnore;

    for i := 0 to Data.Textures.Count-1 do
    begin
      OrdType := Ord(Data.Textures[i].Typ);
      if OrdType = cbTypes.ItemIndex then
        for y := 0 to Data.Textures[i].Models.Count-1 do
          slModels.Add(Data.Textures[i].Models[y].Mini);
    end;

    if Assigned(Images) then
      Images.Free;
    Images := TObjectList<TBitmap>.Create;
    for i := 0 to slModels.Count-1 do
    begin
      Bitmap := TBitmap.Create;
      if FileExists(Util.DIR + 'textures\mini\' + slModels[i] + '.bmp') then
        Bitmap.LoadFromFile(Util.DIR + 'textures\mini\' + slModels[i] + '.bmp')
      else
        Bitmap.LoadFromFile(Util.DIR + 'textures\mini\other.bmp');
      Images.Add(Bitmap);
    end;

    cbModels.Items.BeginUpdate;
    cbModels.Items.Assign(slModels);
    cbModels.Items.EndUpdate;

    if cbModels.Items.Count > 0 then
    begin
      cbModels.ItemIndex := 0;
      cbModelsClick(self);
    end
    else
      lbTextures.Clear;
  finally
    slModels.Free;
  end;
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

procedure TMain.clCouplersMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  CouplerOld, Coupler, SelectCouplerMax, NextCouplerMax : Integer;
  Flag : TFlag;
  ConType1, ConType2 : string;
begin
  Coupler := GetCoupler;
  clCouplers.Hint := Coupler.ToString;

  if (SelVehicle = -1) or (Train.Vehicles.Count-1 <= SelVehicle) then exit;

  CouplerOld := Train.Vehicles[SelVehicle].Coupler;

  if Coupler > CouplerOld then
  begin
    if (Train.Vehicles[SelVehicle].Texture <> nil) then
    begin
      SelectCouplerMax  := GetMaxCoupler(Train.Vehicles[SelVehicle],False);
      ConType1          := GetControlType(Train.Vehicles[SelVehicle],False);
    end
    else
      SelectCouplerMax := 3;

    if (Train.Vehicles[SelVehicle+1].Texture <> nil) then
    begin
      NextCouplerMax    := GetMaxCoupler(Train.Vehicles[SelVehicle+1]);
      ConType2          := GetControlType(Train.Vehicles[SelVehicle+1]);
    end
    else
      NextCouplerMax := 3;

    Flag := TFlag(Coupler-CouplerOld);

    if (Flag in CheckFlag(SelectCouplerMax)) and (Flag in CheckFlag(NextCouplerMax))
      and ((not (F4 in CheckFlag(Coupler))) or (ConType1 = ConType2)) or (ssCtrl in Shift) then
      Train.Vehicles[SelVehicle].Coupler := Coupler
    else
    begin
      Train.Vehicles[SelVehicle].Coupler := CouplerOld;
      SelectCoupler(CouplerOld);
      clCouplers.Hint := CouplerOld.ToString;
      ShowMessage('Niedopuszczalny rodzaj po��czenia mi�dzy tymi pojazdami.');
    end;
  end
  else
    Train.Vehicles[SelVehicle].Coupler := Coupler;
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

procedure TMain.ChangePage(const PageIndex:Integer);
begin
  Pages.ActivePageIndex := PageIndex;
  pnlInfoTrain.Visible := Pages.ActivePage.PageIndex < tsSettings.PageIndex;
  sbTrain.Visible := Pages.ActivePage.PageIndex < tsSettings.PageIndex;

  if Pages.ActivePage = tsStart then
  begin
    SelList := slSCN;
    pcTrains.ActivePageIndex := 0;
    pcTrainsChange(self);
  end
  else
  if Pages.ActivePage = tsSettings then
    chAngle.Visible := FileExists(Util.Dir + '\libEGL.dll') and FileExists(Util.Dir + '\libGLESv2.dll');
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
  KeysGridClick(self);
end;

procedure TMain.FormActivate(Sender: TObject);
begin
  AppActivate(Application);
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Settings.SaveSettings;
end;

procedure TMain.ConfigChange(Sender:TObject);
begin
  lbTemperature.Caption := IntToStr(tbTemperature.Position) + '�C';
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  Application.OnActivate    := AppActivate;
  Application.OnDeactivate  := AppDeactivate;

  //Util.DIR := ExtractFilePath(ParamStr(0));
  //DIR := 'G:\MaSzyna\MaSzyna2009\';
  //Util.DIR := 'G:\MaSzyna\pctga\';
  //DIR := 'C:\Users\damia\Desktop';

  RemoveOldVersion;

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

  while i < Data.Scenarios.Count do
  begin
    if Data.Scenarios[i].ID = '-' then
    begin
      tvSCN.Items.AddObject(nil,Data.Scenarios[i].Name,Data.Scenarios[i]);
      Inc(i);
    end
    else
    begin
      Found := False;
      for y := 0 to tvSCN.Items.Count-1 do
      begin
          if SameStr(tvSCN.Items[y].Text, Data.Scenarios[i].ID) then
          begin
            tvSCN.Items.AddChildObject(tvSCN.Items[y],Data.Scenarios[i].Name,Data.Scenarios[i]);
            Inc(i);
            Found := True;
            break;
          end;
      end;

      if not Found then
        tvSCN.Items.Add(nil,Data.Scenarios[i].ID);
    end;
  end;

  if tvSCN.Items.Count > 0 then
  begin
    if Util.InitSCN <> '' then
    begin
      for i := 0 to tvSCN.Items.Count-1 do
        if SameText(tvSCN.Items[i].Text,Util.InitSCN) then
        begin
          tvSCN.Select(tvSCN.Items[i]);
          Break;
        end;
    end;

    if tvSCN.SelectionCount = 0 then
      if tvSCN.Items[0].Data <> nil then
        tvSCN.Select(tvSCN.Items[0])
      else
        if tvSCN.Items[1].Data <> nil then
          tvSCN.Select(tvSCN.Items[1]);
    tvSCN.SetFocus;
  end;

  tvSCN.Items.AlphaSort;
  tvSCN.Items.EndUpdate;
end;

procedure TMain.seDayChange(Sender: TObject);
begin
  case seDay.Value of
      0.. 65: cbSeason.ItemIndex := 4;
     66..158: cbSeason.ItemIndex := 1;
    159..252: cbSeason.ItemIndex := 2;
    253..341: cbSeason.ItemIndex := 3;
    342..366: cbSeason.ItemIndex := 4;
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
  try
    lbDepot.Items.BeginUpdate;
    lbDepot.Clear;

    if miSortByVehicleName.Checked then
    begin
      Data.Depot.Sort(TComparer<TTrain>.Construct(
          function (const L, R: TTrain): integer
          begin
            result := CompareVehicleNames(L, R);
          end
      ));
    end
    else
    begin
      Data.Depot.Sort(TComparer<TTrain>.Construct(
          function (const L, R: TTrain): integer
          begin
            result := CompareTrainNames(L, R);
          end
      ));
    end;

    for i := 0 to Data.Depot.Count-1 do
      if Data.Depot[i].TrainName.Length > 0 then
        lbDepot.AddItem(Data.Depot[i].TrainName + ': ' + PrepareTrainsetDesc(Data.Depot[i]),TObject(i))
      else
        lbDepot.AddItem(PrepareTrainsetDesc(Data.Depot[i]),TObject(i));

    lbDepot.Items.EndUpdate;

    if lbDepot.Count > 0 then
      lbDepot.ItemIndex := lbDepot.Count-1;
  except
    on E: Exception do
    begin
      ShowMessage('B��d wczytywania magazynu. Szczeg�y b��du: ' + E.Message);
      Util.Errors.Add('B��d wczytywania magazynu. Szczeg�y b��du: ' + E.Message);
    end;
  end;
end;

procedure TMain.AppActivate(Sender: TObject);
begin
  actRemoveVehicle.ShortCut := VK_DELETE;
  actAddVehicle.ShortCut := VK_INSERT;

  btnStart.Enabled := True;
end;

procedure TMain.AppDeactivate(Sender: TObject);
begin
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
      Errors.Add('Brak pliku mulitmedi�w dla tekstury ' + Textures[i].Dir + '\' + Textures[i].Plik);
  end;}
  if Util.Errors.Count > 0 then
      if ForceDirectories(Util.DIR + 'starter') then
        Util.Errors.SaveToFile(Util.DIR + 'starter\bledy.txt');
  Util.Destroy;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  TDepotThread.Create;
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

  Util.CheckInstallation(cbEXE.Items.Count);
end;

function TMain.GetSelList: TTrain;
begin
  if SelTrain >= 0 then
    if SelList = slSCN then
        Result := SCN.Trains[SelTrain]
    else
	    Result := Data.Depot[SelTrain]
  else
    Result := nil;
end;

procedure TMain.imFacebookClick(Sender: TObject);
begin
  OpenURL('https://www.facebook.com/MaSzynaeu07pl/');
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
  OpenURL('https://eu07.pl/');
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

procedure TMain.LoadScenery(const aSCN:TScenario);
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

  if FileExists(Util.DIR + 'scenery\images\' + SCN.Image) then
  begin
    Mini := TJPEGImage.Create;
    Mini.LoadFromFile(Util.DIR + 'scenery\images\' + SCN.Image);
    imScenario.Picture.Bitmap.Assign(Mini);
    Mini.Free;
  end;

  meDesc.Lines.BeginUpdate;
  meDesc.Text := SCN.Desc.Text;
  meDesc.Lines.EndUpdate;

  LoadTrains(SCN.Trains);
  lbTrainsClick(self);
  LoadWeather(SCN);
end;

procedure TMain.LoadTrains(const Trains:TList<TTrain>);
var
  i : Integer;
begin
  lbTrains.Items.BeginUpdate;
  lbTrains2.Items.BeginUpdate;
  lbTrains.Clear;

  for i := 0 to Trains.Count-1 do
  begin
    if (not chOnlyForDriving.Checked) or ((Trains[i].Vehicles.Count > 0)
      and (Trains[i].Vehicles[0].CabOccupancy in [coHeadDriver,coRearDriver])) then
    begin
      if (chShowAI.Checked) or (not Trains[I].AI) then
        lbTrains.AddItem(PrepareTrainsetDesc
        (Trains[i]),TObject(i));
    end;
  end;
  lbTrains2.Items := lbTrains.Items;

  if lbTrains.Count > 0 then
    lbTrains.ItemIndex := 0
  else
    ClearTrainScroll;

  lbTrains2.Items.EndUpdate;
  lbTrains.Items.EndUpdate;
end;

procedure TMain.LoadWeather(const aSCN:TScenario);
begin
  if aSCN.Config.Day > 0 then
    seDay.Value := aSCN.Config.Day
  else
    seDay.Value := DayOfTheYear(Now);

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
  if (not Assigned(tvSCN.Selected)) then exit;

  if (tvSCN.Selected.Data = nil) then
    if chAutoExpandTree.Checked then
    begin
      tvSCN.FullCollapse;
      tvSCN.Select(Node.getFirstChild);
    end
    else
      Exit;

  if (SCN = TScenario(tvSCN.Selected.Data)) and (Sender <> chOnlyForDriving) then Exit;
  LoadScenery(TScenario(tvSCN.Selected.Data));
end;

procedure TMain.tvSCNCompare(Sender: TObject; Node1, Node2: TTreeNode;
  Data: Integer; var Compare: Integer);
begin
  If node1.Data = node2.Data Then
    compare := AnsiCompareText(Node1.Text, NOde2.Text)
  Else
    If Assigned(node1.data) Then
      compare := -1
    Else
      compare := 1;
end;

procedure TMain.OnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Point : TPoint;
begin
  GetCursorPos(Point);

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
      begin
        pmTrainsets.PopupComponent := nil;
        pmTrainsets.Popup(Point.X,Point.Y);
      end
      else
        pmDepot.Popup(Point.X,Point.Y);
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

procedure TMain.BitmapMouseEnter(Sender : TObject);
var
  Image : TImage;
begin
  Image := (Sender as TImage);

  if Train.Vehicles[Image.Tag].Number > 0 then
  begin
    Image.Hint      := 'Numer wagonu: ' + Train.Vehicles[Image.Tag].Number.ToString;
    Image.ShowHint  := True;
  end
  else
    Image.ShowHint := False;
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
  ChangePage(2);
  btnCheckUpdate.SetFocus;
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
    OpenDir(Util.DIR + lbModel.Hint);
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
      meMission.Lines.Add('Poci�g prowadzony przez komputer.');
    meMission.Lines.Add(Train.Desc);
    meMission.Lines.EndUpdate;

    meTimetable.Lines.BeginUpdate;
    meTimetable.Text := '';

    if (Train.TimeTable.Length > 0) and (FileExists(Util.DIR + 'scenery\' + Train.TimeTable + '.txt')) then
      meTimetable.Lines.LoadFromFile(Util.DIR + 'scenery\' + Train.TimeTable + '.txt')
    else
      if FileExists(Util.DIR + 'scenery\' + Train.TrainName + '.txt') then
        meTimetable.Lines.LoadFromFile(Util.DIR + 'scenery\' + Train.TrainName + '.txt' );

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

  Mark              := TShape.Create(sbTrain);
  Mark.Brush.Style  := bsClear;
  Mark.Pen.Width    := 3;
  Mark.Pen.Color    := Color;
  Mark.Parent       := sbTrain;
  Mark.Left         := Image.Left - 1;
  Mark.Width        := Image.Width + 2;
  Mark.Height       := Image.Height + 3;
  Mark.Tag          := Image.Tag;
  Mark.OnDragOver   := ShapeDragOver;
  Mark.OnDragDrop   := ShapeDragDrop;
  Mark.OnMouseDown  := OnMouseDown;
  Mark.Hint         := Image.Hint;
  Mark.ShowHint     := Mark.Hint.Length > 0;
end;

procedure TMain.SelectVehicle(const Sender:TObject;const SelectTex:Boolean=True);
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

  if (Vehicle.Texture <> nil) and (Vehicle.Texture.Models[Vehicle.ModelID].Fiz.MaxLoad > 0) then
    seLoadCount.MaxValue := Vehicle.Texture.Models[Vehicle.ModelID].Fiz.MaxLoad
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

procedure TMain.LoadModelData(const Physics:TPhysics);
begin
  if Physics <> nil then
  begin
    lbMass.Caption := FloatToStr(Physics.Mass / 1000);
    lbLength.Caption := FloatToStr(Physics.Length);
    lbVMax.Caption := FloatToStr(Physics.VMax);
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
  cbTypesChange(self);

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
  if Data.Textures.Count = 0 then Exit;
    lbTextures.Items.BeginUpdate;
  if Vehicle.Texture <> nil then
  begin
    SelectModel(Vehicle.Texture,Vehicle.ModelID);

    cbLoadType.Items.Clear;
    ExtractStrings([','],[],PChar(Vehicle.Texture.Models[Vehicle.ModelID].Fiz.LoadAccepted),cbLoadType.Items);

    if not SameText(Vehicle.TypeChk,Vehicle.Texture.Models[Vehicle.ModelID].Model) then
      lbModel.Caption := lbModel.Caption + ' (!)';

    lbTextures.ItemIndex := lbTextures.Items.IndexOf(Vehicle.Texture.Plik);
  end
  else
  begin
    i := 0;
    while (not SameText(Data.Textures[i].Dir,Vehicle.Dir)) and (i < Data.Textures.Count-1) do
      Inc(i);

    if SameText(Data.Textures[i].Dir,Vehicle.Dir) then
      SelectModel(Data.Textures[i])
    else
    begin
      cbTypes.ItemIndex := -1;
      cbModels.ItemIndex := -1;
      lbTextures.ItemIndex := -1;
    end;
  end;
  lbTextures.Items.EndUpdate;
end;

procedure TMain.LoadTrainParams;
var
  TrainParams : TTrainParams;
begin
  if Train <> nil then
  begin
    TrainParams := RecalcTrainParams(Train);

    if TrainParams.Mass < 200000 then
      TrainParams := RecalcTrainParams(Train,True);

    lbCountVehicles.Caption := IntToStr(Train.Vehicles.Count);
  end
  else
    lbCountVehicles.Caption := '';

  try
    if TrainParams.Length > 0 then
      lbTrainLength.Caption := FloatToStr(TrainParams.Length)
    else
      lbTrainLength.Caption := '';

    if TrainParams.Mass > 0 then
    begin
      lbTrainMass.Caption := FloatToStr(TrainParams.Mass / 1000);
      lbTrainBrutto.Caption := FloatToStr((TrainParams.Mass + TrainParams.LoadMass) / 1000);
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

procedure TMain.DrawTrain(const Train:TTrain);
var
  i, ImageWidth, ScrollPos : Integer;
  Image : TImage;
begin
  ImageWidth  := 0;
  ScrollPos := sbTrain.HorzScrollBar.Position;
  ClearTrainScroll;
  if Train <> nil then
  begin
    for i := Train.Vehicles.Count-1 downto 0 do
    begin
      Image := TImage.Create(self);
      Image.Parent := sbTrain;
      Image.Align := alLeft;
      Image.Stretch := True;
      Image.Constraints.MaxHeight := 30 * MiniFactor;
      Image.OnMouseDown := ImageMouseDown;
      Image.OnDragOver := BitmapDragOver;
      Image.OnDragDrop := BitmapDragDrop;
      Image.OnMouseEnter := BitmapMouseEnter;
      Image.Tag := i;
      Image.Name := 'Image' + IntToStr(i);
      Image.Picture.Bitmap.Assign(PaintVehicle(Train.Vehicles[i].Texture,Train.Vehicles[i].ModelID));
      Image.Width := Image.Picture.Bitmap.Width * MiniFactor;
      Inc(ImageWidth,Image.Width);
    end;
  end;

  sbTrain.HorzScrollBar.Range := ImageWidth;
  sbTrain.HorzScrollBar.Position := ScrollPos;

  if SelImage <> nil then
    SelectVehicle(SelImage);

  LoadTrainParams;
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

    if Vehicle.Number > 0 then
    begin
      Image.Hint      := 'Numer wagonu: ' + Vehicle.Number.ToString;
      Image.ShowHint  := True;
    end
    else
      Image.Hint := '';

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
  begin
    if (Train.Vehicles[SelVehicle].Texture <> nil)
      and (Train.Vehicles[SelVehicle].Texture.Typ >= tySZYNOBUS)
      and (Train.Vehicles[SelVehicle].LoadType.Length > 0) then
    begin
      Train.Vehicles[SelVehicle].Loadquantity := seLoadCount.Value;
      LoadTrainParams;
    end
    else
      seLoadCount.Value := Train.Vehicles[SelVehicle].Loadquantity;
  end;
end;

procedure TMain.SetSelList(const Value: TTrain);
begin
  if SelList = slSCN then
    SCN.Trains[SelTrain] := Value
  else
    Data.Depot[SelTrain] := Value;
end;

function TMain.PaintVehicle(const Tex:TTexture; const ModelID:Integer=0;const Mini:Boolean=True):TBitmap;
begin
  result := TBitmap.Create;

  if Tex <> nil then
  begin
    if FileExists(Util.DIR + 'textures\mini\' + Tex.Models[ModelID].MiniD + '.bmp') then
      result.LoadFromFile(Util.DIR + 'textures\mini\' + Tex.Models[ModelID].MiniD + '.bmp')
    else
      if FileExists(Util.DIR + 'textures\mini\' + Tex.Models[ModelID].Mini + '.bmp') then
        result.LoadFromFile(Util.DIR + 'textures\mini\' + Tex.Models[ModelID].Mini + '.bmp');
  end;

  if result.Empty then
    if FileExists(Util.DIR + 'textures\mini\other.bmp') then
      result.LoadFromFile(Util.DIR + 'textures\mini\other.bmp');

  if Mini then
    imMini.Picture.Bitmap := result;
end;

procedure TMain.pcSettingsChange(Sender: TObject);
begin
  if pcSettings.ActivePage = tsGraphics then
  begin
    Settings.LoadPresets;
    cbPreset.ItemIndex := 0;
  end;
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
  miCopyTexture.Visible := lbTextures.ItemIndex >= 0;
  miOpenTexDir.Visible  := lbTextures.ItemIndex >= 0;
end;

procedure TMain.pmTrainsetsPopup(Sender: TObject);
var
  MI : TMenuItem;
  i : Integer;
begin
  miRemoveVehicle.Visible := pmTrainsets.PopupComponent = nil;

  if lbTrains.Count > 0 then
  begin
    miReplaceTrain.Clear;
    miReplaceTrain.Visible := Data.Depot.Count > 0;
    for i := 0 to Data.Depot.Count-1 do
    begin
      MI := TMenuItem.Create(miReplaceTrain);
      MI.Caption := lbDepot.Items[i];
      MI.Tag := i;
      MI.OnClick := miTrainClick;
      miReplaceTrain.Add(MI);
    end;

    miAddTrain.Clear;
    miAddTrain.Visible := Data.Depot.Count > 0;
    for i := 0 to Data.Depot.Count-1 do
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
  ReplaceTrain(Data.Depot[Index].Vehicles);
end;

procedure TMain.miAddTrainClick(Sender: TObject);
var
  Index : Integer;
begin
  Index := (Sender as TMenuItem).Tag;
  AddTrain(Data.Depot[Index].Vehicles);
  Connect(Train,Train.Vehicles.Count-Data.Depot[Index].Vehicles.Count-1);
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

procedure TMain.edFieldofview2Exit(Sender: TObject);
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
  Util.OpenFile((Sender as TButton).Hint);
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
      LoadTrainParams;
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
    AssignTexToVehicle(Train.Vehicles[SelVehicle+Result],Data.Textures[Tex.NextTexID]);
    Tex := Data.Textures[Tex.NextTexID];
    Inc(Result);
  end;
end;

function TMain.AssignPrevVehicles(Tex:TTexture):Integer;
begin
  Result := 1;
  while (SelVehicle - Result >= 0) and (SameText(Tex.Dir,Train.Vehicles[SelVehicle-Result].Dir)) and (Tex.PrevTexID >= 0) do
  begin
    AssignTexToVehicle(Train.Vehicles[SelVehicle-Result],Data.Textures[Tex.PrevTexID]);
    Tex := Data.Textures[Tex.PrevTexID];
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
    OpenDir(Util.DIR + 'dynamic\' + Tex.Dir);
end;

procedure TMain.miSortByTrackNameClick(Sender: TObject);
begin
  miSortByVehicleName.Checked := False;
  miSortByTrackName.Checked   := True;
  LoadMagazine;
end;

procedure TMain.miSortByVehicleNameClick(Sender: TObject);
begin
  miSortByVehicleName.Checked := True;
  miSortByTrackName.Checked   := False;
  LoadMagazine;
end;

procedure TMain.SetItemDesc(const Trainset:TTrain);
begin
  lbTrains.Items[lbTrains.ItemIndex] := PrepareTrainsetDesc(Trainset);
  if lbTrains2.ItemIndex = -1 then
    lbTrains2.Items[lbTrains.ItemIndex] := lbTrains.Items[lbTrains.ItemIndex]
  else
    lbTrains2.Items[lbTrains2.ItemIndex] := lbTrains.Items[lbTrains.ItemIndex];
end;

end.
