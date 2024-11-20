import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      body: Column(
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
          Expanded(child: imgUrl == null ?
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
              onPressed: () => makeImg(textEditingController.text),
              child: const Text("Recreate",style: TextStyle(color: ColorSet.white,fontSize: 18),)
          )
        ],
      ),
    );
  }
}
