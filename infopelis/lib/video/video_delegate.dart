import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/models.dart';
import '../providers/movies_provider.dart';

class VideoTrailer extends StatefulWidget {
  final List<String> videos;
  
  const VideoTrailer(this.videos);

  @override
  _VideoState createState(){
    
    return _VideoState(videos);
  }
}
class _VideoState extends State<VideoTrailer>{
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  final List<String> videos;

  _VideoState(this.videos);
  

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videos.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        onExitFullScreen: (){
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
               IconButton(
                 icon: const Icon(
                   Icons.settings,
                   color: Colors.white,
                   size: 25.0,
                 ),
                 onPressed: () {
                   log('Settings Tapped!');
                 },
               ),
          ],
             onReady: () {
               _isPlayerReady = true;
             },
             onEnded: (data) {
               _controller
                   .load(videos[(videos.indexOf(data.videoId) + 1) % videos.length]);
             },
        ),
        builder: (context,player){
           return Container(
                 child: player,
                 height: 300,
                 padding: EdgeInsets.only(bottom: 50),
           );
        },
      );
  }
   
   
}

class listVideosMovies extends StatelessWidget {
  final int movieId;

  const listVideosMovies(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    List<String> keys = [];
    return FutureBuilder(
      future: moviesProvider.getMovieVideo(movieId),
      builder: (_,AsyncSnapshot<List<VideoMovie>> snapshot){
           if (!snapshot.hasData) {
              return Container(
                child: Center(child: Container(height: 30,width: 30,child: CircularProgressIndicator())),
                height: 300,
                padding: EdgeInsets.only(bottom: 50),
              );
           }
           final List<VideoMovie> videos = snapshot.data!;
           if (videos.isEmpty) {
              return Container(
                child: Center(child: Container(height: 30,width: 30,child: CircularProgressIndicator())),
                height: 300,
                padding: EdgeInsets.only(bottom: 50),
              );
           }
           for (var i = 0; i < videos.length; i++) {
             keys.add(videos[i].key);
           }
           return VideoTrailer(keys);
      },
    );
  }
}