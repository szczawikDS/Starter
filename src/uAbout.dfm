object frmAbout: TfrmAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'O programie'
  ClientHeight = 322
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
    Height = 322
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
      Top = 62
      Width = 300
      Height = 13
      Hint = '(16.11.2020)'
      Align = alTop
      Alignment = taCenter
      Caption = '6.1.1'
      ParentShowHint = False
      ShowHint = True
    end
    object Label11: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 33
      Width = 294
      Height = 13
      Margins.Top = 0
      Margins.Bottom = 3
      Align = alTop
      Alignment = taCenter
      Caption = 'dla symulatora MaSzyna'
      WordWrap = True
    end
    object Label2: TLabel
      Left = 0
      Top = 49
      Width = 300
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Wersja:'
      ParentShowHint = False
      ShowHint = False
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 132
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
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 116
      Width = 294
      Height = 13
      Margins.Top = 10
      Align = alBottom
      Alignment = taCenter
      Caption = 'G'#322#243'wny programista:'
      Layout = tlBottom
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 78
      Width = 294
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'Wydany na licencji GNU GPL v3.0.'
      WordWrap = True
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 171
      Width = 294
      Height = 13
      Margins.Top = 10
      Align = alBottom
      Alignment = taCenter
      Caption = 'Testy, sugestie:'
      Layout = tlBottom
    end
    object Label7: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 261
      Width = 294
      Height = 13
      Margins.Top = 10
      Margins.Bottom = 3
      Align = alBottom
      Alignment = taCenter
      Caption = 'T'#322'umaczenie na j'#281'zyk czeski:'
      Layout = tlBottom
    end
    object Label8: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 187
      Width = 294
      Height = 64
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = '@jakubg1'#13#10'@matek123'#13#10'@Stele'#13#10'@Turbokibel'
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
      Top = 280
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
    end
  end
  object pnlLog: TPanel
    Left = 0
    Top = 0
    Width = 294
    Height = 322
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
    end
    object meLog: TMemo
      AlignWithMargins = True
      Left = 3
      Top = 19
      Width = 288
      Height = 300
      Align = alClient
      Lines.Strings = (
        '6.1.1 (16.11.2020)'
        '*poprawka aktywacji przycisku START'
        ''
        '6.1 (15.11.2020)'
        '*informacje o sk'#322'adzie przy podgl'#261'dzie graficznym'
        '*klikni'#281'cie PPM- prze'#322#261'czenie pojazdu bez zmiany '
        'podgl'#261'du pojazdu'
        '*kontrola maksymalnej ilo'#347'ci '#322'adunku'
        '*brak blokady sprz'#281'gu dla ostatniego pojazdu w '
        'sk'#322'adzie'
        ''
        '6.0 (09.11.2020)'
        '*automatyczne wstawianie pojazd'#243'w '
        'wielocz'#322'onowych'
        '*automatyczna zmiana tekstury we wszystkich '
        'cz'#322'onach pojazdu'
        '*'#322#261'czenie bie'#380#261'cego sk'#322'adu ze sk'#322'adem z magazynu'
        ''
        '5.10 (01.11.2020)'
        '*obs'#322'uga parametru maxcabtexturesize'
        '*reorganizacja ustawie'#324' pogodowych'
        '*poprawiona obs'#322'uga komentarzy wewn'#261'trz wpis'#243'w '
        'trainset'
        ''
        '5.9 (21.10.2020)'
        '*obs'#322'uga compresstex oraz gfx.reflections.fidelity'
        '*okno zaawansowanych ustawie'#324' (PPM na przycisku '
        'ustawie'#324')'
        ''
        '5.8.2 (05.10.2020)'
        '*baza taboru- wybieranie taboru do edycji przez '
        'dwuklik'
        ''
        '5.8.1 (30.09.2020)'
        '*wy'#347'wietlanie katalogu modelu- poprawka'
        ''
        '5.8 (29.09.2020)'
        '*obs'#322'uga parametru automatycznej rozdzielczo'#347'ci'
        '*wy'#347'wietlanie katalogu modelu'
        '*poprawka na niezdefiniowany j'#281'zyk w starterze'
        '*@Traktor175: rozszerzone t'#322'umaczenie j'#281'zyka '
        'czeskiego'
        ''
        '5.7 (24.09.2020)'
        '*opcja usuwania pojazdu z poziomu miniaturki'
        ''
        '5.6.1 (22.09.2020)'
        '*poprawiony proces aktualizacji programu'
        ''
        '...')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
  end
end
