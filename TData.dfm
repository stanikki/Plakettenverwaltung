object DaMConnections: TDaMConnections
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 584
  Top = 221
  Height = 290
  Width = 313
  object AdsConnectionMOP: TAdsConnection
    IsConnected = False
    AdsServerTypes = [stADS_LOCAL]
    LoginPrompt = True
    Compression = ccAdsCompressionNotSet
    CommunicationType = ctAdsDefault
    Left = 52
    Top = 8
  end
  object AdsConnectionTMOP: TAdsConnection
    IsConnected = False
    AdsServerTypes = [stADS_LOCAL]
    LoginPrompt = True
    Compression = ccAdsCompressionNotSet
    CommunicationType = ctAdsDefault
    Left = 52
    Top = 68
  end
  object AdsConnectionPRIVATE: TAdsConnection
    IsConnected = False
    AdsServerTypes = [stADS_LOCAL]
    LoginPrompt = True
    Compression = ccAdsCompressionNotSet
    CommunicationType = ctAdsDefault
    Left = 52
    Top = 136
  end
  object AdsConnectionSHARED: TAdsConnection
    IsConnected = False
    AdsServerTypes = [stADS_LOCAL]
    LoginPrompt = True
    Compression = ccAdsCompressionNotSet
    CommunicationType = ctAdsDefault
    Left = 56
    Top = 204
  end
  object AdsSettings1: TAdsSettings
    DateFormat = 'dd.MM.yyyy'
    NumDecimals = 2
    SetDelphiDate = True
    ShowDeleted = False
    AdsServerTypes = [stADS_LOCAL]
    NumCachedTables = 0
    NumCachedCursors = 25
    Left = 200
    Top = 8
  end
  object AdsConnectionPlakettenverwaltung: TAdsConnection
    IsConnected = False
    AdsServerTypes = [stADS_LOCAL]
    LoginPrompt = True
    Compression = ccAdsCompressionNotSet
    CommunicationType = ctAdsDefault
    Left = 200
    Top = 204
  end
end
