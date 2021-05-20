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
      Hint = '20.05.2021'
      Align = alTop
      Alignment = taCenter
      Caption = 'Wersja: 7.4'
      ParentShowHint = False
      ShowHint = True
      ExplicitWidth = 57
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
        '7.4 (20.05.2021)'
        '*zmieniona obs'#322'uga i zapis zestaw'#243'w ustawie'#324
        '*uniezale'#380'nienie wyszukiwania od znak'#243'w '
        'diakrytycznych'
        '*testowa opcja pomijania sk'#322'ad'#243'w dekoracyjnych'
        ''
        '7.3 (17.05.2021)'
        '*indywidualne obrazki dla sk'#322'ad'#243'w'
        '*mo'#380'liwo'#347#263' ukrycia przestarza'#322'ych scenariuszy'
        '*obs'#322'uga parametru wielko'#347'ci bufora'
        '*mo'#380'liwo'#347#263' za'#322'./wy'#322'. komunikacji UART'
        ''
        '7.2.1 (16.05.2021)'
        '*indywidualne ekrany logowania dla sk'#322'ad'#243'w'
        ''
        '7.2 (12.05.2021)'
        '*poprawione wklejanie sk'#322'adu ze schowka'
        '*podgl'#261'd i obs'#322'uga wizualna klawiszologii'
        '*parametry rozdzielczo'#347'ci kopiowane do '
        'gfx.framebuffer'
        ''
        '7.1.2 (25.04.2021)'
        '*od'#347'wie'#380'anie parametr'#243'w lokalnych programu'
        '*usprawnione wykrywanie b'#322#281'd'#243'w'
        ''
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
        '...')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
  end
end
