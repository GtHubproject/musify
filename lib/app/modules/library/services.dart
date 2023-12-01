// audio_service.dart


import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioService {
  final AudioPlayer _audioPlayer;
   final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);

  AudioService(this._audioPlayer) {
    _audioPlayer.playerStateStream.listen((playerState) {
      isPlayingNotifier.value = playerState.playing;
      // You can add more logic here to handle other playback state changes
    });
  }
  
  Future<void> playSong(SongModel song) async {
    await _audioPlayer.stop();
    await _audioPlayer.setUrl(song.data);
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }
}
