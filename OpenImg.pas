unit OpenImg;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.IOUtils, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmOpenImg = class(TForm)
    LbxDateiList: TListBox;
    StyleBook: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure LbxDateiListItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    sDateiName: String;
  end;

var
  FrmOpenImg: TFrmOpenImg;

implementation

{$R *.fmx}

procedure TFrmOpenImg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ModalResult := mrOk;
  Action := TCloseAction.caFree;
end;

procedure TFrmOpenImg.FormCreate(Sender: TObject);
  var
  DirArraySize, i : Integer;
  DirArray : TStringDynArray;
  ListItem : TListBoxItem;
  Size: TSizeF;
begin
  LbxDateiList.BeginUpdate;
  DirArray := TDirectory.GetFiles(TPath.GetDocumentsPath);
  DirArraySize := Length(DirArray);
  Size.Width := 32;
  Size.Height := 32;
  for i := 0 to DirArraySize-1 do
  begin
    ListItem := TListBoxItem.Create(LbxDateiList);
    //ListItem.StyleLookup := 'listboxitemrightdetail';
    ListItem.text := ExtractFileName(DirArray[i]);
    if ExtractFileExt(DirArray[i]) = '.png' then
      ListItem.ItemData.Bitmap.LoadFromFile(DirArray[i]);
    ListItem.Parent := LbxDateiList;
  end;
  LbxDateiList.EndUpdate;
end;

procedure TFrmOpenImg.LbxDateiListItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
  sDateiName := TPath.Combine(TPath.GetDocumentsPath, Item.Text);
  Close;
end;

end.
