object frmTexRandomizer: TfrmTexRandomizer
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Zmiana tekstur'
  ClientHeight = 232
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbTestVersion: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 173
    Width = 252
    Height = 13
    Align = alBottom
    Alignment = taCenter
    Caption = 'Wersja testowa- mog'#261' wyst'#261'pi'#263' b'#322#281'dy.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
    ExplicitTop = 131
    ExplicitWidth = 188
  end
  object pnlEra: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 252
    Height = 110
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    object lbEra: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 246
      Height = 13
      Align = alTop
      Alignment = taCenter
      Caption = 'EPOKA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 36
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 22
      Width = 246
      Height = 22
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object seTexAgeDiff: TSpinEdit
        Left = 185
        Top = 0
        Width = 41
        Height = 22
        Align = alLeft
        MaxValue = 8
        MinValue = 2
        TabOrder = 0
        Value = 3
      end
      object chRevDiff: TCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 179
        Height = 16
        Align = alLeft
        Caption = 'R'#243#380'nica rewizji nie wi'#281'ksza ni'#380
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = chRevDiffClick
      end
    end
    object rbTextureRevYear: TRadioButton
      AlignWithMargins = True
      Left = 20
      Top = 50
      Width = 219
      Height = 17
      Caption = 'wzgl'#281'dem daty rewizji obecnej tekstury'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = rbUserYearClick
    end
    object rbUserYear: TRadioButton
      Left = 20
      Top = 73
      Width = 99
      Height = 17
      Caption = 'wzgl'#281'dem roku:'
      TabOrder = 2
      OnClick = rbUserYearClick
    end
    object seYear: TSpinEdit
      Left = 123
      Top = 73
      Width = 65
      Height = 22
      Enabled = False
      MaxValue = 2050
      MinValue = 1950
      TabOrder = 3
      Value = 2018
    end
  end
  object btnOK: TButton
    AlignWithMargins = True
    Left = 3
    Top = 192
    Width = 252
    Height = 37
    Align = alBottom
    Caption = 'Dopasuj'
    ModalResult = 1
    TabOrder = 1
    ExplicitTop = 150
  end
  object chWithoutArchival: TCheckBox
    AlignWithMargins = True
    Left = 3
    Top = 119
    Width = 252
    Height = 17
    Align = alTop
    Caption = 'Nie losuj tekstur oznaczonych jako archiwalne'
    Checked = True
    State = cbChecked
    TabOrder = 2
    ExplicitLeft = 72
    ExplicitTop = 136
    ExplicitWidth = 97
  end
end
