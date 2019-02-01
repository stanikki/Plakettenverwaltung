unit USelectSVData;

interface

uses
  Z_PLV_SELECT_SVDATA_V011, SOAPHTTPClient, SysUtils, TData, adstable;

  var
    SAP_SVDATA_SVDATA, TblWSLOG: TAdsTable;

  function SendRequest_SELECT_SVDATA(var cResult: String; HTTPRIO: THTTPRIO; Buchungskreis: String; UserPNR: String;
            Plakettenjahr: String; BDatumVon: String; BDatumBis: String; Plakettentyp: String; aElements: array of String;
            lBestandsAnzeige: Boolean; lSollIst: Boolean; Toleranz: String; lBestandsUebersicht: Boolean; lAlleBuchungen: Boolean; WebServiceURL: String; UseProxy: Integer; SAPUser: String; SAPPassword: String): Boolean;

implementation

function SendRequest_SELECT_SVDATA(var cResult: String; HTTPRIO: THTTPRIO; Buchungskreis: String; UserPNR: String;
            Plakettenjahr: String; BDatumVon: String; BDatumBis: String; Plakettentyp: String; aElements: array of String;
            lBestandsAnzeige: Boolean; lSollIst: Boolean; Toleranz: String; lBestandsUebersicht: Boolean; lAlleBuchungen: Boolean; WebServiceURL: String; UseProxy: Integer; SAPUser: String; SAPPassword: String): Boolean;
var

  oSVDATAS: TableOfZPLV_SVDATA_V01;

  cPLVV: char5;

  oSVSEL: ZPLV_SVSEL_V01;

  oBSCHL: item2;
  oBSCHLS: TableOfZPLV_BSCHL_V01;

  oMESSAGE: ZPLV_MESSAGE_V01;

  oSVKPF: ZPLV_SVKPF_V01;

  i, Code: Integer;
  Zeit1, Zeit2: TDateTime;
  cRet: String;
  ProxyEnable, nRet: Integer;
begin

  // Proxy evtl. setzen
  ProxyEnable := DaMConnections.GetProxyEnable();
  if not (ProxyEnable = UseProxy) then
  begin
    nRet := DaMConnections.SetProxyEnable(UseProxy);
  end;

  // RIO initialisieren
  HTTPRIO.Create(nil);
  HTTPRIO.WSDLLocation := WebServiceURL;

  // Proxy- und SAP-Einstellungen
  HTTPRIO.HTTPWebNode.Proxy := DaMConnections.Plakini.ReadString(INI_SEC_SETTINGS, INI_KEY_PROXY, INI_VALUES_DEF);
  HTTPRIO.HTTPWebNode.UserName := SAPUser;
  HTTPRIO.HTTPWebNode.Password := SAPPassword;

  // Request/Response initialisieren
  cPLVV := PRG_VERSION;

  oSVSEL := ZPLV_SVSEL_V01.Create;
  oSVSEL.BUKRS := Buchungskreis;
  oSVSEL.PERNR := UserPNR;
  oSVSEL.PLJAHR := Plakettenjahr;
  if Plakettenjahr = TXT_ALLE then
    oSVSEL.PLJAHR := '';
  oSVSEL.VOBUDAT := BDatumVon;
  oSVSEL.BIBUDAT := BDatumBis;
  oSVSEL.PLTYP := Plakettentyp;
  if Plakettentyp = TXT_ALLE then
    oSVSEL.PLTYP := '';

  if lBestandsAnzeige then
    oSVSEL.BO_BSTAN := 'X'
  else
    oSVSEL.BO_BSTAN := '';

  if lSollIst then
    oSVSEL.BO_SIVGL := 'X'
  else
    oSVSEL.BO_SIVGL := '';

  oSVSEL.ABWTZ := Toleranz;

  if lBestandsUebersicht then
    oSVSEL.CB_BST := 'X'
  else
    oSVSEL.CB_BST := '';

  if lAlleBuchungen then
    oSVSEL.CB_BUCH := 'X'
  else
    oSVSEL.CB_BUCH := '';

  // Buchungsschlüssel einlesen
  // Hinweis: Checkbox 'Alle' wird vorab ausgefiltert
  SetLength(oBSCHLS, Length(aElements));
  for i := 0 to Length(aElements) - 1 do
  begin
    oBSCHL := item2.Create;
    oBSCHL.BSCHL  := aElements[i];
    oBSCHLS[i]    := oBSCHL;
  end;

  oMESSAGE := ZPLV_MESSAGE_V01.Create;

  oSVKPF := ZPLV_SVKPF_V01.Create;

  try

    Zeit1 := Time();

    // Request abschicken und ..
    GetZ_PLV_SELECT_SVDATA_V01(True, WebServiceURL, HTTPRIO).Z_PLV_SELECT_SVDATA_V01(oSVDATAS, cPLVV, oSVSEL, oBSCHLS, oMESSAGE, oSVKPF);

    Zeit2 := Time();

    // .. Response verarbeiten

    // neue Ergebnisse verarbeiten wenn oMESSAGE ok zurück liefert!!
    if (oMESSAGE.MSGTY = 'S') or (oMESSAGE.MSGTY = '') then
    begin

      for i := 0 to Length(oSVDATAS)-1 do
      begin
        SAP_SVDATA_SVDATA.Insert;
        SAP_SVDATA_SVDATA.FieldByName('PTYP').AsString        := oSVDATAS[i].PLTYP;
        SAP_SVDATA_SVDATA.FieldByName('PJAHR').AsString       := oSVDATAS[i].PLJAHR;
        SAP_SVDATA_SVDATA.FieldByName('BDATUM').AsString      := oSVDATAS[i].BUDAT;
        SAP_SVDATA_SVDATA.FieldByName('BSCHL').AsString       := oSVDATAS[i].BSCHL;
        SAP_SVDATA_SVDATA.FieldByName('BSCHLBEZ').AsString    := oSVDATAS[i].BSBEZ;
        SAP_SVDATA_SVDATA.FieldByName('KORRBK').AsString      := oSVDATAS[i].CBUKRS;
        SAP_SVDATA_SVDATA.FieldByName('KORRDEPOT').AsString   := oSVDATAS[i].CDEPOT;
        SAP_SVDATA_SVDATA.FieldByName('DEPOTBEZ').AsString    := oSVDATAS[i].CDEBEZ;
        SAP_SVDATA_SVDATA.FieldByName('KORRSV').AsString      := oSVDATAS[i].CPERNR;
        SAP_SVDATA_SVDATA.FieldByName('SVNAME').AsString      := oSVDATAS[i].CEMNAM;
        SAP_SVDATA_SVDATA.FieldByName('PCNUMMER').AsString    := oSVDATAS[i].PCNR;
        SAP_SVDATA_SVDATA.FieldByName('PCLNWNR').AsString     := oSVDATAS[i].PCLNW;
        SAP_SVDATA_SVDATA.FieldByName('PANZAHL').AsString     := oSVDATAS[i].PLANZ;
        SAP_SVDATA_SVDATA.FieldByName('PANZAHLO').AsString    := oSVDATAS[i].PLANZO;
        SAP_SVDATA_SVDATA.FieldByName('PBESTAND').AsString    := oSVDATAS[i].PLBST;
        SAP_SVDATA_SVDATA.FieldByName('PBESTANDO').AsString   := oSVDATAS[i].PLBSTO;
        SAP_SVDATA_SVDATA.FieldByName('TBESTAND').AsString    := oSVDATAS[i].TSBST;
        SAP_SVDATA_SVDATA.FieldByName('ABWEICHUNG').AsString  := oSVDATAS[i].BSTABW;
        SAP_SVDATA_SVDATA.FieldByName('HINWEIS').AsString     := oSVDATAS[i].HINW;
        SAP_SVDATA_SVDATA.FieldByName('SATZART').AsString     := oSVDATAS[i].SART;
        SAP_SVDATA_SVDATA.Post;
      end;

      cRet := '0';
      Result := true;
    end
    else
    begin
      cResult := oMESSAGE.MSGTXT;

      cRet := '1';
      Result := false;
    end;

  except
    cRet := '2';
    Zeit2 := Time();
    Result := false;
  end;

  // Ergebnis aller Rückgaben loggen
  TblWSLOG.Insert;
  TblWSLOG.FieldByName('Datum').AsDateTime        := Now();
  TblWSLOG.FieldByName('Zeit1').AsDateTime        := Zeit1;
  TblWSLOG.FieldByName('Zeit2').AsDateTime        := Zeit2;
  TblWSLOG.FieldByName('WebService').AsString     := WebServiceURL;
  TblWSLOG.FieldByName('Simu').AsString           := '';
  TblWSLOG.FieldByName('Proxy').AsInteger         := DaMConnections.GetProxyEnable();
  TblWSLOG.FieldByName('Return').AsString         := cRet;

  if cRet <> '2' then
  begin
    TblWSLOG.FieldByName('MsgCont').AsString        := oMESSAGE.MSGCONT;
    TblWSLOG.FieldByName('MsgConn').AsString        := oMESSAGE.MSGCONN;
    TblWSLOG.FieldByName('MsgID').AsString          := oMESSAGE.MSGID;
    TblWSLOG.FieldByName('MsgTy').AsString          := oMESSAGE.MSGTY;
    TblWSLOG.FieldByName('MsgNo').AsString          := oMESSAGE.MSGNO;
    TblWSLOG.FieldByName('MsgTxt').AsString         := oMESSAGE.MSGTXT;
  end;
  TblWSLOG.Post;

  // Proxy evtl. wieder zurückstellen
  nRet := DaMConnections.SetProxyEnable(ProxyEnable);

end;

end.
