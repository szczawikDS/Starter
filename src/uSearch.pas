unit uSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uStructures, Vcl.ExtCtrls,
  Vcl.CheckLst, Vcl.ComCtrls;

type
  TfrmSearch = class(TForm)
    lbSearch: TLabel;
    edText: TEdit;
    lbExample: TLabel;
    lbList: TListBox;
    rgFilters: TRadioGroup;
    cbSearchType: TComboBox;
    Label1: TLabel;
    pnlDate: TPanel;
    dtRevEnd: TDateTimePicker;
    Label3: TLabel;
    dtRevStart: TDateTimePicker;
    Label2: TLabel;
    procedure edTextChange(Sender: TObject);
    procedure rgFiltersClick(Sender: TObject);
    procedure lbListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbListDblClick(Sender: TObject);
    procedure cbSearchTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    VehicleType : set of TTyp;
    procedure AddItem(const Tex: TTexture);
    function AdaptRevDate(RevStr: string): TDate;
  public
    { Public declarations }
  end;

var
  frmSearch: TfrmSearch;

implementation

uses uMain, StrUtils, uLanguages;

{$R *.dfm}

procedure TfrmSearch.cbSearchTypeChange(Sender: TObject);
begin
  if cbSearchType.ItemIndex = 5 then
  begin
    pnlDate.Visible   := True;
    lbSearch.Visible  := False;
    edText.Visible    := False;
    lbExample.Visible := False;
  end
  else
  begin
    pnlDate.Visible   := False;
    lbSearch.Visible  := True;
    edText.Visible    := True;
    lbExample.Visible := True;
  end;

  edTextChange(self);
end;

function TfrmSearch.AdaptRevDate(RevStr:string):TDate;
var
  fs: TFormatSettings;
begin
  try
    Result := 0;
    if RevStr.Length = 10 then
    begin
      fs := TFormatSettings.Create;
      fs.DateSeparator := '.';
      fs.ShortDateFormat := 'dd.MM.yyyy';
      RevStr := StringReplace(RevStr,'xx','01',[rfReplaceAll]);
      Result := StrToDateTime(RevStr, fs);
    end;
  except
    Result := 0;
  end;
end;

procedure TfrmSearch.edTextChange(Sender: TObject);
var
  i, y : Integer;
  Rev : TDate;
begin
  lbList.Items.BeginUpdate;
  lbList.Clear;
  if (Length(edText.Text) > 1) or (cbSearchType.ItemIndex = 5) then
  begin
    for i := 0 to Main.Textures.Count-1 do
      for y := 0 to Main.Textures[i].Models.Count-1 do
        if (rgFilters.ItemIndex = 0) or (Main.Textures[i].Typ in VehicleType) then
          case cbSearchType.ItemIndex of
            0: if ContainsText(Main.Textures[i].Plik,edText.Text) then
              AddItem(Main.Textures[i]);

            1: if ContainsText(Main.Textures[i].Models[y].MiniD,edText.Text) then
              AddItem(Main.Textures[i]);

            2: if SameText(Main.Textures[i].Owner,edText.Text) then
              AddItem(Main.Textures[i]);

            3: if ContainsText(Main.Textures[i].Author,edText.Text) then
              AddItem(Main.Textures[i]);

            4: if ContainsText(Main.Textures[i].Photos,edText.Text) then
              AddItem(Main.Textures[i]);

            5:begin
                Rev := AdaptRevDate(Main.Textures[i].Revision);
                if (Rev >= dtRevStart.Date) and (Rev <= dtRevEnd.Date) then
                  AddItem(Main.Textures[i]);
              end;

            6: if SameText(Main.Textures[i].Models[y].Model,edText.Text) then
              AddItem(Main.Textures[i]);
          end;
  end;

  lbList.Items.EndUpdate;
end;

procedure TfrmSearch.AddItem(const Tex:TTexture);
begin
  if Tex.Models[0].MiniD.Length > 0 then
    lbList.AddItem(Tex.Plik + ' [' + Tex.Models[0].MiniD + ']',Tex)
  else
    lbList.AddItem(Tex.Plik,Tex);
end;

procedure TfrmSearch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(self);
end;

procedure TfrmSearch.FormCreate(Sender: TObject);
begin
  if Main.Lang <> 'pl' then
    TLanguages.ChangeLanguage(Self,Main.Lang);
  cbSearchType.ItemIndex := 0;
end;

procedure TfrmSearch.lbListClick(Sender: TObject);
var
  Tex : TTexture;
begin
  if lbList.ItemIndex >= 0 then
  begin
    Tex := TTexture(lbList.Items.Objects[lbList.ItemIndex]);
    Main.SelectModel(Tex);
    Main.lbTextures.ItemIndex := Main.lbTextures.Items.IndexOf(Tex.Plik);
    Main.lbTexturesClick(self);
  end;
end;

procedure TfrmSearch.lbListDblClick(Sender: TObject);
begin
  Main.lbTexturesDblClick(self);
end;

procedure TfrmSearch.rgFiltersClick(Sender: TObject);
begin
  case rgFilters.ItemIndex of
    0: VehicleType := [];
    1: VehicleType := [tyELEKTROWOZ];
    2: VehicleType := [tySPALINOWOZ];
    3: VehicleType := [tyEZT];
    4: VehicleType := [tyA,tyB,tyD,tyE,tyF,tyG,tyH,tyL,tyP,tyR,tyS,tyU,tyV,tyW,tyX,tyZ];
  end;
  edTextChange(self);
end;

end.
