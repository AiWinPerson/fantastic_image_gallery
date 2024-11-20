import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/user_gallery_controller.dart';
import '../util/color_set.dart';
import '../util/enum.dart';
import '../widget/image_clip.dart';
import '../widget/screen_title.dart';
import 'safe_scaffold.dart';

class StyleDetail extends StatelessWidget {
  const StyleDetail({super.key,required this.imageStylePath,required this.styleName});
  final ImageStylePath imageStylePath;
  final String styleName;

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ScreenTitle(
                title:styleName,
              ),
            ),
            SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                childAspectRatio: 1/1.3,
              ),
              itemCount: imageStylePath.paths.length,
              itemBuilder: (context, index) => Obx(() {
                bool isAlreadyLike = UserGalleryController.to.imageList.value.contains(imageStylePath.paths[index]);
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ImageClip(assetPath: imageStylePath.paths[index],),
                    GestureDetector(
                      onTap: (){
                        if(isAlreadyLike){
                          UserGalleryController.to.remove(imageStylePath.paths[index]);
                        }else{
                          UserGalleryController.to.add(imageStylePath.paths[index]);
                        }
                      },
                      child: Container(
                        width: 38,
                        height: 38,
                        margin: const EdgeInsets.only(top: 5,right: 5),
                        decoration: BoxDecoration(
                            color: ColorSet.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(isAlreadyLike? Icons.favorite :  Icons.favorite_border_outlined),
                      ),
                    )
                  ],
                );
              },),
            ),
          ],
        ),
      ),
    );
  }
}
