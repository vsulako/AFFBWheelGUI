object AnalogAxisFrame: TAnalogAxisFrame
  Left = 0
  Top = 0
  Width = 642
  Height = 100
  Margins.Left = 0
  Margins.Top = 0
  Margins.Right = 0
  Margins.Bottom = 0
  TabOrder = 0
  object Group: TGroupBox
    Left = 0
    Top = 0
    Width = 642
    Height = 100
    Align = alClient
    Caption = 'Axis #1 (Y - Accelerator)'
    Color = clBtnFace
    Constraints.MinWidth = 384
    Ctl3D = True
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitLeft = 3
    DesignSize = (
      642
      100)
    object Percent: TLabel
      Left = 506
      Top = 66
      Width = 25
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '-2%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object labelTrim: TLabel
      Left = 316
      Top = 74
      Width = 24
      Height = 13
      Caption = 'Trim:'
    end
    object Max: TLabeledEdit
      Left = 32
      Top = 42
      Width = 49
      Height = 21
      Alignment = taRightJustify
      EditLabel.Width = 24
      EditLabel.Height = 13
      EditLabel.Caption = 'Max:'
      LabelPosition = lpLeft
      TabOrder = 0
      OnChange = MaxChange
    end
    object Center: TLabeledEdit
      Left = 139
      Top = 16
      Width = 49
      Height = 21
      Alignment = taRightJustify
      Ctl3D = True
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'Center:'
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 1
      OnChange = CenterChange
    end
    object autoLimit: TCheckBox
      Left = 18
      Top = 70
      Width = 81
      Height = 17
      Caption = 'Autolimit'
      TabOrder = 2
      OnClick = autoLimitClick
    end
    object DeadZone: TLabeledEdit
      Left = 139
      Top = 43
      Width = 49
      Height = 21
      Alignment = taRightJustify
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Deadzone:'
      LabelPosition = lpLeft
      TabOrder = 3
      OnChange = DeadZoneChange
    end
    object Min: TLabeledEdit
      Left = 32
      Top = 15
      Width = 49
      Height = 21
      Alignment = taRightJustify
      Ctl3D = True
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'Min:'
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 4
      OnChange = MinChange
    end
    object Bar: TPanel
      Left = 194
      Top = 17
      Width = 439
      Height = 17
      Anchors = [akLeft, akTop, akRight]
      BevelKind = bkFlat
      BevelOuter = bvNone
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 5
      object BarVal: TPanel
        Left = 256
        Top = 0
        Width = 185
        Height = 49
        BevelOuter = bvNone
        Caption = 'BarVal'
        Color = clHotLight
        ParentBackground = False
        TabOrder = 0
      end
    end
    object hasCenter: TCheckBox
      Left = 115
      Top = 70
      Width = 89
      Height = 17
      Caption = 'Has center'
      TabOrder = 6
      OnClick = hasCenterClick
    end
    object Val: TLabeledEdit
      Left = 584
      Top = 63
      Width = 49
      Height = 19
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = cl3DLight
      Ctl3D = False
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Value:'
      LabelPosition = lpLeft
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 7
    end
    object Raw: TLabeledEdit
      Left = 584
      Top = 40
      Width = 49
      Height = 19
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Color = cl3DLight
      Ctl3D = False
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = 'Raw:'
      LabelPosition = lpLeft
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 8
    end
    object setMin: TButton
      Left = 194
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Set Min'
      TabOrder = 9
      OnClick = setMinClick
    end
    object setMax: TButton
      Left = 346
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Set Max'
      TabOrder = 10
      OnClick = setMaxClick
    end
    object setCenter: TButton
      Left = 274
      Top = 40
      Width = 66
      Height = 25
      Caption = 'Set Center'
      TabOrder = 11
      OnClick = setCenterClick
    end
    object outputDisabled: TCheckBox
      Left = 194
      Top = 71
      Width = 103
      Height = 17
      Caption = 'Output disabled'
      TabOrder = 12
      OnClick = outputDisabledClick
    end
    object bitTrim: TComboBox
      Left = 346
      Top = 71
      Width = 87
      Height = 21
      Style = csDropDownList
      TabOrder = 13
      OnChange = bitTrimChange
      Items.Strings = (
        'none'
        '1 bit (/2)'
        '2 bit (/4)'
        '3 bit (/8)'
        '4 bit (/16)'
        '5 bit (/32)'
        '6 bit (/64)'
        '7 bit (/128)')
    end
  end
end
