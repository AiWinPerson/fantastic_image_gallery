import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controller/image_explanation_controller.dart';
import '../util/color_set.dart';
import '../util/mobile_save.dart';
import '../widget/before_button.dart';
import 'safe_scaffold.dart';

class ImageCreation extends StatefulWidget {
  const ImageCreation({super.key,required this.prompt});
  final String prompt;

  @override
  State<ImageCreation> createState() => _ImageCreationState();
}

class _ImageCreationState extends State<ImageCreation> {

  String? imgUrl;

  late final TextEditingController textEditingController = TextEditingController(text: widget.prompt);

  final OutlineInputBorder inputBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(10));

  bool isRecreating = false;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      makeImg(widget.prompt);
    },);
  }

  Future<void> makeImg(String prompt)async{
    OpenAIImageModel image = await OpenAI.instance.image.create(
      prompt: prompt,
      n: 1,
      size: OpenAIImageSize.size1024,
      responseFormat: OpenAIImageResponseFormat.url,
    );

    final currentItem = image.data[0];
    imgUrl = currentItem.url;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const BeforeButton(),
                  const Spacer(),
                  IconButton(onPressed: () {
                    MobileSave.saveImgFromUrl(url: imgUrl!);
                    Fluttertoast.showToast(msg: "이미지가 저장되었습니다.",gravity: ToastGravity.BOTTOM,backgroundColor: ColorSet.blackShade300);
                  }, icon: const Icon(Icons.download,color: ColorSet.green,))
                ],
              ),
            ),
            Expanded(child: imgUrl == null || isRecreating?
            const Center(child: CircularProgressIndicator())
                : Image.network(imgUrl!,fit: BoxFit.contain,)
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorSet.blackShade300,
                      border: inputBorder,
                      focusedBorder: inputBorder,
                      enabledBorder: inputBorder,
                    ),
                  )),
                ],
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    backgroundColor: ColorSet.violet500,
                    minimumSize: const Size(double.maxFinite, 60)
                ),
                onPressed:isRecreating? (){} : () async{
                  isRecreating = true;
                  setState(() {});
                  await makeImg(textEditingController.text);
                  ImageExplanationController.to.addExplanation(textEditingController.text);
                  isRecreating = false;
                  setState(() {});
                },
                child: Text(isRecreating? "Recreating...": "Recreate",style: const TextStyle(color: ColorSet.white,fontSize: 18),)
            )
          ],
        ),
      ),
    );
  }
}
