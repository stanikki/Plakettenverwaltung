unit UPlakettenverwaltung;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, fcStatusBar, Menus, Grids, Wwdbigrd, Wwdbgrid,
  DB, adsdata, adsfunc, adstable, ComCtrls, CommCtrl, Wwdatsrc, StdCtrls,
  Mask, wwdbedit, Wwdbspin, Spin, Buttons, XPMan, ExtCtrls, UGetInfos, TData,
  jpeg, WinInet;

type
  TFrmPlakettenverwaltung = class(TForm)
    StBBottom: TStatusBar;
    XPManifest1: TXPManifest;
    MMPlakettenverw: TMainMenu;
    HMIDatei: TMenuItem;
    MIBeenden: TMenuItem;
    HMIHilfe: TMenuItem;
    MIInfo: TMenuItem;
    TmrZeit: TTimer;
    HMIVerwaltung: TMenuItem;
    MIWertePruef: TMenuItem;
    MIPlaketten: TMenuItem;
    MIProtokoll: TMenuItem;
    MIAuswertung: TMenuItem;
    BBtnWertePruef: TBitBtn;
    BBtnPlaketten: TBitBtn;
    BBtnAuswertung: TBitBtn;
    BBtnSchliessen: TBitBtn;
    TblWSLOG: TAdsTable;
    BBtnEinstellungen: TBitBtn;
    MIEinstellungen: TMenuItem;
    ImgPlakette: TImage;
    MIHilfe: TMenuItem;
    TblSAPUser: TAdsTable;
    procedure FormShow(Sender: TObject);
    procedure MIInfoClick(Sender: TObject);
    procedure TmrZeitTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StBBottomDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure BBtnPlakettenClick(Sender: TObject);
    procedure BBtnSchliessenClick(Sender: TObject);
    procedure BBtnWertePruefClick(Sender: TObject);
    procedure BBtnEinstellungenClick(Sender: TObject);
    procedure BBtnAuswertungClick(Sender: TObject);
    procedure MIProtokollClick(Sender: TObject);
    procedure MIHilfeClick(Sender: TObject);
  private
    { Private-Deklarationen }
    PanelColor: TColor;
//    function ReadBuchungskreis(): String;
    procedure SwitchVerwaltung(lSwitch: Boolean);
    procedure SendRequest_Infos();
  public
    { Public-Deklarationen }
    ShowAllSettings: boolean;
    AllTransactions: boolean;

    UseProxy: Integer;

    WebService_User: String;
    WebService_Password: String;
    
    WebService_GetInfos: String;
    WebService_GetSVData: String;
    WebService_SetSVData: String;
    WebService_SelectSVData: String;

//    Section: String;
//    Modus: Integer;
//    Server: Integer;
//    NetModus: Integer;

    CurrentDate: TDateTime;
    StartDatePRG: TDateTime;
    SAPSystem: TPVSAPSystem;
    ConnectionType: TPVConnectionType;
    Mandant: TPVMandant;
    MandantCMD: String;
    User: String;
    UserPNR: String;
    Buchungskreis: String;

    procedure LoadPicture();
    procedure InitWebServicesData();
    procedure InitWebServicesData_old();
  end;

var
  FrmPlakettenverwaltung: TFrmPlakettenverwaltung;

implementation

{$R *.dfm}

uses
  UInfo, UAnzeigeSAP, Z_PLV_GET_INFOS_V011, UPlakettenbestaende, UAnmeldung, UAuswertung, UProtokoll, UEinstellungen;

procedure TFrmPlakettenverwaltung.SendRequest_Infos();
var cErgebnis: String;
begin
  cErgebnis := '';

  FrmWertePruef.EmptyTables(false);

  // Test, ob Internetverbindung besteht, dabei einlesen aller Wertehilfen/Prüftabellen
  if not SendRequest_GET_INFOS(cErgebnis, FrmWertePruef.HTTPRIO, Buchungskreis, WebService_GetInfos, UseProxy, WebService_User, WebService_Password) then
  begin
    MessageDlg('Es besteht keine Verbindung zum Webservice der Plakettenverwaltung!' + #13 + #13 +
        'Bitte prüfen Sie Anschlüsse und Einstellungen und stellen Sie für' + #13 +
        'die Arbeit mit der Plakettenverwaltung eine Internetverbindung her.', mtError, [mbOK], 0);
    PanelColor := clRed;
    StBBottom.Panels[4].Text := 'Offline !';
    StBBottom.Hint := 'Verbindung zum WebService nicht vorhanden!';
    StBBottom.Repaint();

    SwitchVerwaltung(false);
  end
  else
  begin
    PanelColor := clLime;
    StBBottom.Panels[4].Text := 'Online !';
    StBBottom.Hint := 'Verbindung zum WebService vorhanden!';
    StBBottom.Repaint();

    SwitchVerwaltung(true);
  end;

end;

procedure TFrmPlakettenverwaltung.InitWebServicesData();
var cSystemKey, cSeek: String;
begin

  cSystemKey := EmptyStr;

  case self.SAPSystem of

    sapEntwicklung:
    begin
      cSystemKey := 'WS_DEV_';
    end;

    sapTraining:
    begin
      cSystemKey := 'WS_TRG_';
    end;

    sapProduktion:
    begin
      cSystemKey := 'WS_PRD_';
    end;
  end;

  TblSAPUser.Open;
  if TblSAPUser.Active and TblSAPUser.AdsIsTableEncrypted then
    TblSAPUser.AdsEnableEncryption(DEF_TBL_KEY);
  TblSAPUser.IndexName := 'MANDANT';
  cSeek := frmPlakettenverwaltung.MandantCMD + IntToStr(Ord(self.SAPSystem));
  if TblSAPUser.AdsSeek(cSeek, stHARD) then
  begin
    self.WebService_User := TblSAPUser.FieldByName('User').AsString;
    self.WebService_Password := TblSAPUser.FieldByName('Password').AsString;
  end;
  TblSAPUser.Close;
  TblSAPUser := nil;

  self.WebService_GetInfos :=     DaMConnections.Plakini.ReadString(cSystemKey + FrmPlakettenverwaltung.MandantCMD, URL_WS_GET_INFOS, EmptyStr);
  self.WebService_GetSVData :=    DaMConnections.Plakini.ReadString(cSystemKey + FrmPlakettenverwaltung.MandantCMD, URL_WS_GET_SVDATA, EmptyStr);
  self.WebService_SetSVData :=    DaMConnections.Plakini.ReadString(cSystemKey + FrmPlakettenverwaltung.MandantCMD, URL_WS_SET_SVDATA, EmptyStr);
  self.WebService_SelectSVData := DaMConnections.Plakini.ReadString(cSystemKey + FrmPlakettenverwaltung.MandantCMD, URL_WS_SELECT_SVDATA, EmptyStr);

end;

procedure TFrmPlakettenverwaltung.InitWebServicesData_old();
var cServerDEV, cServerTRG, cServerPRD, cMandant: String;
  Hosts: TStringList; i: Integer;
  s1: TextFile;
  h: THandle;
begin

  case self.ConnectionType of
    ctIntranet:
    begin
      cServerDEV  := DaMConnections.Plakini.ReadString(INI_SEC_WEBSERVICES, INI_KEY_INTRANET_DEV, URL_WS_DEV_INTRA);
      cServerTRG  := DaMConnections.Plakini.ReadString(INI_SEC_WEBSERVICES, INI_KEY_INTRANET_TRG, URL_WS_TRG_INTRA);
      cServerPRD  := DaMConnections.Plakini.ReadString(INI_SEC_WEBSERVICES, INI_KEY_INTRANET_PRD, URL_WS_PRD_INTRA);
    end;
    ctInternet:
    begin
      cServerDEV  := DaMConnections.Plakini.ReadString(INI_SEC_WEBSERVICES, INI_KEY_INTERNET_DEV, URL_WS_DEV_INTER);
      cServerTRG  := DaMConnections.Plakini.ReadString(INI_SEC_WEBSERVICES, INI_KEY_INTERNET_TRG, URL_WS_TRG_INTER);
      cServerPRD  := DaMConnections.Plakini.ReadString(INI_SEC_WEBSERVICES, INI_KEY_INTERNET_PRD, URL_WS_PRD_INTER);
    end;
  end;

  case self.SAPSystem of
    sapEntwicklung:
    begin
      case self.Mandant of
        manTK:
        begin
          cMandant := URL_WS_SAPCLIENT_TK;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_TK_DEV;
        end;
        manFSP:
        begin
          cMandant := URL_WS_SAPCLIENT_FSP;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_FSP_DEV;
        end;
        else // oneSAP on HANA
        begin
          cMandant := URL_WS_SAPCLIENT + '0' + FrmPlakettenverwaltung.MandantCMD;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_DEV;
        end;
      end;
      self.WebService_GetInfos :=     cServerDEV + URL_WS_SAPPATH + URL_WS_GET_INFOS + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_GetSVData :=    cServerDEV + URL_WS_SAPPATH + URL_WS_GET_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_SetSVData :=    cServerDEV + URL_WS_SAPPATH + URL_WS_SET_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_SelectSVData := cServerDEV + URL_WS_SAPPATH + URL_WS_SELECT_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
    end;
    sapTraining:
    begin
      case self.Mandant of
        manTK:
        begin
          cMandant := URL_WS_SAPCLIENT_TK;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_TK_TRG;
        end;
        manFSP:
        begin
          cMandant := URL_WS_SAPCLIENT_FSP;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_FSP_TRG;
        end;
        else // oneSAP on HANA
        begin
          cMandant := URL_WS_SAPCLIENT + '0' + FrmPlakettenverwaltung.MandantCMD;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_TRG;
        end;
      end;
      self.WebService_GetInfos :=     cServerTRG + URL_WS_SAPPATH + URL_WS_GET_INFOS + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_GetSVData :=    cServerTRG + URL_WS_SAPPATH + URL_WS_GET_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_SetSVData :=    cServerTRG + URL_WS_SAPPATH + URL_WS_SET_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_SelectSVData := cServerTRG + URL_WS_SAPPATH + URL_WS_SELECT_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
    end;
    sapProduktion:
    begin
      case self.Mandant of
        manTK:
        begin
          cMandant := URL_WS_SAPCLIENT_TK;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_TK_PRD;
        end;
        manFSP:
        begin
          cMandant := URL_WS_SAPCLIENT_FSP;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_FSP_PRD;
        end;
        else // oneSAP on HANA
        begin
          cMandant := URL_WS_SAPCLIENT + '0' + FrmPlakettenverwaltung.MandantCMD;
          self.WebService_User :=       SAP_USER;
          self.WebService_Password :=   SAP_PW_PRD;
        end;
      end;
      self.WebService_GetInfos :=     cServerPRD + URL_WS_SAPPATH + URL_WS_GET_INFOS + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_GetSVData :=    cServerPRD + URL_WS_SAPPATH + URL_WS_GET_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_SetSVData :=    cServerPRD + URL_WS_SAPPATH + URL_WS_SET_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
      self.WebService_SelectSVData := cServerPRD + URL_WS_SAPPATH + URL_WS_SELECT_SVDATA + URL_WS_VERSION + cMandant + URL_WS_WSDL_VERSION;
    end;
  end;

end;


procedure TFrmPlakettenverwaltung.SwitchVerwaltung(lSwitch: Boolean);
begin
    BBtnWertePruef.Enabled := lSwitch;
    BBtnPlaketten.Enabled := lSwitch;
    BBtnAuswertung.Enabled := lSwitch;

    HMIVerwaltung.Enabled := lSwitch;
end;

procedure TFrmPlakettenverwaltung.LoadPicture();
var jpg1:Tjpegimage;
    stream:TResourceStream;
    DLLHandle: HMODULE;
    cBild: String;
begin
  // Hintergrundbild je nach SAPSystem laden
  DLLHandle := LoadLibrary('Plaketten_Rec.dll');
  if DLLHandle <> 0 then
  begin
    jpg1 := TJPEGImage.Create;
    try

      case self.SAPSystem of
        sapProduktion:  cBild := 'Plak_Gruen';
        sapEntwicklung: cBild := 'Plak_Gelb';
        sapTraining:    cBild := 'Plak_Orange';
      end;

      Stream := TResourceStream.Create(DLLHandle, cBild, 'JPEG');
      try
        Jpg1.LoadFromStream(Stream);
        self.ImgPlakette.Picture.Bitmap.Assign(Jpg1);
      finally
        Stream.Free;
      end;
    finally
      jpg1.Free;
    end;
    FreeLibrary(DLLHandle);
  end;
end;

{
function TFrmPlakettenverwaltung.ReadBuchungskreis(): String;
var cSeek: String;
  cBK: String;
  n, i: Integer;
  cRet: String;
begin

  if Modus = 1 then
    TblPLAPTOP.AdsConnection := DaMConnections.AdsConnectionMOP
  else
    TblPLAPTOP.AdsConnection := DaMConnections.AdsConnectionTMOP;

  // Buchungskreis anhand der Task-Installation suchen
  TblPLAPTOP.Open;
  if TblPLAPTOP.Active and TblPLAPTOP.AdsIsTableEncrypted then
    TblPLAPTOP.AdsEnableEncryption(DEF_TBL_KEY);

  cSeek := TblPLAPTOP.FieldByName('PMAND').AsString + TblPLAPTOP.FieldByName('PBK').AsString + TblPLAPTOP.FieldByName('PNL').AsString;

  TblZBUK.Open;
  if TblZBUK.Active and TblZBUK.AdsIsTableEncrypted then
    TblZBUK.AdsEnableEncryption(DEF_TBL_KEY);
  TblZBUK.IndexName := 'ZBUK';
  if TblZBUK.AdsSeek(cSeek, stHARD) then
    cBK := TblZBUK.FieldByName('ZSAPBUK').AsString
  else
    cBK := TblPLAPTOP.FieldByName('PBK').AsString;

  // Buchungskreis anpassen (8 stellen mit führenden Nullen)
  cBK := StringOfChar('0', 4 - Length(cBK)) + cBK;

  // Mandant aus der Plaptop übernehmen
//  Mandant := TblPLAPTOP.FieldByName('PMAND').AsInteger;
  case TblPLAPTOP.FieldByName('PMAND').AsInteger of
    PRG_MANDANT_TK:   Mandant := manTK;
    PRG_MANDANT_FSP:  Mandant := manFSP;
  end;

  TblZBUK.Close;
  TblZBUK := nil;
  TblPLAPTOP.Close;
  TblPLAPTOP := nil;

  Result := cBK;

end;
}

procedure TFrmPlakettenverwaltung.FormShow(Sender: TObject);
begin

//  Buchungskreis := ReadBuchungskreis();
  InitWebServicesData();

  StBBottom.Panels[0].Text := 'V.: ' + PRG_VERSION;
  StBBottom.Panels[1].Text := 'Benutzer: ' + User + ' ( ' + UserPNR +  ' ) / ' + Buchungskreis;
  StBBottom.Panels[2].Text := 'Datum: ' + DateToStr(Now());
  StBBottom.Panels[3].Text := 'Zeit: ' + TimeToStr(Time());

  UGetInfos.SAP_INFOS_PLTYP := FrmWertePruef.SAP_INFOS_PLTYP;
  UGetInfos.SAP_INFOS_DEPOT := FrmWertePruef.SAP_INFOS_DEPOT;
  UGetInfos.SAP_INFOS_BSCHL := FrmWertePruef.SAP_INFOS_BSCHL;
  UGetInfos.SAP_INFOS_SART := FrmWertePruef.SAP_INFOS_SART;
  UGetInfos.TblWSLOG := FrmPlakettenverwaltung.TblWSLOG;

  FrmWertePruef.EmptyTables(false);
  FrmWertePruef.Abbort_GET_INFOS := false;

  // WebService auslösen um Online/Offline-Status zu ermitteln
  self.SendRequest_Infos();
end;

procedure TFrmPlakettenverwaltung.MIInfoClick(Sender: TObject);
begin
  FrmInfo.ShowModal;
end;

procedure TFrmPlakettenverwaltung.TmrZeitTimer(Sender: TObject);
begin
  StBBottom.Panels[3].Text := 'Zeit: ' + TimeToStr(Time());
  StBBottom.Repaint();
end;

procedure TFrmPlakettenverwaltung.FormCreate(Sender: TObject);
var RecCount, i: Integer;
begin
  // Panel 3 soll selber gezeichnet werden
  StBBottom.Panels[4].Style := psOwnerDraw;
  PanelColor := StBBottom.Color; // clBtnFace;

{
  // Programm-Initialisierung
  Modus := DaMConnections.Taskini.ReadInteger('Application', 'Modus', 2);
  if Modus = 1 then
    Section := 'MOP'
  else
    Section := 'TMOP';

  Server := DaMConnections.Taskini.ReadInteger(Section, 'Server', 0);
  NetModus := DaMConnections.Taskini.ReadInteger(Section, 'NetModus', 0);
  }

  StartDatePRG := StrToDate(DaMConnections.Plakini.ReadString(INI_SEC_SETTINGS, INI_KEY_STARTPRG, INI_STARTPRG_DEF));
  CurrentDate := Now();
  ConnectionType := TPVConnectionType(DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_CONNECTIONTYPE, INI_CONNECTIONTYPE_DEF));
  SAPSystem := TPVSAPSystem(DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_SYSTEM, INI_SYSTEM_DEF));
  // Hintergrundbild je nach SAPSystem laden
  LoadPicture();
  // Proxy-Einstellungen des Internet-Explorers nutzen
  UseProxy := DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_USEPROXY, INI_USEPROXY_DEF);
  // alle Einstellungen im Dialog Einstellungen anzeigen
  ShowAllSettings := (DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_SHOWALLSETTINGS, INI_SHOWALLSETTINGS_DEF) = 1);
  // Anzeige aller tatsächlichen Bestandsbuchungen
  AllTransactions := (DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_ALLTRANSACTIONS, INI_ALLTRANSACTIONS_DEF) = 1);

  // Log-Datenbank
  TblWSLOG.Open;
  if TblWSLOG.Active and TblWSLOG.AdsIsTableEncrypted then
    TblWSLOG.AdsEnableEncryption(DEF_TBL_KEY);
  // Log-Datenbank reorganisieren
  RecCount := TblWSLOG.RecordCount;
  if RecCount > DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_LOGREORGCOUNT, INI_LOGREORGCOUNT_DEF) then
  begin
    TblWSLOG.AdsGotoTop;
    for i := 0 to RecCount-DaMConnections.Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_LOGREORGCOUNT, INI_LOGREORGCOUNT_DEF) do
    begin
      TblWSLOG.AdsDeleteRecord;
    end;
    TblWSLOG.PackTable;
    TblWSLOG.AdsGotoBottom;
  end;

end;

procedure TFrmPlakettenverwaltung.StBBottomDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[4] then                   // fünftes Panel
  begin
    with StatusBar.Canvas do
    begin
      Brush.Color := PanelColor;                        // Farbe aus dem Array
      FillRect(Rect);                                   // Mit der Farbe füllen
      TextOut(Rect.Left + 2, Rect.Top + 2, Panel.Text); // Textausgeben
    end;
  end;
end;

procedure TFrmPlakettenverwaltung.BBtnPlakettenClick(Sender: TObject);
begin
  FrmPlakettenbestaende.ShowModal;
end;

procedure TFrmPlakettenverwaltung.BBtnSchliessenClick(Sender: TObject);
begin
  Application.Terminate;
  Exit;
end;

procedure TFrmPlakettenverwaltung.BBtnWertePruefClick(Sender: TObject);
begin
  FrmWertePruef.ShowModal;
end;

procedure TFrmPlakettenverwaltung.BBtnEinstellungenClick(Sender: TObject);
var ret: Integer;
begin
  if FrmEinstellungen.ShowModal = mrOk then
  begin
    self.SendRequest_Infos();

//    MessageDlg('Bevor die Änderungen wirksam werden müssen Sie das Programm neu starten!' + #13 + #13 +
//        'Das Programm beendet sich nun von alleine.', mtInformation, [mbOK], 0);
//    Application.Terminate;
//    Exit;
  end;
end;

procedure TFrmPlakettenverwaltung.BBtnAuswertungClick(Sender: TObject);
begin
  FrmAuswertung.ShowModal;
end;

procedure TFrmPlakettenverwaltung.MIProtokollClick(Sender: TObject);
begin
  FrmProtokoll.ShowModal;
end;

procedure TFrmPlakettenverwaltung.MIHilfeClick(Sender: TObject);
begin
//  Application.HelpFile := 'Plakettenverwaltung_Hilfe.hlp';
//  Application.HelpCommand(HELP_CONTEXT, 998);
  Application.HelpContext(2);
//  Application.HelpJump('TApplication_HelpJump');
end;

initialization

end.
