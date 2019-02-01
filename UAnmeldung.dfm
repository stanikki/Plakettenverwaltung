object FrmAnmeldung: TFrmAnmeldung
  Left = 435
  Top = 322
  HelpContext = 1
  ActiveControl = EdtUser
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Plakettenverwaltung Anmeldung'
  ClientHeight = 210
  ClientWidth = 278
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object GrBButtons: TGroupBox
    Left = 16
    Top = 124
    Width = 245
    Height = 57
    TabOrder = 2
    object BBtnAbbrechen: TBitBtn
      Left = 144
      Top = 16
      Width = 89
      Height = 29
      Hint = 'Programm beenden!'
      Cancel = True
      Caption = '&Abbrechen'
      ModalResult = 3
      ParentShowHint = False
      ShowHint = True
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
    object BBtnOK: TBitBtn
      Left = 12
      Top = 16
      Width = 89
      Height = 29
      Hint = 'Anmeldung ausf'#252'hren!'
      Caption = '&OK'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BBtnOKClick
      Kind = bkOK
    end
  end
  object StBBottom: TStatusBar
    Left = 0
    Top = 191
    Width = 278
    Height = 19
    Panels = <
      item
        Width = 95
      end
      item
        Width = 50
      end>
    OnDrawPanel = StBBottomDrawPanel
  end
  object GrBLogin: TGroupBox
    Left = 16
    Top = 12
    Width = 245
    Height = 101
    Caption = 'Login'
    TabOrder = 0
    object LblBenutzername: TLabel
      Left = 12
      Top = 24
      Width = 68
      Height = 13
      Caption = 'Benutzername'
    end
    object LblPasswort: TLabel
      Left = 12
      Top = 64
      Width = 43
      Height = 13
      Caption = 'Passwort'
    end
    object EdtUser: TEdit
      Left = 108
      Top = 20
      Width = 121
      Height = 21
      Hint = 'Ihr Benutzername'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnEnter = EdtUserEnter
      OnExit = EdtUserExit
    end
    object EdtPasswort: TEdit
      Left = 108
      Top = 60
      Width = 121
      Height = 21
      Hint = 'Ihr Passwort'
      Color = clWhite
      ParentShowHint = False
      PasswordChar = '*'
      ShowHint = True
      TabOrder = 1
      OnEnter = EdtPasswortEnter
      OnExit = EdtPasswortExit
    end
  end
  object TmrHinweis: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = TmrHinweisTimer
    Top = 32
  end
end
