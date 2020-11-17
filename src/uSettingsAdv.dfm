object frmSettingsAdv: TfrmSettingsAdv
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ustawienia zaawansowane'
  ClientHeight = 184
  ClientWidth = 245
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 245
    Height = 184
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label8: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 239
      Height = 16
      Align = alTop
      AutoSize = False
      Caption = 'Generowanie E3D:'
    end
    object cbConvertmodels: TComboBox
      AlignWithMargins = True
      Left = 3
      Top = 22
      Width = 239
      Height = 21
      Align = alTop
      Style = csDropDownList
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 0
      Items.Strings = (
        'Wy'#322#261'czone'
        'Konwersja')
    end
    object chCompressTex: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 49
      Width = 239
      Height = 17
      Align = alTop
      Caption = 'Kompresja tekstur TGA'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object chScaleSpeculars: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 72
      Width = 239
      Height = 17
      Align = alTop
      Caption = 'Skalowanie sk'#322'adowej specular'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
end
