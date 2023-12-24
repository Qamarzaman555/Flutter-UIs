part of '../local_pub.dart';

class CHIVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final double? aspectRatio;
  final VideoType? videoType;
  final String? localVideoPath;
  final Uint8List? videoBytes;
  final Widget? loadingWidget;

  const CHIVideoPlayer({
    this.videoUrl,
    this.aspectRatio = 16 / 9,
    required this.videoType,
    this.localVideoPath,
    this.videoBytes,
    this.loadingWidget,
    super.key,
  });

  @override
  State<CHIVideoPlayer> createState() => _CHIVideoPlayerState();
}

class _CHIVideoPlayerState extends State<CHIVideoPlayer> {
  File? videoFile;
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;
  Orientation orientation = Orientation.portrait;
  List<DeviceOrientation> orientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ];

  // final String url = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  @override
  void initState() {
    super.initState();
    if (widget.videoType == VideoType.local) {
      if (kIsWeb) {
        videoFile = File.fromRawPath(widget.videoBytes!);
      } else {
        videoFile = File(widget.localVideoPath!);
      }
    }
    SystemChrome.setPreferredOrientations(orientations);
    videoPlayerController = widget.videoType == VideoType.local
        ? VideoPlayerController.file(videoFile!)
        : widget.videoType == VideoType.assets
            ? VideoPlayerController.asset(widget.localVideoPath ?? '')
            : VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl ?? ''))
      ..initialize().then((value) {
        setState(() {});
      });
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    return Center(
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: widget.aspectRatio!,
              child: CustomVideoPlayer(
                  customVideoPlayerController: _customVideoPlayerController),
            )
          : widget.loadingWidget ?? const CircularProgressIndicator(),
    );
  }
}

enum VideoType { network, local, assets }
