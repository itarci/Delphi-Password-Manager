program PassList;

uses
  FMX.Forms,
  FMX.Styles,
  EntryList in 'EntryList.pas' {FrmEntryList},
  DataModule in 'DataModule.pas' {DM: TDataModule},
  OpenImg in 'OpenImg.pas' {FrmOpenImg},
  Settings in 'Settings.pas' {FrmSettings},
  Info in 'Info.pas' {FrmInfo},
  PassGen in 'PassGen.pas' {FrmPassGen},
  Login in 'Login.pas' {FrmLogin},
  VirtualKeying.Mac in 'VirtualKeying.Mac.pas',
  VirtualKeying in 'VirtualKeying.pas',
  VirtualKeying.Consts in 'VirtualKeying.Consts.pas',
  VirtualKeying.Win in 'VirtualKeying.Win.pas';

{$R *.res}

begin
  //TStyleManager.SetStyleFromFile('C:\RADStudio\FM_PremiumStylePack_Seattle\Win\EmeraldDark.style');
  //TStyleManager.UpdateScenes;
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.

