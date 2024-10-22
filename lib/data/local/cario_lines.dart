import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:get/get.dart';
class CairoLines {
  static List<String> cairoLine1() {
    List<String> metroLine1 = [
      "helwan".tr,
      "ain_helwan".tr,
      "helwan_university".tr,
      "wadi_hof".tr,
      "hadayek_helwan".tr,
      "el_maasara".tr,
      "tora_el_asmant".tr,
      "kozzika".tr,
      "tora_el_balad".tr,
      "sakanat_el_maadi".tr,
      "maadi".tr,
      "hadayek_el_maadi".tr,
      "dar_el_salam".tr,
      "el_zahraa".tr,
      "mar_girgis".tr,
      "el_malek_el_saleh".tr,
      "al_sayeda_zeinab".tr,
      "saad_zaghloul".tr,
      "sadat".tr,
      "nasser".tr,
      "orabi".tr,
      "al_shohadaa".tr,
      "ghamra".tr,
      "el_demerdash".tr,
      "manshiet_el_sadr".tr,
      "kobri_el_qobba".tr,
      "hammamat_el_qobba".tr,
      "saray_el_qobba".tr,
      "hadayeq_el_zaitoun".tr,
      "helmeyet_el_zaitoun".tr,
      "el_matareyya".tr,
      "ain_shams".tr,
      "ezbet_el_nakhl".tr,
      "el_marg".tr,
      "new_el_marg".tr,
    ];
    return metroLine1;
  }



  static List<String> cairoLine2() {
    List<String> metroLine2 = [
      "shobra_el_kheima".tr,
      "kolleyyet_el_zeraa".tr,
      "mezallat".tr,
      "khalafawy".tr,
      "st_teresa".tr,
      "rod_el_farag".tr,
      "massara".tr,
      "al_shohadaa".tr,
      "attaba".tr,
      "mohamed_naguib".tr,
      "sadat".tr,
      "opera".tr,
      "dokki".tr,
      "bohooth".tr,
      "cairo_university".tr,
      "faisal".tr,
      "giza".tr,
      "omm_el_masryeen".tr,
      "sakiat_mekki".tr,
      "el_mounib".tr,
    ];
    return metroLine2;
  }



  static List<String> cairoLine3() {
    List<String> metroLine3 = [
      "road_el_farg_corr".tr,
      "ring_road".tr,
      "el_qumia".tr,
      "el_bohy".tr,
      "imbaba".tr,
      "sudan".tr,
      "kitkat".tr,
      "safay_hegazy".tr,
      "maspero".tr,
      "nasser".tr,
      "attaba".tr,
      "bab_el_shaaria".tr,
      "el_geish".tr,
      "abdou_pasha".tr,
      "abbasia".tr,
      "cairo_fair".tr,
      "stadium".tr,
      "kolleyet_el_banat".tr,
      "al_ahram".tr,
      "haroun".tr,
      "heliopolis".tr,
      "alf_maskan".tr,
      "nadi_el_shams".tr,
      "al_nozha".tr,
      "hesham_barkat".tr,
      "qubaa".tr,
      "omar_ebn_el_khattab".tr,
      "el_hayikstep".tr,
      "adly_mansour".tr,
    ];
    return metroLine3;
  }



  static List<String> kitKatCairoUniversityLine = [
    "kitkat".tr,
    "tawfikia".tr,
    "wadi_elnail".tr,
    "gamate_ldawel".tr,
    "bolaq_eldakror".tr,
    "cairo_university".tr,
  ];


  static Map<String,String> transitionStation = {
    "Sadat":"Transition With Line 1 and Line 2",
    "Nasser":"Transition With Line 1 and Line 3",
    "Attaba":"Transition With Line 2 and Line 3",
    "Al-Shohadaa":"Transition With Line 1 and Line 2",
    "CairoUniversity":"Transition With CairoUniversity Branch and Line 3",
    "KitKate":"Transition With CairoUniversity Branch and Line 2"
  };
  static Map<String, String> transitionStationAr = {
    "السادات": "محطة تبادلية مع الخط الأول والخط الثاني",
    "ناصر": "محطة تبادلية مع الخط الأول والخط الثالث",
    "العتبه": "محطة تبادلية مع الخط الثاني والخط الثالث",
    "الشهداء": "محطة تبادلية مع الخط الأول والخط الثاني",
    "جامعة القاهرة": "محطة تبادلية مع فرع جامعة القاهرة والخط الثالث",
    "الكيت كات": "محطة تبادلية مع فرع جامعة القاهرة والخط الثاني"
  };
  static List<SelectedListItem> allCairoLines = [
    ...cairoLine1().map((station) => SelectedListItem(name: station)),
    ...cairoLine2().map((station) => SelectedListItem(name: station)),
    ...cairoLine3().map((station) => SelectedListItem(name: station)),
    ...kitKatCairoUniversityLine.map((station) => SelectedListItem(name: station))
  ];



  }
