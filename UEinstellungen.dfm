object FrmEinstellungen: TFrmEinstellungen
  Left = 463
  Top = 394
  HelpContext = 8
  ActiveControl = BBtnSchliessen
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Einstellungen'
  ClientHeight = 324
  ClientWidth = 409
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
  object GrBProgrammeinstellungen: TGroupBox
    Left = 20
    Top = 16
    Width = 369
    Height = 213
    Caption = 'Programmeinstellungen'
    TabOrder = 0
    object lblSAPSystem: TLabel
      Left = 44
      Top = 132
      Width = 61
      Height = 13
      Caption = 'SAP-System:'
    end
    object lblPlakettenSteps: TLabel
      Left = 44
      Top = 24
      Width = 99
      Height = 13
      Caption = 'Plaketten pro Schritt:'
    end
    object lblConnectionType: TLabel
      Left = 44
      Top = 160
      Width = 74
      Height = 13
      Caption = 'Verbindungsart:'
    end
    object lblDefaultDepot: TLabel
      Left = 44
      Top = 56
      Width = 78
      Height = 13
      Caption = 'Standard Depot:'
    end
    object CoBSAPSystem: TComboBox
      Left = 236
      Top = 128
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
    object SpEPlakettensteps: TSpinEdit
      Left = 260
      Top = 20
      Width = 65
      Height = 22
      MaxValue = 1000
      MinValue = 1
      TabOrder = 0
      Value = 10
    end
    object CoBConnectionType: TComboBox
      Left = 236
      Top = 156
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnChange = CoBConnectionTypeChange
    end
    object ChBProxy: TCheckBox
      Left = 42
      Top = 184
      Width = 287
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Proxy verwenden:'
      TabOrder = 5
    end
    object CoBDefaultDepot: TComboBox
      Left = 188
      Top = 52
      Width = 137
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      MaxLength = 3
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object ChbAllTransactions: TCheckBox
      Left = 42
      Top = 84
      Width = 283
      Height = 17
      Hint = 'Anzeige aller tats'#228'chlichen Bestandsbuchungen'
      Alignment = taLeftJustify
      Caption = 'Tats'#228'chlicher Bestand inkl. alter Buchungen anzeigen:'
      TabOrder = 2
    end
  end
  object GrBButtons: TGroupBox
    Left = 20
    Top = 239
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
      Caption = #220'bernehmen'
      TabOrder = 0
      OnClick = BBtnUebernehmenClick
      Kind = bkOK
    end
  end
  object StBBottom: TStatusBar
    Left = 0
    Top = 305
    Width = 409
    Height = 19
    Panels = <>
  end
end
