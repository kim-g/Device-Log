object AddCond: TAddCond
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1077
  ClientHeight = 126
  ClientWidth = 428
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
    Width = 72
    Height = 23
    Caption = #1059#1089#1083#1086#1074#1080#1103
  end
  object Edit1: TEdit
    Left = 8
    Top = 32
    Width = 409
    Height = 31
    TabOrder = 0
  end
  object Button1: TButton
    Left = 80
    Top = 85
    Width = 129
    Height = 33
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 232
    Top = 85
    Width = 129
    Height = 33
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object Query: TADOQuery
    Connection = MainMenuForm.DB
    Parameters = <>
    Left = 376
  end
end
