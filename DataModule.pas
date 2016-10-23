unit DataModule;

interface

uses

{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows,
{$ENDIF MSWINDOWS}

{$IFDEF ANDROID}
  Androidapi.Helpers, FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
{$ENDIF ANDROID}

{$IFDEF MACOS}
  Macapi.Helpers,
  {$IFNDEF IOS}
    Macapi.Foundation, Macapi.AppKit, MacApi.CoreFoundation, MacApi.CoreGraphics,
    MacApi.KeyCodes, MacApi.CocoaTypes,
  {$ENDIF nIOS}
  {$IFDEF IOS}
    iOSapi.Foundation, FMX.Helpers.iOS, IdURI,
  {$ENDIF IOS}
{$ENDIF MACOS}

  System.SysUtils, System.Classes, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FireDAC.Stan.Intf, FireDAC.FMXUI.Login, FireDAC.Comp.Client, fmx.dialogs,
  FMX.Types, System.UITypes;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQuEntry: TFDQuery;
    dsEntry: TDataSource;
    FDSQLiteSecurity: TFDSQLiteSecurity;
    FDPhysSQLiteDriverLink: TFDPhysSQLiteDriverLink;
    FDGUIxLoginDialog: TFDGUIxLoginDialog;
    FDQuEntryTitle: TStringField;
    FDQuEntryIcon: TBlobField;
    FDQuEntryUserN: TStringField;
    FDQuEntryPassw: TStringField;
    FDQuEntryURLpa: TStringField;
    FDQuEntryNotes: TStringField;
    FDQuEntryDateC: TDateField;
    FDQuEntryDelete: TFDQuery;
    Lang: TLang;
    procedure FDQuEntryNewRecord(DataSet: TDataSet);
    procedure FDConnectionAfterConnect(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure LaunchBrowser(sURL: String);
    { Public-Deklarationen }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.FDConnectionAfterConnect(Sender: TObject);
begin
  FDConnection.ExecSQL(
  'CREATE TABLE IF NOT EXISTS ENTRY( '+
    'Title VARCHAR2(60) NOT NULL, '+
    'UserN VARCHAR2(40), '+
    'Passw CHAR(64) NOT NULL, '+
    'URLpa VARCHAR2(100), '+
    'NickN VARCHAR2(20), '+
    'CustN VARCHAR2(20), '+
    'Notes VARCHAR2(400), '+
    'DateC DATE, '+
    'Icon IMAGE)');
end;

procedure TDM.FDQuEntryNewRecord(DataSet: TDataSet);
begin
  FDQuEntry.FieldByName('DateC').AsDateTime := Now;
end;

procedure TDM.LaunchBrowser(sURL: String);
{$IFDEF ANDROID}
var
  Intent: JIntent;
{$ENDIF ANDROID}

{$IFDEF IOS}
var
  URL: NSUrl;
{$ENDIF IOS}

{$IF Defined(MACOS) and not Defined(IOS)}
var
  URL: NSUrl;
  Workspace: NSWorkspace;
{$ENDIF MacOS}
begin
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PChar(sURL), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}

{$IFDEF ANDROID}
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(StrToJURI(sURL));
  TAndroidHelper.Activity.startActivity(Intent);
{$ENDIF ANDROID}

{$IFDEF IOS}
  URL := StrToNSUrl(TIdURI.URLEncode(sURL));
  if SharedApplication.canOpenURL(URL) then
    SharedApplication.openUrl(URL);
{$ENDIF IOS}

{$IF Defined(MACOS) and not Defined(IOS)}
  URL := TNSURL.Wrap(TNSURL.OCClass.URLWithString(StrToNSStr(sURL)));
  Workspace := TNSWorkspace.Wrap(TNSWorkspace.OCClass.sharedWorkspace);
  Workspace.openURL(URL);
{$ENDIF MacOS}
end;

end.
