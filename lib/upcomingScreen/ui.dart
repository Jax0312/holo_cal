import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:holo_cal/data_handler.dart';
import 'package:holo_cal/enums.dart';
import 'package:holo_cal/stream_model.dart';
import 'package:holo_cal/upcomingScreen/components/upcoming_box.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> with AutomaticKeepAliveClientMixin<UpcomingScreen> {
  final List<StreamModel> _models = [];
  PageStatus _pageStatus = PageStatus.loading;

  void _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      _models.clear();
      Map.from(jsonDecode(response.body))['upcoming'].forEach((item) {
        _models.add(StreamModel(item));
      });

      // Display stream that are starting soon first
      _models.sort((a, b) => a.liveSchedule!.compareTo(b.liveSchedule!));

      setState(() {
        _pageStatus = PageStatus.success;
      });
    } else {
      setState(() {
        _pageStatus = PageStatus.success;
      });
    }
  }

  @override
  void initState() {
    DataHandler.get().then((res) => _handleResponse(res));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    switch (_pageStatus) {
      case PageStatus.success:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.w, top: 4.h),
              child: FittedBox(
                child: Text(
                  'Upcoming - ${_models.length}',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: _models.map((model) => UpcomingBox(model: model)).toList(),
              ),
            ),
          ],
        );
      case PageStatus.failed:
        return Container();
      case PageStatus.loading:
        return Center(
          child: SizedBox(
              height: 35,
              width: 35,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color!),
                strokeWidth: 2,
              )),
        );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
