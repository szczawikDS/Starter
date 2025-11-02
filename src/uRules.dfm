object frmRules: TfrmRules
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Regu'#322'y losowania tekstur'
  ClientHeight = 361
  ClientWidth = 531
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 15
  object lbRules: TListBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 525
    Height = 214
    Style = lbOwnerDrawFixed
    Align = alTop
    DoubleBuffered = False
    ItemHeight = 20
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnClick = lbRulesClick
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 513
  end
  object btnSave: TButton
    Left = 0
    Top = 331
    Width = 531
    Height = 30
    Action = actSave
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 320
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 287
    Width = 531
    Height = 29
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = -8
    ExplicitTop = 348
    object cbTypes: TComboBox
      Left = 3
      Top = 3
      Width = 200
      Height = 23
      Style = csDropDownList
      DoubleBuffered = False
      DropDownCount = 16
      ParentDoubleBuffered = False
      TabOrder = 0
      OnChange = cbTypesChange
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
        'Wagony I'
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
        'Ludzie'
        'Zwierz'#281'ta'
        'Prototypy'
        'Inne')
    end
    object cbModels: TComboBox
      Left = 209
      Top = 3
      Width = 200
      Height = 23
      Style = csDropDownList
      DoubleBuffered = False
      DropDownCount = 16
      ParentDoubleBuffered = False
      TabOrder = 1
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
        'Wagony I'
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
        'Ludzie'
        'Zwierz'#281'ta'
        'Prototypy'
        'Inne')
    end
    object btnAdd: TButton
      Left = 415
      Top = 2
      Width = 101
      Height = 24
      Action = actAdd
      TabOrder = 2
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 220
    Width = 531
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object sbButtons: TScrollBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 525
      Height = 61
      HorzScrollBar.Smooth = True
      HorzScrollBar.Tracking = True
      Align = alLeft
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimerTimer
    Left = 480
    Top = 245
  end
  object AL: TActionList
    Left = 400
    Top = 247
    object actAdd: TAction
      Caption = 'Dodaj do regu'#322'y'
      OnExecute = actAddExecute
      OnUpdate = actAddUpdate
    end
    object actSave: TAction
      Caption = 'Zapisz regu'#322'y'
      OnExecute = actSaveExecute
    end
    object actButtonClick: TAction
      Caption = '-'
      OnExecute = actButtonClickExecute
    end
  end
end
