unit UGetSVData;

interface

uses
  Z_PLV_GET_SVDATA_V011, SOAPHTTPClient, SysUtils, adstable, adsfunc, TData;

  var
    SAP_SVDATA_EPLAK, SAP_SVDATA_APLAK, SAP_SVDATA_VBBST, SAP_SVDATA_TSBST, TblWSLOG: TAdsTable;

  function SendRequest_GET_SVDATA(var cResult: String; HTTPRIO: THTTPRIO; Buchungskreis: String; UserPNR: String; WebServiceURL: String; UseProxy: Integer; SAPUser: String; SAPPassword: String; AllTransactions: boolean): Boolean;

implementation

function SendRequest_GET_SVDATA(var cResult: String; HTTPRIO: THTTPRIO; Buchungskreis: String; UserPNR: String; WebServiceURL: String; UseProxy: Integer; SAPUser: String; SAPPassword: String; AllTransactions: boolean): Boolean;
var
  cPLVV: char5;
  cPLJAHR: numeric4;

  oSVKPF: ZPLV_SVKPF_V01;
  oSVKPF2: ZPLV_SVKPF_V01;
  oAPLAK: item;
  oAPLAKS: TableOfZPLV_APLAK_V01;
  oEPLAK: item2;
  oEPLAKS: TableOfZPLV_EPLAK_V01;
  oVBBST: item4;
  oVBBSTS: TableOfZPLV_VBBST_V01;
  oTSBST: item3;
  oTSBSTS: TableOfZPLV_TSBST_V01;

  oMESSAGE: ZPLV_MESSAGE_V01;

  i: Integer;
  Zeit1, Zeit2, cDateTime: TDateTime;
  cRet, cFilter: String;
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

  oSVKPF := ZPLV_SVKPF_V01.Create;
  oSVKPF.BUKRS := Buchungskreis;
  oSVKPF.PERNR := UserPNR;
  oSVKPF.EMNAM := '';

  oAPLAK := item.Create;
  oEPLAK := item2.Create;
  oTSBST := item3.Create;
  oVBBST := item4.Create;

  oSVKPF2 := ZPLV_SVKPF_V01.Create;

  oMESSAGE := ZPLV_MESSAGE_V01.Create;

  try

    Zeit1 := Time();

    // Request abschicken und ..
    GetZ_PLV_GET_SVDATA_V01(True, WebServiceURL, HTTPRIO).Z_PLV_GET_SVDATA_V01(oAPLAKS, oEPLAKS, oTSBSTS, oVBBSTS, cPLJAHR, cPLVV, oSVKPF, oMESSAGE, oSVKPF2);

    Zeit2 := Time();

    // .. Response verarbeiten

    // neue Ergebnisse verarbeiten wenn oMESSAGE ok zurück liefert!!
    if (oMESSAGE.MSGTY = 'S') or (oMESSAGE.MSGTY = '') then
    begin
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

      for i := 0 to Length(oVBBSTS)-1 do
      begin
        SAP_SVDATA_VBBST.Insert;
        SAP_SVDATA_VBBST.FieldByName('Plakettenjahr').AsString        := oVBBSTS[i].PLJAHR;
        SAP_SVDATA_VBBST.FieldByName('Plakettentyp').AsString         := oVBBSTS[i].PLTYP;
        SAP_SVDATA_VBBST.FieldByName('Plakettenbestand').AsString     := oVBBSTS[i].PLBST;
        SAP_SVDATA_VBBST.Post;
      end;

      // alle Bestandsbuchungen zum tatsächlichen Bestand anzeigen oder alte Buchungen ausfiltern?
      if AllTransactions then
      begin
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
      end
      else
      begin
        for i := 0 to Length(oTSBSTS)-1 do
        begin
          // kiek 02.10.12, lfd.Nr./Beschreibung 904/3
          // beim Ausfiltern darf es nur einen Eintrag zu jeder Jahr-HU-Kombination geben.
          // dieser Eintrag muss der aktuellste Eintrag zu der Jahr-HU-Kombination sein.
          cFilter := 'Plakettenjahr="' + oTSBSTS[i].PLJAHR + '" .and. Plakettentyp="' + oTSBSTS[i].PLTYP + '"';
          SAP_SVDATA_TSBST.AdsSetFilter(cFilter);
          SAP_SVDATA_TSBST.AdsGotoTop;
          // Abfrage, ob bereits ein Eintrag zu der aktuellen Jahr-HU-Kombination in der DB existiert
          if not SAP_SVDATA_TSBST.Eof then
          begin
            // hat der Datensatz ein aktuelleres Datum, muss dieser Datensatz eingestellt werden.
            // in diesem Fall überschreibt der neue Datensatz den Alten.
            // hat der Datensatz ein älteres Datum, muss er übersprungen werden.
            if StrToDateTime(Copy(oTSBSTS[i].BUDAT,7,2) + '.' + Copy(oTSBSTS[i].BUDAT,5,2) + '.' + Copy(oTSBSTS[i].BUDAT,1,4)) > StrToDateTime(Copy(SAP_SVDATA_TSBST.FieldByName('Buchungsdatum').AsString,7,2) + '.' + Copy(SAP_SVDATA_TSBST.FieldByName('Buchungsdatum').AsString,5,2) + '.' + Copy(SAP_SVDATA_TSBST.FieldByName('Buchungsdatum').AsString,1,4)) then
            begin
              SAP_SVDATA_TSBST.Edit;
              SAP_SVDATA_TSBST.FieldByName('Buchungsdatum').AsString        := oTSBSTS[i].BUDAT;
              SAP_SVDATA_TSBST.FieldByName('Plakettenjahr').AsString        := oTSBSTS[i].PLJAHR;
              SAP_SVDATA_TSBST.FieldByName('Plakettentyp').AsString         := oTSBSTS[i].PLTYP;
              SAP_SVDATA_TSBST.FieldByName('Plakettenbeleg-Nr').AsString    := oTSBSTS[i].PBELN;
              SAP_SVDATA_TSBST.FieldByName('Plakettenbestand').AsString     := oTSBSTS[i].PLBST;
              SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString   := oTSBSTS[i].UPDKZ;
              SAP_SVDATA_TSBST.Post;
            end;
          end
          else
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
          SAP_SVDATA_TSBST.AdsClearFilter;
        end;
      end;
      
      // oSVKPF2 // für die Auswertung irrelevant !

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
