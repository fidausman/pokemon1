part of 'video_bloc.dart';

@immutable
sealed class VideoEvent {}

class FetchVideo extends VideoEvent {
  FetchVideo();
}
