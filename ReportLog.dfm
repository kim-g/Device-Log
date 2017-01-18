object Report: TReport
  Left = 0
  Top = 0
  Caption = #1054#1090#1095#1105#1090
  ClientHeight = 469
  ClientWidth = 675
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 675
    Height = 51
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 13
      Width = 204
      Height = 23
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1095#1105#1090' '#1089' '
    end
    object Label2: TLabel
      Left = 376
      Top = 13
      Width = 21
      Height = 23
      Caption = #1087#1086
    end
    object DateFrom: TDateTimePicker
      Left = 226
      Top = 13
      Width = 135
      Height = 25
      Date = 42045.660050057870000000
      Time = 42045.660050057870000000
      TabOrder = 0
    end
    object DateTo: TDateTimePicker
      Left = 418
      Top = 13
      Width = 135
      Height = 25
      Date = 42045.660050057870000000
      Time = 42045.660050057870000000
      TabOrder = 1
    end
    object Button1: TButton
      Left = 568
      Top = 7
      Width = 97
      Height = 38
      Caption = #1053#1072#1095#1072#1090#1100
      TabOrder = 2
      OnClick = CreateReport
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 51
    Width = 675
    Height = 377
    Align = alClient
    BorderWidth = 10
    TabOrder = 1
    object Memo: TMemo
      Left = 11
      Top = 11
      Width = 653
      Height = 355
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 428
    Width = 675
    Height = 41
    Align = alBottom
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 200
      Height = 39
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Button3: TButton
        Left = 10
        Top = 5
        Width = 177
        Height = 27
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
        TabOrder = 0
        OnClick = Button3Click
      end
    end
    object Panel5: TPanel
      Left = 544
      Top = 1
      Width = 130
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object Button2: TButton
        Left = 14
        Top = 5
        Width = 107
        Height = 27
        Caption = #1047#1072#1082#1088#1099#1090#1100
        TabOrder = 0
        OnClick = Button2Click
      end
    end
    object Panel6: TPanel
      Left = 201
      Top = 1
      Width = 343
      Height = 39
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 7
      TabOrder = 2
      object ProgressBar1: TProgressBar
        Left = 7
        Top = 7
        Width = 329
        Height = 25
        Align = alClient
        Step = 1
        TabOrder = 0
        Visible = False
      end
    end
  end
  object PB_Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = PB_TimerTimer
    Left = 512
    Top = 240
  end
  object SD: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt) |*.txt'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1086#1090#1095#1105#1090' '#1082#1072#1082'...'
    Left = 184
    Top = 432
  end
end
