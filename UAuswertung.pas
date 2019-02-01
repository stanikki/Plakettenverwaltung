unit UAuswertung;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, DB, adsdata, adsfunc, adstable,
  Wwdatsrc, Grids, Wwdbigrd, Wwdbgrid, Spin, Mask,
  InvokeRegistry, ExtCtrls, Rio, SOAPHTTPClient, UAnzeigeSAP, TData, UPlakettenverwaltung, USelectSVData,
  CheckLst, RRReport;

type
  TFrmAuswertung = class(TForm)
    StBBottom: TStatusBar;
    GrBButtons: TGroupBox;
    BBtnSchliessen: TBitBtn;
    BBtnAktualisieren: TBitBtn;
    BBtnAbbrechen: TBitBtn;
    GrBErgebnis: TGroupBox;
    GrBDatenSelektieren1: TGroupBox;
    lblPlakettentyp: TLabel;
    lblPlakettenjahr: TLabel;
    lblBuchungskreis: TLabel;
    lblPersonalnummer: TLabel;
    DaTiPZeitraumVon: TDateTimePicker;
    CoBPlakettentyp: TComboBox;
    MaEBuchungskreis: TMaskEdit;
    MaEPersonalnummer: TMaskEdit;
    DaTiPZeitraumBis: TDateTimePicker;
    HTTPRIO: THTTPRIO;
    TmrErgebnis: TTimer;
    lblRequest: TLabel;
    MeRequest: TMemo;
    lblResponse: TLabel;
    MeResponse: TMemo;
    SAP_SVDATA_SVDATA: TAdsTable;
    DSrcAuswertungSAP_SVDATA: TwwDataSource;
    CoBPlakettenjahr: TComboBox;
    wwDBGridAuswertung_SVDATA: TwwDBGrid;
    DaTiPStichtag: TDateTimePicker;
    RaBZeitraum: TRadioButton;
    RaBStichtag: TRadioButton;
    GrBDatenSelektieren2: TGroupBox;
    ChBAlleBuchungenAnlisten: TCheckBox;
    ChBBestandsuebersicht: TCheckBox;
    lblToleranz: TLabel;
    SpEToleranz: TSpinEdit;
    RaBSollIstVergleich: TRadioButton;
    RaBBestandsanzeige: TRadioButton;
    lblBuchungsschluessel: TLabel;
    CoBBuchungsschluessel: TComboBox;
    lblVon: TLabel;
    lblBis: TLabel;
    ChLBBuchungsschluessel: TCheckListBox;
    BBtnDrucken: TBitBtn;
    SAP_SVDATA_SVDATAPTYP: TAdsStringField;
    SAP_SVDATA_SVDATAPJAHR: TAdsStringField;
    SAP_SVDATA_SVDATABDATUM: TAdsStringField;
    SAP_SVDATA_SVDATABSCHL: TAdsStringField;
    SAP_SVDATA_SVDATABSCHLBEZ: TAdsStringField;
    SAP_SVDATA_SVDATAKORRBK: TAdsStringField;
    SAP_SVDATA_SVDATAKORRDEPOT: TAdsStringField;
    SAP_SVDATA_SVDATADEPOTBEZ: TAdsStringField;
    SAP_SVDATA_SVDATAKORRSV: TAdsStringField;
    SAP_SVDATA_SVDATASVNAME: TAdsStringField;
    SAP_SVDATA_SVDATAPCNUMMER: TAdsStringField;
    SAP_SVDATA_SVDATAPCLNWNR: TAdsStringField;
    SAP_SVDATA_SVDATAPANZAHL: TAdsStringField;
    SAP_SVDATA_SVDATAPANZAHLO: TAdsStringField;
    SAP_SVDATA_SVDATAPBESTAND: TAdsStringField;
    SAP_SVDATA_SVDATAPBESTANDO: TAdsStringField;
    SAP_SVDATA_SVDATATBESTAND: TAdsStringField;
    SAP_SVDATA_SVDATAABWEICHUNG: TAdsStringField;
    SAP_SVDATA_SVDATAHINWEIS: TAdsStringField;
    SAP_SVDATA_SVDATASATZART: TAdsStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BBtnAktualisierenClick(Sender: TObject);
    procedure BBtnAbbrechenClick(Sender: TObject);
    procedure TmrErgebnisTimer(Sender: TObject);
    procedure HTTPRIOAfterExecute(const MethodName: String;
      SOAPResponse: TStream);
    procedure HTTPRIOBeforeExecute(const MethodName: String;
      var SOAPRequest: WideString);
    procedure StBBottomDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure RaBSollIstVergleichClick(Sender: TObject);
    procedure RaBBestandsanzeigeClick(Sender: TObject);
    procedure RaBZeitraumClick(Sender: TObject);
    procedure RaBStichtagClick(Sender: TObject);
    procedure ChLBBuchungsschluesselClickCheck(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BBtnDruckenClick(Sender: TObject);
    procedure GrBDatenSelektieren2Enter(Sender: TObject);
    procedure GrBDatenSelektieren1Enter(Sender: TObject);
  private
    { Private-Deklarationen }
    Abbort_SELECT_SVDATA: Boolean;
    PanelColor: TColor;
    function Validate(): Boolean;
    procedure EmptyTables(lPack: Boolean);
    procedure ConfigureTable(lStichtag: Boolean; lBestandsanzeige: Boolean; lBestandsuebersicht: Boolean; lAlleBuchungenAnlisten: Boolean);
  public
    { Public-Deklarationen }
  end;

var
  FrmAuswertung: TFrmAuswertung;

implementation

{$R *.dfm}

function GetTempDir(): string;
var
  Dir: string;
  Len: DWord;
begin
  SetLength(Dir,MAX_PATH);
  Len:=GetTempPath(MAX_PATH,PChar(Dir));
  if Len>0 then
  begin
    SetLength(Dir,Len);
    Result:=Dir;
  end
  else
    RaiseLastOSError;
end;

procedure TFrmAuswertung.ConfigureTable(lStichtag: Boolean; lBestandsanzeige: Boolean; lBestandsuebersicht: Boolean; lAlleBuchungenAnlisten: Boolean);
var lBestand_Stichtag,
    lBuchungen_Stichtag,
    lBestandBuchungen_Stichtag,
    lBuchungen_Zeitraum,
    lSollIst_Stichtag,
    lSollIstBuchungen_Stichtag,
    lDefault: Boolean;
begin

  if (DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_STATISTIK, INI_STATISTIK_DEF) = 0) then
  begin
    // Default-Anzeige, alles wird angezeigt
    lBestand_Stichtag := false;
    lBuchungen_Stichtag := false;
    lBestandBuchungen_Stichtag := false;
    lBuchungen_Zeitraum := false;
    lSollIst_Stichtag := false;
    lSollIstBuchungen_Stichtag := false;

    lDefault := true;
  end
  else
  begin
    // Anzeige Control-Abhängigkeit
    lBestand_Stichtag := (lStichtag and lBestandsanzeige and lBestandsuebersicht and not lAlleBuchungenAnlisten);
    lBuchungen_Stichtag := (lStichtag and lBestandsanzeige and not lBestandsuebersicht and lAlleBuchungenAnlisten);
    lBestandBuchungen_Stichtag := (lStichtag and lBestandsanzeige and lBestandsuebersicht and lAlleBuchungenAnlisten);
    lBuchungen_Zeitraum := (not lStichtag and lBestandsanzeige and not lBestandsuebersicht and lAlleBuchungenAnlisten);
    lSollIst_Stichtag := (lStichtag and not lBestandsanzeige and lBestandsuebersicht and not lAlleBuchungenAnlisten);
    lSollIstBuchungen_Stichtag := (lStichtag and not lBestandsanzeige and lBestandsuebersicht and lAlleBuchungenAnlisten);

    lDefault := not (lBestand_Stichtag or lBuchungen_Stichtag or lBestandBuchungen_Stichtag or lBuchungen_Zeitraum or lSollIst_Stichtag or lSollIstBuchungen_Stichtag);
  end;

  if lBestand_Stichtag then
  begin
    SAP_SVDATA_SVDATAPTYP.Visible := true;
    SAP_SVDATA_SVDATAPJAHR.Visible := true;
    SAP_SVDATA_SVDATABDATUM.Visible := true;
    SAP_SVDATA_SVDATABSCHL.Visible := true;
    SAP_SVDATA_SVDATABSCHLBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRBK.Visible := false;
    SAP_SVDATA_SVDATAKORRDEPOT.Visible := false;
    SAP_SVDATA_SVDATADEPOTBEZ.Visible := false;
    SAP_SVDATA_SVDATAKORRSV.Visible := false;
    SAP_SVDATA_SVDATASVNAME.Visible := false;
    SAP_SVDATA_SVDATAPCNUMMER.Visible := false;
    SAP_SVDATA_SVDATAPCLNWNR.Visible := false;
    SAP_SVDATA_SVDATAPANZAHL.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPANZAHLO.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPBESTAND.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATAPBESTANDO.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATATBESTAND.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAABWEICHUNG.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAHINWEIS.Visible := false;
    SAP_SVDATA_SVDATASATZART.Visible := false;
  end;

  if lBuchungen_Stichtag then
  begin
    SAP_SVDATA_SVDATAPTYP.Visible := true;
    SAP_SVDATA_SVDATAPJAHR.Visible := true;
    SAP_SVDATA_SVDATABDATUM.Visible := true;
    SAP_SVDATA_SVDATABSCHL.Visible := true;
    SAP_SVDATA_SVDATABSCHLBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRBK.Visible := false;
    SAP_SVDATA_SVDATAKORRDEPOT.Visible := true;
    SAP_SVDATA_SVDATADEPOTBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRSV.Visible := true;
    SAP_SVDATA_SVDATASVNAME.Visible := true;
    SAP_SVDATA_SVDATAPCNUMMER.Visible := true;
    SAP_SVDATA_SVDATAPCLNWNR.Visible := true;
    SAP_SVDATA_SVDATAPANZAHL.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPANZAHLO.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPBESTAND.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATAPBESTANDO.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATATBESTAND.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAABWEICHUNG.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAHINWEIS.Visible := true;
    SAP_SVDATA_SVDATASATZART.Visible := false;
  end;

  if lBestandBuchungen_Stichtag then
  begin
    SAP_SVDATA_SVDATAPTYP.Visible := true;
    SAP_SVDATA_SVDATAPJAHR.Visible := true;
    SAP_SVDATA_SVDATABDATUM.Visible := true;
    SAP_SVDATA_SVDATABSCHL.Visible := true;
    SAP_SVDATA_SVDATABSCHLBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRBK.Visible := false;
    SAP_SVDATA_SVDATAKORRDEPOT.Visible := true;
    SAP_SVDATA_SVDATADEPOTBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRSV.Visible := true;
    SAP_SVDATA_SVDATASVNAME.Visible := true;
    SAP_SVDATA_SVDATAPCNUMMER.Visible := true;
    SAP_SVDATA_SVDATAPCLNWNR.Visible := true;
    SAP_SVDATA_SVDATAPANZAHL.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPANZAHLO.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPBESTAND.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATAPBESTANDO.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATATBESTAND.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAABWEICHUNG.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAHINWEIS.Visible := true;
    SAP_SVDATA_SVDATASATZART.Visible := false;
  end;

  if lBuchungen_Zeitraum then
  begin
    SAP_SVDATA_SVDATAPTYP.Visible := true;
    SAP_SVDATA_SVDATAPJAHR.Visible := true;
    SAP_SVDATA_SVDATABDATUM.Visible := true;
    SAP_SVDATA_SVDATABSCHL.Visible := true;
    SAP_SVDATA_SVDATABSCHLBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRBK.Visible := false;
    SAP_SVDATA_SVDATAKORRDEPOT.Visible := false;
    SAP_SVDATA_SVDATADEPOTBEZ.Visible := false;
    SAP_SVDATA_SVDATAKORRSV.Visible := false;
    SAP_SVDATA_SVDATASVNAME.Visible := false;
    SAP_SVDATA_SVDATAPCNUMMER.Visible := true;
    SAP_SVDATA_SVDATAPCLNWNR.Visible := true;
    SAP_SVDATA_SVDATAPANZAHL.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPANZAHLO.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPBESTAND.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATAPBESTANDO.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATATBESTAND.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAABWEICHUNG.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAHINWEIS.Visible := false;
    SAP_SVDATA_SVDATASATZART.Visible := false;
  end;

  if lSollIst_Stichtag then
  begin
    SAP_SVDATA_SVDATAPTYP.Visible := true;
    SAP_SVDATA_SVDATAPJAHR.Visible := true;
    SAP_SVDATA_SVDATABDATUM.Visible := true;
    SAP_SVDATA_SVDATABSCHL.Visible := true;
    SAP_SVDATA_SVDATABSCHLBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRBK.Visible := false;
    SAP_SVDATA_SVDATAKORRDEPOT.Visible := false;
    SAP_SVDATA_SVDATADEPOTBEZ.Visible := false;
    SAP_SVDATA_SVDATAKORRSV.Visible := false;
    SAP_SVDATA_SVDATASVNAME.Visible := false;
    SAP_SVDATA_SVDATAPCNUMMER.Visible := false;
    SAP_SVDATA_SVDATAPCLNWNR.Visible := false;
    SAP_SVDATA_SVDATAPANZAHL.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPANZAHLO.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPBESTAND.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATAPBESTANDO.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATATBESTAND.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAABWEICHUNG.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAHINWEIS.Visible := true;
    SAP_SVDATA_SVDATASATZART.Visible := false;
  end;

  if lSollIstBuchungen_Stichtag then
  begin
    SAP_SVDATA_SVDATAPTYP.Visible := true;
    SAP_SVDATA_SVDATAPJAHR.Visible := true;
    SAP_SVDATA_SVDATABDATUM.Visible := true;
    SAP_SVDATA_SVDATABSCHL.Visible := true;
    SAP_SVDATA_SVDATABSCHLBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRBK.Visible := false;
    SAP_SVDATA_SVDATAKORRDEPOT.Visible := true;
    SAP_SVDATA_SVDATADEPOTBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRSV.Visible := true;
    SAP_SVDATA_SVDATASVNAME.Visible := true;
    SAP_SVDATA_SVDATAPCNUMMER.Visible := true;
    SAP_SVDATA_SVDATAPCLNWNR.Visible := true;
    SAP_SVDATA_SVDATAPANZAHL.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPANZAHLO.Visible := lAlleBuchungenAnlisten;
    SAP_SVDATA_SVDATAPBESTAND.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATAPBESTANDO.Visible := lBestandsuebersicht;
    SAP_SVDATA_SVDATATBESTAND.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAABWEICHUNG.Visible := not lBestandsanzeige;
    SAP_SVDATA_SVDATAHINWEIS.Visible := true;
    SAP_SVDATA_SVDATASATZART.Visible := false;
  end;

  if lDefault then
  begin
    SAP_SVDATA_SVDATAPTYP.Visible := true;
    SAP_SVDATA_SVDATAPJAHR.Visible := true;
    SAP_SVDATA_SVDATABDATUM.Visible := true;
    SAP_SVDATA_SVDATABSCHL.Visible := true;
    SAP_SVDATA_SVDATABSCHLBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRBK.Visible := true;
    SAP_SVDATA_SVDATAKORRDEPOT.Visible := true;
    SAP_SVDATA_SVDATADEPOTBEZ.Visible := true;
    SAP_SVDATA_SVDATAKORRSV.Visible := true;
    SAP_SVDATA_SVDATASVNAME.Visible := true;
    SAP_SVDATA_SVDATAPCNUMMER.Visible := true;
    SAP_SVDATA_SVDATAPCLNWNR.Visible := true;
    SAP_SVDATA_SVDATAPANZAHL.Visible := true;
    SAP_SVDATA_SVDATAPANZAHLO.Visible := true;
    SAP_SVDATA_SVDATAPBESTAND.Visible := true;
    SAP_SVDATA_SVDATAPBESTANDO.Visible := true;
    SAP_SVDATA_SVDATATBESTAND.Visible := true;
    SAP_SVDATA_SVDATAABWEICHUNG.Visible := true;
    SAP_SVDATA_SVDATAHINWEIS.Visible := true;
    SAP_SVDATA_SVDATASATZART.Visible := true;
  end;

end;

function TFrmAuswertung.Validate(): Boolean;
var lRet: boolean;
  i, n: Integer;
begin
  lRet := true;

  // Anzahl der angehakten Checkboxen bestimmen
  n := 0;
  for i := 0 to ChLBBuchungsschluessel.Items.Count - 1 do
  begin
    if ChLBBuchungsschluessel.Checked[i] then
      Inc(n)
  end;
  if (n = 0) and RaBBestandsanzeige.Checked then
  begin
    SetFocusedControl(ChLBBuchungsschluessel);
    MessageDlg('Bitte gegen Sie mindestens einen Buchungsschlüssel an!', mtInformation, [mbOk], 0);
    lRet := false;
  end;

  Result := lRet;

end;

procedure TFrmAuswertung.EmptyTables(lPack: Boolean);
begin
  if SAP_SVDATA_SVDATA.Exclusive then
  begin
    SAP_SVDATA_SVDATA.EmptyTable;
    if lPack then
      SAP_SVDATA_SVDATA.PackTable;
  end
  else
  begin
    while not SAP_SVDATA_SVDATA.Eof do
    begin
      SAP_SVDATA_SVDATA.AdsDeleteRecord;
      SAP_SVDATA_SVDATA.AdsGotoTop;
    end;
  end;
end;

procedure TFrmAuswertung.FormCreate(Sender: TObject);
var I, nI, nDate: Integer;
begin
  // Panel 2 soll selber gezeichnet werden
  StBBottom.Panels[1].Style := psOwnerDraw;
  PanelColor := StBBottom.Color; // clBtnFace;

  SAP_SVDATA_SVDATAPTYP.DisplayLabel := 'Pl.Typ';
  SAP_SVDATA_SVDATAPJAHR.DisplayLabel := 'Pl.Jahr';
  SAP_SVDATA_SVDATABDATUM.DisplayLabel := 'B.Datum';
  SAP_SVDATA_SVDATABSCHL.DisplayLabel := 'B.Schl.';
  SAP_SVDATA_SVDATABSCHLBEZ.DisplayLabel := 'B.Schl.-Bezeichnung';
  SAP_SVDATA_SVDATABSCHLBEZ.DisplayWidth := 25;
  SAP_SVDATA_SVDATAKORRBK.DisplayLabel := 'BuKr.';
  SAP_SVDATA_SVDATAKORRDEPOT.DisplayLabel := 'PR';
  SAP_SVDATA_SVDATADEPOTBEZ.DisplayLabel := 'PR-Bezeichnung';
  SAP_SVDATA_SVDATADEPOTBEZ.DisplayWidth := 25;
  SAP_SVDATA_SVDATAKORRSV.DisplayLabel := 'PersNr.';
  SAP_SVDATA_SVDATASVNAME.DisplayLabel := 'Name MA/Bew.';
  SAP_SVDATA_SVDATASVNAME.DisplayWidth := 25;
  SAP_SVDATA_SVDATAPCNUMMER.DisplayLabel := 'PCNr';
  SAP_SVDATA_SVDATAPCLNWNR.DisplayLabel := 'PCLnw';
  SAP_SVDATA_SVDATAPANZAHL.DisplayLabel := 'Anzahl';
  SAP_SVDATA_SVDATAPANZAHL.DisplayWidth := 5;
  SAP_SVDATA_SVDATAPANZAHLO.DisplayLabel := 'Anz. offen';
  SAP_SVDATA_SVDATAPANZAHLO.DisplayWidth := 5;
  SAP_SVDATA_SVDATAPBESTAND.DisplayLabel := 'Bestand';
  SAP_SVDATA_SVDATAPBESTAND.DisplayWidth := 5;
  SAP_SVDATA_SVDATAPBESTANDO.DisplayLabel := 'Best. offen';
  SAP_SVDATA_SVDATAPBESTANDO.DisplayWidth := 5;
  SAP_SVDATA_SVDATATBESTAND.DisplayLabel := 'Tats. Bestand';
  SAP_SVDATA_SVDATATBESTAND.DisplayWidth := 5;
  SAP_SVDATA_SVDATAABWEICHUNG.DisplayLabel := 'Abweichung';
  SAP_SVDATA_SVDATAABWEICHUNG.DisplayWidth := 5;
  SAP_SVDATA_SVDATAHINWEIS.DisplayLabel := 'Hinweis';
  SAP_SVDATA_SVDATAHINWEIS.DisplayWidth := 25;
  SAP_SVDATA_SVDATASATZART.DisplayLabel := 'Satzart';

  // DB wird zum leeren exclusiv geöffnet!
  // für den Report muss die DB aber normal geöffnet sein!
  SAP_SVDATA_SVDATA.Open;
  if SAP_SVDATA_SVDATA.Active and SAP_SVDATA_SVDATA.AdsIsTableEncrypted then
    SAP_SVDATA_SVDATA.AdsEnableEncryption(DEF_TBL_KEY);

  // alle Datenbanken des WebServices leeren
  EmptyTables(true);
  SAP_SVDATA_SVDATA.Close;
  SAP_SVDATA_SVDATA.Exclusive := false;
  SAP_SVDATA_SVDATA.Open;
  if SAP_SVDATA_SVDATA.Active and SAP_SVDATA_SVDATA.AdsIsTableEncrypted then
    SAP_SVDATA_SVDATA.AdsEnableEncryption(DEF_TBL_KEY);

  // Controls-Initialisierung über Plakettenverwaltung.ini
  SpEToleranz.Increment := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENSTEPS, INI_PLAKETTENSTEPS_DEF);
{
  nDate := StrToInt(FormatDateTime('yyyy', Now())) - 2;
  I := CoBPlakettenjahr.Items.Add(TXT_ALLE);
  for nI := nDate to nDate + 5 do
  begin
    I := CoBPlakettenjahr.Items.Add(IntToStr(nI));
  end;
  CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(TXT_ALLE);
}
  I := CoBPlakettenjahr.Items.Add(TXT_ALLE);
  for nI := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENJAHRVON, INI_PLAKETTENJAHRVON_DEF) to DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENJAHRBIS, INI_PLAKETTENJAHRBIS_DEF) do
  begin
    I := CoBPlakettenjahr.Items.Add(IntToStr(nI));
  end;
  CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(TXT_ALLE);// CoBPlakettenjahr.Items.IndexOf(FormatDateTime('yyyy', Now()));

  DaTiPZeitraumVon.Date := Now();
  DaTiPZeitraumBis.Date := Now();
  DaTiPStichtag.Date := Now();

end;

procedure TFrmAuswertung.FormShow(Sender: TObject);
var I: Integer;
begin

  Abbort_SELECT_SVDATA := false;
  TmrErgebnis.Interval := PRG_ABBORT_CHECKTIME;

  PanelColor := StBBottom.Color;
  StBBottom.Panels[1].Text := 'Status der Anfrage:';
  StBBottom.Repaint();

  // erst leeren, damit sich die Einträge nicht verdoppeln
  CoBPlakettentyp.Items.Clear;
  CoBPlakettentyp.Hint := '';
  FrmWertePruef.SAP_INFOS_PLTYP.AdsGotoTop;
  I := CoBPlakettentyp.Items.Add(TXT_ALLE);
  while not FrmWertePruef.SAP_INFOS_PLTYP.Eof do
  begin
    I := CoBPlakettentyp.Items.Add(FrmWertePruef.SAP_INFOS_PLTYP.FieldByName('Plakettentyp').AsString);
    CoBPlakettentyp.Hint := CoBPlakettentyp.Hint + FrmWertePruef.SAP_INFOS_PLTYP.FieldByName('Plakettentyp').AsString + ' - ' + FrmWertePruef.SAP_INFOS_PLTYP.FieldByName('Bezeichnung').AsString + #13;
    FrmWertePruef.SAP_INFOS_PLTYP.AdsSkip(1);
  end;
  CoBPlakettentyp.ItemIndex := 0;

  // erst leeren, damit sich die Einträge nicht verdoppeln
  ChLBBuchungsschluessel.Items.Clear;
  ChLBBuchungsschluessel.Hint := '';
  FrmWertePruef.SAP_INFOS_BSCHL.AdsGotoTop;
  I := ChLBBuchungsschluessel.Items.Add(TXT_ALLE);
  while not FrmWertePruef.SAP_INFOS_BSCHL.Eof do
  begin
    I := ChLBBuchungsschluessel.Items.Add(FrmWertePruef.SAP_INFOS_BSCHL.FieldByName('Buchungsschluessel').AsString);
    ChLBBuchungsschluessel.Hint := ChLBBuchungsschluessel.Hint + FrmWertePruef.SAP_INFOS_BSCHL.FieldByName('Buchungsschluessel').AsString + ' - ' + FrmWertePruef.SAP_INFOS_BSCHL.FieldByName('Bezeichnung').AsString + #13;
    FrmWertePruef.SAP_INFOS_BSCHL.AdsSkip(1);
  end;
//  ChLBBuchungsschluessel.I

  // erst leeren, damit sich die Einträge nicht verdoppeln
  CoBBuchungsschluessel.Items.Clear;
  CoBBuchungsschluessel.Hint := '';
  FrmWertePruef.SAP_INFOS_BSCHL.AdsGotoTop;
  I := CoBBuchungsschluessel.Items.Add(TXT_ALLE);
  while not FrmWertePruef.SAP_INFOS_BSCHL.Eof do
  begin
    I := CoBBuchungsschluessel.Items.Add(FrmWertePruef.SAP_INFOS_BSCHL.FieldByName('Buchungsschluessel').AsString);
    CoBBuchungsschluessel.Hint := CoBBuchungsschluessel.Hint + FrmWertePruef.SAP_INFOS_BSCHL.FieldByName('Buchungsschluessel').AsString + ' - ' + FrmWertePruef.SAP_INFOS_BSCHL.FieldByName('Bezeichnung').AsString + #13;
    FrmWertePruef.SAP_INFOS_BSCHL.AdsSkip(1);
  end;
  CoBBuchungsschluessel.ItemIndex := 0;

  MaEBuchungskreis.Text := FrmPlakettenverwaltung.Buchungskreis;
  MaEPersonalnummer.Text := FrmPlakettenverwaltung.UserPNR;

//  CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(FormatDateTime('yyyy', Now()));

//  DaTiPZeitraumVon.Date := Now();
//  DaTiPZeitraumBis.Date := Now();
//  DaTiPStichtag.Date := Now();

end;

procedure TFrmAuswertung.BBtnAktualisierenClick(Sender: TObject);
var cErgebnis, cDatum1, cDatum2: String;
  i, n: Integer;
  aElements: array of String;
  lAlleBS: boolean;
begin

  if Validate() then
  begin
    // strikte Auswertung erforderlich
    if MessageDlg('Die Anzeige wird gelöscht.' + #13 + #13 + 'Wollen Sie die Daten aktualisieren?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      BBtnAktualisieren.Enabled := false;
      BBtnSchliessen.Enabled := false;
      BBtnAbbrechen.Enabled := true;

      // Abbruch der Anfrage (neu) initialisieren
      Abbort_SELECT_SVDATA := false;

      // Evtl. Ende über Abbruch-Button
      TmrErgebnis.Enabled := true;

      PanelColor := clYellow;
      StBBottom.Panels[1].Text := 'Status der Anfrage: senden..';
      StBBottom.Repaint();

      EmptyTables(false);

      USelectSVData.SAP_SVDATA_SVDATA := SAP_SVDATA_SVDATA;
      USelectSVData.TblWSLOG := FrmPlakettenverwaltung.TblWSLOG;

      cErgebnis := '';

      // Anzahl der angehakten Checkboxen bestimmen
      n := 0;
      lAlleBS := false;
      for i := 0 to ChLBBuchungsschluessel.Items.Count - 1 do
      begin
        if ChLBBuchungsschluessel.Checked[i] then
        begin
          if not (ChLBBuchungsschluessel.Items.Strings[i] = TXT_ALLE) then
            Inc(n);
        end;
      end;
      // Text der angehakten Checkboxen auslesen
      SetLength(aElements, n);
      n := 0;
      for i := 0 to ChLBBuchungsschluessel.Items.Count - 1 do
      begin
        if ChLBBuchungsschluessel.Checked[i] then
        begin
          if not (ChLBBuchungsschluessel.Items.Strings[i] = TXT_ALLE) then
          begin
            aElements[n] := ChLBBuchungsschluessel.Items.Strings[i];
            Inc(n);
          end;
        end;
      end;

      if RaBStichtag.Checked then
      begin
        cDatum1 := FormatDateTime('yyyymmdd', DaTiPStichtag.DateTime);
        cDatum2 := '';
      end
      else
      begin
        cDatum1 := FormatDateTime('yyyymmdd', DaTiPZeitraumVon.DateTime);
        cDatum2 := FormatDateTime('yyyymmdd', DaTiPZeitraumBis.DateTime);
      end;

      // TODO 1 und TODO alte Plakettenjahre abfangen!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      // Spaltenauswahl, Spaltenanordnung, usw. je Auswahl festlegen
      self.ConfigureTable(RaBStichtag.Checked, RaBBestandsanzeige.Checked, ChBBestandsuebersicht.Checked, ChBAlleBuchungenAnlisten.Checked);

      if SendRequest_SELECT_SVDATA(cErgebnis, HTTPRIO, FrmPlakettenverwaltung.Buchungskreis, FrmPlakettenverwaltung.UserPNR, CoBPlakettenjahr.Text,
            cDatum1, cDatum2, CoBPlakettentyp.Text, aElements, RaBBestandsanzeige.Checked, RaBSollIstVergleich.Checked, IntToStr(SpEToleranz.Value),
            ChBBestandsuebersicht.Checked, ChBAlleBuchungenAnlisten.Checked, FrmPlakettenverwaltung.WebService_SelectSVData, FrmPlakettenverwaltung.UseProxy, FrmPlakettenverwaltung.WebService_User, FrmPlakettenverwaltung.WebService_Password) then
      begin
        PanelColor := clLime;
        if cErgebnis = '' then
          cErgebnis := 'Aktualisierung erfolgreich abgeschlossen!';
        StBBottom.Panels[1].Text := 'Status der Anfrage: ' + cErgebnis;
        StBBottom.Repaint();
      end
      else
      begin
        PanelColor := clRed;
        if cErgebnis = '' then
          cErgebnis := 'Fehler bei der Aktualisierung!';
        StBBottom.Panels[1].Text := 'Status der Anfrage: ' + cErgebnis;
        StBBottom.Repaint();

//        if not (cErgebnis = '') then
          MessageDlg(cErgebnis, mtError, [mbOK], 0);
      end;

      // Normales Ende
      TmrErgebnis.Enabled := false;

      BBtnAktualisieren.Enabled := true;
      BBtnAbbrechen.Enabled := false;
      BBtnSchliessen.Enabled := true;
      if RaBStichtag.Checked then
        BBtnDrucken.Enabled := true;
    end;
  end;
end;

procedure TFrmAuswertung.BBtnAbbrechenClick(Sender: TObject);
begin
  // gesendetet Anfrage abbrechen
  Abbort_SELECT_SVDATA := true;
end;

procedure TFrmAuswertung.TmrErgebnisTimer(Sender: TObject);
begin
  // Auf Abbruch über Abbruch-Button reagieren
  if Abbort_SELECT_SVDATA then
  begin
    TmrErgebnis.Enabled := false;
    PanelColor := clRed;
    StBBottom.Panels[1].Text := 'Status der Anfrage: Aktualisierung abgebrochen !';
    StBBottom.Repaint();

    BBtnAktualisieren.Enabled := true;
    BBtnSchliessen.Enabled := true;
    BBtnAbbrechen.Enabled := false;
  end;
end;

procedure TFrmAuswertung.HTTPRIOAfterExecute(const MethodName: String;
  SOAPResponse: TStream);
var
  StrStrm: TStringStream;
  ReqWideStr: WideString;
begin

  StrStrm := TStringStream.Create('');
  try
    StrStrm.CopyFrom(SOAPResponse, 0);
    SOAPResponse.Position := 0;
    ReqWideStr := StrStrm.DataString; // UTF8Decode(StrStrm.DataString);
  finally
    StrStrm.Free;
  end;

  // Response einlesen
  MeResponse.Text := ReqWideStr

end;

procedure TFrmAuswertung.HTTPRIOBeforeExecute(const MethodName: String;
  var SOAPRequest: WideString);
const cNS = 'tuvns';
begin

  // den Namespace für den Request korrekt setzen, ..
  SOAPRequest := DaMConnections.StringReplace(SOAPRequest, 'xmlns="urn:sap-com:document:sap:rfc:functions"', 'xmlns:' + cNS + '="urn:sap-com:document:sap:rfc:functions"');
  SOAPRequest := DaMConnections.StringReplace(SOAPRequest, '<' + MethodName, '<' + cNS + ':' + MethodName);
  SOAPRequest := DaMConnections.StringReplace(SOAPRequest, '</' + MethodName, '</' + cNS + ':' + MethodName);

  // .. Umlaute umwandeln und ..
  SOAPRequest := Utf8Encode(SOAPRequest);

  // .. Request vorm Senden auslesen
  MeRequest.Text := SOAPRequest;

end;

procedure TFrmAuswertung.StBBottomDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[1] then                   // zweites Panel
  begin
    with StatusBar.Canvas do
    begin
      Brush.Color := PanelColor;                        // Farbe aus dem Array
      FillRect(Rect);                                   // Mit der Farbe füllen
      TextOut(Rect.Left + 2, Rect.Top + 2, Panel.Text); // Textausgeben
    end;
  end;
end;

procedure TFrmAuswertung.RaBSollIstVergleichClick(Sender: TObject);
begin
  // alle angehakten Buchungsschlüssel abhaken ..
  ChLBBuchungsschluessel.ItemIndex := ChLBBuchungsschluessel.Items.IndexOf(TXT_ALLE);
  ChLBBuchungsschluessel.Checked[ChLBBuchungsschluessel.Items.IndexOf(TXT_ALLE)] := false;
  self.ChLBBuchungsschluesselClickCheck(Sender);
  // .. Controls disablen
  ChLBBuchungsschluessel.Enabled := not RaBSollIstVergleich.Checked;
  lblBuchungsschluessel.Enabled := not RaBSollIstVergleich.Checked;
  CoBBuchungsschluessel.ItemIndex := 0;
  CoBBuchungsschluessel.Enabled := not RaBSollIstVergleich.Checked;
  lblToleranz.Enabled := RaBSollIstVergleich.Checked;
  SpEToleranz.Enabled := RaBSollIstVergleich.Checked;
end;

procedure TFrmAuswertung.RaBBestandsanzeigeClick(Sender: TObject);
begin
  CoBBuchungsschluessel.Enabled := RaBBestandsanzeige.Checked;
  lblBuchungsschluessel.Enabled := RaBBestandsanzeige.Checked;
  ChLBBuchungsschluessel.Enabled := RaBBestandsanzeige.Checked;
  lblToleranz.Enabled := not RaBBestandsanzeige.Checked;
  SpEToleranz.Enabled := not RaBBestandsanzeige.Checked;
end;

procedure TFrmAuswertung.RaBZeitraumClick(Sender: TObject);
begin
  DaTiPStichtag.Enabled := RaBStichtag.Checked;
  DaTiPZeitraumVon.Enabled := not RaBStichtag.Checked;
  DaTiPZeitraumBis.Enabled := not RaBStichtag.Checked;
  lblVon.Enabled := not RaBStichtag.Checked;
  lblBis.Enabled := not RaBStichtag.Checked;
end;

procedure TFrmAuswertung.RaBStichtagClick(Sender: TObject);
begin
  DaTiPStichtag.Enabled := not RaBZeitraum.Checked;
  DaTiPZeitraumVon.Enabled := RaBZeitraum.Checked;
  DaTiPZeitraumBis.Enabled := RaBZeitraum.Checked;
  lblVon.Enabled := RaBZeitraum.Checked;
  lblBis.Enabled := RaBZeitraum.Checked;
end;

procedure TFrmAuswertung.ChLBBuchungsschluesselClickCheck(Sender: TObject);
var i: Integer;
begin
  // Klick auf Checkbox 'Alle'
  if ChLBBuchungsschluessel.Items.Strings[ChLBBuchungsschluessel.ItemIndex] = TXT_ALLE then
  begin
    // Checkbox 'Alle' wird angehakt
    if ChLBBuchungsschluessel.Checked[ChLBBuchungsschluessel.ItemIndex] then
    begin
      // Alle Checkboxen anhaken
      for i := 0 to ChLBBuchungsschluessel.Items.Count - 1 do
      begin
        if not (ChLBBuchungsschluessel.Items.Strings[i] = TXT_ALLE) then
          ChLBBuchungsschluessel.Checked[i] := true;
      end;
    end
    else // Checkbox 'Alle' abgehakt
    begin
      // Alle Checkboxen abhaken
      for i := 0 to ChLBBuchungsschluessel.Items.Count - 1 do
      begin
        if not (ChLBBuchungsschluessel.Items.Strings[i] = TXT_ALLE) then
          ChLBBuchungsschluessel.Checked[i] := false;
      end;
    end;
  end
  else // Klick auf einer Checkbox ausser Checkbox 'Alle'
    // eine Checkbox wird abgehakt
    if not (ChLBBuchungsschluessel.Checked[ChLBBuchungsschluessel.ItemIndex]) then
      // Checkbox 'Alle' ist angehakt
      if ChLBBuchungsschluessel.Checked[ChLBBuchungsschluessel.Items.IndexOf(TXT_ALLE)] then
        // CheckBox 'Alle' ebenfalls abhaken
        ChLBBuchungsschluessel.Checked[ChLBBuchungsschluessel.Items.IndexOf(TXT_ALLE)] := false;

end;

procedure TFrmAuswertung.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := BBtnSchliessen.ModalResult;
end;

procedure TFrmAuswertung.BBtnDruckenClick(Sender: TObject);
var
  cOutputDest: PChar;
  nReport, i: Integer;
  cTmp: string;
  RRReport: TRRReport;
begin

  RRReport := TRRReport.Create(PChar(ExtractFileName(Application.ExeName)), GetTempDir() + PRG_PRT_FILE);
  // Report liegt im selben Verzeichnis wie die Datenbank
  nReport := RRReport.chooseReportA(PChar(SAP_SVDATA_SVDATA.AdsConnection.ConnectPath + '\PlakettenAusw.rrw'), '');

  if nReport <> 0 then
  begin
    // set all window properties
    RRReport.setWinTitleA('Auswertung - Vorschau');

    // set all userparm for the report
    RRReport.setUserParamA('BUCHUNGSKREIS',         PChar(MaEBuchungskreis.Text));
    RRReport.setUserParamA('PERSONALNUMMER',        PChar(MaEPersonalnummer.Text));
    RRReport.setUserParamA('PJAHR',                 PChar(CoBPlakettenjahr.Text));
    // typs: Stichtag = 1, Zeitraum = 2
    cTmp := '1';
    if RaBZeitraum.Checked then
      cTmp := '2';
    RRReport.setUserParamA('AUSWERTUNGSTYP',        PChar(cTmp));
    RRReport.setUserParamA('STICHTAG',              PChar(FormatDateTime('dd.mm.yyyy', DaTiPStichtag.DateTime)));
    RRReport.setUserParamA('ZEITRAUMVON',           PChar(FormatDateTime('dd.mm.yyyy', DaTiPZeitraumVon.DateTime)));
    RRReport.setUserParamA('ZEITRAUMBIS',           PChar(FormatDateTime('dd.mm.yyyy', DaTiPZeitraumBis.DateTime)));
    RRReport.setUserParamA('PTYP',                  PChar(CoBPlakettentyp.Text));

    // get text of all selected checkboxes (format: foo;bar;..)
    cTmp := '';
    for i := 0 to ChLBBuchungsschluessel.Items.Count - 1 do
    begin
      if ChLBBuchungsschluessel.Checked[i] then
        cTmp := cTmp + ChLBBuchungsschluessel.Items[i] + ';';
    end;
    RRReport.setUserParamA('BUCHUNGSSCHLUESSEL',    PChar(cTmp));

    if RaBBestandsanzeige.Checked then
      RRReport.setUserParamA('BESTANDSANZEIGE',     'X');
    if RaBSollIstVergleich.Checked then
      RRReport.setUserParamA('SOLLISTVERGLEICH',    'X');

    RRReport.setUserParamA('ABWEICHUNGSTOLERANZ', PChar(SpEToleranz.Text));

    if ChBBestandsuebersicht.Checked then
      RRReport.setUserParamA('BESTANDSUEBERSICHT',  'X');
    if ChBAlleBuchungenAnlisten.Checked then
      RRReport.setUserParamA('ALLEBUCHUNGEN',       'X');

    // give visible colums to report
    if SAP_SVDATA_SVDATAPTYP.Visible then
      RRReport.setUserParamA('COL_TYP',             PChar(SAP_SVDATA_SVDATAPTYP.DisplayLabel));
    if SAP_SVDATA_SVDATAPJAHR.Visible then
      RRReport.setUserParamA('COL_JAHR',            PChar(SAP_SVDATA_SVDATAPJAHR.DisplayLabel));
    if SAP_SVDATA_SVDATABDATUM.Visible then
      RRReport.setUserParamA('COL_BDATUM',          PChar(SAP_SVDATA_SVDATABDATUM.DisplayLabel));
    if SAP_SVDATA_SVDATABSCHL.Visible then
      RRReport.setUserParamA('COL_ABSCHL',          PChar(SAP_SVDATA_SVDATABSCHL.DisplayLabel));
    if SAP_SVDATA_SVDATABSCHLBEZ.Visible then
      RRReport.setUserParamA('COL_ABSCHLBEZ',       PChar(SAP_SVDATA_SVDATABSCHLBEZ.DisplayLabel));
    if SAP_SVDATA_SVDATAKORRBK.Visible then
      RRReport.setUserParamA('COL_KORRBK',          PChar(SAP_SVDATA_SVDATAKORRBK.DisplayLabel));
    if SAP_SVDATA_SVDATAKORRDEPOT.Visible then
      RRReport.setUserParamA('COL_KORRDEPOT',       PChar(SAP_SVDATA_SVDATAKORRDEPOT.DisplayLabel));
    if SAP_SVDATA_SVDATADEPOTBEZ.Visible then
      RRReport.setUserParamA('COL_DEPOTBEZ',        PChar(SAP_SVDATA_SVDATADEPOTBEZ.DisplayLabel));
    if SAP_SVDATA_SVDATAKORRSV.Visible then
      RRReport.setUserParamA('COL_KORRSV',          PChar(SAP_SVDATA_SVDATAKORRSV.DisplayLabel));
    if SAP_SVDATA_SVDATASVNAME.Visible then
      RRReport.setUserParamA('COL_SVNAME',          PChar(SAP_SVDATA_SVDATASVNAME.DisplayLabel));
    if SAP_SVDATA_SVDATAPCNUMMER.Visible then
      RRReport.setUserParamA('COL_PCNUMMER',        PChar(SAP_SVDATA_SVDATAPCNUMMER.DisplayLabel));
    if SAP_SVDATA_SVDATAPCLNWNR.Visible then
      RRReport.setUserParamA('COL_PCLNWNR',         PChar(SAP_SVDATA_SVDATAPCLNWNR.DisplayLabel));
    if SAP_SVDATA_SVDATAPANZAHL.Visible then
      RRReport.setUserParamA('COL_PANZAHL',         PChar(SAP_SVDATA_SVDATAPANZAHL.DisplayLabel));
    if SAP_SVDATA_SVDATAPANZAHLO.Visible then
      RRReport.setUserParamA('COL_PANZAHLO',        PChar(SAP_SVDATA_SVDATAPANZAHLO.DisplayLabel));
    if SAP_SVDATA_SVDATAPBESTAND.Visible then
      RRReport.setUserParamA('COL_PBESTAND',        PChar(SAP_SVDATA_SVDATAPBESTAND.DisplayLabel));
    if SAP_SVDATA_SVDATAPBESTANDO.Visible then
      RRReport.setUserParamA('COL_PBESTANDO',       PChar(SAP_SVDATA_SVDATAPBESTANDO.DisplayLabel));
    if SAP_SVDATA_SVDATATBESTAND.Visible then
      RRReport.setUserParamA('COL_BESTAND',         PChar(SAP_SVDATA_SVDATATBESTAND.DisplayLabel));
    if SAP_SVDATA_SVDATAABWEICHUNG.Visible then
      RRReport.setUserParamA('COL_ABWEICHUNG',      PChar(SAP_SVDATA_SVDATAABWEICHUNG.DisplayLabel));
    if SAP_SVDATA_SVDATAHINWEIS.Visible then
      RRReport.setUserParamA('COL_HINWEIS',         PChar(SAP_SVDATA_SVDATAHINWEIS.DisplayLabel));
    if SAP_SVDATA_SVDATASATZART.Visible then
      RRReport.setUserParamA('COL_SATZART',         PChar(SAP_SVDATA_SVDATASATZART.DisplayLabel));
      
    // D -> Display
    // F -> File
    // P -> Printer (also PDF-Converter)
    cOutputDest := 'D';
    RRReport.setOutputDestA(cOutputDest);
    if cOutputDest = 'P' then
    begin
      // todo: the amyuni pdf-driver must be activated before use
      RRReport.setPrinterA(PRG_PDF_DRV);
      RRReport.setOutputFileA(PChar(GetTempDir() + 'tmp.pdf'));
    end
    else
      // use the windows-default printer
      RRReport.setPrinterA('Default');

    // start report
    RRReport.execRuntimeA(false, 2);

    // free all resources      
    RRReport.endReportA();
    RRReport.Destroy;
    RRReport := NIL;
  end;

end;

procedure TFrmAuswertung.GrBDatenSelektieren1Enter(Sender: TObject);
begin
  BBtnDrucken.Enabled := false;
end;

procedure TFrmAuswertung.GrBDatenSelektieren2Enter(Sender: TObject);
begin
  BBtnDrucken.Enabled := false;
end;

end.


