unit UEinstellungen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Spin, Mask, TData, UPlakettenverwaltung,
  UAnzeigeSAP;

type
  TFrmEinstellungen = class(TForm)
    GrBProgrammeinstellungen: TGroupBox;
    lblSAPSystem: TLabel;
    lblPlakettenSteps: TLabel;
    CoBSAPSystem: TComboBox;
    SpEPlakettensteps: TSpinEdit;
    GrBButtons: TGroupBox;
    BBtnSchliessen: TBitBtn;
    BBtnUebernehmen: TBitBtn;
    StBBottom: TStatusBar;
    lblConnectionType: TLabel;
    CoBConnectionType: TComboBox;
    ChBProxy: TCheckBox;
    CoBDefaultDepot: TComboBox;
    lblDefaultDepot: TLabel;
    ChbAllTransactions: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BBtnUebernehmenClick(Sender: TObject);
    procedure CoBConnectionTypeChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmEinstellungen: TFrmEinstellungen;

implementation

{$R *.dfm}

procedure TFrmEinstellungen.FormCreate(Sender: TObject);
var I: Integer;
begin

  for I := ord(sapEntwicklung) to ord(sapProduktion) do
  begin
    if not (TPVSAPSystem(I) = sapProduktion) or (FrmPlakettenverwaltung.CurrentDate > FrmPlakettenverwaltung.StartDatePRG) then
      CoBSAPSystem.Items.Add(SAPSystemStr[ord(I)]);
  end;

  for I := ord(ctIntranet) to ord(ctInternet) do
  begin
    CoBConnectionType.Items.Add(ConnectionTypeStr[ord(I)]);
  end;

  if not FrmPlakettenverwaltung.ShowAllSettings then
  begin
    lblSAPSystem.Enabled := false;
    lblSAPSystem.Visible := false;
    CoBSAPSystem.Enabled := false;
    CoBSAPSystem.Visible := false;
    lblConnectionType.Enabled := false;
    lblConnectionType.Visible := false;
    CoBConnectionType.Enabled := false;
    CoBConnectionType.Visible := false;
    ChBProxy.Enabled := false;
    ChBProxy.Visible := false;
  end;

end;

procedure TFrmEinstellungen.FormShow(Sender: TObject);
var I: Integer;
begin
  // Verbindungsart einlesen
  CoBSAPSystem.ItemIndex := Ord(FrmPlakettenverwaltung.SAPSystem);
  CoBConnectionType.ItemIndex := Ord(FrmPlakettenverwaltung.ConnectionType);

  // Proxy-Eintellungen einlesen
//  if DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_USEPROXY, INI_USEPROXY_DEF) = 0 then
  ChBProxy.Checked := (DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_USEPROXY, INI_USEPROXY_DEF) = 1);
  // Anzeige aller tatsächlichen Bestandsbuchungen
  ChbAllTransactions.Checked := (DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_ALLTRANSACTIONS, INI_ALLTRANSACTIONS_DEF) = 1);

  // weitere Control-Einstellungen einlesen
  // Default-Depot
  // kiek 25.01.12, lfd.Nr./Beschreibung 866/1
  // erst leeren, damit sich die Einträge nicht verdoppeln
  CoBDefaultDepot.Items.Clear;
  CoBDefaultDepot.Hint := '';
  FrmWertePruef.SAP_INFOS_DEPOT.AdsGotoTop;
  I := CoBDefaultDepot.Items.Add('');
  CoBDefaultDepot.Hint := '' + #13;
  while not FrmWertePruef.SAP_INFOS_DEPOT.Eof do
  begin
    I := CoBDefaultDepot.Items.Add(FrmWertePruef.SAP_INFOS_DEPOT.FieldByName('Bezeichnung').AsString);
    CoBDefaultDepot.Hint := CoBDefaultDepot.Hint + FrmWertePruef.SAP_INFOS_DEPOT.FieldByName('Depot-ID').AsString + ' - ' + FrmWertePruef.SAP_INFOS_DEPOT.FieldByName('Bezeichnung').AsString + #13;
    FrmWertePruef.SAP_INFOS_DEPOT.AdsSkip(1);
  end;
  CoBDefaultDepot.ItemIndex := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_DEFAULTDEPOT, INI_DEFAULTDEPOT_DEF);

  // Plakettenschritte einlesen
  SpEPlakettensteps.Value := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENSTEPS, INI_PLAKETTENSTEPS_DEF);
end;

procedure TFrmEinstellungen.BBtnUebernehmenClick(Sender: TObject);
var iTmp: Integer;
begin
  // Verbindungsart speichern
  DaMConnections.Plakini.WriteInteger(INI_SEC_SETTINGS, INI_KEY_CONNECTIONTYPE, CoBConnectionType.ItemIndex);
  FrmPlakettenverwaltung.ConnectionType := TPVConnectionType(CoBConnectionType.ItemIndex);

  // Proxy-Eintellungen in Anlehnung an der Verbindungsart speichern
  iTmp := 0;
  if ChBProxy.Checked then
    iTmp := 1;
  DaMConnections.Plakini.WriteInteger(INI_SEC_SETTINGS, INI_KEY_USEPROXY, iTmp);
  FrmPlakettenverwaltung.UseProxy := iTmp;

  // SAP-System speichern
  DaMConnections.Plakini.WriteInteger(INI_SEC_SETTINGS, INI_KEY_SYSTEM, CoBSAPSystem.ItemIndex);
  FrmPlakettenverwaltung.SAPSystem := TPVSAPSystem(CoBSAPSystem.ItemIndex);
  // Hintergrundbild je nach SAPSystem laden
  FrmPlakettenverwaltung.LoadPicture();
  FrmPlakettenverwaltung.InitWebServicesData();

  // Anzeige aller tatsächlichen Bestandsbuchungen
  iTmp := 0;
  if ChbAllTransactions.Checked then
    iTmp := 1;
  DaMConnections.Plakini.WriteInteger(INI_SEC_SETTINGS, INI_KEY_ALLTRANSACTIONS, iTmp);
  FrmPlakettenverwaltung.AllTransactions := ChbAllTransactions.Checked;

  // weitere Control-Einstellungen speichern
  // Default-Depot
  DaMConnections.Plakini.WriteInteger(INI_SEC_CONTROLS, INI_KEY_DEFAULTDEPOT, CoBDefaultDepot.ItemIndex);
  // Plakettenschritte
  DaMConnections.Plakini.WriteInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENSTEPS, SpEPlakettensteps.Value);
end;

procedure TFrmEinstellungen.CoBConnectionTypeChange(Sender: TObject);
begin
  // Proxy für's Intranet verwenden und für's Internet ausschalten 
//  ChBProxy.Checked := TPVConnectionType(CoBConnectionType.ItemIndex) = ctIntranet;
end;

procedure TFrmEinstellungen.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := BBtnSchliessen.ModalResult;
end;

end.
