object frmSettingsAdv: TfrmSettingsAdv
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Ustawienia zaawansowane'
  ClientHeight = 299
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 672
    Height = 293
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 744
    object pnlSettingsAdv: TPanel
      Left = 0
      Top = 0
      Width = 190
      Height = 293
      Align = alLeft
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object chCompressTex: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 30
        Width = 184
        Height = 17
        Align = alTop
        Caption = 'Kompresja tekstur TGA'
        Checked = True
        State = cbChecked
        TabOrder = 0
        ExplicitWidth = 267
      end
      object chIgnoreIrrevelant: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 145
        Width = 184
        Height = 17
        Align = alTop
        Caption = 'Nie wczytuj sk'#322'ad'#243'w-dekoracji'
        TabOrder = 1
        ExplicitWidth = 267
      end
      object chMipmaps: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 122
        Width = 184
        Height = 17
        Align = alTop
        AllowGrayed = True
        Caption = 'Mipmapy ekran'#243'w'
        State = cbGrayed
        TabOrder = 2
        ExplicitWidth = 267
      end
      object chScaleSpeculars: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 53
        Width = 184
        Height = 17
        Align = alTop
        Caption = 'Skalowanie sk'#322'adowej specular'
        Checked = True
        State = cbChecked
        TabOrder = 3
        ExplicitWidth = 267
      end
      object chShaderGamma: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 99
        Width = 184
        Height = 17
        Align = alTop
        AllowGrayed = True
        Caption = 'Gamma w shaderach'
        State = cbGrayed
        TabOrder = 4
        ExplicitWidth = 267
      end
      object chUseGLES: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 76
        Width = 184
        Height = 17
        Align = alTop
        AllowGrayed = True
        Caption = 'U'#380'yj OpenGL ES'
        State = cbGrayed
        TabOrder = 5
        ExplicitWidth = 267
      end
      object pnlConvertModels: TPanel
        Left = 0
        Top = 0
        Width = 190
        Height = 27
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 6
        ExplicitWidth = 273
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
        Width = 190
        Height = 100
        Align = alBottom
        BevelOuter = bvNone
        Enabled = False
        ShowCaption = False
        TabOrder = 7
        ExplicitWidth = 273
        object lbLegend: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 184
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
          Width = 184
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
          ExplicitWidth = 267
        end
        object CheckBox2: TCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 45
          Width = 184
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
          ExplicitWidth = 267
        end
        object CheckBox3: TCheckBox
          AlignWithMargins = True
          Left = 3
          Top = 68
          Width = 184
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
          ExplicitWidth = 267
        end
      end
    end
    object pnlLog: TPanel
      Left = 190
      Top = 0
      Width = 482
      Height = 293
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = 273
      ExplicitWidth = 471
      object lbLogCaption: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 476
        Height = 13
        Align = alTop
        Caption = 'Podgl'#261'd logu:'
        ExplicitWidth = 65
      end
      object meLog: TMemo
        AlignWithMargins = True
        Left = 3
        Top = 22
        Width = 476
        Height = 237
        Align = alClient
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
        ExplicitWidth = 465
      end
      object btnClearLog: TButton
        AlignWithMargins = True
        Left = 3
        Top = 265
        Width = 476
        Height = 25
        Align = alBottom
        Caption = 'Wyczy'#347#263' log'
        TabOrder = 1
        OnClick = btnClearLogClick
        ExplicitWidth = 465
      end
    end
  end
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 395
    Top = 147
  end
end
