part of 'video_bloc.dart';

@immutable
sealed class VideoState {}

final class VideoInitial extends VideoState {}

class VideoSuccess extends VideoState {
  final List<VideoItem> videos;

  VideoSuccess(this.videos);
}

class VideoLoading extends VideoState {}

class VideoError extends VideoState {}
