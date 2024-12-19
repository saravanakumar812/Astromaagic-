import 'package:get_storage/get_storage.dart';

class AppPreference {
  static const STORAGE_NAME = 'Astrolomagic';
  final _storage = GetStorage(STORAGE_NAME);

  Future<void> init() async {
    await _storage.initStorage;
  }

  static const lang = 'language';
  static const country = 'Country';
  static const tokenValues = 'TOKEN';
  static const loginUser_Id = 'USERID';
  static const remeady_Id = 'Reameady_id';
  static const mobNumber = 'MOBILE';
  static const USERNAME = 'USERNAME';


  updateMobileNumber(String mobileNumber) {
    _storage.write(mobNumber, mobileNumber);
  }

  String get getMobileNumber {
    try {
      return _storage.read(mobNumber);
    } catch (e) {
      return '';
    }
  }
  updateUserName(String data) {
    _storage.write(USERNAME, data);
  }

  String get getUserName {
    try {
      return _storage.read(USERNAME);
    } catch (e) {
      return '';
    }
  }
  updateLang(String language) {
    _storage.write(lang, language);
  }

  String get getLanguage {
    try {
      return _storage.read(lang);
    } catch (e) {
      return '';
    }
  }

  updateCountry(String countries) {
    _storage.write(country, countries);
  }

  String get getCountry {
    try {
      return _storage.read(country);
    } catch (e) {
      return '';
    }
  }

  updateToken(String token) {
    _storage.write(tokenValues, token);
  }

  String get getToken {
    try {
      return _storage.read(tokenValues);
    } catch (e) {
      return '';
    }
  }

  updateLoginUserId(String loginUserId) {
    _storage.write(loginUser_Id, loginUserId);
  }

  String get getLoginUserId {
    try {
      return _storage.read(loginUser_Id);
    } catch (e) {
      return '';
    }
  }
  updateReamedyId(String remeadyId) {
    _storage.write(remeady_Id, remeadyId);
  }

  String get getReameadyId {
    try {
      return _storage.read(remeady_Id);
    } catch (e) {
      return '';
    }
  }

  clearData() {
    _storage.erase();
  }
}


