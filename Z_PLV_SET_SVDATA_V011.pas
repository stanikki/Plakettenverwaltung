// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_SET_SVDATA_V01?sap-client=010&wsdl=1.1
//  >Import : https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_SET_SVDATA_V01?sap-client=010&wsdl=1.1:0
// Encoding : utf-8
// Codegen  : [wfAllowOutParameters+]
// Version  : 1.0
// (14.02.2011 09:33:43 - - $Rev: 10138 $)
// ************************************************************************ //

unit Z_PLV_SET_SVDATA_V011;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNBD = $0002;
  IS_UNQL = $0008;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  ZPLV_TSBST_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_EPLAK_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_APLAK_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_SVKPF_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_MESSAGE_V01     = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  item                 = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }
  item2                = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }
  item3                = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }
  item4                = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }

  TableOfZPLV_MESSAGE_V01 = array of item;      { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  TableOfZPLV_APLAK_V01 = array of item2;       { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  TableOfZPLV_EPLAK_V01 = array of item3;       { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  TableOfZPLV_TSBST_V01 = array of item4;       { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  char11          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char9           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric10       =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char2           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric4        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char3           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char40          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char4           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char220         =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric3        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char1           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric8        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : ZPLV_TSBST_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_TSBST_V01 = class(TRemotable)
  private
    FBUDAT: numeric8;
    FPLJAHR: numeric4;
    FPLTYP: char3;
    FPBELN: numeric10;
    FPLBST: char11;
    FUPDKZ: char1;
  published
    property BUDAT:  numeric8   Index (IS_UNQL) read FBUDAT write FBUDAT;
    property PLJAHR: numeric4   Index (IS_UNQL) read FPLJAHR write FPLJAHR;
    property PLTYP:  char3      Index (IS_UNQL) read FPLTYP write FPLTYP;
    property PBELN:  numeric10  Index (IS_UNQL) read FPBELN write FPBELN;
    property PLBST:  char11     Index (IS_UNQL) read FPLBST write FPLBST;
    property UPDKZ:  char1      Index (IS_UNQL) read FUPDKZ write FUPDKZ;
  end;



  // ************************************************************************ //
  // XML       : ZPLV_EPLAK_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_EPLAK_V01 = class(TRemotable)
  private
    FPLTYP: char3;
    FPLJAHR: numeric4;
    FBUDAT: numeric8;
    FBUKRS: char4;
    FDEPOT: char2;
    FPERNR: numeric8;
    FPBELN: numeric10;
    FPLANZ: char9;
    FBEZ: char40;
    FERH: char1;
  published
    property PLTYP:  char3      Index (IS_UNQL) read FPLTYP write FPLTYP;
    property PLJAHR: numeric4   Index (IS_UNQL) read FPLJAHR write FPLJAHR;
    property BUDAT:  numeric8   Index (IS_UNQL) read FBUDAT write FBUDAT;
    property BUKRS:  char4      Index (IS_UNQL) read FBUKRS write FBUKRS;
    property DEPOT:  char2      Index (IS_UNQL) read FDEPOT write FDEPOT;
    property PERNR:  numeric8   Index (IS_UNQL) read FPERNR write FPERNR;
    property PBELN:  numeric10  Index (IS_UNQL) read FPBELN write FPBELN;
    property PLANZ:  char9      Index (IS_UNQL) read FPLANZ write FPLANZ;
    property BEZ:    char40     Index (IS_UNQL) read FBEZ write FBEZ;
    property ERH:    char1      Index (IS_UNQL) read FERH write FERH;
  end;



  // ************************************************************************ //
  // XML       : ZPLV_APLAK_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_APLAK_V01 = class(TRemotable)
  private
    FPLTYP: char3;
    FPLJAHR: numeric4;
    FBUDAT: numeric8;
    FBUKRS: char4;
    FDEPOT: char2;
    FPERNR: numeric8;
    FPBELN: numeric10;
    FPLANZ: char9;
    FBEZ: char40;
    FUPDKZ: char1;
  published
    property PLTYP:  char3      Index (IS_UNQL) read FPLTYP write FPLTYP;
    property PLJAHR: numeric4   Index (IS_UNQL) read FPLJAHR write FPLJAHR;
    property BUDAT:  numeric8   Index (IS_UNQL) read FBUDAT write FBUDAT;
    property BUKRS:  char4      Index (IS_UNQL) read FBUKRS write FBUKRS;
    property DEPOT:  char2      Index (IS_UNQL) read FDEPOT write FDEPOT;
    property PERNR:  numeric8   Index (IS_UNQL) read FPERNR write FPERNR;
    property PBELN:  numeric10  Index (IS_UNQL) read FPBELN write FPBELN;
    property PLANZ:  char9      Index (IS_UNQL) read FPLANZ write FPLANZ;
    property BEZ:    char40     Index (IS_UNQL) read FBEZ write FBEZ;
    property UPDKZ:  char1      Index (IS_UNQL) read FUPDKZ write FUPDKZ;
  end;



  // ************************************************************************ //
  // XML       : ZPLV_SVKPF_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_SVKPF_V01 = class(TRemotable)
  private
    FBUKRS: char4;
    FPERNR: numeric8;
    FEMNAM: char40;
  published
    property BUKRS: char4     Index (IS_UNQL) read FBUKRS write FBUKRS;
    property PERNR: numeric8  Index (IS_UNQL) read FPERNR write FPERNR;
    property EMNAM: char40    Index (IS_UNQL) read FEMNAM write FEMNAM;
  end;

  char20          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : ZPLV_MESSAGE_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_MESSAGE_V01 = class(TRemotable)
  private
    FMSGCONT: char20;
    FMSGCONN: numeric8;
    FMSGID: char20;
    FMSGTY: char1;
    FMSGNO: numeric3;
    FMSGTXT: char220;
  published
    property MSGCONT: char20    Index (IS_UNQL) read FMSGCONT write FMSGCONT;
    property MSGCONN: numeric8  Index (IS_UNQL) read FMSGCONN write FMSGCONN;
    property MSGID:   char20    Index (IS_UNQL) read FMSGID write FMSGID;
    property MSGTY:   char1     Index (IS_UNQL) read FMSGTY write FMSGTY;
    property MSGNO:   numeric3  Index (IS_UNQL) read FMSGNO write FMSGNO;
    property MSGTXT:  char220   Index (IS_UNQL) read FMSGTXT write FMSGTXT;
  end;

  char5           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item = class(ZPLV_MESSAGE_V01)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item2 = class(ZPLV_APLAK_V01)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item3 = class(ZPLV_EPLAK_V01)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item4 = class(ZPLV_TSBST_V01)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : Z_PLV_SET_SVDATA_V01SoapBinding
  // service   : Z_PLV_SET_SVDATA_V01Service
  // port      : Z_PLV_SET_SVDATA_V01SoapBinding
  // URL       : http://trg101.de.tuv.com:1080/sap/bc/srt/rfc/sap/Z_PLV_SET_SVDATA_V01?sap-client=010
  // ************************************************************************ //
  Z_PLV_SET_SVDATA_V01 = interface(IInvokable)
  ['{BA6A1B06-86BD-2B81-9241-2104D7BCDF8F}']
    function  Z_PLV_SET_SVDATA_V01(var ET_MSG: TableOfZPLV_MESSAGE_V01; const IF_PLJAHR: numeric4; const IF_PLVV: char5; const IF_SIMUL: char1; const IS_SVKPF_V01: ZPLV_SVKPF_V01; var IT_APLAK_V01: TableOfZPLV_APLAK_V01; 
                                   var IT_EPLAK_V01: TableOfZPLV_EPLAK_V01; var IT_TSBST_V01: TableOfZPLV_TSBST_V01): ZPLV_MESSAGE_V01; stdcall;
  end;

function GetZ_PLV_SET_SVDATA_V01(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Z_PLV_SET_SVDATA_V01;


implementation
  uses SysUtils;

function GetZ_PLV_SET_SVDATA_V01(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Z_PLV_SET_SVDATA_V01;
const
  defWSDL = 'https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_SET_SVDATA_V01?sap-client=010&wsdl=1.1';
  defURL  = 'http://trg101.de.tuv.com:1080/sap/bc/srt/rfc/sap/Z_PLV_SET_SVDATA_V01?sap-client=010';
  defSvc  = 'Z_PLV_SET_SVDATA_V01Service';
  defPrt  = 'Z_PLV_SET_SVDATA_V01SoapBinding';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as Z_PLV_SET_SVDATA_V01);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(Z_PLV_SET_SVDATA_V01), 'urn:sap-com:document:sap:rfc:functions', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Z_PLV_SET_SVDATA_V01), '');
  InvRegistry.RegisterReturnParamNames(TypeInfo(Z_PLV_SET_SVDATA_V01), 'ES_MSG');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Z_PLV_SET_SVDATA_V01), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_MESSAGE_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_MESSAGE_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_APLAK_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_APLAK_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_EPLAK_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_EPLAK_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_TSBST_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_TSBST_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char11), 'urn:sap-com:document:sap:rfc:functions', 'char11');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char9), 'urn:sap-com:document:sap:rfc:functions', 'char9');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric10), 'urn:sap-com:document:sap:rfc:functions', 'numeric10');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char2), 'urn:sap-com:document:sap:rfc:functions', 'char2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric4), 'urn:sap-com:document:sap:rfc:functions', 'numeric4');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char3), 'urn:sap-com:document:sap:rfc:functions', 'char3');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char40), 'urn:sap-com:document:sap:rfc:functions', 'char40');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char4), 'urn:sap-com:document:sap:rfc:functions', 'char4');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char220), 'urn:sap-com:document:sap:rfc:functions', 'char220');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric3), 'urn:sap-com:document:sap:rfc:functions', 'numeric3');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char1), 'urn:sap-com:document:sap:rfc:functions', 'char1');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric8), 'urn:sap-com:document:sap:rfc:functions', 'numeric8');
  RemClassRegistry.RegisterXSClass(ZPLV_TSBST_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_TSBST_V01');
  RemClassRegistry.RegisterXSClass(ZPLV_EPLAK_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_EPLAK_V01');
  RemClassRegistry.RegisterXSClass(ZPLV_APLAK_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_APLAK_V01');
  RemClassRegistry.RegisterXSClass(ZPLV_SVKPF_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_SVKPF_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char20), 'urn:sap-com:document:sap:rfc:functions', 'char20');
  RemClassRegistry.RegisterXSClass(ZPLV_MESSAGE_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_MESSAGE_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char5), 'urn:sap-com:document:sap:rfc:functions', 'char5');
  RemClassRegistry.RegisterXSClass(item, 'urn:sap-com:document:sap:rfc:functions', 'item');
  RemClassRegistry.RegisterXSClass(item2, 'urn:sap-com:document:sap:rfc:functions', 'item2', 'item');
  RemClassRegistry.RegisterXSClass(item3, 'urn:sap-com:document:sap:rfc:functions', 'item3', 'item');
  RemClassRegistry.RegisterXSClass(item4, 'urn:sap-com:document:sap:rfc:functions', 'item4', 'item');

end.