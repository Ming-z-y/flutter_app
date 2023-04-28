import 'package:shared_preferences/shared_preferences.dart';

/// 缓存里的值的键名, 格式因人因项目而异，我这里取得比较简单
class CacheKey {
  /// token
  static const String TOKEN =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo3LCJpc3MiOiJjb2xkIGJpbiIsInN1YiI6InNtYWEgYXBwIiwiYXVkIjpbInNtYWEgYXBwIl0sImV4cCI6MTY4MTc5NjU1NSwibmJmIjoxNjgxNzg5MzU1LCJpYXQiOjE2ODE3ODkzNTV9.Kxne50kW954Yxc8ibQYl7-L4mWvCp4FuJ-SEyFLEdnc';

  /// refresh_token
  static const String REFRESH_TOKEN =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjo3LCJpc3MiOiJjb2xkIGJpbiIsImV4cCI6MTY4MTgzNDc4MCwibmJmIjoxNjgxMjI5OTgwLCJpYXQiOjE2ODEyMjk5ODB9.C8-F4SGEz5ujB-yn152Zh9wrrNzHgeyS1k1oALGNr-A';

  /// phone
  static const String PHONE = 'app_phone';

  /// username
  static const String USERNAME = "username";

  /// description
  static const String DESCRIPTION = "暂无个人简介";

  /// address
  static const String ADDRESS = "重庆";

  /// school
  static const SCHOOL = "重庆邮电大学";

  /// height
  static const HEIGHT = "未设置";

  /// weight
  static const WEIGHT = "未设置";
}

class AppCache {
  final SharedPreferences sharedPreferences;

  AppCache._({required this.sharedPreferences});

  factory AppCache.create({
    required SharedPreferences sharedPreferences,
  }) =>
      AppCache._(
        sharedPreferences: sharedPreferences,
      );

  ///  缓存类采取单例模式
  static AppCache? _instance;

  /// 一定要在main里面初始化
  static Future<void> init() async {
    _instance ??= AppCache.create(
      sharedPreferences: await SharedPreferences.getInstance(),
    );
  }

  /// 简化获取工具类的缓存实例，以便在下方封装一些方法
  static SharedPreferences get _pre => _instance!.sharedPreferences;

  ///  封装设置token的方法
  static Future<bool> setToken(String token) async {
    return await _pre.setString(CacheKey.TOKEN, token);
  }

  ///  封装设置refresh_token的方法
  static Future<bool> setRefreshToken(String token) async {
    return await _pre.setString(CacheKey.REFRESH_TOKEN, token);
  }

  ///  封装设置username的方法
  static Future<bool> setUsername(String username) async {
    return await _pre.setString(CacheKey.USERNAME, username);
  }

  ///  封装设置description的方法
  static Future<bool> setDescription(String des) async {
    return await _pre.setString(CacheKey.DESCRIPTION, des);
  }

  ///  封装设置 address 的方法
  static Future<bool> setAddress(String address) async {
    return await _pre.setString(CacheKey.ADDRESS, address);
  }

  ///  封装设置 school 的方法
  static Future<bool> setSchool(String school) async {
    return await _pre.setString(CacheKey.SCHOOL, school);
  }

  ///  封装设置 height 的方法
  static Future<bool> setHeight(String height) async {
    return await _pre.setString(CacheKey.HEIGHT, height);
  }

  ///  封装设置 weight 的方法
  static Future<bool> setWeight(String weight) async {
    return await _pre.setString(CacheKey.WEIGHT, weight);
  }

  /// 封装清除token的方法
  static Future<bool> cleanToken() async {
    return await _pre.setString(CacheKey.TOKEN, '');
  }

  ///  封装获取token的方法
  static String? get token => _pre.getString(CacheKey.TOKEN);

  ///  封装获取refresh_token的方法
  static String? get refresh_token => _pre.getString(CacheKey.REFRESH_TOKEN);

  ///  封装设置phone的方法
  static Future<bool> setPhone(String phone) async {
    return _pre.setString(CacheKey.PHONE, phone);
  }

  ///  封装清除phone的方法
  static Future<bool> cleanPhone() async {
    return await _pre.setString(CacheKey.PHONE, '');
  }

  ///  封装获取phone的方法
  static String? get phone => _pre.getString(CacheKey.PHONE);

  /// 获取 username
  static String? get username => _pre.getString(CacheKey.USERNAME);

  /// 获取 description
  static String? get description => _pre.getString(CacheKey.DESCRIPTION);

  /// 获取 address
  static String? get address => _pre.getString(CacheKey.ADDRESS);

  /// 获取 school
  static String? get school => _pre.getString(CacheKey.SCHOOL);

  /// 获取 height
  static String? get height => _pre.getString(CacheKey.HEIGHT);

  /// 获取 weight
  static String? get weight => _pre.getString(CacheKey.WEIGHT);
}
