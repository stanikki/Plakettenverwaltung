unit UInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, TData;

type
  TFrmInfo = class(TForm)
    ImgClaim: TImage;
    BBtnOK: TBitBtn;
    LblInfo1: TLabel;
    LblInfo2: TLabel;
    lblVersion: TLabel;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmInfo: TFrmInfo;

implementation

{$R *.dfm}

procedure TFrmInfo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TFrmInfo.FormCreate(Sender: TObject);
begin
  lblVersion.Caption := PRG_VERSION;
end;

procedure TFrmInfo.FormClick(Sender: TObject);
begin
  Close;
end;

end.
