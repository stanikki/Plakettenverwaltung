unit TData;

interface

uses
  Windows, SysUtils, Classes, adscnnct, adsset, IniFiles, Forms, Graphics, Registry;

// die Programmversion muss bei jeder neuen Version erhöht werden  
const PRG_VERSION   = '81.05';
const PRG_LANGUAGE  = 'DE';
const PRG_NAME      = 'Plakettenverwaltung';

const PRG_PRT_FILE  = PRG_NAME + '.txt';

const PRG_MANDANT_TK  = '10';
const PRG_MANDANT_FSP = '33';

const TASKINI_FILENAME = 'task1.ini';
const PLAKINI_FILENAME = PRG_NAME + '.ini';
const CURRENT_TASK_VERSION = '5.70';

const PRG_DEF_DATE  = '01.01.1999';
const PRG_PDF_DRV   = 'TaskPdfConverter';

const PRG_ABBORT_CHECKTIME = 500;
const STATUS_COLOR: array[1..4] of TColor = (clBtnFace,clGreen,clYellow,clRed);

const SAPSystemStr : array[0..2] of string = ('Entwicklung','Training','Produktion');
type TPVSAPSystem = (sapEntwicklung, sapTraining, sapProduktion);

const ConnectionTypeStr : array[0..1] of string = ('Intranet','Internet');
type TPVConnectionType = (ctIntranet, ctInternet);

// oneSAP on HANA
const MandantStr : array[0..2] of String = ('OneSAP','TK','FSP');
type TPVMandant = (manOneSAP, manTK, manFSP);

const INI_SEC_MOP               = 'MOP';
const INI_SEC_TMOP              = 'TMOP';
const INI_SEC_PRIVATE           = 'PRIVATE';
const INI_SEC_DATA              = 'DATA';
const INI_SEC_SETTINGS          = 'SETTINGS';
const INI_SEC_CONTROLS          = 'CONTROLS';
const INI_SEC_SAPDATA           = 'SAPDATA';
const INI_SEC_WEBSERVICES       = 'WEBSERVICES';
const INI_KEY_PATH              = 'Path';
const INI_KEY_DBPATH            = 'DBPath';
const INI_DBPATH_SHARED         = 'C:\Programme\Task1\Netdata\Shared';
const INI_KEY_CONNECTTYPE       = 'DBConnectType';
const INI_CONNECTTYPE_DEFAULT   = ord(stAds_LOCAL);
const INI_KEY_STARTPRG          = 'StartPRG';
const INI_STARTPRG_DEF          = '01.04.2011';
const INI_KEY_PLAKETTENJAHRVON  = 'PlakettenjahrVon';
const INI_PLAKETTENJAHRVON_DEF  = 2008;
const INI_KEY_PLAKETTENJAHRBIS  = 'PlakettenjahrBis';
const INI_PLAKETTENJAHRBIS_DEF  = 2020;
const INI_KEY_PLAKETTENSTEPS    = 'PlakettenSteps';
const INI_PLAKETTENSTEPS_DEF    = 10;
const INI_KEY_YEARSINPAST       = 'YearsInPast';
const INI_YEARSINPAST_DEF       = 2;
const INI_KEY_YEARSINFUTURE     = 'YearsInFuture';
const INI_YEARSINFUTURE_DEF     = 4;
const INI_KEY_PROXY             = 'Proxy';
const INI_KEY_PROXYUSER         = 'User';
const INI_KEY_PROXYPW           = 'PW';
const INI_KEY_LOGREORGCOUNT     = 'LogReorgCount';
const INI_LOGREORGCOUNT_DEF     = 100;
const INI_KEY_SYSTEM            = 'SAPSystem';
const INI_SYSTEM_DEF            = ord(sapEntwicklung);
const INI_VALUES_DEF            = '';
const INI_KEY_CONNECTIONTYPE    = 'ConnectionType';
const INI_CONNECTIONTYPE_DEF    = ord(ctIntranet);
const INI_KEY_USEPROXY          = 'UseProxy';
const INI_USEPROXY_DEF          = 1;
const INI_KEY_STATISTIK         = 'Statistik';
const INI_STATISTIK_DEF         = 0;
const INI_KEY_SHOWALLSETTINGS   = 'ShowAllSettings';
const INI_SHOWALLSETTINGS_DEF   = 0;
const INI_KEY_DEFAULTDEPOT      = 'DefaultDepot';
const INI_DEFAULTDEPOT_DEF      = 0;
const INI_KEY_ALLTRANSACTIONS   = 'ShowAllTransactions';
const INI_ALLTRANSACTIONS_DEF   = 1;

const INI_KEY_INTERNET_DEV      = 'Internet_DEV';
const INI_KEY_INTERNET_TRG      = 'Internet_TRG';
const INI_KEY_INTERNET_PRD      = 'Internet_PRD';

const INI_KEY_INTRANET_DEV      = 'Intranet_DEV';
const INI_KEY_INTRANET_TRG      = 'Intranet_TRG';
const INI_KEY_INTRANET_PRD      = 'Intranet_PRD';

const INI_KEY_TSBSTINDEX        = 'TSBSTIndex';
const INI_TSBSTINDEX_DEF        = 'D_BUCHUNGSDATUM';

// Datenbanken und Key's
const DEF_TBL_KEY           = 'SF3dpe95G8Zr';

const PRG_SAP_INFOS_PLTYP   = 'SAP_INFOS_PLTYP.adt';
const PRG_SAP_INFOS_DEPOT   = 'SAP_INFOS_DEPOT.adt';
const PRG_SAP_INFOS_BSCHL   = 'SAP_INFOS_BSCHL.adt';
const PRG_SAP_INFOS_SART    = 'SAP_INFOS_SART.adt';

const PRG_SAP_SVDATA_EPLAK  = 'SAP_SVDATA_EPLAK.adt';
const PRG_SAP_SVDATA_APLAK  = 'SAP_SVDATA_APLAK.adt';
const PRG_SAP_SVDATA_VBBST  = 'SAP_SVDATA_VBBST.adt';
const PRG_SAP_SVDATA_TSBST  = 'SAP_SVDATA_TSBST.adt';

const PRG_LOG_FILENAME      = 'SAP_WSLOG.adt';
const PRG_SAPWS_USER        = 'SAP_WSUSER.adt';

// Beispiele für WebService-URL's
// http://trg101.de.tuv.com:1080/sap/bc/srt/rfc/sap/Z_PLV_GET_INFOS_V01?sap-client=010&wsdl=1.1
// https://plakettenvt.de.tuv.com/sap/bc/srt/rfc/sap/Z_PLV_GET_INFOS_V01?sap-client=010&wsdl=1.1

// alle Kosntanten für den Aufbau der URL's der Webservices
const URL_WS_HTTP               = 'http://';
const URL_WS_HTTPS              = 'https://';

const URL_WS_DEV_INTER          = URL_WS_HTTPS + 'dev101.de.tuv.com:8443';
const URL_WS_TRG_INTER          = URL_WS_HTTPS + 'trg101.de.tuv.com:8443';
const URL_WS_PRD_INTER          = URL_WS_HTTPS + 'prd101.de.tuv.com:8443';

const URL_WS_DEV_INTRA          = URL_WS_HTTPS + 'dev101.de.tuv.com:8443';
const URL_WS_TRG_INTRA          = URL_WS_HTTPS + 'trg101.de.tuv.com:8443';
const URL_WS_PRD_INTRA          = URL_WS_HTTPS + 'prd101.de.tuv.com:8443';

const URL_WS_SAPPATH            = '/sap/bc/srt/rfc/sap/';

const URL_WS_GET_INFOS          = 'Z_PLV_GET_INFOS_V';
const URL_WS_GET_SVDATA         = 'Z_PLV_GET_SVDATA_V';
const URL_WS_SET_SVDATA         = 'Z_PLV_SET_SVDATA_V';
const URL_WS_SELECT_SVDATA      = 'Z_PLV_SELECT_SVDATA_V';

const URL_WS_VERSION            = '01';

const URL_WS_SAPCLIENT          = '?sap-client=';
const URL_WS_SAPCLIENT_TK       = '?sap-client=010';
const URL_WS_SAPCLIENT_FSP      = '?sap-client=033';

const URL_WS_WSDL_VERSION       = '&wsdl=1.1';

const SAP_USER          = 'rfc_pls_ws';
// unterschiedliche Passwörter pro SAP-Mandant und pro SAP-System
// oneSAP on HANA
const SAP_PW_DEV        = 'plvsv01';
const SAP_PW_TRG        = 'plvsv01';
const SAP_PW_PRD        = 'X5[$-3S<';
const SAP_PW_TK_DEV     = 'plvsv01';
const SAP_PW_TK_TRG     = 'plvsv01';
const SAP_PW_TK_PRD     = 'X5[$-3S<';
const SAP_PW_FSP_DEV    = 'plvsv01';
const SAP_PW_FSP_TRG    = 'plvsv01';
const SAP_PW_FSP_PRD    = '7]8~B29W';

// Einträge für das externe DNS (HOSTS-Datei auf dem Client)
//const HOSTS_FILEHOSTS_FILE            = 'C:\Windows\System32\drivers\etc\hosts';
//const HOSTS_DEV             = '172.21.29.91 dev101.de.tuv.com dev101 plakettenvd.de.tuv.com plakettenvd';
//const HOSTS_TRG             = '172.21.29.91 trg101.de.tuv.com trg101 plakettenvt.de.tuv.com plakettenvt';
//const HOSTS_PRD             = '172.21.29.91 prd101.de.tuv.com prd101 plakettenvp.de.tuv.com plakettenvp';

const FRM_CAPTION_ABGAENGE_INSERT = 'Plakettenabgänge - Erfassen';
const FRM_CAPTION_ABGAENGE_EDIT = 'Plakettenabgänge - Bearbeiten';

const FRM_CAPTION_BESTAND_INSERT = 'Tatsächlicher Bestand - Erfassen';
const FRM_CAPTION_BESTAND_EDIT = 'Tatsächlicher Bestand - Bearbeiten';

const RET_EPLAK = 'EPLAK';
const RET_APLAK = 'APLAK';
const RET_TSBST = 'TSBST';

const TXT_ALLE  = 'Alle';

type TPVFormModus = (fmEdit, fmInsert);

type TPVUserLevel = (ulNone, ulStandard, ulAdmin, ulSupervisor);
type TPVPlakettenTyp = (ptHU, ptSP);
type TPVMsgTyp = set of char;

type TES_MSG = record
  msgid: String[20];
  msgty: TPVMsgTyp;
  msgno: String[3];
  msgtxt: ShortString;    // Zeichenkette max. 255 Byte
end;

type
  TDaMConnections = class(TDataModule)
    AdsConnectionMOP: TAdsConnection;
    AdsConnectionTMOP: TAdsConnection;
    AdsConnectionPRIVATE: TAdsConnection;
    AdsConnectionSHARED: TAdsConnection;
    AdsSettings1: TAdsSettings;
    AdsConnectionPlakettenverwaltung: TAdsConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    Taskini: TIniFile;
    Plakini: TIniFile;

    function SetProxyEnable(i: Integer): Integer;
    function GetProxyEnable(): Integer;
    function StringReplace(const Source, OldPattern, NewPattern: WideString): WideString;
//    function GetTempDir(): string;
  end;

var
  DaMConnections: TDaMConnections;

implementation

{$R *.dfm}

procedure TDaMConnections.DataModuleCreate(Sender: TObject);
var button: Integer;
  PathToTaskini, PathToPlakini: String;
  PathToPlakettenDBs: String;
begin

  // Task1.ini "laden"
  PathToTaskini := ExtractFileDir(Application.ExeName) + '\' + TASKINI_FILENAME;
  if not FileExists(PathToTaskini) then
  begin
    button := Application.MessageBox(PChar(TASKINI_FILENAME + ' konnte nicht gefunden werden. Stellen Sie sicher, dass dieses Programm im korrekten bin-Verzeichnis ausgeführt wird!'), PChar(Application.Title), 16);
    Application.Terminate;
    Exit;
  end;
  Taskini := TIniFile.Create(PathToTaskini);

  // Connections aufbauen
  AdsConnectionMOP.ConnectPath := Taskini.ReadString(INI_SEC_MOP, INI_KEY_PATH, INI_VALUES_DEF);
  AdsConnectionMOP.AdsServerTypes := [TAdsServerType(TaskIni.ReadInteger(INI_SEC_MOP, INI_KEY_CONNECTTYPE, INI_CONNECTTYPE_DEFAULT))];
  AdsConnectionMOP.Connect;

  AdsConnectionTMOP.ConnectPath := Taskini.ReadString(INI_SEC_TMOP, INI_KEY_PATH, INI_VALUES_DEF);
  AdsConnectionTMOP.AdsServerTypes := [TAdsServerType(TaskIni.ReadInteger(INI_SEC_TMOP, INI_KEY_CONNECTTYPE, INI_CONNECTTYPE_DEFAULT))];
  AdsConnectionTMOP.Connect;

  AdsConnectionPRIVATE.ConnectPath := Taskini.ReadString(INI_SEC_PRIVATE, INI_KEY_PATH, INI_VALUES_DEF);
  AdsConnectionPRIVATE.AdsServerTypes := [TAdsServerType(TaskIni.ReadInteger(INI_SEC_PRIVATE, INI_KEY_CONNECTTYPE, INI_CONNECTTYPE_DEFAULT))];
  AdsConnectionPRIVATE.Connect;

  AdsConnectionSHARED.ConnectPath := TaskIni.ReadString(INI_SEC_DATA, INI_KEY_PATH, INI_VALUES_DEF);
  AdsConnectionSHARED.AdsServerTypes := [TAdsServerType(TaskIni.ReadInteger(INI_SEC_DATA, INI_KEY_CONNECTTYPE, INI_CONNECTTYPE_DEFAULT))];
  AdsConnectionSHARED.Connect;

  // Plakettenverwaltung.ini "laden"
  PathToPlakini := ExtractFileDir(Application.ExeName) + '\' + PLAKINI_FILENAME;
  if not FileExists(PathToPlakini) then
  begin
    button := Application.MessageBox(PChar(PLAKINI_FILENAME + ' konnte nicht gefunden werden. Stellen Sie sicher, dass dieses Programm im korrekten bin-Verzeichnis ausgeführt wird!'), PChar(Application.Title), 16);
    Application.Terminate;
    Exit;
  end;
  Plakini := TIniFile.Create(PathToPlakini);

  // Datenbanken-Pfad und Connection-Typ aus Plakettenverwaltung.ini auslesen
  PathToPlakettenDBs := Plakini.ReadString(INI_SEC_SETTINGS, INI_KEY_DBPATH, INI_DBPATH_SHARED);
  if not (DirectoryExists(PathToPlakettenDBs)) then
    if not (CreateDir(PathToPlakettenDBs)) then
    begin
      button := Application.MessageBox(PChar('Für die Plakettenverwaltung konnte folgendes Verzeichnis nicht angelegt werden: ' + PathToPlakettenDBs), PChar(Application.Title), 16);
      Application.Terminate;
      Exit;
    end;
  AdsConnectionPlakettenverwaltung.ConnectPath := PathToPlakettenDBs;
  AdsConnectionPlakettenverwaltung.AdsServerTypes := [TAdsServerType(Plakini.ReadInteger(INI_SEC_SETTINGS, INI_KEY_CONNECTTYPE, INI_CONNECTTYPE_DEFAULT))];
  AdsConnectionPlakettenverwaltung.Connect;

end;

procedure TDaMConnections.DataModuleDestroy(Sender: TObject);
begin

  if AdsConnectionMOP.IsConnected then
    AdsConnectionMOP.Disconnect;

  if AdsConnectionTMOP.IsConnected then
    AdsConnectionTMOP.Disconnect;

  if AdsConnectionPRIVATE.IsConnected then
    AdsConnectionPRIVATE.Disconnect;

  if AdsConnectionSHARED.IsConnected then
    AdsConnectionSHARED.Disconnect;

  if AdsConnectionPlakettenverwaltung.IsConnected then
    AdsConnectionPlakettenverwaltung.Disconnect;

  AdsConnectionMOP.Destroy;
  AdsConnectionTMOP.Destroy;
  AdsConnectionPRIVATE.Destroy;
  AdsConnectionSHARED.Destroy;
  AdsConnectionPlakettenverwaltung.Destroy;
  AdsSettings1.Free;
end;

function TDaMConnections.StringReplace(const Source, OldPattern, NewPattern: WideString): WideString;
// Replace every occurrence, case insensitive
var
   C: Integer;
   FoundCount: Integer;
   SourcePosition: Integer;
   Positions: array of Integer;

   SourceLength, OldPatternLength, NewPatternLength: Integer;
   WideCharLength: Integer;
   Helper: Integer;

   PSource, PDest, PNew: PWideChar;
begin
  // Is there anything to do?
  if (OldPattern = NewPattern) or
     (Source = '') or
     (OldPattern = '') then
  begin
    Result := Source;
    Exit;
  end;

  // Initialize some variables
  SourceLength := Length(Source);
  OldPatternLength := Length(OldPattern);
  NewPatternLength := Length(NewPattern);
  WideCharLength := SizeOf(WideChar);

  FoundCount := 0;

  // We *should* range check here, but who has strings > 4GB ?
  SetLength(Positions, SourceLength div OldPatternLength + 1);

  Helper := OldPatternLength * WideCharLength;

  C := 1;
  while C <= SourceLength - OldPatternLength + 1 do
  begin
    if Source[C] = OldPattern[1] then // Check first char before we waste a jump to CompareMem
    begin
      if CompareMem(@Source[C], @OldPattern[1], Helper) then
      begin
        Positions[FoundCount] := C; // Store the found position
        Inc(FoundCount);
        Inc(C, OldPatternLength - 1); // Jump to after OldPattern
      end;
    end;
    Inc(C);
  end;

  if FoundCount > 0 then // Have we found anything?
  begin
    // We know the length of the result
    // Again, we *should* range check here...
    SetLength(Result, SourceLength + FoundCount * (NewPatternLength - OldPatternLength));

    // Initialize some variables
    SourcePosition := 1;
    PSource := PWideChar(Source);
    PDest := PWideChar(Result);
    PNew := PWideChar(NewPattern);
    Helper := NewPatternLength * WideCharLength;

    // Replace...
    for C := 0 to FoundCount - 1 do
    begin
      // Copy original and advance resultpos
      Move(PSource^, PDest^, (Positions[C] - SourcePosition) * WideCharLength);
      Inc(PDest, Positions[C] - SourcePosition);

      // Append NewPattern and advance resultpos
      Move(PNew^, PDest^, Helper);
      Inc(PDest, NewPatternLength);

      // Jump to after OldPattern
      Inc(PSource, Positions[C] - SourcePosition + OldPatternLength);
      SourcePosition := Positions[C] + OldPatternLength;
    end;
    // Append characters after last OldPattern
    Move(PSource^, PDest^, (SourceLength - SourcePosition + 1) * WideCharLength);
  end else
    Result := Source; // Nothing to replace

  // Clean up
  Finalize(Positions);
end;

function TDaMConnections.GetProxyEnable(): Integer;
var registry: TRegistry;
  i: Integer;
begin
  i := 99;

  registry := TRegistry.Create;

  try
    registry.RootKey := HKEY_CURRENT_USER;

    if registry.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings',false) then
    begin
      i := registry.ReadInteger('ProxyEnable');
    end;

  finally
    registry.Free;
  end;

  result := i;
end;


function TDaMConnections.SetProxyEnable(i: Integer): Integer;
var registry: TRegistry;
  j: Integer;
begin
  result := 99;

  registry := TRegistry.Create;

  try
    registry.RootKey := HKEY_CURRENT_USER;

    if registry.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Internet Settings',false) then
    begin
      j := registry.ReadInteger('ProxyEnable');
      result := j;
      if not (i = j) then
      begin
        registry.WriteInteger('ProxyEnable', i);
      end;
    end;

  finally
    registry.Free;
  end;

end;

{
function TDaMConnections.GetTempDir(): string;
var
  Dir: string;
  Len: DWord;
begin
  SetLength(Dir,MAX_PATH);
  Len:=GetTempPath(MAX_PATH,PChar(Dir));
  if Len>0 then
  begin
    SetLength(Dir,Len);
    Result:=Dir;
  end
  else
    RaiseLastOSError;
end;
}

end.
