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
      Align = alTop
      Alignment = taCenter
      Caption = 'Wersja: 7.9'
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
        '7.9 (25.01.2022)'
        '*zmiana stanu hamulca wp'#322'ywa na ca'#322'y zesp'#243#322' '
        'trakcyjny'
        '*obs'#322'uga parametru czu'#322'o'#347'ci zaworu hamulca'
        ''
        '7.8.1 (17.01.2022)'
        '*przy b'#322#281'dach scenariusza zak'#322'adka z b'#322#281'dami jako '
        'domy'#347'lna'
        '*baza taboru- usuni'#281'ty b'#322#261'd pustego elementu'
        '*tworzenie textures.ini'
        '*poprawione zczytywanie sk'#322'adu ze schowka'
        '*mo'#380'liwo'#347#263' zmiany sprz'#281'gu ostatniego pojazdu'
        '*poprawiona obs'#322'uga renderera ANGLE'
        ''
        '7.8! (28.12.2021)'
        '*rozszerzone logowanie b'#322#281'd'#243'w'
        '*podgl'#261'd logu'
        '*scalone zak'#322'adki rozk'#322'adu i dodatk'#243'w'
        '*dodana zak'#322'adka z informacjami o b'#322#281'dach'
        '*poprawiona unikalno'#347#263' nazw pojazd'#243'w'
        '*refaktoryzacja'
        ''
        '7.7.4 (11.11.2021)'
        '*opis opcji ograniczenia cieni'
        '*przycisk pomocy- odno'#347'niki do instrukcji'
        ''
        '7.7.3 (08.11.2021)'
        '*poprawione wy'#347'wietlanie danych pojazdu'
        '*poprawione przechodzenie do magazynu'
        '*ulepszone opisy parametr'#243'w d'#378'wi'#281'ku'
        ''
        '7.7.2 (21.10.2021)'
        '*ka'#380'dorazowe od'#347'wie'#380'anie mini scenariusza'
        ''
        '7.7.1 (12.10.2021)'
        '*poprawione nadawanie numer'#243'w pojazdom'
        '*obs'#322'uga poziomu wyciszenia podczas pauzy'
        ''
        '7.7 (08.09.2021)'
        '*reorganizacja ustawie'#324
        '*obs'#322'uga dodatkowych parametr'#243'w cieni i '
        'renderowania'
        ''
        '7.6.3 (02.09.2021)'
        '*poprawione ustawienia zaawansowane'
        ''
        '7.6.2 (23.08.2021)'
        '*wyszukiwarka w klawiszologii'
        '*odwracanie w poziomie miniaturek'
        ''
        '...')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
  end
end
