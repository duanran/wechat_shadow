import 'package:flutter/material.dart';


class MinePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new MinePageState();

}
class MinePageState extends State<MinePage>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('我的'),
          actions: <Widget>[
            new Container()
          ],
        ),
        body:  ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15,top: 10),
                      child: Image.asset('assets/use_icon.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding : const EdgeInsets.only(left:10,top:5),
                          child: new Text('ID:'),
                        ),
                        Container(
                          padding :  const EdgeInsets.only(left:10,top:5),
                          child : new Text(
                            '15630008679',
                            style: new TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Text('0'),
                        new Text('打折卡'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Text('1'),
                        new Text('代金券'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Text('2'),
                        new Text('激活码'),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: _getListData(),
                )

              ],
            ),
          ],
        ),
      ),

    );

  }

  _getListData(){
    List <Widget> widgets = [];
    for (int i = 0; i < 100; i++){
      widgets.add(GestureDetector(
        child: Padding(padding: EdgeInsets.all(10.0),
          child: Text("Row $i"),
        ),
        onTap: (){
          print('row tapped');
        },
      )
      );
    }
    return widgets;
  }


}
