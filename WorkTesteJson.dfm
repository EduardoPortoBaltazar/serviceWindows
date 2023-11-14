object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'BT Work Agent'
  ClientHeight = 405
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 376
    Top = 56
    Width = 35
    Height = 13
    Caption = 'IdHotel'
    Visible = False
  end
  object Label2: TLabel
    Left = 514
    Top = 56
    Width = 126
    Height = 13
    Caption = 'Data UtimoProcessamento'
    Visible = False
  end
  object Label3: TLabel
    Left = 16
    Top = 8
    Width = 181
    Height = 13
    Caption = 'Saber a data do Arquivo Mais recente'
  end
  object lbv: TLabel
    Left = 18
    Top = 96
    Width = 61
    Height = 13
    Caption = 'Start service'
  end
  object Label4: TLabel
    Left = 18
    Top = 139
    Width = 60
    Height = 13
    Caption = 'Stop Service'
  end
  object Edit1: TEdit
    Left = 376
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
    Visible = False
  end
  object Edit2: TEdit
    Left = 512
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
    Visible = False
  end
  object Button1: TButton
    Left = 376
    Top = 99
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    Visible = False
  end
  object edtCaminho: TEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'C:\Totvs\Servicos\Plugin\InterfaceBTVHF\Robot\Log\2124'
  end
  object Button2: TButton
    Left = 16
    Top = 51
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 184
    Width = 635
    Height = 221
    Align = alBottom
    TabOrder = 5
  end
  object edtStartService: TEdit
    Left = 16
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'HotalBTVHFService'
  end
  object edtStopService: TEdit
    Left = 16
    Top = 155
    Width = 121
    Height = 21
    TabOrder = 7
    Text = 'HotalBTVHFService'
  end
  object Button3: TButton
    Left = 143
    Top = 110
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 144
    Top = 153
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 255
    Top = 153
    Width = 75
    Height = 25
    Caption = 'Minimizar'
    TabOrder = 10
    OnClick = Button5Click
  end
  object Timer: TTimer
    Interval = 40000
    OnTimer = TimerTimer
    Left = 344
    Top = 40
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    Hint = 'BT Work Agent'
    BalloonHint = 'BT Work Agent'
    BalloonTitle = 'BT Work'
    BalloonFlags = bfInfo
    PopupMenu = PopupMenu1
    Visible = True
    OnClick = TrayIcon1Click
    Left = 312
    Top = 208
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 280
    object Abrir1: TMenuItem
      Caption = 'Abrir'
      OnClick = Abrir1Click
    end
  end
end
