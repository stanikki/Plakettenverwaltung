unit USetSVData;

interface

uses
  Z_PLV_SET_SVDATA_V011, SOAPHTTPClient, SysUtils, adstable, TData;

  var
    SAP_SVDATA_EPLAK, SAP_SVDATA_APLAK, SAP_SVDATA_TSBST, TblWSLOG: TAdsTable;

  function SendRequest_SET_SVDATA(var cResult: String; HTTPRIO: THTTPRIO; Buchungskreis: String; UserPNR: String; Eingabenpruefen: Boolean; WebServiceURL: String; UseProxy: Integer; SAPUser: String; SAPPassword: String): Boolean;

implementation

function SendRequest_SET_SVDATA(var cResult: String; HTTPRIO: THTTPRIO; Buchungskreis: String; UserPNR: String; Eingabenpruefen: Boolean; WebServiceURL: String; UseProxy: Integer; SAPUser: String; SAPPassword: String): Boolean;
var
  cPLVV: char5;
  cPLJAHR: numeric4;
  cSIMU: char1;
  oSVKPF: ZPLV_SVKPF_V01;

  oAPLAK: item2;
  oAPLAKS: TableOfZPLV_APLAK_V01;
  oEPLAK: item3;
  oEPLAKS: TableOfZPLV_EPLAK_V01;
  oTSBST: item4;
  oTSBSTS: TableOfZPLV_TSBST_V01;

  oMESSAGE: ZPLV_MESSAGE_V01;
  oMESSAGES: TableOfZPLV_MESSAGE_V01;

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

  // Anzeige der SAP Daten einschränken
  cPLJAHR := IntToStr(StrToInt(FormatDateTime('yyyy', Now())) - DaMConnections.Plakini.ReadInteger(INI_SEC_SAPDATA, INI_KEY_YEARSINPAST, INI_YEARSINPAST_DEF));

  if Eingabenpruefen then
    cSIMU := 'X'
  else
    cSIMU := '';

  oSVKPF := ZPLV_SVKPF_V01.Create;
  oSVKPF.BUKRS := Buchungskreis;
  oSVKPF.PERNR := UserPNR;
  oSVKPF.EMNAM := '';

  try

    // Daten in Variablen einlesen, ..
    i := 0;
    SAP_SVDATA_EPLAK.AdsGotoTop;
    SetLength(oEPLAKS, SAP_SVDATA_EPLAK.RecordCount);
    while not SAP_SVDATA_EPLAK.Eof do
    begin
      oEPLAK := item3.Create;
      oEPLAK.PLTYP  := SAP_SVDATA_EPLAK.FieldByName('Plakettentyp').AsString;
      oEPLAK.PLJAHR := SAP_SVDATA_EPLAK.FieldByName('Plakettenjahr').AsString;
      oEPLAK.BUDAT  := SAP_SVDATA_EPLAK.FieldByName('Buchungsdatum').AsString;
      oEPLAK.BUKRS  := SAP_SVDATA_EPLAK.FieldByName('Quell-Buchungskreis').AsString;
      oEPLAK.DEPOT  := SAP_SVDATA_EPLAK.FieldByName('Quell-Depot').AsString;
      oEPLAK.PERNR  := SAP_SVDATA_EPLAK.FieldByName('Quell-PNr').AsString;
      oEPLAK.PBELN  := SAP_SVDATA_EPLAK.FieldByName('Plakettenbeleg-Nr').AsString;
      oEPLAK.PLANZ  := SAP_SVDATA_EPLAK.FieldByName('Plakettenanzahl').AsString;
      oEPLAK.BEZ    := SAP_SVDATA_EPLAK.FieldByName('Bezeichnung').AsString;
      oEPLAK.ERH    := SAP_SVDATA_EPLAK.FieldByName('Erhalten-Kennzeichen').AsString;
      oEPLAKS[i]    := oEPLAK;
      Inc(i);
      SAP_SVDATA_EPLAK.AdsSkip(1);
    end;

    i := 0;
    SAP_SVDATA_APLAK.AdsGotoTop;
    SetLength(oAPLAKS, SAP_SVDATA_APLAK.RecordCount);
    while not SAP_SVDATA_APLAK.Eof do
    begin
      oAPLAK := item2.Create;
      oAPLAK.PLTYP  := SAP_SVDATA_APLAK.FieldByName('Plakettentyp').AsString;
      oAPLAK.PLJAHR := SAP_SVDATA_APLAK.FieldByName('Plakettenjahr').AsString;
      oAPLAK.BUDAT  := SAP_SVDATA_APLAK.FieldByName('Buchungsdatum').AsString;
      oAPLAK.BUKRS  := SAP_SVDATA_APLAK.FieldByName('Ziel-Buchungskreis').AsString;
      oAPLAK.DEPOT  := SAP_SVDATA_APLAK.FieldByName('Ziel-Depot').AsString;
      oAPLAK.PERNR  := SAP_SVDATA_APLAK.FieldByName('Ziel-PNr').AsString;
      oAPLAK.PBELN  := SAP_SVDATA_APLAK.FieldByName('Plakettenbeleg-Nr').AsString;
      oAPLAK.PLANZ  := SAP_SVDATA_APLAK.FieldByName('Plakettenanzahl').AsString;
      oAPLAK.BEZ    := SAP_SVDATA_APLAK.FieldByName('Bezeichnung').AsString;
      oAPLAK.UPDKZ  := SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString;
      oAPLAKS[i]    := oAPLAK;
      Inc(i);
      SAP_SVDATA_APLAK.AdsSkip(1);
    end;

    i := 0;
    SAP_SVDATA_TSBST.AdsGotoTop;
    SetLength(oTSBSTS, SAP_SVDATA_TSBST.RecordCount);
    while not SAP_SVDATA_TSBST.Eof do
    begin
      oTSBST := item4.Create;
      oTSBST.BUDAT  := SAP_SVDATA_TSBST.FieldByName('Buchungsdatum').AsString;
      oTSBST.PLJAHR := SAP_SVDATA_TSBST.FieldByName('Plakettenjahr').AsString;
      oTSBST.PLTYP  := SAP_SVDATA_TSBST.FieldByName('Plakettentyp').AsString;
      oTSBST.PBELN  := SAP_SVDATA_TSBST.FieldByName('Plakettenbeleg-Nr').AsString;
      oTSBST.PLBST  := SAP_SVDATA_TSBST.FieldByName('Plakettenbestand').AsString;
      oTSBST.UPDKZ  := SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString;
      oTSBSTS[i]    := oTSBST;
      Inc(i);
      SAP_SVDATA_TSBST.AdsSkip(1);
    end;

    Zeit1 := Time();

    // .. Request abschicken und ..
    oMESSAGE := GetZ_PLV_SET_SVDATA_V01(True, WebServiceURL, HTTPRIO).Z_PLV_SET_SVDATA_V01(oMESSAGES, cPLJAHR, cPLVV, cSIMU, oSVKPF, oAPLAKS, oEPLAKS, oTSBSTS);

    Zeit2 := Time();

    // .. Response verarbeiten

    // neue Ergebnisse verarbeiten wenn oMESSAGE ok zurück liefert!!
    if (oMESSAGE.MSGTY = 'S') or (oMESSAGE.MSGTY = '') then
    begin

      SAP_SVDATA_EPLAK.EmptyTable;
      SAP_SVDATA_APLAK.EmptyTable;
      SAP_SVDATA_TSBST.EmptyTable;

      for i := 0 to Length(oEPLAKS)-1 do
      begin
        SAP_SVDATA_EPLAK.Insert;
        SAP_SVDATA_EPLAK.FieldByName('Plakettentyp').AsString         := oEPLAKS[i].PLTYP;
        SAP_SVDATA_EPLAK.FieldByName('Plakettenjahr').AsString        := oEPLAKS[i].PLJAHR;
        SAP_SVDATA_EPLAK.FieldByName('Buchungsdatum').AsString        := oEPLAKS[i].BUDAT;
        SAP_SVDATA_EPLAK.FieldByName('Quell-Buchungskreis').AsString  := oEPLAKS[i].BUKRS;
        SAP_SVDATA_EPLAK.FieldByName('Quell-Depot').AsString          := oEPLAKS[i].DEPOT;
        SAP_SVDATA_EPLAK.FieldByName('Quell-PNr').AsString            := oEPLAKS[i].PERNR;
        SAP_SVDATA_EPLAK.FieldByName('Plakettenbeleg-Nr').AsString    := oEPLAKS[i].PBELN;
        SAP_SVDATA_EPLAK.FieldByName('Plakettenanzahl').AsString      := oEPLAKS[i].PLANZ;
        SAP_SVDATA_EPLAK.FieldByName('Bezeichnung').AsString          := oEPLAKS[i].BEZ;
        SAP_SVDATA_EPLAK.FieldByName('Erhalten-Kennzeichen').AsString := oEPLAKS[i].ERH;
        SAP_SVDATA_EPLAK.Post;
      end;

      for i := 0 to Length(oAPLAKS)-1 do
      begin
        SAP_SVDATA_APLAK.Insert;
        SAP_SVDATA_APLAK.FieldByName('Plakettentyp').AsString         := oAPLAKS[i].PLTYP;
        SAP_SVDATA_APLAK.FieldByName('Plakettenjahr').AsString        := oAPLAKS[i].PLJAHR;
        SAP_SVDATA_APLAK.FieldByName('Buchungsdatum').AsString        := oAPLAKS[i].BUDAT;
        SAP_SVDATA_APLAK.FieldByName('Ziel-Buchungskreis').AsString   := oAPLAKS[i].BUKRS;
        SAP_SVDATA_APLAK.FieldByName('Ziel-Depot').AsString           := oAPLAKS[i].DEPOT;
        SAP_SVDATA_APLAK.FieldByName('Ziel-PNr').AsString             := oAPLAKS[i].PERNR;
        SAP_SVDATA_APLAK.FieldByName('Plakettenbeleg-Nr').AsString    := oAPLAKS[i].PBELN;
        SAP_SVDATA_APLAK.FieldByName('Plakettenanzahl').AsString      := oAPLAKS[i].PLANZ;
        SAP_SVDATA_APLAK.FieldByName('Bezeichnung').AsString          := oAPLAKS[i].BEZ;
        SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString   := oAPLAKS[i].UPDKZ;
        SAP_SVDATA_APLAK.Post;
      end;

      for i := 0 to Length(oTSBSTS)-1 do
      begin
        SAP_SVDATA_TSBST.Insert;
        SAP_SVDATA_TSBST.FieldByName('Buchungsdatum').AsString        := oTSBSTS[i].BUDAT;
        SAP_SVDATA_TSBST.FieldByName('Plakettenjahr').AsString        := oTSBSTS[i].PLJAHR;
        SAP_SVDATA_TSBST.FieldByName('Plakettentyp').AsString         := oTSBSTS[i].PLTYP;
        SAP_SVDATA_TSBST.FieldByName('Plakettenbeleg-Nr').AsString    := oTSBSTS[i].PBELN;
        SAP_SVDATA_TSBST.FieldByName('Plakettenbestand').AsString     := oTSBSTS[i].PLBST;
        SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString   := oTSBSTS[i].UPDKZ;
        SAP_SVDATA_TSBST.Post;
      end;

      cRet := '0';
      Result := true;
    end
    else
    begin
      cResult := oMESSAGE.MSGTXT + #13 + #13;
      for i := 0 to Length(oMESSAGES)-1 do
      begin
        if oMESSAGES[i].MSGCONT = RET_EPLAK then
          cResult := cResult + 'Erhaltene Plaketten: ';
        if oMESSAGES[i].MSGCONT = RET_APLAK then
          cResult := cResult + 'Plakettenabgänge: ';
        if oMESSAGES[i].MSGCONT = RET_TSBST then
          cResult := cResult + 'Tatsächlicher Bestand: ';
        cResult := cResult + oMESSAGES[i].MSGTXT + #13
      end;

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
  TblWSLOG.FieldByName('Simu').AsString           := cSIMU;
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

  if cRet <> '2' then
  begin
    for i := 0 to Length(oMESSAGES)-1 do
    begin
      TblWSLOG.Insert;
      TblWSLOG.FieldByName('MsgCont').AsString        := oMESSAGES[i].MSGCONT;
      TblWSLOG.FieldByName('MsgConn').AsString        := oMESSAGES[i].MSGCONN;
      TblWSLOG.FieldByName('MsgID').AsString          := oMESSAGES[i].MSGID;
      TblWSLOG.FieldByName('MsgTy').AsString          := oMESSAGES[i].MSGTY;
      TblWSLOG.FieldByName('MsgNo').AsString          := oMESSAGES[i].MSGNO;
      TblWSLOG.FieldByName('MsgTxt').AsString         := oMESSAGES[i].MSGTXT;
      TblWSLOG.Post;
    end;
  end;

  // Proxy evtl. wieder zurückstellen
  nRet := DaMConnections.SetProxyEnable(ProxyEnable);

end;

end.

