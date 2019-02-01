unit UPlakettenabgaenge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Mask, UAnzeigeSAP, TData, UPlakettenbestaende, UPlakettenverwaltung,
  Spin;

type
  TFrmPlakettenabgaenge = class(TForm)
    lblPlakettentyp: TLabel;
    lblPlakettenjahr: TLabel;
    lblBuchungsdatum: TLabel;
    lblBuchungskreis: TLabel;
    lblDepot: TLabel;
    lblPersonalnummer: TLabel;
    lblPlakettenbelegnummer: TLabel;
    lblPlakettenanzahl: TLabel;
    lblBezechnung: TLabel;
    lblUpdateKennzeichen: TLabel;
    CoBPlakettentyp: TComboBox;
    MaEBuchungskreis: TMaskEdit;
    MaEPersonalnummer: TMaskEdit;
    MaEPlakettenbelegnummer: TMaskEdit;
    EdBezeichnung: TEdit;
    DaTiPBuchungsdatum: TDateTimePicker;
    StBBottom: TStatusBar;
    GrBAbgangerfassen: TGroupBox;
    GrBButtons: TGroupBox;
    BBtnSchliessen: TBitBtn;
    BBtnUebernehmen: TBitBtn;
    CoBDepot: TComboBox;
    EdUpdateKennzeichen: TEdit;
    RaBDepot: TRadioButton;
    RaBPerson: TRadioButton;
    lblAbgang: TLabel;
    SpEPlakettenanzahl: TSpinEdit;
    CoBPlakettenjahr: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure RaBDepotClick(Sender: TObject);
    procedure RaBPersonClick(Sender: TObject);
    procedure BBtnUebernehmenClick(Sender: TObject);
    procedure CoBDepotChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
    function Validate(): Boolean;
  public
    { Public-Deklarationen }
    Modus: TPVFormModus;
  end;

var
  FrmPlakettenabgaenge: TFrmPlakettenabgaenge;

implementation

{$R *.dfm}

function TFrmPlakettenabgaenge.Validate(): Boolean;
var lRet: boolean;
begin
  lRet := true;

  if SpEPlakettenanzahl.Value = 0 then
  begin
    SetFocusedControl(SpEPlakettenanzahl);
    MessageDlg('Eingabe "Plakettenanzahl" ist ungültig!', mtInformation, [mbOk], 0);
    lRet := false;
  end;
  if MaEPersonalnummer.Enabled then
  begin
    if Length(Trim(MaEPersonalnummer.Text)) < 8 then
    begin
      SetFocusedControl(MaEPersonalnummer);
      MessageDlg('Eingabe "Personalnummer" ist ungültig!' + #13 + #13 + 'Hinweis:' + #13 + '8-stellige Personalnummer mit führenden Nullen angeben', mtInformation, [mbOk], 0);
      lRet := false;
    end;
  end;
  if CoBDepot.Enabled then
  begin
    if CoBDepot.ItemIndex = 0 then
    begin
      SetFocusedControl(CoBDepot);
      MessageDlg('Bitte ein Depot auswählen!', mtInformation, [mbOk], 0);
      lRet := false;
    end;
  end;
  if MaEBuchungskreis.Enabled then
  begin
    if Length(Trim(MaEBuchungskreis.Text)) < 4 then
    begin
      SetFocusedControl(MaEBuchungskreis);
      MessageDlg('Eingabe "Buchungskreis" ist ungültig!', mtInformation, [mbOk], 0);
      lRet := false;
    end;
  end;

  Result := lRet;
end;

procedure TFrmPlakettenabgaenge.FormShow(Sender: TObject);
var s: String;
  I, Code: Integer;
begin

  // Controls-Initialisierung über Plakettenverwaltung.ini
  SpEPlakettenanzahl.Increment := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENSTEPS, INI_PLAKETTENSTEPS_DEF);

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

  // erst leeren, damit sich die Einträge nicht verdoppeln
  CoBDepot.Items.Clear;
  CoBDepot.Hint := '';
  FrmWertePruef.SAP_INFOS_DEPOT.AdsGotoTop;
  I := CoBDepot.Items.Add('');
  CoBDepot.Hint := '' + #13;
  while not FrmWertePruef.SAP_INFOS_DEPOT.Eof do
  begin
    I := CoBDepot.Items.Add(FrmWertePruef.SAP_INFOS_DEPOT.FieldByName('Depot-ID').AsString);
    CoBDepot.Hint := CoBDepot.Hint + FrmWertePruef.SAP_INFOS_DEPOT.FieldByName('Depot-ID').AsString + ' - ' + FrmWertePruef.SAP_INFOS_DEPOT.FieldByName('Bezeichnung').AsString + #13;
    FrmWertePruef.SAP_INFOS_DEPOT.AdsSkip(1);
  end;

  if (Modus = fmInsert) then
  begin
    Caption := FRM_CAPTION_ABGAENGE_INSERT;
    
    CoBDepot.Enabled := true;
    lblDepot.Enabled := true;
    MaEPersonalnummer.Enabled := false;
    lblPersonalnummer.Enabled := false;

    RaBDepot.Checked := true;
    RaBPerson.Checked := false;

    CoBPlakettentyp.ItemIndex := 0;

    CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(FormatDateTime('yyyy', Now()));

    // kiek 25.01.12, lfd.Nr./Beschreibung 866/1
//    CoBDepot.ItemIndex := 0;
    CoBDepot.ItemIndex := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_DEFAULTDEPOT, INI_DEFAULTDEPOT_DEF);
    // Event auslösen, Buchungskreis aus Depot-Datenbank auslesen
    CoBDepotChange(Sender);

    MaEPersonalnummer.Text := '';
    MaEPlakettenbelegnummer.Text := '';
    SpEPlakettenanzahl.Value := 0;
    EdBezeichnung.Text := '';
    EdUpdateKennzeichen.Text := '';

    DaTiPBuchungsdatum.Date := Now();
  end
  else // fmEdit
  begin
    Caption := FRM_CAPTION_ABGAENGE_EDIT;

    // Unterscheidung ob Depot- oder Person-Eintrag an Feld 'Ziel-Depot' ausgemacht
    if not (FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Ziel-Depot').AsString = '') then
    begin
      CoBDepot.Enabled := true;
      lblDepot.Enabled := true;
      MaEPersonalnummer.Enabled := false;
      lblPersonalnummer.Enabled := false;

      RaBDepot.Checked := true;
      RaBPerson.Checked := false;

      CoBDepot.ItemIndex := CoBDepot.Items.IndexOf(Trim(FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Ziel-Depot').AsString));
      // Event auslösen, Buchungskreis aus Depot-Datenbank auslesen
      CoBDepotChange(Sender);
    end
    else
    begin
      CoBDepot.Enabled := false;
      lblDepot.Enabled := false;
      MaEPersonalnummer.Enabled := true;
      lblPersonalnummer.Enabled := true;

      RaBDepot.Checked := false;
      RaBPerson.Checked := true;

      CoBDepot.ItemIndex := 0;
      // Buchungskreis des Anwenders
      MaEBuchungskreis.Text := FrmPlakettenverwaltung.Buchungskreis;
    end;

    CoBPlakettentyp.ItemIndex := CoBPlakettentyp.Items.IndexOf(FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Plakettentyp').AsString);

    CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Plakettenjahr').AsString);
    MaEPersonalnummer.Text := FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Ziel-PNr').AsString;
    MaEPlakettenbelegnummer.Text := FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Plakettenbeleg-Nr').AsString;
    SpEPlakettenanzahl.Value := FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Plakettenanzahl').AsInteger;

    EdBezeichnung.Text := FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Bezeichnung').AsString;
    EdUpdateKennzeichen.Text := FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString;

    // Aufbau des String-Datum 'yyyymmdd'
    s := FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Buchungsdatum').AsString;
    DaTiPBuchungsdatum.DateTime := EncodeDate(StrToIntDef(copy(s, 1, 4), 0), StrToIntDef(copy(s, 5, 2), 0), StrToIntDef(copy(s, 7, 2), 0));

  end;

  RaBDepot.Enabled := true;
  RaBPerson.Enabled := true;
  CoBPlakettentyp.Enabled := true;
  CoBPlakettenjahr.Enabled := true;
  DaTiPBuchungsdatum.Enabled := true;
  lblBuchungskreis.Enabled := false;
  MaEBuchungskreis.Enabled := false;
  lblPlakettenbelegnummer.Enabled := false;
  MaEPlakettenbelegnummer.Enabled := false;
  SpEPlakettenanzahl.Enabled := true;
  lblBezechnung.Enabled := false;
  EdBezeichnung.Enabled := false;
  lblUpdateKennzeichen.Enabled := false;
  EdUpdateKennzeichen.Enabled := false;

end;

procedure TFrmPlakettenabgaenge.RaBDepotClick(Sender: TObject);
begin
  CoBDepot.Enabled := true;
  lblDepot.Enabled := true;
  MaEPersonalnummer.Enabled := false;
  lblPersonalnummer.Enabled := false;

  // Buchungskreis ist Buchungskreis aus Depot-Datenbank
  // Event auslösen, damit Buchungskreis aus Depot-Datenbank ausgelesen wird
  CoBDepotChange(Sender);
end;

procedure TFrmPlakettenabgaenge.RaBPersonClick(Sender: TObject);
begin
  CoBDepot.Enabled := false;
  lblDepot.Enabled := false;
  MaEPersonalnummer.Enabled := true;
  lblPersonalnummer.Enabled := true;

  // Buchungskreis ist Buchungskreis des Anwenders
  MaEBuchungskreis.Text := FrmPlakettenverwaltung.Buchungskreis;
end;

procedure TFrmPlakettenabgaenge.BBtnUebernehmenClick(Sender: TObject);
begin
  if Validate() then
  begin
    if (Modus = fmInsert) then
    begin
      FrmPlakettenbestaende.SAP_SVDATA_APLAK.Insert;
      FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString := 'I';
    end
    else
    begin
      FrmPlakettenbestaende.SAP_SVDATA_APLAK.Edit;
      // Insert-Kennung darf nicht überschrieben werden
      if FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString = '' then
        FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Update-Kennzeichen').AsString := 'U';
    end;

    if RaBDepot.Checked then
    begin
      FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Ziel-Depot').AsString           := CoBDepot.Text;
      FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Ziel-PNr').AsString             := '';
    end
    else
    begin
      FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Ziel-Depot').AsString           := '';
      FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Ziel-PNr').AsString             := MaEPersonalnummer.Text;
    end;
    FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Plakettentyp').AsString         := CoBPlakettentyp.Text;
    FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Plakettenjahr').AsString        := CoBPlakettenjahr.Text;
    FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Buchungsdatum').AsString        := FormatDateTime('yyyymmdd', DaTiPBuchungsdatum.DateTime);
    FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Ziel-Buchungskreis').AsString   := MaEBuchungskreis.Text;
    FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Plakettenbeleg-Nr').AsString    := MaEPlakettenbelegnummer.Text;
    FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Plakettenanzahl').AsInteger     := SpEPlakettenanzahl.Value;
    FrmPlakettenbestaende.SAP_SVDATA_APLAK.FieldByName('Bezeichnung').AsString          := EdBezeichnung.Text;
    FrmPlakettenbestaende.SAP_SVDATA_APLAK.Post;
  end
  else
    // Fenster darf nicht verlassen werden
    ModalResult := mrNone;
end;

procedure TFrmPlakettenabgaenge.CoBDepotChange(Sender: TObject);
var found: Boolean;
begin
  found := false;
  FrmWertePruef.SAP_INFOS_DEPOT.AdsGotoTop;
  while not FrmWertePruef.SAP_INFOS_DEPOT.Eof and not found do
  begin
    if FrmWertePruef.SAP_INFOS_DEPOT.FieldByName('Depot-ID').AsString = CoBDepot.Text then
    begin
      MaEBuchungskreis.Text := FrmWertePruef.SAP_INFOS_DEPOT.FieldByName('Buchungskreis').AsString;
      found := true;
    end;
    FrmWertePruef.SAP_INFOS_DEPOT.AdsSkip(1);
  end;
end;

procedure TFrmPlakettenabgaenge.FormCreate(Sender: TObject);
var I, nI, nDateFrom, nDateTo, nDateToday: Integer;
begin
  // Controls-Initialisierung über Plakettenverwaltung.ini
//  SpEPlakettenanzahl.Increment := DaMConnections.Plakini.ReadInteger(INI_SEC_CONTROLS, INI_KEY_PLAKETTENSTEPS, INI_PLAKETTENSTEPS_DEF);

  nDateToday := StrToInt(FormatDateTime('yyyy', Now()));
  nDateFrom := nDateToday - DaMConnections.Plakini.ReadInteger(INI_SEC_SAPDATA, INI_KEY_YEARSINPAST, INI_YEARSINPAST_DEF);
  nDateTo := nDateToday + DaMConnections.Plakini.ReadInteger(INI_SEC_SAPDATA, INI_KEY_YEARSINFUTURE, INI_YEARSINFUTURE_DEF);

  for nI := nDateFrom to nDateTo do
  begin
    I := CoBPlakettenjahr.Items.Add(IntToStr(nI));
  end;
  CoBPlakettenjahr.ItemIndex := CoBPlakettenjahr.Items.IndexOf(IntToStr(nDateToday));

end;

procedure TFrmPlakettenabgaenge.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    ModalResult := BBtnSchliessen.ModalResult;
end;

end.
