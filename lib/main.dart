import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'env/env.dart';
import 'screen/home.dart';
import 'util/custom_theme.dart';

void main(){
  OpenAI.apiKey = Env.apiKey;
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: CustomTheme.dark,
    home: const SafeArea(
      child: Home(),
    ),
  ));
}