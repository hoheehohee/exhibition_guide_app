import 'package:exhibition_guide_app/main/slider_drawers.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class ExhibitThemeView extends StatefulWidget {
  final appBarTitle;
  final location;

  ExhibitThemeView({
    Key key,
    this.appBarTitle,
    this.location
  }): super(key: key);

  @override
  _ExhibitThemeViewState createState() => _ExhibitThemeViewState();
}

class _ExhibitThemeViewState extends State<ExhibitThemeView> {
  var mqd;
  var mqw;
  var mqh;
  bool show = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => {
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitThemeListSel(widget.location)
    });
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      backgroundColor: backgroundColor,
      endDrawer: Drawer(
          child: Container(
            color: Color(0xff1A1A1B),
            child: SliderDrawers(),
          )
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.all(mqw * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _dataItem(),
                _dataItem()
              ],
            )
        ),
      )
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(widget.appBarTitle != null ? widget.appBarTitle : '', style: TextStyle(color: Colors.white),),
      actions:[
        IconButton(
          icon: new Icon(Icons.menu, size: mqw * 0.08, color: Colors.white,),
          onPressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ],
      leading: new Container(),
    );
  }

  Widget _dataItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                show = !show;
              });
            },
            child: Container(
              width: double.infinity,
              height: show ? mqh * 0.22 : mqh * 0.17,
              decoration: BoxDecoration(
                  borderRadius: (
                      show
                          ? BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))
                          : BorderRadius.circular(8.0)
                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRin2FtYAFZIK4Yv-fCVboJylGVZSS9u-lM3w&usqp=CAU",
                      )
                  )
              ),
              child: Align(
                  alignment: Alignment(-0.75, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "테스트 글씨",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "테스트 글씨글씨글씨글씨",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )
              ),
            ),
          ),
          show ? (
              Container(
                width: double.infinity,
                height: mqh * 0.22,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                ),
                child: Text(
                  "sdgsdgsdgsdgsdfdsfsdfdsfsfssdfsfd",
                  style: TextStyle(fontSize: 18),
                ),
              )
          ) : Container()
        ],
      ),
    );
  }
}
