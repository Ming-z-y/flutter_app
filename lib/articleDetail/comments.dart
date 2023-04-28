import 'package:flutter/material.dart';
import 'package:flutter_application_1/articleDetail/components/commentSheet.dart';

Future<void> showComments({
  required BuildContext context,
  required int work_id,
  required int user_id,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: ((context) {
      return CommentSheet(
        work_id: work_id,
        user_id: user_id,
      );
    }),
  );
}
