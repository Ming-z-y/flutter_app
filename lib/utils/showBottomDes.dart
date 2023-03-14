import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import './chooseImage.dart';

class ShowBottomDes {
  static chooseDescription(
    String title,
    BuildContext context,

    /// 点击确定提交回调
    void Function(String des) onTap,
  ) {
    TextEditingController textController = TextEditingController();
    BrnBottomPicker.show(
      context,
      onConfirm: () {
        Navigator.of(context).maybePop();
      },
      onCancel: () {},
      cancel: '',
      confirm: Icon(Icons.access_time_rounded),
      contentWidget: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 1,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.05)),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 14, color: Color.fromRGBO(164, 163, 183, 1)),
            ),
            TextField(
              controller: textController,
              cursorColor: const Color.fromRGBO(164, 163, 183, 1),
              decoration: const InputDecoration(
                hintText: '请输入',
                hintStyle: TextStyle(color: Color.fromRGBO(164, 163, 183, 1)),
                focusColor: Color.fromRGBO(164, 163, 183, 1),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(164, 163, 183, 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
              child: BrnSmallMainButton(
                title: '确认提交',
                bgColor: Color.fromRGBO(98, 90, 248, 1),
                width: 180,
                radius: 20,
                onTap: () {
                  onTap(textController.text);
                },
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  static chooseBirthday(
    BuildContext context,
  ) {
    BrnDatePicker.showDatePicker(context,
        maxDateTime: DateTime.now(),
        minDateTime: DateTime.parse('1969-07-20 20:18:04Z'),
        initialDateTime: DateTime.now(),
        themeData: BrnPickerConfig(
            itemTextSelectedStyle:
                BrnTextStyle(color: Color.fromRGBO(51, 51, 51, 1)),
            cancelTextStyle: BrnTextStyle()),
        // 支持DateTimePickerMode.date、DateTimePickerMode.datetime、DateTimePickerMode.time
        // pickerMode: DateTimePickerMode.date,
        minuteDivider: 30,
        pickerTitleConfig: BrnPickerTitleConfig.Default,
        dateFormat: 'yyyy,MMMM,dd', onConfirm: (dateTime, list) {
      BrnToast.show("onConfirm:  $dateTime   $list", context);
    }, onClose: () {
      print("onClose");
    }, onCancel: () {
      print("onCancel");
    }, onChange: (dateTime, list) {
      print("onChange:  $dateTime    $list");
    });
  }

  static showChooseImage(
    BuildContext context,
  ) {
    List<BrnCommonActionSheetItem> actions = [];
    actions.add(BrnCommonActionSheetItem(
      '手机照片中选择',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    actions.add(BrnCommonActionSheetItem(
      '拍摄',
      actionStyle: BrnCommonActionSheetItemStyle.normal,
    ));
    // 展示actionSheet
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BrnCommonActionSheet(
          actions: actions,
          clickCallBack: (
            int index,
            BrnCommonActionSheetItem actionEle,
          ) {
            index == 0
                ? ImageChoices.getPhoneImage()
                : ImageChoices.getImageFromCamera();
          },
        );
      },
    );
  }
}
