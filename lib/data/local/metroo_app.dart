import 'cario_lines.dart';

class MetroApp {
  List<String> _metroLine1;
  List<String> _metroLine2;
  List<String> _metroLine3;
  List<String> _cairoKitKateBranch;
  List<List<String>> _routes;
  StringBuffer _directionForFirstRoute;
  StringBuffer _directionForSecondRoute;
  String _direction; // For single route // For single route
  String start, end;
  String transtionStation1;


  MetroApp(this.start, this.end)
      : _metroLine1 = CairoLines.cairoLine1(),
        _metroLine2 = CairoLines.cairoLine2(),
        _metroLine3 = CairoLines.cairoLine3(),
        _cairoKitKateBranch = CairoLines.kitKatCairoUniversityLine,
        _routes = [],
        _directionForFirstRoute = StringBuffer(),
        _directionForSecondRoute = StringBuffer(),
        _direction = '',
        transtionStation1 = "";


  String getDirection() {
    return _direction;
  }

  List<List<String>> getRoutes() {
    return _routes;
  }

  StringBuffer getDirectionForFirstRoute() {
    return _directionForFirstRoute;
  }

  StringBuffer getDirectionForSecondRoute() {
    return _directionForSecondRoute;
  }

  void searchPath() {
    if (isSameLine(start, end)) {
      getPathIfSameLine();
    } else {
      _searchInManyLines();
    }
  }

  bool isValidData() {
    if (start.isEmpty || end.isEmpty) return false;
    if (start == end) return false;
    return _isValidStation(start) && _isValidStation(end);
  }

  bool _isValidStation(String station) {
    return _metroLine1.contains(station) ||
        _metroLine2.contains(station) ||
        _metroLine3.contains(station) ||
        _cairoKitKateBranch.contains(station);
  }

  bool isSameLine(String start, String end) {
    return isOnSameLine(_metroLine1, start, end) ||
        isOnSameLine(_metroLine2, start, end) ||
        isOnSameLine(_metroLine3, start, end) ||
        isOnSameLine(_cairoKitKateBranch, start, end);
  }

  bool isOnSameLine(List<String> line, String start, String end) {
    return line.contains(start) && line.contains(end);
  }

  void getPathIfSameLine() {
    List<String> path = [];

    if (_metroLine1.contains(start) && _metroLine1.contains(end)) {
      path = _getSingleRoute(_metroLine1, start, end);
    } else if (_metroLine2.contains(start) && _metroLine2.contains(end)) {
      path = _getSingleRoute(_metroLine2, start, end);
    } else if (_metroLine3.contains(start) && _metroLine3.contains(end)) {
      path = _getSingleRoute(_metroLine3, start, end);
    } else if (_cairoKitKateBranch.contains(start) &&
        _cairoKitKateBranch.contains(end)) {
      path = _getSingleRoute(_cairoKitKateBranch, start, end);
    }

    _routes.add(path);
  }

  List<String> _getSingleRoute(List<String> line, String start, String end) {
    int startIndex = line.indexOf(start);
    int endIndex = line.indexOf(end);
    List<String> subListPath;

    if (startIndex < endIndex) {
      subListPath = line.sublist(startIndex, endIndex + 1);
      _direction = "Take Direction to ${line.last}";
    } else {
      _direction = "Take Direction to ${line.first}";
      subListPath = line.sublist(endIndex, startIndex + 1);
      subListPath = subListPath.reversed.toList();
    }

    return subListPath;
  }

  void _searchInManyLines() {
    if (_metroLine1.contains(start) && _metroLine2.contains(end)) {
      _searchRoutesFromLine1ToLine2();
    } else if (_metroLine2.contains(start) && _metroLine1.contains(end)) {
      _searchRoutesFromLine2ToLine1();
    } else if (_metroLine2.contains(start) && _metroLine3.contains(end)) {
      _searchRoutesFromLine2ToLine3();
    } else if (_metroLine3.contains(start) && _metroLine2.contains(end)) {
      _searchRoutesFromLine3ToLine2();
    } else if (_metroLine1.contains(start) && _metroLine3.contains(end)) {
      _searchRoutesFromLine1ToLine3();
    } else if (_metroLine3.contains(start) && _metroLine1.contains(end)) {
      _searchRoutesFromLine3ToLine1();
    } else if (_metroLine1.contains(start) &&
        _cairoKitKateBranch.contains(end)) {
      _searchRoutesFromLine1ToCairoKitKateBranch();
    } else if (_cairoKitKateBranch.contains(start) &&
        _metroLine1.contains(end)) {
      _searchRoutesFromCairoKitKateBranchToLine1();
    } else if (_metroLine2.contains(start) &&
        _cairoKitKateBranch.contains(end)) {
      _searchRoutesFromLine2ToCairoKitKateBranch();
    } else if (_cairoKitKateBranch.contains(start) &&
        _metroLine2.contains(end)) {
      _searchRoutesFromCairoKitKateBranchToLine2();
    }
  }

  void _searchRoutesFromCairoKitKateBranchToLine2() {
    final startIndex = _cairoKitKateBranch.indexOf(start);
    final endIndex = _metroLine2.indexOf(end);
    final attabaIndexAtLine2 = _metroLine2.indexOf('Attaba');
    final cairoIndexAtLine2 = _metroLine2.indexOf('CairoUniversity');
    final kitKateIndexAtCairoBranch = _cairoKitKateBranch.indexOf('KitKate');
    final cairoUniversityIndexAtCairoBranch =
        _cairoKitKateBranch.indexOf('CairoUniversity');
    final attabaIndexAtLine3 = _metroLine3.indexOf('Attaba');
    final kitKateIndexAtLine3 = _metroLine3.indexOf('KitKate');
    final List<String> attabaLine = [];
    final List<String> cairoLine = [];
    List<String> subLine = [];

    // Option 1: Change at Attaba
    _directionForFirstRoute.write('Change Direction to KitKate ');

    subLine = _cairoKitKateBranch
        .sublist(kitKateIndexAtCairoBranch, startIndex + 1)
        .reversed
        .toList();
    attabaLine.addAll(subLine);
    subLine.clear();

    attabaLine.addAll(
        _metroLine3.sublist(kitKateIndexAtLine3 + 1, attabaIndexAtLine3));
    _directionForFirstRoute.write(
        'Then Take Direction to Adly Mansour and Change Direction at Attaba ');
    if (endIndex < attabaIndexAtLine2) {
      _directionForFirstRoute
          .write('Then Take Direction to Shobra El-Kheima  ');
      subLine = _metroLine2
          .sublist(endIndex, attabaIndexAtLine2 + 1)
          .reversed
          .toList();
      attabaLine.addAll(subLine);
      subLine.clear();
    } else {
      _directionForFirstRoute.write('Then Take Direction to El-Mounib  ');
      attabaLine.addAll(_metroLine2.sublist(attabaIndexAtLine2, endIndex + 1));
    }

    // Option 2: Change at Cairo University
    _directionForSecondRoute.write('Change Direction to CairoUniversity ');
    cairoLine.addAll(_cairoKitKateBranch.sublist(
        startIndex, cairoUniversityIndexAtCairoBranch + 1));
    if (endIndex < cairoIndexAtLine2) {
      _directionForSecondRoute.write('Then Take Direction to Shobra El-Kheima');
      subLine =
          _metroLine2.sublist(endIndex, cairoIndexAtLine2).reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else {
      _directionForSecondRoute.write('Then Take Direction to El-Mounib');
      cairoLine
          .addAll(_metroLine2.sublist(cairoIndexAtLine2 + 1, endIndex + 1));
    }

    _routes.add(attabaLine);
    _routes.add(cairoLine);
  }

  void _searchRoutesFromLine2ToCairoKitKateBranch() {
    final startIndex = _metroLine2.indexOf(start);
    final endIndex = _cairoKitKateBranch.indexOf(end);
    final attabaIndexAtLine2 = _metroLine2.indexOf('Attaba');
    final cairoIndexAtLine2 = _metroLine2.indexOf('CairoUniversity');
    final List<String> attabaLine = [];
    final List<String> cairoLine = [];
    List<String> subLine = [];

    // Operations on Line 2
    if (startIndex > attabaIndexAtLine2 && startIndex > cairoIndexAtLine2) {
      _directionForFirstRoute.write(
          'Take Direction to Shobra El-Kheima and Change Direction at Attaba ');
      _directionForSecondRoute.write(
          'Take Direction to Shobra El-Kheima and Change Direction at CairoUniversity ');
      subLine = _metroLine2
          .sublist(attabaIndexAtLine2 + 1, startIndex + 1)
          .reversed
          .toList();
      attabaLine.addAll(subLine);
      subLine.clear();
      subLine = _metroLine2
          .sublist(cairoIndexAtLine2 + 1, startIndex + 1)
          .reversed
          .toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else if (startIndex < attabaIndexAtLine2 &&
        startIndex < cairoIndexAtLine2) {
      _directionForFirstRoute.write(
          'Take Direction to El-Mounib and Change Direction at Attaba ');
      _directionForSecondRoute.write(
          'Take Direction to El-Mounib and Change Direction at CairoUniversity ');
      attabaLine.addAll(_metroLine2.sublist(startIndex, attabaIndexAtLine2));
      cairoLine.addAll(_metroLine2.sublist(startIndex, cairoIndexAtLine2));
    } else if (startIndex > attabaIndexAtLine2 &&
        startIndex < cairoIndexAtLine2) {
      _directionForFirstRoute.write(
          'Take Direction to ShobraEl-Kheima and Change Direction at Attaba ');
      _directionForSecondRoute.write(
          'Take Direction to El-Mounib and Change Direction at CairoUniversity ');
      subLine = _metroLine2
          .sublist(attabaIndexAtLine2 + 1, startIndex)
          .reversed
          .toList();
      attabaLine.addAll(subLine);
      subLine.clear();
      cairoLine.addAll(_metroLine2.sublist(startIndex, cairoIndexAtLine2));
    } else {
      _directionForFirstRoute.write('You are At Attaba');
      _directionForSecondRoute.write('You are At CairoUniversity');
    }

    // Operations on Line 3 with Attaba line
    _directionForFirstRoute.write(
        'Then Take Direction to Road El FargCorr and Change Direction at KitKate ');
    final attabaIndexAtLine3 = _metroLine3.indexOf('Attaba');
    final kitKateIndexAtLine3 = _metroLine3.indexOf('KitKate');
    final kitKateIndexAtCairoBranch = _cairoKitKateBranch.indexOf('KitKate');
    final cairoIndexAtCairoBranch =
        _cairoKitKateBranch.indexOf('CairoUniversity');
    subLine = _metroLine3
        .sublist(kitKateIndexAtLine3 + 1, attabaIndexAtLine3 + 1)
        .reversed
        .toList();
    attabaLine.addAll(subLine);
    subLine.clear();
    attabaLine.addAll(
        _cairoKitKateBranch.sublist(kitKateIndexAtCairoBranch, endIndex + 1));

    // Operations on Cairo Branch with Cairo line
    _directionForSecondRoute.write('Then Take Direction to KitKate ');
    subLine = _cairoKitKateBranch
        .sublist(endIndex, cairoIndexAtCairoBranch + 1)
        .reversed
        .toList();
    cairoLine.addAll(subLine);
    subLine.clear();

    _routes.add(attabaLine);
    _routes.add(cairoLine);
  }

  void _searchRoutesFromCairoKitKateBranchToLine1() {
    final startIndex = _cairoKitKateBranch.indexOf(start);
    final cairoIndexAtKitKatCairoUniversityBranch =
        _cairoKitKateBranch.indexOf("CairoUniversity");
    final kitKateIndexAtCairoBranch = _cairoKitKateBranch.indexOf("KitKate");

    final List<String> nasserLine = [];
    final List<String> sadatLine = [];
    final List<String> subLine = [];

    // Operations at KitKat Cairo University line for Sadat route
    if (startIndex < cairoIndexAtKitKatCairoUniversityBranch) {
      sadatLine.addAll(_cairoKitKateBranch.sublist(
          startIndex, cairoIndexAtKitKatCairoUniversityBranch + 1));
    } else if (startIndex > cairoIndexAtKitKatCairoUniversityBranch) {
      subLine.addAll(_cairoKitKateBranch
          .sublist(cairoIndexAtKitKatCairoUniversityBranch, startIndex + 1)
          .reversed);
      sadatLine.addAll(subLine);
      subLine.clear();
    }
    _directionForSecondRoute.write("Change Direction at CairoUniversity ");

    // Operations at Line 2 for Sadat route
    final sadatIndexAtLine2 = _metroLine2.indexOf("Sadat");
    final cairoIndexAtLine2 = _metroLine2.indexOf("CairoUniversity");
    if (cairoIndexAtLine2 < sadatIndexAtLine2) {
      sadatLine.addAll(
          _metroLine2.sublist(cairoIndexAtLine2 + 1, sadatIndexAtLine2 + 1));
    } else {
      subLine.addAll(
          _metroLine2.sublist(sadatIndexAtLine2, cairoIndexAtLine2).reversed);
      sadatLine.addAll(subLine);
      subLine.clear();
    }
    _directionForSecondRoute.write(
        "then Take Direction to Shobra El-Kheima and Change Direction at Sadat   ");

    // Operations at Line 1 for Sadat route
    final sadatIndexAtLine1 = _metroLine1.indexOf("Sadat");
    final endIndexAtLine1 = _metroLine1.indexOf(end);
    if (endIndexAtLine1 > sadatIndexAtLine1) {
      sadatLine
          .addAll(_metroLine1.sublist(sadatIndexAtLine1, endIndexAtLine1 + 1));
      _directionForSecondRoute.write("then Take Direction to El-Marg ");
    } else if (endIndexAtLine1 < sadatIndexAtLine1) {
      _directionForSecondRoute.write("then Take Direction to Helwan ");
      subLine.addAll(
          _metroLine1.sublist(endIndexAtLine1, sadatIndexAtLine1 + 1).reversed);
      sadatLine.addAll(subLine);
      subLine.clear();
    }

    // Operations at KitKat Cairo University line for Nasser route
    _directionForFirstRoute.write("Change Direction at KitKate ");
    if (startIndex < kitKateIndexAtCairoBranch) {
      nasserLine.addAll(_cairoKitKateBranch.sublist(
          startIndex, kitKateIndexAtCairoBranch + 1));
    } else if (startIndex > kitKateIndexAtCairoBranch) {
      subLine.addAll(_cairoKitKateBranch
          .sublist(kitKateIndexAtCairoBranch, startIndex + 1)
          .reversed);
      nasserLine.addAll(subLine);
      subLine.clear();
    }

    // Operations at Line 3 for Nasser route
    _directionForFirstRoute.write(
        "then Take Direction to Adly Mansour and Change Direction at Nasser   ");
    final nasserIndexAtLine3 = _metroLine3.indexOf("Nasser");
    final kitKateIndexAtLine3 = _metroLine3.indexOf("KitKate");

    nasserLine.addAll(
        _metroLine3.sublist(kitKateIndexAtLine3 + 1, nasserIndexAtLine3 + 1));

    // Operations at Line 1 for Nasser route
    final nasserIndexAtLine1 = _metroLine1.indexOf("Nasser");

    if (endIndexAtLine1 > nasserIndexAtLine1) {
      _directionForFirstRoute.write("then Take Direction to El-Marg ");
      nasserLine
          .addAll(_metroLine1.sublist(nasserIndexAtLine1, endIndexAtLine1 + 1));
    } else if (endIndexAtLine1 < nasserIndexAtLine1) {
      _directionForFirstRoute.write("then Take Direction to Helwan ");
      subLine.addAll(_metroLine1
          .sublist(endIndexAtLine1, nasserIndexAtLine1 + 1)
          .reversed);
      nasserLine.addAll(subLine);
      subLine.clear();
    }

    _routes.add(nasserLine);
    _routes.add(sadatLine);
  }

  void _searchRoutesFromLine1ToCairoKitKateBranch() {
    int startIndex = _metroLine1.indexOf(start);
    int nasserIndexAtLine1 = _metroLine1.indexOf("Nasser");
    int sadatIndexAtLine1 = _metroLine1.indexOf("Sadat");

    List<String> nasserLine = [];
    List<String> sadatLine = [];
    List<String> subLine = [];

    // Operations at Line 1
    if (startIndex < nasserIndexAtLine1 && startIndex < sadatIndexAtLine1) {
      _directionForFirstRoute.write(
          "Take Direction to El-Marg and Change Direction at Nasser ");
      _directionForSecondRoute
          .write("Take Direction to El-Marg and Change Direction at Sadat ");
      nasserLine.addAll(_metroLine1.sublist(startIndex, nasserIndexAtLine1));
      sadatLine.addAll(_metroLine1.sublist(startIndex, sadatIndexAtLine1));
    } else if (startIndex > nasserIndexAtLine1 &&
        startIndex > sadatIndexAtLine1) {
      _directionForFirstRoute
          .write("Take Direction to Helwan and Change Direction at Nasser ");
      _directionForSecondRoute
          .write("Take Direction to Helwan and Change Direction at Sadat ");
      subLine.addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, startIndex));
      subLine = subLine.reversed.toList();
      sadatLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine1.sublist(nasserIndexAtLine1 + 1, startIndex));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
    } else {
      if (startIndex == nasserIndexAtLine1) {
        _directionForFirstRoute.write("You are At Nasser");
        _directionForSecondRoute.write("You are At Sadat");
      } else {
        _directionForFirstRoute.write("You are At $start");
        nasserLine
            .addAll(_metroLine1.sublist(sadatIndexAtLine1, nasserIndexAtLine1));
        _directionForSecondRoute.write("You are At Sadat");
      }
    }

    // Operations at Line 2 for Sadat route
    int sadatIndexAtLine2 = _metroLine2.indexOf("Sadat");
    int cairoIndexAtLine2 = _metroLine2.indexOf("CairoUniversity");
    _directionForSecondRoute.write(
        "Then Take Direction to EL-Mounib and Change Direction at CairoUniversity ");
    sadatLine.addAll(_metroLine2.sublist(sadatIndexAtLine2, cairoIndexAtLine2));

    // Operations at Cairo KitKate branch for Sadat route
    int endIndexAtCairoKitKateBranch = _cairoKitKateBranch.indexOf(end);
    int cairoIndexAtCairoKitKateBranch =
        _cairoKitKateBranch.indexOf("CairoUniversity");
    subLine.addAll(_cairoKitKateBranch.sublist(
        cairoIndexAtCairoKitKateBranch, cairoIndexAtCairoKitKateBranch + 1));
    subLine = subLine.reversed.toList();
    sadatLine.addAll(subLine);
    subLine.clear();

    // Operations at Line 3 for Nasser route
    _directionForFirstRoute.write(
        "Take Direction to Road El FargCorr and Change Direction at KitKate ");
    int nasserIndexAtLine3 = _metroLine3.indexOf("Nasser");
    int kitKateIndexAtLine3 = _metroLine3.indexOf("KitKate");
    subLine.addAll(
        _metroLine3.sublist(kitKateIndexAtLine3 + 1, nasserIndexAtLine3 + 1));
    subLine = subLine.reversed.toList();
    nasserLine.addAll(subLine);
    subLine.clear();
    int kitKateIndexAtCairoKitKateBranch =
        _cairoKitKateBranch.indexOf("KitKate");

    // Operations at Cairo KitKate branch for Nasser route
    nasserLine.addAll(_cairoKitKateBranch.sublist(
        kitKateIndexAtCairoKitKateBranch, endIndexAtCairoKitKateBranch + 1));

    _routes.add(nasserLine);
    _routes.add(sadatLine);
  }

  void _searchRoutesFromLine1ToLine3() {
    int startIndex = _metroLine1.indexOf(start);
    int nasserIndexAtLine1 = _metroLine1.indexOf("Nasser");
    int sadatIndexAtLine1 = _metroLine1.indexOf("Sadat");
    List<String> nasserLine = [];
    List<String> sadatLine = [];
    List<String> subLine = [];

    // Operations in Line 1
    if (startIndex < nasserIndexAtLine1 && startIndex < sadatIndexAtLine1) {
      _directionForFirstRoute.write(
          "Take Direction to El-Marg and Change Direction at Nasser ");
      _directionForSecondRoute.write(
          "Take Direction to El-Marg and Change Direction at Sadat Then Take Direction to El Mounib And Change Direction at CairoUniversity");
      nasserLine.addAll(_metroLine1.sublist(startIndex, nasserIndexAtLine1));
      sadatLine.addAll(_metroLine1.sublist(startIndex, sadatIndexAtLine1));
    } else if (startIndex > nasserIndexAtLine1 &&
        startIndex > sadatIndexAtLine1) {
      _directionForFirstRoute
          .write("Take Direction to Helwan and Change Direction at Nasser ");
      _directionForSecondRoute.write(
          "Take Direction to Helwan and Change Direction at Sadat Then Take Direction to El Mounib And Change Direction at CairoUniversity");
      subLine.addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, startIndex));
      subLine = subLine.reversed.toList();
      sadatLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine1.sublist(nasserIndexAtLine1 + 1, startIndex));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
    } else {
      // You are at Sadat or Shohadaa
      _directionForFirstRoute.write("You are At Nasser");
      _directionForSecondRoute.write("You are At Sadat");
    }

    // Operations in Line 3
    int sadatIndexAtLine2 = _metroLine2.indexOf("Sadat");
    int cairoIndexAtLine2 = _metroLine2.indexOf("CairoUniversity");
    sadatLine.addAll(_metroLine2.sublist(sadatIndexAtLine2, cairoIndexAtLine2));
    subLine.addAll(_cairoKitKateBranch);
    subLine = subLine.reversed.toList();
    sadatLine.addAll(subLine);
    subLine.clear();

    int endIndex = _metroLine3.indexOf(end);
    int nasserIndexAtLine3 = _metroLine3.indexOf("Nasser");
    int kitKateIndex = _metroLine3.indexOf("KitKate");

    if (endIndex > nasserIndexAtLine3 && endIndex > kitKateIndex) {
      _directionForFirstRoute.write(" And then Take Direction to Adly Mansour");
      _directionForSecondRoute.write(" And then Take Direction to Adly Mansour");
      nasserLine.addAll(_metroLine3.sublist(nasserIndexAtLine3, endIndex + 1));
      sadatLine.addAll(_metroLine3.sublist(kitKateIndex + 1, endIndex + 1));
    } else if (endIndex < nasserIndexAtLine3 && endIndex < kitKateIndex) {
      _directionForFirstRoute
          .write(" And then Take Direction to Road El FargCorr");
      _directionForSecondRoute
          .write(" And then Take Direction to Road El FargCorr");
      subLine.addAll(_metroLine3.sublist(endIndex, nasserIndexAtLine3 + 1));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine3.sublist(endIndex, kitKateIndex));
      subLine = subLine.reversed.toList();
      sadatLine.addAll(subLine);
      subLine.clear();
    } else if (endIndex > kitKateIndex && endIndex < nasserIndexAtLine3) {
      _directionForFirstRoute.write("And then Take Direction to Adly Mansour");
      _directionForSecondRoute
          .write("And then Take Direction to Road El FargCorr");
      nasserLine.addAll(_metroLine3.sublist(endIndex, nasserIndexAtLine3 + 1));
      subLine.addAll(_metroLine3.sublist(kitKateIndex + 1, endIndex + 1));
      subLine = subLine.reversed.toList();
      sadatLine.addAll(subLine);
      subLine.clear();
    } else {
      nasserLine.add("Nasser");
      sadatLine.add("KitKate");
    }

    _routes.add(nasserLine);
    _routes.add(sadatLine);
  }

  void _searchRoutesFromLine3ToLine1() {
    int startIndex = _metroLine3.indexOf(start);
    int nasserIndexAtLine3 = _metroLine3.indexOf("Nasser");
    int kitKateIndex = _metroLine3.indexOf("KitKate");
    List<String> nasserLine = [];
    List<String> kitKateLine = [];
    List<String> subLine = [];
    print('zikokoas${startIndex}');
    print('zikokoas${nasserIndexAtLine3}');
    print('zikokoas${kitKateIndex}');
    // Operations at Line 3
    if (startIndex < nasserIndexAtLine3 && startIndex < kitKateIndex) {
      _directionForFirstRoute.write(
          "Take Direction to Adly Mansour and Change Direction at Nasser ");
      _directionForSecondRoute.write(
          "Take Direction to Adly Mansour and Change Direction at KitKate And Change Direction at CairoUniversity And Take Direction to ShobraEl-Kheima");
      nasserLine.addAll(_metroLine3.sublist(startIndex, nasserIndexAtLine3));
      kitKateLine.addAll(_metroLine3.sublist(startIndex, kitKateIndex));
    } else if (startIndex > nasserIndexAtLine3 && startIndex > kitKateIndex) {
      _directionForFirstRoute.write(
          "Take Direction to Road El FargCorr and Change Direction at Nasser ");
      _directionForSecondRoute.write(
          "Take Direction to Road El FargCorr and Change Direction at KitKate And Change Direction at CairoUniversity And Take Direction to ShobraEl-Kheima");
      subLine.addAll(_metroLine3.sublist(kitKateIndex + 1, startIndex + 1));
      subLine = subLine.reversed.toList();
      kitKateLine.addAll(subLine);
      subLine.clear();
      subLine
          .addAll(_metroLine3.sublist(nasserIndexAtLine3 + 1, startIndex + 1));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
    } else {
      // You are at Nasser or KitKate
      _directionForFirstRoute.write("You are At Nasser");
      _directionForSecondRoute.write("You are At KitKate");
    }

    // Operations at Line 2
    int sadatIndexAtLine2 = _metroLine2.indexOf("Sadat");
    int cairoIndexAtLine2 = _metroLine2.indexOf("CairoUniversity");
    kitKateLine
        .addAll(_metroLine2.sublist(sadatIndexAtLine2, cairoIndexAtLine2));
    subLine.addAll(_cairoKitKateBranch);
    subLine = subLine.reversed.toList();
    kitKateLine.addAll(subLine);
    subLine.clear();

    // Operations at Line 1
    int endIndex = _metroLine1.indexOf(end);
    int nasserIndexAtLine1 = _metroLine1.indexOf("Nasser");
    int sadatIndexAtLine1 = _metroLine1.indexOf("Sadat");
    if (endIndex > nasserIndexAtLine1 && endIndex > sadatIndexAtLine1) {
      _directionForFirstRoute.write("And then Take Direction to El-Marg");
      _directionForSecondRoute.write("And then Take Direction to El-Marg");
      nasserLine.addAll(_metroLine1.sublist(nasserIndexAtLine1, endIndex + 1));
      kitKateLine
          .addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, endIndex + 1));
    } else if (endIndex < nasserIndexAtLine1 && endIndex < sadatIndexAtLine1) {
      _directionForFirstRoute.write("And then Take Direction to Helwan");
      _directionForSecondRoute.write("And then Take Direction to Helwan");
      subLine.addAll(_metroLine1.sublist(endIndex, nasserIndexAtLine1 + 1));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine1.sublist(endIndex, sadatIndexAtLine1));
      subLine = subLine.reversed.toList();
      kitKateLine.addAll(subLine);
      subLine.clear();
    } else {
      nasserLine.add("Nasser");
      kitKateLine.add("KitKate");
    }

    _routes.add(nasserLine);
    _routes.add(kitKateLine);
  }

  void _searchRoutesFromLine2ToLine3() {
    int attabaIndexAtLine2 = _metroLine2.indexOf('Attaba');
    int cairoIndexAtLine2 = _metroLine2.indexOf('CairoUniversity');
    int attabaIndexAtLine3 = _metroLine3.indexOf('Attaba');
    int kitKateIndex = _metroLine3.indexOf('KitKate');
    int startIndex = _metroLine2.indexOf(start);
    int endIndex = _metroLine3.indexOf(end);

    List<String> attabaLine = [];
    List<String> cairoLine = [];
    List<String> subLine = [];

    StringBuffer directionForFirstRoute = StringBuffer();
    StringBuffer directionForSecondRoute = StringBuffer();

    // Operations at line 2
    if (startIndex < attabaIndexAtLine2 && startIndex < cairoIndexAtLine2) {
      directionForFirstRoute.write(
          "Take Direction to El-Mounib and Change Direction at El-Attaba\n");
      directionForSecondRoute.write(
          "Take Direction to El-Mounib and Change Direction at CairoUniversity\nAnd Change Direction at KitKate");
      attabaLine.addAll(_metroLine2.sublist(startIndex, attabaIndexAtLine2));
      cairoLine.addAll(_metroLine2.sublist(startIndex, cairoIndexAtLine2));
      subLine.addAll(_cairoKitKateBranch);
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else if (startIndex > attabaIndexAtLine2 &&
        startIndex > cairoIndexAtLine2) {
      directionForFirstRoute.write(
          "Take Direction to ShobraEl-Kheima and Change Direction at El-Attaba\n");
      directionForSecondRoute.write(
          "Take Direction to ShobraEl-Kheima and Change Direction at CairoUniversity\nAnd Change Direction at KitKate");
      subLine
          .addAll(_metroLine2.sublist(attabaIndexAtLine2 + 1, startIndex + 1));
      subLine = subLine.reversed.toList();
      attabaLine.addAll(subLine);
      subLine.clear();
      subLine
          .addAll(_metroLine2.sublist(cairoIndexAtLine2 + 1, startIndex + 1));
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.addAll(_cairoKitKateBranch);
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else if (startIndex > attabaIndexAtLine2 &&
        startIndex < cairoIndexAtLine2) {
      directionForFirstRoute.write(
          "Take Direction to ShobraEl-Kheima and Change Direction at El-Attaba\n");
      directionForSecondRoute.write(
          "Take Direction to El-Mounib and Change Direction at CairoUniversity\nAnd Change Direction at KitKate");
      subLine
          .addAll(_metroLine2.sublist(attabaIndexAtLine2 + 1, startIndex + 1));
      subLine = subLine.reversed.toList();
      attabaLine.addAll(subLine);
      subLine.clear();
      cairoLine.addAll(_metroLine2.sublist(startIndex, cairoIndexAtLine2));
      subLine.addAll(_cairoKitKateBranch);
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else {
      directionForFirstRoute.write("You are At Attaba");
      directionForSecondRoute.write("You are At CairoUniversity");
    }

    // Operations at line 3
    if (endIndex > attabaIndexAtLine3 && endIndex > kitKateIndex) {
      directionForFirstRoute.write("And then Take Direction to Adly Mansour");
      directionForSecondRoute.write("And then Take Direction to Adly Mansour");
      attabaLine.addAll(_metroLine3.sublist(attabaIndexAtLine3, endIndex + 1));
      cairoLine.addAll(_metroLine3.sublist(kitKateIndex + 1, endIndex + 1));
    } else if (endIndex < attabaIndexAtLine3 && endIndex < kitKateIndex) {
      directionForFirstRoute
          .write("And then Take Direction to Road El FargCorr");
      directionForSecondRoute
          .write("And then Take Direction to Road El FargCorr");
      subLine.addAll(_metroLine3.sublist(endIndex, attabaIndexAtLine3 + 1));
      subLine = subLine.reversed.toList();
      attabaLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine3.sublist(endIndex, kitKateIndex));
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else if (endIndex > kitKateIndex && endIndex < attabaIndexAtLine3) {
      directionForFirstRoute.write("And then Take Direction to Adly Mansour");
      directionForSecondRoute
          .write("And then Take Direction to Road El FargCorr");
      attabaLine.addAll(_metroLine3.sublist(endIndex, attabaIndexAtLine3 + 1));
      subLine.addAll(_metroLine3.sublist(kitKateIndex + 1, endIndex + 1));
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else {
      attabaLine.add("Attaba");
      cairoLine.add("KitKate");
    }

    _routes.add(attabaLine);
    _routes.add(cairoLine);
  }

  void _searchRoutesFromLine3ToLine2() {
    List<String> attabaLine = [];
    List<String> kitKateLine = [];
    List<String> subLine = [];

    StringBuffer directionForFirstRoute = StringBuffer();
    StringBuffer directionForSecondRoute = StringBuffer();

    int startIndex = _metroLine3.indexOf(start);
    int attabaIndexAtLine3 = _metroLine3.indexOf("Attaba");
    int kitKateIndex = _metroLine3.indexOf("KitKate");
    int attabaIndexAtLine2 = _metroLine2.indexOf("Attaba");
    int cairoIndexAtLine2 = _metroLine2.indexOf("CairoUniversity");
    int endIndex = _metroLine2.indexOf(end);

    // Operations at Line 3
    if (startIndex < attabaIndexAtLine3 && startIndex < kitKateIndex) {
      attabaLine
          .addAll(_metroLine3.sublist(startIndex, attabaIndexAtLine3 + 1));
      kitKateLine.addAll(_metroLine3.sublist(startIndex, kitKateIndex + 1));
      directionForFirstRoute.write(
          "Take Direction to Adly Mansour and Change Direction at Attaba \n");
      directionForSecondRoute.write(
          "Take Direction to Adly Mansour and Change Direction at KitKate \n");
    } else if (startIndex > attabaIndexAtLine3 && startIndex > kitKateIndex) {
      attabaLine.addAll(
          _metroLine3.sublist(attabaIndexAtLine3 + 1, startIndex + 1).reversed);
      kitKateLine.addAll(
          _metroLine3.sublist(kitKateIndex + 1, startIndex + 1).reversed);
      directionForFirstRoute.write(
          "Take Direction to Road El FargCorr and Change Direction at Attaba \n");
      directionForSecondRoute.write(
          "Take Direction to Road El FargCorr and Change Direction at KitKate \n");
    } else if (startIndex > kitKateIndex && startIndex < attabaIndexAtLine3) {
      attabaLine
          .addAll(_metroLine3.sublist(startIndex, attabaIndexAtLine3 + 1));
      kitKateLine.addAll(
          _metroLine3.sublist(kitKateIndex + 1, startIndex + 1).reversed);
      directionForFirstRoute.write(
          "Take Direction to Adly Mansour and Change Direction at Attaba \n");
      directionForSecondRoute.write(
          "Take Direction to Road El FargCorr and Change Direction at KitKate \n");
    } else {
      // You are at Attaba or KitKate
      if (startIndex == attabaIndexAtLine3) {
        directionForFirstRoute.write("You are at Attaba ");
        directionForSecondRoute.write(
            "Take Direction to Road El FargCorr and Change Direction at KitKate ");
        subLine.addAll(
            _metroLine3.sublist(kitKateIndex + 1, startIndex + 1).reversed);
        kitKateLine.addAll(subLine);
        subLine.clear();
        kitKateLine.addAll(_cairoKitKateBranch);
      } else {
        directionForFirstRoute.write(
            "Take Direction to Adly Mansour and Change Direction at Attaba ");
        directionForSecondRoute.write(
            "You are at KitKate, Then Change Direction at CairoUniversity\n");
        attabaLine
            .addAll(_metroLine3.sublist(kitKateIndex, attabaIndexAtLine3));
        kitKateLine.addAll(_cairoKitKateBranch);
      }
    }

    // Operations at Line 2
    if (endIndex < attabaIndexAtLine2 && endIndex < cairoIndexAtLine2) {
      subLine.addAll(
          _metroLine2.sublist(endIndex, attabaIndexAtLine2 + 1).reversed);
      attabaLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(
          _metroLine2.sublist(endIndex, cairoIndexAtLine2 + 1).reversed);
      kitKateLine.addAll(subLine);
      subLine.clear();
      directionForFirstRoute
          .write("And Then Take Direction to ShobraEl-Kheima ");
      directionForSecondRoute
          .write("And Then Take Direction to ShobraEl-Kheima ");
    } else if (endIndex > attabaIndexAtLine2 && endIndex > cairoIndexAtLine2) {
      attabaLine.addAll(_metroLine2.sublist(attabaIndexAtLine2, endIndex + 1));
      kitKateLine
          .addAll(_metroLine2.sublist(cairoIndexAtLine2 + 1, endIndex + 1));
      directionForFirstRoute.write("And Then Take Direction to El-Mounib ");
      directionForSecondRoute.write("And Then Take Direction to El-Mounib ");
    } else if (endIndex < cairoIndexAtLine2 && endIndex > attabaIndexAtLine2) {
      subLine.addAll(
          _metroLine2.sublist(endIndex, cairoIndexAtLine2 + 1).reversed);
      kitKateLine.addAll(subLine);
      subLine.clear();
      attabaLine.addAll(_metroLine2.sublist(attabaIndexAtLine2, endIndex + 1));
      directionForFirstRoute
          .write("And Then Take Direction to ShobraEl-Kheima ");
      directionForSecondRoute.write("And Then Take Direction to El-Mounib ");
    } else {
      // You are at Attaba or CairoUniversity
      attabaLine.add("Attaba");
      kitKateLine.add("CairoUniversity");
    }

    _routes.add(attabaLine);
    _routes.add(kitKateLine);
  }

  void _searchRoutesFromLine1ToLine2() {
    List<String> sadatLine = [];
    List<String> shohadaaLine = [];
    List<String> subLine = [];
    StringBuffer directionForFirstRoute = StringBuffer();
    StringBuffer directionForSecondRoute = StringBuffer();

    int startIndex = _metroLine1.indexOf(start);
    int sadatIndexAtLine1 = _metroLine1.indexOf("Sadat");
    int shohadaaIndexAtLine1 = _metroLine1.indexOf("Al-Shohadaa");
    int sadatIndexAtLine2 = _metroLine2.indexOf("Sadat");
    int shohadaaIndexAtLine2 = _metroLine2.indexOf("Al-Shohadaa");
    int endIndex = _metroLine2.indexOf(end);

    // Operations at line 1
    if (startIndex < sadatIndexAtLine1 && startIndex < shohadaaIndexAtLine1) {
      sadatLine.addAll(_metroLine1.sublist(startIndex, sadatIndexAtLine1));
      shohadaaLine
          .addAll(_metroLine1.sublist(startIndex, shohadaaIndexAtLine1));
      directionForFirstRoute.writeln(
          "Take Direction to El-Marg and Change Direction at Sadat");
      directionForSecondRoute.writeln(
          "Take Direction to El-Marg and Change Direction at El-Shohadaa");
    } else if (startIndex > shohadaaIndexAtLine1 &&
        startIndex > sadatIndexAtLine1) {
      sadatLine.addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, startIndex));
      shohadaaLine
          .addAll(_metroLine1.sublist(shohadaaIndexAtLine1 + 1, startIndex));
      sadatLine = sadatLine.reversed.toList();
      shohadaaLine = shohadaaLine.reversed.toList();
      directionForFirstRoute
          .writeln("Take Direction to Helwan and Change Direction at Sadat");
      directionForSecondRoute.writeln(
          "Take Direction to Helwan and Change Direction at El-Shohadaa");
    } else if (startIndex > sadatIndexAtLine1 &&
        startIndex < shohadaaIndexAtLine1) {
      shohadaaLine
          .addAll(_metroLine1.sublist(startIndex, shohadaaIndexAtLine1));
      sadatLine.addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, startIndex));
      sadatLine = sadatLine.reversed.toList();
    } else {
      // You are at Sadat or Shohadaa
      directionForFirstRoute.writeln("You are at Sadat");
      directionForSecondRoute.writeln("You are at Shohadaa");
    }

    // Operations at line 2
    if (endIndex < sadatIndexAtLine2 && endIndex < shohadaaIndexAtLine2) {
      subLine.addAll(_metroLine2.sublist(endIndex, shohadaaIndexAtLine2 + 1));
      shohadaaLine.addAll(subLine.reversed.toList());
      subLine.clear();
      subLine.addAll(_metroLine2.sublist(endIndex, sadatIndexAtLine2 + 1));
      sadatLine.addAll(subLine.reversed.toList());
      subLine.clear();
      directionForFirstRoute
          .writeln("And Then Take Direction to ShobraEl-Kheima");
      directionForSecondRoute
          .writeln("And Then Take Direction to ShobraEl-Kheima");
    } else if (endIndex > sadatIndexAtLine2 &&
        endIndex > shohadaaIndexAtLine2) {
      sadatLine.addAll(_metroLine2.sublist(sadatIndexAtLine2, endIndex + 1));
      shohadaaLine
          .addAll(_metroLine2.sublist(shohadaaIndexAtLine2, endIndex + 1));
      directionForFirstRoute.writeln("And Then Take Direction to El-Mounib");
      directionForSecondRoute.writeln("And Then Take Direction to El-Mounib");
    } else if (endIndex > shohadaaIndexAtLine2 &&
        endIndex < sadatIndexAtLine2) {
      sadatLine.addAll(_metroLine2.sublist(endIndex, sadatIndexAtLine2 + 1));
      subLine.addAll(_metroLine2.sublist(shohadaaIndexAtLine2, endIndex + 1));
      shohadaaLine.addAll(subLine.reversed.toList());
      subLine.clear();
      directionForFirstRoute.writeln("And Then Take Direction to El-Mounib");
      directionForSecondRoute
          .writeln("And Then Take Direction to ShobraEl-Kheima");
    } else {
      // You are at Sadat or Shohadaa
      directionForFirstRoute.writeln("You are at Sadat");
      directionForSecondRoute.writeln("You are at Shohadaa");
      sadatLine.add("Sadat");
      shohadaaLine.add("Al-Shohadaa");
    }

    _routes.add(sadatLine);
    _routes.add(shohadaaLine);
  }

  void _searchRoutesFromLine2ToLine1() {
    List<String> sadatLine = [];
    List<String> shohadaaLine = [];
    List<String> subLine = [];
    _directionForFirstRoute = StringBuffer();
    _directionForSecondRoute = StringBuffer();

    if (_metroLine2.contains(start) && _metroLine1.contains(end)) {
      int startIndex = _metroLine2.indexOf(start);
      int sadatIndexAtLine2 = _metroLine2.indexOf('Sadat');
      int shohadaaIndexAtLine2 = _metroLine2.indexOf('Al-Shohadaa');
      int sadatIndexAtLine1 = _metroLine1.indexOf('Sadat');
      int shohadaaIndexAtLine1 = _metroLine1.indexOf('Al-Shohadaa');
      int endIndex = _metroLine1.indexOf(end);

      // Operations at Line 2
      if (startIndex < sadatIndexAtLine2 && startIndex < shohadaaIndexAtLine2) {
        sadatLine.addAll(_metroLine2.sublist(startIndex, sadatIndexAtLine2));
        shohadaaLine
            .addAll(_metroLine2.sublist(startIndex, shohadaaIndexAtLine2));
        _directionForFirstRoute.write(
            'Take Direction to El-Mounib and Change Direction at Sadat \n');
        _directionForSecondRoute.write(
            'Take Direction to El-Mounib and Change Direction at El-Shohadaa \n');
      } else if (startIndex > sadatIndexAtLine2 &&
          startIndex > shohadaaIndexAtLine2) {
        sadatLine
            .addAll(_metroLine2.sublist(sadatIndexAtLine2 + 1, startIndex + 1));
        shohadaaLine.addAll(
            _metroLine2.sublist(shohadaaIndexAtLine2 + 1, startIndex + 1));
        sadatLine = sadatLine.reversed.toList();
        shohadaaLine = shohadaaLine.reversed.toList();
        _directionForFirstRoute.write(
            'Take Direction to ShobraEl-Kheima and Change Direction at Sadat \n');
        _directionForSecondRoute.write(
            'Take Direction to ShobraEl-Kheima and Change Direction at El-Shohadaa \n');
      } else if (startIndex > shohadaaIndexAtLine2 &&
          startIndex < sadatIndexAtLine2) {
        sadatLine
            .addAll(_metroLine2.sublist(sadatIndexAtLine2 + 1, startIndex + 1));
        shohadaaLine
            .addAll(_metroLine2.sublist(startIndex, shohadaaIndexAtLine2));
        sadatLine = sadatLine.reversed.toList();
      } else {
        _directionForFirstRoute.write('You are At Sadat');
        _directionForSecondRoute.write('You are At Shohadaa');
      }

      // Operations at Line 1
      if (endIndex < sadatIndexAtLine1 && endIndex < shohadaaIndexAtLine1) {
        subLine.addAll(_metroLine1.sublist(endIndex, sadatIndexAtLine1 + 1));
        subLine = subLine.reversed.toList();
        sadatLine.addAll(subLine);
        subLine.clear();
        subLine.addAll(_metroLine1.sublist(endIndex, shohadaaIndexAtLine1 + 1));
        subLine = subLine.reversed.toList();
        shohadaaLine.addAll(subLine);
        subLine.clear();
        _directionForFirstRoute.write('And Then Take Direction to El-Marg ');
        _directionForSecondRoute.write('And Then Take Direction to El-Marg ');
      } else if (endIndex > sadatIndexAtLine1 &&
          endIndex > shohadaaIndexAtLine1) {
        sadatLine.addAll(_metroLine1.sublist(sadatIndexAtLine1, endIndex + 1));
        shohadaaLine
            .addAll(_metroLine1.sublist(shohadaaIndexAtLine1, endIndex + 1));
        _directionForFirstRoute.write('And Then Take Direction to Helwan ');
        _directionForSecondRoute.write('And Then Take Direction to Helwan ');
      } else if (endIndex > shohadaaIndexAtLine1 &&
          endIndex < sadatIndexAtLine1) {
        sadatLine.addAll(_metroLine1.sublist(endIndex, sadatIndexAtLine1 + 1));
        subLine.addAll(_metroLine1.sublist(shohadaaIndexAtLine1, endIndex + 1));
        subLine = subLine.reversed.toList();
        shohadaaLine.addAll(subLine);
        subLine.clear();
        _directionForFirstRoute.write('And Then Take Direction to Helwan ');
        _directionForSecondRoute.write('And Then Take Direction to El-Marg ');
      } else {
        _directionForFirstRoute.write('You are At Sadat');
        _directionForSecondRoute.write('You are At Shohadaa');
        sadatLine.add('Sadat');
        shohadaaLine.add('Al-Shohadaa');
      }

      _routes.add(sadatLine);
      _routes.add(shohadaaLine);
    }
  }
}
