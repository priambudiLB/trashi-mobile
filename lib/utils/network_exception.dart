class NetworkException implements Exception {
  String _errorMessage;
  int _errorStatusCode;
  dynamic _response;

  NetworkException(
      {String errorMessage, int errorStatusCode, dynamic response}) {
    this._errorMessage = errorMessage;
    this._errorStatusCode = errorStatusCode;
    this._response = response;
  }

  @override
  String toString() =>
      "Error Status code: ${this._errorStatusCode}, Message: ${this._errorMessage}";

  String get errorMessage => this._errorMessage;
  int get errorStatusCode => this._errorStatusCode;
  dynamic get response => this._response;
}
