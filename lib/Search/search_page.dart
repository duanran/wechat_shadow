import 'package:flutter/material.dart';
import 'package:wechat_shadow/models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat_shadow/network/http_api.dart';
import 'package:wechat_shadow/models/food_detail_model.dart';
import 'package:wechat_shadow/food_cook.dart';
import 'package:dio/dio.dart';


// 模拟的假数据
const searchList = [
  "pai-排骨",
  "dou-豆腐",
];

const recentSuggest = [
  "排骨",
  "豆腐"
];


class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new SearchPageState();


}

class SearchPageState extends State<SearchPage>{
  List <FoodDetail> foodDetailList;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
       title: new Text("搜索"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed:(){
                showSearch(context: context, delegate: SearchBar());
              }),
        ],
      ),
      body: null,

    );
  }

}


class SearchBar extends SearchDelegate<String>{

  @override
  List<Widget> buildActions(BuildContext context){
    return[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  // 点击箭头返回
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        // 使用动画效果返回
        icon: AnimatedIcons.menu_arrow,progress: transitionAnimation,
      ),
      // 点击的时候关闭页面（上下文）
      onPressed: (){
        close(context, null);
      },
    );
  }



  // 点击搜索出现结果
  @override
  Widget buildResults(BuildContext context) {
    //    return getGradList(context, tmpList);
    return buildSearchFutureBuilder(query);

  }

  Future <List<FoodDetail>>  getData(String key) async{
    List <FoodDetail> tmpList = new List();
    var dio = new Dio();
      Response res = await dio.get("http://apis.juhe.cn/cook/query.php?menu=$key&pn=0&rn=30&key=84390d67a16a558277db61a2a55f4036");
      Map<String,dynamic> resultDic = res.data["result"];
       List<dynamic> arr = resultDic["data"];
        for (var item in arr){
        FoodDetail d = FoodDetail.fromJson(item);
        tmpList.add(d);
      };
      return tmpList;
  }

  Future <List<FoodDetail>> searchData(String key) async{
    List <FoodDetail> tmpList = new List();
   await HttpApi.sharedIns.searchDataWithName(key, "0", "30").then((Map<String,dynamic> resultDic){
      List<dynamic> data = resultDic["data"];
      for (var item in data){
        print("item=$item");
        FoodDetail d = FoodDetail.fromJson(item);
        tmpList.add(d);
      };
    });
    return tmpList;

  }

  FutureBuilder<List<FoodDetail>> buildSearchFutureBuilder(String key){
    return new FutureBuilder<List<FoodDetail>>(
        builder: (context, AsyncSnapshot<List<FoodDetail>> async){
          if (async.connectionState == ConnectionState.active || async.connectionState == ConnectionState.waiting){
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }

          if (async.connectionState == ConnectionState.done){
            if (async.hasError){
              return new Center(
                child: new Text('Error:code '),
              );
            }
           else if (async.hasData){
              List<FoodDetail> tmpList = async.data;

              return getGradList(context, tmpList);
            }
           else{

              return new Center(
                child: new CircularProgressIndicator(),
              );
            }

          }
        },
      future: searchData(key),
    );
  }

//  List <FoodDetail> run(String key) async{
//    List <FoodDetail> list = awiat getData(key);
//    return list;
//  }




  Widget getGradList(BuildContext context,List <FoodDetail> tmpList){

    return new GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: tmpList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (BuildContext context , int index){
        return getItemContainer(context,tmpList[index]);
      },

    );
  }

  Widget getItemContainer(BuildContext context,FoodDetail d){
    return new GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            child: Image.network(d.albums[0]),
          ),
          new Text(d.title),
        ],
      ),
      onTap: (){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new FoodCook(
          selFoodDetail: d,
        ),
        ),
        );
      },
    );

  }




  // 搜索下拉框提示的方法
  @override
  Widget buildSuggestions(BuildContext context) {
    // 定义变量 并进行判断
    final suggestionList = query.isEmpty
        ? recentSuggest
        :searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context,index){
          return  new GestureDetector(
            child: getSuggestions(suggestionList,index),
            onTap:() {
              query = suggestionList[index];
            },
          );
        }
    );
  }

  Widget getSuggestions(List<dynamic>suggestionList , int index){
    return new ListTile(
        title: RichText(
            text: TextSpan(
              // 获取搜索框内输入的字符串，设置它的颜色并让让加粗
                text: suggestionList[index].substring(0, query.length),
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    //获取剩下的字符串，并让它变成灰色
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ]
            ),
        )
    );
  }


}


