import 'package:exhibition_guide_app/provider/devices_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:better_player/better_player.dart';
import 'package:provider/provider.dart';


class ExhibitVideoView extends StatefulWidget {
  @override
  _ExhibitVideoViewState createState() => _ExhibitVideoViewState();
}

class _ExhibitVideoViewState extends State<ExhibitVideoView> {
  BetterPlayerController _betterPlayerController;
  BetterPlayerControlsConfiguration controlsConfiguration;
  BetterPlayerConfiguration betterPlayerConfiguration;

  @override
  void initState() {
    super.initState();

    controlsConfiguration =  BetterPlayerControlsConfiguration(
      enableOverflowMenu: false,
      enableSkips: false,
      enableFullscreen: true,
      enableProgressText: true,
      playIcon: Icons.play_circle_outline,
      pauseIcon: Icons.pause_circle_outline,
      controlBarHeight: 60,
    );

    betterPlayerConfiguration = BetterPlayerConfiguration(
      controlsConfiguration: controlsConfiguration,
      aspectRatio: 1,
      looping: false,
      autoPlay: true,
      fit: BoxFit.contain,
      // startAt: Duration(seconds: 5)
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _device = Provider.of<DevicesProvider>(context, listen: true);
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Container(
          child: Center(
            child: BetterPlayerPlaylist(
                betterPlayerConfiguration: betterPlayerConfiguration,
                betterPlayerPlaylistConfiguration: BetterPlayerPlaylistConfiguration(
                    loopVideos: false,
                    nextVideoDelay: Duration(seconds: 5)),
                betterPlayerDataSourceList: _device.dataSourceList
            )
          ),
        )
      ),
      // bottomNavigationBar: _videoPlayer(),
    );
  }

  Widget _videoPlayer() {
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
                  },
                  iconPath: ("assets/images/button/btn-pause.png"
                    // _controller.value.isPlaying
                    //     ? "assets/images/button/btn-pause.png"
                    //     : "assets/images/button/btn-play.png"
                  )
                ),
                Text(
                  "00:00",
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                    flex: 1,
                    child: Container(),
                ),
                Text(
                    "00:00",
                    style: TextStyle(color: Colors.white)
                ),
                _imageIconBtn(
                    px: 23.0,
                    onAction: () {
                      Get.back();
                    },
                    iconPath: 'assets/images/button/btn-cancel.png'
                )
              ],
            )
        )
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
}
