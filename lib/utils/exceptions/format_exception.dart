class AppFormatException implements Exception {
  final String message;

  const AppFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  factory AppFormatException.fromMessage(String message) {
    return AppFormatException(message);
  }

  /// Get the corresponding error message.
  String get formattedMessage => message;

  /// Create a format exception from a specific error code.
  factory AppFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return const AppFormatException('The email address format is invalid. Please enter a valid email.');
      case 'invalid-phone-number-format':
        return const AppFormatException('The provided phone number format is invalid. Please enter a valid number.');
      case 'invalid-date-format':
        return const AppFormatException('The date format is invalid. Please enter a valid date.');
      case 'invalid-url-format':
        return const AppFormatException('The URL format is invalid. Please enter a valid URL.');
      case 'invalid-numeric-format':
        return const AppFormatException('The input should be a valid numeric format.');
      default:
        return const AppFormatException();
    }
  }
}