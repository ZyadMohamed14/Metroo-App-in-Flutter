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
      name: 'Line 1',
      operatingHours: 'Daily from 5:15 AM to 1:00 AM',
      lastTrainDepartures: ['Helwan Station: 11:40 PM', 'New Marg Station: 11:45 PM'],
      intersections: ['Anwar Sadat Station: Meets Line 2 at 12:15 AM', 'Gamal Abdel Nasser Station: Meets Line 3 at 12:10 AM'],
      tripTime: 'Helwan Station to New Marg Station (and vice versa): 79 minutes',
      headway: '4 minutes throughout the day',
      trainFleetSize: 62,
      trainUnits: 3,
      maximumSpeed: 80,
      designCapacity: 2583,
    ),
    MetroOperation(
      name: 'Line 2',
      operatingHours: 'Daily from 5:15 AM to approximately 12:00 AM',
      lastTrainDepartures: ['Shubra El-Kheima Station: 11:35 PM', 'El-Moneeb Station: 11:35 PM'],
      intersections: ['Anwar El-Sadat Station: Meets Line 1 at 12:00 AM'],
      tripTime: 'Shubra El-Kheima Station to El-Moneeb Station (and vice versa): 38 minutes',
      headway: '2.45-3 minutes throughout the day',
      trainFleetSize: 45,
      trainUnits: 2,
      maximumSpeed: 80,
      designCapacity: 2583,
    ),
    MetroOperation(
      name: 'Line 3',
      operatingHours: 'Daily from 5:00 AM to 12:00 AM',
      lastTrainDepartures: ['Adly Mansour Station: 11:15 PM', 'Attaba Station: 11:55 PM'],
      intersections: [],
      tripTime: 'Attaba Station to Adly Mansour Station (and vice versa): 37 minutes',
      headway: '6.5 minutes from 7 AM to 9 PM, 11 minutes from 9 PM to end of service',
      trainFleetSize: 45,
      trainUnits:20,
      maximumSpeed: 80,
      designCapacity: 2583,
    ),
  ];
}

