import 'dart:async';

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

  var mqd;
  var mqw;
  var mqh;
  String idx;
  ExhibitProvider _exhibit;
  DevicesProvider _device;
  SettingProvider _settingProv;
  bool _loading;
  bool _audioPlayShow = true;

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      // Provider.of<DevicesProvider>(context, listen: false).playAudio(),
      idx = widget.idx.toString();
      Provider.of<DevicesProvider>(context, listen: false).setBeforeBeaconIdx(idx.toString());
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitDetSel(widget.idx);
    });

    // 음성지원 안내가 on일 경우 자동 음성 안내 시작
    Timer(
      Duration(seconds: 3), () {
        if (_device.autoPlayAudio && _exhibit.exhibitItem != null) {
          final audio = _exhibit.getTextByLanguage(-1, 'voiceFile');
          _device.setExhibitDetAudio(audio);
          _device.playAudio();
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
    _device = Provider.of<DevicesProvider>(context);
    _settingProv = Provider.of<SettingProvider>(context);
    _loading = _exhibit.loading;

    // 새로운 비콘이 잡혔을 때 해당 데이터 조회
    if (_device.beforeBeaconIdx != idx) {
      idx = _device.beforeBeaconIdx;
      if (idx != "-1") {
        _exhibit.setExhibitDetSel(int.parse(_device.beforeBeaconIdx));
      }
    }

    return Scaffold(
      appBar: _appBar(),
      body: _mainView(),
      bottomNavigationBar: _audioPlayShow ?  _bottomButtons() : null,
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        widget.appbarTitle != null ? widget.appbarTitle : "",
        style: TextStyle(color: Colors.white),
      ),
      leading: Builder(
        builder: (BuildContext context) => (
            IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () {
                  Get.back();
                  _device.stopAudio();
                }
            )
          )
      ),
      actions: [
        _imageIconBtn(
          px: 25.0,
          iconPath: 'assets/images/button/btn-home.png',
          onAction: () {
            _device.stopAudio();
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
                        width: 60,
                        margin: EdgeInsets.only(right: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                  "assets/images/icon/icon-qr-on.png",
                                  width: 25,
                                  fit: BoxFit.fill
                              ),
                              Image.asset(
                                  "assets/images/icon/icon-bluetooth.png",
                                  color: Color(0xff2E667B),
                                  width: 25,
                                  fit: BoxFit.fill
                              ),
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
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xffF7F8F9),
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    _imageIconBtn(
                      px: 40.0,
                      onAction: () {
                        setState(() {
                          _audioPlayShow = true;
                        });
                        final audio = _exhibit.getTextByLanguage(-1, 'voiceFile');
                        _device.setExhibitDetAudio(audio);
                      },
                      iconPath: 'assets/images/icon/icon-headset.png',
                    ),
                    _imageIconBtn(
                      px: 40.0,
                      onAction: () async {
                        _device.stopAudio();
                        final video = _exhibit.getTextByLanguage(-1, 'videoFile');
                        print("##### video: $video");
                        await _device.setExhibitDetVideo(video);
                        Get.to(ExhibitVideoView());
                      },
                      iconPath: 'assets/images/icon/icon-movie.png',
                    ),
                    _imageIconBtn(
                      px: 40.0,
                      onAction: () {
                        _device.stopAudio();
                        Get.to(ExhibitionMapView());
                      },
                      iconPath: 'assets/images/icon/icon-map-d.png',
                    )
                  ]
                )
            ),
            Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _imageIconBtn(
                            px: 40.0,
                            onAction: () {},
                            iconPath: 'assets/images/icon/icon-share.png'
                          ),
                          _imageIconBtn(
                            px: 40.0,
                            onAction: () {
                              Get.off(LanguageView(idx: widget.idx));
                            },
                            iconPath: 'assets/images/icon/icon-type.png'
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
                    _device.setExhibitDetAudio(audio);
                    _device.playAudio();
                  },
                  iconPath: (
                    _device.isPlaying
                      ? 'assets/images/button/btn-pause.png'
                      :'assets/images/button/btn-play.png'
                  )
                ),
                Text(
                  "${_device.position.inMinutes}:${_device.position.inSeconds.remainder(60)}",
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                    flex: 1,
                    child: _audioSlider()
                ),
                Text(
                  "${_device.duration.inMinutes}:${_device.duration.inSeconds.remainder(60)}",
                  style: TextStyle(color: Colors.white)
                ),
                _imageIconBtn(
                  px: 23.0,
                  onAction: () {
                    _device.stopAudio();
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
        // value: _device.position.inSeconds.toDouble(),
        value: _device.duration.inSeconds.toDouble() == 0 ? 0 : _device.position.inSeconds.toDouble(),
        max: _device.duration.inSeconds.toDouble() == 0 ? 1 : _device.duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            _device.audioPlayer.seek(new Duration(seconds: value.toInt()));
          });
        },
      )
    );
  }
}
