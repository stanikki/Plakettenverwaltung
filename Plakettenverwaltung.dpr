program Plakettenverwaltung;

uses
  Forms, Interfaces,
  UPlakettenverwaltung in 'UPlakettenverwaltung.pas' {FrmPlakettenverwaltung},
  TData in 'TData.pas' {DaMConnections},
  UAnmeldung in 'UAnmeldung.pas' {FrmAnmeldung},
  UInfo in 'UInfo.pas' {FrmInfo},
  UAnzeigeSAP in 'UAnzeigeSAP.pas' {FrmWertePruef},
  UPlakettenbestaende in 'UPlakettenbestaende.pas' {FrmPlakettenbestaende},
  Z_PLV_GET_INFOS_V011 in 'Z_PLV_GET_INFOS_V011.pas',
  Z_PLV_GET_SVDATA_V011 in 'Z_PLV_GET_SVDATA_V011.pas',
  Z_PLV_SELECT_SVDATA_V011 in 'Z_PLV_SELECT_SVDATA_V011.pas',
  Z_PLV_SET_SVDATA_V011 in 'Z_PLV_SET_SVDATA_V011.pas',
  UPlakettenabgaenge in 'UPlakettenabgaenge.pas' {FrmPlakettenabgaenge},
  UTatsaechlicherBestand in 'UTatsaechlicherBestand.pas' {FrmTatsaechlicherBestand},
  UGetInfos in 'UGetInfos.pas',
  UGetSVData in 'UGetSVData.pas',
  USetSVData in 'USetSVData.pas',
  UAuswertung in 'UAuswertung.pas' {FrmAuswertung},
  USelectSVData in 'USelectSVData.pas',
  UProtokoll in 'UProtokoll.pas' {FrmProtokoll},
  UEinstellungen in 'UEinstellungen.pas' {FrmEinstellungen},
  RRDecl32 in 'rrdecl32.pas',
  sysutils;

{$R *.res}
{$DEFINE FIX_ELEM_NODE_NS}
{$DEFINE CLEANUP_SOAP_HEADERS}

begin
  Application.Initialize;
  Application.HelpFile := 'Plakettenverwaltung_Hilfe.hlp';
//  Application.HelpFile := 'Plakettenverwaltung_Hilfe.chm';
    // Hint-Zeitintervalle festlegen
  // Zeit bis zur Anzeige des Hints
  Application.HintPause := 100;
  // Länge der Hint-Anzeige
  Application.HintHidePause := 8000;
  Application.CreateForm(TDaMConnections, DaMConnections);
  Application.CreateForm(TFrmAnmeldung, FrmAnmeldung);
  Application.CreateForm(TFrmPlakettenverwaltung, FrmPlakettenverwaltung);
  Application.CreateForm(TFrmEinstellungen, FrmEinstellungen);
  // Programmstart für Produktion auf Datum festgelegt
  if not (FrmPlakettenverwaltung.SAPSystem = sapProduktion) or (FrmPlakettenverwaltung.CurrentDate > FrmPlakettenverwaltung.StartDatePRG) then
  begin
    Application.CreateForm(TFrmPlakettenbestaende, FrmPlakettenbestaende);
    Application.CreateForm(TFrmInfo, FrmInfo);
    Application.CreateForm(TFrmWertePruef, FrmWertePruef);
    Application.CreateForm(TFrmPlakettenabgaenge, FrmPlakettenabgaenge);
    Application.CreateForm(TFrmTatsaechlicherBestand, FrmTatsaechlicherBestand);
    Application.CreateForm(TFrmAuswertung, FrmAuswertung);
    Application.CreateForm(TFrmProtokoll, FrmProtokoll);
    if FrmAnmeldung.AutoLogin and (Length(FrmAnmeldung.CommandLine_Buchungskreis) > 0) and (Length(FrmAnmeldung.CommandLine_Personalnummer) > 0) then
    begin
//      FrmPlakettenverwaltung.User := FrmAnmeldung.CommandLine_User;
//      FrmPlakettenverwaltung.Mandant := FrmAnmeldung.CommandLine_Mandant;

      FrmPlakettenverwaltung.MandantCMD := FrmAnmeldung.CommandLine_Mandant;
      FrmPlakettenverwaltung.Buchungskreis := FrmAnmeldung.CommandLine_Buchungskreis;
      FrmPlakettenverwaltung.UserPNR := FrmAnmeldung.CommandLine_Personalnummer;
      FrmAnmeldung.Visible := false;
      FrmPlakettenverwaltung.Visible := true;
      Application.ShowMainForm := false;
      Application.Run;
    end
    else
      Application.MessageBox('Das Programm darf nur mit Parametern gestartet werden!', PRG_NAME + ' - Programmabbruch', 16);
  end
  else
    Application.MessageBox('Das Programm darf mit den aktuellen Einstellungen nicht gestartet werden!', PRG_NAME + ' - Programmabbruch', 16);

end.

