object FrmProtokoll: TFrmProtokoll
  Left = 306
  Top = 240
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Protokoll-Anzeige'
  ClientHeight = 649
  ClientWidth = 982
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    982
    649)
  PixelsPerInch = 96
  TextHeight = 13
  object GrBProtokoll: TGroupBox
    Left = 16
    Top = 16
    Width = 949
    Height = 537
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Protokoll'
    TabOrder = 0
  end
  object GrBButtons: TGroupBox
    Left = 16
    Top = 564
    Width = 949
    Height = 57
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      949
      57)
    object BBtnSchliessen: TBitBtn
      Left = 836
      Top = 16
      Width = 97
      Height = 29
      Anchors = [akRight]
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object StBBottom: TStatusBar
    Left = 0
    Top = 630
    Width = 982
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 350
      end
      item
        Width = 50
      end>
  end
end
