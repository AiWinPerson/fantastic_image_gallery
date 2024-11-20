import 'package:get/get.dart';

class UserGalleryController extends GetxController{
  static final UserGalleryController to = Get.find<UserGalleryController>();
  final RxList<String> _imageList = <String>[].obs;

  RxList<String> get imageList => _imageList;

  void add(String path){
    _imageList.add(path);
    _imageList.refresh();
  }

  void remove(String path){
    _imageList.removeWhere((e) => e == path);
    _imageList.refresh();
  }

}