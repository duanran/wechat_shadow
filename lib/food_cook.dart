import 'package:flutter/material.dart';

import 'models/food_detail_model.dart';

class FoodCook extends StatefulWidget{
  FoodCook({Key key,@required this.selFoodDetail}) : super(key : key);
  final FoodDetail selFoodDetail;
  @override
  State<StatefulWidget> createState() => new FoodCookState();


}

class FoodCookState extends State<FoodCook>{

  List<String> materialList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    materialList = new List();
    List<String> tmpMaterial = new List();

    List <String> tmpburden = widget.selFoodDetail.burden.split(";");
    List <String> tmpIn = widget.selFoodDetail.ingredients.split(";");



    String str = "";
    for(var item in tmpIn){
        str = str + item + ",";
    }


    for(var item in tmpburden){
      str = str + item + ",";
    }

    tmpMaterial = str.split(",");
    tmpMaterial.removeLast();
    materialList = tmpMaterial;


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("详细步骤"),
      ),
      body: ListView(
//        shrinkWrap: true,
        children: <Widget>[
          _getBrief(),
          _getMaterialReady(),
          _getCookStep(),
        ],
      ),
    );
  }


  Widget _getBrief(){
    return new Container(
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: new Text(widget.selFoodDetail.title),
            height: 30,
            padding: EdgeInsets.only(left: 10,top: 5),
            width: MediaQuery.of(context).size.width,
            color: Colors.green[300],
//            foregroundDecoration: new BoxDecoration(
//              color:Colors.white24,
//            ),
          ),
          Row(
            children: <Widget>[
              Container(
                child: Image.network(widget.selFoodDetail.albums[0]),
                padding: EdgeInsets.all(10),
                width: 100,
                height: 100,
              ),
              Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(widget.selFoodDetail.imtro),
                    ],
                  ),

              ),
            ],
          ),
        ],
      ),
    );

  }


  Widget _getCookStep(){
    return new Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text("材料准备"),
            height: 30,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 10,top: 5),
            color: Colors.green[300],
          ),
          Column(
            children: _getStepData(),
          ),
        ],
      ),
    );

  }

  Widget _getMaterialReady(){
    return new Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text("材料准备"),
              height: 30,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10,top: 5),
              color: Colors.green[300],
            ),
            Column(
              children: _getMaterialData(),
            ),
          ],
        ),
    );
  }



  List<Widget> _getMaterialData(){
    int n = materialList.length ~/ 4;
    int count = materialList.length;
    print("n=$n");
    print("materialList=$materialList");
    print("count=$count");

    int row = 0;
    if (n > 0){
      row = n + 1;
    }
    else {
      row = 0;
    }

    List <Widget> widgets = [];

    if (row > 0){
      widgets.addAll(_assembleCommeMaterial(row));
      int index = (row-1) * 4;
      Row r = _assembleLastMaterial(index);
      widgets.add(r);
    }
    else{
      Row r = _assembleLastMaterial(0);
      widgets.add(r);
    }


    return widgets;

  }

  Widget _assembleLastMaterial(int index){
    List <Widget> widgets = new List();
    for (int j = index; j < materialList.length;j++){
      String content = materialList[j];
      Text t = Text(content);
      widgets.add(t);
    }
    Row r = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    );
    return r;
  }


  List<Widget> _assembleCommeMaterial(int row){
    List <Widget> widgets = new List();
    for (int j = 0; j < row-1 ;j++){
      print("j=$j");
      Row r = new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(materialList[(j*4) + 0]),
          Text(materialList[(j*4) + 1]),
          Text(materialList[(j*4) + 2]),
          Text(materialList[(j*4) + 3]),
        ],
      );
      widgets.add(r);
    }
    return widgets;
  }


  List<Widget>_getStepData(){
    List<Widget> widgets = new List();
    for (var item in widget.selFoodDetail.steps){
      String img = item["img"];
      String content = item["step"];
      Row r = new Row(
        children: <Widget>[
          Container(
            child: Image.network(img),
            padding: EdgeInsets.all(10),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
        ],
      );
      widgets.add(r);
    }

    return widgets;
  }


}