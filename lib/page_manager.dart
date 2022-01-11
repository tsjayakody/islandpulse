import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:islandpulse/constants/constants.dart';
import 'package:islandpulse/service/playlist_repository.dart';
import 'package:islandpulse/service/service_locator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'notifier/play_button_notifier.dart';

class PageManager {
  static const radioStationKey = "lastRadioStation";

  // Listeners: Updates going to the UI
  final currentRadioTitleNotifier = ValueNotifier<String>('Loading...');
  final currentSongTitleNotifier = ValueNotifier<String>('Island Pulse');
  final currentSongArtistNotifier = ValueNotifier<String>('Online');
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);

  final _audioHandler = getIt<AudioHandler>();

  // Events: Calls coming from the UI
  void init() async {
    await _loadPlaylist();
    _listenToPlaybackState();
    _listenToChangesInSong();
  }

  Future<void> _loadPlaylist() async {
    final songRepository = getIt<PlaylistRepository>();
    final playlist = await songRepository.fetchInitialPlaylist();
    final mediaItems = playlist
        .map((song) => MediaItem(
              id: song['id'] ?? '',
              album: song['album'] ?? '',
              title: song['title'] ?? '',
              artUri: Uri.parse('https://www.islandpulse.lk/images/yellow.png'),
              extras: {
                'url': song['url'],
                'data': song['data'],
                'channel_name': song['channel_name']
              },
            ))
        .toList();
    _audioHandler.addQueueItems(mediaItems);
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentRadioTitleNotifier.value =
          mediaItem?.extras!['channel_name'] ?? 'Loading...';
      currentSongTitleNotifier.value = mediaItem?.title ?? 'Island Pulse';
      currentSongArtistNotifier.value = mediaItem?.artist ?? 'Online';
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void launchWhatsapp() {
    _launchSocial(
        StringConstants.whatsappURL, StringConstants.fallbackWhatsappURL);
  }

  void launchFacebook() {
    if (Platform.isIOS) {
      _launchSocial(StringConstants.facebookURLIOS,
          StringConstants.fallbackFacebookURLIOS);
    } else {
      _launchSocial(
          StringConstants.facebookURL, StringConstants.fallbackFacebookURL);
    }
  }

  void launchInstagram() {
    _launchSocial(
        StringConstants.instagramURL, StringConstants.fallbackInstagramURL);
  }

  void launchYoutube() {
    _launchSocial(
        StringConstants.youtubeURL, StringConstants.fallbackYoutubeURL);
  }

  void _launchSocial(String url, String fallbackUrl) async {
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  void dragControl(DragEndDetails details) {
    if (details.primaryVelocity == 0) return;
    if (details.primaryVelocity!.compareTo(0) == 1) {
      previous();
    } else {
      next();
    }
  }

  void play() {
    _audioHandler.play();
  }

  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);
  void previous() => _audioHandler.skipToPrevious();
  void next() => _audioHandler.skipToNext();

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}
