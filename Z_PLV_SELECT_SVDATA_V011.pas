// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_SELECT_SVDATA_V01?sap-client=010&wsdl=1.1
//  >Import : https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_SELECT_SVDATA_V01?sap-client=010&wsdl=1.1:0
// Encoding : utf-8
// Codegen  : [wfAllowOutParameters+]
// Version  : 1.0
// (14.02.2011 09:33:44 - - $Rev: 10138 $)
// ************************************************************************ //

unit Z_PLV_SELECT_SVDATA_V011;

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

  ZPLV_BSCHL_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_SVKPF_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_MESSAGE_V01     = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_SVSEL_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_SVDATA_V01      = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  item                 = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }
  item2                = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }

  TableOfZPLV_SVDATA_V01 = array of item;       { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  TableOfZPLV_BSCHL_V01 = array of item2;       { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  char220         =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric3        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char20          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char1           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char11          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char9           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric5        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char40          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char2           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char4           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char50          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric2        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : ZPLV_BSCHL_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_BSCHL_V01 = class(TRemotable)
  private
    FBSCHL: numeric2;
    FBEZ: char40;
  published
    property BSCHL: numeric2  Index (IS_UNQL) read FBSCHL write FBSCHL;
    property BEZ:   char40    Index (IS_UNQL) read FBEZ write FBEZ;
  end;

  numeric8        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


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

  numeric4        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char3           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : ZPLV_SVSEL_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_SVSEL_V01 = class(TRemotable)
  private
    FBUKRS: char4;
    FPERNR: numeric8;
    FPLJAHR: numeric4;
    FVOBUDAT: numeric8;
    FBIBUDAT: numeric8;
    FPLTYP: char3;
    FBO_BSTAN: char1;
    FBO_SIVGL: char1;
    FABWTZ: char9;
    FCB_BST: char1;
    FCB_BUCH: char1;
  published
    property BUKRS:    char4     Index (IS_UNQL) read FBUKRS write FBUKRS;
    property PERNR:    numeric8  Index (IS_UNQL) read FPERNR write FPERNR;
    property PLJAHR:   numeric4  Index (IS_UNQL) read FPLJAHR write FPLJAHR;
    property VOBUDAT:  numeric8  Index (IS_UNQL) read FVOBUDAT write FVOBUDAT;
    property BIBUDAT:  numeric8  Index (IS_UNQL) read FBIBUDAT write FBIBUDAT;
    property PLTYP:    char3     Index (IS_UNQL) read FPLTYP write FPLTYP;
    property BO_BSTAN: char1     Index (IS_UNQL) read FBO_BSTAN write FBO_BSTAN;
    property BO_SIVGL: char1     Index (IS_UNQL) read FBO_SIVGL write FBO_SIVGL;
    property ABWTZ:    char9     Index (IS_UNQL) read FABWTZ write FABWTZ;
    property CB_BST:   char1     Index (IS_UNQL) read FCB_BST write FCB_BST;
    property CB_BUCH:  char1     Index (IS_UNQL) read FCB_BUCH write FCB_BUCH;
  end;



  // ************************************************************************ //
  // XML       : ZPLV_SVDATA_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_SVDATA_V01 = class(TRemotable)
  private
    FPLTYP: char3;
    FPLJAHR: numeric4;
    FBUDAT: numeric8;
    FBSCHL: numeric2;
    FBSBEZ: char50;
    FCBUKRS: char4;
    FCDEPOT: char2;
    FCDEBEZ: char40;
    FCPERNR: numeric8;
    FCEMNAM: char40;
    FPCNR: char4;
    FPCLNW: numeric5;
    FPLANZ: char9;
    FPLANZO: char9;
    FPLBST: char11;
    FPLBSTO: char11;
    FTSBST: char11;
    FBSTABW: char11;
    FHINW: char50;
    FSART: char2;
  published
    property PLTYP:  char3     Index (IS_UNQL) read FPLTYP write FPLTYP;
    property PLJAHR: numeric4  Index (IS_UNQL) read FPLJAHR write FPLJAHR;
    property BUDAT:  numeric8  Index (IS_UNQL) read FBUDAT write FBUDAT;
    property BSCHL:  numeric2  Index (IS_UNQL) read FBSCHL write FBSCHL;
    property BSBEZ:  char50    Index (IS_UNQL) read FBSBEZ write FBSBEZ;
    property CBUKRS: char4     Index (IS_UNQL) read FCBUKRS write FCBUKRS;
    property CDEPOT: char2     Index (IS_UNQL) read FCDEPOT write FCDEPOT;
    property CDEBEZ: char40    Index (IS_UNQL) read FCDEBEZ write FCDEBEZ;
    property CPERNR: numeric8  Index (IS_UNQL) read FCPERNR write FCPERNR;
    property CEMNAM: char40    Index (IS_UNQL) read FCEMNAM write FCEMNAM;
    property PCNR:   char4     Index (IS_UNQL) read FPCNR write FPCNR;
    property PCLNW:  numeric5  Index (IS_UNQL) read FPCLNW write FPCLNW;
    property PLANZ:  char9     Index (IS_UNQL) read FPLANZ write FPLANZ;
    property PLANZO: char9     Index (IS_UNQL) read FPLANZO write FPLANZO;
    property PLBST:  char11    Index (IS_UNQL) read FPLBST write FPLBST;
    property PLBSTO: char11    Index (IS_UNQL) read FPLBSTO write FPLBSTO;
    property TSBST:  char11    Index (IS_UNQL) read FTSBST write FTSBST;
    property BSTABW: char11    Index (IS_UNQL) read FBSTABW write FBSTABW;
    property HINW:   char50    Index (IS_UNQL) read FHINW write FHINW;
    property SART:   char2     Index (IS_UNQL) read FSART write FSART;
  end;

  char5           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item = class(ZPLV_SVDATA_V01)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item2 = class(ZPLV_BSCHL_V01)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : Z_PLV_SELECT_SVDATA_V01SoapBinding
  // service   : Z_PLV_SELECT_SVDATA_V01Service
  // port      : Z_PLV_SELECT_SVDATA_V01SoapBinding
  // URL       : http://trg101.de.tuv.com:1080/sap/bc/srt/rfc/sap/Z_PLV_SELECT_SVDATA_V01?sap-client=010
  // ************************************************************************ //
  Z_PLV_SELECT_SVDATA_V01 = interface(IInvokable)
  ['{8F56FCAD-25B5-0F8F-0788-16DCF7418BCB}']
    procedure Z_PLV_SELECT_SVDATA_V01(var ET_SVDATA_V01: TableOfZPLV_SVDATA_V01; const IF_PLVV: char5; const IS_SVSEL_V01: ZPLV_SVSEL_V01; var IT_BSCHL_V01: TableOfZPLV_BSCHL_V01; out ES_MSG: ZPLV_MESSAGE_V01; out ES_SVKPF_V01: ZPLV_SVKPF_V01
                                      ); stdcall;
  end;

function GetZ_PLV_SELECT_SVDATA_V01(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Z_PLV_SELECT_SVDATA_V01;


implementation
  uses SysUtils;

function GetZ_PLV_SELECT_SVDATA_V01(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Z_PLV_SELECT_SVDATA_V01;
const
  defWSDL = 'https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_SELECT_SVDATA_V01?sap-client=010&wsdl=1.1';
  defURL  = 'http://trg101.de.tuv.com:1080/sap/bc/srt/rfc/sap/Z_PLV_SELECT_SVDATA_V01?sap-client=010';
  defSvc  = 'Z_PLV_SELECT_SVDATA_V01Service';
  defPrt  = 'Z_PLV_SELECT_SVDATA_V01SoapBinding';
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
    Result := (RIO as Z_PLV_SELECT_SVDATA_V01);
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
  InvRegistry.RegisterInterface(TypeInfo(Z_PLV_SELECT_SVDATA_V01), 'urn:sap-com:document:sap:rfc:functions', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Z_PLV_SELECT_SVDATA_V01), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Z_PLV_SELECT_SVDATA_V01), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_SVDATA_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_SVDATA_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_BSCHL_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_BSCHL_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char220), 'urn:sap-com:document:sap:rfc:functions', 'char220');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric3), 'urn:sap-com:document:sap:rfc:functions', 'numeric3');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char20), 'urn:sap-com:document:sap:rfc:functions', 'char20');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char1), 'urn:sap-com:document:sap:rfc:functions', 'char1');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char11), 'urn:sap-com:document:sap:rfc:functions', 'char11');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char9), 'urn:sap-com:document:sap:rfc:functions', 'char9');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric5), 'urn:sap-com:document:sap:rfc:functions', 'numeric5');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char40), 'urn:sap-com:document:sap:rfc:functions', 'char40');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char2), 'urn:sap-com:document:sap:rfc:functions', 'char2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char4), 'urn:sap-com:document:sap:rfc:functions', 'char4');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char50), 'urn:sap-com:document:sap:rfc:functions', 'char50');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric2), 'urn:sap-com:document:sap:rfc:functions', 'numeric2');
  RemClassRegistry.RegisterXSClass(ZPLV_BSCHL_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_BSCHL_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric8), 'urn:sap-com:document:sap:rfc:functions', 'numeric8');
  RemClassRegistry.RegisterXSClass(ZPLV_SVKPF_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_SVKPF_V01');
  RemClassRegistry.RegisterXSClass(ZPLV_MESSAGE_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_MESSAGE_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric4), 'urn:sap-com:document:sap:rfc:functions', 'numeric4');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char3), 'urn:sap-com:document:sap:rfc:functions', 'char3');
  RemClassRegistry.RegisterXSClass(ZPLV_SVSEL_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_SVSEL_V01');
  RemClassRegistry.RegisterXSClass(ZPLV_SVDATA_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_SVDATA_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char5), 'urn:sap-com:document:sap:rfc:functions', 'char5');
  RemClassRegistry.RegisterXSClass(item, 'urn:sap-com:document:sap:rfc:functions', 'item');
  RemClassRegistry.RegisterXSClass(item2, 'urn:sap-com:document:sap:rfc:functions', 'item2', 'item');

end.