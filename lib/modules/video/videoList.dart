import 'package:app/modules/video/videoPlayer.dart';
import 'package:app/shared/bloc/video_bloc/video_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<VideoBloc>().add(FetchVideo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Videos')),
      body: BlocBuilder<VideoBloc, VideoState>(builder: (context, state) {
        print(state);
        if (state is VideoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is VideoSuccess) {
          return ListView.builder(
            itemCount: state.videos.length,
            itemBuilder: (context, index) {
              final video = state.videos[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayer(video: video),
                      ));
                },
                leading: Image.network(
                    video.snippet.thumbnails.thumbnailsDefault.url),
                // video['snippet']['thumbnails']['default']['url']
                title: Text(video.snippet.title),
                subtitle: Text(video.snippet.publishedAt.toString()),
                // Add onTap to navigate to video details or play video.
              );
            },
          );
        }
        return const Text('NO Data');
      }),
    );
  }
}
