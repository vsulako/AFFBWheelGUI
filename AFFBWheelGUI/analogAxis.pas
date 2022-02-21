unit analogAxis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.Samples.Gauges;

type
  TAnalogAxisFrame = class(TFrame)
    Group: TGroupBox;
    Max: TLabeledEdit;
    Center: TLabeledEdit;
    autoLimit: TCheckBox;
    DeadZone: TLabeledEdit;
    Min: TLabeledEdit;
    Bar: TPanel;
    hasCenter: TCheckBox;
    Val: TLabeledEdit;
    Raw: TLabeledEdit;
    setMin: TButton;
    setMax: TButton;
    setCenter: TButton;
    BarVal: TPanel;
    Percent: TLabel;
    procedure setMinClick(Sender: TObject);
    procedure setMaxClick(Sender: TObject);
    procedure setCenterClick(Sender: TObject);
    procedure MinChange(Sender: TObject);
    procedure MaxChange(Sender: TObject);
    procedure autoLimitClick(Sender: TObject);
    procedure hasCenterClick(Sender: TObject);
    procedure CenterChange(Sender: TObject);
    procedure DeadZoneChange(Sender: TObject);
  private
    { Private declarations }
  public
    axisNum:Byte;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  MainFormUnit;

procedure TAnalogAxisFrame.autoLimitClick(Sender: TObject);
begin

    if not autoLimit.Focused then
      Exit;

    if autoLimit.Checked then
      MainForm.sendCommand(CMD_SET_AAAUTOLIM, axisNum, 1)
    else
      MainForm.sendCommand(CMD_SET_AAAUTOLIM, axisNum, 0);

end;

procedure TAnalogAxisFrame.CenterChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;

    if TryStrToInt(center.Text, val) then
    if (val>=-32767) and (val<32767) and (val<strtoint(Max.text)) and (val>strtoint(Min.Text))  then
      MainForm.sendCommand(CMD_SET_AACENTER, axisNum, val);
end;

procedure TAnalogAxisFrame.DeadZoneChange(Sender: TObject);
var
  val:Integer;
begin
    if not TWinControl(Sender).Focused then Exit;
    if TryStrToInt(DeadZone.Text, val) then
    if (val>=-32767) and (val<32767) then
      MainForm.sendCommand(CMD_SET_AADZ, axisNum, val);
end;

procedure TAnalogAxisFrame.hasCenterClick(Sender: TObject);
begin

   if not hasCenter.Focused then
      Exit;

    if hasCenter.Checked then
      MainForm.sendCommand(CMD_SET_AACENTER, axisNum, strtoint(Center.Text))
    else
      MainForm.sendCommand(CMD_SET_AACENTER, axisNum, -32768);

end;

procedure TAnalogAxisFrame.MaxChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;

    if TryStrToInt(Max.Text, val) then
    if (val>=-32767) and (val<32767) then
    if val>=strtoint(Min.Text) then
      MainForm.sendCommand(CMD_SET_AALIMITS, axisNum, strtoint(Min.Text), val);
end;

procedure TAnalogAxisFrame.MinChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;
    if TryStrToInt(Min.Text, val) then
    if (val>=-32767) and (val<32767) then
    if val<=strtoint(Max.Text) then
      MainForm.sendCommand(CMD_SET_AALIMITS, axisNum, val, strtoint(Max.Text));
end;





procedure TAnalogAxisFrame.setCenterClick(Sender: TObject);
begin
  if (strtoint(Raw.Text)<strtoint(Max.Text)) and (strtoint(Raw.Text)>strtoint(Min.Text)) then
     MainForm.sendCommand(CMD_SET_AACENTER, axisNum, strtoint(Raw.Text));
end;

procedure TAnalogAxisFrame.setMaxClick(Sender: TObject);
begin
  if strtoint(Min.Text)<strtoint(Raw.Text) then
    MainForm.sendCommand(CMD_SET_AALIMITS, axisNum, strtoint(Min.Text), strtoint(Raw.Text));
end;

procedure TAnalogAxisFrame.setMinClick(Sender: TObject);
begin
  if strtoint(Raw.Text)<strtoint(Max.Text) then
    MainForm.sendCommand(CMD_SET_AALIMITS, axisNum, strtoint(Raw.Text), strtoint(Max.Text));
end;

end.
