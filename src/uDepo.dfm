object frmDepo: TfrmDepo
  Left = 0
  Top = 0
  Caption = 'Baza taboru'
  ClientHeight = 492
  ClientWidth = 1100
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
  object spSplitter: TSplitter
    Left = 0
    Top = 161
    Width = 1100
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object sgDepo: TStringGrid
    AlignWithMargins = True
    Left = 3
    Top = 167
    Width = 1094
    Height = 322
    Align = alClient
    ColCount = 9
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
    TabOrder = 0
    ColWidths = (
      32
      133
      130
      131
      64
      199
      69
      139
      153)
  end
  object pnlSelect: TPanel
    Left = 0
    Top = 0
    Width = 1100
    Height = 161
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object sgModels: TStringGrid
      AlignWithMargins = True
      Left = 111
      Top = 3
      Width = 378
      Height = 155
      Align = alLeft
      ColCount = 3
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
      TabOrder = 1
      OnClick = sgModelsClick
      ColWidths = (
        40
        161
        147)
    end
    object lbTypes: TListBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 102
      Height = 155
      Align = alLeft
      ItemHeight = 13
      Items.Strings = (
        'Elektrowozy'
        'Spalinowozy'
        'Parowozy'
        'Szynobusy'
        'EZT'
        'Wagony A'
        'Wagony B'
        'Wagony D'
        'Wagony E'
        'Wagony F'
        'Wagony G'
        'Wagony H'
        'Wagony L'
        'Wagony P'
        'Wagony R'
        'Wagony S'
        'Wagony U'
        'Wagony V'
        'Wagony W'
        'Wagony X'
        'Wagony Z'
        'Robocze'
        'Drezyny'
        'Tramwaje'
        'Samochody'
        'Autobusy'
        'Ci'#281#380'ar'#243'wki'
        'Inne')
      TabOrder = 0
      OnClick = lbTypesClick
    end
    object pnlFilters: TPanel
      Left = 492
      Top = 0
      Width = 608
      Height = 161
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 2
      object pnlLeft: TPanel
        Left = 0
        Top = 0
        Width = 241
        Height = 161
        Align = alLeft
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 0
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 235
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object edTexName: TEdit
            Left = 97
            Top = 0
            Width = 121
            Height = 21
            Align = alLeft
            TabOrder = 1
            OnChange = edTexNameChange
          end
          object cbTexName: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Tekstura:'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
        end
        object pnlOwner: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 84
          Width = 235
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object edOperator: TEdit
            Left = 97
            Top = 0
            Width = 121
            Height = 21
            Align = alLeft
            TabOrder = 1
            OnChange = edOperatorChange
          end
          object cbOperator: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Operator:'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
        end
        object Panel4: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 30
          Width = 235
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object edMini: TEdit
            Left = 97
            Top = 0
            Width = 121
            Height = 21
            Align = alLeft
            TabOrder = 1
            OnChange = edMiniChange
          end
          object cbMini: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Miniatura:'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
        end
        object Panel7: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 111
          Width = 235
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 4
          object edStation: TEdit
            Left = 97
            Top = 0
            Width = 121
            Height = 21
            Align = alLeft
            TabOrder = 1
            OnChange = edStationChange
          end
          object cbStation: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Stacja:'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
        end
        object Panel8: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 57
          Width = 235
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object edModel: TEdit
            Left = 97
            Top = 0
            Width = 121
            Height = 21
            Align = alLeft
            TabOrder = 1
            OnChange = edModelChange
          end
          object cbModel: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Model:'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
        end
      end
      object Panel5: TPanel
        Left = 241
        Top = 0
        Width = 224
        Height = 161
        Align = alLeft
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 1
        object Panel6: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 218
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object cbRevStart: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Rewizja od:'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
          object dtRevStart: TDateTimePicker
            Left = 97
            Top = 0
            Width = 120
            Height = 21
            Align = alLeft
            Date = 44062.000000000000000000
            Time = 0.647236898148548800
            TabOrder = 1
            OnChange = dtRevStartChange
          end
        end
        object Panel10: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 30
          Width = 218
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object cbRevEnd: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Rewizja do:'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
          object dtRevEnd: TDateTimePicker
            Left = 97
            Top = 0
            Width = 120
            Height = 21
            Align = alLeft
            Date = 44062.000000000000000000
            Time = 0.647236898148548800
            TabOrder = 1
            OnChange = dtRevEndChange
          end
        end
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 57
          Width = 218
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object edAuthor: TEdit
            Left = 97
            Top = 0
            Width = 121
            Height = 21
            Align = alLeft
            TabOrder = 1
            OnChange = edAuthorChange
          end
          object cbAuthor: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Autor:'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
        end
        object Panel2: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 84
          Width = 218
          Height = 21
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object edPhoto: TEdit
            Left = 97
            Top = 0
            Width = 121
            Height = 21
            Align = alLeft
            TabOrder = 1
            OnChange = edPhotoChange
          end
          object cbPhoto: TCheckBox
            Left = 0
            Top = 0
            Width = 97
            Height = 21
            Align = alLeft
            Caption = 'Autor zdj'#281#263':'
            TabOrder = 0
            OnClick = cbOperatorClick
          end
        end
      end
    end
  end
end
