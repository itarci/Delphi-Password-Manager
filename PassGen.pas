unit PassGen;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.NumberBox, FMX.EditBox, FMX.SpinBox,
  FMX.Platform;

type
  TCharacterSet = set of (pmUpper, pmLower, pmNumbers, pmSpecial);

type
  TFrmPassGen = class(TForm)
    EdtResul: TEdit;
    GrbCharacter: TGroupBox;
    ChbLower: TCheckBox;
    ChbUpper: TCheckBox;
    ChbNumbe: TCheckBox;
    ChbSpeci: TCheckBox;
    GrbLength: TGroupBox;
    SpbLengt: TSpinBox;
    Panel: TPanel;
    BtnGener: TButton;
    BtnCancel: TButton;
    BtnAccept: TButton;
    Label1: TLabel;
    procedure BtnGenerClick(Sender: TObject);
    procedure ChbPModeClick(Sender: TObject);
    procedure ChbSpeciClick(Sender: TObject);
    procedure BtnAcceptClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    function GenPassword(iLength: integer; Mode: TCharacterSet):string;
  public
    { Public-Deklarationen }
  end;

var
  FrmPassGen: TFrmPassGen;

implementation

{$R *.fmx}

procedure TFrmPassGen.ChbPModeClick(Sender: TObject);
begin
  BtnGener.Enabled := ChbLower.IsChecked or ChbUpper.IsChecked or
    ChbNumbe.IsChecked or ChbSpeci.IsChecked;
end;

procedure TFrmPassGen.ChbSpeciClick(Sender: TObject);
begin
  ChbSpeci.OnClick := nil;
  ChbSpeci.OnChange := nil;
end;

procedure TFrmPassGen.FormShow(Sender: TObject);
begin
  BtnGener.OnClick(Self);
end;

function TFrmPassGen.GenPassword(iLength: integer; Mode: TCharacterSet):string;
const
  cLower   = 'abcdefghijklmnopqrstuvwxyz';
  cUpper   = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  cNumbers = '0123456789';
  cSpecial = '°!"§$&/()=-+*?ß}{][@.,;:_~';
var
  i : Integer;
  S : string;
  iM: BYTE;
begin
  if Mode = [] then Exit;
  i := 0;
  Randomize;
  while (i < iLength)  do
  begin
    iM := Random(4);
    case iM of
      0: if (pmLower in Mode) then
         begin
           S := S + cLower[1 + Random(Length(cLower)-1)];
           Inc(i);
         end;
      1: if (pmUpper in Mode) then
         begin
          S := S + cUpper[1 + Random(Length(cUpper)-1)];
          Inc(i);
         end;
      2: if (pmNumbers in Mode) then
         begin
           S := S + cNumbers[1 + Random(Length(cNumbers)-1)];
           Inc(i);
         end;
      3: if (pmSpecial in Mode) then
         begin
           S := S + cSpecial[1 + Random(Length(cSpecial)-1)];
           Inc(i);
         end;
    end;
  end;
  Result := S;
end;

procedure TFrmPassGen.BtnAcceptClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPassGen.BtnGenerClick(Sender: TObject);
var
  Mode: TCharacterSet;
begin
  Mode := [];
  if ChbLower.IsChecked then
    Mode := Mode + [pmLower];
  if ChbUpper.IsChecked then
    Mode := Mode + [pmUpper];
  if ChbNumbe.IsChecked then
    Mode := Mode + [pmNumbers];
  if ChbSpeci.IsChecked then
    Mode := Mode + [pmSpecial];

  EdtResul.Text := GenPassword(StrToInt(SpbLengt.Text), Mode);
end;

end.

