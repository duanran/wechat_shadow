import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;



class file_mgr{
  static final shareins = file_mgr();

  localPath() async{
    try {
        var appDir = await getApplicationDocumentsDirectory();
        String apppath = appDir.path;
        return apppath;

    }
    catch(err){
        print(err);
    }
  }

  localFile(path) async{
    return new File('$path/TagList.json');
  }


  Future<String>loadAsset() async{

    return await rootBundle.loadString('assets/TagList.json');

  }





  getTagFilePath() async {
    try {
      final file = await localFile(await localPath());
      String str = await file.readAsString();
      return json.decode(str);
    }
    catch (err) {
      print(err);
    }
  }


}