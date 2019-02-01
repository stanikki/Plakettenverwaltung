// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_GET_INFOS_V01?sap-client=010&wsdl=1.1
//  >Import : https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_GET_INFOS_V01?sap-client=010&wsdl=1.1:0
// Encoding : utf-8
// Codegen  : [wfAllowOutParameters+]
// Version  : 1.0
// (14.02.2011 09:33:40 - - $Rev: 10138 $)
// ************************************************************************ //

unit Z_PLV_GET_INFOS_V011;

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

  ZPLV_MESSAGE_V01     = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_SART_V01        = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_PLTYP_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_INFSEL_V01      = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_DEPOT_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  ZPLV_BSCHL_V01       = class;                 { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  item                 = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }
  item2                = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }
  item3                = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }
  item4                = class;                 { "urn:sap-com:document:sap:rfc:functions"[Alias] }

  TableOfZPLV_BSCHL_V01 = array of item;        { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  TableOfZPLV_DEPOT_V01 = array of item2;       { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  TableOfZPLV_PLTYP_V01 = array of item3;       { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  TableOfZPLV_SART_V01 = array of item4;        { "urn:sap-com:document:sap:rfc:functions"[GblCplx] }
  char220         =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric3        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char1           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  numeric8        =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
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

  char60          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char10          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : ZPLV_SART_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_SART_V01 = class(TRemotable)
  private
    FDOMVALUE_L: char10;
    FDDTEXT: char60;
  published
    property DOMVALUE_L: char10  Index (IS_UNQL) read FDOMVALUE_L write FDOMVALUE_L;
    property DDTEXT:     char60  Index (IS_UNQL) read FDDTEXT write FDDTEXT;
  end;

  char50          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char3           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : ZPLV_PLTYP_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_PLTYP_V01 = class(TRemotable)
  private
    FPLTYP: char3;
    FBEZEI: char50;
  published
    property PLTYP: char3   Index (IS_UNQL) read FPLTYP write FPLTYP;
    property BEZEI: char50  Index (IS_UNQL) read FBEZEI write FBEZEI;
  end;

  char2           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }
  char4           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : ZPLV_INFSEL_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_INFSEL_V01 = class(TRemotable)
  private
    FSPRAS: char2;
    FBUKRS: char4;
    FBUKRS_DEPOT: char4;
  published
    property SPRAS:       char2  Index (IS_UNQL) read FSPRAS write FSPRAS;
    property BUKRS:       char4  Index (IS_UNQL) read FBUKRS write FBUKRS;
    property BUKRS_DEPOT: char4  Index (IS_UNQL) read FBUKRS_DEPOT write FBUKRS_DEPOT;
  end;

  char40          =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : ZPLV_DEPOT_V01, global, <complexType>
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  ZPLV_DEPOT_V01 = class(TRemotable)
  private
    FBUKRS: char4;
    FDEPOT: char2;
    FBEZ: char40;
  published
    property BUKRS: char4   Index (IS_UNQL) read FBUKRS write FBUKRS;
    property DEPOT: char2   Index (IS_UNQL) read FDEPOT write FDEPOT;
    property BEZ:   char40  Index (IS_UNQL) read FBEZ write FBEZ;
  end;

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

  char5           =  type WideString;      { "urn:sap-com:document:sap:rfc:functions"[GblSmpl] }


  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item = class(ZPLV_BSCHL_V01)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item2 = class(ZPLV_DEPOT_V01)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item3 = class(ZPLV_PLTYP_V01)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : item, alias
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // ************************************************************************ //
  item4 = class(ZPLV_SART_V01)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : urn:sap-com:document:sap:rfc:functions
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : Z_PLV_GET_INFOS_V01SoapBinding
  // service   : Z_PLV_GET_INFOS_V01Service
  // port      : Z_PLV_GET_INFOS_V01SoapBinding
  // URL       : http://trg101.de.tuv.com:1080/sap/bc/srt/rfc/sap/Z_PLV_GET_INFOS_V01?sap-client=010
  // ************************************************************************ //
  Z_PLV_GET_INFOS_V01 = interface(IInvokable)
  ['{F73FEE5F-1407-9E13-AFE4-CDB2106EB785}']
    function  Z_PLV_GET_INFOS_V01(var ET_BSCHL_V01: TableOfZPLV_BSCHL_V01; var ET_DEPOT_V01: TableOfZPLV_DEPOT_V01; var ET_PLTYP_V01: TableOfZPLV_PLTYP_V01; var ET_SART_V01: TableOfZPLV_SART_V01; const IF_PLVV: char5; const IS_INFO_V01: ZPLV_INFSEL_V01
                                  ): ZPLV_MESSAGE_V01; stdcall;
  end;

function GetZ_PLV_GET_INFOS_V01(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): Z_PLV_GET_INFOS_V01;


implementation
  uses SysUtils;

function GetZ_PLV_GET_INFOS_V01(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): Z_PLV_GET_INFOS_V01;
const
  defWSDL = 'https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_GET_INFOS_V01?sap-client=010&wsdl=1.1';
  defURL  = 'http://trg101.de.tuv.com:1080/sap/bc/srt/rfc/sap/Z_PLV_GET_INFOS_V01?sap-client=010';
  defSvc  = 'Z_PLV_GET_INFOS_V01Service';
  defPrt  = 'Z_PLV_GET_INFOS_V01SoapBinding';
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
    Result := (RIO as Z_PLV_GET_INFOS_V01);
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
  InvRegistry.RegisterInterface(TypeInfo(Z_PLV_GET_INFOS_V01), 'urn:sap-com:document:sap:rfc:functions', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(Z_PLV_GET_INFOS_V01), '');
  InvRegistry.RegisterReturnParamNames(TypeInfo(Z_PLV_GET_INFOS_V01), 'ES_MSG');
  InvRegistry.RegisterInvokeOptions(TypeInfo(Z_PLV_GET_INFOS_V01), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_BSCHL_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_BSCHL_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_DEPOT_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_DEPOT_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_PLTYP_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_PLTYP_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TableOfZPLV_SART_V01), 'urn:sap-com:document:sap:rfc:functions', 'TableOfZPLV_SART_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char220), 'urn:sap-com:document:sap:rfc:functions', 'char220');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric3), 'urn:sap-com:document:sap:rfc:functions', 'numeric3');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char1), 'urn:sap-com:document:sap:rfc:functions', 'char1');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric8), 'urn:sap-com:document:sap:rfc:functions', 'numeric8');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char20), 'urn:sap-com:document:sap:rfc:functions', 'char20');
  RemClassRegistry.RegisterXSClass(ZPLV_MESSAGE_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_MESSAGE_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char60), 'urn:sap-com:document:sap:rfc:functions', 'char60');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char10), 'urn:sap-com:document:sap:rfc:functions', 'char10');
  RemClassRegistry.RegisterXSClass(ZPLV_SART_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_SART_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char50), 'urn:sap-com:document:sap:rfc:functions', 'char50');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char3), 'urn:sap-com:document:sap:rfc:functions', 'char3');
  RemClassRegistry.RegisterXSClass(ZPLV_PLTYP_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_PLTYP_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char2), 'urn:sap-com:document:sap:rfc:functions', 'char2');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char4), 'urn:sap-com:document:sap:rfc:functions', 'char4');
  RemClassRegistry.RegisterXSClass(ZPLV_INFSEL_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_INFSEL_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char40), 'urn:sap-com:document:sap:rfc:functions', 'char40');
  RemClassRegistry.RegisterXSClass(ZPLV_DEPOT_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_DEPOT_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(numeric2), 'urn:sap-com:document:sap:rfc:functions', 'numeric2');
  RemClassRegistry.RegisterXSClass(ZPLV_BSCHL_V01, 'urn:sap-com:document:sap:rfc:functions', 'ZPLV_BSCHL_V01');
  RemClassRegistry.RegisterXSInfo(TypeInfo(char5), 'urn:sap-com:document:sap:rfc:functions', 'char5');
  RemClassRegistry.RegisterXSClass(item, 'urn:sap-com:document:sap:rfc:functions', 'item');
  RemClassRegistry.RegisterXSClass(item2, 'urn:sap-com:document:sap:rfc:functions', 'item2', 'item');
  RemClassRegistry.RegisterXSClass(item3, 'urn:sap-com:document:sap:rfc:functions', 'item3', 'item');
  RemClassRegistry.RegisterXSClass(item4, 'urn:sap-com:document:sap:rfc:functions', 'item4', 'item');

end.