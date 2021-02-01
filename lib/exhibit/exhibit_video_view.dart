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
    print("##### video ${_device.dataSourceList.length}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.only(bottom: 80),
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
      // bottomNavigationBar: _videoPlayer(),
    );
  }
}
