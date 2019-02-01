object FrmPlakettenbestaende: TFrmPlakettenbestaende
  Left = 292
  Top = 280
  HelpContext = 4
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Plakettenbest'#228'nde'
  ClientHeight = 689
  ClientWidth = 980
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblRequest: TLabel
    Left = 996
    Top = 16
    Width = 74
    Height = 13
    Caption = 'letzter Request:'
  end
  object lblResponse: TLabel
    Left = 992
    Top = 364
    Width = 82
    Height = 13
    Caption = 'letzter Response:'
  end
  object GrBTatsaechlicherB: TGroupBox
    Left = 356
    Top = 12
    Width = 605
    Height = 197
    Caption = 'Tats'#228'chlicher Bestand'
    TabOrder = 1
    object BtnBSTErfassen: TButton
      Left = 24
      Top = 156
      Width = 97
      Height = 29
      Caption = 'Erfassen'
      TabOrder = 1
      OnClick = BtnBSTErfassenClick
    end
    object BtnBSTBearbeiten: TButton
      Left = 136
      Top = 156
      Width = 97
      Height = 29
      Caption = 'Bearbeiten'
      TabOrder = 2
      OnClick = BtnBSTBearbeitenClick
    end
    object BtnBSTLoeschen: TButton
      Left = 248
      Top = 156
      Width = 97
      Height = 29
      Caption = 'L'#246'schen'
      TabOrder = 3
      OnClick = BtnBSTLoeschenClick
    end
    object wwDBGridPlakettenbestaende_TSBST: TwwDBGrid
      Left = 24
      Top = 16
      Width = 557
      Height = 133
      Selected.Strings = (
        'Buchungsdatum'#9'8'#9'Buchungsdatum'
        'Plakettenjahr'#9'4'#9'Plakettenjahr'
        'Plakettentyp'#9'3'#9'Plakettentyp'
        'Plakettenbeleg-Nr'#9'10'#9'Plakettenbeleg-Nr'
        'Plakettenbestand'#9'11'#9'Plakettenbestand'
        'Update-Kennzeichen'#9'1'#9'Update-Kennzeichen')
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSrcPlakettenverwaltung_TSBST
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = True
      OnTitleButtonClick = wwDBGridPlakettenbestaende_TSBSTTitleButtonClick
      OnDblClick = BtnBSTBearbeitenClick
      OnKeyPress = wwDBGridPlakettenbestaende_TSBSTKeyPress
      FooterCellColor = clRed
      FooterHeight = 10
    end
  end
  object GrBPlakettenabg: TGroupBox
    Left = 16
    Top = 408
    Width = 945
    Height = 193
    Caption = 'Plakettenabg'#228'nge'
    TabOrder = 3
    object wwDBGridPlakettenbestaende_APLAK: TwwDBGrid
      Left = 24
      Top = 16
      Width = 897
      Height = 133
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSrcPlakettenverwaltung_APLAK
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      OnDblClick = BtnPLAKBearbeitenClick
      OnKeyPress = wwDBGridPlakettenbestaende_APLAKKeyPress
    end
    object BtnPLAKErfassen: TButton
      Left = 24
      Top = 156
      Width = 97
      Height = 29
      Caption = 'Erfassen'
      TabOrder = 1
      OnClick = BtnPLAKErfassenClick
    end
    object BtnPLAKBearbeiten: TButton
      Left = 136
      Top = 156
      Width = 97
      Height = 29
      Caption = 'Bearbeiten'
      TabOrder = 2
      OnClick = BtnPLAKBearbeitenClick
    end
    object BtnPLAKLoeschen: TButton
      Left = 248
      Top = 156
      Width = 97
      Height = 29
      Caption = 'L'#246'schen'
      TabOrder = 3
      OnClick = BtnPLAKLoeschenClick
    end
  end
  object GrBVerbucht: TGroupBox
    Left = 16
    Top = 12
    Width = 329
    Height = 197
    Caption = 'Aktuell in SAP verbuchter Bestand'
    TabOrder = 0
    object wwDBGridPlakettenbestaende_VBBST: TwwDBGrid
      Left = 24
      Top = 16
      Width = 281
      Height = 169
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSrcPlakettenverwaltung_VBBST
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
    end
  end
  object GrBErhaltene: TGroupBox
    Left = 16
    Top = 212
    Width = 945
    Height = 193
    Caption = 'Erhaltene und noch nicht best'#228'tigte Plaketten'
    TabOrder = 2
    object BtnErhaltBest: TButton
      Left = 24
      Top = 156
      Width = 97
      Height = 29
      Caption = 'Erhalt best'#228'tigen'
      TabOrder = 1
      OnClick = BtnErhaltBestClick
    end
    object wwDBGridPlakettenbestaende_EPLAK: TwwDBGrid
      Left = 24
      Top = 16
      Width = 897
      Height = 133
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = DSrcPlakettenverwaltung_EPLAK
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      OnDblClick = BtnErhaltBestClick
      OnKeyPress = wwDBGridPlakettenbestaende_EPLAKKeyPress
    end
  end
  object GrBButtons: TGroupBox
    Left = 16
    Top = 604
    Width = 945
    Height = 57
    TabOrder = 4
    object BBtnSchliessen: TBitBtn
      Left = 832
      Top = 16
      Width = 97
      Height = 29
      Caption = '&Schlie'#223'en'
      ModalResult = 2
      TabOrder = 5
      OnClick = BBtnSchliessenClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      NumGlyphs = 2
    end
    object BBtnAktualisieren: TBitBtn
      Left = 436
      Top = 16
      Width = 97
      Height = 29
      Caption = '&Aktualisieren'
      TabOrder = 3
      OnClick = BBtnAktualisierenClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00344446333334
        44433333FFFF333333FFFF33000033AAA43333332A4333338833F33333883F33
        00003332A46333332A4333333383F33333383F3300003332A2433336A6633333
        33833F333383F33300003333AA463362A433333333383F333833F33300003333
        6AA4462A46333333333833FF833F33330000333332AA22246333333333338333
        33F3333300003333336AAA22646333333333383333F8FF33000033444466AA43
        6A43333338FFF8833F383F330000336AA246A2436A43333338833F833F383F33
        000033336A24AA442A433333333833F33FF83F330000333333A2AA2AA4333333
        333383333333F3330000333333322AAA4333333333333833333F333300003333
        333322A4333333333333338333F333330000333333344A433333333333333338
        3F333333000033333336A24333333333333333833F333333000033333336AA43
        33333333333333833F3333330000333333336663333333333333333888333333
        0000}
      NumGlyphs = 2
    end
    object BBtnAbbrechen: TBitBtn
      Left = 548
      Top = 16
      Width = 97
      Height = 29
      Caption = 'A&bbrechen'
      Enabled = False
      TabOrder = 4
      OnClick = BBtnAbbrechenClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object BBtnUebernehmen: TBitBtn
      Left = 136
      Top = 16
      Width = 97
      Height = 29
      Caption = '&Buchen'
      TabOrder = 2
      OnClick = BBtnUebernehmenClick
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      NumGlyphs = 2
    end
    object RaBEingabenbuchen: TRadioButton
      Left = 16
      Top = 36
      Width = 105
      Height = 17
      Caption = 'Eingaben &buchen'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RaBEingabenbuchenClick
    end
    object RaBEingabenpruefen: TRadioButton
      Left = 16
      Top = 12
      Width = 105
      Height = 17
      Caption = 'Eingaben &pr'#252'fen'
      TabOrder = 0
      OnClick = RaBEingabenpruefenClick
    end
    object BBtnAbbrechen2: TBitBtn
      Left = 248
      Top = 16
      Width = 97
      Height = 29
      Caption = 'Abb&rechen'
      Enabled = False
      TabOrder = 6
      OnClick = BBtnAbbrechen2Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object StBBottom: TStatusBar
    Left = 0
    Top = 670
    Width = 980
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 400
      end
      item
        Width = 50
      end>
    OnDrawPanel = StBBottomDrawPanel
  end
  object MeRequest: TMemo
    Left = 992
    Top = 32
    Width = 149
    Height = 325
    TabStop = False
    Enabled = False
    TabOrder = 5
    Visible = False
  end
  object MeResponse: TMemo
    Left = 992
    Top = 380
    Width = 149
    Height = 281
    TabStop = False
    Enabled = False
    Lines.Strings = (
      '')
    TabOrder = 6
    Visible = False
  end
  object DSrcPlakettenverwaltung_VBBST: TwwDataSource
    DataSet = SAP_SVDATA_VBBST
    Left = 104
    Top = 100
  end
  object SAP_SVDATA_VBBST: TAdsTable
    StoreActive = True
    AdsConnection = DaMConnections.AdsConnectionPlakettenverwaltung
    FieldDefs = <
      item
        Name = 'Plakettenjahr'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Plakettentyp'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Plakettenbestand'
        DataType = ftString
        Size = 11
      end>
    StoreDefs = True
    Exclusive = True
    TableName = 'SAP_SVDATA_VBBST.adt'
    Left = 104
    Top = 72
    object SAP_SVDATA_VBBSTPlakettenjahr: TAdsStringField
      FieldName = 'Plakettenjahr'
      Size = 4
    end
    object SAP_SVDATA_VBBSTPlakettentyp: TAdsStringField
      FieldName = 'Plakettentyp'
      Size = 3
    end
    object SAP_SVDATA_VBBSTPlakettenbestand: TAdsStringField
      FieldName = 'Plakettenbestand'
      Size = 11
    end
  end
  object DSrcPlakettenverwaltung_EPLAK: TwwDataSource
    DataSet = SAP_SVDATA_EPLAK
    Left = 104
    Top = 300
  end
  object SAP_SVDATA_EPLAK: TAdsTable
    StoreActive = True
    AdsConnection = DaMConnections.AdsConnectionPlakettenverwaltung
    FieldDefs = <
      item
        Name = 'Plakettentyp'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Plakettenjahr'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Buchungsdatum'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Quell-Buchungskreis'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Quell-Depot'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Quell-PNr'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Plakettenbeleg-Nr'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Plakettenanzahl'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'Bezeichnung'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'Erhalten-Kennzeichen'
        DataType = ftString
        Size = 1
      end>
    StoreDefs = True
    Exclusive = True
    TableName = 'SAP_SVDATA_EPLAK.adt'
    Left = 104
    Top = 272
    object SAP_SVDATA_EPLAKPlakettentyp: TAdsStringField
      FieldName = 'Plakettentyp'
      Size = 3
    end
    object SAP_SVDATA_EPLAKPlakettenjahr: TAdsStringField
      FieldName = 'Plakettenjahr'
      Size = 4
    end
    object SAP_SVDATA_EPLAKBuchungsdatum: TAdsStringField
      FieldName = 'Buchungsdatum'
      Size = 8
    end
    object SAP_SVDATA_EPLAKQuellBuchungskreis: TAdsStringField
      FieldName = 'Quell-Buchungskreis'
      Size = 4
    end
    object SAP_SVDATA_EPLAKQuellDepot: TAdsStringField
      FieldName = 'Quell-Depot'
      Size = 2
    end
    object SAP_SVDATA_EPLAKQuellPNr: TAdsStringField
      FieldName = 'Quell-PNr'
      Size = 8
    end
    object SAP_SVDATA_EPLAKPlakettenbelegNr: TAdsStringField
      FieldName = 'Plakettenbeleg-Nr'
      Size = 10
    end
    object SAP_SVDATA_EPLAKPlakettenanzahl: TAdsStringField
      FieldName = 'Plakettenanzahl'
      Size = 9
    end
    object SAP_SVDATA_EPLAKBezeichnung: TAdsStringField
      FieldName = 'Bezeichnung'
      Size = 40
    end
    object SAP_SVDATA_EPLAKErhaltenKennzeichen: TAdsStringField
      FieldName = 'Erhalten-Kennzeichen'
      Size = 1
    end
  end
  object DSrcPlakettenverwaltung_APLAK: TwwDataSource
    DataSet = SAP_SVDATA_APLAK
    Left = 104
    Top = 496
  end
  object SAP_SVDATA_APLAK: TAdsTable
    StoreActive = True
    AdsConnection = DaMConnections.AdsConnectionPlakettenverwaltung
    FieldDefs = <
      item
        Name = 'Plakettentyp'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Plakettenjahr'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Buchungsdatum'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Ziel-Buchungskreis'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Ziel-Depot'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Ziel-PNr'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Plakettenbeleg-Nr'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Plakettenanzahl'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'Bezeichnung'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'Update-Kennzeichen'
        DataType = ftString
        Size = 1
      end>
    StoreDefs = True
    Exclusive = True
    TableName = 'SAP_SVDATA_APLAK.adt'
    Left = 104
    Top = 468
    object SAP_SVDATA_APLAKPlakettentyp: TAdsStringField
      FieldName = 'Plakettentyp'
      Size = 3
    end
    object SAP_SVDATA_APLAKPlakettenjahr: TAdsStringField
      FieldName = 'Plakettenjahr'
      Size = 4
    end
    object SAP_SVDATA_APLAKBuchungsdatum: TAdsStringField
      FieldName = 'Buchungsdatum'
      Size = 8
    end
    object SAP_SVDATA_APLAKZielBuchungskreis: TAdsStringField
      FieldName = 'Ziel-Buchungskreis'
      Size = 4
    end
    object SAP_SVDATA_APLAKZielDepot: TAdsStringField
      FieldName = 'Ziel-Depot'
      Size = 2
    end
    object SAP_SVDATA_APLAKZielPNr: TAdsStringField
      FieldName = 'Ziel-PNr'
      Size = 8
    end
    object SAP_SVDATA_APLAKPlakettenbelegNr: TAdsStringField
      FieldName = 'Plakettenbeleg-Nr'
      Size = 10
    end
    object SAP_SVDATA_APLAKPlakettenanzahl: TAdsStringField
      FieldName = 'Plakettenanzahl'
      Size = 9
    end
    object SAP_SVDATA_APLAKBezeichnung: TAdsStringField
      FieldName = 'Bezeichnung'
      Size = 40
    end
    object SAP_SVDATA_APLAKUpdateKennzeichen: TAdsStringField
      FieldName = 'Update-Kennzeichen'
      Size = 1
    end
  end
  object DSrcPlakettenverwaltung_TSBST: TwwDataSource
    DataSet = SAP_SVDATA_TSBST
    Left = 448
    Top = 100
  end
  object SAP_SVDATA_TSBST: TAdsTable
    IndexDefs = <
      item
        Name = 'DATUM'
        Fields = 'BUCHUNGSDATUM'
      end
      item
        Name = 'JAHR'
        Fields = 'PLAKETTENJAHR'
      end
      item
        Name = 'TYP'
        Fields = 'PLAKETTENTYP'
      end
      item
        Name = 'BELEGNR'
        Fields = 'PLAKETTENBELEG-NR'
      end
      item
        Name = 'BESTAND'
        Fields = 'PLAKETTENBESTAND'
      end
      item
        Name = 'KENNZ'
        Fields = 'UPDATE-KENNZEICHEN'
      end>
    StoreActive = True
    AdsConnection = DaMConnections.AdsConnectionPlakettenverwaltung
    AdsTableOptions.AdsIndexPageSize = 512
    FieldDefs = <
      item
        Name = 'Buchungsdatum'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Plakettenjahr'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Plakettentyp'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Plakettenbeleg-Nr'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Plakettenbestand'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'Update-Kennzeichen'
        DataType = ftString
        Size = 1
      end>
    StoreDefs = True
    Exclusive = True
    TableName = 'SAP_SVDATA_TSBST.adt'
    Left = 448
    Top = 72
    object SAP_SVDATA_TSBSTBuchungsdatum: TAdsStringField
      DisplayWidth = 8
      FieldName = 'Buchungsdatum'
      Size = 8
    end
    object SAP_SVDATA_TSBSTPlakettenjahr: TAdsStringField
      DisplayWidth = 4
      FieldName = 'Plakettenjahr'
      Size = 4
    end
    object SAP_SVDATA_TSBSTPlakettentyp: TAdsStringField
      DisplayWidth = 3
      FieldName = 'Plakettentyp'
      Size = 3
    end
    object SAP_SVDATA_TSBSTPlakettenbelegNr: TAdsStringField
      DisplayWidth = 10
      FieldName = 'Plakettenbeleg-Nr'
      Size = 10
    end
    object SAP_SVDATA_TSBSTPlakettenbestand: TAdsStringField
      Alignment = taRightJustify
      DisplayWidth = 11
      FieldName = 'Plakettenbestand'
      Size = 11
    end
    object SAP_SVDATA_TSBSTUpdateKennzeichen: TAdsStringField
      Alignment = taCenter
      DisplayWidth = 1
      FieldName = 'Update-Kennzeichen'
      Size = 1
    end
  end
  object HTTPRIO: THTTPRIO
    OnAfterExecute = HTTPRIOAfterExecute
    OnBeforeExecute = HTTPRIOBeforeExecute
    HTTPWebNode.Agent = 'Borland SOAP 1.2'
    HTTPWebNode.UseUTF8InHeader = False
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soDocument, soLiteralParams]
    Left = 684
    Top = 4
  end
  object TmrErgebnis: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TmrErgebnisTimer
    Left = 656
    Top = 4
  end
end
