class ContentFetchException implements Exception {
  ContentFetchException(this.message, [this.statusCode, this.body]);
  final String message;
  final int? statusCode;
  final String? body;

  @override
  String toString() {
    return message +
        (statusCode != null ? ' - status code: $statusCode' : '') +
        (body != null ? ' - body: $body' : '');
  }
}
