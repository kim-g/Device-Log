object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1090#1091
  ClientHeight = 122
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 23
  object Label1: TLabel
    Left = 24
    Top = 27
    Width = 42
    Height = 23
    Caption = #1044#1072#1090#1072
  end
  object Edit1: TEdit
    Left = 80
    Top = 24
    Width = 305
    Height = 31
    TabOrder = 0
  end
  object Button1: TButton
    Left = 56
    Top = 72
    Width = 129
    Height = 33
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 224
    Top = 72
    Width = 129
    Height = 33
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object ADOQuery1: TADOQuery
    Connection = DB
    Parameters = <>
    Left = 392
    Top = 72
  end
  object DB: TADOConnection
    Left = 392
    Top = 8
  end
end
