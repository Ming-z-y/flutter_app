import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() {
    return _SearchPage();
  }
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 45,
        iconTheme: const IconThemeData(color: Color.fromRGBO(125, 122, 238, 1)),
        title: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 217, 215, 215),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const TextField(
                  cursorColor: Colors.amber,
                  style: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    focusColor: Color.fromRGBO(125, 122, 238, 1),
                    hintText: '搜索的东西',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    '搜索',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(125, 122, 238, 1),
                    ),
                  )),
            )
          ],
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // 历史记录字体
              Container(
                padding: const EdgeInsets.only(left: 5),
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        width: 5, color: Color.fromRGBO(130, 128, 239, 1)),
                  ),
                ),
                child: const Text(
                  '历史记录',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Wrap(
                  children: [
                    // 样例
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(246, 246, 246, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: (() {}),
                        child: Text(
                          '男生如何护肤',
                          style:
                              TextStyle(color: Color.fromRGBO(90, 76, 112, 1)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(246, 246, 246, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: (() {}),
                        child: Text(
                          '男生医美靠谱吗，会不会...',
                          style:
                              TextStyle(color: Color.fromRGBO(90, 76, 112, 1)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(246, 246, 246, 1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: (() {}),
                        child: Text(
                          '脸部祛痘用什么好',
                          style:
                              TextStyle(color: Color.fromRGBO(90, 76, 112, 1)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // 猜你想搜字体
              Container(
                padding: const EdgeInsets.only(left: 5),
                margin: const EdgeInsets.only(top: 30, left: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        width: 5, color: Color.fromRGBO(130, 128, 239, 1)),
                  ),
                ),
                child: const Text(
                  '猜你想搜',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  ),
                ),
              ),
              // 样例
              SizedBox(
                height: 40,
                child: ListTile(
                  title: const Text(
                    '男神逆袭计划',
                    style: TextStyle(color: Color.fromRGBO(90, 76, 112, 1)),
                  ),
                  onTap: () {
                    print("点击");
                  },
                ),
              ),
              SizedBox(
                height: 40,
                child: ListTile(
                  title: const Text(
                    '男性不动刀可以做的医美',
                    style: TextStyle(color: Color.fromRGBO(90, 76, 112, 1)),
                  ),
                  onTap: () {
                    print("点击");
                  },
                ),
              ),
              SizedBox(
                height: 40,
                child: ListTile(
                  title: const Text(
                    '提高气质小技巧',
                    style: TextStyle(color: Color.fromRGBO(90, 76, 112, 1)),
                  ),
                  onTap: () {
                    print("点击");
                  },
                ),
              ),
              SizedBox(
                height: 40,
                child: ListTile(
                  title: const Text(
                    '寒风穿搭，博主手把手教学',
                    style: TextStyle(color: Color.fromRGBO(90, 76, 112, 1)),
                  ),
                  onTap: () {
                    print("点击");
                  },
                ),
              ),
            ],
          )),
    );
  }
}
