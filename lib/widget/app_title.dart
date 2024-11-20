import 'package:flutter/material.dart';

import '../util/enum.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(ImagePath.appLogo.path,width: 40,height: 40,fit: BoxFit.fill,),
        const Text("ImgGenAI",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
      ],
    );
  }
}
