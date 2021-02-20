import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:exhibition_guide_app/provider/social_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../util.dart';
import 'mypage_view.dart';

class AgreeDialogView extends StatefulWidget {
  final String snsType;
  final String email;

  AgreeDialogView(this.snsType, this.email);

  @override
  _AgreeDialogViewState createState() => _AgreeDialogViewState();
}

class _AgreeDialogViewState extends State<AgreeDialogView> {
  var mqd;
  var mqw;
  var mqh;

  bool allCheck = false;
  bool collect = false;
  bool use = false;
  bool retention = false;
  bool email = false;
  SocialProvider _social;

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  AppLocalizations _locals;

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;
    _locals = AppLocalizations.of(context);

    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          )
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/img-back.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _appBar(),
                _arrgeForm(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: Colors.white,
          child: IconButton(
            splashRadius: 20,
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.clear),
          ),
        ),
      ],
    );
  }

  Widget _arrgeForm() {
    _social = Provider.of<SocialProvider>(context, listen: false);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/sns-logo.png", height: mqh * 0.13,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageIconBtn(
                  px: 25.0,
                  iconPath: (
                    allCheck || (collect && use && retention)
                      ? "assets/images/button/btn-all-check-on.png"
                      : "assets/images/button/btn-all-check-off.png"
                  ),
                  onAction: () {
                    setState(() {
                      collect = !allCheck;
                      use = !allCheck;
                      retention = !allCheck;
                      allCheck = !allCheck;
                    });
                  },
                ),
                Text(_locals.agree1, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: mqh * 0.02,
                bottom: mqh * 0.02,
                right: mqw * 0.03
              ),
              decoration: BoxDecoration(
                color: Color(0xffE5E6E7),
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageIconBtn(
                        px: 25.0,
                        iconPath: (
                          collect
                            ? "assets/images/button/btn-radio-on.png"
                            : "assets/images/button/btn-radio-off.png"
                        ),
                        onAction: () {
                          setState(() {
                            collect = !collect;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: mqh * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_locals.agree2, style: TextStyle(fontSize: 16)),
                              SizedBox(height: 3),
                              Text("- ${_locals.agree3}", style: TextStyle(fontSize: 13),)
                            ],
                          ),
                        ),
                      ),
                      Text(_locals.agree8),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageIconBtn(
                        px: 25.0,
                        iconPath: (
                          use
                            ? "assets/images/button/btn-radio-on.png"
                            : "assets/images/button/btn-radio-off.png"
                        ),
                        onAction: () {
                          setState(() {
                            use = !use;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: mqh * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_locals.agree4, style: TextStyle(fontSize: 16)),
                              SizedBox(height: 3),
                              Text("- ${_locals.agree5}", style: TextStyle(fontSize: 13),)
                            ],
                          ),
                        ),
                      ),
                      Text(_locals.agree8),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageIconBtn(
                        px: 25.0,
                        iconPath: (
                          retention
                            ? "assets/images/button/btn-radio-on.png"
                            : "assets/images/button/btn-radio-off.png"
                        ),
                        onAction: () {
                          setState(() {
                            retention = !retention;
                          });
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: mqh * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_locals.agree6, style: TextStyle(fontSize: 16)),
                              SizedBox(height: 3),
                              Text("- ${_locals.agree7}", style: TextStyle(fontSize: 13),)
                            ],
                          ),
                        ),
                      ),
                      Text(_locals.agree8),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: mqh * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(_locals.agree9, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ],
            ),
            SizedBox(height: mqh * 0.02),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  top: mqh * 0.005,
                  bottom: mqh * 0.005,
                  right: mqw * 0.03
              ),
              decoration: BoxDecoration(
                  color: Color(0xffE5E6E7),
                  borderRadius: BorderRadius.circular(5.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImageIconBtn(
                    px: 25.0,
                    iconPath: (
                        email
                            ? "assets/images/button/btn-radio-on.png"
                            : "assets/images/button/btn-radio-off.png"
                    ),
                    onAction: () {
                      setState(() {
                        email = !email;
                      });
                    },
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(_locals.agree10, style: TextStyle(fontSize: 16)),
                  ),
                  Text(_locals.agree8),
                ],
              ),
            ),
            SizedBox(height: mqh * 0.02,),
            Container(
                width: double.infinity,
                height: mqh * 0.08,
                // margin: EdgeInsets.only(bottom: 18, left: 10, right: 10),
                child: RaisedButton(
                  color: Color(0xff293F52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(_locals.etc2, style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () async {
                      if(!email){
                          g_showMyDialog(_locals.alert2, context);
                        } else if(!collect){
                          g_showMyDialog(_locals.alert3, context);
                        } else if(!use){
                          g_showMyDialog(_locals.alert4, context);
                        } else if(!retention){
                          g_showMyDialog(_locals.alert5, context);
                        } else {
                          Map data = {"snsType": widget.snsType, "email": widget.email};
                          var join = await _social.joinServer(data);
                          if(join == "Y"){
                            await g_showMyDialog(_locals.alert6, context);
                            Get.to(MyPageView(0));
                          }
                        }
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}
