object frmUART: TfrmUART
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'UART'
  ClientHeight = 223
  ClientWidth = 530
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
    Top = 16
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
    Top = 80
    Width = 53
    Height = 13
    Caption = 'UARTtune:'
  end
  object Label3: TLabel
    Left = 17
    Top = 59
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
  object Label4: TLabel
    Left = 17
    Top = 120
    Width = 500
    Height = 13
    AutoSize = False
    Caption = 
      'ham. zespolony min max/ham. dodatkowy min max/ci'#347'nienie max w zb' +
      'iorniku g'#322'./max warto'#347#263' dla PWM'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object edUART: TEdit
    Left = 17
    Top = 32
    Width = 290
    Height = 21
    TabOrder = 0
  end
  object edUARTTune: TEdit
    Left = 17
    Top = 96
    Width = 433
    Height = 21
    TabOrder = 1
  end
  object chMainenable: TCheckBox
    Left = 17
    Top = 152
    Width = 97
    Height = 17
    Caption = 'Nastawnik'
    TabOrder = 2
  end
  object chScndenable: TCheckBox
    Left = 120
    Top = 152
    Width = 97
    Height = 17
    Caption = 'Bocznik'
    TabOrder = 3
  end
  object chTrainenable: TCheckBox
    Left = 223
    Top = 152
    Width = 97
    Height = 17
    Caption = 'Hamulec'
    TabOrder = 4
  end
  object chLocalenable: TCheckBox
    Left = 326
    Top = 152
    Width = 121
    Height = 17
    Caption = 'Hamulec lokomotywy'
    TabOrder = 5
  end
  object chUARTDebug: TCheckBox
    Left = 17
    Top = 184
    Width = 248
    Height = 17
    Caption = 'Wy'#347'wietlanie danych debugowania w konsoli'
    TabOrder = 6
  end
end
