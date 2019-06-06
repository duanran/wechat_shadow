import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';



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


  Future<Map<String,dynamic>> getDataFromKey(String key) async{
    Map<String,dynamic> data;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataStr = await prefs.getString(key);
    if (dataStr == null){
      return null;
    }
    data = jsonDecode(dataStr);
    return data;
  }

  Future <bool> saveDataWithKey(String key, Map<String,dynamic>data) async{
    bool saved = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataStr = jsonEncode(data);
    saved = await prefs.setString(key, dataStr);
    return saved;
  }


  Future saveListWithKey(String key,List<Map<String,dynamic>>dataList) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> strList = new List();
    for (var item in dataList){
      String dataStr = jsonEncode(item);
      strList.add(dataStr);
    }
    await prefs.setStringList(key, strList);
  }


  Future<List<Map<String,dynamic>>> readListFromKey(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>strList = await prefs.getStringList(key);
    if (strList == null){
      return null;
    }
    List<Map<String,dynamic>>dataList = new List();
    for (var str in strList){
      Map<String,dynamic> data = jsonDecode(str);
      dataList.add(data);
    }
    return dataList;
  }



  Future <bool>removeDataWithKey(String key)async{
    bool suc = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    suc = await prefs.remove(key);
    return suc;
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