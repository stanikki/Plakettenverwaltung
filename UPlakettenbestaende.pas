unit UPlakettenbestaende;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, InvokeRegistry, Rio, SOAPHTTPClient, ComCtrls,
  ExtCtrls, DB, adsdata, adsfunc, adstable,
  Wwdatsrc, Grids, Wwdbigrd, Wwdbgrid, SOAPHTTPTrans, UGetSVData, USetSVData;

type
  TFrmPlakettenbestaende = class(TForm)
    GrBButtons: TGroupBox;
    BBtnSchliessen: TBitBtn;
    BBtnAktualisieren: TBitBtn;
    BBtnAbbrechen: TBitBtn;
    HTTPRIO: THTTPRIO;
    TmrErgebnis: TTimer;
    StBBottom: TStatusBar;
    DSrcPlakettenverwaltung_EPLAK: TwwDataSource;
    SAP_SVDATA_EPLAK: TAdsTable;
    wwDBGridPlakettenbestaende_APLAK: TwwDBGrid;
    DSrcPlakettenverwaltung_APLAK: TwwDataSource;
    SAP_SVDATA_APLAK: TAdsTable;
    DSrcPlakettenverwaltung_VBBST: TwwDataSource;
    SAP_SVDATA_VBBST: TAdsTable;
    DSrcPlakettenverwaltung_TSBST: TwwDataSource;
    SAP_SVDATA_TSBST: TAdsTable;
    MeRequest: TMemo;
    MeResponse: TMemo;
    lblRequest: TLabel;
    lblResponse: TLabel;
    SAP_SVDATA_APLAKPlakettentyp: TAdsStringField;
    SAP_SVDATA_APLAKPlakettenjahr: TAdsStringField;
    SAP_SVDATA_APLAKBuchungsdatum: TAdsStringField;
    SAP_SVDATA_APLAKZielBuchungskreis: TAdsStringField;
    SAP_SVDATA_APLAKZielDepot: TAdsStringField;
    SAP_SVDATA_APLAKZielPNr: TAdsStringField;
    SAP_SVDATA_APLAKPlakettenbelegNr: TAdsStringField;
    SAP_SVDATA_APLAKPlakettenanzahl: TAdsStringField;
    SAP_SVDATA_APLAKBezeichnung: TAdsStringField;
    SAP_SVDATA_APLAKUpdateKennzeichen: TAdsStringField;
    BtnErhaltBest: TButton;
    GrBErhaltene: TGroupBox;
    GrBVerbucht: TGroupBox;
    GrBPlakettenabg: TGroupBox;
    GrBTatsaechlicherB: TGroupBox;
    BtnBSTErfassen: TButton;
    BtnBSTBearbeiten: TButton;
    BtnBSTLoeschen: TButton;
    BtnPLAKErfassen: TButton;
    BtnPLAKBearbeiten: TButton;
    BtnPLAKLoeschen: TButton;
    BBtnUebernehmen: TBitBtn;
    RaBEingabenbuchen: TRadioButton;
    RaBEingabenpruefen: TRadioButton;
    BBtnAbbrechen2: TBitBtn;
    SAP_SVDATA_VBBSTPlakettenjahr: TAdsStringField;
    SAP_SVDATA_VBBSTPlakettentyp: TAdsStringField;
    SAP_SVDATA_VBBSTPlakettenbestand: TAdsStringField;
    wwDBGridPlakettenbestaende_VBBST: TwwDBGrid;
    SAP_SVDATA_EPLAKPlakettentyp: TAdsStringField;
    SAP_SVDATA_EPLAKPlakettenjahr: TAdsStringField;
    SAP_SVDATA_EPLAKBuchungsdatum: TAdsStringField;
    SAP_SVDATA_EPLAKQuellBuchungskreis: TAdsStringField;
    SAP_SVDATA_EPLAKQuellDepot: TAdsStringField;
    SAP_SVDATA_EPLAKQuellPNr: TAdsStringField;
    SAP_SVDATA_EPLAKPlakettenbelegNr: TAdsStringField;
    SAP_SVDATA_EPLAKPlakettenanzahl: TAdsStringField;
    SAP_SVDATA_EPLAKBezeichnung: TAdsStringField;
    SAP_SVDATA_EPLAKErhaltenKennzeichen: TAdsStringField;
    SAP_SVDATA_TSBSTBuchungsdatum: TAdsStringField;
    SAP_SVDATA_TSBSTPlakettenjahr: TAdsStringField;
    SAP_SVDATA_TSBSTPlakettentyp: TAdsStringField;
    SAP_SVDATA_TSBSTPlakettenbelegNr: TAdsStringField;
    SAP_SVDATA_TSBSTPlakettenbestand: TAdsStringField;
    SAP_SVDATA_TSBSTUpdateKennzeichen: TAdsStringField;
    wwDBGridPlakettenbestaende_TSBST: TwwDBGrid;
    wwDBGridPlakettenbestaende_EPLAK: TwwDBGrid;
    procedure BBtnSchliessenClick(Sender: TObject);
    procedure StBBottomDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure BBtnAbbrechenClick(Sender: TObject);
    procedure TmrErgebnisTimer(Sender: TObject);
    procedure BBtnAktualisierenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HTTPRIOBeforeExecute(const MethodName: String;
      var SOAPRequest: WideString);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HTTPRIOAfterExecute(const MethodName: String;
      SOAPResponse: TStream);
    procedure BtnErhaltBestClick(Sender: TObject);
    procedure BtnPLAKBearbeitenClick(Sender: TObject);
    procedure BtnPLAKLoeschenClick(Sender: TObject);
    procedure BtnBSTBearbeitenClick(Sender: TObject);
    procedure BtnBSTLoeschenClick(Sender: TObject);
    procedure BtnPLAKErfassenClick(Sender: TObject);
    procedure BtnBSTErfassenClick(Sender: TObject);
    procedure BBtnUebernehmenClick(Sender: TObject);
    procedure wwDBGridPlakettenbestaende_EPLAKKeyPress(Sender: TObject;
      var Key: Char);
    procedure wwDBGridPlakettenbestaende_APLAKKeyPress(Sender: TObject;
      var Key: Char);
    procedure wwDBGridPlakettenbestaende_TSBSTKeyPress(Sender: TObject;
      var Key: Char);
    procedure BBtnAbbrechen2Click(Sender: TObject);
    procedure RaBEingabenbuchenClick(Sender: TObject);
    procedure RaBEingabenpruefenClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure wwDBGridPlakettenbestaende_TSBSTTitleButtonClick(
      Sender: TObject; AFieldName: String);
  private
    { Private-Deklarationen }
    Question: Boolean;
    PanelColor: TColor;
    procedure EmptyTables(lPack: Boolean);
    procedure ChangeIndexName(AFieldName: String);
    procedure SetIndexColor(AFieldName: String);
  public
    { Public-Deklarationen }
    Abbort_GET_SVDATA: Boolean;
    Abbort_SET_SVDATA: Boolean;
  end;

var
  FrmPlakettenbestaende: TFrmPlakettenbestaende;

implementation

{$R *.dfm}

uses
  TData, UPlakettenverwaltung, UPlakettenabgaenge, UTatsaechlicherBestand;

procedure TFrmPlakettenbestaende.EmptyTables(lPack: Boolean);
begin
  SAP_SVDATA_EPLAK.EmptyTable;
  SAP_SVDATA_APLAK.EmptyTable;
  SAP_SVDATA_TSBST.EmptyTable;
  SAP_SVDATA_VBBST.EmptyTable;

  if lPack then
  begin
    SAP_SVDATA_EPLAK.PackTable;
    SAP_SVDATA_APLAK.PackTable;
    SAP_SVDATA_TSBST.PackTable;
    SAP_SVDATA_VBBST.PackTable;
  end;
end;

// kiek 27.06.12, lfd.Nr./Beschreibung 904/2
// Sortierung über DB-Indexe durch Buttons in Titelzeile möglich
procedure TFrmPlakettenbestaende.ChangeIndexName(AFieldName: String);
var cTmp: String;
begin
  // D -> descending, A -> ascending
  if (SAP_SVDATA_TSBST.IndexName = '') then
    // wenn kein Index gesetzt ist, dann als Default den absteigenden Index einstellen
    SAP_SVDATA_TSBST.IndexName := 'D_' + AFieldName
  else
    cTmp := SAP_SVDATA_TSBST.IndexName;
    // Prefix (A_ oder D_) entfernen, somit bleibt der reine Spaltenname übrig
    Delete(cTmp,1,2);
    if cTmp = AFieldName then
      // innerhalb der gleichen Spalte den Index wechseln
      if SAP_SVDATA_TSBST.IndexName[1] = 'A' then
        SAP_SVDATA_TSBST.IndexName := 'D_' + AFieldName
      else
        SAP_SVDATA_TSBST.IndexName := 'A_' + AFieldName
    else
      // bei Auswahl einer neuen Spalte den absteigenden Index einstellen
      SAP_SVDATA_TSBST.IndexName := 'D_' + AFieldName
end;

// kiek 27.06.12, lfd.Nr./Beschreibung 904/2
// Index je nach Sortierung im Spaltenfuss farblich kennzeichnen
procedure TFrmPlakettenbestaende.SetIndexColor(AFieldName: String);
begin
  // gewählte Spalte setzen
  // damit der Aufwang gering bleibt, erst alle Spalten zurücksetzen..
  wwDBGridPlakettenbestaende_TSBST.ColumnByName('Buchungsdatum').FooterValue := '';
  wwDBGridPlakettenbestaende_TSBST.ColumnByName('Plakettenjahr').FooterValue := '';
  wwDBGridPlakettenbestaende_TSBST.ColumnByName('Plakettentyp').FooterValue := '';
  wwDBGridPlakettenbestaende_TSBST.ColumnByName('Plakettenbeleg-Nr').FooterValue := '';
  wwDBGridPlakettenbestaende_TSBST.ColumnByName('Plakettenbestand').FooterValue := '';
  wwDBGridPlakettenbestaende_TSBST.ColumnByName('Update-Kennzeichen').FooterValue := '';
  // .. und dann die ausgewählte Spalte setzen
  wwDBGridPlakettenbestaende_TSBST.ColumnByName(AFieldName).FooterValue := ' ';

  // Farbe bestimmen und setzen
  // D steht für descending, also absteigend (rot)
  // A steht für ascending, also aufsteigend (gelb)
  if SAP_SVDATA_TSBST.IndexName[1] = 'D' then
    wwDBGridPlakettenbestaende_TSBST.FooterCellColor := clRed
  else
    wwDBGridPlakettenbestaende_TSBST.FooterCellColor := clYellow;
end;

procedure TFrmPlakettenbestaende.BBtnSchliessenClick(Sender: TObject);
begin
  if MessageDlg('Alle temporären Änderungen gehen verloren.' + #13 + #13 + 'Wollen Sie das Fenster schließen?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    // alle Datenbanken des WebServices leeren
    EmptyTables(true);

    Close();
  end
  else
    ModalResult := mrNone;
end;

procedure TFrmPlakettenbestaende.StBBottomDrawPanel(StatusBar: TStatusBar;
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

procedure TFrmPlakettenbestaende.BBtnAbbrechenClick(Sender: TObject);
begin
  // gesendetet Anfrage abbrechen
  Abbort_GET_SVDATA := true;
end;

procedure TFrmPlakettenbestaende.TmrErgebnisTimer(Sender: TObject);
begin
  // Auf Abbruch über Abbruch-Button reagieren
  if Abbort_GET_SVDATA then
  begin
    TmrErgebnis.Enabled := false;
    PanelColor := clRed;
    StBBottom.Panels[1].Text := 'Status der Anfrage: Aktualisierung abgebrochen !';
    StBBottom.Repaint();

    BBtnAktualisieren.Enabled := true;
    BBtnSchliessen.Enabled := true;
    BBtnAbbrechen.Enabled := false;
  end;

  // Auf Abbruch über Abbruch-Button reagieren
  if Abbort_SET_SVDATA then
  begin
    TmrErgebnis.Enabled := false;
    PanelColor := clRed;
    StBBottom.Panels[1].Text := 'Status der Anfrage: Aktualisierung abgebrochen !';
    StBBottom.Repaint();

    BBtnAktualisieren.Enabled := true;
    BBtnSchliessen.Enabled := true;
    BBtnAbbrechen2.Enabled := false;
  end;
end;

procedure TFrmPlakettenbestaende.BBtnAktualisierenClick(Sender: TObject);
var cErgebnis: String;
begin

  // strikte Auswertung erforderlich
  if not Question or (MessageDlg('Alle temporären Änderungen gehen verloren.' + #13 + #13 + 'Wollen Sie die Daten aktualisieren?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    BBtnAktualisieren.Enabled := false;
    BBtnSchliessen.Enabled := false;
    BBtnAbbrechen.Enabled := true;

    // Abbruch der Anfrage (neu) initialisieren
    Abbort_GET_SVDATA := false;

    // Evtl. Ende über Abbruch-Button
    TmrErgebnis.Enabled := true;

    PanelColor := clYellow;
    StBBottom.Panels[1].Text := 'Status der Anfrage: senden..';
    StBBottom.Repaint();

    EmptyTables(false);

    UGetSVData.SAP_SVDATA_EPLAK := SAP_SVDATA_EPLAK;
    UGetSVData.SAP_SVDATA_APLAK := SAP_SVDATA_APLAK;
    UGetSVData.SAP_SVDATA_VBBST := SAP_SVDATA_VBBST;
    UGetSVData.SAP_SVDATA_TSBST := SAP_SVDATA_TSBST;
    UGetSVData.TblWSLOG := FrmPlakettenverwaltung.TblWSLOG;

    cErgebnis := '';

    if SendRequest_GET_SVDATA(cErgebnis, HTTPRIO, FrmPlakettenverwaltung.Buchungskreis, FrmPlakettenverwaltung.UserPNR, FrmPlakettenverwaltung.WebService_GetSVData, FrmPlakettenverwaltung.UseProxy, FrmPlakettenverwaltung.WebService_User, FrmPlakettenverwaltung.WebService_Password, FrmPlakettenverwaltung.AllTransactions) then
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

//      if not (cErgebnis = '') then
        MessageDlg(cErgebnis, mtError, [mbOK], 0);
    end;

    // Normales Ende
    TmrErgebnis.Enabled := false;

    BBtnAktualisieren.Enabled := true;
    BBtnSchliessen.Enabled := true;
    BBtnAbbrechen.Enabled := false;
  end;
end;

procedure TFrmPlakettenbestaende.FormShow(Sender: TObject);
var cIndexName: String;
begin
  Abbort_GET_SVDATA := false;
  TmrErgebnis.Interval := PRG_ABBORT_CHECKTIME;

  Question := false;
  BBtnAktualisierenClick(Sender);

  // Spaltensortierung farblich kennzeichnen
  // kiek 27.06.12, lfd.Nr./Beschreibung 904/2
  cIndexName := SAP_SVDATA_TSBST.IndexName;
  // Prefix (A_ oder D_) entfernen, somit bleibt der reine Spaltenname übrig 
  Delete(cIndexName,1,2);
  SetIndexColor(cIndexName);

  Question := true;

end;

procedure TFrmPlakettenbestaende.HTTPRIOBeforeExecute(
  const MethodName: String; var SOAPRequest: WideString);
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

procedure TFrmPlakettenbestaende.FormCreate(Sender: TObject);
var
  ahI: array of Integer;
  nI: Integer;
begin
  // Panel 2 soll selber gezeichnet werden
  StBBottom.Panels[1].Style := psOwnerDraw;
  PanelColor := StBBottom.Color; // clBtnFace;

  Question := true;

  SAP_SVDATA_EPLAKBezeichnung.DisplayWidth := 30;
  SAP_SVDATA_EPLAKErhaltenKennzeichen.DisplayLabel := 'Erhalten';

  SAP_SVDATA_EPLAK.Open;
  if SAP_SVDATA_EPLAK.Active then
    if SAP_SVDATA_EPLAK.AdsIsTableEncrypted then
      SAP_SVDATA_EPLAK.AdsEnableEncryption(DEF_TBL_KEY);

  SAP_SVDATA_APLAKBezeichnung.DisplayWidth := 30;
  SAP_SVDATA_APLAKUpdateKennzeichen.DisplayLabel := 'Update';

  SAP_SVDATA_APLAK.Open;
  if SAP_SVDATA_APLAK.Active then
    if SAP_SVDATA_APLAK.AdsIsTableEncrypted then
      SAP_SVDATA_APLAK.AdsEnableEncryption(DEF_TBL_KEY);

  SAP_SVDATA_VBBST.Open;
  if SAP_SVDATA_VBBST.Active then
    if SAP_SVDATA_VBBST.AdsIsTableEncrypted then
      SAP_SVDATA_VBBST.AdsEnableEncryption(DEF_TBL_KEY);

  SAP_SVDATA_TSBSTUpdateKennzeichen.DisplayLabel := 'Update';

  SAP_SVDATA_TSBST.Open;
  if SAP_SVDATA_TSBST.Active then
  begin
    if SAP_SVDATA_TSBST.AdsIsTableEncrypted then
      SAP_SVDATA_TSBST.AdsEnableEncryption(DEF_TBL_KEY);

    // kiek 27.06.12, lfd.Nr./Beschreibung 904/2
    // gespeicherten Index einstellen (evtl. Verprobung notwendig, ob der Index überhaupt existiert!)
    SAP_SVDATA_TSBST.IndexName := DaMConnections.Plakini.ReadString(INI_SEC_CONTROLS, INI_KEY_TSBSTINDEX, INI_TSBSTINDEX_DEF);
  end;
  
  // alle Datenbanken des WebServices leeren
//  EmptyTables();

end;

procedure TFrmPlakettenbestaende.FormDestroy(Sender: TObject);
begin
  SAP_SVDATA_EPLAK.Close;
  SAP_SVDATA_APLAK.Close;
  SAP_SVDATA_VBBST.Close;
  // kiek 27.06.12, lfd.Nr./Beschreibung 904/2
  // eingestellten Index speichern
  DaMConnections.Plakini.WriteString(INI_SEC_CONTROLS, 'TSBSTIndex', SAP_SVDATA_TSBST.IndexName);
  SAP_SVDATA_TSBST.Close;
end;

procedure TFrmPlakettenbestaende.HTTPRIOAfterExecute(
  const MethodName: String; SOAPResponse: TStream);
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

procedure TFrmPlakettenbestaende.BtnErhaltBestClick(Sender: TObject);
begin
  if SAP_SVDATA_EPLAK.RecordCount > 0 then
  begin
    if SAP_SVDATA_EPLAK.FieldByName('Erhalten-Kennzeichen').AsString = 'X' then
    begin
      MessageDlg('Plaketten wurden bereits als "Erhalten" gekennzeichnet!', mtError, [mbOK], 0);
    end
    else
    begin
      if MessageDlg('Plaketten als "Erhalten" kennzeichnen?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        SAP_SVDATA_EPLAK.Edit;
        SAP_SVDATA_EPLAK.FieldByName('Erhalten-Kennzeichen').AsString := 'X';
        SAP_SVDATA_EPLAK.Post;
      end;
    end;
  end
  else
    MessageDlg('Es wurde kein Datensatz gekennzeichnet!', mtError, [mbOK], 0);
end;

procedure TFrmPlakettenbestaende.BtnPLAKBearbeitenClick(Sender: TObject);
var s: Char;
  Kennz: String;
begin
  if SAP_SVDATA_APLAK.RecordCount > 0 then
  begin
    s := ' ';
    Kennz := SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString;
    if Length(Kennz) > 0 then
      s := Kennz[1];
    case s of
//      'I': MessageDlg('Plakettenabgang wurde eingefügt!', mtError, [mbOK], 0);
      'D': MessageDlg('Plakettenabgang wurde bereits als "Gelöscht" gekennzeichnet!', mtError, [mbOK], 0);
//      'U': MessageDlg('Plakettenabgang wurde bereits bearbeitet!', mtError, [mbOK], 0);
    else
      FrmPlakettenabgaenge.Modus := fmEdit;
      FrmPlakettenabgaenge.ShowModal;
    end;
  end
  else
    MessageDlg('Es ist kein Datensatz zum Bearbeiten gekennzeichnet!', mtError, [mbOK], 0);
end;

procedure TFrmPlakettenbestaende.BtnPLAKLoeschenClick(Sender: TObject);
var s: Char;
  Kennz: String;
begin
  if SAP_SVDATA_APLAK.RecordCount > 0 then
  begin
    s := ' ';
    Kennz := SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString;
    if Length(Kennz) > 0 then
      s := Kennz[1];
    case s of
      'I': MessageDlg('Plakettenabgang wurde eingefügt!', mtError, [mbOK], 0);
      'D': MessageDlg('Plakettenabgang wurde bereits als "Gelöscht" gekennzeichnet!', mtError, [mbOK], 0);
//    'U': MessageDlg('Plakettenabgang wurde bereits bearbeitet!', mtError, [mbOK], 0);
    else
      if MessageDlg('Plakettenabgang wirklich als "Gelöscht" kennzeichnen?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        SAP_SVDATA_APLAK.Edit;
        SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString := 'D';
        SAP_SVDATA_APLAK.Post;
      end;
    end;
  end
  else
    MessageDlg('Es ist kein Datensatz zum Löschen gekennzeichnet!', mtError, [mbOK], 0);
end;

procedure TFrmPlakettenbestaende.BtnBSTBearbeitenClick(Sender: TObject);
var s: Char;
  Kennz: String;
begin
  if SAP_SVDATA_TSBST.RecordCount > 0 then
  begin
    s := ' ';
    Kennz := SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString;
    if Length(Kennz) > 0 then
      s := Kennz[1];
    case s of
//      'I': MessageDlg('Tatsächlicher Bestand wurde eingefügt!', mtError, [mbOK], 0);
      'D': MessageDlg('Tatsächlicher Bestand wurde bereits als "Gelöscht" gekennzeichnet!', mtError, [mbOK], 0);
//    'U': MessageDlg('Tatsächlicher Bestand wurde bereits bearbeitet!', mtError, [mbOK], 0);
    else
      FrmTatsaechlicherBestand.Modus := fmEdit;
      FrmTatsaechlicherBestand.ShowModal;
    end;
  end
  else
    MessageDlg('Es ist kein Datensatz zum Bearbeiten gekennzeichnet!', mtError, [mbOK], 0);
end;

procedure TFrmPlakettenbestaende.BtnBSTLoeschenClick(Sender: TObject);
var s: Char;
  Kennz: String;
begin
  if SAP_SVDATA_TSBST.RecordCount > 0 then
  begin
    s := ' ';
    Kennz := SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString;
    if Length(Kennz) > 0 then
      s := Kennz[1];
    case s of
      'I': MessageDlg('Tatsächlicher Bestand wurde eingefügt!', mtError, [mbOK], 0);
      'D': MessageDlg('Tatsächlicher Bestand wurde bereits als "Gelöscht" gekennzeichnet!', mtError, [mbOK], 0);
//    'U': MessageDlg('Tatsächlicher Bestand wurde bereits bearbeitet!', mtError, [mbOK], 0);
    else
      if MessageDlg('Tatsächlicher Bestand wirklich als "Gelöscht" kennzeichnen?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        SAP_SVDATA_TSBST.Edit;
        SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString := 'D';
        SAP_SVDATA_TSBST.Post;
      end;
    end;
  end
  else
    MessageDlg('Es ist kein Datensatz zum Löschen gekennzeichnet!', mtError, [mbOK], 0);
end;

procedure TFrmPlakettenbestaende.BtnPLAKErfassenClick(Sender: TObject);
begin
  FrmPlakettenabgaenge.Modus := fmInsert;
  FrmPlakettenabgaenge.ShowModal;
end;

procedure TFrmPlakettenbestaende.BtnBSTErfassenClick(Sender: TObject);
begin
  FrmTatsaechlicherBestand.Modus := fmInsert;
  FrmTatsaechlicherBestand.ShowModal;
end;

procedure TFrmPlakettenbestaende.BBtnUebernehmenClick(Sender: TObject);
var cErgebnis, s: String;
  lPuefen: Boolean;
begin

  lPuefen := RaBEingabenpruefen.Checked;
  s := 'Verbuchen';
  if lPuefen then
    s := 'Prüfen';

  if MessageDlg(s + ' aller Daten ausführen.' + #13 + #13 + 'Wollen Sie fortfahren?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    BBtnUebernehmen.Enabled := false;
    BBtnSchliessen.Enabled := false;
    BBtnAbbrechen2.Enabled := true;

    // Abbruch der Anfrage (neu) initialisieren
    Abbort_SET_SVDATA := false;

    // Evtl. Ende über Abbruch-Button
    TmrErgebnis.Enabled := true;

    PanelColor := clYellow;
    StBBottom.Panels[1].Text := 'Status der Anfrage: senden..';
    StBBottom.Repaint();

    USetSVData.SAP_SVDATA_EPLAK := SAP_SVDATA_EPLAK;
    USetSVData.SAP_SVDATA_APLAK := SAP_SVDATA_APLAK;
    USetSVData.SAP_SVDATA_TSBST := SAP_SVDATA_TSBST;
    USetSVData.TblWSLOG := FrmPlakettenverwaltung.TblWSLOG;

    cErgebnis := '';

    if SendRequest_SET_SVDATA(cErgebnis, HTTPRIO, FrmPlakettenverwaltung.Buchungskreis, FrmPlakettenverwaltung.UserPNR, lPuefen, FrmPlakettenverwaltung.WebService_SetSVData, FrmPlakettenverwaltung.UseProxy, FrmPlakettenverwaltung.WebService_User, FrmPlakettenverwaltung.WebService_Password) then
    begin
      if cErgebnis = '' then
        cErgebnis := s + ' der Daten erfolgreich abgeschlossen!';

      PanelColor := clLime;
      StBBottom.Panels[1].Text := 'Status der Anfrage: ' + cErgebnis;
      StBBottom.Repaint();

      if RaBEingabenbuchen.Checked then
      begin
        MessageDlg('Eine Buchung wurde durchgeführt. Die Ansicht wird jetzt automatisch aktualisiert!', mtInformation, [mbOk], 0);
        Question := false;
        BBtnAktualisierenClick(Sender);
        Question := true;
      end;
    end
    else
    begin
      PanelColor := clRed;
      StBBottom.Panels[1].Text := 'Status der Anfrage: Fehler beim ' + s + ' der Daten!';
      StBBottom.Repaint();

      if not (cErgebnis = '') then
        MessageDlg(cErgebnis, mtError, [mbOK], 0);
    end;

    // Normales Ende
    TmrErgebnis.Enabled := false;

    BBtnUebernehmen.Enabled := true;
    BBtnSchliessen.Enabled := true;
    BBtnAbbrechen2.Enabled := false;
  end;

end;

procedure TFrmPlakettenbestaende.wwDBGridPlakettenbestaende_EPLAKKeyPress(
  Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_RETURN) then
    BtnErhaltBestClick(Sender);
end;

procedure TFrmPlakettenbestaende.wwDBGridPlakettenbestaende_APLAKKeyPress(
  Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_RETURN) then
    BtnPLAKBearbeitenClick(Sender);
end;

procedure TFrmPlakettenbestaende.wwDBGridPlakettenbestaende_TSBSTKeyPress(
  Sender: TObject; var Key: Char);
begin
  if Key = Char(VK_RETURN) then
    BtnBSTBearbeitenClick(Sender);
end;

procedure TFrmPlakettenbestaende.BBtnAbbrechen2Click(Sender: TObject);
begin
  // gesendetet Anfrage abbrechen
  Abbort_SET_SVDATA := true;
end;

procedure TFrmPlakettenbestaende.RaBEingabenbuchenClick(Sender: TObject);
begin
  BBtnUebernehmen.Caption := '&Buchen';
end;

procedure TFrmPlakettenbestaende.RaBEingabenpruefenClick(Sender: TObject);
begin
  BBtnUebernehmen.Caption := '&Prüfen';
end;

procedure TFrmPlakettenbestaende.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and BBtnSchliessen.Enabled then
    BBtnSchliessenClick(Sender);
end;

procedure TFrmPlakettenbestaende.wwDBGridPlakettenbestaende_TSBSTTitleButtonClick(
  Sender: TObject; AFieldName: String);
begin
  // kiek 27.06.12, lfd.Nr./Beschreibung 904/2
  ChangeIndexName(AFieldName);
  SetIndexColor(AFieldName);
end;

end.
