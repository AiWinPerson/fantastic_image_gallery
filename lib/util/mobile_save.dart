import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'file_path.dart';

class MobileSave{
  static Future<void> saveImgFromUrl({required String url,String? fileName})async{
    String name = fileName?? "image_${DateFormat("HH_mm_ss").format(DateTime.now())}.png";
    final http.Response response = await http.get(Uri.parse(url));
    Uint8List uint8list = response.bodyBytes;
    ByteBuffer buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    String? path = await FilePath.getDownloadPath();
    File file = File("$path/$name");
    await file.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes,byteData.lengthInBytes));
  }
}