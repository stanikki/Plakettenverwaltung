object FrmPlakettenabgaenge: TFrmPlakettenabgaenge
  Left = 775
  Top = 216
  HelpContext = 6
  ActiveControl = BBtnSchliessen
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Plakettenabg'#228'nge'
  ClientHeight = 471
  ClientWidth = 410
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
  PixelsPerInch = 96
  TextHeight = 13
  object GrBAbgangerfassen: TGroupBox
    Left = 20
    Top = 16
    Width = 369
    Height = 357
    Caption = 'Abgang erfassen'
    TabOrder = 0
    object lblPlakettentyp: TLabel
      Left = 24
      Top = 60
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
    object lblBuchungsdatum: TLabel
      Left = 24
      Top = 116
      Width = 80
      Height = 13
      Caption = 'Buchungsdatum:'
    end
    object lblBuchungskreis: TLabel
      Left = 24
      Top = 144
      Width = 73
      Height = 13
      Caption = 'Buchungskreis:'
    end
    object lblDepot: TLabel
      Left = 24
      Top = 172
      Width = 32
      Height = 13
      Caption = 'Depot:'
    end
    object lblPersonalnummer: TLabel
      Left = 24
      Top = 200
      Width = 81
      Height = 13
      Caption = 'Personalnummer:'
    end
    object lblPlakettenbelegnummer: TLabel
      Left = 24
      Top = 228
      Width = 111
      Height = 13
      Caption = 'Plakettenbelegnummer:'
    end
    object lblPlakettenanzahl: TLabel
      Left = 24
      Top = 256
      Width = 79
      Height = 13
      Caption = 'Plakettenanzahl:'
    end
    object lblBezechnung: TLabel
      Left = 24
      Top = 284
      Width = 63
      Height = 13
      Caption = 'Bezechnung:'
    end
    object lblUpdateKennzeichen: TLabel
      Left = 24
      Top = 312
      Width = 103
      Height = 13
      Caption = 'Update-Kennzeichen:'
    end
    object lblAbgang: TLabel
      Left = 24
      Top = 32
      Width = 61
      Height = 13
      Caption = 'Abgang an ..'
    end
    object DaTiPBuchungsdatum: TDateTimePicker
      Left = 160
      Top = 112
      Width = 89
      Height = 21
      Date = 40548.478526701390000000
      Time = 40548.478526701390000000
      TabOrder = 4
    end
    object CoBPlakettentyp: TComboBox
      Left = 160
      Top = 56
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object MaEBuchungskreis: TMaskEdit
      Left = 160
      Top = 140
      Width = 57
      Height = 21
      EditMask = '0000;1; '
      MaxLength = 4
      TabOrder = 5
      Text = '    '
    end
    object CoBDepot: TComboBox
      Left = 160
      Top = 168
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      MaxLength = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnChange = CoBDepotChange
    end
    object MaEPersonalnummer: TMaskEdit
      Left = 160
      Top = 196
      Width = 71
      Height = 21
      EditMask = '00000000;1;#'
      MaxLength = 8
      TabOrder = 7
      Text = '        '
    end
    object MaEPlakettenbelegnummer: TMaskEdit
      Left = 160
      Top = 224
      Width = 114
      Height = 21
      EditMask = '0000000000;1; '
      MaxLength = 10
      TabOrder = 8
      Text = '          '
    end
    object EdBezeichnung: TEdit
      Left = 160
      Top = 280
      Width = 177
      Height = 21
      MaxLength = 40
      TabOrder = 10
    end
    object EdUpdateKennzeichen: TEdit
      Left = 160
      Top = 308
      Width = 25
      Height = 21
      MaxLength = 1
      TabOrder = 11
    end
    object RaBDepot: TRadioButton
      Left = 160
      Top = 28
      Width = 69
      Height = 17
      Caption = 'Depot'
      TabOrder = 0
      OnClick = RaBDepotClick
    end
    object RaBPerson: TRadioButton
      Left = 236
      Top = 28
      Width = 69
      Height = 17
      Caption = 'Person'
      TabOrder = 1
      OnClick = RaBPersonClick
    end
    object SpEPlakettenanzahl: TSpinEdit
      Left = 160
      Top = 252
      Width = 89
      Height = 22
      Increment = 10
      MaxLength = 8
      MaxValue = 99999999
      MinValue = 0
      TabOrder = 9
      Value = 0
    end
    object CoBPlakettenjahr: TComboBox
      Left = 160
      Top = 84
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
    end
  end
  object StBBottom: TStatusBar
    Left = 0
    Top = 452
    Width = 410
    Height = 19
    Panels = <>
  end
  object GrBButtons: TGroupBox
    Left = 20
    Top = 384
    Width = 369
    Height = 57
    TabOrder = 1
    object BBtnSchliessen: TBitBtn
      Left = 260
      Top = 16
      Width = 97
      Height = 29
      Caption = '&Schlie'#223'en'
      ModalResult = 2
      TabOrder = 1
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
    object BBtnUebernehmen: TBitBtn
      Left = 16
      Top = 16
      Width = 97
      Height = 29
      TabOrder = 0
      OnClick = BBtnUebernehmenClick
      Kind = bkOK
    end
  end
end
