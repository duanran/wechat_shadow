import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wechat_shadow/network/http_api.dart';
import 'package:wechat_shadow/models/paid_model.dart';

class PhoneChargeList extends StatefulWidget{
  @override
  State <StatefulWidget> createState() => PhoneChargeListState();


}


class PhoneChargeListState extends State<PhoneChargeList>{

  String payType;
  List<PaidModel>topModelList;
  List<PaidModel>normalMoedelList;

  PaidModel currentModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    topModelList = new List();
    normalMoedelList = new List();

    getPriceList(0);


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text("购买云手机"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 24),
            child: new Swiper(
              pagination: new SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  color: const Color(0xFFE6E6E6),
                  activeColor: const Color(0xFFFF6667),

                )

              ),
//          layout: SwiperLayout.CUSTOM,
//          customLayoutOption: new CustomLay.outOption(
//            startIndex: -1,
//            stateCount: 3,
//
//          ).addRotate([
//            -45.0/180,
//            0.0,
//            45.0/180,
//          ]).addTranslate(
//            [
//              new Offset(-370, -40),
//              new Offset(0, 0),
//              new Offset(370, -40),
//            ]
//          ),
              itemBuilder: (BuildContext context,int index){
                return getCard(index);
              },
              itemCount: 3,
//          itemWidth: MediaQuery.of(context).size.width - 96,
              scale: 0.8,
              viewportFraction: 0.7,
              onIndexChanged:(int vaule){
                print("vaule=$vaule");
                getPriceList(vaule);
              },
            ),
            height: 162,
            color: const Color(0xFFf5f5f5),
          ),
          new Expanded(
              child: new ListView(
                  children: getTopCell(),
              ),
          ),
          new MaterialButton(
              color: const Color(0xFFFF6667),
              textColor: Colors.white,
              child: Text("确认购买"),
              minWidth: MediaQuery.of(context).size.width,
              height: 48,
              onPressed: (){

          }),




        ],
      )
    );
  }




  Widget getCard(int index){
    if (index == 0){
     return Stack(
       children: <Widget>[
         new Image.asset('assets/vip@2x.png'),
         new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left: 18,top: 18),
                child: new Text(
                  "VIP云手机",
                  style: TextStyle(
                    color: const Color(0xFF3A0707),
                    fontSize: 24.0,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 18,top: 10),
                child: new Text(
                  "标准级配置，系统流畅性良好",
                  style: TextStyle(
                    color: const Color(0xFF3A0707),
                    fontSize: 12.0,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 18,top: 4),
                child: new Text(
                  "支持标清画质，游戏操作体验流畅",
                  style: TextStyle(
                    color: const Color(0xFF3A0707),
                    fontSize: 12.0,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 18,top: 4),
                child: new Text(
                  "操作便捷，使用体验良好",
                  style: TextStyle(
                    color: const Color(0xFF3A0707),
                    fontSize: 12.0,
                  ),
                ),
              ),

            ],
         ),

       ],
     );
    }
    else if (index == 1){
      return Stack(
        children: <Widget>[
          new Image.asset('assets/Gvip@2x.png'),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left: 18,top: 18),
                child: new Text(
                  "GVIP云手机",
                  style: TextStyle(
                    color: const Color(0xFF3A0707),
                    fontSize: 24.0,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 18,top: 10),
                child: new Text(
                  "类似原生手机系统的舒适体验",
                  style: TextStyle(
                    color: const Color(0xFF3A0707),
                    fontSize: 12.0,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 18,top: 4),
                child: new Text(
                  "支持超清画质，游戏极致体验",
                  style: TextStyle(
                    color: const Color(0xFF3A0707),
                    fontSize: 12.0,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 18,top: 4),
                child: new Text(
                  "GVIP专属网络通道，网络稳定性强",
                  style: TextStyle(
                    color: const Color(0xFF3A0707),
                    fontSize: 12.0,
                  ),
                ),
              ),

            ],
          ),

        ],
      );
    }
    else{return Stack(
      children: <Widget>[
        new Image.asset('assets/base.png'),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(left: 18,top: 18),
              child: new Text(
                "基础班云手机",
                style: TextStyle(
                  color: const Color(0xFF3A0707),
                  fontSize: 24.0,
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(left: 18,top: 10),
              child: new Text(
                "基础级配置，系统稳定性高",
                style: TextStyle(
                  color: const Color(0xFF3A0707),
                  fontSize: 12.0,
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(left: 18,top: 4),
              child: new Text(
                "游戏操作体验流畅",
                style: TextStyle(
                  color: const Color(0xFF3A0707),
                  fontSize: 12.0,
                ),
              ),
            ),
            new Container(
              margin: EdgeInsets.only(left: 18,top: 4),
              child: new Text(
                "推荐部落冲突coc玩家使用",
                style: TextStyle(
                  color: const Color(0xFF3A0707),
                  fontSize: 12.0,
                ),
              ),
            ),

          ],
        ),

      ],
    );
    }
  }

  List<Widget>getTopCell(){
    List<Widget> widgets = new List();

    for (int i = 0;i < topModelList.length; i++){
      PaidModel m = topModelList[i];
      String tit = m.title;
      Container c = new Container(
        margin: EdgeInsets.all(18),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12,top: 12),
                  child: Text(
                    "$tit",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color(0xFF3A0707),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 12,top: 8),
                      child: Image.asset('assets/fire@2x.png'),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3,top: 8),
                      child: Text(
                        m.subtitle,
                        style: TextStyle(
                          fontSize: 10,
                          color: const Color(0xFF3A0707),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          m.official_price,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            color: const Color(0xFF3A0707),
                          ),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          m.price.toString(),
                          style: TextStyle(
                            fontSize: 28,
                            color: const Color(0xFFFF6667),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "元",
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color(0xFF3A0707),
                          ),
                        ),


                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 12,right: 12),
                  )

                ],
              ),
            ),

          ],
        ),
        height: 86,
        decoration: new BoxDecoration(
          color: getTopBg(m),
          border: Border.all(
            color: getTopBorder(m),
            width: 1,
          )
        ),

      );

      GestureDetector g = new GestureDetector(
        child: c,
        onTap: (){
            print("$i");
            setState(() {
              currentModel = m;
            });
        },
      );

        widgets.add(g);
    }

   Container toptitle = new Container(
      margin: EdgeInsets.only(left: 18),
      child: getTopTitle(),
    );

    widgets.insert(0,toptitle);



    Container norTitle = new Container(
      margin: EdgeInsets.only(left: 18),
      child: Text(
          "其他套餐",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    if (normalMoedelList.length > 0){
      widgets.add(norTitle);
    }

    for (int j = 0; j < normalMoedelList.length;j++){
      PaidModel n = normalMoedelList[j];
      Container c = new Container(
        decoration: new BoxDecoration(
          color: getTopBg(n),
          border: Border.all(
            width: 1,
            color: getTopBorder(n),
          )
        ),
        margin: EdgeInsets.all(18),
        height: 50,
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                n.title,
                style: TextStyle(
                  fontSize: 12,
                  color: const Color(0xFF3A0707),
                ),
              ),
              margin: EdgeInsets.only(left: 12),
            ),
            Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            n.price.toString(),
                            style: TextStyle(
                              color: const Color(0xFFFF6667),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
            ),

            Container(
              margin: EdgeInsets.only(right: 12),
              child: Text(
                "元",
                style: TextStyle(
                  color: const Color(0xFF3A0707),
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
      );


      GestureDetector g = new GestureDetector(
        onTap: (){
          setState(() {
            currentModel = n;
          });
        },
        child: c,
      );
      widgets.add(g);

    }








    return widgets;
  }

  Color getTopBg(PaidModel m){
    if (m == currentModel){
      return const Color(0xFFFFF7DC);
    }
    else{
      return const Color(0xFFEEEEEE);
    }
  }

  Widget getTopTitle(){
    if (topModelList.length > 0){
      return  Text(
          "超值套餐",
          style: TextStyle(
          fontSize: 18,
          color: const Color(0xFF222222),
            fontWeight: FontWeight.bold,
      ),
      );
    }
    else {
      return null;
    }
  }

  Color getTopBorder(PaidModel m){
    if (m == currentModel){
      return const Color(0xFFEED2C3);
    }
    else{
      return const Color(0xFFEEEEEE);
    }
  }
  


  getPriceList(int page){
    String deviceType;
    if (page == 0){
      deviceType = "2";
    }
    else if (page == 1){
      deviceType = "1";
    }
    else {
      deviceType = "3";
    }

//    if type == payType.payTypeFirst {
//    pt = 1;
//    }
//    else{
//    pt = 2;
//    }
//
//    String pt
//
//    if (payType == "1"){
//
//    }

    HttpApi.sharedIns.getPriceList(deviceType, "1").then((Map<String,dynamic> data){
      print("data=$data");
      List<dynamic>topArr = data["top_list"];
      List<dynamic>normallArr = data["normal_list"];


      List<PaidModel>tmpArr = new List();
      List<PaidModel>norTmpArr = new List();

      for (var item in topArr){
         PaidModel m = PaidModel.fromJson(item);
         tmpArr.add(m);
      }


      for (var item in normallArr){
        PaidModel m = PaidModel.fromJson(item);
        norTmpArr.add(m);
      }

      setState(() {
          topModelList = tmpArr;
          normalMoedelList = norTmpArr;
      });
      



    });


  }

//  List<Widget> getCards(){
//    List<Widget> widgets = new List();
//
//    for (int i = 0;i < 3;i++){
//      if (i == 0){
//        Container c = new Container(
//          margin: EdgeInsets.only(left: 48,right: 48),
//          child: Image.asset('assets/vip@2x.png'),
//        );
//        widgets.add(c);
//      }
//      else if (i == 1){
//        Container c = new Container(
//          margin: EdgeInsets.only(left: 48,right: 48),
//          child: Image.asset('assets/Gvip@2x.png'),
//        );
//        widgets.add(c);
//      }
//      else{
//        Container c = new Container(
//          margin: EdgeInsets.only(left: 48,right: 48),
//          child: Image.asset('assets/base.png'),
//        );
//        widgets.add(c);
//      }
//
//    }
//    return widgets;
//
//
//  }

}

