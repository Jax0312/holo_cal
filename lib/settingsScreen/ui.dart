import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 3.w, top: 4.h),
          child: FittedBox(
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FittedBox(
              child: Text(
                'Report an issue / Request new features',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
        )
      ],
    );
  }
}
