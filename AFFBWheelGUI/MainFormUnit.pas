unit MainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  JvHidControllerClass,JvComponentBase,
  analogAxis, gain, Math;

type
  TMainForm = class(TForm)
    PageControl: TPageControl;
    ts1: TTabSheet;
    ts3: TTabSheet;
    HidCtl: TJvHidDeviceController;
    GainGroupBox: TGroupBox;
    Gains: TScrollBox;
    miscPanel: TPanel;
    miscGroupbox: TGroupBox;
    ffbpwmlabel: TLabel;
    ffbBD: TComboBox;
    Axes: TScrollBox;
    axisSteerGrp: TGroupBox;
    steerRangeLabel: TLabel;
    steerPercent: TLabel;
    steerRange: TComboBox;
    steerCenter: TButton;
    steerBar: TPanel;
    steerBarVal: TPanel;
    steerValue: TLabeledEdit;
    steerRaw: TLabeledEdit;
    updateTimer: TTimer;
    maxVD: TLabeledEdit;
    maxVF: TLabeledEdit;
    maxAcc: TLabeledEdit;
    maxForce: TLabeledEdit;
    cutForce: TLabeledEdit;
    cutForceTrackbar: TTrackBar;
    maxForceTrackbar: TTrackBar;
    minForce: TLabeledEdit;
    minForceTrackbar: TTrackBar;
    minForcePercent: TLabel;
    maxForcePercent: TLabel;
    cutForcePercent: TLabel;
    buttonsGrp: TGroupBox;
    centerButtonLabel: TLabel;
    centerButton: TComboBox;
    debounce: TLabeledEdit;
    Panel1: TPanel;
    ControlPanel: TPanel;
    loadDefaults: TButton;
    loadEE: TButton;
    saveEE: TButton;
    devList: TComboBox;
    Version: TLabel;
    buttonsPanel: TPanel;
    Velocity: TLabeledEdit;
    Acceleration: TLabeledEdit;
    SteerPos: TPaintBox;
    SteerAngle: TLabeledEdit;
    procedure HidCtlDeviceChange(Sender: TObject);
    function HidCtlEnumerate(HidDev: TJvHidDevice;
      const Idx: Integer): Boolean;
    procedure HidCtlDeviceData(HidDev: TJvHidDevice; ReportID: Byte;
      const Data: Pointer; Size: Word);
    procedure FormCreate(Sender: TObject);
    procedure debounceChange(Sender: TObject);
    procedure centerButtonSelect(Sender: TObject);
    procedure updateTimerTimer(Sender: TObject);
    procedure steerCenterClick(Sender: TObject);
    procedure steerRangeSelect(Sender: TObject);
    procedure loadDefaultsClick(Sender: TObject);
    procedure loadEEClick(Sender: TObject);
    procedure maxVDChange(Sender: TObject);
    procedure maxVFChange(Sender: TObject);
    procedure maxAccChange(Sender: TObject);
    procedure ffbBDSelect(Sender: TObject);
    procedure cutForceTrackbarChange(Sender: TObject);
    procedure maxForceTrackbarChange(Sender: TObject);
    procedure minForceTrackbarChange(Sender: TObject);
    procedure minForceChange(Sender: TObject);
    procedure maxForceChange(Sender: TObject);
    procedure cutForceChange(Sender: TObject);
    procedure saveEEClick(Sender: TObject);
    procedure HidCtlDeviceUnplug(HidDev: TJvHidDevice);
    procedure devListSelect(Sender: TObject);
    procedure HidCtlDeviceCreateError(Controller: TJvHidDeviceController;
      PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
  private
    { Private declarations }
    analogAxesFrames: array [0..6] of TAnalogAxisFrame;
    buttonsState: array [1..32] of TPanel;
    gainFrames: array [0..12] of TGainFrame;
    procedure makeVisible(visible:boolean);
  public
    { Public declarations }
    procedure  sendCommand(command:Byte;arg1:SmallInt=0;arg2:SmallInt=0;arg3:SmallInt=0);
    procedure  drawWheel(range, pos:SmallInt);
  end;

  TDrawPanel = class(TPanel);

  //Reports
  TReportCommand = packed record
     reportId: Byte;
     command: Byte;
     arg1,arg2,arg3: SmallInt;
   end;

  TDataReport = packed record
     repType:Byte;
     repIndex:SmallInt;
     data: array [0..27] of Byte;
  end;
  PDataReport=^TDataReport;

  TVersionDataReport = packed record
     id: array [0..5] of Byte;
     ver: array [0..11] of Byte;
  end;
  PVersionDataReport = ^TVersionDataReport;

  TSteeringAxisDataReport = packed record
     rawValue: Integer;
     value: SmallInt;
     range: SmallInt;
     velocity: SmallInt;
     acceleration: SmallInt;
  end;
  PSteeringAxisDataReport = ^TSteeringAxisDataReport;

  TAnalogAxisDataReport = packed record
     rawValue:  SmallInt;
     value:     SmallInt;
     axisMin:   SmallInt;
     axisMax:   SmallInt;
     center:    SmallInt;
     deadZone:  SmallInt;
     autoLimit: Byte;
     hasCenter: Byte;
  end;
  PAnalogAxisDataReport = ^TAnalogAxisDataReport;

  TButtonsDataReport = packed record
     buttons:       Integer;
     centerButton:  ShortInt;
     debounce:      Byte;
  end;
  PButtonsDataReport = ^TButtonsDataReport;

  TGainDataReport = array [0..12] of SmallInt;
  PGainDataReport = ^TGainDataReport;

  TMiscDataReport = packed record
     maxVd:       SmallInt;
     maxVf:       SmallInt;
     maxAcc:      SmallInt;

     minForce:    SmallInt;
     maxForce:    SmallInt;
     cutForce:    SmallInt;

     ffbBD:       Byte;
  end;
  PMiscDataReport = ^TMiscDataReport;

Const

  //device props
  ID_Usage                     =4;
  ID_InputReportByteLength     =32;
  ID_OutputReportByteLength    =18;
  ID_FeatureReportByteLength   =5;

  //report constants
  CMD_REPORT_ID   = 15;
  DATA_REPORT_ID  = 16;

  CMD_GET_VER     = 1;
  CMD_GET_STEER   = 2;
  CMD_GET_ANALOG  = 3;
  CMD_GET_BUTTONS = 4;
  CMD_GET_GAINS   = 5;
  CMD_GET_MISC    = 6;

  CMD_SET_RANGE     = 10;
  CMD_SET_AALIMITS  = 11;
  CMD_SET_AACENTER  = 12;
  CMD_SET_AADZ      = 13;
  CMD_SET_AAAUTOLIM = 14;
  CMD_SET_CENTERBTN = 15;
  CMD_SET_DEBOUNCE  = 16;
  CMD_SET_GAIN      = 17;
  CMD_SET_MISC      = 18;
    MISC_MAXVD    = 0;
    MISC_MAXVF    = 1;
    MISC_MAXACC   = 2;
    MISC_MINF     = 3;
    MISC_MAXF     = 4;
    MISC_CUTF     = 5;
    MISC_FFBBD    = 6;

  CMD_EELOAD  = 20;
  CMD_EESAVE  = 21;
  CMD_DEFAULT = 22;
  CMD_CENTER  = 23;


var
  MainForm: TMainForm;

  currentDataType: Byte=CMD_GET_VER;
  currentDataIndex: Byte=0;


implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var i:Byte;
top:integer;
begin
    makeVisible(false);

    //Create analog axes controls
    top:=axisSteerGrp.Height;
    for I := 0 to 6 do
    begin
      analogAxesFrames[i]:=TAnalogAxisFrame.Create(MainForm);
      analogAxesFrames[i].Align:=alBottom;
      analogAxesFrames[i].Parent:=Axes;
      analogAxesFrames[i].name:='AnalogAxis'+inttostr(i);
      analogAxesFrames[i].Align:=alTop;
      analogAxesFrames[i].axisNum:=I;

      top:=top+analogAxesFrames[i].Height;
      case i of
        0: analogAxesFrames[i].Group.Caption:='Axis #1 (Y - Accelerator)';
        1: analogAxesFrames[i].Group.Caption:='Axis #2 (Z - Brake)';
        2: analogAxesFrames[i].Group.Caption:='Axis #3 (rX - Clutch)';
        3: analogAxesFrames[i].Group.Caption:='Axis #4 (rY - Aux1)';
        4: analogAxesFrames[i].Group.Caption:='Axis #5 (rZ - Aux2)';
        5: analogAxesFrames[i].Group.Caption:='Axis #6 (Slider - Aux3)';
        6: analogAxesFrames[i].Group.Caption:='Axis #7 (Dial - Aux4)';
      end;
    end;
      buttonsGrp.Top:=top;

    //create button states
    for i := 1 to 32 do
    begin

       buttonsState[i]:=TPanel.Create(MainForm);
       buttonsState[i].Parent:=buttonsPanel;
       if i<10 then
         buttonsState[i].Caption:='0'+inttostr(i)
       else
         buttonsState[i].Caption:=inttostr(i);
       centerButton.Items.Add(buttonsState[i].Caption);
       buttonsState[i].width:=19;
       buttonsState[i].height:=20;
       buttonsState[i].BevelOuter:=bvNone;
       buttonsState[i].BorderStyle:=bsSingle;
       buttonsState[i].Ctl3D:=false;
       buttonsState[i].ParentBackground:=false;

       buttonsState[i].left:=((i-1) mod 16)*(buttonsState[i].width+6) + (((i-1) mod 16) div 8)*10;
       buttonsState[i].top:=((i-1) div 16)*(buttonsState[i].height+6);
    end;


    //create gain controls
    for i := 0 to 12 do
    begin
        gainFrames[i]:=TGainFrame.Create(MainForm);
        gainFrames[i].Name:='Gain'+inttostr(i);
        gainFrames[i].Parent:=Gains;
        gainFrames[i].gainIndex:=i;
        case i of
          0: gainFrames[i].title.Caption:='All';
          1: gainFrames[i].title.Caption:='Constant';
          2: gainFrames[i].title.Caption:='Ramp';
          3: gainFrames[i].title.Caption:='Square';
          4: gainFrames[i].title.Caption:='Sine';
          5: gainFrames[i].title.Caption:='Triangle';
          6: gainFrames[i].title.Caption:='Sawtooth Up';
          7: gainFrames[i].title.Caption:='Sawtooth Down';
          8: gainFrames[i].title.Caption:='Spring';
          9: gainFrames[i].title.Caption:='Damper';
          10: gainFrames[i].title.Caption:='Inertia';
          11: gainFrames[i].title.Caption:='Friction';
          12: gainFrames[i].title.Caption:='Endstop';
        end;
    end;

end;

procedure TMainForm.HidCtlDeviceChange(Sender: TObject);
var
  Dev: TJvHidDevice;
  I: Integer;
begin
    for I := 0 to DevList.Items.Count - 1 do
    begin
      Dev := TJvHidDevice(DevList.Items.Objects[I]);
      Dev.Free;
    end;

    DevList.Clear;
    HidCtl.Enumerate;
end;

procedure TMainForm.HidCtlDeviceCreateError(Controller: TJvHidDeviceController;
  PnPInfo: TJvHidPnPInfo; var Handled, RetryCreate: Boolean);
begin
  Handled:=true;
end;

function TMainForm.HidCtlEnumerate(HidDev: TJvHidDevice;
  const Idx: Integer): Boolean;
var
  N: Integer;
  Dev: TJvHidDevice;
begin

  Result := True;

  //draft filtering devices by caps
  if (HidDev.Caps.Usage<>ID_Usage) or
     (HidDev.Caps.InputReportByteLength<>ID_InputReportByteLength) or
     (HidDev.Caps.OutputReportByteLength<>ID_OutputReportByteLength) or
     (HidDev.Caps.FeatureReportByteLength<>ID_FeatureReportByteLength) then
  begin
    Exit;
  end;

  if Assigned(DevList) then
  begin
    if HidDev.ProductName <> '' then
      N := DevList.Items.Add(HidDev.ProductName)
    else
      N := DevList.Items.Add(Format('Device VID=%.4x PID=%.4x',
        [HidDev.Attributes.VendorID, HidDev.Attributes.ProductID]));

    HidCtl.CheckOutByIndex(Dev, Idx);
    DevList.Items.Objects[N] := Dev;
  end;
end;


procedure TMainForm.HidCtlDeviceData(HidDev: TJvHidDevice; ReportID: Byte;
  const Data: Pointer; Size: Word);
var
  I: Integer;
  dataReport: TDataReport;
  versionDataReport: TVersionDataReport;
  steeringAxisDataReport:  TSteeringAxisDataReport;
  analogAxisDataReport:  TAnalogAxisDataReport;
  buttonsDataReport: TButtonsDataReport;
  gainDataReport: TGainDataReport;
  miscDataReport: TMiscDataReport;
  angle: Double;
  analogAxisF: TAnalogAxisFrame;
begin
    //ignore reports with other reportID
    if (ReportID<>DATA_REPORT_ID) then
      Exit;

    dataReport:=PDataReport(Data)^;

    //if device is not selected - auto discovery device with ident string and version
    if ((DevList.ItemIndex=-1) and (dataReport.repType=CMD_GET_VER)) then
    begin
        versionDataReport:=PVersionDataReport(@dataReport.Data)^;

        if PAnsiChar(@versionDataReport.id)='AFFBW' then
        begin
          for i := 0 to DevList.Items.Count-1 do
            if HidDev=DevList.Items.Objects[i] then
              devList.ItemIndex:=i;

          Version.Caption:='FW: '+PAnsiChar(@versionDataReport.ver);

          MakeVisible(true);
        end;

        Exit;
    end;

    //ignore data from other devices
    if HidDev<>DevList.Items.Objects[DevList.ItemIndex] then
      Exit;

    Case dataReport.repType of
        CMD_GET_VER:  begin
           versionDataReport:=PVersionDataReport(@dataReport.Data)^;
           if PAnsiChar(@versionDataReport.id)='AFFBW' then
             Version.Caption:='FW: '+PAnsiChar(@versionDataReport.ver);

        end;
        CMD_GET_STEER:  begin
           steeringAxisDataReport:=PSteeringAxisDataReport(@dataReport.Data)^;
           steerRaw.Text:=IntToStr(steeringAxisDataReport.rawValue);
           steerValue.Text:=inttostr(steeringAxisDataReport.value);
           Velocity.Text:=inttostr(steeringAxisDataReport.velocity);
           Acceleration.Text:=inttostr(steeringAxisDataReport.acceleration);
           if (not steerRange.Focused) then
             steerRange.Text:=inttostr(steeringAxisDataReport.range);

           steerPercent.Caption:=inttostr(round(steeringAxisDataReport.value * 100 / 32768)) + '%';
           if steeringAxisDataReport.value>0 then
             begin
               steerBarVal.Width:=round(steerBar.Width * steeringAxisDataReport.value / 65536);
               steerBarVal.Left:=round(steerBar.Width/2);
             end
             else
             begin
               steerBarVal.Width:=round(-steerBar.Width * steeringAxisDataReport.value / 65536);
               steerBarVal.Left:=round(steerBar.Width/2)-steerBarVal.Width;
             end;

             drawWheel(steeringAxisDataReport.range, steeringAxisDataReport.value);
         end;
      CMD_GET_ANALOG:  begin

           analogAxisF:=analogAxesFrames[dataReport.repIndex];
           analogAxisDataReport:=PAnalogAxisDataReport(@dataReport.Data)^;

           if not analogAxisF.Raw.Focused then
             analogAxisF.Raw.Text:=IntToStr(analogAxisDataReport.rawValue);
           if not analogAxisF.Val.Focused then
             analogAxisF.Val.Text:=IntToStr(analogAxisDataReport.value);
           if not analogAxisF.Min.Focused then
             analogAxisF.Min.Text:=IntToStr(analogAxisDataReport.axisMin);
           if not analogAxisF.Max.Focused then
             analogAxisF.Max.Text:=IntToStr(analogAxisDataReport.axisMax);
           if not analogAxisF.Center.Focused then
             analogAxisF.Center.Text:=IntToStr(analogAxisDataReport.Center);
           if not analogAxisF.DeadZone.Focused then
             analogAxisF.DeadZone.Text:=IntToStr(analogAxisDataReport.deadZone);

           if (analogAxisDataReport.hasCenter=0) then
           begin
             analogAxisF.BarVal.Left:=0;
             analogAxisF.BarVal.Width:=round(analogAxisF.Bar.Width * (analogAxisDataReport.value+32768) / 65536);

             analogAxisF.Percent.Caption:=inttostr(round((analogAxisDataReport.value+32768) * 100 / 65536)) + '%';
           end
           else
           begin
             if analogAxisDataReport.value>0 then
               begin
                 analogAxisF.BarVal.Width:=round(analogAxisF.Bar.Width * analogAxisDataReport.value / 65536);
                 analogAxisF.BarVal.Left:=round(analogAxisF.Bar.Width/2);
               end
               else
               begin
                 analogAxisF.BarVal.Width:=round(-analogAxisF.Bar.Width * analogAxisDataReport.value / 65536);
                 analogAxisF.BarVal.Left:=round(analogAxisF.Bar.Width/2)-analogAxisF.BarVal.Width;
               end;
             analogAxisF.Percent.Caption:=inttostr(round(analogAxisDataReport.value * 100 / 32768)) + '%';
           end;

          if (not analogAxisF.autolimit.Focused) then
            analogAxisF.autolimit.Checked:=(analogAxisDataReport.autoLimit>0);
          if (not analogAxisF.hasCenter.Focused) then
            analogAxisF.hasCenter.Checked:=(analogAxisDataReport.hasCenter>0);

          analogAxisF.Min.ReadOnly:= analogAxisF.autolimit.Checked;
          analogAxisF.Max.ReadOnly:= analogAxisF.autolimit.Checked;
          analogAxisF.Center.Enabled:=analogAxisF.hasCenter.Checked;
          analogAxisF.DeadZone.Enabled:=analogAxisF.hasCenter.Checked;

         end;
      CMD_GET_BUTTONS: begin
           buttonsDataReport:=PButtonsDataReport(@dataReport.Data)^;
           if not centerButton.focused then
              centerButton.ItemIndex:=buttonsDataReport.centerButton+1;
           if not debounce.Focused then
              debounce.Text:=inttostr(buttonsDataReport.debounce);

           for i := 0 to 31 do
             begin
                if (buttonsDataReport.buttons and (1 shl i)) <> 0 then
                   buttonsState[i+1].Color:=clRed
                else
                  if i=buttonsDataReport.centerButton then
                   buttonsState[i+1].Color:=$00F8B963
                  else
                   buttonsState[i+1].Color:=clBtnFace;

             end;

         end;
      CMD_GET_GAINS: begin
           gainDataReport:=PGainDataReport(@dataReport.Data)^;

           for i := 0 to 12 do
           if not(gainFrames[i].Value.Focused or gainFrames[i].TrackBar.Focused) then
             begin
                gainFrames[i].Value.Text:=inttostr(gainDataReport[i]);
                gainFrames[i].Percent.Caption:=inttostr(Round(gainDataReport[i]*100 / 1024))+'%';

                if gainDataReport[i]<=1024 then
                begin
                  gainFrames[i].TrackBar.Position:=round(gainDataReport[i]*500/1024);
                end
                else
                begin
                  gainFrames[i].TrackBar.Position:=500+ round((gainDataReport[i]-1024)*500/(4096 - 1024));
               end;
             end;
         end;
      CMD_GET_MISC:
          begin
              miscDataReport:=PMiscDataReport(@dataReport.Data)^;

              if not maxVD.Focused then
                maxVD.Text:=inttostr(miscDataReport.maxVD);
              if not maxVF.Focused then
                maxVF.Text:=inttostr(miscDataReport.maxVF);
              if not maxAcc.Focused then
                maxAcc.Text:=inttostr(miscDataReport.maxAcc);

              if not (minForce.Focused or minForceTrackbar.Focused) then
              begin
                minForce.Text:=inttostr(miscDataReport.minForce);
                minForcePercent.Caption:=inttostr(round(miscDataReport.minForce*100/16383))+'%';
                minForceTrackbar.Position:=miscDataReport.minForce;
              end;

              if not (maxForce.Focused or maxForceTrackbar.Focused) then
              begin
                maxForce.Text:=inttostr(miscDataReport.maxForce);
                maxForcePercent.Caption:=inttostr(round(miscDataReport.maxForce*100/16383))+'%';
                maxForceTrackbar.Position:=miscDataReport.maxForce;
              end;
              if not (cutForce.Focused or cutForceTrackbar.Focused) then
              begin
                cutForce.Text:=inttostr(miscDataReport.cutForce);
                cutForcePercent.Caption:=inttostr(round(miscDataReport.cutForce*100/16383))+'%';
                cutForceTrackbar.Position:=miscDataReport.cutForce;
              end;

              if not ffbBD.Focused then
                ffbBD.ItemIndex:=miscDataReport.ffbBD-8;
          end;
    end;
end;

procedure TMainForm.DrawWheel(range,pos:SmallInt);
var
  angle: Double;
  cx,cy:  integer;
  radius: integer;

begin

     angle:= (range / 2) *  pos / 32768;

     SteerAngle.Text:=floattostrf(angle,ffFixed,8,2)+'°';

     //SteerPos.Canvas.Brush.Style:=bsClear;
     SteerPos.Canvas.Brush.Color:=SteerPos.Color;
     SteerPos.Canvas.FillRect(SteerPos.ClientRect);

     SteerPos.Canvas.pen.Color:=clBlack;
     SteerPos.Canvas.Pen.Width:=1;
     //
     SteerPos.Canvas.Ellipse(1,1,SteerPos.Width-1,SteerPos.Height-1);

     cx:=round(SteerPos.Width/2);
     cy:=round(SteerPos.Height/2);
     radius:=round(SteerPos.Height/2)-1;


     SteerPos.Canvas.MoveTo(cx, cy);
     SteerPos.Canvas.LineTo(cx + round(radius * Cos(DegToRad(angle-10))), cy + round(radius * Sin(DegToRad(angle-10))));

     SteerPos.Canvas.MoveTo(cx, cy);
     SteerPos.Canvas.LineTo(cx + round(radius * Cos(DegToRad(angle+90))), cy + round(radius * Sin(DegToRad(angle+90))));

     SteerPos.Canvas.MoveTo(cx, cy);
     SteerPos.Canvas.LineTo(cx + round(radius * Cos(DegToRad(angle+180+10))), cy + round(radius * Sin(DegToRad(angle+180+10))));

end;


procedure TMainForm.HidCtlDeviceUnplug(HidDev: TJvHidDevice);
var
  i, n:integer;
begin
    n:=-1;
    for I := 0 to DevList.Items.Count - 1 do
    begin
      if HidDev=TJvHidDevice(DevList.Items.Objects[I]) then
          n:=i;
    end;

    if n>=0 then
    begin
       if DevList.ItemIndex=n then
       begin
          DevList.ItemIndex:=-1;
          MakeVisible(false);
       end;
       DevList.Items.Delete(n) ;
    end;

end;

procedure TMainForm.updateTimerTimer(Sender: TObject);
var
  Dev: TJvHidDevice;
  I: Integer;

  repCmd: TReportCommand;
  ToWrite, Written:Cardinal;
begin


 if DevList.ItemIndex=-1 then
 begin
    repCmd.reportId:=CMD_REPORT_ID;
    repCmd.command:=CMD_GET_VER;

    if DevList.Items.Count > 0 then
    for I := 0 to DevList.Items.Count - 1 do
    begin
        Dev := TJvHidDevice(DevList.Items.Objects[I]);
        ToWrite:=Dev.Caps.OutputReportByteLength;
        Dev.WriteFile(repCmd, ToWrite, Written);
    end;

    Exit;
  end;

  sendCommand(currentDataType, currentDataIndex);

  case currentDataType of
    CMD_GET_VER   :  currentDataType:=CMD_GET_STEER;
    CMD_GET_STEER   :  currentDataType:=CMD_GET_ANALOG;
    CMD_GET_ANALOG  :
      begin
        inc(currentDataIndex);
        if currentDataIndex>6 then
        begin
          currentDataType:=CMD_GET_BUTTONS;
          currentDataIndex:=0;
        end;
      end;
    CMD_GET_BUTTONS :  currentDataType:=CMD_GET_GAINS;
    CMD_GET_GAINS   :  currentDataType:=CMD_GET_MISC;
    CMD_GET_MISC    :  currentDataType:=CMD_GET_VER;
  end;
end;


procedure TMainForm.makeVisible(visible:boolean);
begin
  PageControl.Visible:=visible;
  Version.Visible:=visible;
  loadEE.Enabled:=visible;
  saveEE.Enabled:=visible;
  loadDefaults.Enabled:=visible;
end;

procedure  TMainForm.sendCommand(command:Byte;arg1,arg2,arg3:SmallInt);
var
  repCmd: TReportCommand;
  Written: Cardinal;
  Dev: TJvHidDevice;
begin

    if DevList.ItemIndex=-1 then
      Exit;

    if not Assigned(DevList.Items.Objects[DevList.ItemIndex]) then
      Exit;


    Dev:=TJvHidDevice(DevList.Items.Objects[DevList.ItemIndex]);

    repCmd.reportId:=CMD_REPORT_ID;
    repCmd.command:=command;
    repCmd.arg1:=arg1;
    repCmd.arg2:=arg2;
    repCmd.arg3:=arg3;

    Dev.WriteFile(repCmd, Dev.Caps.OutputReportByteLength, Written);
end;

//data change/save----------------------------------------------------------------------------------------

procedure TMainForm.centerButtonSelect(Sender: TObject);
begin
   sendCommand(CMD_SET_CENTERBTN, centerButton.ItemIndex-1);
end;

procedure TMainForm.cutForceChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;

    if TryStrToInt(cutForce.Text, val) then
    if (val>=0) and (val<16383) then
      sendCommand(CMD_SET_MISC, MISC_CUTF, val);
end;

procedure TMainForm.cutForceTrackbarChange(Sender: TObject);
begin
  if not TWinControl(Sender).Focused then Exit;

  cutForce.Text:=inttostr(cutForceTrackbar.Position);
  cutForcePercent.Caption:=inttostr(Round(cutForceTrackbar.Position*100 / 16384))+'%';

  sendCommand(CMD_SET_MISC, MISC_CUTF, cutForceTrackbar.Position);

end;

procedure TMainForm.debounceChange(Sender: TObject);
var
  val:Integer;
begin
   if not TWinControl(Sender).Focused then Exit;

    if TryStrToInt(debounce.Text, val) then
    if (val>=0) and (val<255) then
      sendCommand(CMD_SET_DEBOUNCE, val);
end;

procedure TMainForm.devListSelect(Sender: TObject);
begin
   MakeVisible(DevList.ItemIndex<>-1);
end;

procedure TMainForm.ffbBDSelect(Sender: TObject);
begin
    sendCommand(CMD_SET_MISC, MISC_FFBBD, ffbBD.ItemIndex+8);
end;


procedure TMainForm.saveEEClick(Sender: TObject);
begin
  sendCommand(CMD_EESAVE);
end;

procedure TMainForm.steerCenterClick(Sender: TObject);
begin
   sendCommand(CMD_CENTER);
end;

procedure TMainForm.steerRangeSelect(Sender: TObject);
begin
  sendCommand(CMD_SET_RANGE, strtoint(steerRange.Text));
end;

procedure TMainForm.loadDefaultsClick(Sender: TObject);
begin
    sendCommand(CMD_DEFAULT);
end;

procedure TMainForm.loadEEClick(Sender: TObject);
begin
    sendCommand(CMD_EELOAD);
end;

procedure TMainForm.maxAccChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;

    if TryStrToInt(maxAcc.Text, val) then
    if (val>=0) and (val<32767) then
      sendCommand(CMD_SET_MISC, MISC_MAXACC, val);
end;

procedure TMainForm.maxForceChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;

    if TryStrToInt(maxForce.Text, val) then
    if (val>=0) and (val<16383) then
      sendCommand(CMD_SET_MISC, MISC_MAXF, val);
end;

procedure TMainForm.maxForceTrackbarChange(Sender: TObject);
begin
  if not TWinControl(Sender).Focused then Exit;

  maxForce.Text:=inttostr(maxForceTrackbar.Position);
  maxForcePercent.Caption:=inttostr(Round(maxForceTrackbar.Position*100 / 16384))+'%';

  sendCommand(CMD_SET_MISC, MISC_MAXF, maxForceTrackbar.Position);
end;

procedure TMainForm.maxVDChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;

    if TryStrToInt(maxVD.Text, val) then
    if (val>=0) and (val<32767) then
      sendCommand(CMD_SET_MISC, MISC_MAXVD, val);
end;

procedure TMainForm.maxVFChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;

   if TryStrToInt(maxVF.Text, val) then
    if (val>=0) and (val<32767) then
      sendCommand(CMD_SET_MISC, MISC_MAXVF, val);

end;

procedure TMainForm.minForceChange(Sender: TObject);
var
  val:integer;
begin
  if not TWinControl(Sender).Focused then Exit;

    if TryStrToInt(minForce.Text, val) then
    if (val>=0) and (val<16383) then
      sendCommand(CMD_SET_MISC, MISC_MINF, val);
end;

procedure TMainForm.minForceTrackbarChange(Sender: TObject);
begin
  if not TWinControl(Sender).Focused then Exit;

  minForce.Text:=inttostr(minForceTrackbar.Position);
  minForcePercent.Caption:=inttostr(Round(minForceTrackbar.Position*100 / 16384))+'%';

  sendCommand(CMD_SET_MISC, MISC_MINF, minForceTrackbar.Position);
end;



end.
