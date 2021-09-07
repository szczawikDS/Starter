object frmSettingsAdv: TfrmSettingsAdv
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ustawienia zaawansowane'
  ClientHeight = 299
  ClientWidth = 237
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
    Width = 231
    Height = 293
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = -2
    ExplicitTop = -2
    object chCompressTex: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 30
      Width = 225
      Height = 17
      Align = alTop
      Caption = 'Kompresja tekstur TGA'
      Checked = True
      State = cbChecked
      TabOrder = 0
      ExplicitWidth = 233
    end
    object chScaleSpeculars: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 53
      Width = 225
      Height = 17
      Align = alTop
      Caption = 'Skalowanie sk'#322'adowej specular'
      Checked = True
      State = cbChecked
      TabOrder = 1
      ExplicitWidth = 233
    end
    object chUseGLES: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 76
      Width = 225
      Height = 17
      Align = alTop
      AllowGrayed = True
      Caption = 'U'#380'yj OpenGL ES'
      State = cbGrayed
      TabOrder = 2
      ExplicitWidth = 233
    end
    object chShaderGamma: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 99
      Width = 225
      Height = 17
      Align = alTop
      AllowGrayed = True
      Caption = 'Gamma w shaderach'
      State = cbGrayed
      TabOrder = 3
      ExplicitWidth = 233
    end
    object chMipmaps: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 122
      Width = 225
      Height = 17
      Align = alTop
      AllowGrayed = True
      Caption = 'Mipmapy ekran'#243'w'
      State = cbGrayed
      TabOrder = 4
      ExplicitWidth = 233
    end
    object chIgnoreIrrevelant: TCheckBox
      AlignWithMargins = True
      Left = 3
      Top = 145
      Width = 225
      Height = 17
      Align = alTop
      Caption = 'Nie wczytuj sk'#322'ad'#243'w-dekoracji'
      TabOrder = 5
      ExplicitWidth = 233
    end
    object pnlConvertModels: TPanel
      Left = 0
      Top = 0
      Width = 231
      Height = 27
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 6
      ExplicitWidth = 239
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
      end
    end
    object pnlLegend: TPanel
      Left = 0
      Top = 193
      Width = 231
      Height = 100
      Align = alBottom
      BevelOuter = bvNone
      Enabled = False
      ShowCaption = False
      TabOrder = 7
      object lbLegend: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 225
        Height = 13
        Align = alTop
        AutoSize = False
        Caption = 'Legenda:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
        ExplicitLeft = 364
        ExplicitWidth = 45
      end
      object CheckBox1: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 22
        Width = 225
        Height = 17
        Align = alTop
        Caption = 'Opcja w'#322#261'czona'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        ExplicitTop = 45
        ExplicitWidth = 406
      end
      object CheckBox2: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 45
        Width = 225
        Height = 17
        Align = alTop
        Caption = 'Opcja wy'#322#261'czona'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
        TabOrder = 1
        ExplicitTop = 68
        ExplicitWidth = 406
      end
      object CheckBox3: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 68
        Width = 225
        Height = 17
        Align = alTop
        Caption = 'Opcja nieaktywna'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
        State = cbGrayed
        TabOrder = 2
        ExplicitTop = 91
        ExplicitWidth = 406
      end
    end
  end
end
