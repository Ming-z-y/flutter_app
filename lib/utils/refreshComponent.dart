import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CustomRefreshHeader extends ClassicalHeader {
  /// Key
  final Key? key;

  /// 方位
  final AlignmentGeometry? alignment;

  /// 提示刷新文字
  final String refreshText;

  /// 准备刷新文字
  final String refreshReadyText;

  /// 正在刷新文字
  final String refreshingText;

  /// 刷新完成文字
  final String refreshedText;

  /// 刷新失败文字
  final String refreshFailedText;

  /// 没有更多文字
  final String noMoreText;

  /// 显示额外信息(默认为时间)
  final bool showInfo;

  /// 更多信息
  final String infoText;

  /// 背景颜色
  final Color bgColor;

  /// 字体颜色
  final Color textColor;

  /// 更多信息文字颜色
  final Color infoColor;

  CustomRefreshHeader({
    extent = 60.0,
    triggerDistance = 70.0,
    float = false,
    completeDuration = const Duration(seconds: 1),
    enableInfiniteRefresh = false,
    enableHapticFeedback = true,
    this.key,
    this.alignment,
    this.refreshText: "下拉刷新",
    this.refreshReadyText: "释放刷新",
    this.refreshingText: "刷新中...",
    this.refreshedText: "刷新完成",
    this.refreshFailedText: "刷新失败",
    this.noMoreText: "没有更多",
    this.showInfo: true,
    this.infoText: "更新时间 %T",
    this.bgColor: Colors.white,
    this.textColor: Colors.grey,
    this.infoColor: Colors.grey,
  }) : super(
          extent: extent,
          triggerDistance: triggerDistance,
          float: float,
          completeDuration: float
              ? completeDuration == null
                  ? Duration(
                      milliseconds: 400,
                    )
                  : completeDuration +
                      Duration(
                        milliseconds: 400,
                      )
              : completeDuration,
          enableInfiniteRefresh: enableInfiniteRefresh,
          enableHapticFeedback: enableHapticFeedback,
        );
}

class CustomRefreshFooter extends ClassicalFooter {
  /// Key
  final Key? key;

  /// 方位
  final AlignmentGeometry? alignment;

  /// 提示加载文字
  final String loadText;

  /// 准备加载文字
  final String loadReadyText;

  /// 正在加载文字
  final String loadingText;

  /// 加载完成文字
  final String loadedText;

  /// 加载失败文字
  final String loadFailedText;

  /// 没有更多文字
  final String noMoreText;

  /// 显示额外信息(默认为时间)
  final bool showInfo;

  /// 更多信息
  final String infoText;

  /// 背景颜色
  final Color bgColor;

  /// 字体颜色
  final Color textColor;

  /// 更多信息文字颜色
  final Color infoColor;

  CustomRefreshFooter({
    extent = 60.0,
    triggerDistance = 70.0,
    float = false,
    completeDuration = const Duration(seconds: 1),
    enableInfiniteLoad = true,
    enableHapticFeedback = true,
    this.key,
    this.alignment,
    this.loadText: "上拉加载",
    this.loadReadyText: "释放加载",
    this.loadingText: "加载中...",
    this.loadedText: "加载完成",
    this.loadFailedText: "加载失败",
    this.noMoreText: "没有更多",
    this.showInfo: true,
    this.infoText: "更新时间 %T",
    this.bgColor: Colors.white,
    this.textColor: Colors.grey,
    this.infoColor: Colors.grey,
  }) : super(
          extent: extent,
          triggerDistance: triggerDistance,
          float: float,
          completeDuration: completeDuration,
          enableInfiniteLoad: enableInfiniteLoad,
          enableHapticFeedback: enableHapticFeedback,
        );
}
