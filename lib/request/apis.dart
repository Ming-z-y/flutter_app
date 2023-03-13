import './httpUtil.dart';

class APIS {
  /// 验证码登录接口
  static Future<String> loginByCode(String phone, String code) async {
    var data =
        await HttpUtil().post('/user/login-nu-code', data: {phone, code});
    return data;
  }

  /// 获取验证码
  static Future<String> getCode(String phone) async {
    var data = await HttpUtil().post('/user/get-code', data: {phone});
    return data;
  }

  /// 密码登录接口
  static Future<String> loginByPassword(String phone, String password) async {
    var data = await HttpUtil()
        .post('/user/login-by-password', data: {phone, password});
    return data;
  }

  /// 用户注册
  static Future<String> register(
      String phone, String code, String password) async {
    var data =
        await HttpUtil().post('/user/register', data: {phone, code, password});
    return data;
  }

  /// 密码重置
  static Future<String> resetPassword(
      String phone, String code, String password) async {
    var data = await HttpUtil()
        .post('/user/reset-password', data: {phone, code, password});
    return data;
  }

  /// 每日一题
  static Future<String> dailyQuestion() async {
    var data = await HttpUtil().get('/daily-question');
    return data;
  }

  /// 热榜
  static Future<String> hot() async {
    var data = await HttpUtil().get('/work/hot');
    return data;
  }

  /// 推荐作品
  static Future<String> workRecommend(
      {int? page_num, int? page_size, String? type}) async {
    var data = await HttpUtil()
        .get('/work?type=$type&page_num=$page_num&page_size=$page_size');
    return data;
  }

  /// 搜索接口
  static Future<String> search(String scope, String key,
      {int? page_num, int? page_size}) async {
    var data = await HttpUtil().get(
        '/search?scope=$scope&key=$key&page_num=$page_num&page_size=$page_size');
    return data;
  }

  /// 获取关注用户最新作品
  static Future<String> getFocusWork({int? user_id}) async {
    var data = await HttpUtil().get('/focus/work?user_id=$user_id');
    return data;
  }

  /// 关注用户
  static Future<String> focusPeople(int user_id) async {
    var data = await HttpUtil().post('/focus', data: {user_id});
    return data;
  }

  /// 获取关注列表
  static Future<String> getFocus({int? page_num, int? page_size}) async {
    var data = await HttpUtil().get('/getFocus');
    return data;
  }

  /// 发表评论
  static Future<String> publishComment(
      String content, int work_id, int to_comment_id) async {
    var data = await HttpUtil()
        .post('/publish-comment', data: {content, work_id, to_comment_id});
    return data;
  }

  /// 获取评论
  static Future<String> getComment(int rank_type, int work_id) async {
    var data = await HttpUtil()
        .post('/getComment?rank_type=$rank_type', data: {work_id});
    return data;
  }

  /// 点赞
  static Future<String> like(int scope, String id) async {
    var data = await HttpUtil().post('/like?scope=$scope', data: {id});
    return data;
  }

  /// 收藏作品
  static Future<String> collection(int work_id) async {
    var data = await HttpUtil().post('/collection', data: {work_id});
    return data;
  }

  /// 获取自身用户信息
  static Future<String> getSelfInfo() async {
    var data = await HttpUtil().get('/user/self');
    return data;
  }

  /// 获取自身用户创作作品
  static Future<String> getSelfWork() async {
    var data = await HttpUtil().get('/user/self/work');
    return data;
  }

  /// 获取自身用户收藏作品
  static Future<String> getSelfCollection() async {
    var data = await HttpUtil().get('/user/self/collection');
    return data;
  }

  /// 获取自身用户点赞作品
  static Future<String> getSelfLike() async {
    var data = await HttpUtil().get('/user/self/like');
    return data;
  }

  /// 获取其他用户信息
  static Future<String> getOtherInfo(int user_id) async {
    var data = await HttpUtil().post('/user/other', data: {user_id});
    return data;
  }

  /// 获取其他用户作品
  static Future<String> getOtherWork(int user_id,
      {int? page_size, int? page_num}) async {
    var data = await HttpUtil().post(
        '/user/other/work?page_size=$page_size&page_num=$page_num',
        data: {user_id});
    return data;
  }

  /// 获取其他用户收藏作品
  static Future<String> getOtherCollection(int user_id,
      {int? page_size, int? page_num}) async {
    var data = await HttpUtil().post(
        '/user/other/collection?page_size=$page_size&page_num=$page_num',
        data: {user_id});
    return data;
  }

  /// 获取其他用户点赞作品
  static Future<String> getOtherLike(int user_id,
      {int? page_size, int? page_num}) async {
    var data = await HttpUtil().post(
        '/user/other/like?page_size=$page_size&page_num=$page_num',
        data: {user_id});
    return data;
  }

  /// 发布作品
  static Future<String> publicWork(
      int scope, String type, String title, String imge_url, String content_url,
      {String? outlined}) async {
    var data = await HttpUtil().post('/work?scope=$scope',
        data: {scope, type, title, imge_url, content_url, outlined});
    return data;
  }

  ///
}
