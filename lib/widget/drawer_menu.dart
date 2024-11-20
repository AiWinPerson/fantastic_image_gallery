import 'package:flutter/material.dart';

import '../util/color_set.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key, required this.icon, this.onTap, required this.title});
  final IconData icon;
  final VoidCallback? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorSet.blackShade300,
        ),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: Row(
          children: [
            SizedBox(width: 40,child: Icon(icon,size: 35,),),
            const SizedBox(width: 10,),
            Text(title,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}
