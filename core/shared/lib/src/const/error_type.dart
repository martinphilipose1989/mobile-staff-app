enum ErrorType {
  //custom error
  iOException,

  //Network Error
  network,
  netServerMessage,
  netDefaultError,
  unknown,
  // UI Errors
  ui,
  uiEmptyEmail,
  uiInvalidEmail,
  uiEmptyPassword,
  uiEmptyName,
  uiVistorType,
  uiPurposeOfVisit,
  uiPorfileImage,

  //DB ERROR
  database,
  databaseNotSupported,
  databaseError1,
  databaseUserNotFound,

  // FILE
  imagePickerCancelled,
  imagePickerFailed,
  fileSizeExceed,
  filePickerFailed,

  //QR Error
  qrCodeInvalid,

  // Auth Error
  appAuthUserCancelled,
  appAuthPlatformException,

  // Storage
  storageError
}
