import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/video_page_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends GetView<VideoPageController> {
  const VideoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VideoPageController());
    final VideoPlayerController _videoController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        controller.isFinishedInitVideo.value = true;
      })
      ..setLooping(true);

    return Obx(() {
      if (controller.isFinishedInitVideo.value) {
        late String currentMinutes;
        late String currentSeconds;

        String videoMunitesSize = _videoController.value.duration.inMinutes <= 9
            ? '0' + _videoController.value.duration.inMinutes.toString()
            : _videoController.value.duration.inMinutes.toString();
        String videoSecondsSize = _videoController.value.duration.inSeconds <= 9
            ? '0' + _videoController.value.duration.inSeconds.toString()
            : _videoController.value.duration.inSeconds.toString();

        return Container(
          height: 180,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.black,
          ),
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
              ),
              InkWell(
                onTap: () {
                  if (controller.isVideoPlayed.value) {
                    _videoController.pause();
                    controller.isVideoPlayed.value = false;
                  } else {
                    _videoController.play();
                    controller.isVideoPlayed.value = true;
                  }
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: controller.isVideoPlayed.value
                          ? Colors.transparent
                          : DARK_GREY_COLOR.withOpacity(0.4),
                    ),
                    child: controller.isVideoPlayed.value
                        ? const SizedBox.shrink()
                        : CircleAvatar(
                            backgroundColor: WHITE_COLOR.withOpacity(0.8),
                            child: const Icon(
                              Icons.play_arrow,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                  ),
                ),
              ),
              Positioned(
                bottom: 1,
                left: 0,
                right: 0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _videoController,
                      builder: (context, VideoPlayerValue value, child) {
                        currentMinutes = value.position.inMinutes <= 9
                            ? '0' + value.position.inMinutes.toString()
                            : value.position.inMinutes.toString();
                        currentSeconds = value.position.inSeconds <= 9
                            ? '0' + value.position.inSeconds.toString()
                            : value.position.inSeconds.toString();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '$currentMinutes:$currentSeconds/$videoMunitesSize:$videoSecondsSize',
                            style: GoogleFonts.quicksand(
                              color: WHITE_COLOR,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: VideoProgressIndicator(
                        _videoController,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                            playedColor: PRIMARY_COLOR,
                            backgroundColor: PRIMARY_LIGHT_COLOR),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: Icon(
                        Icons.fullscreen,
                        color: PRIMARY_COLOR,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
