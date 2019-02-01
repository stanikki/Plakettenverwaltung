unit UTatsaechlicherBestand;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ComCtrls, UAnzeigeSAP, TData, UPlakettenbestaende,
  Spin, DateUtils;

type
  TFrmTatsaechlicherBestand = class(TForm)
    GrBBestanderfassen: TGroupBox;
    lblPlakettentyp: TLabel;
    lblPlakettenjahr: TLabel;
    lblBuchungsdatum: TLabel;
    lblPlakettenbelegnummer: TLabel;
    lblUpdateKennzeichen: TLabel;
    DaTiPBuchungsdatum: TDateTimePicker;
    CoBPlakettentyp: TComboBox;
    MaEPlakettenbelegnummer: TMaskEdit;
    EdUpdateKennzeichen: TEdit;
    StBBottom: TStatusBar;
    lblPlakettenbestand: TLabel;
    SpEPlakettenbestand: TSpinEdit;
    GrBButtons: TGroupBox;
    BBtnSchliessen: TBitBtn;
    BBtnUebernehmen: TBitBtn;
    CoBPlakettenjahr: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure BBtnUebernehmenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    lastDate: TDate;
    function Validate(): Boolean;
  public
    { Public-Deklarationen }
    Modus: TPVFormModus;
  end;

var
  FrmTatsaechlicherBestand: TFrmTatsaechlicherBestand;

implementation

{$R *.dfm}

function TFrmTatsaechlicherBestand.Validate(): Boolean;
var lRet: boolean;
begin
  lRet := true;

  // kiek 25.01.12, lfd.Nr./Beschreibung 867/1
//  if SpEPlakettenbestand.Value = 0 then
  if SpEPlakettenbestand.Value < 0 then
  begin
    SetFocusedControl(SpEPlakettenbestand);
    MessageDlg('Eingabe "Plakettenbestand" ist ungültig!', mtInformation, [mbOk], 0);
    lRet := false;
  end;

  // kiek 24.08.12, lfd.Nr./Beschreibung 904/1
  if Trunc(DaTiPBuchungsdatum.Date) = StrToDate(PRG_DEF_DATE) then
  begin
    SetFocusedControl(DaTiPBuchungsdatum);
    MessageDlg('Eingabe "Buchungsdatum" ist ungültig!', mtInformation, [mbOk], 0);
    lRet := false;
  end;

  Result := lRet;
end;


procedure TFrmTatsaechlicherBestand.FormShow(Sender: TObject);
var s: String;
  I, Code: Integer;
  Year, Month, Day: Word;
begin

  // Controls-Initialisierung über Plakettenverwaltung.ini
  SpEPlakettenbestand.Increment := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENSTEPS, INI_PLAKETTENSTEPS_DEF);

  // erst leeren, damit sich die Einträge nicht verdoppeln
  CoBPlakettentyp.Items.Clear;
  CoBPlakettentyp.Hint := '';
  FrmWertePruef.SAP_INFOS_PLTYP.AdsGotoTop;
  while not FrmWertePruef.SAP_INFOS_PLTYP.Eof do
  begin
    I := CoBPlakettentyp.Items.Add(FrmWertePruef.SAP_INFOS_PLTYP.FieldByName('Plakettentyp').AsString);
    CoBPlakettentyp.Hint := CoBPlakettentyp.Hint + FrmWertePruef.SAP_INFOS_PLTYP.FieldByName('Plakettentyp').AsString + ' - ' + FrmWertePruef.SAP_INFOS_PLTYP.FieldByName('Bezeichnung').AsString + #13;
    FrmWertePruef.SAP_INFOS_PLTYP.AdsSkip(1);
  end;

  if (Modus = fmInsert) then
  begin
    Caption := FRM_CAPTION_BESTAND_INSERT;

    // kiek 27.06.12, lfd.Nr./Beschreibung
    // letzter Tag des Vormonats als Vorbelegung
//    DaTiPBuchungsdatum.Date := Now();
    // kiek 24.08.12, lfd.Nr./Beschreibung 904/1
//    DecodeDate(Now(), Year, Month, Day);
//    DaTiPBuchungsdatum.Date := EncodeDate(Year, Month-1, {DateUtils.}DaysInAMonth(Year, Month-1));
    DaTiPBuchungsdatum.Date := lastDate;

    CoBPlakettentyp.ItemIndex := 0;

    CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(FormatDateTime('yyyy', Now()));

    MaEPlakettenbelegnummer.Text := '';
    SpEPlakettenbestand.Value := 0;
    EdUpdateKennzeichen.Text := '';
  end
  else
  begin
    Caption := FRM_CAPTION_BESTAND_EDIT;

    s := FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Buchungsdatum').AsString;
    DaTiPBuchungsdatum.DateTime := EncodeDate(StrToIntDef(copy(s, 1, 4), 0), StrToIntDef(copy(s, 5, 2), 0), StrToIntDef(copy(s, 7, 2), 0));

    CoBPlakettentyp.ItemIndex := CoBPlakettentyp.Items.IndexOf(FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettentyp').AsString);
    CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettenjahr').AsString);

    MaEPlakettenbelegnummer.Text := FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettenbeleg-Nr').AsString;
    SpEPlakettenbestand.Value := FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettenbestand').AsInteger;
    EdUpdateKennzeichen.Text := FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString;
  end;

  CoBPlakettentyp.Enabled := true;
  CoBPlakettenjahr.Enabled := true;
  DaTiPBuchungsdatum.Enabled := true;
  lblPlakettenbelegnummer.Enabled := false;
  MaEPlakettenbelegnummer.Enabled := false;
  SpEPlakettenbestand.Enabled := true;
  lblUpdateKennzeichen.Enabled := false;
  EdUpdateKennzeichen.Enabled := false;

end;

procedure TFrmTatsaechlicherBestand.BBtnUebernehmenClick(Sender: TObject);
var cTmp: String;
begin
  if Validate() then
  begin
    if (Modus = fmInsert) then
    begin
      FrmPlakettenbestaende.SAP_SVDATA_TSBST.Insert;
      FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString := 'I';

      // kiek 24.08.12, lfd.Nr./Beschreibung 904/1
      lastDate := DaTiPBuchungsdatum.Date;
    end
    else
    begin
      FrmPlakettenbestaende.SAP_SVDATA_TSBST.Edit;
      // Insert-Kennung darf nicht überschrieben werden
      if FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString = '' then
        FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Update-Kennzeichen').AsString := 'U';
    end;
    FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Buchungsdatum').AsString        := FormatDateTime('yyyymmdd', DaTiPBuchungsdatum.DateTime);
    FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettenjahr').AsString        := CoBPlakettenjahr.Text;
    FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettentyp').AsString         := CoBPlakettentyp.Text;
    FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettenbeleg-Nr').AsString    := MaEPlakettenbelegnummer.Text;

    // kiek 24.08.12, lfd.Nr./Beschreibung 904/2
    // für die automatisch Sortierung notwendig, da der SAP-String folgenden Aufbau hat
    // insgesamt 11 Stellen, davon 10 Stellen numerisch und als letzte Stelle ein Zeichen (+ oder -, wird aber nicht mehr verwendet)
//    FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettenbestand').AsInteger    := SpEPlakettenbestand.Value;
    cTmp := IntToStr(SpEPlakettenbestand.Value);
    cTmp := StringOfChar(' ', FrmPlakettenbestaende.SAP_SVDATA_TSBST.AdsGetFieldLength('Plakettenbestand') - 1 - Length(cTmp)) + cTmp + ' ';
    FrmPlakettenbestaende.SAP_SVDATA_TSBST.FieldByName('Plakettenbestand').AsString     := cTmp;
    
    FrmPlakettenbestaende.SAP_SVDATA_TSBST.Post;
  end
  else
    // Fenster darf nicht verlassen werden
    ModalResult := mrNone;

end;

procedure TFrmTatsaechlicherBestand.FormCreate(Sender: TObject);
var I, nI, nDateFrom, nDateTo, nDateToday: Integer;
begin
  // Controls-Initialisierung über Plakettenverwaltung.ini
//  SpEPlakettenbestand.Increment := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENSTEPS, INI_PLAKETTENSTEPS_DEF);

  nDateToday := StrToInt(FormatDateTime('yyyy', Now()));
  nDateFrom := nDateToday - DaMConnections.Plakini.ReadInteger(INI_SEC_SAPDATA, INI_KEY_YEARSINPAST, INI_YEARSINPAST_DEF);
  nDateTo := nDateToday + DaMConnections.Plakini.ReadInteger(INI_SEC_SAPDATA, INI_KEY_YEARSINFUTURE, INI_YEARSINFUTURE_DEF);
  
  for nI := nDateFrom to nDateTo do
  begin
    I := CoBPlakettenjahr.Items.Add(IntToStr(nI));
  end;
  CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(IntToStr(nDateToday));

  // kiek 24.08.12, lfd.Nr./Beschreibung 904/1
  lastDate := StrToDate(PRG_DEF_DATE);
end;

procedure TFrmTatsaechlicherBestand.FormKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := BBtnSchliessen.ModalResult;
end;

end.
