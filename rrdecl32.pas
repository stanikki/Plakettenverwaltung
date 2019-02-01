{Issues:
   We changed all Booleans to LongBools.  Do we need to do likewise for Integers?
   How do you say "pointer to LongBool"?  (PLongBool?)
   Adding stdcall to all prototypes makes this stuff work, but why?  (C header declares
      all functions as "WINAPI PASCAL".)
   
}

unit RRDecl32;

interface

uses WinTypes;

function choosePrinter(HReport:Integer; Printer:PChar; PrSize:Integer; Port:PChar; PoSize:Integer): LongBool; far; stdcall;
function chooseReport(AppName:PChar; LibName:PChar; LSize:Integer; Rep:PChar; RSize:Integer): Integer; far; stdcall;
function chooseTable(HReport:Integer; Table:PChar; TSize:Integer): LongBool; far; stdcall;
function endReport(HReport: Integer): LongBool; far; stdcall;
function endRuntimeInstance(): LongBool; far; stdcall;
function execRuntime(HReport:Integer; bWait:LongBool; FsCmdShow: Integer; pCode: PInteger; pPageCount: PLongInt; EMsg:PChar; Emsgsize: Integer): LongBool; far; stdcall;
function getAPIVersion(APIVersion: PLongInt): LongBool; far; stdcall;
function getBeginPage(HReport: Integer; pPage: PLongInt): LongBool; far; stdcall;
function getCopies(HReport: Integer; pCopies: PInteger): LongBool; far; stdcall;
function getDBContainer(HReport:Integer; pPath:PChar; Size:Integer): LongBool; far; stdcall;
function getDisplayErrors(HReport:Integer; pDispErr: PBool): LongBool; far; stdcall;
function getDisplayStatus(HReport:Integer; pDispStatus:PBool): LongBool; far; stdcall;
function getEndPage(HReport:Integer; pPage: PLongInt): LongBool; far; stdcall;
function getErrorInfo(HReport:Integer; Msg:PChar; Size:Integer; pCode:PInteger): LongBool; far; stdcall;
function getExportDest(HReport:Integer; Dest: PChar): LongBool; far; stdcall;
function getFilter(HReport:Integer; Filter:PChar; Size:Integer): LongBool; far; stdcall;
function getFilterUsage(HReport:Integer; Usage: PChar): LongBool; far; stdcall;
function getFirstFieldName(HReport:Integer; FieldName:PChar; Size:Integer): LongBool; far; stdcall;
function getFirstFilteredFieldName(HReport:Integer; FieldName:PChar; Size:Integer; Filter:Integer): LongBool; far; stdcall;
function getFirstGroupField(HReport:Integer; GroupFldName:PChar; Size:Integer): LongBool; far; stdcall;
function getFirstRelationInfo(HReport:Integer; FilePath:PChar; FSize:Integer; IndexPath:PChar; ISize:Integer; Tag:PChar; TSize:integer; Alias:PChar; ASize:integer): LongBool; far; stdcall;
function getFirstSortField(HReport:Integer; SortFieldName:PChar; Size:Integer): LongBool; far; stdcall;
function getFirstUserParam(HReport:Integer; ParmName:PChar; NSize:Integer; PValue:PChar; VSize:Integer): LongBool; far; stdcall;
function getHighScope(HReport:Integer; Scope:PChar; Size:Integer): LongBool; far; stdcall;
function getLibrary(HReport:Integer; LibName:PChar; Size:Integer): LongBool; far; stdcall;
function getLowScope(HReport:Integer; Scope:PChar; Size:Integer): LongBool; far; stdcall;
function getMasterIndexInfo(HReport:Integer; Path:PChar; Size:Integer; pType:PChar; Tag:PChar; TSize:Integer): LongBool; far; stdcall;
function getMasterTableName(HReport:Integer; Path:PChar; Size:Integer): LongBool; far; stdcall;
function getMemoName(HReport:Integer; MemoNamePath:PChar; Size:Integer): LongBool; far; stdcall;
function getNewReportHandle(AppName:PChar): Integer; far; stdcall;
function getNextFieldName(HReport:Integer; FieldName:PChar; Size:Integer): LongBool; far; stdcall;
function getNextFilteredFieldName(HReport:Integer; FieldName:PChar; Size:Integer; Filter:Integer): LongBool; far; stdcall;
function getNextGroupField(HReport:Integer; GroupFieldName:PChar; Size:Integer): LongBool; far; stdcall;
function getNextRelationInfo(HReport:Integer; FilePath:PChar; FSize:Integer; IndexPath:PChar; ISize:Integer; Tag:PChar; TSize:integer; Alias:PChar; ASize:integer): LongBool; far; stdcall;
function getNextSortField(HReport:Integer; SortFieldName:PChar; Size:Integer): LongBool; far; stdcall;
function getNextUserParam(HReport:Integer; ParmName:PChar; NSize:Integer; Value:PChar; VSize:Integer): LongBool; far; stdcall;
function getOutputDest(HReport:Integer; Dest:PChar; Size:Integer): LongBool; far; stdcall;
function getOutputFile(HReport:Integer; OutFilePath:PChar; Size: Integer): LongBool; far; stdcall;
function getPreventEscape(HReport:Integer; pbNoEsc:PBool): LongBool; far; stdcall;
function getPrinter(HReport:Integer; Printer: PChar; Size: Integer): LongBool; far; stdcall;
function getPrinterPort(HReport:Integer; Port:PChar; Size:Integer): LongBool; far; stdcall;
function getReportPick(HReport:Integer; RepPick:PChar): LongBool; far; stdcall;
function getRuntimeRecord(AppName:PChar; Filename:PChar): Integer; far; stdcall;
function getScopeUsage(HReport:Integer; ScopeUse:PChar): LongBool; far; stdcall;
function getStatusEveryPage(HReport:Integer; pbEvery:PBool): LongBool; far; stdcall;
function getTestPattern(HReport:Integer; pbTest:PBool): LongBool; far; stdcall;
function getWinTitle(HReport:Integer; Title:PChar; Size:Integer): LongBool; far; stdcall;
function initRuntimeInstance(): LongBool; far; stdcall;
function resetErrorInfo(HReport:Integer): LongBool; far; stdcall;
function setBeginPage(HReport: Integer; Page: LongInt): LongBool; far; stdcall;
function setCopies(HReport: Integer; Copies: Integer): LongBool; far; stdcall;
function setDataDir(HReport:Integer; Directory:PChar): LongBool; far; stdcall;
function setDBContainer(HReport:Integer; Path:PChar): LongBool; far; stdcall;
function setDisplayErrors(HReport:Integer; bDispErr: LongBool): LongBool; far; stdcall;
function setDisplayStatus(HReport:Integer; bDispStatus: LongBool): LongBool; far; stdcall;
function setEndPage(HReport: Integer; Page: LongInt): LongBool; far; stdcall;
function setExportDest(HReport:Integer; ExpDest: char ): LongBool; far; stdcall;
function setFilter(HReport:Integer; Filter: PChar): LongBool; far; stdcall;
function setFilterUsage(HReport:Integer; Usage:Char): LongBool; far; stdcall;
function setGroupField(HReport:Integer; GroupFieldName:PChar; GroupFieldNum:Integer): LongBool; far; stdcall;
function setHighScope(HReport:Integer; Scope:PChar): LongBool; far; stdcall;
function setImageDir(HReport:Integer; Dir:PChar): LongBool; far; stdcall;
function setIndexExtension(HReport:Integer; ExtNumber:Integer): LongBool; far; stdcall;
function setLibrary(HReport:Integer; LibName:PChar): LongBool; far; stdcall;
function setLibraryDir(HReport:Integer; DirName:PChar): LongBool; far; stdcall;
function setLowScope(HReport:Integer; Scope:PChar): LongBool; far; stdcall;
function setMasterIndexInfo(HReport:Integer; Path:PChar; pType:Char; Tag:PChar): LongBool; far; stdcall;
function setMasterTableName(HReport:Integer; MastFileName:PChar): LongBool; far; stdcall;
function setMemoName(HReport:Integer; MemoPath:PChar): LongBool; far; stdcall;
function setOutputDest(HReport:Integer; Dest:PChar): LongBool; far; stdcall;
function setOutputFile(HReport:Integer; Filename:PChar): LongBool; far; stdcall;
function setPreventEscape(HReport:Integer; bNoEsc:LongBool): LongBool; far; stdcall;
function setPrinter(HReport:Integer; Printer:PChar): LongBool; far; stdcall;
function setPrinterPort(HReport:Integer; Port:PChar): LongBool; far; stdcall;
function setRelationInfo(HReport:Integer; Path:PChar; IndexPath:PChar; Tag:PChar; Alias:PChar; AliasNum:Integer): LongBool; far; stdcall;
function setReportPick(HReport:Integer; RepPick:Char): LongBool; far; stdcall;
function setScopeUsage(HReport:Integer; ScopeFlag:Char): LongBool; far; stdcall;
function setSortField(HReport:Integer; SortFieldName:PChar; SortNum:Integer): LongBool; far; stdcall;
function setStatusEveryPage(HReport:Integer; bValue:LongBool): LongBool; far; stdcall;
function setStatusFileName(HReport:Integer; Filename:PChar): LongBool; far; stdcall;
function setSuppressTitle(HReport:Integer; bValue:LongBool): LongBool; far; stdcall;
function setTestPattern(HReport:Integer; bValue:LongBool): LongBool; far; stdcall;
function setUserParam(HReport:Integer; ParamName:PChar; Value:PChar): LongBool; far; stdcall;
function setWinBorderStyle(HReport:Integer; Style:Integer): LongBool; far; stdcall;
function setWinControlBox(HReport:Integer; ControlBox:LongBool): LongBool; far; stdcall;
function setWinHeight(HReport:Integer; Height:Integer): LongBool; far; stdcall;
function setWinLeft(HReport:Integer; Left:Integer): LongBool; far; stdcall;
function setWinMaxButton(HReport:Integer; bAllow:LongBool): LongBool; far; stdcall;
function setWinMinButton(HReport:Integer; bAllow:LongBool): LongBool; far; stdcall;
function setWinParentHandle(HReport:Integer; Parent:Integer): LongBool; far; stdcall;
function setWinTitle(HReport:Integer; WinTitle:PChar): LongBool; far; stdcall;
function setWinTop(HReport:Integer; WinTop:Integer): LongBool; far; stdcall;
function setWinWidth(HReport:Integer; WinWidth:Integer): LongBool; far; stdcall;
function setWriteAllow(HReport:Integer; bAllow:LongBool): LongBool; far; stdcall;
function setXBaseEditor(HReport:Integer; bXBase:LongBool): LongBool; far; stdcall;
function tabChooseTable(table:PChar; tSize:Integer): Integer; far; stdcall;
function tabFreeHandle(hTable:Integer): LongBool; far; stdcall;
function tabGetErrorInfo(hReport:Integer; Msg:PChar; size:Integer; Code:PInteger): LongBool; far; stdcall;
//function tabGetFirstFieldInfo(hTable:Integer; FieldName:PChar; iSize;Integer; Type:PChar; Lgt:PInteger; DecPl:PInteger): LongBool; far; stdcall;
//function tabGetNextFieldInfo(hTable:Integer; FieldName:PChar; iSize;Integer; Type:PChar; Lgt:PInteger; DecPl:PInteger): LongBool; far; stdcall;
function tabResetErrorInfo(hReport:Integer): LongBool; far; stdcall;
function writeRuntimeRecord(HReport:Integer; RecordFile:PChar): LongBool; far; stdcall;

implementation

function ChoosePrinter; external 'RRRPT32.DLL' name 'choosePrinter';
function ChooseReport; external 'RRRPT32.DLL' name 'chooseReport';
function ChooseTable; external 'RRRPT32.DLL' name 'chooseTable';
function EndReport; external 'RRRPT32.DLL' name 'endReport';
function EndRuntimeInstance; external 'RRRPT32.DLL' name 'endRuntimeInstance';
function ExecRuntime; external 'RRRPT32.DLL' name 'execRuntime';
function GetAPIVersion; external 'RRRPT32.DLL' name 'getAPIVersion';
function GetBeginPage; external 'RRRPT32.DLL' name 'getBeginPage';
function GetCopies; external 'RRRPT32.DLL' name 'getCopies';
function GetDBContainer;external 'RRRPT32.DLL' name 'getDBContainer';
function GetDisplayErrors; external 'RRRPT32.DLL' name 'getDisplayErrors';
function GetDisplayStatus; external 'RRRPT32.DLL' name 'getDisplayStatus';
function GetEndPage; external 'RRRPT32.DLL' name  'getEndPage';
function GetErrorInfo; external 'RRRPT32.DLL' name 'getErrorInfo';
function GetExportDest; external 'RRRPT32.DLL' name 'getExportDest';
function GetFilter; external 'RRRPT32.DLL' name 'getFilter';
function GetFilterUsage; external 'RRRPT32.DLL' name 'getFilterUsage';
function GetFirstFieldName; external 'RRRPT32.DLL' name 'getFirstFieldName';
function GetFirstFilteredFieldName; external 'RRRPT32.DLL' name 'getFirstFilteredFieldName';
function GetFirstGroupField; external 'RRRPT32.DLL' name 'getFirstGroupField';
function GetFirstRelationInfo; external 'RRRPT32.DLL' name 'getFirstRelationInfo';
function GetFirstSortField; external 'RRRPT32.DLL' name 'getFirstSortField';
function GetFirstUserParam; external 'RRRPT32.DLL' name 'getFirstUserParam';
function GetHighScope; external 'RRRPT32.DLL' name 'getHighScope';
function GetLibrary; external 'RRRPT32.DLL' name 'getLibrary';
function GetLowScope; external 'RRRPT32.DLL' name 'getLowScope';
function GetMasterIndexInfo; external 'RRRPT32.DLL' name 'getMasterIndexInfo';
function GetMasterTableName; external 'RRRPT32.DLL' name 'getMasterTableName';
function GetMemoName; external 'RRRPT32.DLL' name 'getMemoName';
function GetNewReportHandle; external 'RRRPT32.DLL' name 'getNewReportHandle';
function GetNextFieldName; external 'RRRPT32.DLL' name 'getNextFieldName';
function GetNextFilteredFieldName; external 'RRRPT32.DLL' name 'getNextFilteredFieldName';
function GetNextGroupField; external 'RRRPT32.DLL' name 'getNextGroupField';
function GetNextRelationInfo; external 'RRRPT32.DLL' name 'getNextRelationInfo';
function GetNextSortField; external 'RRRPT32.DLL' name 'getNextSortField';
function GetNextUserParam; external 'RRRPT32.DLL' name 'getNextUserParam';
function GetOutputDest; external 'RRRPT32.DLL' name 'getOutputDest';
function GetOutputFile; external 'RRRPT32.DLL' name 'getOutputFile';
function GetPreventEscape; external 'RRRPT32.DLL' name 'getPreventEscape';
function GetPrinter; external 'RRRPT32.DLL' name 'getPrinter';
function GetPrinterPort; external 'RRRPT32.DLL'name 'getPrinterPort';
function GetReportPick; external 'RRRPT32.DLL' name 'getReportPick';
function GetRuntimeRecord; external 'RRRPT32.DLL' name 'getRunTimeRecord';
function GetScopeUsage; external 'RRRPT32.DLL' name  'getScopeUsage';
function GetStatusEveryPage; external 'RRRPT32.DLL' name 'getStatusEveryPage';
function GetTestPattern; external 'RRRPT32.DLL' name 'getTestPattern';
function GetWinTitle; external 'RRRPT32.DLL' name 'getWinTitle';
function InitRuntimeInstance; external 'RRRPT32.DLL' name 'initRuntimeInstance';
function ResetErrorInfo; external 'RRRPT32.DLL' name 'resetErrorInfo';
function SetBeginPage; external 'RRRPT32.DLL' name 'setBeginPage';
function SetCopies; external 'RRRPT32.DLL' name 'setCopies';
function SetDataDir; external 'RRRPT32.DLL' name 'setDataDir';
function SetDBContainer; external 'RRRPT32.DLL' name 'setDBContainer';
function SetDisplayErrors; external 'RRRPT32.DLL' name 'setDisplayErrors';
function SetDisplayStatus; external 'RRRPT32.DLL' name 'setDisplayStatus';
function SetEndPage; external 'RRRPT32.DLL' name 'setEndPage';
function SetExportDest; external 'RRRPT32.DLL' name 'setExportDest';
function SetFilter; external 'RRRPT32.DLL' name 'setFilter';
function SetFilterUsage; external 'RRRPT32.DLL' name 'setFilterUsage';
function SetGroupField; external 'RRRPT32.DLL' name 'setGroupField';
function SetHighScope; external 'RRRPT32.DLL' name 'setHighScope';
function SetImageDir; external 'RRRPT32.DLL' name 'setImageDir';
function SetIndexExtension; external 'RRRPT32.DLL' name 'setIndexExtension';
function SetLibrary; external 'RRRPT32.DLL' name 'setLibrary';
function SetLibraryDir; external 'RRRPT32.DLL' name 'setLibraryDir';
function SetLowScope; external 'RRRPT32.DLL' name 'setLowScope';
function SetMasterIndexInfo; external 'RRRPT32.DLL' name 'setMasterIndexInfo';
function SetMasterTableName; external 'RRRPT32.DLL' name 'setMasterTableName';
function SetMemoName; external 'RRRPT32.DLL' name 'setMemoName';
function SetOutputDest; external 'RRRPT32.DLL' name 'setOutputDest';
function SetOutputFile; external 'RRRPT32.DLL' name 'setOutputFile';
function SetPreventEscape; external 'RRRPT32.DLL' name  'setPreventEscape';
function SetPrinter; external 'RRRPT32.DLL' name 'setPrinter';
function SetPrinterPort; external 'RRRPT32.DLL' name 'setPrinterPort';
function SetRelationInfo; external 'RRRPT32.DLL'name 'setRelationInfo';
function SetReportPick; external 'RRRPT32.DLL' name 'setReportPick';
function SetScopeUsage; external 'RRRPT32.DLL' name 'setScopeUsage';
function SetSortField; external 'RRRPT32.DLL' name 'setSortField';
function SetStatusEveryPage; external 'RRRPT32.DLL' name 'setStatusEveryPage';
function SetStatusFileName; external 'RRRPT32.DLL' name 'setStatusFileName';
function SetSuppressTitle; external 'RRRPT32.DLL' name 'setSuppressTitle';
function SetTestPattern; external 'RRRPT32.DLL' name 'setTestPattern';
function SetUserParam; external 'RRRPT32.DLL' name 'setUserParam';
function SetWinBorderStyle; external 'RRRPT32.DLL' name 'setWinBorderStyle';
function SetWinControlBox; external 'RRRPT32.DLL' name 'setWinControlBox';
function SetWinHeight; external 'RRRPT32.DLL' name 'setWinHeight';
function SetWinLeft; external 'RRRPT32.DLL' name 'setWinLeft';
function SetWinMaxButton; external 'RRRPT32.DLL' name 'setWinMaxButton';
function SetWinMinButton; external 'RRRPT32.DLL' name 'setWinMinButton';
function SetWinParentHandle; external 'RRRPT32.DLL' name 'setWinParentHandle';
function SetWinTitle; external 'RRRPT32.DLL' name 'setWinTitle';
function SetWinTop; external 'RRRPT32.DLL' name 'setWinTop';
function SetWinWidth; external 'RRRPT32.DLL' name 'setWinWidth';
function SetWriteAllow; external 'RRRPT32.DLL' name 'setWriteAllow';
function SetXBaseEditor; external 'RRRPT32.DLL' name 'setXBaseEditor';
function TabChooseTable; external 'RRRPT32.DLL' name 'tabChooseTable';
function TabFreeHandle; external 'RRRPT32.DLL' name 'tabFreeHandle';
function TabGetErrorInfo; external 'RRRPT32.DLL' name 'tabGetErrorInfo';
//function TabGetFirstFieldInfo; external 'RRRPT32.DLL' name 'tabGetFirstFieldInfo';
//function TabGetNextFieldInfo; external 'RRRPT32.DLL' name 'tabGetNextFieldInfo';
function TabResetErrorInfo; external 'RRRPT32.DLL' name 'tabResetErrorInfo';
function WriteRuntimeRecord; external 'RRRPT32.DLL' name 'writeRuntimeRecord';

end.

