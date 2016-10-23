unit Settings;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TFrmSettings = class(TForm)
    Label1: TLabel;
    LblStat: TLabel;
    GroupBox: TGroupBox;
    EdtPassword: TEdit;
    EdtNewPassw: TEdit;
    BtnChange: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LblDriv: TLabel;
    Label7: TLabel;
    LblData: TLabel;
    Label9: TLabel;
    LblDate: TLabel;
    Label11: TLabel;
    LblSize: TLabel;
    Panel: TPanel;
    BtnConnect: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnChangeClick(Sender: TObject);
    procedure BtnConnectClick(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure UpdateInfo;
  public
    { Public-Deklarationen }
  end;

var
  FrmSettings: TFrmSettings;

implementation

{$R *.fmx}

uses DataModule;

function FileSize(Path : String) : Int64;
var
  SR: TSearchRec;
begin
  if FindFirst(Path, faAnyFile, SR) = 0 then
  begin
  {$IFDEF MSWINDOWS}
     Result := Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(SR.FindData.nFileSizeLow)
  {$ELSE}
     Result := SR.Size
  {$ENDIF}
  end
  else
    Result := -1;
  FindClose(SR);
end;

procedure TFrmSettings.UpdateInfo;
begin
  LblStat.Text := DM.FDSQLiteSecurity.CheckEncryption;
  LblDriv.Text := DM.FDConnection.ActualDriverID;
  LblData.Text := DM.FDConnection.Params.Database;
  LblDate.Text := FormatDateTime('DD.MM.YYYY', DM.FDConnection.LastUsed);
  LblSize.Text := IntToStr(FileSize(DM.FDConnection.Params.Database));
end;

procedure TFrmSettings.BtnChangeClick(Sender: TObject);
begin
  DM.FDSQLiteSecurity.Database := DM.FDConnection.Params.Database;
  DM.FDSQLiteSecurity.Password := EdtPassword.Text;
  if EdtNewPassw.Text = '' then
  begin
    DM.FDSQLiteSecurity.RemovePassword;
  end
  else
  begin
    DM.FDSQLiteSecurity.ToPassword := EdtNewPassw.Text;
    DM.FDSQLiteSecurity.ChangePassword;
  end;
  UpdateInfo;
end;

procedure TFrmSettings.BtnConnectClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFrmSettings.FormShow(Sender: TObject);
begin
  UpdateInfo;
end;

end.
