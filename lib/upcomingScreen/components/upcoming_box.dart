import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:holo_cal/stream_model.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class UpcomingBox extends StatelessWidget {
  final StreamModel model;
  const UpcomingBox({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 3.w, right: 3.w),
      height: 20.h,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 5.h,
            child: Marquee(
              text: model.title ?? '',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Container(
            height: 15.h,
            padding: EdgeInsets.all(1.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    launch('https://www.youtube.com/watch?v=${model.videoId}');
                  },
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: model.thumbnail ?? '',
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          height: 10.w,
                          width: 10.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fadeOutDuration: Duration.zero,
                      fadeInDuration: Duration.zero,
                      height: 14.h,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.channelName ?? '',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(child: _NotificationButton()),
                              Text(
                                model.status,
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _NotificationButton extends StatefulWidget {
  const _NotificationButton({Key? key}) : super(key: key);

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<_NotificationButton> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _active = !_active;
          });
        },
        child: Icon(
          _active ? Icons.notifications_active_rounded : Icons.notifications_none_rounded,
          color: _active
              ? Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color
              : Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme!.color,
        ),
      ),
    );
  }
}
