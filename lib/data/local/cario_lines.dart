import 'package:drop_down_list/model/selected_list_item.dart';
class CairoLines {
  static List<String> cairoLine1() {
    List<String> metroLine1 = [
      "Helwan",
      "Ain Helwan",
      "Helwan University",
      "Wadi Hof",
      "Hadayek Helwan",
      "El-Maasara",
      "Tora El-Asmant",
      "Kozzika",
      "Tora El-Balad",
      "Sakanat El-Maadi",
      "Maadi",
      "Hadayek El-Maadi",
      "Dar El-Salam",
      "El-Zahraa",
      "Mar Girgis",
      "El-Malek El-Saleh",
      "Al-Sayeda Zeinab",
      "Saad Zaghloul",
      "Sadat",
      "Nasser",
      "Orabi",
      "Al-Shohadaa",
      "Ghamra",
      "El-Demerdash",
      "Manshiet El-Sadr",
      "Kobri El-Qobba",
      "Hammamat El-Qobba",
      "Saray El-Qobba",
      "Hadayeq El-Zaitoun",
      "Helmeyet El-Zaitoun",
      "El-Matareyya",
      "Ain Shams",
      "Ezbet El-Nakhl",
      "El-Marg",
      "New El-Marg"
    ];
    return metroLine1;
  }

  static List<String> cairoLine2() {
    List<String> metroLine2 = [
      "Shobra El-Kheima",
      "Kolleyyet El-Zeraa",
      "Mezallat",
      "Khalafawy",
      "St. Teresa",
      "Rod El-Farag",
      "Massara",
      "Al-Shohadaa",
      "Attaba",
      "Mohamed Naguib",
      "Sadat",
      "Opera",
      "Dokki",
      "Bohooth",
      "CairoUniversity",
      "Faisal",
      "Giza",
      "Omm El-Masryeen",
      "Sakiat Mekki",
      "El-Mounib"
    ];
    return metroLine2;
  }

  static List<String> cairoLine3() {
    List<String> metroLine3 = [
      "Road El Farg Corr",
      "Ring Road",
      "El Qumia",
      "El Bohy",
      "Imbaba",
      "Sudan",
      "KitKate",
      "Safay Hegazy",
      "Maspero",
      "Nasser",
      "Attaba",
      "Bab El Shaaria",
      "El Geish",
      "Abdou Pasha",
      "Abbasia",
      "Cairo Fair",
      "Stadium",
      "Kolleyet El-Banat",
      "Al Ahram",
      "Haroun",
      "Heliopolis",
      "Alf Maskan",
      "Nadi El Shams",
      "Al Nozha",
      "Hesham Barkat",
      "Qubaa",
      "Omar Ebn El Khattab",
      "El Hayikstep",
      "Adly Mansour"
    ];
    return metroLine3;
  }

  static List<String> kitKatCairoUniversityLine = [
    "KitKate",
    "Tawfikia",
    "Wadi El-Nail",
    "Gamat El-Dawel",
    "Bolaq El-Dakror",
    "CairoUniversity"
  ];
  static Map<String,String> transitionStation = {
    "Sadat":"Transition With Line 1 and Line 2",
    "Nasser":"Transition With Line 1 and Line 3",
    "Attaba":"Transition With Line 2 and Line 3",
    "Al-Shohadaa":"Transition With Line 1 and Line 2",
    "CairoUniversity":"Transition With CairoUniversity Branch and Line 3",
    "KitKate":"Transition With CairoUniversity Branch and Line 2"
  };
  static List<SelectedListItem> allCairoLines = [
    SelectedListItem(name: "Metro Line 1"),
    SelectedListItem(name: "Helwan"),
    SelectedListItem(name: "Ain Helwan"),
    SelectedListItem(name: "Helwan University"),
    SelectedListItem(name: "Wadi Hof"),
    SelectedListItem(name: "Hadayek Helwan"),
    SelectedListItem(name: "El-Maasara"),
    SelectedListItem(name: "Tora El-Asmant"),
    SelectedListItem(name: "Kozzika"),
    SelectedListItem(name: "Tora El-Balad"),
    SelectedListItem(name: "Sakanat El-Maadi"),
    SelectedListItem(name: "Maadi"),
    SelectedListItem(name: "Hadayek El-Maadi"),
    SelectedListItem(name: "Dar El-Salam"),
    SelectedListItem(name: "El-Zahraa"),
    SelectedListItem(name: "Mar Girgis"),
    SelectedListItem(name: "El-Malek El-Saleh"),
    SelectedListItem(name: "Al-Sayeda Zeinab"),
    SelectedListItem(name: "Saad Zaghloul"),
    SelectedListItem(name: "Sadat"),
    SelectedListItem(name: "Nasser"),
    SelectedListItem(name: "Orabi"),
    SelectedListItem(name: "Al-Shohadaa"),
    SelectedListItem(name: "Ghamra"),
    SelectedListItem(name: "El-Demerdash"),
    SelectedListItem(name: "Manshiet El-Sadr"),
    SelectedListItem(name: "Kobri El-Qobba"),
    SelectedListItem(name: "Hammamat El-Qobba"),
    SelectedListItem(name: "Saray El-Qobba"),
    SelectedListItem(name: "Hadayeq El-Zaitoun"),
    SelectedListItem(name: "Helmeyet El-Zaitoun"),
    SelectedListItem(name: "El-Matareyya"),
    SelectedListItem(name: "Ain Shams"),
    SelectedListItem(name: "Ezbet El-Nakhl"),
    SelectedListItem(name: "El-Marg"),
    SelectedListItem(name: "New El-Marg"),
    SelectedListItem(name: "Metro Line 2"),
    SelectedListItem(name: "Shobra El-Kheima"),
    SelectedListItem(name: "Kolleyyet El-Zeraa"),
    SelectedListItem(name: "Mezallat"),
    SelectedListItem(name: "Khalafawy"),
    SelectedListItem(name: "St. Teresa"),
    SelectedListItem(name: "Rod El-Farag"),
    SelectedListItem(name: "Massara"),
    SelectedListItem(name: "Al-Shohadaa"),
    SelectedListItem(name: "Attaba"),
    SelectedListItem(name: "Mohamed Naguib"),
    SelectedListItem(name: "Sadat"),
    SelectedListItem(name: "Opera"),
    SelectedListItem(name: "Dokki"),
    SelectedListItem(name: "Bohooth"),
    SelectedListItem(name: "CairoUniversity"),
    SelectedListItem(name: "Faisal"),
    SelectedListItem(name: "Giza"),
    SelectedListItem(name: "Omm El-Masryeen"),
    SelectedListItem(name: "Sakiat Mekki"),
    SelectedListItem(name: "El-Mounib"),
    SelectedListItem(name: "Metro Line 3"),
    SelectedListItem(name: "Road El Farg Corr"),
    SelectedListItem(name: "Ring Road"),
    SelectedListItem(name: "El Qumia"),
    SelectedListItem(name: "El Bohy"),
    SelectedListItem(name: "Imbaba"),
    SelectedListItem(name: "Sudan"),
    SelectedListItem(name: "Kit Kate"),
    SelectedListItem(name: "Safay Hegazy"),
    SelectedListItem(name: "Maspero"),
    SelectedListItem(name: "Nasser"),
    SelectedListItem(name: "Attaba"),
    SelectedListItem(name: "Bab El Shaaria"),
    SelectedListItem(name: "El Geish"),
    SelectedListItem(name: "Abdou Pasha"),
    SelectedListItem(name: "Abbasia"),
    SelectedListItem(name: "Cairo Fair"),
    SelectedListItem(name: "Stadium"),
    SelectedListItem(name: "Kolleyet El-Banat"),
    SelectedListItem(name: "Al Ahram"),
    SelectedListItem(name: "Haroun"),
    SelectedListItem(name: "Heliopolis"),
    SelectedListItem(name: "Alf Maskan"),
    SelectedListItem(name: "Nadi El Shams"),
    SelectedListItem(name: "Al Nozha"),
    SelectedListItem(name: "Hesham Barkat"),
    SelectedListItem(name: "Qubaa"),
    SelectedListItem(name: "Omar Ebn El Khattab"),
    SelectedListItem(name: "El Hayikstep"),
    SelectedListItem(name: "Adly Mansour"),
    SelectedListItem(name: "KitKate Cairo Branch"),
    SelectedListItem(name: "Tawfikia"),
    SelectedListItem(name: "Wadi El-Nail"),
    SelectedListItem(name: "Gamat El-Dawel"),
    SelectedListItem(name: "Bolaq El-Dakror"),
  ];
}
