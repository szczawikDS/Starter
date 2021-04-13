object frmAbout: TfrmAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'O programie'
  ClientHeight = 336
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlAbout: TPanel
    Left = 294
    Top = 0
    Width = 300
    Height = 336
    Align = alRight
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 294
      Height = 30
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Starter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 0
      Top = 36
      Width = 300
      Height = 13
      Hint = '13.04.2021'
      Align = alTop
      Alignment = taCenter
      Caption = 'Wersja: 7.1.1'
      ParentShowHint = False
      ShowHint = True
      ExplicitWidth = 67
    end
    object Label11: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 49
      Width = 294
      Height = 13
      Margins.Top = 0
      Align = alTop
      Alignment = taCenter
      Caption = 'dla symulatora MaSzyna'
      WordWrap = True
      ExplicitWidth = 116
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 118
      Width = 294
      Height = 29
      Hint = 'damian.skrzek@szczawik.net'
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = '@szczawik'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      ExplicitTop = 132
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 99
      Width = 294
      Height = 13
      Margins.Top = 10
      Align = alBottom
      Alignment = taCenter
      Caption = 'G'#322#243'wny programista:'
      Layout = tlBottom
      ExplicitWidth = 100
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 68
      Width = 294
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Wydany na licencji GNU GPL v3.0.'
      WordWrap = True
      ExplicitWidth = 163
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 160
      Width = 294
      Height = 13
      Margins.Top = 10
      Align = alBottom
      Alignment = taCenter
      Caption = 'Testy, sugestie:'
      Layout = tlBottom
      ExplicitWidth = 78
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 275
      Width = 294
      Height = 13
      Margins.Top = 10
      Align = alBottom
      Alignment = taCenter
      Caption = 'T'#322'umaczenie na j'#281'zyk czeski:'
      Layout = tlBottom
      ExplicitWidth = 137
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 179
      Width = 294
      Height = 83
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = '@DzordZ'#13#10'@jakubg1'#13#10'@Joachimowicz'#13#10'@matek123'#13#10'@Stele'#13#10'@Turbokibel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 294
      Width = 294
      Height = 32
      Margins.Bottom = 10
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = '@Traktor175'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitTop = 280
    end
  end
  object pnlLog: TPanel
    Left = 0
    Top = 0
    Width = 294
    Height = 336
    Align = alClient
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object Label12: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 288
      Height = 13
      Align = alTop
      Caption = 'Lista zmian:'
      ExplicitWidth = 56
    end
    object meLog: TMemo
      AlignWithMargins = True
      Left = 3
      Top = 22
      Width = 288
      Height = 311
      Align = alClient
      Lines.Strings = (
        '7.1.1 (13.04.2021)'
        '*poprawione prze'#322'adowywanie scenerii'
        '*opcja auto-rozwijania drzewka'
        ''
        '7.1 (12.04.2021)'
        '*sortowanie listy scenerii (wg grup)'
        '*podgl'#261'd i nadawanie numeru wagonu [CTRL + N]'
        '*definiowanie startowo wybranej scenerii'
        ''
        '7.0 (10.03.2021)'
        '*obs'#322'uga zestaw'#243'w ustawie'#324
        '*obs'#322'uga wirtualnego manewrowego'
        '*obs'#322'uga ANGLE'
        '*usuni'#281'cie multisamplingu x16'
        '*poprawione kopiowanie sk'#322'adu do schowka'
        ''
        '6.8 (06.02.2021)'
        '*poprawione losowanie tekstur'
        '*dodana kategoria "prototypy"'
        '*sortowanie magazynu wg nazwy pojazdu lub '
        'poci'#261'gu'
        ''
        '6.7 (30.01.2021)'
        '*refaktoryzacja'
        '*poprawione wyszukiwanie tekstur'
        '*poprawione przechodzenie pomi'#281'dzy grupami '
        'pojazd'#243'w'
        '*zapami'#281'tywanie opcji widoczno'#347'ci sk'#322'ad'#243'w'
        ''
        '6.6.4 (04.01.2021)'
        '*poprawiona obs'#322'uga wpi'#243'w include w fizyce'
        '*od'#347'wie'#380'enie parametr'#243'w poci'#261'gu po zmianie '
        'tekstury'
        ''
        '6.6.3 (02.01.2021)'
        '*sprawdzanie sprz'#281'gu wy'#322#261'czone przy wci'#347'ni'#281'tym '
        'Ctrl'
        '*korekty losowania pojazd'#243'w'
        '*poprawione przewijanie listy modeli'
        ''
        '6.6.2 (29.12.2020)'
        '*poprawione elementy interfejsu'
        '*refaktoryzacja'
        ''
        '6.6.1 (23.12.2020)'
        '*poprawiona obs'#322'uga wpis'#243'w include w fizyce'
        ''
        '6.6 (22.12.2020)'
        '*obs'#322'uga ControlType sprz'#281'gu'
        '*zmienione pobieranie nowszych wersji'
        '*poprawiona obs'#322'uga pojazd'#243'w z brakami'
        '*poprawiona obs'#322'uga schowka'
        ''
        '...')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
  end
end
