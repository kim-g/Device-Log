object AddLab: TAddLab
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1083#1072#1073#1086#1088#1072#1090#1086#1088#1080#1080
  ClientHeight = 168
  ClientWidth = 444
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
    Width = 204
    Height = 23
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1083#1072#1073#1086#1088#1072#1090#1086#1088#1080#1080
  end
  object Label2: TLabel
    Left = 8
    Top = 66
    Width = 123
    Height = 23
    Caption = #1040#1073#1073#1088#1080#1074#1080#1072#1090#1091#1088#1072
  end
  object FullName: TEdit
    Left = 8
    Top = 32
    Width = 424
    Height = 31
    TabOrder = 0
  end
  object Button1: TButton
    Left = 80
    Top = 127
    Width = 121
    Height = 33
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 224
    Top = 127
    Width = 121
    Height = 33
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    OnClick = Button2Click
  end
  object ShortName: TEdit
    Left = 8
    Top = 90
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
