import 'dart:async';

import 'package:exhibition_guide_app/commons/custom_image_icon_btn.dart';
import 'package:exhibition_guide_app/constant.dart';
import 'package:exhibition_guide_app/exhibit/exhibit_video_view.dart';
import 'package:exhibition_guide_app/guide/exhibition_map_view.dart';
import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:exhibition_guide_app/provider/setting_provider.dart';
import 'package:exhibition_guide_app/setting/language_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../main/main_view.dart';
import '../util.dart';
import 'exhibit_all_list_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExhibitDetail extends StatefulWidget {
  final int idx;
  final String appbarTitle;
  ExhibitDetail(this.idx, {
    Key key,
    this.appbarTitle
  }) : super(key: key);

  @override
  _ExhibitDetailState createState() => _ExhibitDetailState();
}

class _ExhibitDetailState extends State<ExhibitDetail> with WidgetsBindingObserver {

  IconData playBtn = Icons.play_arrow; // 재성 시 활성 icon
  AppLocalizations _locals;

  var mqd;
  var mqw;
  var mqh;

  String idx;
  ExhibitProvider _exhibit;
  DevicesProvider _devicesProv;
  SettingProvider _settingProv;
  bool _loading;
  bool _audioPlayShow = true;

  String getTitle(String title){
    if(title == "전시유물" || title == "Relics" || title == "展示遺物" || title == "展示遺物" || title == "展示文物" ){
      return _locals.menu2;
    } else if(title == "상설전시" || title == "Permanent Exhibition" || title == "常設展示" || title == "常设展览" ){
      return _locals.menu3;
    } else if(title == "기획전시" || title == "Featured Exhibition" || title == "企画展示" || title == "策划展览" ){
      return _locals.menu4;
    } else if(title == "전시물" || title == "Exhibits" || title == "展示物" || title == "展品" ){
      return _locals.main5;
    } else if(title == "4F 전시실" || title == "4th Floor" || title == "４Ｆ 展示室" || title == "4F展厅" ){
      return _locals.main6;
    } else if(title == "5F 전시실" || title == "5th Floor" || title == "5Ｆ 展示室" || title == "5F展厅" ){
      return _locals.main7;
    } else if(title == "전시물 선택" || title == "Select an exhibit" || title == "选择展品" || title == "展示物を選択" ){
      return _locals.el4;
    }else {
      return "";
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    //앱 상태 변경 이벤트 등록

    Future.microtask((){
      // Provider.of<DevicesProvider>(context, listen: false).playAudio(),
      idx = widget.idx.toString();
      print("####### idx: $idx");
      Provider.of<DevicesProvider>(context, listen: false).setBeforeBeaconIdx(idx.toString());
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitDetSel(widget.idx);
    });

    autoAudioPlay();
  }

  @override
  void dispose() {
    //앱 상태 변경 이벤트 해제
    //문제는 앱 종료시 dispose함수가 호출되지 않아 해당 함수를 실행 할 수가 없다.
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        Provider.of<DevicesProvider>(context, listen: false).stopAudio();
        print("##### detached");
        break;
    }
  }
  void t() {
    if (_devicesProv.autoPlayAudio && _exhibit.exhibitItem != null) {
      final audio = _exhibit.getTextByLanguage(-1, 'voiceFile');
      _devicesProv.setExhibitDetAudio(audio);
      _devicesProv.playAudio();
    }
  }

  void autoAudioPlay() {
    // 음성지원 안내가 on일 경우 자동 음성 안내 시작
    // auioTimer = new Timer.periodic(const Duration(milliseconds: 100), t);
    Timer(
        Duration(seconds: 1), () {
        if (_devicesProv.autoPlayAudio && _exhibit.exhibitItem != null) {
          final audio = _exhibit.getTextByLanguage(-1, 'voiceFile');
          _devicesProv.setExhibitDetAudio(audio);
          _devicesProv.playAudio();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _exhibit = Provider.of<ExhibitProvider>(context);
    _devicesProv = Provider.of<DevicesProvider>(context);
    _settingProv = Provider.of<SettingProvider>(context);
    _locals = AppLocalizations.of(context);
    _loading = _exhibit.loading;

    // 새로운 비콘이 잡혔을 때 해당 데이터 조회
    if (_devicesProv.beforeBeaconIdx != idx) {
      idx = _devicesProv.beforeBeaconIdx;
      if (idx != "-1") {
        _exhibit.setExhibitDetSel(int.parse(_devicesProv.beforeBeaconIdx));
        autoAudioPlay();
      }
    }

    return WillPopScope(
      child: Scaffold(
        appBar: _appBar(),
        body: _mainView(),
        bottomNavigationBar: (
          _audioPlayShow
            ? (
              _exhibit.exhibitItem != null && _exhibit.exhibitItem["voiceFile"] != ""
              ? _bottomButtons()
              : null
            )
            : null),
      ),
      onWillPop: () async {

        Provider.of<DevicesProvider>(context, listen: false).stopAudio();
        return true;
      }
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(widget.appbarTitle != null ? getTitle(widget.appbarTitle) : '', style: TextStyle(color: Colors.white),),
      leading: Builder(
        builder: (BuildContext context) => (
            IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () {
                  Get.back();
                  _devicesProv.stopAudio();
                }
            )
          )
      ),
      actions: [
        _imageIconBtn(
          px: 25.0,
          iconPath: 'assets/images/button/btn-home.png',
          onAction: () {
            _devicesProv.stopAudio();
            Get.offAll(MainView());
          }
        ),
      ]
    );
  }

  Widget _mainView() {
    final _text = !_loading ? _exhibit.getTextByLanguage(-1, "content") : '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xffE5E6E7),
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 15,),
              Expanded(
                flex: 1,
                child: Text(
                    !_loading ? _exhibit.getTextByLanguage(-1, "exhibition_name"): '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff555657))
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: (
                    Container(
                        width: mqw * 0.15,
                        margin: EdgeInsets.only(right: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _imageIconBtn(
                                  px: 40.0,
                                  onAction: () {
                                    Get.off(LanguageView(idx: widget.idx), arguments: widget.appbarTitle);
                                  },
                                  iconPath: 'assets/images/icon/icon-type.png'
                              )
                            ]
                        )
                    )
                ),
              )
            ],
          )
        ),
        InkWell(
          onTap: () {
            Get.to(ExhibitAllListView());
          },
          child: Container(
            height: 60,
            color: Color(0xffE5E6E7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 15,),
                Container(
                  width: 50,
                  height: 32,
                  decoration: BoxDecoration(
                      color: Color(0xffA58C60),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Center(
                    child: Text(
                      _exhibit.exhibitItem != null ? getContentType(_exhibit.exhibitItem['contentsType']) : '',
                      style: TextStyle(color: Colors.white, fontSize: 18, height: 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                Flexible(
                  child: Text(
                    !_loading ? _exhibit.getTextByLanguage(-1, "title") : '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff555657)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
                _exhibit.exhibitItem != null ? _exhibit.exhibitItem['contentsImgFile'] : '',
                fit: BoxFit.fill
            )
        ),
        Container(
            height: mqh * 0.09,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xffF7F8F9),
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  children: [
                    _imageIconBtn(
                      px: 40.0,
                      onAction: () {
                        setState(() {
                          _audioPlayShow = true;
                        });
                        final audio = _exhibit.getTextByLanguage(-1, 'voiceFile');
                        _devicesProv.setExhibitDetAudio(audio);
                      },
                      iconPath: 'assets/images/icon/icon-headset.png',
                    ),
                    _imageIconBtn(
                      px: 40.0,
                      onAction: () async {
                        _devicesProv.stopAudio();
                        final video = _exhibit.getTextByLanguage(-1, 'videoFile');
                        print("##### video: $video");
                        await _devicesProv.setExhibitDetVideo(video);
                        Get.to(ExhibitVideoView());
                      },
                      iconPath: 'assets/images/icon/icon-movie.png',
                    ),
                    _imageIconBtn(
                      px: 40.0,
                      onAction: () {
                        _devicesProv.stopAudio();
                        Get.to(ExhibitionMapView());
                      },
                      iconPath: 'assets/images/icon/icon-map-d.png',
                    )
                  ]
              ),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: mqw * 0.03, bottom: mqh * 0.01),
                              child: (
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomImageIconBtn(
                                      px: mqw * 0.2,
                                      iconPath: (
                                          _devicesProv.isRunning
                                              ? 'assets/images/toogle-main-on.png'
                                              : 'assets/images/toogle-main-off.png'
                                      ),
                                      onAction: () {
                                        _devicesProv.becaonScan(!_devicesProv.isRunning);
                                      },
                                    ),
                                    Text(_locals.hr5, style: TextStyle(fontSize: mqw * 0.035, height: mqh * 0.0005)),
                                  ],
                                )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: mqh * 0.01),
                              child: (
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomImageIconBtn(
                                        px: mqw * 0.2,
                                        iconPath: (
                                            _devicesProv.autoPlayAudio
                                                ? 'assets/images/toogle-main-on.png'
                                                : 'assets/images/toogle-main-off.png'
                                        ),
                                        onAction: () {
                                          _devicesProv.setAutoPlayAudio(!_devicesProv.autoPlayAudio);
                                          // if (!_devicesProv.autoPlayAudio) {
                                          //   final audio = _exhibit.getTextByLanguage(-1, 'voiceFile');
                                          //   _devicesProv.setExhibitDetAudio(audio);
                                          //   _devicesProv.playAudio();
                                          // } else {
                                          //   _devicesProv.stopAudio();
                                          // }
                                        },
                                      ),
                                      Text(_locals.hr6, style: TextStyle(fontSize: mqw * 0.035, height: mqh * 0.0005)),
                                    ],
                                  )
                              ),
                            )
                          ]
                      )
                  )
                )
            ]
          )
        ),
        Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(_text, textScaleFactor: 1.2,),
                )
            )
        )
      ],
    );
  }

  Widget _imageIconBtn({ iconPath, onAction, px }) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: Container(
        width: px,
        child: Image.asset(
          iconPath,
          fit: BoxFit.fill,
        ),
      ),
      onPressed: () {
        if (onAction != null) {
          onAction();
        }
      },
    );
  }

  Widget _bottomButtons() {
    return Container(
        height: mqh * 0.09,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _audioPlay(), // 오디오 플레이어
            ]
        )
    );
  }

  Widget _audioPlay() {
    return Container(
        height: 60,
        child: Material(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _imageIconBtn(
                  px: 30.0,
                  onAction: () {
                    final audio = _exhibit.getTextByLanguage(-1, 'voiceFile');
                    _devicesProv.setExhibitDetAudio(audio);
                    _devicesProv.playAudio();
                  },
                  iconPath: (
                    _devicesProv.isPlaying
                      ? 'assets/images/button/btn-pause.png'
                      :'assets/images/button/btn-play.png'
                  )
                ),
                Text(
                  "${_devicesProv.position.inMinutes}:${_devicesProv.position.inSeconds.remainder(60)}",
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                    flex: 1,
                    child: _audioSlider()
                ),
                Text(
                  "${_devicesProv.duration.inMinutes}:${_devicesProv.duration.inSeconds.remainder(60)}",
                  style: TextStyle(color: Colors.white)
                ),
                _imageIconBtn(
                  px: 23.0,
                  onAction: () {
                    _devicesProv.stopAudio();
                    setState(() {
                      _audioPlayShow = false;
                    });
                  },
                  iconPath: 'assets/images/button/btn-cancel.png'
                )
              ],
            )
        )
    );
  }

  // 오디오 재생 슬라이드
  Widget _audioSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
        // activeTrackColor: Colors.red[700],
        // inactiveTrackColor: Colors.red[100],
        // trackShape: RectangularSliderTrackShape(),
        // trackHeight: 4.0,
        // thumbColor: Colors.redAccent,
        // overlayColor: Colors.red.withAlpha(32),
        // overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
      ),
      child: Slider(
        min: 0,
        // value: _devicesProv.position.inSeconds.toDouble(),
        value: _devicesProv.duration.inSeconds.toDouble() == 0 ? 0 : _devicesProv.position.inSeconds.toDouble(),
        max: _devicesProv.duration.inSeconds.toDouble() == 0 ? 1 : _devicesProv.duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            _devicesProv.audioPlayer.seek(new Duration(seconds: value.toInt()));
          });
        },
      )
    );
  }
}
