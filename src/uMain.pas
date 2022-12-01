{
  Starter
  Copyright (C) 2019-2022 Damian Skrzek (szczawik)

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
  along with Starter. If not, see <http://www.gnu.org/licenses/>.
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
    tsInfo: TTabSheet;
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
    tsKeyboard: TTabSheet;
    actSaveKeyboard: TAction;
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
    cbLang: TComboBox;
    pnlTime: TPanel;
    dtTime: TDateTimePicker;
    Splitter: TSplitter;
    actReplaceTrain: TAction;
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
    btnCurrentTime: TButton;
    actCurrentTime: TAction;
    chMouseInversionVertical: TCheckBox;
    chMouseInversionHorizontal: TCheckBox;
    miRemoveVehicle: TMenuItem;
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
    miSortBy: TMenuItem;
    miSortByVehicleName: TMenuItem;
    miSortByTrackName: TMenuItem;
    chTrainMan: TCheckBox;
    actPreset: TAction;
    actANGLE: TAction;
    actSetNumber: TAction;
    chAutoExpandTree: TCheckBox;
    actKeyboardView: TAction;
    chHideArchival: TCheckBox;
    actHideArchival: TAction;
    pnlRightMargin: TPanel;
    actPresetSave: TAction;
    pnlSettingsSet: TPanel;
    cbPreset: TComboBox;
    btnPreset: TButton;
    btnPresetSave: TButton;
    lbPreset: TLabel;
    actRandomLoad: TAction;
    Losowyadunekdlapocigu1: TMenuItem;
    chLogExt: TCheckBox;
    actFPS: TAction;
    actSearchKey: TAction;
    sbGraphic: TScrollBox;
    pnlGraphic: TPanel;
    Panel1: TPanel;
    lbReflectionsFidelity: TLabel;
    chShadows: TCheckBox;
    cbReflectionsFidelity: TComboBox;
    Panel3: TPanel;
    Label4: TLabel;
    edFieldofview: TEdit;
    pnlFPS: TPanel;
    chFPSLimiter: TCheckBox;
    seFPSLimit: TSpinEdit;
    Panel12: TPanel;
    Label40: TLabel;
    lbHDR: TLabel;
    chExtraEffects: TCheckBox;
    cbGfxrenderer: TComboBox;
    chChromaticAberration: TCheckBox;
    chMotionBlur: TCheckBox;
    chEnvmap: TCheckBox;
    chSkipPipeline: TCheckBox;
    chAngle: TCheckBox;
    cbHDR: TComboBox;
    Panel22: TPanel;
    Label35: TLabel;
    Label10: TLabel;
    chPythonThreadedUpload: TCheckBox;
    chPythonEnabled: TCheckBox;
    cbPyscreenrendererpriority: TComboBox;
    pnlGraphicLeft: TPanel;
    Label7: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label5: TLabel;
    Label14: TLabel;
    lbMaxCabTexSize: TLabel;
    lbBufferRes: TLabel;
    cbMaxtexturesize: TComboBox;
    cbSplinefidelity: TComboBox;
    cbAnisotropicfiltering: TComboBox;
    cbMultisampling: TComboBox;
    cbResolution: TComboBox;
    chFullScreenWindowed: TCheckBox;
    cbMaxcabtexturesize: TComboBox;
    cbBuffer: TComboBox;
    tsControl: TTabSheet;
    cbKey: TComboBox;
    btnSaveKeyboard: TButton;
    KeysGrid: TStringGrid;
    pnlKeyEdit: TPanel;
    cbKey1: TComboBox;
    cbKey2: TComboBox;
    cbKey3: TComboBox;
    btnKeyboard: TButton;
    pnlKeySearch: TPanel;
    lbCaptionFind: TLabel;
    edSearchKey: TEdit;
    btnSearchKey: TButton;
    lbDrawRange: TLabel;
    cbDrawRange: TComboBox;
    lbShadowRank: TLabel;
    cbShadowRank: TComboBox;
    lbShadowSize: TLabel;
    tbShadowSize: TTrackBar;
    chUsevbo: TCheckBox;
    chGfxresourcesweep: TCheckBox;
    Label18: TLabel;
    cbReflectionsFramerate: TComboBox;
    Label36: TLabel;
    cbShadowMapSize: TComboBox;
    lbShadowRange: TLabel;
    cbShadowRange: TComboBox;
    lbShadowsCabRange: TLabel;
    cbShadowsCabRange: TComboBox;
    chShadowMap: TCheckBox;
    chGfxresourcemove: TCheckBox;
    chVsync: TCheckBox;
    chSmoke: TCheckBox;
    Label38: TLabel;
    cbSmokeFidelity: TComboBox;
    chSkipRendering: TCheckBox;
    lbSettingsInfo: TLabel;
    tbVolumePaused: TTrackBar;
    lbVolumePaused: TLabel;
    pnlVolumeLegend: TPanel;
    lbVolMin: TLabel;
    lbVolMax: TLabel;
    pmHelp: TPopupMenu;
    miOpenHelp: TMenuItem;
    miInstructions: TMenuItem;
    miIe1: TMenuItem;
    InstrukcjaoprowadzeniuruchupocigwIr11: TMenuItem;
    Instrukcjaoprowadzeniuradiocznoci1: TMenuItem;
    InstrukcjaoprowadzeniumanewrwIr91: TMenuItem;
    Panel4: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    sbAttachments: TScrollBox;
    meInfo: TMemo;
    Label43: TLabel;
    Splitter1: TSplitter;
    N1: TMenuItem;
    tbBrakeStep: TTrackBar;
    lbBrakeStep: TLabel;
    Panel5: TPanel;
    Label46: TLabel;
    Label48: TLabel;
    lbBrakeSpeed: TLabel;
    tbBrakeSpeed: TTrackBar;
    pnlVersion: TPanel;
    lbVersionCaption: TLabel;
    lbVersion: TLabel;
    actTrainRandomOrder: TAction;
    miTrainRandomOrder: TMenuItem;
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
    procedure actANGLEExecute(Sender: TObject);
    procedure actSetNumberExecute(Sender: TObject);
    procedure actSetNumberUpdate(Sender: TObject);
    procedure tvSCNCompare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure actKeyboardViewExecute(Sender: TObject);
    procedure actKeyboardViewUpdate(Sender: TObject);
    procedure actHideArchivalExecute(Sender: TObject);
    procedure actPresetSaveExecute(Sender: TObject);
    procedure actPresetUpdate(Sender: TObject);
    procedure actRandomLoadExecute(Sender: TObject);
    procedure lbTexStationMouseEnter(Sender: TObject);
    procedure actFPSExecute(Sender: TObject);
    procedure cbHDRChange(Sender: TObject);
    procedure actSearchKeyExecute(Sender: TObject);
    procedure actSearchKeyUpdate(Sender: TObject);
    procedure pcSettingsChange(Sender: TObject);
    procedure actRandomLoadUpdate(Sender: TObject);
    procedure miIe1Click(Sender: TObject);
    procedure InstrukcjaoprowadzeniuruchupocigwIr11Click(Sender: TObject);
    procedure Instrukcjaoprowadzeniuradiocznoci1Click(Sender: TObject);
    procedure InstrukcjaoprowadzeniumanewrwIr91Click(Sender: TObject);
    procedure miOpenHelpClick(Sender: TObject);
    procedure pmHelpPopup(Sender: TObject);
    procedure pmDepotPopup(Sender: TObject);
    procedure lbModelCaptionDblClick(Sender: TObject);
    procedure actTrainRandomOrderExecute(Sender: TObject);
    procedure actTrainRandomOrderUpdate(Sender: TObject);
  private
    SCN : TScenario;

    SelVehicle : Integer;

    procedure OpenAttachment(Sender: TObject);
    ///<summary>Maluje na nowo podgl¹d graficzny sk³adu wraz z wyœwietlanymi parametrami zachowuj¹c zaznaczenie.</summary>
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
    procedure SelectModel(const Tex: TTexture; const ModelID: Integer=0);
    function MiniPath(const Tex:TTexture; const ModelID:Integer;const Mini:Boolean=True):string;
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
    procedure MoveVehicle(FromPos, ToPos: integer);
    procedure RefreshTrain(const SelPos: Integer=-1);
    procedure Mark(const Image: TImage;const Color:TColor=clYellow);
    procedure LoadVehicle(const Vehicle: TVehicle);
    procedure ReloadSettingsState;
    function UniqueVehicleName(const Vehicle:TVehicle;const Unique:Boolean=False):string; overload;
    procedure miTrainClick(Sender: TObject);
    procedure miAddTrainClick(Sender: TObject);
    procedure ReplaceTrain(const Vehicles: TObjectList<TVehicle>);
    procedure AssignBrakeActing(Vehicle: TVehicle);
    procedure AssignBrakeAdjust(Vehicle: TVehicle);
    procedure AssignBrakeState(Vehicle: TVehicle);
    ///<summary>Prze³adowuje opis wybranego sk³adu.</summary>
    procedure TrainDesc;
    procedure NoSelection;
    procedure LoadScenery(const aSCN: TScenario);
    procedure RemoveFromDepot(const Index: Integer);
    procedure LoadWeather(const aSCN: TScenario);
    procedure AddTrain(const Vehicles: TObjectList<TVehicle>);
    function AssignNextVehicles(Tex: TTexture;const FirstIndex:Integer):Integer;
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LoadTrainParams;
    procedure LoadTrains(const Trains: TList<TTrain>);
    procedure RemoveVehicle(const Index:Integer;Indexes:TList<Integer>=nil);
    procedure MatchOccupancy(Vehicle: TVehicle;const Position: Integer);
    procedure BitmapMouseEnter(Sender: TObject);
    procedure ViewKeyOnKeyboard;
    procedure LoadMini(const Name: string);
    function CheckMoveVehicle(const FromPos, ToPos: Integer): Boolean;
    procedure ReverseMultiple(const Value:Integer=-1);
    procedure FlipBitmap(Bitmap:TBitmap;const Flip:Boolean);
    procedure FaultList(const Scenery: TScenario);
    procedure ReplaceVehicle(const Tex: TTexture; const Index: Integer);
    function FirstCarIndex(const Index: Integer): Integer;
    ///<summary>Ustawia najwy¿sze mo¿liwe flagi sprzêgów w wybranym sk³adzie.</summary>
    procedure AutoCoupler;
    function RandomReverse: Integer;

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
    procedure AddingVehicle(Position: Integer;Tex:TTexture;const CheckPrev:Boolean;const CheckNext:Boolean);
    procedure RemoveVehicles(const Index: Integer;Vehicles:TObjectList<TVehicle>=nil);
    procedure LoadMagazine;
    procedure ScenariosList;
    function RemoveAllTrains: Boolean;
  end;

var
  Main: TMain;

implementation

uses DateUtils, JPEG, uParser, uSettingsAdv, uUpdater, uSearch, uTextureBase, uDepot,
     uUART, uAbout, Clipbrd, StrUtils, uTexRandomizer, uUtilities, uData, uKeyboard{, uInstaller};

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
  {for i := 0 to lbTextures.Count-1 do
  begin
    lbTextures.ItemIndex := i;
    lbTexturesClick(self);
    actAddVehicleExecute(self);
    Application.ProcessMessages;
  end;}
  DepoTrain := TTrain.Create;
  DepoTrain.TrainName := InputBox(
                        Util.LAB_TRAIN_NAME{'Nazwa poci¹gu'},
                        Util.LAB_TRAIN_NAME + ':'{'Nazwa poci¹gu:'},
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

procedure TMain.InstrukcjaoprowadzeniumanewrwIr91Click(Sender: TObject);
begin
  Util.OpenFile('\przepisy_kolejowe\ir-9.pdf');
end;

procedure TMain.Instrukcjaoprowadzeniuradiocznoci1Click(Sender: TObject);
begin
  Util.OpenFile('\przepisy_kolejowe\ir-5.pdf');
end;

procedure TMain.InstrukcjaoprowadzeniuruchupocigwIr11Click(Sender: TObject);
begin
  Util.OpenFile('\przepisy_kolejowe\ir-1.pdf');
end;

function TMain.IsVehicleName(const Name:string):Integer;
var
  i, y : Integer;
begin
  Result := -1; // aby pominac sprawdzany pociag

  for i := 0 to SCN.Trains.Count-1 do
    for y := 0 to SCN.Trains[i].Vehicles.Count-1 do
      if (SameText(SCN.Trains[i].Vehicles[y].Name,Name)) then
        Inc(Result);

  for i := 0 to SCN.Vehicles.Count-1 do
    if SameText(SCN.Vehicles[i].Name,Name) then
      Inc(Result);
end;

function TMain.UniqueVehicleName(const Vehicle:TVehicle;const Unique:Boolean=False):string;
var
  Suffix, Found : Integer;
begin
  Result := '';

  if (Vehicle.Model.MiniD.Length > 0) then
    if Vehicle.Model.MiniD <> Vehicle.Model.Mini then
      Result := Vehicle.Model.MiniD;

  if Result.Length = 0 then
    if (Vehicle.ReplacableSkin.Length > 0) and (not SameText('NONE',Vehicle.ReplacableSkin)) then
      Result := Vehicle.ReplacableSkin
    else
      Result := Vehicle.Name;

  if Unique then
  begin
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
begin
  if Tex = nil then
    Tex := (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);

  AddingVehicle(Position,Tex,CheckPrev,CheckNext);

  TrainDesc;
  RefreshTrain(Position);
end;

procedure TMain.AddingVehicle(Position:Integer;Tex:TTexture;const CheckPrev:Boolean;const CheckNext:Boolean);
var
  Vehicle : TVehicle;
begin
  Vehicle := TVehicle.Create;
  Vehicle.MinDist  := -1;
  Vehicle.MaxDist  := 0;
  Vehicle.Dist     := 0;
  Vehicle.Vel      := 0;
  Vehicle.Settings := '0';
  Vehicle.MaxLoad  := -1;

  TryStrToInt(edSway.Text,Vehicle.Sway);
  TryStrToInt(edFlatness.Text,Vehicle.Flatness);
  TryStrToInt(edFlatnessProb.Text,Vehicle.FlatnessProb);
  TryStrToInt(edFlatnessRand.Text,Vehicle.FlatnessRand);

  AssignBrakeActing(Vehicle);
  AssignBrakeAdjust(Vehicle);
  AssignBrakeState(Vehicle);

  Vehicle.LoadType := cbLoadType.Text;
  Vehicle.Loadquantity := seLoadCount.Value;

  if Train.Vehicles.Count = 0 then Position := 0;

  if Position > Train.Vehicles.Count then
    Train.Vehicles.Insert(Train.Vehicles.Count-1,Vehicle)
  else
    Train.Vehicles.Insert(Position,Vehicle);

  AssignTexToVehicle(Vehicle,Tex);
  MatchOccupancy(Vehicle,Position);
  AutoConnect(Train.Vehicles,Position-1);
  AutoConnect(Train.Vehicles,Position);
  if (Train.Vehicles.Count = 1) and (Vehicle.Coupler = 0) then
    Vehicle.Coupler := 3;

  if (CheckNext) and (Tex.NextTexID > 0) then
    AddingVehicle(Position+1,Data.Textures[Tex.NextTexID],False,True);

  if (CheckPrev) and (Tex.PrevTexID > 0) then
  begin
    Vehicle.CabOccupancy := coNobody;
    AddingVehicle(Position,Data.Textures[Tex.PrevTexID],True,False);
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
    if Train.Vehicles[SelVehicle+SkipMultiple-1].Dist >= 0 then
    begin
      if Train.Vehicles[SelVehicle+SkipMultiple-1].Texture.ID = Train.Vehicles[SelVehicle+SkipMultiple].Texture.PrevTexID then
        Inc(SkipMultiple)
      else
        Break;
    end
    else
      if Train.Vehicles[SelVehicle+SkipMultiple-1].Texture.ID = Train.Vehicles[SelVehicle+SkipMultiple].Texture.NextTexID then
        Inc(SkipMultiple)
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
    chPythonThreadedUpload.Enabled        := False;
    frmSettingsAdv.chMipmaps.Checked      := False;
  end
  else
    chPythonThreadedUpload.Enabled        := True;
end;

procedure TMain.AutoCoupler;
var
  i : Integer;
begin
  for i := 0 to Train.Vehicles.Count-1 do
    AutoConnect(Train.Vehicles,i);

  SelectCoupler(Train.Vehicles[SelVehicle].Coupler);
end;

procedure TMain.actAutoCouplerExecute(Sender: TObject);
begin
  AutoCoupler;
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
                      Util.LAB_TRAIN_NAME_CHANGE {'Zmiana nazwy poci¹gu'},
                      Util.LAB_TRAIN_NAME + ':',
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
    if Train.Vehicles[i].Fiz <> nil then
      if ContainsText(Train.Vehicles[i].Fiz.LoadAccepted,cbLoadType.Text) then
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
  Str, TrainName : string;
begin
  if Train.TrainName.Length = 0 then
    TrainName := 'none'
  else
    TrainName := StringReplace(Train.TrainName,' ','_',[rfReplaceAll]);

  if Train.Track.Length = 0 then
    Train.Track := 'none';

  str := 'trainset ' + TrainName + ' ' + Train.Track + ' ' + FloatToStr(Train.Dist) + ' ' + FloatToStr(Train.Vel) + #13#10;

  str := str + PrepareTrainset(Train.Vehicles).Text;

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
  chFPSLimiter.Checked                    := False;
  frmSettingsAdv.chCompressTex.Checked    := True;
  frmSettingsAdv.chMipmaps.State          := cbGrayed;
  frmSettingsAdv.chUseGLES.State          := cbGrayed;
  frmSettingsAdv.chShaderGamma.State      := cbGrayed;

  cbMouseScale.ItemIndex                := 0;
  cbLang.ItemIndex                      := 0;

  tbSoundVolume.Position                := 15;
  tbRadioVolume.Position                := 10;
  tbVehiclesSounds.Position             := 10;
  tbPositionalsSounds.Position          := 10;
  tbGlobalSounds.Position               := 10;
  tbVolumePaused.Position               := 10;
  tbShadowSize.Position                 := 0;
  tbBrakeStep.Position                  := 10;
  tbBrakeSpeed.Position                 := 10;

  cbReflectionsFidelity.ItemIndex       := 0;

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
  cbDrawRange.ItemIndex                 := 0;
  cbShadowRank.ItemIndex                := 2;

  edFriction.Text     := '1.0';
  edFieldofview.Text  := '45';
  edFeedbackport.Text := '888';
  frmSettingsAdv.cbConvertmodels.Text   := '0';
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

procedure TMain.actFPSExecute(Sender: TObject);
begin
  seFPSLimit.Enabled := chFPSLimiter.Checked;
end;

procedure TMain.actKeyboardViewExecute(Sender: TObject);
var
  Form : TForm;
begin
  Form := Application.FindComponent('frmKeyboard') as TForm;

  if Form <> nil then
    Form.Show
  else
    with TfrmKeyboard.Create(Application) do
    begin
      Show;
      ViewKeys(cbKey1.Text,cbKey2.Text,cbKey3.Text);
    end;
end;

procedure TMain.actKeyboardViewUpdate(Sender: TObject);
begin
  actKeyboardView.Enabled := KeysGrid.RowCount > 1;
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

procedure TMain.actHideArchivalExecute(Sender: TObject);
begin
  if Self.Active then
    ScenariosList;
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
  ClipTrain := TLexParser.ParseTrainFromClipBoard(Clipboard.AsText);
  if ClipTrain <> nil then
    ReplaceTrain(ClipTrain.Vehicles);
end;

procedure TMain.actPasteFromClipboardUpdate(Sender: TObject);
begin
  actPasteFromClipboard.Visible := (Clipboard.AsText.Length > 100) and (Pos('dynamic',Clipboard.AsText) > 0);
end;

procedure TMain.actPresetExecute(Sender: TObject);
begin
  if FileExists(Util.DIR + 'starter\#' + cbPreset.Items[cbPreset.ItemIndex] + '.ini') then
  begin
    Settings.ReadSettings('#' + cbPreset.Items[cbPreset.ItemIndex]);
    ReloadSettingsState;
  end
  else
    ShowMessage(Util.LAB_FILE_NOT_FOUND {'Nie znaleziono wybranego pliku.'});
end;

procedure TMain.actPresetSaveExecute(Sender: TObject);
var
  FileName : string;
begin
  FileName := 'moje_ustawienia';

  if InputQuery(Util.LAB_SAVE_PRESET {'Zapis presetu ustawieñ'},
             Util.LAB_SET_PRESET_NAME {'Nadaj nazwê zestawu ustawieñ:'},
             FileName)
  then
    if Trim(FileName).Length > 0 then
    begin
      Settings.SaveSettings('starter\#' + FileName + '.ini');
      Settings.LoadPresets;
    end;
end;

procedure TMain.actPresetUpdate(Sender: TObject);
begin
  actPreset.Enabled := cbPreset.ItemIndex >= 0;
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
        Util.LogAdd('Wyst¹pi³ b³¹d przy losowaniu tekstur. Szczegó³y b³êdu: ' + E.Message, True);
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
    TLexParser.ParseScenario(Data.Scenarios[i]);
  if (tvSCN.Selected <> nil) and (tvSCN.Selected.Data <> nil) then
  begin
    LoadScenery(TScenario(tvSCN.Selected.Data));
    FaultList(TScenario(tvSCN.Selected.Data));
  end;
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

function TMain.RemoveAllTrains:Boolean;
var
  i : Integer;
begin
  try
    for i := 0 to SCN.Trains.Count-1 do
      while SCN.Trains[i].Vehicles.Count > 0 do
        SCN.Trains[i].Vehicles.Extract(SCN.Trains[i].Vehicles.First);

    LoadTrains(SCN.Trains);
    DrawTrain(Train);
    SelTrain := -1;
    Result := True;
  except
    Result := False;
  end;
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

procedure TMain.RemoveVehicles(const Index:Integer;Vehicles:TObjectList<TVehicle>=nil);
begin
  if Vehicles = nil then Vehicles := Train.Vehicles;
  RemoveVehicle(Index, GetMultiple(Vehicles,Index));
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

procedure TMain.actSearchKeyExecute(Sender: TObject);
var
  i : Integer;
  Found : Boolean;
begin
  Found := False;

  if Sender <> nil then
    i := KeysGrid.Row + 1
  else
    i := 1;

  while i < KeysGrid.RowCount do
    if Pos(UpperCase(edSearchKey.Text),UpperCase(KeysGrid.Cells[3,i])) > 0 then
    begin
      KeysGrid.Row := i;
      Found := True;
      Break;
    end
    else
      Inc(i);

  if (not Found) and (Sender <> nil) then
    actSearchKeyExecute(nil);
end;

procedure TMain.actSearchKeyUpdate(Sender: TObject);
begin
  actSearchKey.Enabled := Length(edSearchKey.Text) > 1;
end;

procedure TMain.actSetMaxLoadToAllExecute(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to Train.Vehicles.Count-1 do
    if (Train.Vehicles[i].Texture.Typ <> tyUNKNOWN) and (Train.Vehicles[i].Texture.Typ >= tySZYNOBUS) then
      if Train.Vehicles[i].LoadType.Length > 0 then
        if Train.Vehicles[i].Fiz <> nil then
          Train.Vehicles[i].Loadquantity := Train.Vehicles[i].Fiz.MaxLoad;

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
  Number := InputBox(Util.LAB_CAR_NO {'Numer wagonu'},Util.LAB_CAR_NO + ':'{'Numer wagonu:'},Number);

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
  i : Integer;
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
  Starter.Text := TLexParser.ChangeConfig(SCN.Other.Text,SCN.Config);

  if cbBattery.ItemIndex = 1 then
    Train.Vel := 0
  else
    if cbBattery.ItemIndex = 2 then
      if Train.Vel < 0.2 then
        Train.Vel := 0.1;

  Train.Vehicles[SelVehicle].Name := UniqueVehicleName(Train.Vehicles[SelVehicle],True);

  Starter.Add('FirstInit');

  for i := 0 to SCN.Trains.Count-1 do
  begin
    if (frmSettingsAdv.chIgnoreIrrevelant.Checked) and (SCN.Trains[i].Irrelevant) then
      Continue;

    with SCN.Trains[i] do
    begin
      Starter.Add('trainset ' + TrainName + ' ' + Track + ' ' + FloatToStr(Dist) + ' ' + FloatToStr(Vel));

      Starter.AddStrings(PrepareTrainset(Vehicles));

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

function TMain.RandomReverse:Integer;
var
  i : Integer;
begin
  i := Random(100);
  if i mod 2 = 0 then
    result := -1
  else
    result := 0;
end;

procedure TMain.actTrainRandomOrderExecute(Sender: TObject);
var
  i : Integer;
  Waggons : TList<Integer>;
begin
  Waggons := TList<Integer>.Create;

  for i := SelVehicle to Train.Vehicles.Count-1 do
    if (Train.Vehicles[i].Texture.Typ in [tyA..tyZ]) and (Train.Vehicles[i].Texture.NextTexID < 0) then
      Waggons.Add(i);

  Randomize;
  for i := 0 to Waggons.Count-1 do
  begin
    Train.Vehicles.Exchange(Waggons[Random(Waggons.Count)],Waggons[Random(Waggons.Count)]);
    Train.Vehicles[Waggons[i]].Dist := RandomReverse;
  end;

  TrainDesc;
  DrawTrain(Train);
  AutoCoupler;

  Waggons.Free;
end;

procedure TMain.actTrainRandomOrderUpdate(Sender: TObject);
begin
  actTrainRandomOrder.Enabled := SelVehicle >= 0;
end;

procedure TMain.btnCheckUpdateMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ssRight in Shift then
    TfrmUpdater.UpdateProgram(True);
end;

procedure TMain.btnHelpClick(Sender: TObject);
var
  Point : TPoint;
begin
  GetCursorPos(Point);
  pmHelp.Popup(Point.X,Point.Y);
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
  RunInfo.Logo        := Train.Logo;

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
    Util.LogAdd('Nie znaleziono pliku wykonywalnego (' + ExtractFileName( RunInfo.EXE) + ') symulatora.',True);
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
var
  i : Integer;
  Indexes : TList<Integer>;
begin
  if SelVehicle >= 0 then
  begin
    Indexes := GetMultiple(Train.Vehicles,SelVehicle);
    for i := 0 to Indexes.Count-1 do
      AssignBrakeActing(Train.Vehicles[Indexes[i]]);
  end;
end;

procedure TMain.cbBrakeAdjustChange(Sender: TObject);
var
  i : Integer;
  Indexes : TList<Integer>;
begin
  if SelVehicle >= 0 then
  begin
    Indexes := GetMultiple(Train.Vehicles,SelVehicle);
    for i := 0 to Indexes.Count-1 do
      AssignBrakeAdjust(Train.Vehicles[Indexes[i]]);
  end;
end;

procedure TMain.cbBrakeStateChange(Sender: TObject);
var
  i : Integer;
  Indexes : TList<Integer>;
begin
  if SelVehicle >= 0 then
  begin
    Indexes := GetMultiple(Train.Vehicles,SelVehicle);
    for i := 0 to Indexes.Count-1 do
      AssignBrakeState(Train.Vehicles[Indexes[i]]);
  end;
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

  if cbGfxrenderer.ItemIndex < 2 then
    chFPSLimiter.Checked := False;

  ReloadSettingsState;
end;

procedure TMain.cbHDRChange(Sender: TObject);
begin
  Settings.ChangeHDR(cbHDR.ItemIndex = 0);
end;

procedure TMain.ReloadSettingsState;
var
  Value : Boolean;
begin
  Value := cbGfxrenderer.ItemIndex = 0;
  chMotionBlur.Enabled            := Value;
  chChromaticAberration.Enabled   := Value;

  chUsevbo.Enabled                := cbGfxrenderer.ItemIndex > 1;
  chFPSLimiter.Enabled            := cbGfxrenderer.ItemIndex > 1;

  chShadowMap.Enabled             := cbGfxrenderer.ItemIndex < 2;
  chExtraEffects.Enabled          := cbGfxrenderer.ItemIndex < 2;
  lbHDR.Enabled                   := cbGfxrenderer.ItemIndex < 2;
  cbHDR.Enabled                   := cbGfxrenderer.ItemIndex < 2;

  chShadows.Enabled               := cbGfxrenderer.ItemIndex = 2;

  Value := cbGfxrenderer.ItemIndex < 3;
  chEnvmap.Enabled                := Value;
  lbShadowsCabRange.Enabled       := Value;
  cbShadowsCabRange.Enabled       := Value;
  Label36.Enabled                 := Value;
  cbShadowMapSize.Enabled         := Value;
  lbShadowRange.Enabled           := Value;
  cbShadowRange.Enabled           := Value;
  Label18.Enabled                 := Value;
  cbReflectionsFramerate.Enabled  := Value;
  lbShadowRank.Enabled            := Value;
  cbShadowRank.Enabled            := Value;
  lbShadowSize.Enabled            := Value;
  tbShadowSize.Enabled            := Value;

  chSkipPipeline.Checked          := cbGfxrenderer.ItemIndex = 1;

  label6.Enabled                  := chSoundenabled.Checked;
  lbRadioVolume.Enabled           := chSoundenabled.Checked;
  lbVehiclesSounds.Enabled        := chSoundenabled.Checked;
  lbPositionalsSounds.Enabled     := chSoundenabled.Checked;
  lbGlobalSounds.Enabled          := chSoundenabled.Checked;
  lbVolumePaused.Enabled          := chSoundenabled.Checked;
  tbSoundVolume.Enabled           := chSoundenabled.Checked;
  tbRadioVolume.Enabled           := chSoundenabled.Checked;
  tbVehiclesSounds.Enabled        := chSoundenabled.Checked;
  tbPositionalsSounds.Enabled     := chSoundenabled.Checked;
  tbGlobalSounds.Enabled          := chSoundenabled.Checked;
  tbVolumePaused.Enabled          := chSoundenabled.Checked;
  lbVolMin.Enabled                := chSoundenabled.Checked;
  lbVolMax.Enabled                := chSoundenabled.Checked;

  Label14.Enabled                 := not chFullScreenWindowed.Checked;
  cbResolution.Enabled            := not chFullScreenWindowed.Checked;
end;

procedure TMain.cbKey1Change(Sender: TObject);
begin
  if KeysGrid.RowCount > 1 then
  begin
    Settings.KeyParams[KeysGrid.Row-1].Key := cbKey1.Items[cbKey1.ItemIndex];
    KeysGrid.Cells[0,KeysGrid.Row] := cbKey1.Items[cbKey1.ItemIndex];
    ViewKeyOnKeyboard;
  end;
end;

procedure TMain.cbKey2Change(Sender: TObject);
begin
  if KeysGrid.RowCount > 1 then
  begin
    Settings.KeyParams[KeysGrid.Row-1].Key2 := cbKey2.Items[cbKey2.ItemIndex];
    KeysGrid.Cells[1,KeysGrid.Row] := cbKey2.Items[cbKey2.ItemIndex];
    ViewKeyOnKeyboard;
  end;
end;

procedure TMain.cbKey3Change(Sender: TObject);
begin
  if KeysGrid.RowCount > 1 then
  begin
    Settings.KeyParams[KeysGrid.Row-1].Key3 := cbKey3.Items[cbKey3.ItemIndex];
    KeysGrid.Cells[2,KeysGrid.Row] := cbKey3.Items[cbKey3.ItemIndex];
    ViewKeyOnKeyboard;
  end;
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
    Util.LogAdd('B³¹d wewnêtrzny Startera.');
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

      if Data.Textures[i].Typ = tyOSOBA then
        slModels := slModels;

      if Data.Textures[i].Typ = tyZWIERZE then
        slModels := slModels;

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
      ReverseMultiple
    else
      ReverseMultiple(0);

  DrawTrain(Train);
end;

procedure TMain.ReverseMultiple(const Value:Integer=-1);
var
  Indexes : TList<Integer>;
  i : Integer;
begin
  Indexes := GetMultiple(Train.Vehicles,SelVehicle);

  for i := 0 to Indexes.Count-1 do
    Train.Vehicles[Indexes[i]].Dist := Value;

  Indexes.Sort;

  for i := 0 to (Indexes.Count div 2) - 1 do
    Train.Vehicles.Exchange(Indexes.First+i,Indexes.Last-i);

  for i := 0 to Indexes.Count-1 do
    AutoConnect(Train.Vehicles,Indexes[i]);
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

  if SelVehicle = -1 then exit;

  CouplerOld := Train.Vehicles[SelVehicle].Coupler;

  if Coupler > CouplerOld then
  begin
    SelectCouplerMax  := GetMaxCoupler(Train.Vehicles[SelVehicle],False);
    ConType1          := GetControlType(Train.Vehicles[SelVehicle],False);

    if Train.Vehicles.Count-1 > SelVehicle then
    begin
      NextCouplerMax    := GetMaxCoupler(Train.Vehicles[SelVehicle+1]);
      ConType2          := GetControlType(Train.Vehicles[SelVehicle+1]);
    end
    else
      NextCouplerMax := 300; // wysoka wartosc by nie pomijal w warunku ostatniego pojazdu

    Flag := TFlag(Coupler-CouplerOld);

    if (Flag in CheckFlag(SelectCouplerMax)) and (Flag in CheckFlag(NextCouplerMax))
      and ((not (F4 in CheckFlag(Coupler))) or (ConType1 = ConType2)) or (ssCtrl in Shift) then
      Train.Vehicles[SelVehicle].Coupler := Coupler
    else
    begin
      Train.Vehicles[SelVehicle].Coupler := CouplerOld;
      SelectCoupler(CouplerOld);
      clCouplers.Hint := CouplerOld.ToString;
      ShowMessage(Util.LAB_WRONG_CONNECTION{'Niedopuszczalny rodzaj po³¹czenia miêdzy tymi pojazdami.'});
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
  pnlInfoTrain.Visible  := PageIndex < tsSettings.PageIndex;
  sbTrain.Visible       := PageIndex < tsSettings.PageIndex;
  Pages.ActivePageIndex := PageIndex;

  btnScenarios.Font.Style := [];
  btnDepot.Font.Style     := [];
  btnSettings.Font.Style  := [];

  case Pages.ActivePageIndex of
    0: btnScenarios.Font.Style  := [TFontStyle.fsBold];
    1: btnDepot.Font.Style      := [TFontStyle.fsBold];
    2: btnSettings.Font.Style   := [TFontStyle.fsBold];
  end;

  if Pages.ActivePage = tsStart then
  begin
    SelList := slSCN;
    pcTrains.ActivePageIndex := 0;
    pcTrainsChange(self);
  end
  else
  if Pages.ActivePage = tsSettings then
  begin
    chAngle.Visible := FileExists(Util.Dir + '\libEGL.dll') and FileExists(Util.Dir + '\libGLESv2.dll');
    if cbPreset.Items.Count = 0 then
      Settings.LoadPresets;
  end;
end;

procedure TMain.LoadKeysComponents;
var
  i : Integer;
begin
  KeysGrid.BeginUpdate;

  KeysGrid.RowCount := Settings.KeyParams.Count + 1;
  KeysGrid.Cells[0,0] := Util.LAB_KEY1{'Przycisk 1'};
  KeysGrid.Cells[1,0] := Util.LAB_KEY2{ 'Przycisk 2'};
  KeysGrid.Cells[2,0] := Util.LAB_KEY3{'Przycisk 3'};
  KeysGrid.Cells[3,0] := Util.LAB_KEY_DESC{'Opis funkcji'};

  for i := 0 to Settings.KeyParams.Count-1 do
  begin
    KeysGrid.Cells[0,i+1] := Settings.KeyParams[i].Key;
    KeysGrid.Cells[1,i+1] := Settings.KeyParams[i].Key2;
    KeysGrid.Cells[2,i+1] := Settings.KeyParams[i].Key3;
    KeysGrid.Cells[3,i+1] := Settings.KeyParams[i].Desc;
  end;

  if Settings.KeyParams.Count > 0 then
    KeysGridClick(self);

  KeysGrid.EndUpdate;
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
  lbTemperature.Caption := IntToStr(tbTemperature.Position) + '°C';
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  Application.OnActivate    := AppActivate;
  Application.OnDeactivate  := AppDeactivate;

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
  tvSCN.Items.Clear;

  while i < Data.Scenarios.Count do
  begin
    if (not chHideArchival.Checked) or (not Data.Scenarios[i].Old) then
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
    end
    else
      Inc(i);
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
      Util.LogAdd('B³¹d wczytywania magazynu. Szczegó³y b³êdu: ' + E.Message,True);
  end;
end;

procedure TMain.AppActivate(Sender: TObject);
begin
  actRemoveVehicle.ShortCut := VK_DELETE;
  actAddVehicle.ShortCut := VK_INSERT;

  btnStart.Enabled := True;

  SetFormatSettings;

  Settings.CheckSettingsFile;
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
var
  i : Integer;
begin
  if chLogExt.Checked then
    for i := 0 to Data.Textures.Count-1 do
    begin
      if TTexError.teNoFile in Data.Textures[i].Errors then
        Util.LogAdd('Brak pliku ' + Data.Textures[i].Dir + '\' + Data.Textures[i].Plik);
      if TTexError.teNoModel in Data.Textures[i].Errors then
        Util.LogAdd('Brak modelu dla tekstury ' + Data.Textures[i].Dir + '\' + Data.Textures[i].Plik);
      if TTexError.teNoPhysics in Data.Textures[i].Errors then
        Util.LogAdd('Brak fizyki dla tekstury ' + Data.Textures[i].Dir + '\' + Data.Textures[i].Plik);
      if TTexError.teNoMultimedia in Data.Textures[i].Errors then
        Util.LogAdd('Brak pliku mulitmediów dla tekstury ' + Data.Textures[i].Dir + '\' + Data.Textures[i].Plik);
    end;

  if ForceDirectories(Util.DIR + 'starter') then
    Util.Log.SaveToFile(Util.DIR + 'starter\bledy.txt');

  Util.Destroy;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  TDepotThread.Create;
  DefaultSettings;
  Settings.ReadSettings;
  ReloadSettingsState;
  AdaptMiniSize;
  Util.EmptyTextures;
  lbVersion.Caption := Util.FileVersion;
  lbVersion.Hint := Util.FileDateStr;
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
    Accept := ((Source as TImage).Tag <> (Sender as TImage).Tag)
              and (lbTextures.ItemIndex >= 0)
              and (CheckMoveVehicle((Source as TImage).Tag,(Sender as TImage).Tag))
  else
  if Source is TShape then
    Accept := ((Source as TShape).Tag <> (Sender as TImage).Tag)
              and (lbTextures.ItemIndex >= 0)
              and (CheckMoveVehicle((Source as TShape).Tag,(Sender as TImage).Tag));
end;

function TMain.CheckMoveVehicle(const FromPos,ToPos:Integer):Boolean;
begin
  Result := True;
  if FromPos < ToPos then
    begin
    if (ToPos > 0) and (ToPos < Train.Vehicles.Count-1)
    and (Train.Vehicles[ToPos].Texture.NextTexID = Train.Vehicles[ToPos+1].Texture.ID) then
      Result := False;
    end
    else
      if (ToPos > 0) and (Train.Vehicles[ToPos].Texture.PrevTexID = Train.Vehicles[ToPos-1].Texture.ID) then
        Result := False;
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
  Accept := (Source is TImage) and ((Source as TImage).Name = 'imMini') and (lbTextures.ItemIndex >= 0);
end;

procedure TMain.LoadScenery(const aSCN:TScenario);
var
  i : Integer;
  Attachment : TButton;
begin
  SelTrain := -1;

  SCN := aSCN;

  if (SCN.Vehicles.Count = 0) and (SCN.Trains.Count = 0) then
    TLexParser.ParseScenario(SCN);

  Util.LogAdd('-> £adowanie scenerii ' + aSCN.Name);

  while sbAttachments.ControlCount > 0 do
    sbAttachments.Controls[0].Free;

  for i := SCN.Files.Count-1 downto 0 do
  begin
    Attachment := TButton.Create(self);
    Attachment.Parent := sbAttachments;
    Attachment.Align := alTop;
    Attachment.Top := i;

    Attachment.Hint := Copy(SCN.Files[i] ,Pos(' ',SCN.Files[i],1)+1,Pos(' ',SCN.Files[i],4)-4);
    Attachment.Caption := Copy(SCN.Files[i] ,Pos(' ',SCN.Files[i],10)+1,SCN.Files[i].Length);
    Attachment.OnClick := OpenAttachment;
  end;

  sbAttachments.Height := sbAttachments.ControlCount * 25;

  if SCN.Image.Length > 0 then
    LoadMini(SCN.Image)
  else
    imScenario.Picture.Assign(nil);

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
    if (not chOnlyForDriving.Checked) or (StaffedTrain(Trains[i])) then
      if (chShowAI.Checked) or (not Trains[I].AI) then
        lbTrains.AddItem(PrepareTrainsetDesc(Trains[i]),TObject(i));

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

  FaultList(SCN);
end;

procedure TMain.FaultList(const Scenery:TScenario);
var
  i, y : Integer;
begin
  meInfo.Lines.BeginUpdate;
  meInfo.Clear;

  for i := Util.Log.Count-1 downto 0 do
    if SameText('-> Parsowanie scenerii ' + SCN.Name,Util.Log[i]) then
    begin
      for y := i + 1 to Util.Log.Count-1 do
        if Pos('#',Util.Log[y]) = 1 then
          meInfo.Lines.Add(StringReplace(Util.Log[y],'#','',[]))
        else
          Break;

      Break;
    end;

  for i := 0 to Scenery.Trains.Count-1 do
    for y := 0 to Scenery.Trains[i].Vehicles.Count-1 do
      if teNoFile in Scenery.Trains[i].Vehicles[y].Texture.Errors then
          meInfo.Lines.Add(Scenery.Trains[i].Vehicles[y].ReplacableSkin + ' - brak pliku tekstury.')
      else
      if teNoModel in Scenery.Trains[i].Vehicles[y].Texture.Errors then
        meInfo.Lines.Add(Scenery.Trains[i].Vehicles[y].ReplacableSkin + ' - brak pliku modelu.')
      else
      if teNoPhysics in Scenery.Trains[i].Vehicles[y].Texture.Errors then
        meInfo.Lines.Add(Scenery.Trains[i].Vehicles[y].ReplacableSkin + ' - brak pliku fizyki.')
      else
      if teNoMultimedia in Scenery.Trains[i].Vehicles[y].Texture.Errors then
        meInfo.Lines.Add(Scenery.Trains[i].Vehicles[y].ReplacableSkin + ' - brak pliku multimediów.');

  meInfo.Lines.EndUpdate;

  tsInfo.TabVisible := meInfo.Lines.Count > 0;
end;

procedure TMain.tvSCNCompare(Sender: TObject; Node1, Node2: TTreeNode;
  Data: Integer; var Compare: Integer);
begin
  if Node1.Data = Node2.Data Then
    Compare := AnsiCompareText(Node1.Text, Node2.Text)
  else
    if Assigned(Node1.Data) Then
      Compare := -1
    else
      Compare := 1;
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
    Image.Hint      := Util.LAB_CAR_NO + Train.Vehicles[Image.Tag].Number.ToString;
    Image.ShowHint  := True;
  end
  else
    Image.ShowHint := False;
end;

procedure TMain.MoveVehicle(FromPos,ToPos:integer);
var
  Units, i : Integer;
begin
  try
    while (FromPos-1 >= 0)
      and (Train.Vehicles[FromPos-1].Texture.NextTexID >= Train.Vehicles[FromPos].Texture.ID) do
      Dec(FromPos);

    Units := 0;
    if (Train.Vehicles[FromPos].Texture.NextTexID > 0) then
    begin
      while (Train.Vehicles.Count > FromPos+Units+1)
        and (Train.Vehicles[FromPos+Units+1].Texture.PrevTexID = Train.Vehicles[FromPos+Units].Texture.ID) do
        Inc(Units);

      if ToPos > FromPos then
      begin
        for i := 0 to Units do
          Train.Vehicles.Move(FromPos,ToPos);
      end
      else
        for i := 0 to Units do
          Train.Vehicles.Move(FromPos+i,ToPos+i);
    end
    else
      Train.Vehicles.Move(FromPos,ToPos);
  finally
    RefreshTrain(ToPos);
  end;
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
  if KeysGrid.RowCount > 1 then
  begin
    cbKey1.ItemIndex := cbKey1.Items.IndexOf(Trim(Settings.KeyParams[KeysGrid.Row-1].Key));
    cbKey2.ItemIndex := cbKey2.Items.IndexOf(Settings.KeyParams[KeysGrid.Row-1].Key2);
    cbKey3.ItemIndex := cbKey3.Items.IndexOf(Settings.KeyParams[KeysGrid.Row-1].Key3);
    ViewKeyOnKeyboard;
  end;
end;

procedure TMain.ViewKeyOnKeyboard;
var
  Form : TForm;
begin
  Form := Application.FindComponent('frmKeyboard') as TForm;

  if Form <> nil then
    (Form as TfrmKeyboard).ViewKeys(cbKey1.Text,cbKey2.Text,cbKey3.Text);
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
  if (lbDepot.ItemIndex < 0) or ((SelList = slDEPO)
    and (SelTrain = Integer(lbDepot.Items.Objects[lbDepot.ItemIndex]))) then Exit;

  SelList := slDEPO;
  SelTrain := lbDepot.ItemIndex;
  SelectTrain;
end;

procedure TMain.lbModelCaptionDblClick(Sender: TObject);
begin
  if SelVehicle >= 0 then
    Clipboard.AsText := Train.Vehicles[SelVehicle].TypeChk;
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
    begin
      if Train.Vehicles.Last.CabOccupancy in [coHeadDriver,coRearDriver] then
        SelVehicle := Train.Vehicles.Count-1
      else
        SelVehicle := 0;
    end
    else
      SelVehicle := -1;

    meMission.Lines.BeginUpdate;
    meMission.Clear;
    if Train.AI then
      meMission.Lines.Add(Util.LAB_AI_TRAIN);
    meMission.Lines.Add(Train.Desc);
    meMission.Lines.EndUpdate;

    if IsParameter('utf8') then
      meTimetable.Lines.DefaultEncoding := TEncoding.UTF8;

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

    if Train.Mini.Length > 0 then
      LoadMini(Train.Mini)
    else
      if SCN <> nil then
        LoadMini(SCN.Image);

    lbTrack.Caption := Train.Track;
    if Train.Vel > 0 then
      lbTrack.Caption := lbTrack.Caption + ' (' + FloatToStr(Train.Vel) + 'km/h)';
  end
  else
    ClearTrainScroll;
end;

procedure TMain.LoadMini(const Name:string);
var
  Mini : TJPEGImage;
begin
  try
    if FileExists(Util.DIR + 'scenery\images\' + Name) then
    begin
      Mini := TJPEGImage.Create;
      Mini.LoadFromFile(Util.DIR + 'scenery\images\' + Name);
      imScenario.Picture.Bitmap.Assign(Mini);
      Mini.Free;
    end
    else
      imScenario.Picture.Assign(nil);
  except
    Util.LogAdd('Nie uda³o siê wczytaæ miniaturki scenariusza ' + Name);
  end;
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
  Mark.Cursor       := crHandPoint;
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

  MiniPath(Train.Vehicles[SelVehicle].Texture,Train.Vehicles[SelVehicle].ModelID,SelectTex);

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

  chReversed.OnClick := nil;
  chReversed.Checked := Vehicle.Dist = -1;
  chReversed.OnClick := chReversedClick;

  chRefAmbientTemp.Checked := Vehicle.ThermoDynamic;
  cbLoadType.ItemIndex := cbLoadType.Items.IndexOf(Vehicle.LoadType);

  if (Vehicle.Fiz <> nil) and (Vehicle.Fiz.MaxLoad > 0) then
    seLoadCount.MaxValue := Vehicle.Fiz.MaxLoad
  else
    seLoadCount.MaxValue := 0;

  if Vehicle.MaxLoad >= 0 then
    seLoadCount.MaxValue := Vehicle.MaxLoad;

  seLoadCount.Value := Vehicle.Loadquantity;
end;

procedure TMain.SelectCoupler(Coupler:Integer);
var
  CValue, CheckIndex : Integer;
begin
  clCouplers.Items.BeginUpdate;
  clCouplers.CheckAll(cbUnchecked);

  CheckIndex := 7;
  CValue := 128;
  while CheckIndex >= 0 do
  begin
    if Coupler >= CValue then
    begin
      clCouplers.Checked[CheckIndex] := True;
      Dec(Coupler,CValue);
    end;

    Dec(CheckIndex);
    CValue := Cvalue div 2;
  end;

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
  if Vehicle.Texture.Typ <> tyUNKNOWN then
  begin
    SelectModel(Vehicle.Texture,Vehicle.ModelID);

    cbLoadType.Items.Clear;
    if Vehicle.Fiz <> nil then
      ExtractStrings([','],[],PChar(Vehicle.Fiz.LoadAccepted),cbLoadType.Items);

    if not SameText(Vehicle.TypeChk,Vehicle.Model.Model) then
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
      lbTextures.Items.Clear;
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
      Image := TImage.Create(sbTrain);
      Image.Cursor        := crHandPoint;
      Image.Parent        := sbTrain;
      Image.Align         := alLeft;
      Image.Stretch       := True;
      Image.Constraints.MaxHeight := 30 * MiniFactor;
      Image.OnMouseDown   := ImageMouseDown;
      Image.OnDragOver    := BitmapDragOver;
      Image.OnDragDrop    := BitmapDragDrop;
      Image.OnMouseEnter  := BitmapMouseEnter;
      Image.Tag           := i;
      Image.Name          := 'Image' + IntToStr(i);

      Image.Picture.Bitmap.LoadFromFile(MiniPath(Train.Vehicles[i].Texture,Train.Vehicles[i].ModelID,False));

      if (Train.Vehicles[i].Dist = -1) then
        FlipBitmap(Image.Picture.Bitmap,Train.Vehicles[i].Texture.Typ <> tyUNKNOWN);

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

procedure TMain.FlipBitmap(Bitmap:TBitmap;const Flip:Boolean);
var
  Width, Height : Integer;
  SrcRect, DstRect: TRect;
begin
  if Flip then
  begin
    Width   := Bitmap.Width;
    Height  := Bitmap.Height;
    SrcRect := Rect(0, 0, Width, Height);
    DstRect := Rect(Width, 0, 0, Height);
  end;

  with Bitmap do
  begin
    Canvas.CopyRect(DstRect,Canvas,SrcRect);
    Canvas.Font.Name := 'Webdings';
    Canvas.Font.Size := 16;
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Color := clWhite;
    Canvas.TextOut(5,5,'q');
  end;
end;

procedure TMain.DrawVehicle(const Vehicle:TVehicle);
var
  Image : TImage;
begin
  Image := SelImage;
  if Image <> nil then
  begin
    Image.Picture.Bitmap.LoadFromFile(MiniPath(Vehicle.Texture,Vehicle.ModelID));

    Image.Width := Image.Picture.Bitmap.Width * MiniFactor;

    if Vehicle.Dist = -1 then
        FlipBitmap(Image.Picture.Bitmap,Vehicle.Texture<>nil);

    if Vehicle.Number > 0 then
    begin
      Image.Hint      := Util.LAB_CAR_NO + Vehicle.Number.ToString;
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
    if (Train.Vehicles[SelVehicle].Texture.Typ >= tySZYNOBUS)
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

function TMain.MiniPath(const Tex:TTexture;const ModelID:Integer;const Mini:Boolean=True):string;
begin
  try
    Result := '';

    if FileExists(Util.DIR + 'textures\mini\' + Tex.Models[ModelID].MiniD + '.bmp') then
      Result := Util.DIR + 'textures\mini\' + Tex.Models[ModelID].MiniD + '.bmp'
    else
      if FileExists(Util.DIR + 'textures\mini\' + Tex.Models[ModelID].Mini + '.bmp') then
        Result := Util.DIR + 'textures\mini\' + Tex.Models[ModelID].Mini + '.bmp';

    if Result.IsEmpty then
      if FileExists(Util.DIR + 'textures\mini\other.bmp') then
        Result := Util.DIR + 'textures\mini\other.bmp';

    if Mini then
      imMini.Picture.Bitmap.LoadFromFile(Result);
  except
    Util.LogAdd('Nie uda³o siê wczytaæ miniaturki pojazdu ' + Tex.Plik);
  end;
end;

procedure TMain.pcSettingsChange(Sender: TObject);
begin
  if pcSettings.ActivePage = tsControl then
  begin
    Settings.ReadKeyboard;
    LoadKeysComponents;
  end;
end;

procedure TMain.pcSettingsResize(Sender: TObject);
var
  Width : Integer;
begin
  Width := (tsMain.Width div 2) - 270;
  pnlLeftMargin1.Width := Width;
  pnlLeftMargin2.Width := Width;
  pnlGraphic.Margins.Left := Clamp(tsGraphics.Width div 2 - 435,0,800);
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

procedure TMain.pmDepotPopup(Sender: TObject);
begin
  miSortBy.Visible := Data.Depot.Count > 0;
end;

procedure TMain.pmHelpPopup(Sender: TObject);
begin
  miInstructions.Visible := DirectoryExists(Util.Dir + '\przepisy_kolejowe');
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
  miRemoveVehicle.Visible     := pmTrainsets.PopupComponent = nil;
  miTrainRandomOrder.Visible  := pmTrainsets.PopupComponent = nil;

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
  AutoConnect(Train.Vehicles,Train.Vehicles.Count-Data.Depot[Index].Vehicles.Count-1);
  SelectCoupler(Train.Vehicles[SelVehicle].Coupler);
end;

procedure TMain.miIe1Click(Sender: TObject);
begin
  Util.OpenFile('\przepisy_kolejowe\ie-1.pdf');
end;

procedure TMain.ReplaceTrain(const Vehicles:TObjectList<TVehicle>);
begin
  Train.Vehicles.Clear;
  AddTrain(Vehicles);
end;

procedure TMain.ReplaceVehicle(const Tex:TTexture;const Index:Integer);
var
  BackIndex : Integer;
begin
  BackIndex := 0; // liczymy ile pojazdow do tylu usuwamy

  if Train.Vehicles[Index].Dist <> -1 then
    while (Train.Vehicles[Index-BackIndex].Texture.PrevTexID > 0) do
      Inc(BackIndex);

  RemoveVehicles(Index);

  AddVehicle(Index-BackIndex,Tex);
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

procedure TMain.lbTexStationMouseEnter(Sender: TObject);
begin
  lbTexStation.Hint := lbTexStation.Caption;
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
        MiniPath(Tex,i);
        LoadTexData(Tex,i);
        Break;
      end;
  end;

  lbTextures.Tag := lbTextures.ItemIndex;
end;

function TMain.FirstCarIndex(const Index:Integer):Integer;
var
  i : Integer;
begin
  i := 0;
  while (Index - i > 0)
    and (Train.Vehicles[Index-i-1].Texture.NextTexID = Train.Vehicles[Index-i].Texture.ID) do
    Inc(i);

  Result := Index - i;
end;

procedure TMain.lbTexturesDblClick(Sender: TObject);
var
  Tex : TTexture;
  FirstIndex : Integer;
begin
  if (lbTextures.ItemIndex <> -1) and (Train <> nil) and (Train.Vehicles.Count > 0) then
  begin
    Tex := (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);
    LoadModelData(Tex.Models[Train.Vehicles[SelVehicle].ModelID].Fiz);

    if (SelVehicle >= 0) then
    begin
      // jesli nowy pojazd ma inna ilosc czlonow to usuwamy stary i dodajemy nowy
      if (Train.Vehicles[SelVehicle].Texture.Crew <> Tex.Crew) then
        ReplaceVehicle(Tex,SelVehicle)
      else
      begin
        FirstIndex := FirstCarIndex(SelVehicle);
        Tex := Data.Textures[Tex.FirstIndex];

        AssignTexToVehicle(Train.Vehicles[FirstIndex],Tex);
        LoadTexData(Tex,Train.Vehicles[FirstIndex].ModelID);

        // jesli zmienila sie tylko tekstura zaznaczonego pojazdu wystarczy przerysowac tylko ten pojazd
        if (AssignNextVehicles(Tex,FirstIndex) = 0) then
          DrawVehicle(Train.Vehicles[FirstIndex])
        else
          DrawTrain(Train);

        TrainDesc;
        LoadTrainParams;
      end;
    end
    else
      LoadTexData(Tex);
  end;
end;

function TMain.AssignNextVehicles(Tex:TTexture;const FirstIndex:Integer):Integer;
begin
  Result := 1;
  while (FirstIndex + Result < Train.Vehicles.Count)
  and (Train.Vehicles[FirstIndex+Result].Texture.PrevTexID >= 0)
  and (Tex.NextTexID > 0) do
  begin
    AssignTexToVehicle(Train.Vehicles[FirstIndex+Result],Data.Textures[Tex.NextTexID]);
    Tex := Data.Textures[Tex.NextTexID];
    Inc(Result);
  end;
  Dec(Result);
end;

procedure TMain.TrainDesc;
begin
  if SelList = slSCN then
    SetItemDesc(Train)
  else
    lbDepot.Items[lbDepot.ItemIndex] := PrepareTrainsetDesc(Train);
end;

procedure TMain.miOpenHelpClick(Sender: TObject);
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

procedure TMain.miOpenVehicleDirClick(Sender: TObject);
var
  Tex : TTexture;
begin
  Tex := (lbTextures.Items.Objects[lbTextures.ItemIndex] as TTexture);
  if Tex <> nil then
    OpenDir(Util.DIR + 'dynamic\' + Tex.Dir);
end;

procedure TMain.actRandomLoadExecute(Sender: TObject);
var
  i : Integer;
  Loads : TStringList;
begin
  for i := 0 to Train.Vehicles.Count-1 do
  begin
    if (Train.Vehicles[i].Texture.Typ >= tySZYNOBUS) then
    begin
      if Train.Vehicles[i].Fiz <> nil then
      begin
        Loads := TStringList.Create;
        Loads.Delimiter := ',';
        Loads.DelimitedText := Train.Vehicles[i].Fiz.LoadAccepted;

        if Loads.Count > 0 then
          Train.Vehicles[i].LoadType := Loads[Random(Loads.Count-1)];
      end;
    end;
  end;

  seLoadCount.Value := Train.Vehicles[SelVehicle].Loadquantity;
  LoadTrainParams;
end;

procedure TMain.actRandomLoadUpdate(Sender: TObject);
begin
  actRandomLoad.Enabled := (SelVehicle >= 0);
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
