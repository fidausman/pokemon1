import 'dart:async';

import 'package:app/shared/models/youtubeModel.dart';
import 'package:app/shared/repositories/youtubeService.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<FetchVideo>(getVideo);
  }

  FutureOr<void> getVideo(FetchVideo event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    try {
      final YoutubeModel data =
          await youtubeRepo.getVideo(dotenv.env['YOUTUBE_API_KEY'].toString());
      emit(VideoSuccess(data.items));
    } catch (e) {
      emit(VideoError());
    }
  }
}
