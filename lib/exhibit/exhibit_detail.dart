import 'dart:async';

import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:exhibition_guide_app/provider/exhibit_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../main/main_view.dart';

class ExhibitDetail extends StatefulWidget {
  final int idx;
  ExhibitDetail(this.idx);

  @override
  _ExhibitDetailState createState() => _ExhibitDetailState();
}

class _ExhibitDetailState extends State<ExhibitDetail> with WidgetsBindingObserver {

  IconData playBtn = Icons.play_arrow; // 재성 시 활성 icon
  BuildContext _context;

  @override
  void initState() {
    super.initState();

    Future.microtask(() => {
      Provider.of<DevicesProvider>(context, listen: false).init(),
      Provider.of<ExhibitProvider>(context, listen: false).setExhibitDetSel(widget.idx)
    });
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<DevicesProvider>(context, listen: false).dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _exhibit = Provider.of<ExhibitProvider>(context);
    final loading = _exhibit.loading;
    return Scaffold(
      appBar: AppBar(
          title: Text(!loading ? _exhibit.getTextByLanguage(-1, "exhibition_name"): ''),
          leading: Builder(
              builder: (BuildContext context) => (
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Get.back();
                      }
                  )
              )
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                Get.offAll(MainView());
              },
            )
          ]
      ),
      body: _mainView(context),
      bottomNavigationBar: _bottomButtons(context),
    );
  }

  Widget _mainView(BuildContext context) {
    final _device = Provider.of<DevicesProvider>(context);
    final _exhibit = Provider.of<ExhibitProvider>(context);
    final loading = _exhibit.loading;

    final _imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0g6e6r-vJ7ov7qryFzHHedU2Jd4s6ueRhDw&usqp=CAU";
    final _text = !loading ? _exhibit.getTextByLanguage(-1, "content") : '';

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 80,
                      height: 30,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Center(child: Text('1709', style: TextStyle(color: Colors.white, fontSize: 18)))
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                        !loading ? _exhibit.getTextByLanguage(-1, "title") : '',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: (
                        Container(
                            width: 100,
                            margin: EdgeInsets.only(right: 20),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 30,
                                    icon: Icon(Icons.filter_center_focus, color: Colors.blue),
                                    onPressed: () {
                                      _device.scan();
                                    },
                                  ),
                                  IconButton(
                                    iconSize: 30,
                                    icon:
                                      _device.isRunning
                                      ? Icon(Icons.bluetooth, color: Colors.blue)
                                      : Icon(Icons.bluetooth_disabled),
                                    onPressed: () {
                                      _device.becaonScan(!_device.isRunning);
                                    },
                                  )
                                ]
                            )
                        )
                    ),
                  )
                ],
              )
          ),
        ),
        Container(
            height: 200,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Image.network(_imageUrl, fit: BoxFit.fill)
        ),
        Container(
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.2, color: Colors.grey))
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Row(
                          children: [
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.headset_outlined),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.thumbs_up_down_outlined),
                              onPressed: () {},
                            ),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(Icons.map_outlined),
                              onPressed: () {},
                            ),
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
                                IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.share),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.language),
                                  onPressed: () {},
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(_text, textScaleFactor: 1.2,),
                )
            )
        )
      ],
    );
  }

  Widget _bottomButtons(BuildContext context) {
    final _device = Provider.of<DevicesProvider>(context);
    return Container(
        height: 140,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 60,
                  child: Material(
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: () {
                              _device.playAudio();
                            },
                            icon: Icon(_device.isPlaying ? Icons.pause : Icons.play_arrow)
                        ),
                        Expanded(
                            flex: 1,
                            child: _audioSlider(context)
                        ),
                        IconButton(
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(Icons.close)
                        )
                      ],
                    )
                  )
              ),
              Container(
                  height: 80,
                  color: Colors.black38,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                    onPressed: () {},
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 60,
                                                height: 25,
                                                margin: EdgeInsets.only(bottom: 2),
                                                decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    border: Border.all(width: 1, color: Colors.white),
                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                                child: Center(child: Text('1709', style: TextStyle(color: Colors.white, fontSize: 15)))
                                            ),
                                            Text('등록 전시물2', style: TextStyle(color: Colors.white))
                                          ]
                                      )
                                  )
                                ]
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                                textDirection: TextDirection.ltr,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                            width: 60,
                                            height: 25,
                                            margin: EdgeInsets.only(bottom: 2),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(width: 1, color: Colors.white),
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                            ),
                                            child: Center(child: Text('1709', style: TextStyle(color: Colors.white, fontSize: 15)))
                                        ),
                                        Text('등록 전시물', style: TextStyle(color: Colors.white))
                                      ]
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                    onPressed: () {},
                                  ),
                                ]
                            )
                        )
                      ]
                  )
              )
            ]
        )
    );
  }

  // 오디오 재생 슬라이드
  Widget _audioSlider(BuildContext context) {
    final _device = Provider.of<DevicesProvider>(context);
    // print();
    return Slider.adaptive(
        min: 0,
        value: _device.position.inSeconds.toDouble(),
        max: _device.duration.inSeconds.toDouble() == 0 ? 1 : _device.duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            _device.audioPlayer.seek(new Duration(seconds: value.toInt()));
          });
        }
    );
  }
}
