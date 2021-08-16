object frmUART: TfrmUART
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'UART'
  ClientHeight = 211
  ClientWidth = 466
  Color = clBtnFace
  Constraints.MaxHeight = 250
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
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
    ParentShowHint = False
    ShowHint = False
    ExplicitLeft = 0
    ExplicitTop = 26
    ExplicitWidth = 466
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
    ExplicitLeft = -2
    ExplicitTop = 82
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
    ExplicitLeft = 17
    ExplicitTop = 83
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
    ExplicitLeft = 0
    ExplicitTop = 45
    ExplicitWidth = 466
  end
  object edUARTTune: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 112
    Width = 460
    Height = 21
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 25
    ExplicitTop = 120
    ExplicitWidth = 433
  end
  object chUARTDebug: TCheckBox
    AlignWithMargins = True
    Left = 3
    Top = 177
    Width = 460
    Height = 17
    Align = alTop
    Caption = 'Wy'#347'wietlanie danych debugowania w konsoli'
    TabOrder = 2
    ExplicitLeft = -3
    ExplicitWidth = 466
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
    ExplicitLeft = 17
    ExplicitTop = 8
    ExplicitWidth = 160
  end
  object pnlInstruments: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 146
    Width = 460
    Height = 25
    Margins.Top = 10
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
    ExplicitLeft = 0
    ExplicitTop = 104
    ExplicitWidth = 466
    object chMainenable: TCheckBox
      Left = 0
      Top = 0
      Width = 97
      Height = 25
      Align = alLeft
      Caption = 'Nastawnik'
      TabOrder = 0
      ExplicitLeft = 17
      ExplicitTop = 8
      ExplicitHeight = 17
    end
    object chScndenable: TCheckBox
      Left = 97
      Top = 0
      Width = 97
      Height = 25
      Align = alLeft
      Caption = 'Bocznik'
      TabOrder = 1
      ExplicitLeft = 120
      ExplicitTop = 8
      ExplicitHeight = 17
    end
    object chTrainenable: TCheckBox
      Left = 194
      Top = 0
      Width = 97
      Height = 25
      Align = alLeft
      Caption = 'Hamulec'
      TabOrder = 2
      ExplicitLeft = 223
      ExplicitTop = 8
      ExplicitHeight = 17
    end
    object chLocalenable: TCheckBox
      Left = 291
      Top = 0
      Width = 121
      Height = 25
      Align = alLeft
      Caption = 'Hamulec lokomotywy'
      TabOrder = 3
      ExplicitLeft = 326
      ExplicitTop = 8
      ExplicitHeight = 17
    end
  end
end
