object frmUpdater: TfrmUpdater
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Aktualizator'
  ClientHeight = 61
  ClientWidth = 269
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
  object lbUpdate: TLabel
    Left = 0
    Top = 0
    Width = 269
    Height = 38
    Align = alClient
    Alignment = taCenter
    AutoSize = False
    Caption = 'Sprawdzam aktualizacje...'
    Layout = tlCenter
  end
  object pbProgress: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 41
    Width = 263
    Height = 17
    Align = alBottom
    TabOrder = 0
    Visible = False
  end
  object SSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Method = sslvTLSv1_2
    SSLOptions.SSLVersions = [sslvTLSv1_2]
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 48
    Top = 16
  end
end
