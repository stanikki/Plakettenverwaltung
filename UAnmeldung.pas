unit UAnmeldung;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, adsdata, adsfunc, adstable, StdCtrls, Buttons, ComCtrls, TData, UPlakettenverwaltung,
  ExtCtrls, TypInfo, StrUtils;

type
  TFrmAnmeldung = class(TForm)
    BBtnOK: TBitBtn;
    BBtnAbbrechen: TBitBtn;
    StBBottom: TStatusBar;
    GrBLogin: TGroupBox;
    EdtUser: TEdit;
    EdtPasswort: TEdit;
    LblBenutzername: TLabel;
    LblPasswort: TLabel;
    TmrHinweis: TTimer;
    GrBButtons: TGroupBox;
    procedure BBtnAbbrechenClick(Sender: TObject);
    procedure EdtUserEnter(Sender: TObject);
    procedure EdtUserExit(Sender: TObject);
    procedure EdtPasswortExit(Sender: TObject);
    procedure EdtPasswortEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BBtnOKClick(Sender: TObject);
    procedure TmrHinweisTimer(Sender: TObject);
    procedure StBBottomDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    PanelColor: TColor;
  public
    { Public-Deklarationen }
    AutoLogin: Boolean;
    CommandLine_User: String;
    CommandLine_PW: String;
    CommandLine_Mandant: String;
    CommandLine_Buchungskreis: String;
    CommandLine_Personalnummer: String;
    Counter: Integer;                                 // Zähler für Installationsläufe
//    UserPNR: String;

//    function GetUserLevel(name:String; pass: String; var UserPNR: String): TPVUserLevel;
  end;

var
  FrmAnmeldung: TFrmAnmeldung;
  mHandle, mHandle2: THandle;

implementation

{$R *.dfm}
{
function TFrmAnmeldung.GetUserLevel(name:String; pass: String; var UserPNR: String): TPVUserLevel;
var userLevel: TPVUserLevel;
  userName: String;
  rights: String;
  n, i: Integer;
  cRet: String;
begin

  userLevel := ulNone;

  if TblUsers.Locate('KURZNAME', name, [loCaseInsensitive]) then
  begin
    if (pass = TblUsers.FieldByName('PASSWORD').asString) then
    begin
      userName := TblUsers.FieldByName('NAME').asString;
      rights := TblUsers.FieldByName('USERRIGHTS').asString;
      UserPNR := TblUsers.FieldByName('SPNR').asString;

      // Personalnummer-String auf 8 Stellen mit Nullen auffüllen
      UserPNR := StringOfChar('0', 8 - Length(UserPNR)) + UserPNR;

      if copy(rights,1,1) = 'J' then
        userLevel := ulSupervisor
      else if copy(rights,2,1) = 'J' then
        userLevel := ulAdmin
      else
        userLevel := ulStandard;
    end;
  end;

  Result := userLevel;
end;
}
procedure TFrmAnmeldung.BBtnAbbrechenClick(Sender: TObject);
begin
  Application.Terminate;
  Exit;
end;

procedure TFrmAnmeldung.EdtUserEnter(Sender: TObject);
begin
  EdtUser.Color := clGradientActiveCaption;
end;

procedure TFrmAnmeldung.EdtUserExit(Sender: TObject);
begin
  EdtUser.Color := clWindow;
  if Length(StBBottom.Panels[0].Text)>0 then
  begin
    StBBottom.Panels[0].Text := '';
    StBBottom.Color := clBtnFace;
  end;
end;

procedure TFrmAnmeldung.EdtPasswortExit(Sender: TObject);
begin
  EdtPasswort.Color := clWindow;
  if Length(StBBottom.Panels[0].Text)>0 then
  begin
    StBBottom.Panels[0].Text := '';
    StBBottom.Color := clBtnFace;
  end;
end;

procedure TFrmAnmeldung.EdtPasswortEnter(Sender: TObject);
begin
  EdtPasswort.Color := clGradientActiveCaption;
end;

procedure TFrmAnmeldung.FormCreate(Sender: TObject);
var nPos: Integer;
  cBukField: String;
  userLevel: TPVUserLevel;
begin
  // Panel 1 soll selber gezeichnet werden
  StBBottom.Panels[1].Style := psOwnerDraw;
  PanelColor := StBBottom.Color; // clBtnFace;

//  TblUsers.AdsConnection := DaMConnections.AdsConnectionSHARED;
//  TblUsers.Open;
//  if TblUsers.Active and TblUsers.AdsIsTableEncrypted then
//    TblUsers.AdsEnableEncryption(DEF_TBL_KEY);

  // LogIn über Kommandozeile prüfen
  AutoLogin := false;

  CommandLine_User := '';
  CommandLine_PW := '';

  if ParamCount >= 4 then
  begin
    Counter := ParamCount;
    while Counter > 0 do
    begin
{
      if (UpperCase(ParamStr(Counter)) = '-U') then
        CommandLine_User := ParamStr(Counter+1);
      if (UpperCase(ParamStr(Counter)) = '-P') then
        CommandLine_PW := ParamStr(Counter+1);
}
      if (UpperCase(ParamStr(Counter)) = '-M') then
        CommandLine_Mandant := ParamStr(Counter+1);
      if (UpperCase(ParamStr(Counter)) = '-B') then
        CommandLine_Buchungskreis := ParamStr(Counter+1);
      if (UpperCase(ParamStr(Counter)) = '-N') then
        CommandLine_Personalnummer := ParamStr(Counter+1);

      Dec(Counter);
    end;
  end;

  AutoLogin := true;

{
  if (Length(CommandLine_User) > 0) and (Length(CommandLine_PW) > 0) then
  begin
    userLevel := GetUserLevel(CommandLine_User, CommandLine_PW, UserPNR);
    if not (userLevel = ulNone) then
      // LogIn über Kommandozeile erfolgreich
      AutoLogin := true;
  end;
}
end;

procedure TFrmAnmeldung.FormDestroy(Sender: TObject);
begin
//  TblUsers.Close;
end;

procedure TFrmAnmeldung.BBtnOKClick(Sender: TObject);
var
  userLevel: TPVUserLevel;
  error: boolean;
  UserPNR: String;
begin
  error := False;
  if Length(EdtUser.Text)=0 then
  begin
    EdtUser.SetFocus;
    StBBottom.Panels[0].Text := 'Benutzer angeben!';
    StBBottom.Color := clRed;
    error := True;
  end
  else
  if Length(EdtPasswort.Text)=0 then
  begin
    EdtPasswort.SetFocus;
    StBBottom.Panels[0].Text := 'Passwort angeben!';
    StBBottom.Color := clRed;
    error := True;
  end;

  if not error then
  begin

//    userLevel := GetUserLevel(EdtUser.Text, EdtPasswort.Text, UserPNR);
    userLevel := ulStandard;

    if (userLevel = ulStandard) or (userLevel = ulAdmin) or (userLevel = ulSupervisor) then
    begin
      FrmPlakettenverwaltung.User := EdtUser.Text;
      FrmPlakettenverwaltung.UserPNR := UserPNR;

      // kiek 12.02.15, lfd.Nr./Beschreibung 905/A8
      // Abstrakter Fehler in System.GetdynaMethod wenn erst Free auf Anmeldedialog
      // und danach MainDialog gezeigt wird
      Application.ShowMainForm := False;
      FrmPlakettenverwaltung.Visible := True;
      FrmAnmeldung.Free;
    end
    else
    begin
      EdtUser.SetFocus;
      StBBottom.Color := clRed;
      StBBottom.Panels[0].Text := 'Falsche Eingabe!';
      error := True;
    end;
  end;
end;

procedure TFrmAnmeldung.TmrHinweisTimer(Sender: TObject);
begin
  if PanelColor = clBtnFace then
    PanelColor := clYellow
  else
    PanelColor := clBtnFace;
  StBBottom.Repaint;
end;

procedure TFrmAnmeldung.StBBottomDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel = StatusBar.Panels[1] then                   // zweites Panel
  begin
    with StatusBar.Canvas do
    begin
      Brush.Color := PanelColor;          // Farbe aus dem Array
      FillRect(Rect);                                   // Mit der Farbe füllen
      TextOut(Rect.Left + 2, Rect.Top + 2, Panel.Text); // Textausgeben
    end;
  end;
end;

procedure TFrmAnmeldung.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

initialization

  // Verhindern, dass das Programm mehrmals gestartet wird
  mHandle := CreateMutex(nil, True, 'Plakettenverwaltung.exe');
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin

//    mHandle2 := FindWindowA(NIL, 'Plakettenverwaltung');

//    SetWindowPos(mHandle2, HWND_TOPMOST, 0, 0, 100, 100, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);

//    windows.SetForeGroundWindow(mHandle2);

//    SetForegroundWindow(mHandle2);

//    Application.BringToFront; // todo: funktioniert nocht nicht!

    Halt;
  end;

finalization

  if mHandle <> 0 then
    if CloseHandle(mHandle) then
      //Programmende bei doppelter Ausführung

end.
