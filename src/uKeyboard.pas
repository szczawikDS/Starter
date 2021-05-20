unit uKeyboard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections, System.Generics.Defaults,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.StdCtrls, System.Actions, Vcl.ActnList;

type
  TKey = class
    Key       : Integer;
    ASCII     : string;
    Position  : TPoint;
    Width     : Integer;
    Height    : Integer;
  end;

  TfrmKeyboard = class(TForm)
    imKeyboard: TImage;
    AL: TActionList;
    gbKeys: TGroupBox;
    btnKeyPlain: TButton;
    btnKeyCTRL: TButton;
    btnKeySHIFT: TButton;
    btnKeyCTRLSHIFT: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnKeyCTRLMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnKeySHIFTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnKeyCTRLSHIFTMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imKeyboardMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnKeyPlainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnKeyUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure AddKey(const aKey:Integer;ASCII:string;PositionX,PositionY:Integer;const Width:Integer;const Height:Integer);
    procedure AddKeyboard;
    procedure DrawKey(const ASCII: string);
    function FindKey(const ASCII: string): TKey;
    procedure Mark(const Key: TKey;const Color:TColor=clLime);
    procedure ViewAllSpecialKeyUse(const KeyName: string);
  public
    Keys : TList<TKey>;
    procedure ViewKeys(const Key1, Key2, Key3: string);
  end;

var
  frmKeyboard: TfrmKeyboard;

implementation

uses uMain, uSettings, uUtilities, uLanguages;

{$R *.dfm}

procedure TfrmKeyboard.AddKey(const aKey:Integer;ASCII:string;PositionX,PositionY:Integer;const Width:Integer;const Height:Integer);
var
  Key : TKey;
begin
  Key             := TKey.Create;
  Key.Key         := aKey;
  Key.ASCII       := ASCII;
  Key.Position.X  := PositionX;
  Key.Position.Y  := PositionY;
  Key.Width       := Width;
  Key.Height      := Height;
  Keys.Add(Key);
end;

procedure TfrmKeyboard.AddKeyboard;
begin
  AddKey(65,'A', 87,144,39,39); // A
  AddKey(66,'B',272,185,39,39); // B
  AddKey(67,'C',190,185,39,39); // C
  AddKey(68,'D',169,144,39,39); // D
  AddKey(69,'E',157,103,39,39); // E
  AddKey(70,'F',210,144,39,39); // F
  AddKey(71,'G',251,144,39,39); // G
  AddKey(72,'H',292,144,39,39); // H
  AddKey(73,'I',362,103,39,39); // I
  AddKey(74,'J',332,144,39,39); // J
  AddKey(75,'K',373,144,39,39); // K
  AddKey(76,'L',414,144,39,39); // L
  AddKey(77,'M',353,185,39,39); // M
  AddKey(78,'N',313,185,39,39); // N
  AddKey(79,'O',403,103,39,39); // O
  AddKey(80,'P',444,103,39,39); // P
  AddKey(81,'Q', 76,103,39,39); // Q
  AddKey(82,'R',198,103,39,39); // R
  AddKey(83,'S',128,144,39,39); // S
  AddKey(84,'T',239,103,39,39); // T
  AddKey(85,'U',321,103,39,39); // U
  AddKey(86,'V',231,185,39,39); // V
  AddKey(87,'W',117,103,39,39); // W
  AddKey(88,'X',149,185,39,39); // X
  AddKey(89,'Y',280,103,39,39); // Y
  AddKey(90,'Z',108,185,39,39); // Z

  AddKey(48,'0',423,61,39,40); // 0
  AddKey(49,'1', 55,61,39,40); // 1
  AddKey(50,'2', 96,61,39,40); // 2
  AddKey(51,'3',137,61,39,40); // 3
  AddKey(52,'4',178,61,39,40); // 4
  AddKey(53,'5',219,61,39,40); // 5
  AddKey(54,'6',259,61,39,40); // 6
  AddKey(55,'7',300,61,39,40); // 7
  AddKey(56,'8',342,61,39,40); // 8
  AddKey(57,'9',383,61,39,40); // 9

  AddKey( 96,'num_0',787,226,81,39); // num 0
  AddKey( 97,'num_1',787,185,40,39); // num 1
  AddKey( 98,'num_2',829,185,39,39); // num 2
  AddKey( 99,'num_3',870,185,39,39); // num 3
  AddKey(100,'num_4',787,143,40,39); // num 4
  AddKey(101,'num_5',829,143,39,39); // num 5
  AddKey(102,'num_6',870,143,39,39); // num 6
  AddKey(103,'num_7',787,103,40,39); // num 7
  AddKey(104,'num_8',829,103,39,39); // num 8
  AddKey(105,'num_9',870,103,39,39); // num 9

  AddKey(106,'num_*',870, 62,39,39); // num *
  AddKey(107,'num_+',911,103,39,80); // num +
  AddKey(109,'num_-',911, 62,39,39); // num -
  AddKey(110,'num_.',870,226,39,39); // num . decimal
  AddKey(111,'num_/',829, 62,39,39); // num /
  AddKey(  0,'num_enter',911, 185,39,80); // num return

  AddKey(112, 'f1', 95,13,40,40); // f1
  AddKey(113, 'f2',137,13,39,40); // f2
  AddKey(114, 'f3',178,13,39,40); // f3
  AddKey(115, 'f4',219,13,39,40); // f4
  AddKey(116, 'f5',280,13,39,40); // f5
  AddKey(117, 'f6',321,13,39,40); // f6
  AddKey(118, 'f7',362,13,39,40); // f7
  AddKey(119, 'f8',403,13,39,40); // f8
  AddKey(120, 'f9',463,13,39,40); // f9
  AddKey(121,'f10',504,13,39,40); // f10
  AddKey(122,'f11',545,13,39,40); // f11
  AddKey(123,'f12',586,13,39,40); // f12
  AddKey(124,'f13',628,13,14,40); // f13
  AddKey(125,'f14',628,13,14,40); // f14
  AddKey(126,'f15',628,13,14,40); // f15
  AddKey(127,'f16',628,13,14,40); // f16

  AddKey(144,'numlock',787,62,40,39);  // numlock
  AddKey(145,'scrolllock',686,13,39,40); // scrolllock
  AddKey(160,'shift',13,185,93,39);     // lshift
  AddKey(161,'shift',517,185,109,39);     // rshift
  AddKey(162,'ctrl',13,226,61,39);   // lcontrol
  AddKey(163,'ctrl',565,226,61,39);   // rcontrol
  AddKey(164,'alt',115,226,61,39);       // lalt
  AddKey(165,'alt',464,226,61,39);       // ralt
  AddKey(186,';',455,144,39,39);  // semicolon
  AddKey(187,'=',504,61,39,40);     // equals
  AddKey(188,',',394,185,39,39);      // comma
  AddKey(189,'-',463,61,40,40); // underscore
  AddKey(190,'.',435,185,39,39);     // period
  AddKey(191,'/',476,185,39,39);      // slash
  AddKey(220,'\',566,103,60,39);  // backslash
  AddKey(221,'[',525,103,39,39); // rightbrace
  AddKey(219,']',485,103,39,39);  // leftbrace
  AddKey(222,'''',496,144,39,39); // apostrophe

  AddKey( 8,'backspace',545,61,81,40); // backspace
  AddKey( 9,'tab',13,103,61,39); // tab
  AddKey(13,'enter',537,144,89,39); // return
  //AddKey(16,'shift',0,0,39,39); // shift
  //AddKey(17,'control',0,0,39,39); // control
  //AddKey(18,'alt',0,225,39,39); // alt
  AddKey(19,'pause',727,13,39,40); // pause
  AddKey(20,'capslock',13,144,72,39); // capslock
  AddKey(27,'escape',13,13,40,40); // escape
  AddKey(32,'space',178,226,284,39); // space
  AddKey(33,'pageup',727,61,39,40); // pageup
  AddKey(34,'pagedown',727,103,39,39); // pagedown
  AddKey(35,'end',686,103,39,39); // end
  AddKey(36,'home',686,61,39,40); // home
  AddKey(37,'left',645,226,39,39); // left
  AddKey(38,'up',686,185,39,39); // up
  AddKey(39,'right',727,226,39,39); // right
  AddKey(40,'down',686,226,39,39); // down
  AddKey(44,'printscreen',645,13,39,40); // printscreen
  AddKey(45,'insert',645,61,39,40); // insert
  AddKey(46,'delete',645,103,39,39); // delete }
end;

procedure TfrmKeyboard.btnKeyCTRLMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imKeyboard.Picture.Bitmap.LoadFromResourceName(HInstance,'keyboard');
  ViewAllSpecialKeyUse('ctrl');
end;

procedure TfrmKeyboard.btnKeyCTRLSHIFTMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imKeyboard.Picture.Bitmap.LoadFromResourceName(HInstance,'keyboard');
  ViewAllSpecialKeyUse('ctrl+shift');
end;

procedure TfrmKeyboard.btnKeyPlainMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imKeyboard.Picture.Bitmap.LoadFromResourceName(HInstance,'keyboard');
  ViewAllSpecialKeyUse(EmptyStr);
end;

procedure TfrmKeyboard.btnKeyUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  imKeyboard.Picture.Bitmap.LoadFromResourceName(HInstance,'keyboard');
  Main.KeysGridClick(self);
end;

procedure TfrmKeyboard.btnKeySHIFTMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  imKeyboard.Picture.Bitmap.LoadFromResourceName(HInstance,'keyboard');
  ViewAllSpecialKeyUse('shift');
end;

procedure TfrmKeyboard.ViewAllSpecialKeyUse(const KeyName:string);
var
  i, y : Integer;
begin
  if KeyName = 'ctrl+shift' then
  begin
    for i := 0 to Main.Settings.KeyParams.Count-1 do
      if ((SameText('ctrl',Main.Settings.KeyParams[i].Key2)) and (SameText('shift',Main.Settings.KeyParams[i].Key3)))
      or ((SameText('shift',Main.Settings.KeyParams[i].Key2)) and (SameText('ctrl',Main.Settings.KeyParams[i].Key3))) then
        for y := 0 to Keys.Count-1 do
          if SameText(Main.Settings.KeyParams[i].Key,Keys[y].ASCII) then
            DrawKey(Keys[y].ASCII);
  end
  else
  if KeyName.Length > 0 then
  begin
    for i := 0 to Main.Settings.KeyParams.Count-1 do
      if SameText(KeyName,Main.Settings.KeyParams[i].Key2) or SameText(KeyName,Main.Settings.KeyParams[i].Key3) then
        for y := 0 to Keys.Count-1 do
          if SameText(Main.Settings.KeyParams[i].Key,Keys[y].ASCII) then
            DrawKey(Keys[y].ASCII);
  end
  else
    for i := 0 to Main.Settings.KeyParams.Count-1 do
      if (Main.Settings.KeyParams[i].Key2.IsEmpty) and (Main.Settings.KeyParams[i].Key3.IsEmpty) then
        for y := 0 to Keys.Count-1 do
          if SameText(Trim(Main.Settings.KeyParams[i].Key),Keys[y].ASCII) then
            DrawKey(Keys[y].ASCII);
end;

procedure TfrmKeyboard.ViewKeys(const Key1,Key2,Key3:string);
var
  Key : TKey;
begin
  imKeyboard.Picture.Bitmap.LoadFromResourceName(HInstance,'keyboard');

  Key := FindKey(Key1);
  if Key <> nil then
    DrawKey(Key.ASCII);

  Key := FindKey(Key2);
  if Key <> nil then
    DrawKey(Key.ASCII);

  Key := FindKey(Key3);
  if Key <> nil then
    DrawKey(Key.ASCII);
end;

function TfrmKeyboard.FindKey(const ASCII:string):TKey;
var
  i : Integer;
begin
  Result := nil;

  for i := 0 to Keys.Count-1 do
    if SameText(ASCII,Keys[i].ASCII) then
    begin
      Result := Keys[i];
      Break;
    end;
end;

procedure TfrmKeyboard.DrawKey(const ASCII:string);
var
  Key : TKey;
begin
  Key := FindKey(ASCII);

  if Key <> nil then
    Mark(Key);
end;

procedure TfrmKeyboard.Mark(const Key:TKey;const Color:TColor=clLime);
var
  Bitmap : TBitmap;
begin
  Bitmap := imKeyboard.Picture.Bitmap;

  Bitmap.Canvas.Brush.Style := bsClear;
  Bitmap.Canvas.Pen.Color   := Color;
  Bitmap.Canvas.Pen.Width   := 2;
  Bitmap.Canvas.Rectangle(Key.Position.X,Key.Position.Y,Key.Position.X+Key.Width,Key.Position.Y+Key.Height);
  imKeyboard.Picture.Bitmap := Bitmap;
end;

procedure TfrmKeyboard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(self);
end;

procedure TfrmKeyboard.FormCreate(Sender: TObject);
begin
  if Util.Lang <> 'pl' then
    TLanguages.ChangeLanguage(Self,Util.Lang);

  Keys := TList<TKey>.Create;
  AddKeyboard;
end;

procedure TfrmKeyboard.FormDestroy(Sender: TObject);
begin
  Keys.Free;
end;

procedure TfrmKeyboard.imKeyboardMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, Index : Integer;
begin
  if Main.Pages.ActivePageIndex = 3 then
  begin
    for i := 0 to Keys.Count-1 do
      if (X > Keys[i].Position.X) and (X < Keys[i].Position.X + Keys[i].Width)
      and (Y > Keys[i].Position.Y) and (Y < Keys[i].Position.Y + Keys[i].Height) then
      begin
        if SameText(Keys[i].ASCII,'ctrl') then
        begin
          if Main.cbKey2.Text <> 'ctrl' then
            Main.cbKey2.ItemIndex := Main.cbKey2.Items.IndexOf(Keys[i].ASCII)
          else
            Main.cbKey2.ItemIndex := -1;

          Main.cbKey2Change(self);
        end
        else
        if SameText(Keys[i].ASCII,'shift') then
        begin
          if Main.cbKey3.Text <> 'shift' then
            Main.cbKey3.ItemIndex := Main.cbKey3.Items.IndexOf(Keys[i].ASCII)
          else
            Main.cbKey3.ItemIndex := -1;

          Main.cbKey3Change(self);
        end
        else
        begin
          Index := Main.cbKey1.Items.IndexOf(Keys[i].ASCII);
          if Index >= 0 then
          begin
            Main.cbKey1.ItemIndex := Main.cbKey1.Items.IndexOf(Keys[i].ASCII);
            Main.cbKey1Change(self);
          end
          else
          begin
            Mark(Keys[i],clRed);
            Application.ProcessMessages;
            Sleep(100);
            Main.KeysGridClick(self);
          end;
        end;
      end;
  end;
end;

end.
