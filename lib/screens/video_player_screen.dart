import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:kitsunee_flutter/helper/api.helper.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String? episodeId;
  const VideoPlayerScreen({super.key, required this.episodeId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with WidgetsBindingObserver {
  List<dynamic> sources = [];
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchEpisodeSources();
  }

  Future<void> fetchEpisodeSources() async {
    if (widget.episodeId != null) {
      try {
        final episodeSources = await fetchEpisodeSource(id: widget.episodeId!);
        setState(() {
          sources = episodeSources['sources'] ?? [];
        });

        if (sources.isNotEmpty && sources[0]['isM3U8']) {
          _initializePlayer(sources[0]['url']);
        }
      } catch (e) {
        print('Error fetching episode source: $e');
      }
    }
  }

  void _initializePlayer(String url) {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: false,
    );
    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Pause the video when the app goes into the background
      _videoPlayerController?.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: sources.isNotEmpty && _chewieController != null
            ? SizedBox(
                height: screenHeight * 0.4, // 40% of the screen height
                child: Chewie(controller: _chewieController!),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
