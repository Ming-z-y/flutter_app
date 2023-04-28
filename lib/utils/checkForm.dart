class CheckForm {
  static String checkPhone(String phone) {
    RegExp mobile = RegExp(
        r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    if (mobile.hasMatch(phone))
      return "ok";
    else
      return "手机号不合规";
  }

  static String checkFormIsFull(Map<String, String> data) {
    bool isFull = true;
    data.forEach((key, value) {
      if (value == "") isFull = false;
    });

    if (isFull)
      return "ok";
    else
      return "表单未填写完整";
  }
}
