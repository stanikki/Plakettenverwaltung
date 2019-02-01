object FrmAuswertung: TFrmAuswertung
  Left = 293
  Top = 190
  HelpContext = 7
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Auswertung'
  ClientHeight = 696
  ClientWidth = 979
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
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  DesignSize = (
    979
    696)
  PixelsPerInch = 96
  TextHeight = 13
  object lblRequest: TLabel
    Left = 16
    Top = 684
    Width = 74
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'letzter Request:'
  end
  object lblResponse: TLabel
    Left = 460
    Top = 684
    Width = 82
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'letzter Response:'
  end
  object StBBottom: TStatusBar
    Left = 0
    Top = 677
    Width = 979
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
  object GrBButtons: TGroupBox
    Left = 16
    Top = 608
    Width = 945
    Height = 57
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
    DesignSize = (
      945
      57)
    object BBtnSchliessen: TBitBtn
      Left = 832
      Top = 16
      Width = 97
      Height = 29
      Anchors = [akTop, akRight]
      Caption = '&Schlie'#223'en'
      ModalResult = 2
      TabOrder = 3
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
      Left = 16
      Top = 16
      Width = 97
      Height = 29
      Caption = '&Aktualisieren'
      TabOrder = 0
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
      Left = 128
      Top = 16
      Width = 97
      Height = 29
      Caption = 'A&bbrechen'
      Enabled = False
      TabOrder = 1
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
    object BBtnDrucken: TBitBtn
      Left = 268
      Top = 16
      Width = 97
      Height = 29
      Caption = '&Drucken'
      Enabled = False
      TabOrder = 2
      OnClick = BBtnDruckenClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00800000000000
        00080888888888888880088888888888888000000000000000000F8F8F8F8F8F
        8F8008F8F8F8F8F8F9F00F8F8F8F8F8F8F8000000000000000008880FFFFFFFF
        08888880F0000F0F08888880FFFFFFFF08888880F00F000008888880FFFF0FF0
        88888880F08F0F0888888880FFFF008888888880000008888888}
    end
  end
  object GrBErgebnis: TGroupBox
    Left = 16
    Top = 232
    Width = 945
    Height = 361
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Ergebnis'
    TabOrder = 2
    DesignSize = (
      945
      361)
    object wwDBGridAuswertung_SVDATA: TwwDBGrid
      Left = 24
      Top = 28
      Width = 901
      Height = 309
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = DSrcAuswertungSAP_SVDATA
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
  object GrBDatenSelektieren1: TGroupBox
    Left = 16
    Top = 12
    Width = 493
    Height = 209
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Daten selektieren'
    TabOrder = 0
    OnEnter = GrBDatenSelektieren1Enter
    object lblPlakettentyp: TLabel
      Left = 24
      Top = 172
      Width = 62
      Height = 13
      Caption = 'Plakettentyp:'
    end
    object lblPlakettenjahr: TLabel
      Left = 24
      Top = 88
      Width = 65
      Height = 13
      Caption = 'Plakettenjahr:'
    end
    object lblBuchungskreis: TLabel
      Left = 24
      Top = 32
      Width = 73
      Height = 13
      Caption = 'Buchungskreis:'
    end
    object lblPersonalnummer: TLabel
      Left = 24
      Top = 60
      Width = 81
      Height = 13
      Caption = 'Personalnummer:'
    end
    object lblVon: TLabel
      Left = 136
      Top = 144
      Width = 18
      Height = 13
      Caption = 'von'
      Enabled = False
    end
    object lblBis: TLabel
      Left = 260
      Top = 144
      Width = 13
      Height = 13
      Caption = 'bis'
      Enabled = False
    end
    object DaTiPZeitraumVon: TDateTimePicker
      Left = 160
      Top = 140
      Width = 89
      Height = 21
      Date = 40548.478526701390000000
      Time = 40548.478526701390000000
      Enabled = False
      TabOrder = 6
    end
    object CoBPlakettentyp: TComboBox
      Left = 160
      Top = 168
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
    end
    object MaEBuchungskreis: TMaskEdit
      Left = 160
      Top = 28
      Width = 57
      Height = 21
      Enabled = False
      EditMask = '0000;1; '
      MaxLength = 4
      TabOrder = 0
      Text = '    '
    end
    object MaEPersonalnummer: TMaskEdit
      Left = 160
      Top = 56
      Width = 71
      Height = 21
      Enabled = False
      EditMask = '00000000;1;#'
      MaxLength = 8
      TabOrder = 1
      Text = '        '
    end
    object DaTiPZeitraumBis: TDateTimePicker
      Left = 280
      Top = 140
      Width = 89
      Height = 21
      Date = 40548.478526701390000000
      Time = 40548.478526701390000000
      Enabled = False
      TabOrder = 7
    end
    object CoBPlakettenjahr: TComboBox
      Left = 160
      Top = 84
      Width = 89
      Height = 21
      Style = csDropDownList
      DropDownCount = 14
      ItemHeight = 13
      TabOrder = 2
    end
    object DaTiPStichtag: TDateTimePicker
      Left = 160
      Top = 112
      Width = 89
      Height = 21
      Date = 40548.478526701390000000
      Time = 40548.478526701390000000
      TabOrder = 5
    end
    object RaBZeitraum: TRadioButton
      Left = 24
      Top = 140
      Width = 81
      Height = 17
      Caption = 'Zeitraum'
      TabOrder = 4
      OnClick = RaBZeitraumClick
    end
    object RaBStichtag: TRadioButton
      Left = 24
      Top = 112
      Width = 81
      Height = 17
      Caption = 'Stichtag'
      Checked = True
      TabOrder = 3
      TabStop = True
      OnClick = RaBStichtagClick
    end
  end
  object MeRequest: TMemo
    Left = 17
    Top = 700
    Width = 416
    Height = 113
    TabStop = False
    Anchors = [akLeft, akBottom]
    Enabled = False
    TabOrder = 5
  end
  object MeResponse: TMemo
    Left = 461
    Top = 700
    Width = 372
    Height = 113
    TabStop = False
    Anchors = [akLeft, akBottom]
    Enabled = False
    Lines.Strings = (
      '')
    TabOrder = 6
  end
  object GrBDatenSelektieren2: TGroupBox
    Left = 504
    Top = 12
    Width = 457
    Height = 209
    Anchors = [akTop, akRight]
    TabOrder = 1
    OnEnter = GrBDatenSelektieren2Enter
    object lblToleranz: TLabel
      Left = 290
      Top = 80
      Width = 104
      Height = 13
      Caption = 'Abweichungstoleranz:'
      Enabled = False
    end
    object lblBuchungsschluessel: TLabel
      Left = 103
      Top = 24
      Width = 94
      Height = 13
      Caption = 'Buchungsschl'#252'ssel:'
    end
    object ChBAlleBuchungenAnlisten: TCheckBox
      Left = 288
      Top = 168
      Width = 165
      Height = 17
      Caption = 'Alle Buchungen anlisten'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object ChBBestandsuebersicht: TCheckBox
      Left = 288
      Top = 140
      Width = 165
      Height = 17
      Caption = 'Bestands'#252'bersicht'
      TabOrder = 5
    end
    object SpEToleranz: TSpinEdit
      Left = 288
      Top = 100
      Width = 89
      Height = 22
      Enabled = False
      Increment = 10
      MaxLength = 8
      MaxValue = 99999999
      MinValue = 0
      TabOrder = 4
      Value = 0
    end
    object RaBSollIstVergleich: TRadioButton
      Left = 288
      Top = 52
      Width = 141
      Height = 17
      Caption = 'Soll / Ist-Vergleich'
      TabOrder = 3
      OnClick = RaBSollIstVergleichClick
    end
    object RaBBestandsanzeige: TRadioButton
      Left = 288
      Top = 24
      Width = 141
      Height = 17
      Caption = 'Bestandsanzeige'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RaBBestandsanzeigeClick
    end
    object CoBBuchungsschluessel: TComboBox
      Left = 104
      Top = 44
      Width = 89
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      MaxLength = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Visible = False
    end
    object ChLBBuchungsschluessel: TCheckListBox
      Left = 200
      Top = 24
      Width = 57
      Height = 161
      OnClickCheck = ChLBBuchungsschluesselClickCheck
      Color = clBtnFace
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  object HTTPRIO: THTTPRIO
    OnAfterExecute = HTTPRIOAfterExecute
    OnBeforeExecute = HTTPRIOBeforeExecute
    HTTPWebNode.Agent = 'Borland SOAP 1.2'
    HTTPWebNode.UseUTF8InHeader = False
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts]
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soDocument, soLiteralParams]
    Left = 288
    Top = 4
  end
  object TmrErgebnis: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TmrErgebnisTimer
    Left = 324
    Top = 4
  end
  object SAP_SVDATA_SVDATA: TAdsTable
    StoreActive = True
    AdsConnection = DaMConnections.AdsConnectionPlakettenverwaltung
    AdsTableOptions.AdsCharType = OEM
    FieldDefs = <
      item
        Name = 'PTYP'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'PJAHR'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'BDATUM'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'BSCHL'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'BSCHLBEZ'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'KORRBK'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'KORRDEPOT'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'DEPOTBEZ'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'KORRSV'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'SVNAME'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'PCNUMMER'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'PCLNWNR'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'PANZAHL'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'PANZAHLO'
        DataType = ftString
        Size = 9
      end
      item
        Name = 'PBESTAND'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'PBESTANDO'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'TBESTAND'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'ABWEICHUNG'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'HINWEIS'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'SATZART'
        DataType = ftString
        Size = 2
      end>
    StoreDefs = True
    Exclusive = True
    TableName = 'SAP_SVDATA_SVDATA.dbf'
    TableType = ttAdsCDX
    Left = 100
    Top = 288
    object SAP_SVDATA_SVDATAPTYP: TAdsStringField
      FieldName = 'PTYP'
      Size = 3
    end
    object SAP_SVDATA_SVDATAPJAHR: TAdsStringField
      FieldName = 'PJAHR'
      Size = 4
    end
    object SAP_SVDATA_SVDATABDATUM: TAdsStringField
      FieldName = 'BDATUM'
      Size = 8
    end
    object SAP_SVDATA_SVDATABSCHL: TAdsStringField
      FieldName = 'BSCHL'
      Size = 2
    end
    object SAP_SVDATA_SVDATABSCHLBEZ: TAdsStringField
      FieldName = 'BSCHLBEZ'
      Size = 50
    end
    object SAP_SVDATA_SVDATAKORRBK: TAdsStringField
      FieldName = 'KORRBK'
      Size = 4
    end
    object SAP_SVDATA_SVDATAKORRDEPOT: TAdsStringField
      FieldName = 'KORRDEPOT'
      Size = 2
    end
    object SAP_SVDATA_SVDATADEPOTBEZ: TAdsStringField
      FieldName = 'DEPOTBEZ'
      Size = 40
    end
    object SAP_SVDATA_SVDATAKORRSV: TAdsStringField
      FieldName = 'KORRSV'
      Size = 8
    end
    object SAP_SVDATA_SVDATASVNAME: TAdsStringField
      FieldName = 'SVNAME'
      Size = 40
    end
    object SAP_SVDATA_SVDATAPCNUMMER: TAdsStringField
      FieldName = 'PCNUMMER'
      Size = 4
    end
    object SAP_SVDATA_SVDATAPCLNWNR: TAdsStringField
      FieldName = 'PCLNWNR'
      Size = 5
    end
    object SAP_SVDATA_SVDATAPANZAHL: TAdsStringField
      FieldName = 'PANZAHL'
      Size = 9
    end
    object SAP_SVDATA_SVDATAPANZAHLO: TAdsStringField
      FieldName = 'PANZAHLO'
      Size = 9
    end
    object SAP_SVDATA_SVDATAPBESTAND: TAdsStringField
      FieldName = 'PBESTAND'
      Size = 11
    end
    object SAP_SVDATA_SVDATAPBESTANDO: TAdsStringField
      FieldName = 'PBESTANDO'
      Size = 11
    end
    object SAP_SVDATA_SVDATATBESTAND: TAdsStringField
      FieldName = 'TBESTAND'
      Size = 11
    end
    object SAP_SVDATA_SVDATAABWEICHUNG: TAdsStringField
      FieldName = 'ABWEICHUNG'
      Size = 11
    end
    object SAP_SVDATA_SVDATAHINWEIS: TAdsStringField
      FieldName = 'HINWEIS'
      Size = 50
    end
    object SAP_SVDATA_SVDATASATZART: TAdsStringField
      FieldName = 'SATZART'
      Size = 2
    end
  end
  object DSrcAuswertungSAP_SVDATA: TwwDataSource
    DataSet = SAP_SVDATA_SVDATA
    Left = 100
    Top = 316
  end
end
