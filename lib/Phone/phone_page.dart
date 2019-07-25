import 'package:flutter/material.dart';
import 'package:wechat_shadow/models/device_model.dart';
import 'package:wechat_shadow/network/http_api.dart';
import 'phone_charge_list.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PhonePage extends StatefulWidget{
  @override
  State <StatefulWidget> createState() => PhonePageState();

}


class PhonePageState extends State<PhonePage> {

  List<deviceModel> deviceList;
  final _scrollController = ScrollController() ;
  final minScale = 0.8;


  PageController pageController;



  @override
  void initState() {
    // TODO: implement initState



    _scrollController.addListener((){
      double off = _scrollController.offset;
        print("off=$off");

    });

    pageController = PageController(initialPage: 0,viewportFraction: 0.75);

    _getDeviceList();

    super.initState();


  }






  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    double phoneW = (h - 200) * 0.56;
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("爱云兔云手机"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        height: h -200,
        width: W,
        child: PageView.builder(

            controller: pageController,
            itemBuilder: _buildBannerView,
            itemCount: deviceList.length,
        ),
        color: Colors.yellow,
      ),
    );
  }

  Widget _indexedWidgetBuilder(BuildContext context, int index) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // 控制滑动缩放
          final width = constraints.biggest.width;
          print("width=$width");
          final minX = width * index;
          final maxX = width * (index + 1);
          final offset = pageController.offset;
          var scaleFactor = 1.0;
          if ((offset - minX).toInt() == 0) {
            return _buildBannerView(context, index);
          }

          if (offset - minX > 0 && offset - maxX < 0) {
            var o = maxX - offset;
            scaleFactor = minScale + o / width * (1.0 - minScale);
          } else if (minX - offset > 0 && minX - offset < width) {
            var o = minX - offset;
            scaleFactor = minScale + (1.0 - o / width) * (1.0 - minScale);
          } else if ((minX - offset).toInt() == 0) {
            scaleFactor = 1.0;
            return _buildBannerView(context, index);
          } else {
            // 保持最小
            scaleFactor = minScale;
          }

          return Transform.scale(
            scale: 1.0,
            child: _buildBannerView(context, index),
          );
        });
//      debugPrint("context size ${context.size}");
  }


  Widget _buildBannerView(BuildContext context, int index){
      deviceModel m = deviceList[index];
      if (m.id == -1){
        return getEmptyPhone();
      }
      else{
        return getNormalPhone(m);

      }
  }

  _getDeviceList(){
    deviceList = new List();
    List<deviceModel>tmpList = new List();
    HttpApi.sharedIns.getDeviceList().then((List<dynamic>arr){
      for (var item in arr){
        print("item=$item");
        deviceModel m = deviceModel.fromJson(item);
        print("m=$m");
        tmpList.add(m);
      }
      deviceModel emptyModel =  new deviceModel(id: -1);
      tmpList.add(emptyModel);
      setState(() {
        deviceList = tmpList;
      });

    });
  }

  Widget getEmptyPhone(){
    double phoneH = MediaQuery.of(context).size.height - 200;

    return GestureDetector(
      onTap: (){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new PhoneChargeList()),);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
              SizedBox(
                height: 0,
               ),
              Container(
                margin: EdgeInsets.only(left: 0),
                child: Image.asset('assets/buy.png'),
              ),
             Container(
              child: new MaterialButton(
                  color: const Color(0xFFFF6667),
                  textColor: Colors.white,
                  child: Text("确认购买"),
                  minWidth: MediaQuery.of(context).size.width,
                  height: 48,
                  onPressed: (){

                  }),
              color: Colors.white,
            ),
          ],
        ),
        color: Colors.red,
      ),
    );
  }


  Widget getNormalPhone(deviceModel model){
    return GestureDetector(
      onTap: (){
        if (model.status != 1){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new PhoneChargeList()),);
        }
        else{
          print("进入云游戏");
        }

      },
      child: Stack(
          children: <Widget>[
            Container(
              child: Image.asset('assets/phonebg@2x.png'),
              color: const Color(0xFFFE8F75),
            ),
          ],
      ),
    );
  }





  
//  Widget getCard(int index){
//    if (index == 0){
//      return Stack(
//        children: <Widget>[
//          new Image.asset('assets/vip@2x.png'),
//          new Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              new Container(
//                margin: EdgeInsets.only(left: 18,top: 18),
//                child: new Text(
//                  "VIP云手机",
//                  style: TextStyle(
//                    color: const Color(0xFF3A0707),
//                    fontSize: 24.0,
//                  ),
//                ),
//              ),
//              new Container(
//                margin: EdgeInsets.only(left: 18,top: 10),
//                child: new Text(
//                  "标准级配置，系统流畅性良好",
//                  style: TextStyle(
//                    color: const Color(0xFF3A0707),
//                    fontSize: 12.0,
//                  ),
//                ),
//              ),
//              new Container(
//                margin: EdgeInsets.only(left: 18,top: 4),
//                child: new Text(
//                  "支持标清画质，游戏操作体验流畅",
//                  style: TextStyle(
//                    color: const Color(0xFF3A0707),
//                    fontSize: 12.0,
//                  ),
//                ),
//              ),
//              new Container(
//                margin: EdgeInsets.only(left: 18,top: 4),
//                child: new Text(
//                  "操作便捷，使用体验良好",
//                  style: TextStyle(
//                    color: const Color(0xFF3A0707),
//                    fontSize: 12.0,
//                  ),
//                ),
//              ),
//
//            ],
//          ),
//
//        ],
//      );
//    }
//    else if (index == 1){
//      return Stack(
//        children: <Widget>[
//          new Image.asset('assets/Gvip@2x.png'),
//          new Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              new Container(
//                margin: EdgeInsets.only(left: 18,top: 18),
//                child: new Text(
//                  "GVIP云手机",
//                  style: TextStyle(
//                    color: const Color(0xFF3A0707),
//                    fontSize: 24.0,
//                  ),
//                ),
//              ),
//              new Container(
//                margin: EdgeInsets.only(left: 18,top: 10),
//                child: new Text(
//                  "类似原生手机系统的舒适体验",
//                  style: TextStyle(
//                    color: const Color(0xFF3A0707),
//                    fontSize: 12.0,
//                  ),
//                ),
//              ),
//              new Container(
//                margin: EdgeInsets.only(left: 18,top: 4),
//                child: new Text(
//                  "支持超清画质，游戏极致体验",
//                  style: TextStyle(
//                    color: const Color(0xFF3A0707),
//                    fontSize: 12.0,
//                  ),
//                ),
//              ),
//              new Container(
//                margin: EdgeInsets.only(left: 18,top: 4),
//                child: new Text(
//                  "GVIP专属网络通道，网络稳定性强",
//                  style: TextStyle(
//                    color: const Color(0xFF3A0707),
//                    fontSize: 12.0,
//                  ),
//                ),
//              ),
//
//            ],
//          ),
//
//        ],
//      );
//    }
//    else{return Stack(
//      children: <Widget>[
//        new Image.asset('assets/base.png'),
//        new Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            new Container(
//              margin: EdgeInsets.only(left: 18,top: 18),
//              child: new Text(
//                "基础班云手机",
//                style: TextStyle(
//                  color: const Color(0xFF3A0707),
//                  fontSize: 24.0,
//                ),
//              ),
//            ),
//            new Container(
//              margin: EdgeInsets.only(left: 18,top: 10),
//              child: new Text(
//                "基础级配置，系统稳定性高",
//                style: TextStyle(
//                  color: const Color(0xFF3A0707),
//                  fontSize: 12.0,
//                ),
//              ),
//            ),
//            new Container(
//              margin: EdgeInsets.only(left: 18,top: 4),
//              child: new Text(
//                "游戏操作体验流畅",
//                style: TextStyle(
//                  color: const Color(0xFF3A0707),
//                  fontSize: 12.0,
//                ),
//              ),
//            ),
//            new Container(
//              margin: EdgeInsets.only(left: 18,top: 4),
//              child: new Text(
//                "推荐部落冲突coc玩家使用",
//                style: TextStyle(
//                  color: const Color(0xFF3A0707),
//                  fontSize: 12.0,
//                ),
//              ),
//            ),
//
//          ],
//        ),
//
//      ],
//    );
//    }
//  }
  Widget getPhone(int index){
    double h = MediaQuery.of(context).size.height;
    double W = MediaQuery.of(context).size.width;
    double phoneW = (h - 200) * 0.56;

    print("h=$h");
    if (index == 0){
      Column col = new Column(
        children: <Widget>[
          Container(
            child: new GestureDetector(
              child: Image.asset('assets/buy.png'),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new PhoneChargeList()),);
              },
            ),
            width: phoneW,
            height: h - 200,
            margin: EdgeInsets.only(top: 20,left: ((W - phoneW)/2)-30,right: ((W - phoneW)/2)-30),
            color: Colors.blue,
          ),
        ],
      );
      return col;
    }
    else{
      Column col = new Column(
        children: <Widget>[
          Container(
            child: new GestureDetector(
              child: Image.asset('assets/buy.png'),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new PhoneChargeList()),);
              },
            ),
            width: phoneW,
            height: h - 200,
            margin: EdgeInsets.only(top: 20,left: ((W - phoneW)/2)-30,right: ((W - phoneW)/2)-30),
            color: Colors.red,
          ),
        ],
      );
      return col;
    }



  }

  List<Widget> getScrollView(){
    List<Widget> widges = new List();
    for (int i = 0;i < deviceList.length;i++){
      deviceModel m = deviceList[i];
      Container c = new Container(
        margin: EdgeInsets.all(10),
        child: Text(m.title),
        color: Colors.blue,

      );
      widges.add(c);
    }

    Container lastc = new Container(
      child: new GestureDetector(
        child: Image.asset('assets/buy.png'),
        onTap: (){
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new PhoneChargeList()),);
        },
      ),
      color: Colors.yellow,
    );
    widges.add(lastc);

    return widges;
  }



}