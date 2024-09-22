class Station {
  late final String start;
  late final String end;
  final List<String> path;
  late double time;
  late int noOfStations;
  late double ticketPrice;
  final String direction;

  Station({required this.path, required this.direction}) {
    calcData();
  }

  void calcData() {
    start = path.first;
    end = path.last;
    int startIndex = path.indexOf(start);
    int endIndex = path.indexOf(end);
    noOfStations = (endIndex - startIndex).abs();



    if (noOfStations <= 9) {
      ticketPrice = 6.0; // Base fare for up to 8 stations
    } else if (noOfStations <= 16) {
      ticketPrice = 8.0; // Fare for 9 to 16 stations
    } else {
      ticketPrice = 12.0; // Fare for more than 16 stations
    }



    int timePerStation = 2;
    time = timePerStation * noOfStations.toDouble();


  }

  String getStart() => start;

  String getEnd() => end;

  List<String> getPath() => path;

  int getNoOfStations() => noOfStations;

  double getTime() => time;

  double getTicketPrice() => ticketPrice;

  String getDirection() => direction;
}