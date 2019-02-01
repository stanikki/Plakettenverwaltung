unit RRReport;

interface

uses RRDecl32;

type
  //Das ist die Wrapper-Klasse, die einfach nur die Handhabung
  //im Hauptquelltext erleichtern soll
  TRRReport = class(TObject)
  private
    HReport: Integer;
    AppName: PChar;
    ProtFile: String;
  public
//    constructor Create; overload;
    constructor Create(AppName: PChar; ProtFile: String); overload;

    function chooseReportA(Rep: PChar; LibName: PChar): Integer;
    function endReportA(): LongBool;
    function execRuntimeA(bWait: LongBool; FsCmdShow: Integer): LongBool;

    function getErrorInfoA(): LongBool;
    function getRelationInfoA(): LongBool;

    function setOutputDestA(Dest: PChar): LongBool;
    function setOutputFileA(Filename: PChar): LongBool;
    function setPrinterA(Printer: PChar): LongBool;
    function setUserParamA(ParamName: PChar; Value: PChar): LongBool;
    function setWinTitleA(WinTitle: PChar): LongBool;
  end;

implementation

uses SysUtils;

//constructor TRRReport.Create;
//begin
//  inherited;
//  {...}
//end;

constructor TRRReport.Create(AppName: PChar; ProtFile: String);
begin
  Create;  // call contructor TRRReport.Create
  self.HReport := 0;
  self.AppName := AppName;
  self.ProtFile := ProtFile;
end;

function TRRReport.getRelationInfoA(): LongBool;
begin
  result := true;
end;


function TRRReport.chooseReportA(Rep: PChar; LibName: PChar): Integer;
var LSize, RSize, nRet: Integer;
    lRet: LongBool;
begin
  LSize := sizeOf(LibName);
  RSize := sizeOf(Rep);

  nRet := chooseReport(AppName, LibName, LSize, Rep, RSize);

  if nRet = 0 then
    // error occured
    lRet := self.getErrorInfoA()
  else
    // set report-handle
    HReport := nRet;

  result := nRet;
end;

function TRRReport.endReportA(): LongBool;
var lRet: LongBool;
begin
  lRet := endReport(HReport);

  if not lRet then
    // here no interest of function-result
    getErrorInfoA();

  result := lRet;
end;

function TRRReport.execRuntimeA(bWait: LongBool; FsCmdShow: Integer): LongBool;
var lRet: LongBool;
    pCode: PInteger; pPageCount: PLongInt; EMsg: PChar; Emsgsize: Integer;
begin
  pCode := 0;
  pPageCount := 0;
  Emsgsize := 128;
  EMsg := PChar(StringOfChar(' ', Emsgsize));

  lRet := execRuntime(HReport, bWait, FsCmdShow, pCode, pPageCount, EMsg, Emsgsize);

  if not lRet then
    // here no interest of function-result
    getErrorInfoA();

  result := lRet;
end;

function TRRReport.setOutputDestA(Dest: PChar): LongBool;
var lRet: LongBool;
begin
  lRet := setOutputDest(HReport, Dest);

  if not lRet then
    // here no interest of function-result
    getErrorInfoA();

  result := lRet;
end;

function TRRReport.setOutputFileA(Filename: PChar): LongBool;
var lRet: LongBool;
begin
  lRet := setOutputFile(HReport, Filename);

  if not lRet then
    // here no interest of function-result
    getErrorInfoA();

  result := lRet;
end;

function TRRReport.setPrinterA(Printer: PChar): LongBool;
var lRet: LongBool;
begin
  lRet := setPrinter(HReport, Printer);

  if not lRet then
    // here no interest of function-result
    getErrorInfoA();

  result := lRet;
end;

function TRRReport.setUserParamA(ParamName: PChar; Value: PChar): LongBool;
var lRet: LongBool;
begin
  lRet := setUserParam(HReport, ParamName, Value);

  if not lRet then
    // here no interest of function-result
    getErrorInfoA();

  result := lRet;
end;

function TRRReport.setWinTitleA(WinTitle: PChar): LongBool;
var lRet: LongBool;
begin
  lRet := setWinTitle(HReport, WinTitle);

  if not lRet then
    // here no interest of function-result
    getErrorInfoA();

  result := lRet;
end;

function TRRReport.getErrorInfoA(): LongBool;
var lRet: LongBool;
    Msg: PChar;
    Size: Integer;
    pCode: PInteger;

  function WriteLog(ProtFile, LogString: String): Integer;
  var f: TextFile;
  begin
    {$IOChecks OFF}
    AssignFile(f, ProtFile);
    if FileExists(ProtFile) then
      Append(f)
    else
      Rewrite(f);
    Writeln(f, LogString);
    CloseFile(f);
    result := GetLastError();
    {$IOCHECKS ON}
  end;

begin
  Size  := 128;
  Msg   := PChar(StringOfChar(' ', Size));
  pCode := 0;

  lRet := getErrorInfo(HReport, Msg, Size, pCode);

  if not lRet then
  begin
    // error occurred while error-analysis
    // override for protocol
    Msg := 'error occured in getErrorInfoA';
    pCode := 0;
  end;

  if ProtFile <> EmptyStr then
  begin
    // protocol with timestamp in windows-temp directory
    Msg := PChar(DateToStr(Now()) + ' ' + TimeToStr(Time()) + ': ' + Msg);
    WriteLog(ProtFile, Msg);
  end;

  result := lRet;
end;

  
end.
 