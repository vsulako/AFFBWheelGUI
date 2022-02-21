object GainFrame: TGainFrame
  Left = 0
  Top = 0
  Width = 607
  Height = 40
  Align = alTop
  TabOrder = 0
  DesignSize = (
    607
    40)
  object Title: TLabel
    Left = 7
    Top = 14
    Width = 88
    Height = 13
    Caption = 'Sawtooth Down'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Percent: TLabel
    Left = 177
    Top = 14
    Width = 17
    Height = 13
    Caption = '0%'
  end
  object TrackBar: TTrackBar
    Left = 216
    Top = 7
    Width = 382
    Height = 33
    Anchors = [akLeft, akTop, akRight]
    DoubleBuffered = True
    Max = 1000
    ParentDoubleBuffered = False
    PageSize = 32
    Frequency = 32
    Position = 500
    ShowSelRange = False
    TabOrder = 0
    TickMarks = tmTopLeft
    OnChange = TrackBarChange
  end
  object Value: TEdit
    Left = 112
    Top = 11
    Width = 53
    Height = 21
    Alignment = taRightJustify
    TabOrder = 1
    Text = '16383'
    OnChange = ValueChange
  end
end
