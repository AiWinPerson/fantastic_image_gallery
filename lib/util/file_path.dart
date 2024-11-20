import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';

class FilePath{
  static Future<String?> getDownloadPath()async{
    String? path;
    if(Platform.isAndroid){
      path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      Directory dir = Directory(path);

      if(!dir.existsSync()){
        path = (await getExternalStorageDirectory())!.path;
      }
    }else if(Platform.isIOS){
      path = (await getApplicationDocumentsDirectory()).path;
    }else{
      path = (await getDownloadsDirectory())!.path;
    }
    return path;
  }
}