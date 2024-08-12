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

  //DB ERROR
  database,
  databaseNotSupported,
  databaseError1,
  databaseUserNotFound,

  // FILE
  imagePickerCancelled,
  imagePickerFailed,
  fileSizeExceed,
  filePickerFailed
}
