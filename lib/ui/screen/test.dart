/*
/* Simple Hello, World! program */

void main() {
  // Call the functions to get the data
  Map<String, String> coordinates = metroLine3CoordinatesArabic();
  List<String> stations = cairoLine3Ar();

  // Pass the results to the function
  printNonMatchingStationIndices(coordinates, stations);
}

// Function to return a list of Cairo Line 2 stations
List<String> cairoLine3Ar() {
    List<String> cairoLine3Ar = [
      "محور روض الفرج",
      "طريق الدائري",
      "القومية",
      "البوهي",
      "إمبابة",
      "السودان",
      "الكيت كات",
      "صفاء حجازي",
      "ماسبيرو",
      'ناصر',
      'العتبه',
      "باب الشعريه",
      "الجيش",
      "عبده باشا",
      "عباسية",
      "معرض القاهرة",
      "استاد",
      "كلية البنات",
      "الأهرام",
      "هارون",
      "هيليوبوليس",
      "ألف مسكن",
      "نادي الشمس",
      "النزهة",
      "هشام بركات",
      "قباء",
      "عمر بن الخطاب",
      "الهايكستب",
      "عدلي منصور"
    ];

    return cairoLine3Ar;
  }

// Function to return a map of Metro Line 2 coordinates
Map<String, String> metroLine3CoordinatesArabic() {
    Map<String, String> metroLine3Coordinates = {
      "محور روض الفرج": "30.10190989339181,31.18443476887509",
      "طريق الدائري": "30.096436204240455,31.19957496154549",
      "القومية": "30.093243411138406,31.209015865290002",
      "البوهي": "30.08212470598578,31.210551397385398",
      "إمبابة": "30.075849192590763,31.20745519619157",
      "السودان": "30.070089263060304,31.204705593218478",
      "الكيت كات": "30.06655933608745,31.21301257656363",
      "صفاء حجازي": "30.062268041069913,31.223297859633735",
      "ماسبيرو": "30.055701946915768,31.232115481245565",
      "ناصر": "30.053507874692166,31.238736914888786",
      "العتبه": "30.052359292738558,31.24678431031718",
      "باب الشعريه": "30.054132043308126,31.255909339812927",
      "الجيش": "30.06173781897152,31.266885049885264",
      "عبده باشا": "30.064796568469745,31.27470388360256",
      "عباسية": "30.072005453041363,31.283362803691247",
      "معرض القاهرة": "30.0733734683471,31.30098199011045",
      "استاد": "30.072943184506745,31.317099714339914",
      "كلية البنات": "30.084063374530945,31.329004072861526",
      "الأهرام": "30.091783963542465,31.3262925051496",
      "هارون": "30.101537049663246,31.33300219159074",
      "هيليوبوليس": "30.108473252129592,31.338327106406293",
      "ألف مسكن": "30.119010620454404,31.340184365632673",
      "نادي الشمس": "30.125513322722618,31.34891613259467",
      "النزهة": "30.127959919525487,31.360178589070863",
      "هشام بركات": "30.13085100901205,31.37289445119273",
      "قباء": "30.134836167768402,31.383742032938756",
      "عمر بن الخطاب": "30.140362112263343,31.394360837128424",
      "الهايكستب": "30.14387145849703,31.404690072211803",
      "عدلي منصور": "30.147068153833473,31.421197940368376",
    };

    return metroLine3Coordinates;
  }

// Function to print non-matching station indices
void printNonMatchingStationIndices(Map<String, String> stationCoordinates, List<String> stationList) {
  // Loop through each station in the stationList
  for (int index = 0; index < stationList.length; index++) {
    String station = stationList[index];
    bool matchFound = false;

    // Check if any key in the map matches the station
    for (String mapKey in stationCoordinates.keys) {
      if (mapKey == station) {
        matchFound = true; // A match is found
        break; // Exit inner loop if a match is found
      }
    }

    // If no match was found, print the index
    if (!matchFound) {
      print('No match found for station "$station" at index: $index');
    }
  }
}

 */