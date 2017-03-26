unit Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Edit, FMX.StdCtrls, FMX.Objects, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, System.IOUtils, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.ResStrs, FMX.VirtualKeyboard, FMX.Platform, FireDAC.Stan.Error;

type
  TFrmLogin = class(TForm)
    ToolBar: TToolBar;
    Panel: TPanel;
    BtnConnect: TButton;
    BtnCancel: TButton;
    Image: TImage;
    LblPassword: TLabel;
    EdtPassword: TEdit;
    PebPasVie: TPasswordEditButton;
    LblLogin: TLabel;
    LblChoose: TLabel;
    procedure BtnConnectClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    iTimesLogi: integer;
    bConnected, bEncrypted: Boolean;
  public
    { Public-Deklarationen }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

uses DataModule, EntryList;

procedure TFrmLogin.BtnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmLogin.BtnConnectClick(Sender: TObject);
begin
  iTimesLogi := iTimesLogi + 1;
  try
    if not DM.FDConnection.Connected then
    begin
      if bEncrypted then
        DM.FDConnection.Params.Password := EdtPassword.Text
      else
        DM.FDConnection.Params.NewPassword := EdtPassword.Text;
      DM.FDConnection.Connected := true;
      bConnected := true;
      if DM.FDConnection.Connected then
      begin
        FrmEntryList := TFrmEntryList.Create(Application);
        FrmEntryList.Show;
        Application.MainForm := FrmEntryList;
        DM.FDQuEntry.Active := true;
        DM.FDQuEntry.UpdateOptions.ReadOnly := true;
        FrmEntryList.SpbDelete.Visible := DM.FDQuEntry.RecordCount > 0;
      end;
      Close;
    end;
  except
    on E: EAbort do
      begin

      end; // user pressed Cancel button in Login dialog
    on E: EFDDBEngineException do
    begin
      Showmessage(E.Errors[0].Message);
      EdtPassword.Text := '';
      EdtPassword.SetFocus;
      if iTimesLogi = 3 then
        Application.Terminate
      else
        Abort;
    end;
  end;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  iTimesLogi := 0;
  bConnected := false;
  DM.FDConnection.Params.Values['Database'] := 'PassList.s3db';
  {$IF DEFINED(iOS) or DEFINED(ANDROID) or DEFINED(MacOS)}
    DM.FDConnection.Params.Values['Database'] :=
      TPath.Combine(TPath.GetSharedDocumentsPath, 'PassList.s3db');
  {$ENDIF}
  DM.FDSQLiteSecurity.Database := DM.FDConnection.Params.Database;
end;

procedure TFrmLogin.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    Key := vkTab;
    KeyDown(Key, KeyChar, Shift);
    BtnConnectClick(Self);
  end;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
var
  sStatus: string;
begin
  sStatus := DM.FDSQLiteSecurity.CheckEncryption;
  if sStatus = '<unencrypted>' then
  begin
    bEncrypted := false;
    LblChoose.Visible := true;
    LblPassword.Text := Translate('New password');
    EdtPassword.Position.X := LblPassword.Width + 14;
  end
  else
    bEncrypted := true;
end;

end.
