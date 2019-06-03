import 'package:flutter/material.dart';


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
        body: SafeArea(child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Image.asset('assets/use_icon.png'),
                  margin: EdgeInsets.only(top: 20),
                ),
                SizedBox(height: 80),
                Padding(
                    padding: const EdgeInsets.all(16),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: TextField(
                      focusNode: _nameFocus,
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (input){
                        _nameFocus.unfocus();
//                        FocusScope.of(context).requestFocus(_pwFocus);
                      },
                      decoration: InputDecoration(
                        labelText: "name",
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
                        labelText: "password",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(onPressed: (){},child: Text('login'),color: Colors.white,)
                  ],
                )
              ],
            ),
          ],
        ),
        ),
      ),

    );


  }

}
