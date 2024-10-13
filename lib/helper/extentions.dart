import 'package:get/get.dart';

import '../data/local/station_entity.dart';
import '../domain/model/station.dart';
extension StringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
// Extension function to normalize station names
extension StringExtension on String {
  String normalize() {
    return this.replaceAll(' ', '');
  }

}
extension arabicNumberExtension on String {
  String toArabicNumbers() {
    const englishToArabicDigits = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    return this.split('').map((char) {
      return englishToArabicDigits[char] ?? char; // Replace if it's a digit, otherwise keep it
    }).join();
  }
}
extension StationEntityToStation on StationEntity {
  Station toStation() {
    return Station(
      path: path,
      direction: direction,
    );
  }
}
String formatTime(int timeInMinutes) {
  // Get the whole number of hours
  int hours = timeInMinutes ~/ 60;

  // Get the remaining minutes
  int minutes = timeInMinutes % 60;

  // Handle different scenarios based on time
  if (hours > 0 && minutes > 0) {
    // If both hours and minutes are present
    return "${hours} ${hours == 1 ? 'hour'.tr : 'hours'.tr} ${'and'.tr} ${minutes} ${minutes == 1 ? 'minute'.tr : 'minutes'.tr}";
  } else if (hours > 0) {
    // If only hours are present
    return "${hours} ${'hour'.tr}${hours == 1 ? '' : 'hours'.tr}";
  } else {
    // If only minutes are present
    return "${minutes} ${'minute'.tr}${minutes == 1 ? '' : 'minutes'.tr}";
  }
}
