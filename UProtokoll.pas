unit UProtokoll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, Wwdbigrd, Wwdbgrid, DB,
  Wwdatsrc, UPlakettenverwaltung, adsdata, adsfunc, adstable;

type
  TFrmProtokoll = class(TForm)
    GrBProtokoll: TGroupBox;
    wwDBGridProtokoll_SVDATA: TwwDBGrid;
    GrBButtons: TGroupBox;
    BBtnSchliessen: TBitBtn;
    StBBottom: TStatusBar;
    DSrcProtokollSAP_SVDATA: TwwDataSource;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FrmProtokoll: TFrmProtokoll;

implementation

{$R *.dfm}

end.
