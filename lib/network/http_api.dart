import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
class HttpApi{
  static final sharedIns = HttpApi();
  static final appkey = "84390d67a16a558277db61a2a55f4036";
  final dio = Dio();

  HttpApi(){
    dio.options.baseUrl = "http://apis.juhe.cn/cook";
    dio.options.connectTimeout = 10000;
//    dio.options.contentType = ContentType.json;
    dio.options.responseType = ResponseType.json;



  }
////  String _authToken;
////
////  // 配置dio实例
//  dio.options.baseUrl="http://apis.juhe.cn/cook";
//  dio.options.connectTimeout = 5000; //5s
//  dio.options.receiveTimeout=3000;

//  // 或者通过传递一个 `options`来创建dio实例
//  Options options= new Options(
//      baseUrl:"http://apis.juhe.cn/cook",
//      connectTimeout:5000,
//      receiveTimeout:3000
//  );
//  Dio dio = new Dio(options);

    Future<Map<String,dynamic>> getDataWithIndex(String cid,String pn,String rn) async{
      Response res = await dio.get("/index?pn=$pn&cid=$cid&rn=$rn&key=$appkey");
      if (isSuccess(res)){
         Map<String,dynamic> resultDic = res.data["result"];
         return resultDic;
      }
    }


    Future<Map<String,dynamic>> searchDataWithName(String name,String pn,String rn) async{
      Response res = await dio.get("/query.php?menu=$name&pn=$pn&rn=$rn&key=$appkey");
      if(isSuccess(res)){
        Map<String,dynamic> resultDic = res.data["result"];
        return resultDic;
      }
    }


  bool isSuccess(Response res){
      Map<String,dynamic> resDic = res.data;
      var status = resDic["resultcode"];
      if (status == "200"){
        return true;
      }
      else{
        return false;
      }

    }

}


//class RESTResp{
//    Map<String,dynamic> result;
//
//}


//  Future<String> loginRequest() async{
//    Response r = dio.post('/login',data: jsonEncode("method"))
//
//
//  }
//
//
//  class RESTResp {
//  Map<String, dynamic> result;
//  RespError error;
//  int id;
//
//  RESTResp.fromJson(Map<String, dynamic> json)
//      : result = json["result"] as Map<String, dynamic>,
//  error = RespError.fromJson(json["error"]),
//  id = json["id"] as int;
//
//  Map<String, dynamic> toJson() => {"result": result, "id": id};
//  }


