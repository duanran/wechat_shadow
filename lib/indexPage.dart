
import 'navigation_icon_view.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'mine.dart';
import 'Login/Login.dart';
import 'Fav/fav_page.dart';
import 'Search/search_page.dart';

class Index extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _indexState();
}
class _indexState extends State<Index> with TickerProviderStateMixin{
  int _currentIndex = 0;
  List<NavigationIconView>_navigationViews;
  List<StatefulWidget> _pageList;
  StatefulWidget _currentPage;

  void _rebuild(){
    setState((){});
  }

  @override
  void initState(){
    super.initState();

    _navigationViews = <NavigationIconView>[
      new NavigationIconView(icon: new Icon(Icons.assessment),title: new Text("首页"),vsync: this),
      new NavigationIconView(icon: new Icon(Icons.favorite_border),title: new Text("我的收藏"),vsync: this),
//      new NavigationIconView(icon: new Icon(Icons.perm_identity),title: new Text("我的"),vsync: this),
//      new NavigationIconView(icon: new Icon(Icons.pregnant_woman),title: new Text("登录"),vsync: this),
      new NavigationIconView(icon: new Icon(Icons.search),title: new Text("搜索"),vsync: this),


    ];

    for (NavigationIconView view in _navigationViews){
      view.controller.addListener(_rebuild);
    }

    _pageList = <StatefulWidget>[
        new HomePage(),
        new FavPage(),
        new SearchPage(),
//        new MinePage(),
//        new Login(),
    ];

    _currentPage = _pageList[_currentIndex];

  }

  @override
  Widget build(BuildContext context){
    final BottomNavigationBar bottomNavigationBar = new BottomNavigationBar(
        items: _navigationViews.map((NavigationIconView navigationIconView) => navigationIconView.item).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
          setState(() {
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
            _currentPage = _pageList[_currentIndex];
          });
      },
    );

    return new MaterialApp(
        home: new Scaffold(
        body: new Center(
        child: _currentPage   // 动态的展示我们当前的页面
    ),
    bottomNavigationBar: bottomNavigationBar,   // 底部工具栏
    ),

    theme: new ThemeData(
    primarySwatch: Colors.blue,   // 设置主题颜色
    ),

    );
    
  }



}