object frmAbout: TfrmAbout
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'O programie'
  ClientHeight = 322
  ClientWidth = 332
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
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 326
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
  object Label2: TLabel
    Left = 0
    Top = 49
    Width = 332
    Height = 13
    Hint = '(08.09.2020)'
    Align = alTop
    Alignment = taCenter
    Caption = 'Wersja:'
    ParentShowHint = False
    ShowHint = True
  end
  object Label3: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 132
    Width = 326
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
    Width = 326
    Height = 13
    Margins.Top = 10
    Align = alBottom
    Alignment = taCenter
    Caption = 'G'#322#243'wny programista:'
    Layout = tlBottom
  end
  object Label6: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 171
    Width = 326
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
    Width = 326
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
    Width = 326
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
    Width = 326
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
  object Label5: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 78
    Width = 326
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = 'Wydany na licencji GNU GPL v3.0.'
    WordWrap = True
  end
  object Label10: TLabel
    Left = 0
    Top = 62
    Width = 332
    Height = 13
    Hint = '(13.09.2020)'
    Align = alTop
    Alignment = taCenter
    Caption = '5.4.1'
    ParentShowHint = False
    ShowHint = True
  end
  object Label11: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 33
    Width = 326
    Height = 13
    Margins.Top = 0
    Margins.Bottom = 3
    Align = alTop
    Alignment = taCenter
    Caption = 'dla symulatora MaSzyna'
    WordWrap = True
  end
end
