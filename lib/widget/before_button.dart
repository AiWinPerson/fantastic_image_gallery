import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeforeButton extends StatelessWidget {
  const BeforeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new_outlined)
    );
  }
}
