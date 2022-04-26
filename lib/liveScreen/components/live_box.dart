import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:sizer/sizer.dart';
import '../../stream_model.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveBox extends StatelessWidget {
  final StreamModel model;
  const LiveBox({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch('https://www.youtube.com/watch?v=${model.videoId}');
      },
      child: Container(
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
                  AspectRatio(
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
                          const Spacer(),
                          Text(
                            '${model.viewerCount} Watching',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            model.status,
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
