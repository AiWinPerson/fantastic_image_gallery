import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

import '../controller/image_explanation_controller.dart';
import '../controller/user_gallery_controller.dart';
import '../model/explanation_info.dart';
import '../util/color_set.dart';
import '../util/enum.dart';
import '../widget/app_title.dart';
import '../widget/drawer_menu.dart';
import '../widget/image_clip.dart';
import '../widget/menu_icon.dart';
import 'image_creation.dart';
import 'style_detail.dart';
import 'user_gallery.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final OutlineInputBorder focusedBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: ColorSet.violet500)
  );

  final OutlineInputBorder unfocusedBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(color: ColorSet.violet500.withOpacity(0.6))
  );

  List<String> imageStyleTitleList = [
    "Landscape",
    "Neon",
    "Fantasy",
    "Comic",
    "Halloween",
    "Christmas",
    "Disney",
    "Studio Ghibli",
    "Cyberpunk",
    "Sketch",
  ];

  List<ImagePath> imagePaths = [
    ImagePath.landscape,
    ImagePath.neon,
    ImagePath.fantasy,
    ImagePath.comic,
    ImagePath.halloween,
    ImagePath.christmas,
    ImagePath.disney,
    ImagePath.studioGhibli,
    ImagePath.cyberpunk,
    ImagePath.sketch,
  ];

  List<ImageStylePath> imageStylePath = [
    ImageStylePath.landscapeStyles,
    ImageStylePath.neonStyles,
    ImageStylePath.fantasyStyles,
    ImageStylePath.comicStyles,
    ImageStylePath.halloweenStyles,
    ImageStylePath.christmasStyles,
    ImageStylePath.disneyStyles,
    ImageStylePath.studioGhibliStyles,
    ImageStylePath.cyberpunkStyles,
    ImageStylePath.sketchStyles,
  ];

  final TextEditingController explanationEditor = TextEditingController();

  final SizedBox spacer = const SizedBox(height: 20,);

  final ButtonStyle buttonStyle = IconButton.styleFrom(
    splashFactory: NoSplash.splashFactory,
    highlightColor: ColorSet.transparent,
  );

  @override
  void initState() {
    Get.put(ImageExplanationController(),permanent: true);
    Get.put(UserGalleryController(),permanent: true);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ImageExplanationController>();
    Get.delete<UserGalleryController>();
    super.dispose();
  }

  void showBottomSheet() => Get.bottomSheet(
    Container(
      width: double.maxFinite,
      constraints: const BoxConstraints(
          minHeight: 300,
          maxHeight: double.maxFinite
      ),
      padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
      child: Obx(() => SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48,),
                  const Text("Records",style: TextStyle(fontSize: 18),),
                  IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.close)),
                ],
              ),
            ),
            spacer,
            ...List.generate(ImageExplanationController.to.records.length, (index) {
              ExplanationInfo record = ImageExplanationController.to.records[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat("MM월 dd일 HH:mm").format(record.writtenDate),),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        color: ColorSet.blackShade300,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(record.explanation,style: const TextStyle(color: ColorSet.whiteOpacity800,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(style: buttonStyle,onPressed: () => ImageExplanationController.to.removeRecord(record.writtenDate), icon: const Icon(Icons.delete_outline_rounded,size: 30,color: ColorSet.apricot,)),
                            IconButton(style: buttonStyle,onPressed: () {
                              Clipboard.setData(ClipboardData(text: record.explanation));
                              Fluttertoast.showToast(msg: "클립보드에 복사되었어요.",gravity: ToastGravity.BOTTOM,backgroundColor: ColorSet.blackShade300);
                            }, icon: const Icon(Icons.my_library_books_outlined,size: 25,color: ColorSet.whiteOpacity800,)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            )
          ],
        ),
      ),),
    ),
    backgroundColor: ColorSet.black,
    isScrollControlled: true,
    ignoreSafeArea: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: MenuIcon(),
              ),
              SliverToBoxAdapter(
                child: spacer,
              ),
              SliverToBoxAdapter(
                child: typingWithBot(),
              ),
              const SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                sliver: SliverToBoxAdapter(
                  child: Text("Style",style: TextStyle(color: ColorSet.white,fontSize: 17,fontWeight: FontWeight.w400),),
                )
              ),
              imageStyleList(),
            ],
          )
        ),
      ),
    );
  }

  Widget drawer(){
    return Drawer(
      backgroundColor: ColorSet.black,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTitle(),
            spacer,
            const DrawerMenu(
              title: "Profile",
              icon: Icons.person,
            ),
            DrawerMenu(
                title: "My Gallery",
                icon: Icons.image_outlined,
                onTap: () => Get.to(() => const UserGallery())
            ),
            const DrawerMenu(
              title: "Guide",
              icon: Icons.library_books,
            ),
            const Spacer(),
            const Text("Join Community",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
            spacer,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(child: Image.asset(ImagePath.facebookLogo.path)),
                  Expanded(child: Image.asset(ImagePath.instagramLogo.path)),
                  Expanded(child: Image.asset(ImagePath.discordLogo.path)),
                  Expanded(child: Image.asset(ImagePath.twitterLogo.path)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageStyleList(){
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        childAspectRatio: 1/1.5,
      ),
      itemCount: imageStyleTitleList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: (){
          Get.to(() => StyleDetail(
            imageStylePath: imageStylePath[index],
            styleName: imageStyleTitleList[index],
          ));
        },
        child: Column(
          children: [
            Expanded(
              child: ImageClip(assetPath: imagePaths[index].path,),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(imageStyleTitleList[index],style: const TextStyle(color: ColorSet.whiteOpacity800),),
            )
          ],
        ),
      ),
    );
  }

  Widget typingWithBot(){
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                const Text("Type your details about a image in english."),
                const Spacer(),
                IconButton(onPressed: showBottomSheet, icon: const Icon(Icons.history,color: ColorSet.whiteOpacity800,))
              ],
            ),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              controller: explanationEditor,
              expands: true,
              maxLines: null,
              minLines: null,
              textAlign: TextAlign.start,
              onChanged: (value){
                ImageExplanationController.to.explanationSetter = value;
              },
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                border: unfocusedBorder,
                enabledBorder: unfocusedBorder,
                focusedBorder: focusedBorder,
                hintText: "Please provide a detailed description of the image you would like to create.",
                hintStyle: const TextStyle(color: ColorSet.whiteOpacity400,fontSize: 15,overflow: TextOverflow.visible),
                suffixIcon: Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 48,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: ()async{
                              ImageExplanationController.to.addExplanation(explanationEditor.text);
                              await Get.to(() => ImageCreation(prompt: explanationEditor.text));
                              ImageExplanationController.to.explanationSetter = "";
                              explanationEditor.text = "";
                            },
                            icon: const HugeIcon(icon: HugeIcons.strokeRoundedRobotic, color: ColorSet.violet300)
                        ),
                      ),
                    ),
                    if(ImageExplanationController.to.currentExplanation.isNotEmpty) ...[
                      const SizedBox(width: 10,),
                      IconButton(
                          onPressed: (){
                            explanationEditor.text = "";
                            ImageExplanationController.to.explanationSetter = "";
                            },
                          icon: const Icon(Icons.close,color: ColorSet.violet300,
                          )
                      )
                    ]
                  ],
                )
                  ,)
              ),
            ),
          )),
        ],
      ),
    );
  }

}
