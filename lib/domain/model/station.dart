class Station {
  late final String start;
  late final String end;
  final List<String> path;
   List<String> transList=[];
  late double time;
  late int noOfStations;
  late double ticketPrice;
  final String direction;

  Station({
    required this.path,
    required this.direction,

  }) {
    calcData();
  }

  // Convert a Station object to a Map
  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'path': path.join(','), // Join the list into a string
      'time': time,
      'noOfStations': noOfStations,
      'ticketPrice': ticketPrice,
      'direction': direction,
    };
  }
  // Create a Station object from a Map

  void calcData() {
    start = path.first;
    end = path.last;
    int startIndex = path.indexOf(start);
    int endIndex = path.indexOf(end);
    noOfStations = (endIndex - startIndex).abs();


    if (noOfStations <= 9) {
      ticketPrice = 8.0; // Base fare for up to 9 stations
    } else if (noOfStations >=10&&noOfStations <= 16  ) {
      ticketPrice = 10.0; // Fare for 9 to 16 stations
    }else if (noOfStations >= 17 && noOfStations <=23) {
      ticketPrice = 15.0; // Fare for 17 to 23 stations
    } else {
      ticketPrice = 20.0; // Fare for more than 23 stations
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