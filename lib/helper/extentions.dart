extension StringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
// Extension function to normalize station names
extension StringExtension on String {
  String normalize() {
    return this.replaceAll(' ', '');
  }
}