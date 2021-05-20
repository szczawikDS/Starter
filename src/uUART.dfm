object frmUART: TfrmUART
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'UART'
  ClientHeight = 210
  ClientWidth = 466
  Color = clBtnFace
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
    Left = 17
    Top = 40
    Width = 31
    Height = 13
    Hint = 
      'Nazwa portu / nie zmienia'#263' / cz'#281'stotliwo'#347#263' wysy'#322'ania danych|Pier' +
      'wszy parametr: nazwa portu'#13#10'Drugi parametr: nie zmienia'#263#13#10'Trzeci' +
      ' parametr: cz'#281'stotliwo'#347#263' wysy'#322'ania danych'
    Caption = 'UART:'
    ParentShowHint = False
    ShowHint = False
  end
  object Label2: TLabel
    Left = 17
    Top = 104
    Width = 53
    Height = 13
    Caption = 'UARTtune:'
  end
  object Label3: TLabel
    Left = 17
    Top = 83
    Width = 290
    Height = 13
    Caption = 'Nazwa portu / nie zmienia'#263' / cz'#281'stotliwo'#347#263' wysy'#322'ania danych'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
  end
  object edUART: TEdit
    Left = 17
    Top = 56
    Width = 290
    Height = 21
    TabOrder = 0
  end
  object edUARTTune: TEdit
    Left = 17
    Top = 120
    Width = 433
    Height = 21
    TabOrder = 1
  end
  object chMainenable: TCheckBox
    Left = 17
    Top = 147
    Width = 97
    Height = 17
    Caption = 'Nastawnik'
    TabOrder = 2
  end
  object chScndenable: TCheckBox
    Left = 120
    Top = 147
    Width = 97
    Height = 17
    Caption = 'Bocznik'
    TabOrder = 3
  end
  object chTrainenable: TCheckBox
    Left = 223
    Top = 147
    Width = 97
    Height = 17
    Caption = 'Hamulec'
    TabOrder = 4
  end
  object chLocalenable: TCheckBox
    Left = 326
    Top = 147
    Width = 121
    Height = 17
    Caption = 'Hamulec lokomotywy'
    TabOrder = 5
  end
  object chUARTDebug: TCheckBox
    Left = 17
    Top = 179
    Width = 248
    Height = 17
    Caption = 'Wy'#347'wietlanie danych debugowania w konsoli'
    TabOrder = 6
  end
  object chUART: TCheckBox
    Left = 17
    Top = 8
    Width = 160
    Height = 17
    Caption = 'Komunikacja UART aktywna'
    TabOrder = 7
  end
end
