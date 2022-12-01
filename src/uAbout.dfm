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
        '7.9.4 (02.06.2022)'
        '*katalog we wpisie dynamic mo'#380'e zaczyna'#263' si'#281' od '
        'cyfr'
        '*automatyczne ustawienie sprz'#281'g'#243'w podczas '
        'odwracania pojazd'#243'w'
        '*opcja odbi'#263' 60 FPS'
        '*poprawione unikalne nazwy pojazd'#243'w'
        ''
        '7.9.3 (27.03.2022)'
        '*poprawione unikalne nazwy pojazd'#243'w'
        ''
        '7.9.2.1 (13.03.2022)'
        '*ob'#322'uga parametru czu'#322'o'#347'ci zaworu FV4a'
        '*poprawiona obs'#322'uga pojazd'#243'w z brakami'
        '*poprawka kategorii pojazd'#243'w'
        ''
        '7.9.1 (03.02.2022)'
        '*poprawione '#322'adowanie miniaturek pojazd'#243'w'
        ''
        '7.9 (30.01.2022)'
        '*automatyczna podmiana pojazd'#243'w wielocz'#322'onowych'
        '*zmiana stanu hamulca wp'#322'ywa na ca'#322'y zesp'#243#322' '
        'trakcyjny'
        '*obs'#322'uga parametru czu'#322'o'#347'ci zaworu hamulca'
        ''
        '...')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
  end
end
