import 'package:flutter/material.dart';
import 'package:wechat_shadow/network/http_api.dart';
import 'package:wechat_shadow/Phone/phone_page.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _LoginState();

}

class _LoginState extends State<Login>{
  FocusNode _nameFocus,_pwFocus;
  TextEditingController _nameController,_pwController;
  @override
  void initState() {
    // TODO: implement initState
    _nameController = TextEditingController();
    _pwController = TextEditingController();
    _nameFocus = FocusNode();
    _pwFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('登录'),
        ),
        body: GestureDetector(
          child: SafeArea(child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/logo-lager.png'),
                    margin: EdgeInsets.only(top: 20),
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Material(
//                    borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        focusNode: _nameFocus,
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (input){
                          _nameFocus.unfocus();
//                        FocusScope.of(context).requestFocus(_pwFocus);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintText: "请输入手机号",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        focusNode: _pwFocus,
                        controller: _pwController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (input){
                          _pwFocus.unfocus();
                          //登陆请求
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintText: "请输入密码",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width-32,
                      height: 48,
                      child: Center(
                        child: new Text(
                          '登录',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: const Color(0xFFFF6567),
                          ),
                    onTap: (){
                      print("点击登录");
                      
                      loginReq(_nameController.text,"",_pwController.text);
                    },
                  ),
                ],
              ),
            ],
          ),
          ),
          onTap: (){
            _nameFocus.unfocus();
          },
        ),
        backgroundColor: const Color(0xFFf5f5f5),
      ),

    );

  }

  void loginReq(String account,String token,String pwd){
        account = "15833979831";
        pwd = "Dr2085509";
        token = "";
        HttpApi.sharedIns.loginRequest(account, token, pwd).then((Map<String,dynamic> resultDic){
          if (resultDic != null){
            print("resultDic=$resultDic");
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new PhonePage()),);
          }
        });


//      HttpApi.sharedIns.loginRequest("15833979831", "72235b317e1d00197c980c71d75b0472").then((Map<String,dynamic> resultDic){
//        if (resultDic != null){
//          print("resultDic=$resultDic");
//          Navigator.push(context, new MaterialPageRoute(builder: (context) => new PhonePage()),);
//        }
//      });

//    HttpApi.sharedIns.ucLoginRequest(account, token, pwd).then((Map<String,dynamic> resultDic){
//       print("resultDic=$resultDic");
//    });


  }


}
