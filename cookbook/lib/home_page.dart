import 'package:flutter/material.dart';
import 'file_mgr.dart';
import 'dart:convert';
import 'models/menu_model.dart';
import 'models/food_model.dart';
import 'food_list.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> data;

  List<Menu> menuList;
  List<Food> foodList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    foodList = new List();
    menuList = new List();
    _getFileData();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('帮小厨'),
          centerTitle: true,
          actions: <Widget>[
            new Container()
          ],
        ),
        body: new Center(
          child: new Row(
            children: <Widget>[
              Container(
                width: 100,
                child: ListView(
                  children: _getTagListData(),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    children: _getListData(),
                  ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getMenuData(List data){
    List<Menu>  tmpMenuList = new List();


    for (var item in data){
      List<Food>  tmpFoodList = new List();
      var listMap = List<Map<String, dynamic>>.from(item["list"]);
      for (var foodMap in listMap){
        Food f = Food.fromJson(foodMap);
        tmpFoodList.add(f);
      }
      var name = item["name"];
      var parentId = item["parentId"];
      Menu m = new Menu(tmpFoodList, name, parentId);
      tmpMenuList.add(m);
    }


    setState(() {
      menuList = tmpMenuList;
      Menu m = menuList[0];
      foodList = m.list;
    });



  }

  _getFileData(){
    var mgr = file_mgr.shareins;
    mgr.loadAsset().then((String value){
      data = jsonDecode(value);
      _getMenuData(data);
    });
  }

  _getTagListData(){
    List <Widget> widgets = [];
    if (menuList.length == 0){
      return widgets;
    }
    for (int i = 0; i < menuList.length; i++ ){
      Menu m = menuList[i];
      var imgId = m.parentId;
      widgets.add(GestureDetector(
        child:Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Image.asset("assets/$imgId@2x.png"),
              SizedBox(height: 20),
              Text(m.name),
            ],
          ),
        ),
        onTap: (){
          setState(() {
            var li = m.list;
            foodList = m.list;
          });
        },
      ),
      );
    }
    return widgets;

  }



  _getListData(){
    List <Widget> widgets = [];
    for (int i = 0; i < foodList.length; i++){
      Food f = foodList[i];
      widgets.add(GestureDetector(
        child: Padding(padding: EdgeInsets.all(10.0),
          child: Text(f.name),
        ),
        onTap: (){
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => new FoodList(
                    selFood: f,
                  ),
              ),
              );
        },
      )
      );
    }
    return widgets;
  }
}
