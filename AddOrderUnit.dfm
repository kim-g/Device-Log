object AddOrder: TAddOrder
  Left = 0
  Top = 0
  Caption = 'AddOrder'
  ClientHeight = 386
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 23
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 79
    Height = 23
    Caption = #1060#1072#1084#1080#1083#1080#1103
  end
  object Label2: TLabel
    Left = 18
    Top = 69
    Width = 35
    Height = 23
    Caption = #1048#1084#1103
  end
  object Label3: TLabel
    Left = 21
    Top = 136
    Width = 80
    Height = 23
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086
  end
  object Label4: TLabel
    Left = 18
    Top = 200
    Width = 115
    Height = 23
    Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
  end
  object Label5: TLabel
    Left = 18
    Top = 256
    Width = 115
    Height = 23
    Caption = #1051#1072#1073#1086#1088#1072#1090#1086#1088#1080#1103
  end
  object FName: TEdit
    Left = 16
    Top = 32
    Width = 420
    Height = 31
    TabOrder = 0
  end
  object Button1: TButton
    Left = 72
    Top = 345
    Width = 121
    Height = 33
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 345
    Width = 121
    Height = 33
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 6
    OnClick = Button2Click
  end
  object SName: TEdit
    Left = 18
    Top = 96
    Width = 418
    Height = 31
    TabOrder = 1
  end
  object LName: TEdit
    Left = 19
    Top = 160
    Width = 417
    Height = 31
    TabOrder = 2
  end
  object Org: TComboBox
    Left = 18
    Top = 224
    Width = 417
    Height = 31
    Style = csDropDownList
    TabOrder = 3
    OnChange = OrgChange
  end
  object Lab: TComboBox
    Left = 18
    Top = 280
    Width = 417
    Height = 31
    Style = csDropDownList
    TabOrder = 4
  end
  object Query: TADOQuery
    Connection = MainMenuForm.DB
    Parameters = <>
    Left = 400
    Top = 8
  end
end
