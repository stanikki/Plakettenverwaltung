unit UAnzeigeSAP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, DB, Wwdatsrc, Grids,
  Wwdbigrd, Wwdbgrid, DBClient, SOAPConn, InvokeRegistry, SOAPHTTPTrans,
  Rio, SOAPHTTPClient, OPConvert, SOAPDomConv, OPToSOAPDomConv, Z_PLV_GET_INFOS_V011,
  adsdata, adsfunc, adstable, fcButton, fcImgBtn, fcShapeBtn, fcClearPanel,
  fcButtonGroup, TData, UPlakettenverwaltung, UGetInfos;

type
  TFrmWertePruef = class(TForm)
    GrBButtons: TGroupBox;
    BBtnSchliessen: TBitBtn;
    StBBottom: TStatusBar;
    BBtnAktualisieren: TBitBtn;
    BBtnAbbrechen: TBitBtn;
    TmrErgebnis: TTimer;
    wwDBGridAnzeigeSAP_PLTYP: TwwDBGrid;
    DSrcAnzeigeSAP_PLTYP: TwwDataSource;
    HTTPRIO: THTTPRIO;
    SAP_INFOS_PLTYP: TAdsTable;
    MeRequest: TMemo;
    MeResponse: TMemo;
    lblRequest: TLabel;
    lblResponse: TLabel;
    DSrcAnzeigeSAP_DEPOT: TwwDataSource;
    SAP_INFOS_DEPOT: TAdsTable;
    wwDBGridAnzeigeSAP_DEPOT: TwwDBGrid;
    wwDBGridAnzeigeSAP_BSCHL: TwwDBGrid;
    SAP_INFOS_BSCHL: TAdsTable;
    DSrcAnzeigeSAP_BSCHL: TwwDataSource;
    SAP_INFOS_SART: TAdsTable;
    DSrcAnzeigeSAP_SART: TwwDataSource;
    wwDBGridAnzeigeSAP_SART: TwwDBGrid;
    GrBPlakettentypen: TGroupBox;
    GrBBuchungsschluessel: TGroupBox;
    GrBDepots: TGroupBox;
    GrBSatzarten: TGroupBox;
    SAP_INFOS_DEPOTBuchungskreis: TAdsStringField;
    SAP_INFOS_DEPOTDepotID: TAdsStringField;
    SAP_INFOS_DEPOTBezeichnung: TAdsStringField;
    SAP_INFOS_BSCHLBuchungsschluessel: TAdsStringField;
    SAP_INFOS_BSCHLBezeichnung: TAdsStringField;
    SAP_INFOS_PLTYPPlakettentyp: TAdsStringField;
    SAP_INFOS_PLTYPBezeichnung: TAdsStringField;
    SAP_INFOS_SARTDomaenenwert: TAdsStringField;
    SAP_INFOS_SARTBezeichnung: TAdsStringField;
    procedure BBtnAbbrechenClick(Sender: TObject);
    procedure BBtnAktualisierenClick(Sender: TObject);
    procedure TmrErgebnisTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StBBottomDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormCreate(Sender: TObject);
    procedure HTTPRIOBeforeExecute(const MethodName: String;
      var SOAPRequest: WideString);
    procedure FormDestroy(Sender: TObject);
    procedure HTTPRIOAfterExecute(const MethodName: String;
      SOAPResponse: TStream);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    PanelColor: TColor;
  public
    { Public-Deklarationen }
    Abbort_GET_INFOS: Boolean;
    procedure EmptyTables(lPack: Boolean);
  end;

var
  FrmWertePruef: TFrmWertePruef;

implementation

{$R *.dfm}

procedure TFrmWertePruef.EmptyTables(lPack: Boolean);
begin
  SAP_INFOS_PLTYP.EmptyTable;
  SAP_INFOS_DEPOT.EmptyTable;
  SAP_INFOS_BSCHL.EmptyTable;
  SAP_INFOS_SART.EmptyTable;

  if lPack then
  begin
    SAP_INFOS_PLTYP.PackTable;
    SAP_INFOS_DEPOT.PackTable;
    SAP_INFOS_BSCHL.PackTable;
    SAP_INFOS_SART.PackTable;
  end;
end;

procedure TFrmWertePruef.FormCreate(Sender: TObject);
begin
  // Panel 2 soll selber gezeichnet werden
  StBBottom.Panels[1].Style := psOwnerDraw;
  PanelColor := StBBottom.Color; // clBtnFace;

  SAP_INFOS_PLTYP.Open;
  if SAP_INFOS_PLTYP.Active and SAP_INFOS_PLTYP.AdsIsTableEncrypted then
    SAP_INFOS_PLTYP.AdsEnableEncryption(DEF_TBL_KEY);

  SAP_INFOS_DEPOT.Open;
  if SAP_INFOS_DEPOT.Active and SAP_INFOS_DEPOT.AdsIsTableEncrypted then
    SAP_INFOS_DEPOT.AdsEnableEncryption(DEF_TBL_KEY);

  SAP_INFOS_BSCHL.Open;
  if SAP_INFOS_BSCHL.Active and SAP_INFOS_BSCHL.AdsIsTableEncrypted then
    SAP_INFOS_BSCHL.AdsEnableEncryption(DEF_TBL_KEY);

  SAP_INFOS_SART.Open;
  if SAP_INFOS_SART.Active and SAP_INFOS_SART.AdsIsTableEncrypted then
    SAP_INFOS_SART.AdsEnableEncryption(DEF_TBL_KEY);

  // alle Datenbanken des WebServices leeren
  EmptyTables(false);

end;

procedure TFrmWertePruef.FormShow(Sender: TObject);
begin
  Abbort_GET_INFOS := false;
  TmrErgebnis.Interval := PRG_ABBORT_CHECKTIME;

  PanelColor := StBBottom.Color;
  StBBottom.Panels[1].Text := 'Status der Anfrage:';
  StBBottom.Repaint();

  SAP_INFOS_PLTYP.AdsGotoTop;
  SAP_INFOS_DEPOT.AdsGotoTop;
  SAP_INFOS_BSCHL.AdsGotoTop;
  SAP_INFOS_SART.AdsGotoTop;

end;

procedure TFrmWertePruef.BBtnAktualisierenClick(Sender: TObject);
var cErgebnis: String;
begin
  BBtnAktualisieren.Enabled := false;
  BBtnSchliessen.Enabled := false;
  BBtnAbbrechen.Enabled := true;

  // Abbruch der Anfrage (neu) initialisieren
  Abbort_GET_INFOS := false;

  // Evtl. Ende über Abbruch-Button
  TmrErgebnis.Enabled := true;

  PanelColor := clYellow;
  StBBottom.Panels[1].Text := 'Status der Anfrage: senden..';
  StBBottom.Repaint();

  EmptyTables(false);

  UGetInfos.SAP_INFOS_PLTYP := SAP_INFOS_PLTYP;
  UGetInfos.SAP_INFOS_DEPOT := SAP_INFOS_DEPOT;
  UGetInfos.SAP_INFOS_BSCHL := SAP_INFOS_BSCHL;
  UGetInfos.SAP_INFOS_SART := SAP_INFOS_SART;
  UGetInfos.TblWSLOG := FrmPlakettenverwaltung.TblWSLOG;

  cErgebnis := '';

  // Test, ob Internetverbindung besteht
  if SendRequest_GET_INFOS(cErgebnis, HTTPRIO, FrmPlakettenverwaltung.Buchungskreis, FrmPlakettenverwaltung.WebService_GetInfos, FrmPlakettenverwaltung.UseProxy, FrmPlakettenverwaltung.WebService_User, FrmPlakettenverwaltung.WebService_Password) then
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
    StBBottom.Panels[1].Text := 'Status der Anfrage: Fehler bei der Aktualisierung';
    StBBottom.Repaint();

    MessageDlg('Es ist ein Fehler beim Senden der Anfrage bzw. beim Empfangen der Ergebnisse aufgeteten. Evtl. besteht keine Internetverbindung!', mtError, [mbOK], 0);
  end;

  // Normales Ende
  TmrErgebnis.Enabled := false;

  BBtnAktualisieren.Enabled := true;
  BBtnSchliessen.Enabled := true;
  BBtnAbbrechen.Enabled := false;
end;

procedure TFrmWertePruef.BBtnAbbrechenClick(Sender: TObject);
begin
  // gesendetet Anfrage abbrechen
  Abbort_GET_INFOS := true;
end;

procedure TFrmWertePruef.TmrErgebnisTimer(Sender: TObject);
begin
  // Auf Abbruch über Abbruch-Button reagieren
  if Abbort_GET_INFOS then
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

procedure TFrmWertePruef.StBBottomDrawPanel(StatusBar: TStatusBar;
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

procedure TFrmWertePruef.HTTPRIOBeforeExecute(const MethodName: String;
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

procedure TFrmWertePruef.FormDestroy(Sender: TObject);
begin
  SAP_INFOS_PLTYP.Close;
  SAP_INFOS_DEPOT.Close;
  SAP_INFOS_BSCHL.Close;
  SAP_INFOS_SART.Close;
end;

procedure TFrmWertePruef.HTTPRIOAfterExecute(const MethodName: String;
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

procedure TFrmWertePruef.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := BBtnSchliessen.ModalResult;
end;

end.
