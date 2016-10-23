{*******************************************************}
{                                                       }
{                                                       }
{                                                       }
{ 2015 Itarci José Possamai                             }
{                                                       }
{*******************************************************}

unit EntryList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, FMX.TabControl, FMX.Layouts, FMX.Controls.Presentation,
  FMX.StdCtrls, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Math,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.Components, FMX.Effects,
  Data.Bind.DBScope, FMX.DateTimeCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit,
  FMX.ListView.Types, FMX.ListView, FMX.VirtualKeyboard, FMX.Objects,
  FMX.Platform, System.Actions, FMX.ActnList, FMX.ListBox, FMX.SearchBox,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ImgList,
  FMX.Gestures, System.ImageList, FMX.Ani, System.IOUtils, Data.DB,

{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows, FMX.DialogService.Sync
{$ENDIF MSWINDOWS}

{$IFDEF ANDROID}
  Androidapi.Helpers, FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes,
  FMX.DialogService.aSync
{$ENDIF ANDROID}

{$IFDEF IOS}
  Macapi.Helpers, iOSapi.Foundation, FMX.Helpers.iOS,
  FMX.DialogService.aSync
{$ENDIF IOS}

{$IF Defined(MACOS) and not Defined(IOS)}
  Macapi.Helpers, Macapi.Foundation,  Macapi.AppKit, FMX.DialogService.Sync
{$ENDIF}
  ;

type
  TFrmEntryList = class(TForm)
    ToolBar: TToolBar;
    VertScrollBox: TVertScrollBox;
    TabControl: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    BindSourceDB: TBindSourceDB;
    BindingsList: TBindingsList;
    ListView: TListView;
    LblTitle: TLabel;
    LblIcon: TLabel;
    ImcIcon: TImageControl;
    EdtTitel: TEdit;
    LblUserN: TLabel;
    EdtUserN: TEdit;
    CebUser: TClearEditButton;
    LblPassw: TLabel;
    EdtPassw: TEdit;
    LblURLpa: TLabel;
    EdtURL: TEdit;
    CebURL: TClearEditButton;
    LblNotes: TLabel;
    EdtNotes: TMemo;
    LblDateC: TLabel;
    DteDateC: TDateEdit;
    Layout: TLayout;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkControlToField6: TLinkControlToField;
    LinkControlToField9: TLinkControlToField;
    ActionList: TActionList;
    NextTabAction: TNextTabAction;
    PreviousTabAction: TPreviousTabAction;
    ChangeTabAction: TChangeTabAction;
    SpbMenu: TSpeedButton;
    OverflowMenu: TListBox;
    LbiSettings: TListBoxItem;
    LbiInfo: TListBoxItem;
    LblToolBar: TLabel;
    EdbPassw: TEditButton;
    StyleBook: TStyleBook;
    SbtCopUsr: TSpeedButton;
    SbtCopPss: TSpeedButton;
    ImageList: TImageList;
    SbtLauBro: TSpeedButton;
    GestureManager: TGestureManager;
    CirAdd: TCircle;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    CirEdi: TCircle;
    ShadowEffect3: TShadowEffect;
    SpbSave: TSpeedButton;
    Glyph1: TGlyph;
    SpbCancel: TSpeedButton;
    Glyph2: TGlyph;
    SpbDelete: TSpeedButton;
    Glyph3: TGlyph;
    SpbRet: TSpeedButton;
    Glyph4: TGlyph;
    RetPopup: TRectangle;
    FAnPopup: TFloatAnimation;
    ShEPopup: TShadowEffect;
    EdbPasGen: TEditButton;
    procedure ImcIconChange(Sender: TObject);
    procedure ImcIconClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure SpbMenuClick(Sender: TObject);
    procedure LbiSettingsClick(Sender: TObject);
    procedure LbiInfoClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdbPasswClick(Sender: TObject);
    procedure SbtCopUsrClick(Sender: TObject);
    procedure SbtCopPssClick(Sender: TObject);
    procedure SbtLauBroClick(Sender: TObject);
    procedure CirAddClick(Sender: TObject);
    procedure CirEdiClick(Sender: TObject);
    procedure SpbSaveClick(Sender: TObject);
    procedure SpbCancelClick(Sender: TObject);
    procedure SpbDeleteClick(Sender: TObject);
    procedure ListViewItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure SpbRetClick(Sender: TObject);
    procedure ListViewItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListViewClick(Sender: TObject);
    procedure ListViewMouseEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdbPasGenClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FService : IFMXVirtualKeyboardToolbarService;
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    procedure CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
    procedure UpdateButton(nStatus: integer);
  public
    { Public-Deklarationen }
    procedure ShowPopup;
    procedure HidePopup;
  end;

var
  FrmEntryList: TFrmEntryList;

implementation

{$R *.fmx}

uses DataModule, OpenImg, Info, Settings, PassGen, VirtualKeying;

procedure TFrmEntryList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TFrmEntryList.FormCreate(Sender: TObject);
begin
  RetPopup.Position.Y := -RetPopup.Height;
  TSearchBox(ListView.Controls[1]).Height := 30;
  TSearchBox(ListView.Controls[1]).OnClick := ListView.OnMouseEnter;

  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardToolbarService, IInterface(FService)) then
  begin
    FService.SetToolbarEnabled(True);
    FService.SetHideKeyboardButtonVisibility(True);
  end;
  VertScrollBox.OnCalcContentBounds := CalcContentBoundsProc;
end;

procedure TFrmEntryList.ShowPopup;
begin
  if (RetPopup.Position.Y = -RetPopup.Height) then
  begin
    FAnPopup.StartValue:= -RetPopup.Height;
    FAnPopup.StopValue:= ToolBar.Height;
    FAnPopup.Start;
  end;
end;

procedure TFrmEntryList.HidePopup;
begin
  if (RetPopup.Position.Y = ToolBar.Height) then
  begin
    FAnPopup.StartValue:= ToolBar.Height;
    FAnPopup.StopValue:= -RetPopup.Height;
    FAnPopup.Start;
  end;
end;

procedure TFrmEntryList.FormFocusChanged(Sender: TObject);
begin
  UpdateKBBounds;
end;

procedure TFrmEntryList.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  FService: IFMXVirtualKeyboardService;
begin
  case Key of
    vkHardwareBack:
    begin
      TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
      IInterface(FService));
      if (FService <> nil) and not(TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
      begin
        Key := 0;
        if TabControl.ActiveTab = TabItem2 then
        begin
          DM.FDQuEntry.Cancel;
          TabControl.Previous;
        end
        else
          FreeAndNil(Application);
      end;
    end;
    vkReturn:
      begin
        ActiveControl := TControl(Focused.GetObject);
        if not (ActiveControl = Tcontrol(EdtNotes)) then
        begin
          Key := vkTab;
          KeyDown(Key, KeyChar, Shift);
        end;
      end;
    sgiUpRightLong: //Menu button pressed
      begin
        //
      end;
  end;
end;

procedure TFrmEntryList.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TFrmEntryList.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

procedure TFrmEntryList.CalcContentBoundsProc(Sender: TObject; var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom, 2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TFrmEntryList.CirAddClick(Sender: TObject);
begin
  DM.FDQuEntry.UpdateOptions.ReadOnly := false;
  DM.FDQuEntry.Close;
  DM.FDQuEntry.Active := true;
  DM.FDQuEntry.Insert;
  ChangeTabAction.Tab := TabItem2;
  ChangeTabAction.ExecuteTarget(self);
  EdtPassw.Password := false;
  EdbPassw.IsPressed := true;
  EdtTitel.SetFocus;
  UpdateButton(2);
end;

procedure TFrmEntryList.CirEdiClick(Sender: TObject);
begin
  DM.FDQuEntry.UpdateOptions.ReadOnly := false;
  DM.FDQuEntry.Close;
  DM.FDQuEntry.Active := true;
  DM.FDQuEntry.Edit;
  EdtTitel.SetFocus;
  UpdateButton(3);
end;

procedure TFrmEntryList.EdbPasswClick(Sender: TObject);
begin
  EdtPassw.Password := not EdbPassw.IsPressed;
end;

procedure TFrmEntryList.EdbPasGenClick(Sender: TObject);
begin
  HidePopup;
  FrmPassGen := TFrmPassGen.Create(nil);
  FrmPassGen.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if ModalResult = mrOk then
        if DM.FDQuEntry.CanModify then
          DM.FDQuEntry.FieldByName('Passw').AsString := FrmPassGen.EdtResul.Text;
    end);
end;

procedure TFrmEntryList.RestorePosition;
begin
  VertScrollBox.ViewportPosition := PointF(VertScrollBox.ViewportPosition.X, 0);
  Layout.Align := TAlignLayout.Client;
  VertScrollBox.RealignContent;
end;

procedure TFrmEntryList.SpbCancelClick(Sender: TObject);
begin
  DM.FDQuEntry.Cancel;
  DM.FDQuEntry.UpdateOptions.ReadOnly := true;
  EdtPassw.Password := true;
  EdbPassw.IsPressed := false;
  UpdateButton(1);
end;

procedure TFrmEntryList.SpbDeleteClick(Sender: TObject);
{var
  TaskName: String;}
begin
  MessageDlg(Translate('Confirm delete?'), System.UITypes.TMsgDlgType.mtWarning,
    [
      System.UITypes.TMsgDlgBtn.mbYes,
      System.UITypes.TMsgDlgBtn.mbNo
    ], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      if AResult = mrYes then
      begin
        DM.FDQuEntry.UpdateOptions.ReadOnly := false;
        DM.FDQuEntry.Delete;
        DM.FDQuEntry.UpdateOptions.ReadOnly := true;
      end;
    end);
  SpbDelete.Visible := DM.FDQuEntry.RecordCount > 0;

  {TaskName := TListViewItem(ListView.Selected).Text;
  try
    DM.FDQuEntryDelete.ParamByName('Title').AsString := TaskName;
    DM.FDQuEntryDelete.ExecSQL();
    DM.FDQuEntry.Close;
    DM.FDQuEntry.Open;
    SpbDelete.Visible := ListView.Selected <> nil;
  except
    on e: Exception do
    begin
      SHowMessage(e.Message);
    end;
  end; }
end;

procedure TFrmEntryList.SpbMenuClick(Sender: TObject);
begin
  if (RetPopup.Position.Y = -RetPopup.Height) then
    ShowPopup
  else
    HidePopup;
end;

procedure TFrmEntryList.SpbRetClick(Sender: TObject);
begin
  ChangeTabAction.Tab := TabItem1;
  ChangeTabAction.ExecuteTarget(self);
  UpdateButton(0);
end;

procedure TFrmEntryList.SpbSaveClick(Sender: TObject);
begin
    DM.FDQuEntry.Post;
    DM.FDQuEntry.UpdateOptions.ReadOnly := true;
    EdtPassw.Password := true;
    EdbPassw.IsPressed := false;
    UpdateButton(1);
end;

procedure TFrmEntryList.UpdateButton(nStatus: integer);
begin
  // nStatus = 0 => Main menu
  // nStatus = 1 => View mode
  // nStatus = 2 => Add mode
  // nStatus = 3 => Edit mode
  case nStatus of
  0: LblToolBar.Text := 'Password List';
  1: LblToolBar.Text := DM.FDQuEntry.FieldByName('Title').AsString;
  2: LblToolBar.Text := Translate('Add entry');
  3: LblToolBar.Text := Translate('Edit entry');
  end;
  SpbRet.Visible := (nStatus = 1);
  SpbCancel.Visible := (nStatus = 2) or (nStatus = 3);
  SpbSave.Visible := (nStatus = 2) or (nStatus = 3);
  SpbDelete.Visible := (nStatus = 0);
  CirAdd.Visible := (nStatus = 0);
  CirEdi.Visible := (nStatus = 1);
  CebUser.Visible := (nStatus = 2) or (nStatus = 3);
  CebURL.Visible := (nStatus = 2) or (nStatus = 3);
  EdbPasGen.Visible := (nStatus = 2) or (nStatus = 3);
end;

procedure TFrmEntryList.SbtCopPssClick(Sender: TObject);
var
  Svc: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    Svc.SetClipboard(EdtPassw.Text);
end;

procedure TFrmEntryList.SbtCopUsrClick(Sender: TObject);
var
  Svc: IFMXClipboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    Svc.SetClipboard(EdtUserN.Text);
end;

procedure TFrmEntryList.SbtLauBroClick(Sender: TObject);
begin
  // Function still unavailable
  // Funktion noch nicht verfügbar
  // Função ainda indisponível

  {$IF Defined(MSWINDOWS) or (Defined(MACOS) and not Defined(IOS))}
  MessageDlg(Translate('3 seconds after you click OK, whatever is the active '+
    'window will have typed into it'), TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
  DM.LaunchBrowser(EdtURL.Text);
  Sleep(3000);
  TVirtualKeySequence.Execute(EdtPassw.Text);
  {$IFEND}
end;

procedure TFrmEntryList.UpdateKBBounds;
var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VertScrollBox.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
       (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      Layout.Align := TAlignLayout.Horizontal;
      VertScrollBox.RealignContent;
      Application.ProcessMessages;
      VertScrollBox.ViewportPosition :=
        PointF(VertScrollBox.ViewportPosition.X,
               LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
    RestorePosition;
end;

procedure TFrmEntryList.ImcIconChange(Sender: TObject);
begin
  TLinkObservers.ControlChanged(TComponent(Sender));
end;

procedure TFrmEntryList.ImcIconClick(Sender: TObject);
begin
  {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  FrmOpenImg := TFrmOpenImg.Create(nil);
  FrmOpenImg.ShowModal(
    procedure(ModalResult: TModalResult)
    begin
      if ModalResult = mrOK then
        if FrmOpenImg.sDateiName <> '' then
          ImcIcon.Bitmap.LoadFromFile(FrmOpenImg.sDateiName);
    end);
  {$ENDIF}
end;

procedure TFrmEntryList.LbiSettingsClick(Sender: TObject);
begin
  HidePopup;
  FrmSettings := TFrmSettings.Create(nil);
  FrmSettings.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFrmEntryList.LbiInfoClick(Sender: TObject);
begin
  HidePopup;
  FrmInfo := TFrmInfo.Create(nil);
  FrmInfo.ShowModal(
    procedure(ModalResult: TModalResult)
    begin

    end);
end;

procedure TFrmEntryList.ListViewClick(Sender: TObject);
begin
  HidePopup;
end;

procedure TFrmEntryList.ListViewItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  SpbDelete.Visible := ListView.Selected <> nil;
end;

procedure TFrmEntryList.ListViewItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
  I: Integer;
begin
  if LocalClickPos.X >= TListView(Sender).Width - 60 then
    begin
      for I := 0 to ListView.Controls.Count-1 do
        if ListView.Controls[I].ClassType = TSearchBox then
        begin
          TSearchBox(ListView.Controls[I]).Text := '';
        end;
      ChangeTabAction.Tab := TabItem2;
      ChangeTabAction.ExecuteTarget(self);
      UpdateButton(1);
    end;
end;

procedure TFrmEntryList.ListViewMouseEnter(Sender: TObject);
begin
  HidePopup;
end;

end.
