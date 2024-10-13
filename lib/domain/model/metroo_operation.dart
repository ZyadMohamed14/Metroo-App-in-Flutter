import 'package:get/get.dart';
class MetroOperation {
  final String name;
  final String operatingHours;
  final List<String> lastTrainDepartures;
  final List<String> intersections;
  final String tripTime;
  final String headway;
  final int trainFleetSize;
  final int trainUnits;
  final int maximumSpeed;
  final int designCapacity;

  MetroOperation({
    required this.name,
    required this.operatingHours,
    required this.lastTrainDepartures,
    required this.intersections,
    required this.tripTime,
    required this.headway,
    required this.trainFleetSize,
    required this.trainUnits,
    required this.maximumSpeed,
    required this.designCapacity,
  });

  static List<MetroOperation> cairoMetroOperations = [
    MetroOperation(
      name: 'line1'.tr,
      operatingHours: 'operatingHoursLine1'.tr,
      lastTrainDepartures: ['lastTrainDepartureLine1'.tr],
      intersections: ['intersectionsLine1'.tr],
      tripTime: 'tripTimeLine1'.tr,
      headway: 'headwayLine1'.tr,
      trainFleetSize: 62,
      trainUnits: 3,
      maximumSpeed: 80,
      designCapacity: 2583,
    ),
    MetroOperation(
      name: 'line2'.tr,
      operatingHours: 'operatingHoursLine2'.tr,
      lastTrainDepartures: ['lastTrainDepartureLine2'.tr],
      intersections: ['intersectionsLine2'.tr],
      tripTime: 'tripTimeLine2'.tr,
      headway: 'headwayLine2'.tr,
      trainFleetSize: 45,
      trainUnits: 2,
      maximumSpeed: 80,
      designCapacity: 2583,
    ),
    MetroOperation(
      name: 'line3'.tr,
      operatingHours: 'operatingHoursLine3'.tr,
      lastTrainDepartures: ['lastTrainDepartureLine3'.tr],
      intersections: [],
      tripTime: 'tripTimeLine3'.tr,
      headway: 'headwayLine3'.tr,
      trainFleetSize: 45,
      trainUnits: 20,
      maximumSpeed: 80,
      designCapacity: 2583,
    ),
  ];
}
