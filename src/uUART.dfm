object frmUART: TfrmUART
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'UART'
  ClientHeight = 248
  ClientWidth = 466
  Color = clBtnFace
  Constraints.MaxHeight = 287
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 33
    Width = 460
    Height = 13
    Hint = 
      'Nazwa portu / nie zmienia'#263' / cz'#281'stotliwo'#347#263' wysy'#322'ania danych|Pier' +
      'wszy parametr: nazwa portu'#13#10'Drugi parametr: nie zmienia'#263#13#10'Trzeci' +
      ' parametr: cz'#281'stotliwo'#347#263' wysy'#322'ania danych'
    Margins.Top = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = 'UART:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    ExplicitWidth = 34
  end
  object Label2: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 96
    Width = 460
    Height = 13
    Margins.Top = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = 'UARTtune:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 60
  end
  object Label3: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 70
    Width = 460
    Height = 13
    Margins.Top = 0
    Align = alTop
    Caption = 'Nazwa portu / nie zmienia'#263' / cz'#281'stotliwo'#347#263' wysy'#322'ania danych'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    ExplicitWidth = 290
  end
  object edUART: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 49
    Width = 460
    Height = 21
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 0
  end
  object edUARTTune: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 112
    Width = 460
    Height = 21
    Align = alTop
    TabOrder = 1
  end
  object chUARTDebug: TCheckBox
    AlignWithMargins = True
    Left = 3
    Top = 223
    Width = 460
    Height = 17
    Align = alTop
    Caption = 'Wy'#347'wietlanie danych debugowania w konsoli'
    TabOrder = 2
    ExplicitTop = 255
  end
  object chUART: TCheckBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 460
    Height = 17
    Align = alTop
    Caption = 'Komunikacja UART aktywna'
    TabOrder = 3
  end
  object pnlInstruments: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 139
    Width = 460
    Height = 78
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ShowCaption = False
    TabOrder = 4
    object Label4: TLabel
      Left = 0
      Top = 0
      Width = 460
      Height = 13
      Align = alTop
      Caption = 'UARTfeature:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 76
    end
    object pnlTopInstr: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 16
      Width = 454
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object chMainenable: TCheckBox
        Left = 0
        Top = 0
        Width = 97
        Height = 25
        Align = alLeft
        Caption = 'Nastawnik'
        TabOrder = 0
      end
      object chScndenable: TCheckBox
        Left = 97
        Top = 0
        Width = 97
        Height = 25
        Align = alLeft
        Caption = 'Bocznik'
        TabOrder = 1
      end
      object chTrainenable: TCheckBox
        Left = 194
        Top = 0
        Width = 97
        Height = 25
        Align = alLeft
        Caption = 'Hamulec'
        TabOrder = 2
      end
      object chLocalenable: TCheckBox
        Left = 291
        Top = 0
        Width = 121
        Height = 25
        Align = alLeft
        Caption = 'Hamulec lokomotywy'
        TabOrder = 3
      end
    end
    object pnlMiddleInstr: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 47
      Width = 454
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object chRadioVolume: TCheckBox
        Left = 0
        Top = 0
        Width = 97
        Height = 25
        Align = alLeft
        Caption = 'G'#322'o'#347'no'#347#263' radia'
        TabOrder = 0
      end
      object chRadioChannel: TCheckBox
        Left = 97
        Top = 0
        Width = 97
        Height = 25
        Align = alLeft
        Caption = 'Kana'#322' radia'
        TabOrder = 1
      end
    end
  end
end
