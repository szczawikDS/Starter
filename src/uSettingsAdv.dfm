object frmSettingsAdv: TfrmSettingsAdv
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ustawienia zaawansowane'
  ClientHeight = 227
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 239
    Height = 221
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 245
    ExplicitHeight = 227
    object chCompressTex: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 30
      Width = 233
      Height = 17
      Align = alTop
      Caption = 'Kompresja tekstur TGA'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ExplicitTop = 52
      ExplicitWidth = 239
    end
    object chScaleSpeculars: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 53
      Width = 233
      Height = 17
      Align = alTop
      Caption = 'Skalowanie sk'#322'adowej specular'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ExplicitTop = 75
      ExplicitWidth = 239
    end
    object chUseGLES: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 76
      Width = 233
      Height = 17
      Align = alTop
      Caption = 'U'#380'yj OpenGL ES'
      Checked = True
      State = cbChecked
      TabOrder = 2
      ExplicitTop = 98
      ExplicitWidth = 239
    end
    object chShaderGamma: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 99
      Width = 233
      Height = 17
      Align = alTop
      Caption = 'Gamma w shaderach'
      Checked = True
      State = cbChecked
      TabOrder = 3
      ExplicitTop = 121
      ExplicitWidth = 239
    end
    object chMipmaps: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 122
      Width = 233
      Height = 17
      Align = alTop
      Caption = 'Mipmapy ekran'#243'w'
      Checked = True
      State = cbChecked
      TabOrder = 4
      ExplicitTop = 144
      ExplicitWidth = 239
    end
    object chIgnoreIrrevelant: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 145
      Width = 233
      Height = 17
      Align = alTop
      Caption = 'Nie wczytuj sk'#322'ad'#243'w-dekoracji'
      TabOrder = 5
      ExplicitTop = 180
      ExplicitWidth = 239
    end
    object pnlConvertModels: TPanel
      Left = 0
      Top = 0
      Width = 239
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      ExplicitLeft = -3
      ExplicitTop = 19
      ExplicitWidth = 245
      object lbe3d: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 102
        Height = 21
        Align = alLeft
        AutoSize = False
        Caption = 'Generowanie E3D:'
        Layout = tlCenter
      end
      object cbConvertmodels: TComboBox
        AlignWithMargins = True
        Left = 111
        Top = 3
        Width = 66
        Height = 21
        Align = alLeft
        DoubleBuffered = False
        ParentDoubleBuffered = False
        TabOrder = 0
        Items.Strings = (
          '0'
          '143')
        ExplicitLeft = 176
      end
    end
  end
end
