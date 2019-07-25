import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'AESUtil.dart';
import 'dart:typed_data';

//import 'package:cipher2/cipher2.dart';
class HttpApi{
  static final sharedIns = HttpApi();
  static final appkey = "84390d67a16a558277db61a2a55f4036";
//  final dio = Dio();

  bool isProxyChecked = true; // a variable for debug
  String proxy = '172.16.40.254:8888'; // ip:port
  Dio dio = Dio();
  // 设置代理用来调试应用


   String myCookie = "auth_info=lbLZNOWalGjl4E2PdyNGqqAuzMziyfGvfotkE0Xiz6ZA36uC0O7dFgcCLT++8R9WLoO4aUd8y02KKRvtrzClsav6NOklP1dSqnjujkfw7/oHLElplVLN3oEhGKX6Z9OrGnXhXXNxHcOcsRA4rgTd4ym86Bu2dNhG85Ocgx6TcQIZjD9iTrVpg6LErnk8i+IMOEcR6JlWD1vTpsFSSBME2cxpzl3sjLrtx+nAbV/HLmv/mXiFhefBWa5YcJMjnQGX; Max-Age=3600; Expires=Fri, 19-Jul-2019 09:02:03 GMT; Path=/";


  static final kEncryptKey1 = "8wvu4JNclrnVYfaw";





  HttpApi(){
//    dio.options.baseUrl = "http://apis.juhe.cn/cook";
//    dio.options.baseUrl = "http://172.16.2.155:9700";
      dio.options.baseUrl = "https://cloudphone-out-test.xiaoyaoyou.com:60084";
//    dio.options.baseUrl = "http://172.16.190.182:9700";

    dio.options.connectTimeout = 10000;
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
//    dio.options.contentType = ContentType.json;
    dio.options.responseType = ResponseType.json;

    Map<String, dynamic> myheaders = new Map();
    myheaders['Accept'] = "*/*";
    myheaders['Accept-Encoding'] = "br,gzip,deflate";
    myheaders['User-Agent'] = "cloudPhone/2.3.3 (iPhone; iOS 11.3; Scale/3.00)";
    myheaders['Cookie'] = myCookie;

    dio.options.headers = myheaders;


    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client){
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY 172.16.40.254:8888";
      };
    };

  }

    Future<Map<String,dynamic>> loginRequest(String account,String token,String pwd) async{
      Map<String , dynamic> dic = {
      "account" : account,
        "password" : pwd,
      "clientType" : "6",
      "loginType" : "5",
      "channel" : "test001",
      };

      Response res = await dio.post("/login",data: dic);

      if (aiyuntuSuccess(res)){
        Map<String,dynamic> resultDic = res.data;
        List<dynamic> cookielist = res.headers[HttpHeaders.setCookieHeader];
        if (cookielist.length > 0){
//          myCookie = cookielist[0];
          dio.options.headers[HttpHeaders.cookieHeader] = cookielist[0];
        }
        String loginRes = res.data["result"];
        String resStr = AESUtil.decrypt2Base64(kEncryptKey1, loginRes);
        resultDic = json.decode(resStr);
        return resultDic;
      }
      else{
        return null;
      }
    }

    Future<List<dynamic>> getDeviceList() async{

      Response res = await dio.get("/cloud_device/list");

      if (aiyuntuSuccess(res)){
        Map<String,dynamic> resultDic = res.data["result"];
        List<dynamic> deviceList = resultDic["cloud_device_list"];
        return deviceList;
      }
      else {
        return null;
      }

    }


  Future<Map<String,dynamic>> getPriceList(String device_type,String price_type) async{
    Response res = await dio.get("/cloud_device/price/list/v2?device_type=$device_type&price_type=$price_type");
    if (aiyuntuSuccess(res)){
      Map<String,dynamic> resultDic = res.data["result"];
      return resultDic;
    }
    else{
      return null;
    }

  }





    
    Future<Map<String,dynamic>> ucLoginRequest(String account,String token,String pwd) async{
      dio.options.baseUrl = "http://sdk-api-dev.haimawan.com/user_server/from_client";
      dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
      Map <String,dynamic> dic = {
        "method" : "login",
        "request_source_index" : "CLOUD_IOS_PAYSDK_CLIENT",
        "version" : "1.0",
        "param" : "flR/9VT7g/gU0iiTaerFXjcbLlysM0cLHDtOtPw9Qni8B1wqwm/356idiGPMIcLbS1QA+seM++iEi6aFTOier/fEEuwyoFCVfdoCXDaC89ZX0SxL5ALDnrSrfDsJoBV002s8pnwrdJ2vtdmLiqKLjxBdIQa6Q0vnTrthu88iE1wOY1p3WttQ9oBhrWGdIQP7s89P+f6cMkVrhX9UKxd+SWRG2KYaVbc7VD5SI8BWx1k8I1oVfRzqE+Zjxi2TVhlXk+VktsHDW3peaw4r2+xIsGWb9/JXbrRamRSkKERweht3OwYeZmLJA1jG/SzDrEqULlTRVDTxrrGW60KJexC9c6q8p/dDxx+arqcSu4vz6cWHR72UDAi+B8c9shxLpZL4wWVVIPtmGx86yPmfbvlTEV55WkzqcI1j3WQtbHXlXHrvy3YDb/TyjBafl2JEcA/TdFq2U+4HtJszKzihDq0W98arXjAdyYHu9hWUFu5YsFttIhIKwKxklSsy+PYezWMv7WwxsBiFNpxW/tyZEN8O9lDLOtmuO2OU2sRQNnEqyUa7Mv21nYxb59wAtUJ/irZChcPEd1qOIZSk51IWwU5oSOexqd7CJMgmzBAfrh+r9RiFY7EzaV1XE133zrWs2auYl30uyLLihW7Nt7YBu6fn5uAf8AzeOAztygQEbshvcxyUDopmquzjYdVLbFVgl0BxReVkjK5vbcKvih8qh/DF0ItUwYlm8gaIFf0fPBXndA84rbG7RthZoLfRNdm4yf39ETXWwHyel7Vk23VwfwE0xB8I6uqvYAh3+wzFOOwYU5VP2Y/FGUKvj3pwMQYq5drHffULt4HQQ3HFsvWlZsgXZjHrjia+aE/ZpNEEj9aNqM0G+OQPZZayJHwVzn//xmgIIhfvR+ac8gJ8aLiseV6E1jg7rVyjZZxi/KVU0fsr1NV/EIXO4o4SKYpRqW3iGoRxrQM/M62+sLvjp5xBhU5THCjbfPBCesP1hKqHoYJHkh28Vtlv0Vy/OSSrtVaBSBocfLYVO1banHfSTRXLmMMNXXHZqLMlc+EvouDQ3ZMzJYn37aSKiHh3DfJ/54nPT05s",
        "sign" : "93e783981f051918d0afaee12d1e9279",
      };

////      Map <String,dynamic> sign = {"sign" : "11111"};
////      dic.addAll(sign);
//      print("dic=$dic");
//      String encrypDataStr = dic.toString();
//      print("encrypDataStr=$encrypDataStr");


//      Cipher2
//      String encryptedString = await
//      print("encryptedString=$encryptedString");


      Response res = await dio.post("http://sdk-api-dev.haimawan.com/user_server/from_client",data: dic);





      Map<String,dynamic> resultDic = res.data;
      print("res.data=$resultDic");
      return resultDic;

    }


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


    bool aiyuntuSuccess(Response res){
      Map<String,dynamic> resDic = res.data;
      var status = resDic["code"];
      if (status == 10000){
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


