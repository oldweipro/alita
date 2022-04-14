import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class AlitaCache {
  SharedPreferences? prefs;

  AlitaCache._() {
    init();
  }

  static AlitaCache? _instance;

  AlitaCache._pre(this.prefs);

  ///预初始化，防止在使用get时，prefs还未完成初始化
  static Future<AlitaCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = AlitaCache._pre(prefs);
    }
    return _instance!;
  }

  static AlitaCache getInstance() {
    _instance ??= AlitaCache._();
    return _instance!;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
}
