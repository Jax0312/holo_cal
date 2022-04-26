import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:holo_cal/data_handler.dart';
import 'package:holo_cal/enums.dart';
import 'package:holo_cal/liveScreen/components/live_box.dart';
import 'package:holo_cal/stream_model.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> with AutomaticKeepAliveClientMixin<LiveScreen> {
  final List<StreamModel> _models = [];
  PageStatus _pageStatus = PageStatus.loading;

  void _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      _models.clear();
      Map.from(jsonDecode(response.body))['live'].forEach((item) {
        _models.add(StreamModel(item));
      });

      // Descending viewer count
      _models.sort((a, b) => b.viewerCount.compareTo(a.viewerCount));

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
                  'Currently Live - ${_models.length}',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: _models.map((model) => LiveBox(model: model)).toList(),
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
