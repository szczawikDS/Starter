object frmSearch: TfrmSearch
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Szukanie pojazdu'
  ClientHeight = 366
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbSearch: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 123
    Width = 344
    Height = 13
    Align = alTop
    Caption = 'Szukany element:'
  end
  object lbExample: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 193
    Width = 344
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = 'Przyk'#322'ad: szukaj'#261'c ET22-799 wystarczy wpisa'#263' 799.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 80
    Width = 344
    Height = 13
    Align = alTop
    Caption = 'Szukaj wed'#322'ug:'
  end
  object edText: TEdit
    AlignWithMargins = True
    Left = 3
    Top = 139
    Width = 344
    Height = 21
    Align = alTop
    TabOrder = 2
    OnChange = edTextChange
  end
  object lbList: TListBox
    AlignWithMargins = True
    Left = 3
    Top = 209
    Width = 344
    Height = 154
    Align = alClient
    ItemHeight = 13
    TabOrder = 4
    OnClick = lbListClick
    OnDblClick = lbListDblClick
  end
  object rgFilters: TRadioGroup
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 344
    Height = 71
    Align = alTop
    Caption = 'Filtrowanie'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Wszystkie typy pojazd'#243'w'
      'Tylko elektrowozy'
      'Tylko spalinowozy'
      'Tylko EZT'
      'Tylko wagony')
    TabOrder = 0
    OnClick = rgFiltersClick
  end
  object cbSearchType: TComboBox
    AlignWithMargins = True
    Left = 3
    Top = 96
    Width = 344
    Height = 21
    Align = alTop
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = 'Nazwy tekstury'
    OnChange = cbSearchTypeChange
    Items.Strings = (
      'Nazwy tekstury'
      'Nazwy miniaturki'
      'Operatora'
      'Autora tekstury'
      'Autora zdj'#281#263
      'Roku rewizji'
      'Modelu')
  end
  object pnlDate: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 166
    Width = 344
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 3
    Visible = False
    object Label3: TLabel
      AlignWithMargins = True
      Left = 162
      Top = 3
      Width = 56
      Height = 18
      Align = alLeft
      Caption = 'Rewizja do:'
      Layout = tlCenter
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 56
      Height = 18
      Align = alLeft
      Caption = 'Rewizja od:'
      Layout = tlCenter
    end
    object dtRevEnd: TDateTimePicker
      Left = 221
      Top = 0
      Width = 97
      Height = 21
      Align = alLeft
      Date = 44062.000000000000000000
      Time = 0.841150231484789400
      TabOrder = 1
      OnChange = edTextChange
    end
    object dtRevStart: TDateTimePicker
      Left = 62
      Top = 0
      Width = 97
      Height = 21
      Align = alLeft
      Date = 44062.000000000000000000
      Time = 0.841150231484789400
      TabOrder = 0
      OnChange = edTextChange
    end
  end
end
