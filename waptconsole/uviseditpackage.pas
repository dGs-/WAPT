unit uviseditpackage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterPython, SynEdit,
  Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ActnList, Menus, Buttons,
  superobject, VirtualTrees,
  VarPyth, types, ActiveX, LCLIntf, LCL, sogrid, vte_json, DefaultTranslator,
  SearchEdit;

type

  { TVisEditPackage }

  TVisEditPackage = class(TForm)
    ActExecCode: TAction;
    ActBuildUpload: TAction;
    ActEditSearch: TAction;
    ActEditRemoveDepends: TAction;
    ActEditSavePackage: TAction;
    ActAdvancedMode: TAction;
    ActAddDepends: TAction;
    ActBUApply: TAction;
    ActEditRemoveConflicts: TAction;
    ActAddConflicts: TAction;
    ActionsImages: TImageList;
    ActSearchPackage: TAction;
    ActionList1: TActionList;
    ButAddPackages: TBitBtn;
    butBUApply1: TBitBtn;
    ButCancel: TBitBtn;
    butInitWapt: TBitBtn;
    butSearchPackages1: TBitBtn;
    butBUApply: TBitBtn;
    cbShowLog: TCheckBox;
    EdDescription: TEdit;
    EdPackage: TEdit;
    EdSearch: TSearchEdit;
    EdSection: TComboBox;
    EdVersion: TLabeledEdit;
    GridConflicts: TSOGrid;
    GridPackages: TSOGrid;
    LabDescription: TLabel;
    labPackage: TLabel;
    Label2: TLabel;
    GridDepends: TSOGrid;
    Label5: TLabel;
    MemoLog: TMemo;
    MenuItem1: TMenuItem;
    MenuAddPackages: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PanRight: TPanel;
    Panel9: TPanel;
    PanelDevlop: TPanel;
    Panel4: TPanel;
    Panel7: TPanel;
    PopupMenu1: TPopupMenu;
    PopupMenuEditConflicts: TPopupMenu;
    PopupPackages: TPopupMenu;
    PopupMenuEditDepends: TPopupMenu;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    SynPythonSyn1: TSynPythonSyn;
    pgDevelop: TTabSheet;
    pgDepends: TTabSheet;
    EdSetupPy: TSynEdit;
    jsonlog: TVirtualJSONInspector;
    pgConflicts: TTabSheet;
    procedure ActAddConflictsExecute(Sender: TObject);
    procedure ActAddConflictsUpdate(Sender: TObject);
    procedure ActAddDependsExecute(Sender: TObject);
    procedure ActAddDependsUpdate(Sender: TObject);
    procedure ActAdvancedModeExecute(Sender: TObject);
    procedure ActBUApplyExecute(Sender: TObject);
    procedure ActBuildUploadExecute(Sender: TObject);
    procedure ActEditRemoveConflictsExecute(Sender: TObject);
    procedure ActEditRemoveConflictsUpdate(Sender: TObject);
    procedure ActEditRemoveDependsExecute(Sender: TObject);
    procedure ActEditRemoveDependsUpdate(Sender: TObject);
    procedure ActEditSavePackageExecute(Sender: TObject);
    procedure ActEditSavePackageUpdate(Sender: TObject);
    procedure ActEditSearchExecute(Sender: TObject);
    procedure ActExecCodeExecute(Sender: TObject);
    procedure cbShowLogClick(Sender: TObject);
    procedure EdPackageExit(Sender: TObject);
    procedure EdPackageKeyPress(Sender: TObject; var Key: char);
    procedure EdSearchExecute(Sender: TObject);
    procedure EdSearchKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure EdSectionChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridConflictsDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      const Pt: TPoint; var Effect: DWORD; Mode: TDropMode);
    procedure GridDependsDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      const Pt: TPoint; var Effect: DWORD; Mode: TDropMode);
    procedure GridDependsDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; const Pt: TPoint;
      Mode: TDropMode; var Effect: DWORD; var Accept: boolean);
    procedure PageControl1Change(Sender: TObject);
  private
    FisAdvancedMode: boolean;
    FisTempSourcesDir: boolean;
    { private declarations }
    FPackageRequest: string;
    FSourcePath: string;
    FIsUpdated: boolean;
    GridDependsUpdated: boolean;
    GridConflictsUpdated: boolean;
    FDepends: string;
    FConflicts: string;
    procedure AddDepends(Sender: TObject);
    procedure AddConflicts(Sender: TObject);
    function CheckUpdated: boolean;
    procedure SetisAdvancedMode(AValue: boolean);
    procedure SetIsUpdated(AValue: boolean);
    function GetIsUpdated: boolean;
    function GetDepends: string;
    function GetConflicts: string;
    property IsUpdated: boolean read GetIsUpdated write SetIsUpdated;
    procedure SetDepends(AValue: string);
    procedure SetConflicts(AValue: string);
    procedure SetPackageRequest(AValue: string);
    procedure SetSourcePath(AValue: string);
    property Depends: string read GetDepends write SetDepends;
    property Conflicts: string read GetConflicts write SetConflicts;
    function updateprogress(receiver: TObject; current, total: integer): boolean;
  public
    { public declarations }
    IsHost: boolean;
    isGroup: boolean;
    IsNewPackage: boolean;
    PackageEdited: ISuperObject;
    ApplyUpdatesImmediately:Boolean;
    property isAdvancedMode: boolean read FisAdvancedMode write SetisAdvancedMode;
    procedure EditPackage;
    property SourcePath: string read FSourcePath write SetSourcePath;
    property PackageRequest: string read FPackageRequest write SetPackageRequest;
  end;

function EditPackage(packagename: string; advancedMode: boolean): ISuperObject;
function CreatePackage(packagename: string; advancedMode: boolean): ISuperObject;
function CreateGroup(packagename: string; advancedMode: boolean): ISuperObject;
function EditHost(hostuuid: ansistring; advancedMode: boolean; var ApplyUpdates:Boolean; description:ansiString=''; HostReachable:Boolean=False;computer_fqdn_hint:ansiString=''): ISuperObject;
function EditHostDepends(hostname: string; newDependsStr: string): ISuperObject;
function EditGroup(group: string; advancedMode: boolean): ISuperObject;


var
  VisEditPackage: TVisEditPackage;

implementation

uses uWaptConsoleRes,soutils, LCLType, waptcommon, dmwaptpython, jwawinuser, uvisloading,
  uvisprivatekeyauth, uwaptconsole, tiscommon, uWaptRes,UScaleDPI,tisinifiles;

{$R *.lfm}

function EditPackage(packagename: string; advancedMode: boolean): ISuperObject;
begin
  with TVisEditPackage.Create(nil) do
    try
      isAdvancedMode := advancedMode;
      PackageRequest := packagename;
      if ShowModal = mrOk then
        Result := PackageEdited
      else
        Result := nil;
    finally
      Free;
    end;
end;

function CreatePackage(packagename: string; advancedMode: boolean): ISuperObject;
begin
  with TVisEditPackage.Create(nil) do
    try
      isAdvancedMode := advancedMode;
      IsNewPackage := True;
      PackageRequest := packagename;
      EdSection.ItemIndex := 4;
      EdVersion.Enabled:=advancedMode;
      EdVersion.ReadOnly:=not advancedMode;
      if ShowModal = mrOk then
        Result := PackageEdited
      else
        Result := nil;
    finally
      Free;
    end;
end;

function CreateGroup(packagename: string; advancedMode: boolean): ISuperObject;
begin
  with TVisEditPackage.Create(nil) do
    try
      Caption:= rsEditBundle;
      LabPackage.Caption := rsEdPackage;
      pgDepends.Caption := rsPackagesNeededCaption;

      isAdvancedMode := advancedMode;
      IsNewPackage := True;
      PackageRequest := packagename;
      EdSection.ItemIndex := 4;
      ActBUApply.Visible:=False;
      EdVersion.Enabled:=advancedMode;
      EdVersion.ReadOnly:=not advancedMode;
      if ShowModal = mrOk then
        Result := PackageEdited
      else
        Result := nil;
    finally
      Free;
    end;
end;

function EditHost(hostuuid: ansistring; advancedMode: boolean;var ApplyUpdates:Boolean;description:ansiString='';HostReachable:Boolean=False;computer_fqdn_hint:AnsiString=''): ISuperObject;
var
  res:ISuperObject;
  olddesc:String;
begin
  with TVisEditPackage.Create(nil) do
    try
      IsHost := True;
      Result := Nil;
      isAdvancedMode := advancedMode;
      PackageRequest := hostuuid;

      if computer_fqdn_hint<>'' then
        Caption:= Format(rsEditHostCaption,[computer_fqdn_hint])
      else
        Caption:= Format(rsEditHostCaption,[hostuuid]);

      EdVersion.Enabled:=advancedMode;
      EdVersion.ReadOnly:=not advancedMode;

      if description<>'' then
      begin
        Eddescription.Text := description;
        if computer_fqdn_hint<>'' then
          EdDescription.Text:=EdDescription.Text+' ('+computer_fqdn_hint+')';
      end
      else
        EdDescription.Text:=computer_fqdn_hint;

      EdPackage.ReadOnly:=True;
      EdPackage.ParentColor:=True;

      ActBUApply.Visible := HostReachable;

      if ShowModal = mrOk then
      try
        Result := PackageEdited;
        ApplyUpdates:=ApplyUpdatesImmediately;
      except
        on E:Exception do
          ShowMessageFmt('Error editing host %s',[e.Message]);
      end
      else
        Result := nil;
    finally
      Free;
    end;
end;

function EditGroup(group: string; advancedMode: boolean): ISuperObject;
begin
  with TVisEditPackage.Create(nil) do
    try
      isGroup := True;
      isAdvancedMode := advancedMode;
      PackageRequest := group;
      EdVersion.Enabled:=advancedMode;
      EdVersion.ReadOnly:=not advancedMode;
      if EdVersion.ReadOnly then
        EdVersion.ParentColor:=True;

      EdPackage.ReadOnly:=not IsNewPackage and not advancedMode;
      if EdPackage.ReadOnly then
        EdPackage.ParentColor:=True;

      Caption:=rsEditBundle;
      LabPackage.Caption := rsEdPackage;
      pgDepends.Caption := rsPackagesNeededCaption;

      if ShowModal = mrOk then
        Result := PackageEdited
      else
        Result := nil;
    finally
      Free;
    end;
end;

function EditHostDepends(hostname: string; newDependsStr: string): ISuperObject;
var
  oldDepends, newDepends: ISuperObject;
  i: word;
begin
  with TVisEditPackage.Create(nil) do
    try
      IsHost := True;
      PackageRequest := hostname;

      oldDepends := Split(Depends, ',');
      newDepends := Split(newDependsStr, ',');
      for i := 0 to newDepends.AsArray.Length - 1 do
      begin
        if not StrIn(newDepends.AsArray.S[i], olddepends) then
          olddepends.AsArray.Add(newDepends.AsArray.S[i]);
      end;
      Depends := soutils.Join(',', olddepends);

      Result := PackageEdited;
      if Result<>Nil then
        ActBuildUploadExecute(nil);
    finally
      Free;
    end;
end;

{ TVisEditPackage }
procedure TVisEditPackage.cbShowLogClick(Sender: TObject);
begin
  if cbShowLog.Checked then
    DMPython.PythonEng.ExecString('logger.setLevel(logging.DEBUG)')
  else
    DMPython.PythonEng.ExecString('logger.setLevel(logging.WARNING)');
end;

procedure TVisEditPackage.EdPackageExit(Sender: TObject);
begin
  EdPackage.Text:=Trim(EdPackage.Text);
end;

procedure TVisEditPackage.EdPackageKeyPress(Sender: TObject; var Key: char);
begin
  if not (lowercase(key) in ['a'..'z','0'..'9','-',#8,#9]) then
      Key:=#0;
end;

procedure TVisEditPackage.EdSearchExecute(Sender: TObject);
begin
  if EdSearch.Modified then
    ActEditSearchExecute(Sender);
end;

procedure TVisEditPackage.EdSearchKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    EdSearch.SelectAll;
    ActEditSearch.Execute;
  end;

end;

procedure TVisEditPackage.EdSectionChange(Sender: TObject);
begin
  FIsUpdated := True;
end;

procedure TVisEditPackage.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  IniWriteInteger(Appuserinipath,Name,'Top',Top);
  IniWriteInteger(Appuserinipath,Name,'Left',Left);
  IniWriteInteger(Appuserinipath,Name,'Width',Width);
  IniWriteInteger(Appuserinipath,Name,'Height',Height);
  IniWriteInteger(Appuserinipath,Name,PanRight.Name+'.Width',PanRight.Width);

  GridConflicts.SaveSettingsToIni(Appuserinipath);
  GridDepends.SaveSettingsToIni(Appuserinipath);
  GridPackages.SaveSettingsToIni(Appuserinipath);;

end;

procedure TVisEditPackage.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := CheckUpdated;
  if FisTempSourcesDir and DirectoryExists(FSourcePath) then
    FileUtil.DeleteDirectory(FSourcePath, False);
end;

function TVisEditPackage.CheckUpdated: boolean;
var
  Rep: integer;
  msg: string;
begin
  Result := not IsUpdated;
  if not Result then
  begin
    msg := rsSaveMods;
    Rep := Application.MessageBox(PChar(msg), PChar(rsConfirmCaption), MB_APPLMODAL +
      MB_ICONQUESTION + MB_YESNOCANCEL);
    if (Rep = idYes) then
      Result := ActEditSavePackage.Execute
    else
    if (Rep = idNo) then
      Result := True;
  end;
end;

procedure TVisEditPackage.SetisAdvancedMode(AValue: boolean);
begin
  if FisAdvancedMode = AValue then
    Exit;
  FisAdvancedMode := AValue;
  // Advance mode in mainWindow -> tools => advance
  PanelDevlop.Visible := isAdvancedMode;
  Label5.Visible := isAdvancedMode;
  EdSection.Visible := isAdvancedMode;
  cbShowLog.Visible := isAdvancedMode;
  pgDevelop.TabVisible := isAdvancedMode;
  Eddescription.Visible := not IsHost or isAdvancedMode;

end;

procedure TVisEditPackage.EditPackage;
begin
  EdPackage.Text := PackageEdited.S['package'];
  EdVersion.Text := PackageEdited.S['version'];
  EdDescription.Text := UTF8Encode(PackageEdited.S['description']);
  EdSection.Text := PackageEdited.S['section'];
  IsUpdated := False;
  // get a list of package entries given a
  Depends := PackageEdited.S['depends'];
  Conflicts := PackageEdited.S['conflicts'];
  if FileExists(AppendPathDelim(FSourcePath) + 'setup.py') then
    EdSetupPy.Lines.LoadFromFile(AppendPathDelim(FSourcePath) + 'setup.py')
  else
    EdSetupPy.Lines.Clear;
  butBUApply.Visible:=IsHost;
end;

function gridFind(grid: TSOGrid; Fieldname, AText: string): PVirtualNode;
var
  n: PVirtualNode;
begin
  Result := nil;
  n := grid.GetFirst;
  while n <> nil do
  begin
    if grid.GetCellStrValue(n, Fieldname) = AText then
    begin
      Result := n;
      Break;
    end;
    n := grid.GetNext(n);
  end;
end;

procedure TVisEditPackage.GridDependsDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; const Pt: TPoint; var Effect: DWORD; Mode: TDropMode);
begin
  AddDepends(Sender);
end;

procedure RemoveString(List:ISuperObject;St:string);
var
  i:Integer;
  it:ISuperObject;
begin
  if List <>Nil then
    for i :=0 to List.AsArray.Length-1 do
    begin
      it := List.AsArray[i];
      if (it.DataType=stString) and (it.AsString=St) then
      begin
        List.AsArray.Delete(i);
        Exit;
      end;
    end;
end;

procedure TVisEditPackage.AddDepends(Sender: TObject);
var
  row,olddepends,oldconflicts: ISuperObject;
  package: string;
begin
  olddepends := Split(Depends, ',');
  oldconflicts := Split(Conflicts, ',');
  for row in GridPackages.SelectedRows do
  begin
    package := row.S['package'];
    if not StrIn(package, olddepends) then
    begin
      olddepends.AsArray.Add(package);
      GridDependsUpdated:=True;
    end;
    RemoveString(oldconflicts,package);
    GridConflictsUpdated :=True;
  end;
  Depends := soutils.Join(',', olddepends);
  Conflicts := soutils.Join(',', oldconflicts);
end;

procedure TVisEditPackage.GridDependsDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; const Pt: TPoint;
  Mode: TDropMode; var Effect: DWORD; var Accept: boolean);
begin
  Accept := Source = GridPackages;
end;

procedure TVisEditPackage.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = pgDepends then
  begin
    ButAddPackages.Action := ActAddDepends;
    MenuAddPackages.Action := ActAddDepends;
  end
  else
  begin
    ButAddPackages.Action := ActAddConflicts;
    MenuAddPackages.Action := ActAddConflicts;
  end;
end;

procedure TVisEditPackage.ActEditRemoveDependsExecute(Sender: TObject);
begin
  GridDepends.DeleteSelectedNodes;
  Depends := Depends;
  GridDependsUpdated := True;
end;

procedure TVisEditPackage.ActEditRemoveDependsUpdate(Sender: TObject);
begin
  ActEditRemoveDepends.Enabled:=GridDepends.SelectedCount>0;
end;

procedure TVisEditPackage.ActEditSavePackageExecute(Sender: TObject);
var
  res: ISuperObject;
  description:String;
  PE,ControlDict:Variant;
begin
  Screen.Cursor := crHourGlass;
  try
    if IsNewPackage then
    begin
      description := UTF8Decode(Eddescription.Text);
      res := PyVarToSuperObject(
        Mainmodule.mywapt.make_group_template(
          packagename := Trim(EdPackage.Text),
          depends := Depends,
          description := description,
          section := EdSection.Text
        ));
      FSourcePath := res.S['sourcespath'];
      PackageEdited := res;
    end
    else
    begin
      PackageEdited.S['package'] := StringReplace(trim(EdPackage.Text),' ','',[rfReplaceAll]);
      PackageEdited.S['version'] := trim(lowercase(EdVersion.Text));
      PackageEdited.S['description'] := UTF8Decode(EdDescription.Text);
      PackageEdited.S['section'] :=  trim(lowercase(EdSection.Text));
      PackageEdited.S['depends'] :=  trim(Depends);
      PackageEdited.S['conflicts'] :=  trim(Conflicts);
      ControlDict:=SuperObjectToPyVar(PackageEdited);

      PE := Mainmodule.waptpackage.PackageEntry(package := '');
      PE.load_control_from_dict(ControlDict);
      PE.save_control_to_wapt(SourcePath);

      if EdSetupPy.Lines.Count>0 then
        EdSetupPy.Lines.SaveToFile(AppendPathDelim(FSourcePath) + 'setup.py')
      else
        DeleteFile(AppendPathDelim(FSourcePath) + 'setup.py');
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TVisEditPackage.ActEditSavePackageUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (EdPackage.Text<>'') and IsUpdated;
end;

function TVisEditPackage.GetIsUpdated: boolean;
begin
  Result := FIsUpdated or EdPackage.Modified or EdVersion.Modified or
    EdSetupPy.Modified or Eddescription.Modified or
    GridDependsUpdated or GridConflictsUpdated;
end;

procedure TVisEditPackage.ActEditSearchExecute(Sender: TObject);
begin
  EdSearch.Modified:=False;
  GridPackages.Data := PyVarToSuperObject(DMPython.MainWaptRepo.search(searchwords := EdSearch.Text, newest_only := True));
end;

procedure TVisEditPackage.ActBuildUploadExecute(Sender: TObject);
var
  Result: ISuperObject;
begin
  Result := Nil;

  ActEditSavePackage.Execute;

  if not FileExists(GetWaptPersonalCertificatePath) then
  begin
    ShowMessageFmt(rsPrivateKeyDoesntExist, [GetWaptPersonalCertificatePath]);
    exit;
  end;

  with TVisLoading.Create(Self) do
  try
    ProgressTitle(rsUploading);
    Application.ProcessMessages;
    try
      Result := PyVarToSuperObject(
        Mainmodule.mywapt.build_upload(
          sources_directories := FSourcePath,
          private_key_passwd := dmpython.privateKeyPassword,
          wapt_server_user := waptServerUser,
          wapt_server_passwd := waptServerPassword,
          inc_package_release := True));

      if Result.AsArray.Length=0  then
        raise Exception.Create('Error when building / uploading package, no result');
      if FisTempSourcesDir then
      begin
        FileUtil.DeleteDirectory(FSourcePath, False);
        if (Result.AsArray <> nil) and (FileExistsUTF8(Result.AsArray[0].S['filename'])) then
          FileUtil.DeleteFileUTF8(Result.AsArray[0].S['filename']);
      end;
      IsUpdated := False;
    except
      on E:Exception do
      begin
        ShowMessageFmt(rsPackageCreationError, [E.Message]);
        Result := Nil;
        ModalResult:=mrNone;
        Abort;
      end;
    end;
  finally
    Free;
  end;
  if (Result<>Nil) and (Result.AsArray<>Nil) and (Result.AsArray.Length>0) then
    ModalResult := mrOk
end;

procedure TVisEditPackage.ActEditRemoveConflictsExecute(Sender: TObject);
begin
  GridConflicts.DeleteSelectedNodes;
  Conflicts := Conflicts;
  GridConflictsUpdated := True;
end;

procedure TVisEditPackage.ActEditRemoveConflictsUpdate(Sender: TObject);
begin
  ActEditRemoveConflicts.Enabled:=GridConflicts.SelectedCount>0
end;

procedure TVisEditPackage.ActAdvancedModeExecute(Sender: TObject);
begin
  isAdvancedMode := ActAdvancedMode.Checked;
end;

procedure TVisEditPackage.ActBUApplyExecute(Sender: TObject);
begin
  ApplyUpdatesImmediately := True;
  ActBuildUpload.Execute;
end;

procedure TVisEditPackage.ActAddDependsUpdate(Sender: TObject);
begin
  ActAddDepends.Enabled := GridPackages.SelectedCount > 0;
end;

procedure TVisEditPackage.ActAddDependsExecute(Sender: TObject);
begin
  AddDepends(Sender);
end;

procedure TVisEditPackage.ActAddConflictsUpdate(Sender: TObject);
begin
  ActAddConflicts.Enabled := GridPackages.SelectedCount > 0;
end;

procedure TVisEditPackage.ActAddConflictsExecute(Sender: TObject);
begin
  AddConflicts(Sender);
end;

procedure TVisEditPackage.ActExecCodeExecute(Sender: TObject);
begin
  MemoLog.Clear;
  DMPython.PythonEng.ExecString(EdSetupPy.Lines.Text);
end;

procedure TVisEditPackage.FormCreate(Sender: TObject);
begin
  ScaleDPI(Self,96); // 96 is the DPI you designed
  ScaleImageList(ActionsImages,96);

  GridPackages.Clear;
  MemoLog.Clear;

  GridDepends.Clear;
  GridConflicts.Clear;


end;

procedure TVisEditPackage.FormShow(Sender: TObject);
begin
  Top := IniReadInteger(Appuserinipath,Name,'Top',Top);
  Left := IniReadInteger(Appuserinipath,Name,'Left',Left);
  Width := IniReadInteger(Appuserinipath,Name,'Width',Width);
  Height := IniReadInteger(Appuserinipath,Name,'Height',Height);
  PanRight.Width:=IniReadInteger(Appuserinipath,Name,PanRight.Name+'.Width',PanRight.Width);
  GridConflicts.LoadSettingsFromIni(Appuserinipath);
  GridDepends.LoadSettingsFromIni(Appuserinipath);
  GridPackages.LoadSettingsFromIni(Appuserinipath);;

  ActEditSearch.Execute;
  EdPackage.SetFocus;
end;

procedure TVisEditPackage.GridConflictsDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; const Pt: TPoint; var Effect: DWORD; Mode: TDropMode);
begin
  AddConflicts(Sender);
end;

procedure TVisEditPackage.AddConflicts(Sender: TObject);
var
  row,olddepends,oldconflicts: ISuperObject;
  package: string;
begin
  olddepends := Split(Depends, ',');
  oldconflicts := Split(Conflicts, ',');
  for row in GridPackages.SelectedRows do
  begin
    package := row.S['package'];
    if not StrIn(package, oldconflicts) then
    begin
      oldconflicts.AsArray.Add(package);
      GridConflictsUpdated:=True;
    end;
    RemoveString(olddepends,package);
    GridDependsUpdated:=True;
  end;
  Depends := soutils.Join(',', olddepends);
  Conflicts := soutils.Join(',', oldconflicts);
end;


function UniqueTempDir(prefix: string = ''): string;
begin
  if prefix = '' then
    prefix := 'wapt';
  repeat
    Result := GetTempDir(False) + prefix + IntToStr(Random(maxint));
  until not DirectoryExists(Result) and not FileExists(Result);
end;

procedure TVisEditPackage.SetPackageRequest(AValue: string);
var
  res: ISuperObject;
  n: PVirtualNode;
  filename, filePath, target_directory: string;
  grid: TSOGrid;
begin
  if FPackageRequest = AValue then
    Exit;
  if AValue='' then
    raise Exception.Create('Can not edit an Empty package name');
  Screen.Cursor := crHourGlass;
  try
    FPackageRequest := AValue;
    if not IsNewPackage then
    begin
      if IsHost then
      begin
        target_directory := UniqueTempDir();
        FisTempSourcesDir := True;
        res := PyVarToSuperObject(
          MainModule.mywapt.edit_host(
            hostname := FPackageRequest,
            target_directory := target_directory)
            );
        LabPackage.Caption := 'UUID';
        Caption := rsHostConfigEditCaption;
        pgDepends.Caption := rsPackagesNeededOnHostCaption;
      end
      else
      begin
        with  TVisLoading.Create(Self) do
          try
            ProgressTitle('Téléchargement en cours');
            Application.ProcessMessages;
            if isGroup then
            begin
              Caption := rsBundleConfigEditCaption;
              grid := uwaptconsole.VisWaptGUI.GridGroups;
            end
            else
              grid := uwaptconsole.VisWaptGUI.GridPackages;
            n := grid.GetFirstSelected();
            if n <> nil then
              try
                filename := grid.GetCellStrValue(n, 'filename');
                filePath := AppLocalDir + 'cache\' + filename;
                if not DirectoryExists(AppLocalDir + 'cache') then
                  mkdir(AppLocalDir + 'cache');
                // la gestion du cache implique de lire la version di paquet WAPT dans le fichier control.
                // (paquets de groupe et paquets host)
                //if not FileExists(filePath) then

                IdWget(GetWaptRepoURL + '/' + filename, filePath,
                  ProgressForm, @updateprogress, UseProxyForRepo);
              except
                ShowMessage(rsDlCanceled);
                if FileExists(filePath) then
                  DeleteFile(filePath);
                exit;
              end;

            res := PyVarToSuperObject(MainModule.mywapt.edit_package(packagerequest := filePath));

            FisTempSourcesDir := True;
          finally
            Free;
          end;

      end;
      FSourcePath := res.S['sourcespath'];
      PackageEdited := res;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
  if not IsNewPackage then
    EditPackage;
end;

procedure TVisEditPackage.SetSourcePath(AValue: string);
var
  res: ISuperObject;
begin
  if FSourcePath = AValue then
    Exit;
  FSourcePath := AValue;
  try
    res := PyVarToSuperObject(Mainmodule.mywapt.edit_package(FSourcePath));
    PackageEdited := res['package'];
  finally
    Screen.Cursor := crDefault;
  end;
  EditPackage;
end;

procedure TVisEditPackage.SetIsUpdated(AValue: boolean);
begin
  FIsUpdated := AValue;
  if not AValue then
  begin
    EdPackage.Modified := False;
    Eddescription.Modified := False;
    EdVersion.Modified := False;
    EdSetupPy.Modified := False;
    GridDependsUpdated := False;
    GridConflictsUpdated := False;
  end;
end;

procedure TVisEditPackage.SetDepends(AValue: string);
var
  dependencies: ISuperObject;
begin
  FDepends := AValue;
  if FDepends<>'' then
  begin
    dependencies := PyVarToSuperObject(DMPython.MainWaptRepo.get_package_entries(FDepends));
    GridDepends.Data := dependencies['packages'];
    //GridDepends.Header.AutoFitColumns(False);
    if dependencies['missing'].AsArray.Length > 0 then
    begin
      ShowMessageFmt(rsIgnoredPackages,
        [dependencies.S['missing']]);
      GridDependsUpdated := True;
    end;
  end
  else
    GridDepends.Data := Nil;
end;

procedure TVisEditPackage.SetConflicts(AValue: string);
var
  aconflicts: ISuperObject;
begin
  FConflicts := AValue;
  if FConflicts<>'' then
  begin
    aconflicts := PyVarToSuperObject(DMPython.MainWaptRepo.get_package_entries(FConflicts));
    GridConflicts.Data := aconflicts['packages'];
    //GridConflicts.Header.AutoFitColumns(False);
    if aconflicts['missing'].AsArray.Length > 0 then
    begin
      ShowMessageFmt(rsIgnoredConfictingPackages,
        [aconflicts.S['missing']]);
      GridConflictsUpdated := True;
    end
  end
  else
    GridConflicts.Data := Nil;
end;

function TVisEditPackage.GetDepends: string;
var
  n: PVirtualNode;
begin
  FDepends := '';
  n := GridDepends.GetFirst;
  while (n <> nil) do
  begin
    if FDepends <> '' then
      FDepends := FDepends + ',' + GridDepends.GetCellStrValue(n, 'package')
    else
      FDepends := GridDepends.GetCellStrValue(n, 'package');
    n := GridDepends.GetNext(n);
  end;
  Result := FDepends;
end;

function TVisEditPackage.GetConflicts: string;
var
  n: PVirtualNode;
begin
  FConflicts := '';
  n := GridConflicts.GetFirst;
  while (n <> nil) do
  begin
    if FConflicts <> '' then
      FConflicts := FConflicts + ',' + GridConflicts.GetCellStrValue(n, 'package')
    else
      FConflicts := GridConflicts.GetCellStrValue(n, 'package');
    n := GridConflicts.GetNext(n);
  end;
  Result := FConflicts;
end;


function TVisEditPackage.updateprogress(receiver: TObject;
  current, total: integer): boolean;
begin
  if receiver <> nil then
    with (receiver as TVisLoading) do
    begin
      ProgressStep(current, total);
      Result := not StopRequired;
    end
  else
    Result := True;
end;

end.
