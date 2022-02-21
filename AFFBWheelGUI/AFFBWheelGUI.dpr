program AFFBWheelGUI;

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  analogAxis in 'analogAxis.pas' {AnalogAxisFrame: TFrame},
  gain in 'gain.pas' {GainFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'AFFBWheel settings';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
