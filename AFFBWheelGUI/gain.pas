unit gain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TGainFrame = class(TFrame)
    TrackBar: TTrackBar;
    Value: TEdit;
    Title: TLabel;
    Percent: TLabel;
    procedure TrackBarChange(Sender: TObject);
    procedure ValueChange(Sender: TObject);
  private
    { Private declarations }
  public
    gainIndex:Byte;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  MainFormUnit;


procedure TGainFrame.TrackBarChange(Sender: TObject);
var
  pos:integer;
begin
  if not TWinControl(Sender).Focused then Exit;
  if (TrackBar.Position<=500) then
      pos:=round(TrackBar.Position*1024/500)
  else
      pos:=1024+round((TrackBar.Position-500)*(4096-1024)/500);

  Value.Text:=inttostr(pos);
  Percent.Caption:=inttostr(Round(pos*100 / 1024))+'%';

  MainForm.sendCommand(CMD_SET_GAIN, gainIndex, pos);
end;

procedure TGainFrame.ValueChange(Sender: TObject);
var
  val:Integer;
begin
  if not TWinControl(Sender).Focused then Exit;

   if TryStrToInt(Value.Text, val) then
    if (val>=0) and (val<16383) then
      MainForm.sendCommand(CMD_SET_GAIN, gainIndex, val);

end;

end.
