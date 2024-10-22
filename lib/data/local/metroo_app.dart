import 'package:metroappinflutter/helper/extentions.dart';
import 'package:metroappinflutter/ui/screen/history_screen/history_page.dart';

import 'cario_lines.dart';
import 'package:get/get.dart';

class MetroApp {
  // Define your metro lines here
  late final List<String> _metroLine1;
  late final List<String> _metroLine2;
  late final List<String> _metroLine3;
  late final List<String> _cairoKitKateBranch;
  List<List<String>> _routes;
  StringBuffer _directionForFirstRoute;
  StringBuffer _directionForSecondRoute;
  String _direction; // For single route
  String start, end;
  String transtionStation1;
  List<String> transList1;
  List<String> transList2;
  final String currentLanguage;

  // variable for translate
  String andChangeDirectionAt = 'and_change_direction_at'.tr;
  String changeDirectionTo = 'change_direction_to'.tr;
  String takeDirectionTo = 'take_direction_to'.tr;
  String thenTakeDirectionTo = 'then_take_direction_to'.tr;
  String youAreAt = 'you_are_at'.tr;
  String sadat = 'sadat'.tr;
  String nasser = 'nasser'.tr;
  String cairoUniversity = 'cairo_university'.tr;
  String elmounib = 'el_mounib'.tr;
  String attaba = 'attaba'.tr;
  String shobraElKheima = 'shobra_el_kheima'.tr;
  String shohada = 'al_shohadaa'.tr;
  String elMarg = 'el_marg'.tr;
  String helwan = 'helwan'.tr;
  String kitkat = 'kitkat'.tr;
  String adlyMansour = 'adly_mansour'.tr;
  String roadElFargCorr = 'road_el_farg_corr'.tr;

  MetroApp(this.start, this.end)
      : currentLanguage = Get.locale!.languageCode,
        _routes = [],
        transList1 = [],
        transList2 = [],
        _directionForFirstRoute = StringBuffer(),
        _directionForSecondRoute = StringBuffer(),
        _direction = '',
        transtionStation1 = "" {
    // Initialize metro lines based on the current language
    _metroLine1 = CairoLines.cairoLine1(); // English metro line 1

    _metroLine2 = CairoLines.cairoLine2(); // English metro line 2

    _metroLine3 = CairoLines.cairoLine3(); // English metro line 3

    _cairoKitKateBranch = CairoLines.kitKatCairoUniversityLine;
  }

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
    print(start);
    print(end);
    print(line.length);
    int startIndex = line.indexOf(start);
    int endIndex = line.indexOf(end);
    List<String> subListPath;

    if (startIndex < endIndex) {
      subListPath = line.sublist(startIndex, endIndex + 1);
      _direction = "${'take_direction_to'.tr} ${line.last}";
    } else {
      _direction = "${'take_direction_to'.tr} ${line.first}";
      subListPath = line.sublist(endIndex, startIndex + 1);
      subListPath = subListPath.reversed.toList();
    }
    print(subListPath.length);
    return subListPath;
  }

  void _searchInManyLines() {
    if (_metroLine1.contains(start) && _metroLine2.contains(end)) {
      _searchRoutesFromLine1ToLine2();
    }
    else if (_metroLine2.contains(start) && _metroLine1.contains(end)) {
      _searchRoutesFromLine2ToLine1();
    }
    else if (_metroLine2.contains(start) && _metroLine3.contains(end)) {
      _searchRoutesFromLine2ToLine3();
    }
    else if (_metroLine3.contains(start) && _metroLine2.contains(end)) {
      _searchRoutesFromLine3ToLine2();
    }
    else if (_metroLine1.contains(start) && _metroLine3.contains(end)) {
      _searchRoutesFromLine1ToLine3();
    }
    else if (_metroLine3.contains(start) && _metroLine1.contains(end)) {
      _searchRoutesFromLine3ToLine1();
    }
    else if (_metroLine1.contains(start) &&
        _cairoKitKateBranch.contains(end)) {
      _searchRoutesFromLine1ToCairoKitKateBranch();
    }
    else if (_cairoKitKateBranch.contains(start) &&
        _metroLine1.contains(end)) {
      _searchRoutesFromCairoKitKateBranchToLine1();
    }
    else if (_metroLine2.contains(start) &&
        _cairoKitKateBranch.contains(end)) {
      _searchRoutesFromLine2ToCairoKitKateBranch();
    }
    else if (_cairoKitKateBranch.contains(start) &&
        _metroLine2.contains(end)) {
      _searchRoutesFromCairoKitKateBranchToLine2();
    }
    else if(_metroLine3.contains(start)&&_cairoKitKateBranch.contains(end)
    ||_metroLine3.contains(start)&&_cairoKitKateBranch.contains(end)
    ){
      _searchRoutesFromLine3ToCairoKitKateBranch();
    }else if(_metroLine3.contains(end)&&_cairoKitKateBranch.contains(start)
    ){
      _searchRoutesFromLine3ToCairoKitKateBranch();
    }
  }

  void _searchRoutesFromLine3ToCairoKitKateBranch(){

    List<String> combinedLine=[];
     List<String>reversedLine3=_metroLine3.reversed.toList();
    int kikateIndex=reversedLine3.indexOf(kitkat);
    combinedLine.addAll(reversedLine3.sublist(0,kikateIndex));
    combinedLine.addAll(_cairoKitKateBranch);
    print(combinedLine);
    _routes.add(_getSingleRoute(combinedLine, start, end));
  }
  void _searchRoutesFromCairoKitKateBranchToLine2() {
    final startIndex = _cairoKitKateBranch.indexOf(start);
    final endIndex = _metroLine2.indexOf(end);
    final attabaIndexAtLine2 = _metroLine2.indexOf('attaba'.tr);
    final cairoIndexAtLine2 = _metroLine2.indexOf('cairo_university'.tr);
    final kitKateIndexAtCairoBranch = _cairoKitKateBranch.indexOf('kitkat'.tr);
    final cairoUniversityIndexAtCairoBranch =
        _cairoKitKateBranch.indexOf('cairo_university'.tr);
    final attabaIndexAtLine3 = _metroLine3.indexOf('attaba'.tr);
    final kitKateIndexAtLine3 = _metroLine3.indexOf('kitkat'.tr);
    final List<String> attabaLine = [];
    final List<String> cairoLine = [];
    List<String> subLine = [];

    // Option 1: Change at Attaba
    _directionForFirstRoute
        .write('${'change_direction_to'.tr}  ${'kitkat'.tr} ');
    transList1.add('kitkat'.tr);
    subLine = _cairoKitKateBranch
        .sublist(kitKateIndexAtCairoBranch, startIndex + 1)
        .reversed
        .toList();
    attabaLine.addAll(subLine);
    subLine.clear();

    attabaLine.addAll(
        _metroLine3.sublist(kitKateIndexAtLine3 + 1, attabaIndexAtLine3));
    _directionForFirstRoute.write(
        '${'then_take_direction_to'.tr} ${'adly_mansour'.tr} ${'and_change_direction_at'.tr} ${'attaba'.tr} ');
    transList1.add('attaba'.tr);
    if (endIndex < attabaIndexAtLine2) {
      _directionForFirstRoute
          .write('${'then_take_direction_to'.tr} ${'shobra_el_kheima'.tr} ');
      subLine = _metroLine2
          .sublist(endIndex, attabaIndexAtLine2 + 1)
          .reversed
          .toList();
      attabaLine.addAll(subLine);
      subLine.clear();
    } else {
      _directionForFirstRoute
          .write('${'then_take_direction_to'.tr} ${'el_mounib'.tr} ');
      attabaLine.addAll(_metroLine2.sublist(attabaIndexAtLine2, endIndex + 1));
    }

    // Option 2: Change at Cairo University
    _directionForSecondRoute
        .write('${'change_direction_to'.tr} ${'cairo_university'.tr} ');
    transList2.add('cairo_university'.tr);
    cairoLine.addAll(_cairoKitKateBranch.sublist(
        startIndex, cairoUniversityIndexAtCairoBranch + 1));
    if (endIndex < cairoIndexAtLine2) {
      _directionForSecondRoute
          .write('${'then_take_direction_to'.tr} ${'shobra_el_kheima'.tr} ');

      subLine =
          _metroLine2.sublist(endIndex, cairoIndexAtLine2).reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else {
      _directionForSecondRoute
          .write('${'then_take_direction_to'.tr} ${'el_mounib'.tr} ');
      cairoLine
          .addAll(_metroLine2.sublist(cairoIndexAtLine2 + 1, endIndex + 1));
    }

    _routes.add(attabaLine);
    _routes.add(cairoLine);
  }

  void _searchRoutesFromLine2ToCairoKitKateBranch() {
    final startIndex = _metroLine2.indexOf(start);
    final endIndex = _cairoKitKateBranch.indexOf(end);
    final attabaIndexAtLine2 = _metroLine2.indexOf('attaba'.tr);
    final cairoIndexAtLine2 = _metroLine2.indexOf('cairo_university'.tr);
    final List<String> attabaLine = [];
    final List<String> cairoLine = [];
    List<String> subLine = [];

    // Operations on Line 2
    if (startIndex > attabaIndexAtLine2 && startIndex > cairoIndexAtLine2) {
      _directionForFirstRoute.write(
          '${'take_direction_to'.tr} ${'shobra_el_kheima'.tr} ${'and_change_direction_at'.tr} ${'attaba'.tr} ');
      transList1.add('attaba'.tr);
      _directionForSecondRoute.write(
          '${'take_direction_to'.tr} ${'shobra_el_kheima'.tr} ${'and_change_direction_at'.tr} ${'cairo_university'.tr} ');
      transList2.add('cairo_university'.tr);
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
          '${'take_direction'.tr} ${'el_mounib'.tr} ${'and_change_direction_at'.tr} ${'attaba'.tr} ');
      transList1.add('attaba'.tr);
      _directionForSecondRoute.write(
          '${'take_direction'.tr} ${'el_mounib'.tr} ${'and_change_direction_at'.tr} ${'cairo_university'.tr}');
      transList2.add('cairo_university'.tr);
      attabaLine.addAll(_metroLine2.sublist(startIndex, attabaIndexAtLine2));
      cairoLine.addAll(_metroLine2.sublist(startIndex, cairoIndexAtLine2));
    } else if (startIndex > attabaIndexAtLine2 &&
        startIndex < cairoIndexAtLine2) {
      _directionForFirstRoute.write(
          '${'take_direction'.tr} ${'shobra_el_kheima'.tr} ${'and_change_direction_at'.tr} ${'attaba'.tr} ');
      transList2.add('attaba'.tr);
      _directionForSecondRoute.write(
          '${'take_direction'.tr} ${'el_mounib'.tr} ${'and_change_direction_at'.tr} ${'cairo_university'.tr}');
      transList2.add('cairo_university'.tr);
      subLine = _metroLine2
          .sublist(attabaIndexAtLine2 + 1, startIndex)
          .reversed
          .toList();
      attabaLine.addAll(subLine);
      subLine.clear();
      cairoLine.addAll(_metroLine2.sublist(startIndex, cairoIndexAtLine2));
    } else {
      _directionForFirstRoute.write('${'you_are_at'.tr} ${'attaba'.tr}');
      _directionForSecondRoute
          .write('${'you_are_at'.tr} ${'cairo_university'.tr}');
    }

    // Operations on Line 3 with Attaba line
    _directionForFirstRoute.write(
        '${'then_take_direction_to'.tr} ${'road_el_farg_corr'.tr}$andChangeDirectionAt $kitkat ');
    transList2.add('kitkate'.tr);

    final attabaIndexAtLine3 = _metroLine3.indexOf(attaba);
    final kitKateIndexAtLine3 = _metroLine3.indexOf(kitkat);
    final kitKateIndexAtCairoBranch = _cairoKitKateBranch.indexOf(kitkat);
    final cairoIndexAtCairoBranch =
        _cairoKitKateBranch.indexOf(cairoUniversity);
    subLine = _metroLine3
        .sublist(kitKateIndexAtLine3 + 1, attabaIndexAtLine3 + 1)
        .reversed
        .toList();
    attabaLine.addAll(subLine);
    subLine.clear();
    attabaLine.addAll(
        _cairoKitKateBranch.sublist(kitKateIndexAtCairoBranch, endIndex + 1));

    // Operations on Cairo Branch with Cairo line
    _directionForSecondRoute.write('$thenTakeDirectionTo $kitkat ');
    subLine = _cairoKitKateBranch
        .sublist(endIndex, cairoIndexAtCairoBranch + 1)
        .reversed
        .toList();
    cairoLine.addAll(subLine);
    subLine.clear();

    _routes.add(attabaLine);
    _routes.add(cairoLine);
  }

  ///trans by chat
  void _searchRoutesFromCairoKitKateBranchToLine1() {
    final startIndex = _cairoKitKateBranch.indexOf(start);
    final cairoIndexAtKitKatCairoUniversityBranch =
        _cairoKitKateBranch.indexOf(cairoUniversity);
    final kitKateIndexAtCairoBranch = _cairoKitKateBranch.indexOf(kitkat);

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
    _directionForSecondRoute
        .write('${'and_change_direction_at'.tr} ${'cairo_university'.tr} ');
    transList2.add(cairoUniversity);

    // Operations at Line 2 for Sadat route
    final sadatIndexAtLine2 = _metroLine2.indexOf('sadat'.tr);
    final cairoIndexAtLine2 = _metroLine2.indexOf('cairo_university'.tr);
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
        '${'then_take_direction_to'.tr} ${'shobra_el_kheima'.tr} ${'and_change_direction_at'.tr} ${'sadat'.tr} ');
    transList2.add(sadat);

    // Operations at Line 1 for Sadat route
    final sadatIndexAtLine1 = _metroLine1.indexOf(sadat);
    final endIndexAtLine1 = _metroLine1.indexOf(end);
    if (endIndexAtLine1 > sadatIndexAtLine1) {
      sadatLine
          .addAll(_metroLine1.sublist(sadatIndexAtLine1, endIndexAtLine1 + 1));
      _directionForSecondRoute
          .write('${'then_take_direction_to'.tr} ${'el_marg'.tr} ');
    } else if (endIndexAtLine1 < sadatIndexAtLine1) {
      _directionForSecondRoute
          .write('${'then_take_direction_to'.tr} ${'helwan'.tr} ');
      subLine.addAll(
          _metroLine1.sublist(endIndexAtLine1, sadatIndexAtLine1 + 1).reversed);
      sadatLine.addAll(subLine);
      subLine.clear();
    }

    // Operations at KitKat Cairo University line for Nasser route
    _directionForFirstRoute.write('$andChangeDirectionAt $kitkat ');
    transList1.add(kitkat);
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
        '${'then_take_direction_to'.tr} ${'adly_mansour'.tr} ${'and_change_direction_at'.tr} $nasser ');
    transList1.add(nasser);
    final nasserIndexAtLine3 = _metroLine3.indexOf(nasser);
    final kitKateIndexAtLine3 = _metroLine3.indexOf(kitkat);

    nasserLine.addAll(
        _metroLine3.sublist(kitKateIndexAtLine3 + 1, nasserIndexAtLine3 + 1));

    // Operations at Line 1 for Nasser route
    final nasserIndexAtLine1 = _metroLine1.indexOf(nasser);

    if (endIndexAtLine1 > nasserIndexAtLine1) {
      _directionForFirstRoute
          .write('${'then_take_direction_to'.tr} ${'el_marg'.tr} ');
      nasserLine
          .addAll(_metroLine1.sublist(nasserIndexAtLine1, endIndexAtLine1 + 1));
    } else if (endIndexAtLine1 < nasserIndexAtLine1) {
      _directionForFirstRoute
          .write('${'then_take_direction_to'.tr} ${'helwan'.tr} ');
      subLine.addAll(_metroLine1
          .sublist(endIndexAtLine1, nasserIndexAtLine1 + 1)
          .reversed);
      nasserLine.addAll(subLine);
      subLine.clear();
    }

    _routes.add(nasserLine);
    _routes.add(sadatLine);
  }

  ///trans by chat
  void _searchRoutesFromLine1ToCairoKitKateBranch() {
    int startIndex = _metroLine1.indexOf(start);
    int nasserIndexAtLine1 = _metroLine1.indexOf(nasser);
    int sadatIndexAtLine1 = _metroLine1.indexOf(sadat);

    List<String> nasserLine = [];
    List<String> sadatLine = [];
    List<String> subLine = [];

    // Operations at Line 1
    if (startIndex < nasserIndexAtLine1 && startIndex < sadatIndexAtLine1) {
      _directionForFirstRoute.write(
          '${'take_direction_to'.tr} ${'el_marg'.tr} ${'and_change_direction_at'.tr} $nasser ');
      transList1.add(nasser);
      _directionForSecondRoute.write(
          '${'take_direction_to'.tr} ${'el_marg'.tr} ${'and_change_direction_at'.tr} $sadat ');
      transList2.add(sadat);
      nasserLine.addAll(_metroLine1.sublist(startIndex, nasserIndexAtLine1));
      sadatLine.addAll(_metroLine1.sublist(startIndex, sadatIndexAtLine1));
    } else if (startIndex > nasserIndexAtLine1 &&
        startIndex > sadatIndexAtLine1) {
      _directionForFirstRoute.write(
          '${'take_direction_to'.tr} ${'helwan'.tr} ${'and_change_direction_at'.tr} $nasser ');
      transList1.add(nasser);
      _directionForSecondRoute.write(
          '${'take_direction_to'.tr} ${'helwan'.tr} ${'and_change_direction_at'.tr} $sadat ');
      transList2.add(sadat);
      subLine.addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, startIndex));
      subLine = subLine.reversed.toList();
      sadatLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine1.sublist(nasserIndexAtLine1 + 1, startIndex));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
    } else {
      if (startIndex == nasserIndexAtLine1) {
        _directionForFirstRoute.write('${'you_are_at'.tr} $nasser');
        _directionForSecondRoute.write('${'you_are_at'.tr} $sadat');
      } else {
        _directionForFirstRoute.write('${'you_are_at'.tr} $start');
        nasserLine
            .addAll(_metroLine1.sublist(sadatIndexAtLine1, nasserIndexAtLine1));
        _directionForSecondRoute.write('${'you_are_at'.tr} $sadat');
      }
    }

    // Operations at Line 2 for Sadat route
    int sadatIndexAtLine2 = _metroLine2.indexOf(sadat);
    int cairoIndexAtLine2 = _metroLine2.indexOf(cairoUniversity);
    _directionForSecondRoute.write(
        '${'then_take_direction_to'.tr} ${'el_mounib'.tr} ${'and_change_direction_at'.tr} $cairoUniversity');
    transList2.add(cairoUniversity);
    sadatLine.addAll(_metroLine2.sublist(sadatIndexAtLine2, cairoIndexAtLine2));

    // Operations at Cairo KitKate branch for Sadat route
    int endIndexAtCairoKitKateBranch = _cairoKitKateBranch.indexOf(end);
    int cairoIndexAtCairoKitKateBranch =
        _cairoKitKateBranch.indexOf(cairoUniversity);
    subLine.addAll(_cairoKitKateBranch.sublist(
        cairoIndexAtCairoKitKateBranch, cairoIndexAtCairoKitKateBranch + 1));
    subLine = subLine.reversed.toList();
    sadatLine.addAll(subLine);
    subLine.clear();

    // Operations at Line 3 for Nasser route
    _directionForFirstRoute.write(
        '${'take_direction_to'.tr} ${'road_el_farg_corr'.tr} ${'and_change_direction_at'.tr} ${kitkat} ');
    transList1.add(kitkat);
    int nasserIndexAtLine3 = _metroLine3.indexOf(nasser);
    int kitKateIndexAtLine3 = _metroLine3.indexOf(kitkat);
    subLine.addAll(
        _metroLine3.sublist(kitKateIndexAtLine3 + 1, nasserIndexAtLine3 + 1));
    subLine = subLine.reversed.toList();
    nasserLine.addAll(subLine);
    subLine.clear();
    int kitKateIndexAtCairoKitKateBranch = _cairoKitKateBranch.indexOf(kitkat);

    // Operations at Cairo KitKate branch for Nasser route
    nasserLine.addAll(_cairoKitKateBranch.sublist(
        kitKateIndexAtCairoKitKateBranch, endIndexAtCairoKitKateBranch + 1));

    _routes.add(nasserLine);
    _routes.add(sadatLine);
  }

  ///trans by me
  void _searchRoutesFromLine1ToLine3() {
    int startIndex = _metroLine1.indexOf(start);
    int nasserIndexAtLine1 = _metroLine1.indexOf(nasser);
    int sadatIndexAtLine1 = _metroLine1.indexOf(sadat);
    List<String> nasserLine = [];
    List<String> sadatLine = [];
    List<String> subLine = [];
    transList1.addAll([
      nasser,
    ]);
    transList2.addAll([sadat, cairoUniversity]);

    // Operations in Line 1
    if (startIndex < nasserIndexAtLine1 && startIndex < sadatIndexAtLine1) {
      _directionForFirstRoute.write(
          "${'take_direction_to'.tr} ${elMarg}${'and_change_direction_at'.tr} ${nasser} ");
      _directionForSecondRoute.write(
          "${'take_direction_to'.tr} ${elMarg}${'and_change_direction_at'.tr} ${sadat} "
          "${'then_take_direction_to'.tr} ${'el_mounib'.tr} ${'and_change_direction_at'.tr} ${'cairo_university'.tr}");
      nasserLine.addAll(_metroLine1.sublist(startIndex, nasserIndexAtLine1));
      sadatLine.addAll(_metroLine1.sublist(startIndex, sadatIndexAtLine1));
    } else if (startIndex > nasserIndexAtLine1 &&
        startIndex > sadatIndexAtLine1) {
      _directionForFirstRoute
          .write("$takeDirectionTo $helwan $andChangeDirectionAt $nasser ");
      _directionForSecondRoute.write(
          "$takeDirectionTo $helwan $andChangeDirectionAt $sadat $thenTakeDirectionTo $elmounib $andChangeDirectionAt $cairoUniversity");
      subLine.addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, startIndex));
      subLine = subLine.reversed.toList();
      sadatLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine1.sublist(nasserIndexAtLine1 + 1, startIndex));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
    } else {
      // You are at Sadat or Shohadaa
      _directionForFirstRoute.write("$youAreAt $nasser");
      _directionForSecondRoute.write("$youAreAt $sadat");
    }

    // Operations in Line 3
    int sadatIndexAtLine2 = _metroLine2.indexOf(sadat);
    int cairoIndexAtLine2 = _metroLine2.indexOf(cairoUniversity);
    sadatLine.addAll(_metroLine2.sublist(sadatIndexAtLine2, cairoIndexAtLine2));
    subLine.addAll(_cairoKitKateBranch);
    subLine = subLine.reversed.toList();
    sadatLine.addAll(subLine);
    subLine.clear();

    int endIndex = _metroLine3.indexOf(end);
    int nasserIndexAtLine3 = _metroLine3.indexOf(nasser);
    int kitKateIndex = _metroLine3.indexOf(kitkat);

    if (endIndex > nasserIndexAtLine3 && endIndex > kitKateIndex) {
      _directionForFirstRoute.write(" $takeDirectionTo $adlyMansour");
      _directionForSecondRoute.write(" $takeDirectionTo $adlyMansour");
      nasserLine.addAll(_metroLine3.sublist(nasserIndexAtLine3, endIndex + 1));
      sadatLine.addAll(_metroLine3.sublist(kitKateIndex + 1, endIndex + 1));
    } else if (endIndex < nasserIndexAtLine3 && endIndex < kitKateIndex) {
      _directionForFirstRoute.write("$takeDirectionTo $roadElFargCorr");
      _directionForSecondRoute.write("$takeDirectionTo $roadElFargCorr");
      subLine.addAll(_metroLine3.sublist(endIndex, nasserIndexAtLine3 + 1));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine3.sublist(endIndex, kitKateIndex));
      subLine = subLine.reversed.toList();
      sadatLine.addAll(subLine);
      subLine.clear();
    } else if (endIndex > kitKateIndex && endIndex < nasserIndexAtLine3) {
      _directionForFirstRoute.write("$takeDirectionTo $adlyMansour");
      _directionForSecondRoute.write("$takeDirectionTo $roadElFargCorr");
      nasserLine.addAll(_metroLine3.sublist(endIndex, nasserIndexAtLine3 + 1));
      subLine.addAll(_metroLine3.sublist(kitKateIndex + 1, endIndex + 1));
      subLine = subLine.reversed.toList();
      sadatLine.addAll(subLine);
      subLine.clear();
    } else {
      nasserLine.add(nasser);
      sadatLine.add(kitkat);
    }

    _routes.add(nasserLine);
    _routes.add(sadatLine);
  }

  void _searchRoutesFromLine3ToLine1() {
    int startIndex = _metroLine3.indexOf(start);
    int nasserIndexAtLine3 = _metroLine3.indexOf(nasser);
    int kitKateIndex = _metroLine3.indexOf(kitkat);
    List<String> nasserLine = [];
    List<String> kitKateLine = [];
    List<String> subLine = [];
    // Operations at Line 3
    if (startIndex < nasserIndexAtLine3 && startIndex < kitKateIndex) {
      _directionForFirstRoute
          .write("$takeDirectionTo $adlyMansour $andChangeDirectionAt $nasser");
      transList1.add(nasser);
      _directionForSecondRoute.write(
          "$takeDirectionTo $adlyMansour $andChangeDirectionAt $kitkat $andChangeDirectionAt $cairoUniversity $takeDirectionTo $shobraElKheima");
      transList2.add(kitkat);
      transList2.add(cairoUniversity);
      nasserLine.addAll(_metroLine3.sublist(startIndex, nasserIndexAtLine3));
      kitKateLine.addAll(_metroLine3.sublist(startIndex, kitKateIndex));
    } else if (startIndex > nasserIndexAtLine3 && startIndex > kitKateIndex) {
      _directionForFirstRoute.write(
          "$takeDirectionTo $roadElFargCorr $andChangeDirectionAt $nasser ");
      transList1.add(nasser);
      _directionForSecondRoute.write(
          "$takeDirectionTo $roadElFargCorr $andChangeDirectionAt $kitkat $andChangeDirectionAt $cairoUniversity $takeDirectionTo $shobraElKheima");
      transList2.add(kitkat);
      transList2.add(cairoUniversity);
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
      _directionForFirstRoute.write("$youAreAt $nasser");
      _directionForSecondRoute.write("$youAreAt $kitkat");
    }

    // Operations at Line 2
    int sadatIndexAtLine2 = _metroLine2.indexOf(sadat);
    int cairoIndexAtLine2 = _metroLine2.indexOf(cairoUniversity);
    kitKateLine
        .addAll(_metroLine2.sublist(sadatIndexAtLine2, cairoIndexAtLine2));
    subLine.addAll(_cairoKitKateBranch);
    subLine = subLine.reversed.toList();
    kitKateLine.addAll(subLine);
    subLine.clear();

    // Operations at Line 1
    int endIndex = _metroLine1.indexOf(end);
    int nasserIndexAtLine1 = _metroLine1.indexOf(nasser);
    int sadatIndexAtLine1 = _metroLine1.indexOf(sadat);
    if (endIndex > nasserIndexAtLine1 && endIndex > sadatIndexAtLine1) {
      _directionForFirstRoute.write("$thenTakeDirectionTo $elMarg");
      _directionForSecondRoute.write("$thenTakeDirectionTo $elMarg");
      nasserLine.addAll(_metroLine1.sublist(nasserIndexAtLine1, endIndex + 1));
      kitKateLine
          .addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, endIndex + 1));
    } else if (endIndex < nasserIndexAtLine1 && endIndex < sadatIndexAtLine1) {
      _directionForFirstRoute.write("$thenTakeDirectionTo $helwan");
      _directionForSecondRoute.write("$thenTakeDirectionTo $helwan");
      subLine.addAll(_metroLine1.sublist(endIndex, nasserIndexAtLine1 + 1));
      subLine = subLine.reversed.toList();
      nasserLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine1.sublist(endIndex, sadatIndexAtLine1));
      subLine = subLine.reversed.toList();
      kitKateLine.addAll(subLine);
      subLine.clear();
    } else {
      nasserLine.add(nasser);
      kitKateLine.add(kitkat);
    }

    _routes.add(nasserLine);
    _routes.add(kitKateLine);
  }

  /// by chat
  void _searchRoutesFromLine2ToLine3() {
    int attabaIndexAtLine2 = _metroLine2.indexOf(attaba);
    int cairoIndexAtLine2 = _metroLine2.indexOf(cairoUniversity);
    int attabaIndexAtLine3 = _metroLine3.indexOf(attaba);
    int kitKateIndex = _metroLine3.indexOf(kitkat);
    int startIndex = _metroLine2.indexOf(start);
    int endIndex = _metroLine3.indexOf(end);

    List<String> attabaLine = [];
    List<String> cairoLine = [];
    List<String> subLine = [];
    transList1.addAll([attaba]);
    transList2.addAll([cairoUniversity, kitkat]);

    // Operations at line 2
    if (startIndex < attabaIndexAtLine2 && startIndex < cairoIndexAtLine2) {
      _directionForFirstRoute
          .write("$takeDirectionTo $elmounib $andChangeDirectionAt $attaba\n");
      _directionForSecondRoute.write(
          "$takeDirectionTo $elmounib $andChangeDirectionAt $cairoUniversity\n$andChangeDirectionAt $kitkat");
      attabaLine.addAll(_metroLine2.sublist(startIndex, attabaIndexAtLine2));
      cairoLine.addAll(_metroLine2.sublist(startIndex, cairoIndexAtLine2));
      subLine.addAll(_cairoKitKateBranch);
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else if (startIndex > attabaIndexAtLine2 &&
        startIndex > cairoIndexAtLine2) {
      _directionForFirstRoute.write(
          "$takeDirectionTo $shobraElKheima $andChangeDirectionAt $attaba\n");
      _directionForSecondRoute.write(
          "$takeDirectionTo $shobraElKheima $andChangeDirectionAt $cairoUniversity\n$andChangeDirectionAt $kitkat");
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
      _directionForFirstRoute.write(
          "$takeDirectionTo $shobraElKheima $andChangeDirectionAt $attaba\n");
      _directionForSecondRoute.write(
          "$takeDirectionTo $elmounib $andChangeDirectionAt $cairoUniversity\n$andChangeDirectionAt $kitkat");
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
      _directionForFirstRoute.write("$youAreAt $attaba");
      _directionForSecondRoute.write("$youAreAt $cairoUniversity");
    }

    // Operations at line 3
    if (endIndex > attabaIndexAtLine3 && endIndex > kitKateIndex) {
      _directionForFirstRoute.write("$thenTakeDirectionTo $adlyMansour");
      _directionForSecondRoute.write("$thenTakeDirectionTo $adlyMansour");
      attabaLine.addAll(_metroLine3.sublist(attabaIndexAtLine3, endIndex + 1));
      cairoLine.addAll(_metroLine3.sublist(kitKateIndex + 1, endIndex + 1));
    } else if (endIndex < attabaIndexAtLine3 && endIndex < kitKateIndex) {
      _directionForFirstRoute.write("$thenTakeDirectionTo $roadElFargCorr");
      _directionForSecondRoute.write("$thenTakeDirectionTo $roadElFargCorr");
      subLine.addAll(_metroLine3.sublist(endIndex, attabaIndexAtLine3 + 1));
      subLine = subLine.reversed.toList();
      attabaLine.addAll(subLine);
      subLine.clear();
      subLine.addAll(_metroLine3.sublist(endIndex, kitKateIndex));
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else if (endIndex > kitKateIndex && endIndex < attabaIndexAtLine3) {
      _directionForFirstRoute.write("$thenTakeDirectionTo $adlyMansour");
      _directionForSecondRoute.write("$thenTakeDirectionTo ${roadElFargCorr}");
      attabaLine.addAll(_metroLine3.sublist(endIndex, attabaIndexAtLine3 + 1));
      subLine.addAll(_metroLine3.sublist(kitKateIndex + 1, endIndex + 1));
      subLine = subLine.reversed.toList();
      cairoLine.addAll(subLine);
      subLine.clear();
    } else {
      attabaLine.add(attaba);
      cairoLine.add(kitkat);
    }

    _routes.add(attabaLine);
    _routes.add(cairoLine);
  }

  /// by chat
  void _searchRoutesFromLine3ToLine2() {
    List<String> attabaLine = [];
    List<String> kitKateLine = [];
    List<String> subLine = [];

    int startIndex = _metroLine3.indexOf(start);
    int attabaIndexAtLine3 = _metroLine3.indexOf(attaba);
    int kitKateIndex = _metroLine3.indexOf(kitkat);
    int kitKateIndexAtCairoBrance = _cairoKitKateBranch.indexOf(kitkat);
    int attabaIndexAtLine2 = _metroLine2.indexOf(attaba);
    int cairoIndexAtLine2 = _metroLine2.indexOf(cairoUniversity);
    int cairoIndexatCairoBranch = _cairoKitKateBranch.indexOf(cairoUniversity);
    int endIndex = _metroLine2.indexOf(end);
    transList1.addAll([attaba]);
    transList2.addAll([cairoUniversity, kitkat]);
    // Operations at Line 3
    if (startIndex < attabaIndexAtLine3 && startIndex < kitKateIndex) {
      attabaLine
          .addAll(_metroLine3.sublist(startIndex, attabaIndexAtLine3 + 1));
      kitKateLine.addAll(_metroLine3.sublist(startIndex, kitKateIndex + 1));


      _directionForFirstRoute.write(
          "$takeDirectionTo $adlyMansour $andChangeDirectionAt $attaba \n");
      _directionForSecondRoute.write(
          "$takeDirectionTo $adlyMansour $andChangeDirectionAt $kitkat \n");
    } else if (startIndex > attabaIndexAtLine3 && startIndex > kitKateIndex) {
      attabaLine.addAll(
          _metroLine3.sublist(attabaIndexAtLine3 + 1, startIndex + 1).reversed);
      kitKateLine.addAll(
          _metroLine3.sublist(kitKateIndex + 1, startIndex + 1).reversed);
        kitKateLine.addAll(_cairoKitKateBranch.sublist(kitKateIndexAtCairoBrance,cairoIndexatCairoBranch));
      _directionForFirstRoute.write(
          "$takeDirectionTo $roadElFargCorr $andChangeDirectionAt $attaba \n");
      _directionForSecondRoute.write(
          "$takeDirectionTo $roadElFargCorr $andChangeDirectionAt $kitkat \n");
    }
    else if (startIndex > kitKateIndex && startIndex < attabaIndexAtLine3) {
      attabaLine
          .addAll(_metroLine3.sublist(startIndex, attabaIndexAtLine3));
      kitKateLine.addAll(
          _metroLine3.sublist(kitKateIndex + 1, startIndex + 1).reversed);
      kitKateLine.addAll(_cairoKitKateBranch.sublist(kitKateIndexAtCairoBrance,cairoIndexatCairoBranch));
      _directionForFirstRoute.write(
          "$takeDirectionTo $adlyMansour $andChangeDirectionAt $attaba \n");
      _directionForSecondRoute.write(
          "$takeDirectionTo $roadElFargCorr $andChangeDirectionAt $kitkat \n");
    }
    else {
      // You are at Attaba or KitKate
      if (startIndex == attabaIndexAtLine3) {
        _directionForFirstRoute.write("$youAreAt $attaba ");
        _directionForSecondRoute.write(
            "$takeDirectionTo $roadElFargCorr $andChangeDirectionAt $kitkat ");
        subLine.addAll(
            _metroLine3.sublist(kitKateIndex + 1, startIndex + 1).reversed);
        kitKateLine.addAll(subLine);
        subLine.clear();
        kitKateLine.addAll(_cairoKitKateBranch);
      } else {
        _directionForFirstRoute.write(
            "$takeDirectionTo $adlyMansour $andChangeDirectionAt $attaba ");
        _directionForSecondRoute.write(
            "$youAreAt $kitkat, Then $andChangeDirectionAt $cairoUniversity\n");
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
      _directionForFirstRoute.write("$thenTakeDirectionTo $shobraElKheima ");
      _directionForSecondRoute.write("$thenTakeDirectionTo $shobraElKheima ");
    }
    else if (endIndex > attabaIndexAtLine2 && endIndex > cairoIndexAtLine2) {
      attabaLine.addAll(_metroLine2.sublist(attabaIndexAtLine2, endIndex + 1));
      kitKateLine
          .addAll(_metroLine2.sublist(cairoIndexAtLine2 + 1, endIndex + 1));
      _directionForFirstRoute.write("$thenTakeDirectionTo $elmounib ");
      _directionForSecondRoute.write("$thenTakeDirectionTo $elmounib ");
    }
    else if (endIndex < cairoIndexAtLine2 && endIndex > attabaIndexAtLine2) {
      subLine.addAll(
          _metroLine2.sublist(endIndex, cairoIndexAtLine2 + 1).reversed);
      kitKateLine.addAll(subLine);
      subLine.clear();
      attabaLine.addAll(_metroLine2.sublist(attabaIndexAtLine2, endIndex + 1));
      _directionForFirstRoute.write("$thenTakeDirectionTo $shobraElKheima ");
      _directionForSecondRoute.write("$thenTakeDirectionTo $elmounib ");
    }
    else {
      // You are at Attaba or CairoUniversity
      attabaLine.add(attaba);
      kitKateLine.add(cairoUniversity);
    }

    _routes.add(attabaLine);
    _routes.add(kitKateLine);
  }

  /// by chat  /////////////////////////
  void _searchRoutesFromLine1ToLine2() {
    print('_searchRoutesFromLine1ToLine2');
    List<String> sadatLine = [];
    List<String> shohadaaLine = [];
    List<String> subLine = [];


    int startIndex = _metroLine1.indexOf(start);
    int sadatIndexAtLine1 = _metroLine1.indexOf(sadat);
    int shohadaaIndexAtLine1 = _metroLine1
        .indexOf(shohada); // Assuming this was meant to relate to Shohadaa
    int sadatIndexAtLine2 = _metroLine2.indexOf(sadat);
    int shohadaaIndexAtLine2 = _metroLine2
        .indexOf(shohada); // Assuming this was meant to relate to Shohadaa
    int endIndex = _metroLine2.indexOf(end);
    transList1.addAll([sadat]);
    transList2.addAll([shohada]);
    // Operations at line 1
    if (startIndex < sadatIndexAtLine1 && startIndex < shohadaaIndexAtLine1) {
      sadatLine.addAll(_metroLine1.sublist(startIndex, sadatIndexAtLine1));
      shohadaaLine
          .addAll(_metroLine1.sublist(startIndex, shohadaaIndexAtLine1));
      _directionForFirstRoute
          .writeln("$takeDirectionTo $elMarg $andChangeDirectionAt $sadat");
      _directionForSecondRoute
          .writeln("$takeDirectionTo $elMarg $andChangeDirectionAt $shohada");
    } else if (startIndex > shohadaaIndexAtLine1 &&
        startIndex > sadatIndexAtLine1) {
      sadatLine.addAll(_metroLine1.sublist(sadatIndexAtLine1 + 1, startIndex));
      shohadaaLine
          .addAll(_metroLine1.sublist(shohadaaIndexAtLine1 + 1, startIndex));
      sadatLine = sadatLine.reversed.toList();
      shohadaaLine = shohadaaLine.reversed.toList();
      _directionForFirstRoute
          .writeln("$takeDirectionTo $helwan $andChangeDirectionAt $sadat");
      _directionForSecondRoute
          .writeln("$takeDirectionTo $helwan $andChangeDirectionAt $shohada");
    } else if (startIndex > sadatIndexAtLine1 &&
        startIndex < shohadaaIndexAtLine1) {
      _directionForFirstRoute
          .writeln("$takeDirectionTo $helwan $andChangeDirectionAt $sadat");
      _directionForSecondRoute
          .writeln("$takeDirectionTo $helwan $andChangeDirectionAt $shohada");
      shohadaaLine
          .addAll(_metroLine1.sublist(startIndex, shohadaaIndexAtLine1));
      sadatLine.addAll(_metroLine1.sublist(sadatIndexAtLine1 +1, startIndex+1));
      sadatLine = sadatLine.reversed.toList();
    } else {
      // You are at Sadat or Shohadaa
      _directionForFirstRoute.writeln("$youAreAt $sadat");
      _directionForSecondRoute.writeln("$youAreAt $shohada");
    }

    // Operations at line 2
    if (endIndex < sadatIndexAtLine2 && endIndex < shohadaaIndexAtLine2) {
      subLine.addAll(_metroLine2.sublist(endIndex, shohadaaIndexAtLine2 + 1));
      shohadaaLine.addAll(subLine.reversed.toList());
      subLine.clear();
      subLine.addAll(_metroLine2.sublist(endIndex, sadatIndexAtLine2 + 1));
      sadatLine.addAll(subLine.reversed.toList());
      subLine.clear();
      _directionForFirstRoute.writeln("$thenTakeDirectionTo $shobraElKheima");
      _directionForSecondRoute.writeln("$thenTakeDirectionTo $shobraElKheima");
    } else if (endIndex > sadatIndexAtLine2 &&
        endIndex > shohadaaIndexAtLine2) {
      sadatLine.addAll(_metroLine2.sublist(sadatIndexAtLine2, endIndex + 1));
      shohadaaLine
          .addAll(_metroLine2.sublist(shohadaaIndexAtLine2, endIndex + 1));
      _directionForFirstRoute.writeln("$thenTakeDirectionTo $elmounib");
      _directionForSecondRoute.writeln("$thenTakeDirectionTo $elmounib");
    } else if (endIndex > shohadaaIndexAtLine2 &&
        endIndex < sadatIndexAtLine2) {
      sadatLine.addAll(_metroLine2.sublist(endIndex, sadatIndexAtLine2 + 1));
      subLine.addAll(_metroLine2.sublist(shohadaaIndexAtLine2, endIndex + 1));
      shohadaaLine.addAll(subLine.reversed.toList());
      subLine.clear();
      _directionForFirstRoute.writeln("$thenTakeDirectionTo $elmounib");
      _directionForSecondRoute.writeln("$thenTakeDirectionTo $shobraElKheima");
    } else {
      // You are at Sadat or Shohadaa
      _directionForFirstRoute.writeln("$youAreAt $sadat");
      _directionForSecondRoute.writeln("$youAreAt $shobraElKheima");
      sadatLine.add(sadat);
      shohadaaLine.add(shobraElKheima);
    }

    _routes.add(sadatLine);
    _routes.add(shohadaaLine);
  }

  ///bychat
  void _searchRoutesFromLine2ToLine1() {
    List<String> sadatLine = [];
    List<String> shohadaaLine = [];
    List<String> subLine = [];

    transList1.addAll([sadat]);
    transList2.addAll([shohada]);
    if (_metroLine2.contains(start) && _metroLine1.contains(end)) {
      int startIndex = _metroLine2.indexOf(start);
      int sadatIndexAtLine2 = _metroLine2.indexOf(sadat);
      int shohadaaIndexAtLine2 =
          _metroLine2.indexOf(shohada); // Assuming this relates to Shohadaa
      int sadatIndexAtLine1 = _metroLine1.indexOf(sadat);
      int shohadaaIndexAtLine1 =
          _metroLine1.indexOf(shohada); // Assuming this relates to Shohadaa
      int endIndex = _metroLine1.indexOf(end);

      // Operations at Line 2
      if (startIndex < sadatIndexAtLine2 && startIndex < shohadaaIndexAtLine2) {
        sadatLine.addAll(_metroLine2.sublist(startIndex, sadatIndexAtLine2));
        shohadaaLine
            .addAll(_metroLine2.sublist(startIndex, shohadaaIndexAtLine2));
        _directionForFirstRoute.write(
            "$takeDirectionTo $elmounib $andChangeDirectionAt $sadat \n");
        _directionForSecondRoute.write(
            "$takeDirectionTo $elmounib $andChangeDirectionAt $shohada \n");
      } else if (startIndex > sadatIndexAtLine2 &&
          startIndex > shohadaaIndexAtLine2) {
        sadatLine
            .addAll(_metroLine2.sublist(sadatIndexAtLine2 + 1, startIndex + 1));
        shohadaaLine.addAll(
            _metroLine2.sublist(shohadaaIndexAtLine2 + 1, startIndex + 1));
        sadatLine = sadatLine.reversed.toList();
        shohadaaLine = shohadaaLine.reversed.toList();
        _directionForFirstRoute.write(
            "$takeDirectionTo $shobraElKheima $andChangeDirectionAt $sadat \n");
        _directionForSecondRoute.write(
            "$takeDirectionTo $shobraElKheima $andChangeDirectionAt $shohada \n");
      } else if (startIndex > shohadaaIndexAtLine2 &&
          startIndex < sadatIndexAtLine2) {
        sadatLine
            .addAll(_metroLine2.sublist(sadatIndexAtLine2 + 1, startIndex + 1));
        shohadaaLine
            .addAll(_metroLine2.sublist(startIndex, shohadaaIndexAtLine2));
        sadatLine = sadatLine.reversed.toList();
      } else {
        _directionForFirstRoute.write("$youAreAt $sadat");
        _directionForSecondRoute.write("$youAreAt $shohada");
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
        _directionForFirstRoute.write("$thenTakeDirectionTo $elMarg ");
        _directionForSecondRoute.write("$thenTakeDirectionTo $elMarg ");
      } else if (endIndex > sadatIndexAtLine1 &&
          endIndex > shohadaaIndexAtLine1) {
        sadatLine.addAll(_metroLine1.sublist(sadatIndexAtLine1, endIndex + 1));
        shohadaaLine
            .addAll(_metroLine1.sublist(shohadaaIndexAtLine1, endIndex + 1));
        _directionForFirstRoute.write("$thenTakeDirectionTo $helwan ");
        _directionForSecondRoute.write("$thenTakeDirectionTo $helwan ");
      } else if (endIndex > shohadaaIndexAtLine1 &&
          endIndex < sadatIndexAtLine1) {
        sadatLine.addAll(_metroLine1.sublist(endIndex, sadatIndexAtLine1 + 1));
        subLine.addAll(_metroLine1.sublist(shohadaaIndexAtLine1, endIndex + 1));
        subLine = subLine.reversed.toList();
        shohadaaLine.addAll(subLine);
        subLine.clear();
        _directionForFirstRoute.write("$thenTakeDirectionTo $helwan ");
        _directionForSecondRoute.write("$thenTakeDirectionTo $elMarg ");
      } else {
        _directionForFirstRoute.write("$youAreAt $sadat");
        _directionForSecondRoute.write("$youAreAt $shohada");
        sadatLine.add(sadat);
        shohadaaLine.add(shobraElKheima);
      }

      _routes.add(sadatLine);
      _routes.add(shohadaaLine);
    }
  }
}

