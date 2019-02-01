{$define fcDelphi3Up}
{$define fcDelphi4Up}
{$define fcDelphi5Up}
{$define fcDelphi6Up}
{$define fcDelphi7Up}
{$define fcDelphi9Up}
{$define fcDelphi9}
{$Define fcUseThemeManager}
{$Undef ThemeManager}

{$ifdef ver100}
{$define fcDelphi3Up}
{$define fcDelphi3}
{$define fcDelphi3Only}
{$endif}

{$ifdef ver110}
{$define fcDelphi3Up}
{$define fcDelphi3}
{$ObjExportAll On}
{$endif}

{$ifdef ver120}
{$define fcDelphi3Up}
{$define fcDelphi4Up}
{$endif}

{$IFDEF VER180}
{$define fcDelphi2006}
{$ENDIF}

{$IFDEF VER200}
{$define fcDELPHI2009Up}
{$define fcDELPHI2009}
{$define fcDELPHI2008Up}
{$define fcDELPHI2008}
{$define fcDelphi2007Up}
{$define fcDelphi2007}
{$define fcDelphi2006Up}
{$ENDIf}

{$IFDEF VER210}
{$define fcDELPHI2009Up}
{$define fcDELPHI2009}
{$define fcDELPHI2008Up}
{$define fcDELPHI2008}
{$define fcDelphi2007Up}
{$define fcDelphi2007}
{$define fcDelphi2006Up}
{$ENDIf}

{$IFDEF VER125}
{$define fcDelphi3Up}
{$define fcDelphi4Up}
{$ObjExportAll On}
{$ENDIF}

{$ifdef ver130}
{$define fcDelphi3Up}
{$define fcDelphi4Up}
{$define fcDelphi5Up}
{$define fcDelphi5}
{$endif}

{$IFDEF VER140}
{$define fcDelphi3Up}
{$define fcDelphi4Up}
{$define fcDelphi5Up}
{$define fcDelphi6Up}
{$define fcDelphi6}
{$ENDIF}
{$IFDEF VER150}
{$define fcDelphi3Up}
{$define fcDelphi4Up}
{$define fcDelphi5Up}
{$define fcDelphi6Up}
{$define fcDelphi7Up}
{$define fcDelphi7}
{$Define fcUseThemeManager}
{$Undef ThemeManager}
{$ENDIF}
{$ifdef ThemeManager}
{$Define fcUseThemeManager}
{$endif}
