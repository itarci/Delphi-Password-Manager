unit Info;

interface

uses

{$IFDEF ANDROID}
  Androidapi.JNI.GraphicsContentViewText, Androidapi.helpers,
{$ENDIF}

{$IFDEF MACOS}
  Macapi.CoreFoundation,
  {$IFNDEF IOS}
    Macapi.Foundation,
  {$ENDIF nIOS}
  {$IFDEF IOS}
    iOSapi.Foundation,
  {$ENDIF IOS}
{$ENDIF MACOS}

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, IdURI, FMX.Objects, FMX.Layouts, FMX.ExtCtrls;

type
  TFrmInfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Line1: TLine;
    Label8: TLabel;
    Label9: TLabel;
    Image1: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Line2: TLine;
    Label13: TLabel;
    Label14: TLabel;
    Panel: TPanel;
    BtnConnect: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabelMouseLeave(Sender: TObject);
    procedure LabelMouseEnter(Sender: TObject);
    procedure LabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure LabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmInfo: TFrmInfo;

implementation

{$R *.fmx}

uses DataModule;

procedure TFrmInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFrmInfo.FormCreate(Sender: TObject);
{$IFDEF MSWINDOWS}
var
  Rec: LongRec;
{$ENDIF}

{$IFDEF ANDROID}
var
  PackageManager: JPackageManager;
  PackageInfo: JPackageInfo;
{$ENDIF}

{$IF Defined(MACOS) and not Defined(IOS)}
var
  CFStr: CFStringRef;
  Range: CFRange;
  sEdit: string;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  Rec := LongRec(GetFileVersion(ParamStr(0)));
  Label14.Text := Format('%d.%d', [Rec.Hi, Rec.Lo])
{$ENDIF}

{$IFDEF ANDROID}
  PackageManager := SharedActivity.getPackageManager;
  PackageInfo := PackageManager.getPackageInfo(SharedActivityContext.getPackageName(), TJPackageManager.JavaClass.GET_ACTIVITIES);
  Label14.Text := JStringToString(PackageInfo.versionName);
{$ENDIF}

{$IFDEF IOS}
  Label14.Text :=  TNSString.Wrap(CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle, kCFBundleVersionKey)).UTF8String;
{$ENDIF}

{$IF Defined(MACOS) and not Defined(IOS)}
  CFStr := CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle, kCFBundleVersionKey);
  Range.location := 0;
  Range.length := CFStringGetLength(CFStr);
  SetLength(sEdit, Range.length);
  CFStringGetCharacters(CFStr, Range, PChar(sEdit));
  Label14.Text := sEdit;
{$ENDIF}
end;

procedure TFrmInfo.LabelClick(Sender: TObject);
begin
  DM.LaunchBrowser(TLabel(sender).Text);
end;

procedure TFrmInfo.LabelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  TLabel(Sender).TextSettings.FontColor := TAlphaColors.Blueviolet;
end;

procedure TFrmInfo.LabelMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Cursor := crHandPoint;
  TLabel(Sender).StyledSettings := TLabel(Sender).StyledSettings - [TStyledSetting.FontColor];
  TLabel(Sender).StyledSettings := TLabel(Sender).StyledSettings - [TStyledSetting.Style];
  TLabel(Sender).TextSettings.Font.Style := TLabel(Sender).TextSettings.Font.Style + [TFontStyle.fsUnderline];
  TLabel(Sender).TextSettings.FontColor := TAlphaColors.Blue;
end;

procedure TFrmInfo.LabelMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Cursor := crDefault;
  TLabel(Sender).StyledSettings := TLabel(Sender).StyledSettings + [TStyledSetting.FontColor];
  TLabel(Sender).StyledSettings := TLabel(Sender).StyledSettings - [TStyledSetting.Style];
  TLabel(Sender).TextSettings.Font.Style := TLabel(Sender).TextSettings.Font.Style - [TFontStyle.fsUnderline];
  TLabel(Sender).TextSettings.FontColor := TAlphaColors.Black;
end;

end.
