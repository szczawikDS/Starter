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
    object lbVersion: TLabel
      Left = 0
      Top = 36
      Width = 300
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Wersja: 7.9.4 64-bit'
      ParentShowHint = False
      ShowHint = True
      ExplicitWidth = 98
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
      Height = 19
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
    end
    object lbProgrammer: TLabel
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
    object lbLicense: TLabel
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
    object lbTesters: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 150
      Width = 294
      Height = 13
      Margins.Top = 10
      Align = alBottom
      Alignment = taCenter
      Caption = 'Testy, sugestie:'
      Layout = tlBottom
      ExplicitWidth = 78
    end
    object lbTranslators: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 265
      Width = 294
      Height = 13
      Margins.Top = 10
      Align = alBottom
      Alignment = taCenter
      Caption = 'T'#322'umaczenia:'
      Layout = tlBottom
      ExplicitWidth = 63
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 169
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
      ExplicitTop = 179
    end
    object Label9: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 284
      Width = 294
      Height = 32
      Margins.Bottom = 20
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = '@Traktor175 (CZ)'#13#10'@guih48 (HU)'
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
    object lbLog: TLabel
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
        '8.0 beta (23.07.2024)'
        '*reorganizacja ustawie'#324' zaawansowanych'
        '*ukrycie kolejnych cz'#322'on'#243'w pojazd'#243'w na listach'
        '*funkcjonalno'#347#263' t'#322'umaczenia plik'#243'w klawiszologii'
        '*wprowadzenie element'#243'w opcjonalnych'
        '*losowanie tekstur- mo'#380'liwo'#347#263' pomijania archiwalnych'
        ''
        '7.17 (25.02.2024)'
        '*baza taboru- wyszukiwanie wg stacji'
        '*uruchamianie programu- pasek post'#281'pu'
        '*wersje j'#281'zykowe- dodane flagi'
        ''
        '7.16 (03.09.2023)'
        '*poprawiona obs'#322'uga pojazd'#243'w odwr'#243'conych'
        '*okno UART- przycisk do zapisu zmian'
        '*losowanie tekstur- dodane nowe regu'#322'y'
        ''
        '7.15 (13.06.2023)'
        '*obs'#322'uga nowego formatu uartfeature'
        '*dok'#322'adniejsze logowanie b'#322#281'd'#243'w konwersji typ'#243'w'
        '*losowy obr'#243't pojazd'#243'w wielocz'#322'onowych'
        '*optymalizacja'
        '*przycisk START- informacja o przyczynie '
        'wyszarzenia przycisku'
        ''
        '7.14.1 (16.05.2023)'
        '*pomijanie wagi '#322'adunku nieobs'#322'ugiwanego przez '
        'pojazd'
        '*logowanie u'#380'ycia nieobs'#322'ugiwanego '#322'adunku'
        '*archiwalne pojazdy- zapis ustawienia'
        ''
        '7.14 (21.03.2023)'
        '*opcja archwalne pojazdy przeniesiona do okna '
        'g'#322#243'wnego'
        '*naprawa aktualizatora (uaktualnienie nag'#322#243'wka '
        #380#261'dania)'
        '*wykrywanie zmian ustawie'#324' tylko po pe'#322'nym '
        'uruchomieniu programu'
        '*t'#322'umaczenie na j'#281'zyk w'#281'gierski'
        ''
        '7.13 (13.01.2023)'
        '*rozdzielenie opcji losowej kolejnosci i obr'#243'cenia'
        '*obs'#322'uga opcji archiwalne pojazdy'
        ''
        '7.12 (01.12.2022)'
        '*UART- rozbudowa o nowe parametry'
        '*obs'#322'uga UTF-8'
        '*opcja losowania kolejno'#347'ci i obr'#243'cenia wagon'#243'w w '
        'sk'#322'adzie'
        '*wyszukiwanie po '#322'adunku'
        '*obs'#322'uga komentarzy w plikach textures.txt'
        '*poprawiona obs'#322'uga pojazd'#243'w wielocz'#322'onowych'
        ''
        '7.11 (26.09.2022)'
        '*wykrywanie zmian ustawie'#324' w tle'
        ''
        '7.10.2 (13.08.2022)'
        '*poprawione kategorie pojazd'#243'w'
        ''
        '7.10.1 (12.08.2022)'
        '*poprawione kategorie pojazd'#243'w'
        ''
        '7.10 (09.08.2022)'
        '*unikalno'#347#263' nazwy sprawdzana tylko dla wybranego '
        'pojazdu'
        '*logowanie b'#322#281'd'#243'w '#322'adowania miniaturek pojazd'#243'w i '
        'SCN'
        ''
        '...')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
  end
end
