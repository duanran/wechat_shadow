import 'package:flutter/material.dart';
import 'models/food_model.dart';
import 'package:flutter/cupertino.dart';
import 'network/http_api.dart';
import 'models/food_detail_model.dart';
import 'food_cook.dart';
class FoodList extends StatefulWidget{
  FoodList({Key key,@required this.selFood}) : super(key:key);
  final Food selFood;

  @override
  State<StatefulWidget> createState() => new _FoodListState();

}

class _FoodListState extends State<FoodList>{

  List <FoodDetail> foodDetailList;
  GridView gridView;
  int page;
  final _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page = 0;
    foodDetailList = new List();
    _getDataList();

    _scrollController.addListener((){
      if (_scrollController.offset == _scrollController.position.maxScrollExtent){
        if (isLoading == false){
          print("------加载更多------");
          _loadMoreData();
        }

      }
    });


  }

  _loadMoreData(){
    isLoading = true;
    page = page + 1;
    List <FoodDetail> tmpList = new List();
    HttpApi.sharedIns.getDataWithIndex(widget.selFood.id, "$page", "30").then((Map<String,dynamic> resultDic){
      isLoading = false;
      List<dynamic> data = resultDic["data"];
      for (var item in data){
        FoodDetail d = FoodDetail.fromJson(item);
        tmpList.add(d);
      }
      setState(() {
        foodDetailList.addAll(tmpList);
      });

    });
  }


  _getDataList(){
    List <FoodDetail> tmpList = new List();
    HttpApi.sharedIns.getDataWithIndex(widget.selFood.id, "$page", "30").then((Map<String,dynamic> resultDic){
      List<dynamic> data = resultDic["data"];
        for (var item in data){
          FoodDetail d = FoodDetail.fromJson(item);
          tmpList.add(d);
        }
        setState(() {
          foodDetailList = tmpList;
        });

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.selFood.name),
        centerTitle: true,
      ),
      body:createGrideView(),
    );
  }


 Widget createGrideView(){
    gridView = GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: foodDetailList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (BuildContext context , int index){
          return getItemContainer(foodDetailList[index]);
        },
        controller: _scrollController,

        );

    
   return gridView;

  }



  


  List<Widget> getWidgetList(){
    return foodDetailList.map((f) => getItemContainer(f)).toList();
  }

  Widget getItemContainer(FoodDetail d){
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



  






}