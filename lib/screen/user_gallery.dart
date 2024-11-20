import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/user_gallery_controller.dart';
import '../widget/image_clip.dart';
import '../widget/message_dialog.dart';
import '../widget/screen_title.dart';
import 'safe_scaffold.dart';

class UserGallery extends GetView<UserGalleryController> {
  const UserGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeScaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() => CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: ScreenTitle(
                title:"My Gallery",
              ),
            ),
            SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                  childAspectRatio: 1/1.3,
                ),
                itemCount: controller.imageList.length,
                itemBuilder: (context, index) => GestureDetector(
                  onLongPress: (){
                    Get.dialog(MessageDialog(
                      title: "Delete Image",
                      content: const Text("Do you want to delete this image?"),
                      onPressed: (){
                        controller.remove(controller.imageList.value[index]);
                        Get.back();
                      },
                    ));
                  },
                  child: ImageClip(
                    assetPath: controller.imageList.value[index],
                  ),
                )
            )
          ],
        ),),
      ),
    );
  }
}
