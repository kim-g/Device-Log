object Add_NIR: TAdd_NIR
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1053#1048#1056
  ClientHeight = 242
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 23
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 56
    Height = 23
    Caption = #1053#1086#1084#1077#1088
  end
  object Label2: TLabel
    Left = 8
    Top = 122
    Width = 118
    Height = 23
    Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
  end
  object Label3: TLabel
    Left = 8
    Top = 64
    Width = 84
    Height = 23
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object NIR: TEdit
    Left = 8
    Top = 32
    Width = 424
    Height = 31
    TabOrder = 0
  end
  object Comment: TEdit
    Left = 8
    Top = 146
    Width = 424
    Height = 31
    TabOrder = 2
  end
  object Button1: TButton
    Left = 80
    Top = 183
    Width = 121
    Height = 33
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 224
    Top = 183
    Width = 121
    Height = 33
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 4
    OnClick = Button2Click
  end
  object NIR_Title: TEdit
    Left = 8
    Top = 88
    Width = 424
    Height = 31
    TabOrder = 1
  end
  object Query: TADOQuery
    Connection = MainMenuForm.DB
    Parameters = <>
    Left = 384
    Top = 8
  end
end
