object frmSettingsAdv: TfrmSettingsAdv
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ustawienia zaawansowane'
  ClientHeight = 208
  ClientWidth = 245
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
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 245
    Height = 208
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitHeight = 184
    object lbe3d: TLabel
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
      Top = 25
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
      Top = 52
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
      Top = 75
      Width = 239
      Height = 17
      Align = alTop
      Caption = 'Skalowanie sk'#322'adowej specular'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object chUseGLES: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 98
      Width = 239
      Height = 17
      Align = alTop
      Caption = 'U'#380'yj OpenGL ES'
      Checked = True
      State = cbChecked
      TabOrder = 3
      ExplicitTop = 121
    end
    object chShaderGamma: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 121
      Width = 239
      Height = 17
      Align = alTop
      Caption = 'Gamma w shaderach'
      Checked = True
      State = cbChecked
      TabOrder = 4
      ExplicitLeft = 6
      ExplicitTop = 154
    end
    object chMipmaps: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 144
      Width = 239
      Height = 17
      Align = alTop
      Caption = 'Mipmapy ekran'#243'w'
      Checked = True
      State = cbChecked
      TabOrder = 5
      ExplicitLeft = 0
      ExplicitTop = 167
    end
  end
end
