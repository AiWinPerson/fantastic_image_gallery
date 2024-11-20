import 'package:flutter/material.dart';

import 'before_button.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key,required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const BeforeButton(),
          const SizedBox(width: 20,),
          Text(title,style: const TextStyle(fontSize: 20),)
        ],
      ),
    );
  }
}
