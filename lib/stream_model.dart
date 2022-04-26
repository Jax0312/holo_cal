import 'package:jiffy/jiffy.dart';

class StreamModel {
  String? videoId;
  String? title;
  String? thumbnail;
  String? liveSchedule;
  String? liveStart;
  String? liveEnd;
  String? channelName;
  late int viewerCount;
  late String status;

  StreamModel(Map<String, dynamic> data) {
    videoId = data['yt_video_key'];
    title = data['title'];
    thumbnail = 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
    liveSchedule = data['live_schedule'];
    liveStart = data['live_start'];
    liveEnd = data['live_end'];
    viewerCount = data['live_viewers'] ?? 0;
    channelName = data['channel']['name'];

    if (Jiffy(liveSchedule).isBefore(Jiffy().local()) && liveStart == null) {
      status = 'Waiting';
    } else {
      status = 'Starting in ${Jiffy(liveSchedule).endOf(Units.HOUR).fromNow()}';
    }
    if (liveStart != null && viewerCount == 0) {
      status = 'Members Only';
    }
    if (liveStart != null && viewerCount != 0) {
      status = 'Started ${Jiffy(liveStart).startOf(Units.HOUR).fromNow()}';
    }
  }
}
