import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/cache.dart';
import '../../utils/showBottomDes.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'brn1RowDelegate.dart';

class EditMessage extends StatefulWidget {
  const EditMessage({super.key});

  @override
  State<EditMessage> createState() {
    return _EditMessage();
  }
}

class _EditMessage extends State<EditMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 40,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(65, 53, 85, 1),
        ),
        title: const Text(
          '编辑资料',
          style: TextStyle(
            color: Color.fromRGBO(65, 53, 85, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: EasyRefresh(
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 80,
              height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  chooseImage();
                },
                child: Image.network(
                  'https://p.qqan.com/up/2021-6/16234652484532758.jpg',
                ),
              ),
              // child: Image.network(
              //   'https://p.qqan.com/up/2021-6/16234652484532758.jpg',
              // ),
            ),
            const SizedBox(height: 20),
            BrnTextInputFormItem(
              title: '用户名',
              hint: "请输入",
              controller: TextEditingController()..text = "MING",
              onChanged: (newValue) {
                BrnToast.show("点击触发回调_${newValue}_onChanged", context);
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '个人简介',
              hint: '个人简介',
              value: AppCache.description,
              themeData: BrnFormItemConfig(),
              onTap: () {
                chooseDescription();
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '性别',
              hint: '男',
              onTap: () {
                chooseGender();
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '生日',
              hint: '2004-05-04',
              onTap: () {
                chooseBirthday();
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '居住地',
              hint: 'xxx',
              value: AppCache.address,
              onTap: () {
                writeAddress();
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '职业',
              hint: 'xxx',
              onTap: () {
                writeOccupation();
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '学校',
              value: AppCache.school,
              hint: '填写您的学校',
              onTap: () {
                chooseCollege();
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '背景图',
              hint: 'xxx',
              onTap: () {
                chooseImage();
              },
            ),
            Container(
              height: 5,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              height: 30,
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: const [
                  Text(
                    '更多信息',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '(仅限自己可见)',
                    style: TextStyle(
                        color: Color.fromRGBO(102, 102, 102, 1), fontSize: 12),
                  )
                ],
              ),
            ),
            BrnTextSelectFormItem(
              title: '身高',
              hint: '填写您的身高',
              value: AppCache.height,
              onTap: () {
                writeHeight();
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '体重',
              hint: '填写您的体重',
              value: AppCache.weight,
              onTap: () {
                chooseWeight();
              },
            ),
            const Divider(height: 1.5),
            BrnTextSelectFormItem(
              title: '肤质',
              hint: '易出油',
            ),
            const Divider(height: 1.5),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }

  void chooseGender() {
    List<Map<String, List>> list = [
      {
        '男': [
          {
            'AAA': ['8', '9']
          }
        ]
      },
      {
        '女': [
          {
            'BBB': ['5', '6']
          }
        ]
      },
    ];
    BrnMultiDataPicker(
      context: context,
      title: '填写信息',
      delegate: Brn1RowDelegate(firstSelectedIndex: 1, list: list),
      confirmClick: (list) {
        BrnToast.show(list.toString(), context);
      },
    ).show();
  }

  void chooseDescription() {
    ShowBottomDes.chooseDescription('填写个人简介', context, ((des) {
      if (des == '') {
        return;
      }
      AppCache.setDescription(des)
          .then((value) => {value ? Navigator.of(context).maybePop() : ''});
    }));
  }

  void writeOccupation() {
    ShowBottomDes.chooseDescription('填写你的职业', context, ((des) {}));
  }

  void writeAddress() {
    ShowBottomDes.chooseDescription('填写您的居住地', context, ((des) {
      if (des == '') {
        return;
      }
      AppCache.setAddress(des);
    }));
  }

  void writeHeight() {
    ShowBottomDes.chooseDescription('填写您的身高', context, ((des) {
      if (des == '') {
        return;
      }
      AppCache.setHeight(des);
    }));
  }

  void chooseBirthday() {
    ShowBottomDes.chooseBirthday(context);
  }

  void chooseCollege() {
    ShowBottomDes.chooseDescription("填写您的学校", context, (des) {
      if (des == '') {
        return;
      }
      AppCache.setSchool(des);
    });
  }

  void chooseImage() {
    ShowBottomDes.showChooseImage(context);
  }

  void chooseWeight() {
    ShowBottomDes.chooseDescription("填写您的体重", context, (des) {
      if (des == '') {
        return;
      }
      AppCache.setWeight(des);
    });
  }
}
