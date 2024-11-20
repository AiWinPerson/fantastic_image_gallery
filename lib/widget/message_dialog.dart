import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/color_set.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({super.key, required this.title, required this.content,this.actions,this.onPressed});
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: ColorSet.indigo,
      title: Text(title,),
      titleTextStyle: const TextStyle(color: ColorSet.white),
      content: content,
      actions: actions ?? [
        TextButton(onPressed: onPressed?? (){
          Get.back();
        }, child: const Text("Ok"))
      ],
    );
  }
}