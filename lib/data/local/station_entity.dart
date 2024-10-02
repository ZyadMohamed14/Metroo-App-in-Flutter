class StationEntity {
  late final String start;
  late final String end;
  final List<String> path;
  late double time;
  late int noOfStations;
  late double ticketPrice;
  final String direction;

  StationEntity({
    required this.start,
    required this.end,
    required this.path,
    required this.time,
    required this.noOfStations,
    required this.ticketPrice,
    required this.direction,
  });

  // Convert a Station object to a Map
  // Convert a Station object into a Map
  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'path': path.join(','), // Join the list to a string
      'time': time,
      'noOfStations': noOfStations,
      'ticketPrice': ticketPrice,
      'direction': direction,
    };
  }

  // Create a Station object from a Map
  factory StationEntity.fromMap(Map<String, dynamic> map) {
    return StationEntity(
      start: map['start'],
      end: map['end'],
      path: map['path'].split(','),
      // Split the string back to a list
      time: map['time'],
      noOfStations: map['noOfStations'],
      ticketPrice: map['ticketPrice'],
      direction: map['direction'],
    );
  }
}