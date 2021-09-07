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
      Hint = '08.09.2021'
      Align = alTop
      Alignment = taCenter
      Caption = 'Wersja: 7.7'
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
        '7.7 (08.09.2021)'
        '*reorganizacja ustawie'#324
        ''
        '7.6.3 (02.09.2021)'
        '*poprawione ustawienia zaawansowane'
        ''
        '7.6.2 (23.08.2021)'
        '*wyszukiwarka w klawiszologii'
        '*odwracanie w poziomie miniaturek'
        ''
        '7.6.1 (18.08.2021)'
        '*zmieniona obs'#322'uga odwracania pojazd'#243'w'
        ''
        '7.6 (16.08.2021)'
        '*rozszerzona obs'#322'uga odwracania pojazd'#243'w'
        ''
        '7.5.7 (09.08.2021)'
        '*poprawione zmiany poprzedniej wersji'
        ''
        '7.5.6 (08.08.2021)'
        '*mo'#380'liwo'#347#263' zmiany algorytmu HDR'
        '*fpslimit dost'#281'pny tylko dla tryb'#243'w shaderowych'
        ''
        '7.5.5 (27.07.2021)'
        '*zmieniona obs'#322'uga convertmodels'
        '*dodana obs'#322'uga fpslimit'
        ''
        '7.5.4 (02.07.2021)'
        '*poprawiona obs'#322'uga eu07.ini'
        ''
        '7.5.3 (01.07.2021)'
        '*poprawione dodawanie pojazd'#243'w'
        ''
        '...')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      WantReturns = False
    end
  end
end
