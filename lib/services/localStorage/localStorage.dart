import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static init() async {
    await GetStorage.init();
  }

  static writeString({required String key, required String value}) {
    final GetStorage getStorage = GetStorage();
    getStorage.write(key, value);
  }

  static String readString({required String key}) {
    final GetStorage getStorage = GetStorage();
    String value = getStorage.read(key);

    return value;
  }

  // static saveJson({required  key, required String value}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var res = prefs.setString("$key", value);
  //   return res;
  // }
  //
  // static readJson({required  key}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String res = prefs.getString("$key")!;
  //   return res;
  // }

}

class LocalStorageKeys {

  ///Generic Keys
  // static String userID = 'userID';
  static String accessToken = 'accessToken';
  // static String otpToken = 'otpToken';
  // static String patientsList = 'patientsList';
  // static String doctorsList = 'doctorsList';
  //
  // ///Doctor Keys
  // static String conHmisId = 'conHmisId';
  // static String conCode = 'conCode';
  // static String conName = 'conName';
  // static String conMedSurg = 'conMedSurg';
  //
  // ///Patient Keys
  // static String patientMrNo = 'mrNo';
  // static String patientName = 'patientName';
  // static String patientDob = 'patientDob';
}