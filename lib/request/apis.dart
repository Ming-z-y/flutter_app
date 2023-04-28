import './httpUtil.dart';

class ResponseModal<T> {
  late final int status;
  late final String info;
  late T? data;

  ResponseModal.fromjson(Map<String, dynamic> json) {
    status = json["status"] as int;
    info = json["info"] as String;
    if (json["data"] != null) {
      data = json["data"];
    }
  }
}

class APIS {
  /// 验证码登录接口
  static Future<ResponseModal<Map<String, dynamic>>> loginByCode(
      String phone, String code) async {
    var data = await HttpUtil()
        .post('/user/login-by-code', data: {"phone": phone, "code": code});
    return ResponseModal.fromjson(data);
  }

  /// 获取验证码
  static Future<Map<String, dynamic>> getCode(String phone) async {
    var data = await HttpUtil().post('/user/get-code', data: {"phone": phone});
    // print(data);
    return data;
  }

  /// 密码登录接口
  static Future<ResponseModal<Map<String, dynamic>>> loginByPassword(
      String phone, String password) async {
    var data = await HttpUtil().post('/user/login-by-password',
        data: {"phone": phone, "password": password});
    return ResponseModal.fromjson(data);
  }

  /// 用户注册
  static Future<ResponseModal<Map<String, dynamic>>> register(
      String phone, String code, String password, String nick_name) async {
    var data = await HttpUtil().post('/user/register', data: {
      "phone": phone,
      "code": code,
      "password": password,
      "nick_name": nick_name
    });
    return ResponseModal.fromjson(data);
  }

  /// 密码重置
  static Future<ResponseModal<Map<String, dynamic>>> resetPassword(
      String phone, String code, String password) async {
    var data = await HttpUtil().post('/user/reset-password',
        data: {"phone": phone, "code": code, "password": password});
    return ResponseModal.fromjson(data);
  }

  /// 每日一题
  static Future<String> dailyQuestion() async {
    var data = await HttpUtil().get('/daily-question');
    return data;
  }

  /// 热榜
  static Future<ResponseModal<List<dynamic>>> hot() async {
    var data = await HttpUtil().get('/work/hot');
    return ResponseModal.fromjson(data);
  }

  /// 推荐作品
  static Future<ResponseModal<Map<String, dynamic>>> workRecommend(
      int page_num, int page_size,
      {String? type, int? cursor = 0}) async {
    var data;
    if (type == null) {
      data = await HttpUtil()
          .get('/work?page_num=$page_num&page_size=$page_size&cursor=$cursor');
    } else {
      data = await HttpUtil().get(
          '/work?type=$type&page_num=$page_num&page_size=$page_size&cursor=$cursor');
    }

    return ResponseModal.fromjson(data);
  }

  /// 搜索接口
  static Future<ResponseModal<List<dynamic>>> search(
      {int? page_num,
      int? page_size,
      required int scope,
      required String key}) async {
    var data = await HttpUtil().get('/search?scope=$scope&key=$key');
    return ResponseModal.fromjson(data);
  }

  /// 获取关注用户最新作品
  static Future<ResponseModal<dynamic>> getFocusWork(
      {int? user_id, int? cursor}) async {
    var data;
    if (user_id == null) {
      data = await HttpUtil().get('/focus/work?cursor=$cursor');
    } else if (cursor == null) {
      data = await HttpUtil().get('/focus/work?user_id=$user_id');
    } else {
      data =
          await HttpUtil().get('/focus/work?user_id=$user_id&cursor=$cursor');
    }
    return ResponseModal.fromjson(data);
  }

  /// 关注用户
  static Future<ResponseModal<Map<String, dynamic>>> focusPeople(
      {required int user_id, required bool need_focus}) async {
    var data = await HttpUtil()
        .post('/focus', data: {"user_id": user_id, "need_focus": need_focus});
    return ResponseModal.fromjson(data);
  }

  /// 获取关注列表
  static Future<ResponseModal<dynamic>> getFocus(int cursor,
      {int? page_num, int? page_size}) async {
    var data = await HttpUtil().get('/get-focus');
    return ResponseModal.fromjson(data);
  }

  /// 发表评论
  static Future<ResponseModal<dynamic>> publishComment({
    required String content,
    required int work_id,
    required int worker_id,
    required int to_user_id,
    required int to_comment_id,
  }) async {
    var data = await HttpUtil().post('/publish-comment', data: {
      "content": content,
      "work_id": work_id,
      "to_comment_id": to_comment_id,
      "worker_id": worker_id,
      "to_user_id": to_user_id
    });
    return ResponseModal.fromjson(data);
  }

  /// 获取评论
  static Future<ResponseModal<List<dynamic>>> getComment(
      {required int rank_type, required int work_id}) async {
    var data = await HttpUtil()
        .post('/get-comment?rank_type=$rank_type', data: {"work_id": work_id});
    return ResponseModal.fromjson(data);
  }

  /// 点赞
  static Future<ResponseModal<Map<String, dynamic>>> like(
      {required int scope, required String id}) async {
    var data = await HttpUtil().post('/like?scope=$scope', data: {"id": id});
    return ResponseModal.fromjson(data);
  }

  /// 点赞评论
  static Future<ResponseModal<Map<String, dynamic>>> like_comment({
    required int comment_id,
    required int work_id,
    required bool need_like,
    required bool is_top,
    required int worker_id,
  }) async {
    var data = await HttpUtil().post('/comment/like', data: {
      "comment_id": comment_id,
      "work_id": work_id,
      "need_like": need_like,
      "is_top": is_top,
      "worker_id": worker_id,
    });
    return ResponseModal.fromjson(data);
  }

  /// 点赞作品
  static Future<ResponseModal<Map<String, dynamic>>> like_work({
    required int work_id,
    required int worker_id,
    required bool need_like,
  }) async {
    var data = await HttpUtil().post(
      '/work/like',
      data: {
        "work_id": work_id,
        "need_like": need_like,
        "worker_id": work_id,
      },
    );
    return ResponseModal.fromjson(data);
  }

  /// 获取 oss 上传凭证
  static Future<ResponseModal<Map<String, dynamic>>> getOSSToken() async {
    var data = await HttpUtil().get('/oss/token');
    return ResponseModal.fromjson(data);
  }

  /// 收藏作品
  static Future<ResponseModal<Map<String, dynamic>>> collection(
      {required int work_id, required bool need_collect}) async {
    var data = await HttpUtil().post('/collection', data: {
      "work_id": work_id,
      "need_collect": need_collect,
    });
    return ResponseModal.fromjson(data);
  }

  /// 获取自身用户信息
  static Future<ResponseModal<Map<String, dynamic>>> getSelfInfo() async {
    var data = await HttpUtil().get('/user/self');
    return ResponseModal.fromjson(data);
  }

  /// 获取自身用户创作作品
  static Future<ResponseModal<List<dynamic>>> getSelfWork() async {
    var data = await HttpUtil().get('/user/self/work');
    return ResponseModal.fromjson(data);
  }

  /// 获取自身用户收藏作品
  static Future<ResponseModal<List<dynamic>>> getSelfCollection() async {
    var data = await HttpUtil().get('/user/self/collection');
    return ResponseModal.fromjson(data);
  }

  /// 获取自身用户点赞作品
  static Future<ResponseModal<List<dynamic>>> getSelfLike() async {
    var data = await HttpUtil().get('/user/self/like');
    return ResponseModal.fromjson(data);
  }

  /// 获取作品详情
  static Future<ResponseModal<Map<String, dynamic>>> getDetail(
      {required int work_id}) async {
    var data = await HttpUtil().get('/work-detail?work_id=$work_id');
    return ResponseModal.fromjson(data);
  }

  /// 获取其他用户信息
  static Future<ResponseModal<Map<String, dynamic>>> getOtherInfo(
      {required int user_id}) async {
    var data = await HttpUtil().post('/user/other', data: {"user_id": user_id});
    return ResponseModal.fromjson(data);
  }

  /// 获取其他用户作品
  static Future<ResponseModal<List<dynamic>>> getOtherWork(
      {required int user_id, int? page_size, int? page_num}) async {
    var data =
        await HttpUtil().post('/user/other/work', data: {"user_id": user_id});
    return ResponseModal.fromjson(data);
  }

  /// 获取其他用户收藏作品
  static Future<ResponseModal<List<dynamic>>> getOtherCollection(
      {required int user_id, int? page_size, int? page_num}) async {
    var data = await HttpUtil()
        .post('/user/other/collection', data: {"user_id": user_id});
    return ResponseModal.fromjson(data);
  }

  /// 获取分类
  static Future<ResponseModal<List<dynamic>>> getCategory() async {
    var data = await HttpUtil().get('/category');
    return ResponseModal.fromjson(data);
  }

  /// 获取其他用户点赞作品
  static Future<ResponseModal<List<dynamic>>> getOtherLike(
      {required int user_id, int? page_size, int? page_num}) async {
    var data =
        await HttpUtil().post('/user/other/like', data: {"user_id": user_id});
    return ResponseModal.fromjson(data);
  }

  /// 获取历史消息
  static Future<ResponseModal<List<dynamic>>> getOldMessage() async {
    var data = await HttpUtil().get('/old-message');
    return ResponseModal.fromjson(data);
  }

  /// 发布作品
  static Future<ResponseModal> publishWork({
    String? outlined,
    required int scope,
    required String title,
    required String image_url,
    required String content_url,
    required String work_class,
  }) async {
    var data;
    if (outlined == null) {
      data = await HttpUtil().post('/work', data: {
        "class": work_class,
        "scope": scope,
        "title": title,
        "image_url": image_url,
        "content_url": content_url,
      });
    } else {
      data = await HttpUtil().post('/work', data: {
        "class": work_class,
        "scope": scope,
        "title": title,
        "image_url": image_url,
        "content_url": content_url,
        "outlined": outlined
      });
    }
    return ResponseModal.fromjson(data);
  }

  ///
}
