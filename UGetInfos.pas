unit UGetInfos;

interface

uses
  Z_PLV_GET_INFOS_V011, SOAPHTTPClient, SysUtils, TData, adstable;

  var
    SAP_INFOS_PLTYP, SAP_INFOS_DEPOT, SAP_INFOS_BSCHL, SAP_INFOS_SART, TblWSLOG: TAdsTable;

  function SendRequest_GET_INFOS(var cResult: String; HTTPRIO: THTTPRIO; Buchungskreis: String; WebServiceURL: String; UseProxy: Integer; SAPUser: String; SAPPassword: String): Boolean;

implementation

function SendRequest_GET_INFOS(var cResult: String; HTTPRIO: THTTPRIO; Buchungskreis: String; WebServiceURL: String; UseProxy: Integer; SAPUser: String; SAPPassword: String): Boolean;
var
  cPLVV: char5;
  oINFSEL: ZPLV_INFSEL_V01;
  oBSCHL: item;
  oBSCHLS: TableOfZPLV_BSCHL_V01;
  oDEPOT: item2;
  oDEPOTS: TableOfZPLV_DEPOT_V01;
  oPLTYP: item3;
  oPLTYPS: TableOfZPLV_PLTYP_V01;
  oSART: item4;
  oSARTS: TableOfZPLV_SART_V01;

  oMESSAGE: ZPLV_MESSAGE_V01;

  i: Integer;
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

  oINFSEL := ZPLV_INFSEL_V01.Create;
  oINFSEL.SPRAS := PRG_LANGUAGE;
  oINFSEL.BUKRS := Buchungskreis;
  oINFSEL.BUKRS_DEPOT := '';

  oBSCHL := item.Create;
  oDEPOT := item2.Create;
  oPLTYP := item3.Create;
  oSART := item4.Create;

  try
    Zeit1 := Time();

    // Request abschicken und ..
    oMESSAGE := GetZ_PLV_GET_INFOS_V01(True, WebServiceURL, HTTPRIO).Z_PLV_GET_INFOS_V01(oBSCHLS, oDEPOTS, oPLTYPS, oSARTS, cPLVV, oINFSEL);

    Zeit2 := Time();

    // .. Response verarbeiten

    // neue Ergebnisse verarbeiten wenn oMESSAGE ok zurück liefert!!
    if (oMESSAGE.MSGTY = 'S') or (oMESSAGE.MSGTY = '') then
    begin
      for i := 0 to Length(oPLTYPS)-1 do
      begin
        SAP_INFOS_PLTYP.Insert;
        SAP_INFOS_PLTYP.FieldByName('Plakettentyp').AsString          := oPLTYPS[i].PLTYP;
        SAP_INFOS_PLTYP.FieldByName('Bezeichnung').AsString           := oPLTYPS[i].BEZEI;
        SAP_INFOS_PLTYP.Post;
      end;

      for i := 0 to Length(oDEPOTS)-1 do
      begin
        SAP_INFOS_DEPOT.Insert;
        SAP_INFOS_DEPOT.FieldByName('Buchungskreis').AsString         := oDEPOTS[i].BUKRS;
        SAP_INFOS_DEPOT.FieldByName('Depot-ID').AsString              := oDEPOTS[i].DEPOT;
        SAP_INFOS_DEPOT.FieldByName('Bezeichnung').AsString           := oDEPOTS[i].BEZ;
        SAP_INFOS_DEPOT.Post;
      end;

      for i := 0 to Length(oBSCHLS)-1 do
      begin
        SAP_INFOS_BSCHL.Insert;
        SAP_INFOS_BSCHL.FieldByName('Buchungsschluessel').AsString    := oBSCHLS[i].BSCHL;
        SAP_INFOS_BSCHL.FieldByName('Bezeichnung').AsString           := oBSCHLS[i].BEZ;
        SAP_INFOS_BSCHL.Post;
      end;

      for i := 0 to Length(oSARTS)-1 do
      begin
        SAP_INFOS_SART.Insert;
        SAP_INFOS_SART.FieldByName('Domaenenwert').AsString           := oSARTS[i].DOMVALUE_L;
        SAP_INFOS_SART.FieldByName('Bezeichnung').AsString            := oSARTS[i].DDTEXT;
        SAP_INFOS_SART.Post;
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
