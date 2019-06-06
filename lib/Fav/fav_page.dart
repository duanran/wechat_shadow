import 'package:flutter/material.dart';
import 'package:wechat_shadow/file_mgr.dart';
import 'package:wechat_shadow/models/food_detail_model.dart';
import 'package:wechat_shadow/food_cook.dart';

class FavPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => new FavPageState();



}

class FavPageState extends State<FavPage>{

  List<FoodDetail> favList;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readFavData();
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("我的收藏"),

      ),
      body:ListView.separated(itemBuilder: (BuildContext context,int index){
          return _getContainerWithIndex(favList[index]);
      }, separatorBuilder:(BuildContext context,int index){
        return new Container(height: 1.0,color: Colors.grey[50]);

      }, itemCount: favList.length)
    );
  }


  _readFavData() {
    favList = new List();

    String key = "fav";
    Future <List<Map<String, dynamic>>> favMapList = file_mgr.shareins
        .readListFromKey(key);

    List<FoodDetail>tmpList = new List();

    favMapList.then((List<Map<String, dynamic>> dataList) {
      if (dataList == null) {
      }
      else {
        for (var item in dataList){
          FoodDetail f = FoodDetail.fromJson(item);
          tmpList.add(f);
        }
      }
      setState(() {
        favList = tmpList;
      });
    });
  }

   Widget _getContainerWithIndex(FoodDetail selFoodDetail){
     return new GestureDetector(
       child: new Container(
         child: Row(
           children: <Widget>[
             Container(
               child: Image.network(selFoodDetail.albums[0]),
               padding: EdgeInsets.all(10),
               width: 100,
               height: 100,
             ),
             new Text(selFoodDetail.title),
           ],
         ),
       ),
       onTap: (){
         Navigator.push(context, new MaterialPageRoute(builder: (context) => new FoodCook(
           selFoodDetail: selFoodDetail,
         ),
         ),
         );
       },
     );
    }


}

