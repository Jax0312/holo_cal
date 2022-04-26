import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holo_cal/liveScreen/ui.dart';
import 'package:holo_cal/upcomingScreen/ui.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock device orientation and hide top overlay
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        themeMode: ThemeMode.light,
        //
        // Light Theme
        //
        theme: ThemeData(
          canvasColor: const Color(0xFFF2F2F5),
          textTheme: const TextTheme().copyWith(
            headline1: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(color: Colors.blueAccent, fontSize: 15.sp),
            subtitle1: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF808080),
              fontWeight: FontWeight.normal,
            ),
            subtitle2: TextStyle(fontSize: 10.sp, color: const Color(0xFF808080), fontWeight: FontWeight.normal),
          ),
          cardColor: Colors.white,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
            backgroundColor: Colors.white,
            unselectedIconTheme: const IconThemeData(
              color: Color(0xFF808080),
            ),
            selectedIconTheme: const IconThemeData(
              color: Colors.blueAccent,
            ),
            unselectedItemColor: const Color(0xFF808080),
          ),
        ),
        //
        // Dark Theme
        //
        darkTheme: ThemeData(
          canvasColor: Colors.black,
          textTheme: const TextTheme().copyWith(
            headline1: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            headline2: TextStyle(color: Colors.blueAccent, fontSize: 15.sp),
            subtitle1: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF757575),
              fontWeight: FontWeight.normal,
            ),
            subtitle2: TextStyle(fontSize: 10.sp, color: const Color(0xFF757575), fontWeight: FontWeight.normal),
          ),
          cardColor: const Color(0xFF1c1c1e),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData().copyWith(
            backgroundColor: Colors.black,
            unselectedIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            selectedIconTheme: const IconThemeData(
              color: Colors.blueAccent,
            ),
            unselectedItemColor: Colors.white,
          ),
        ),
        home: Scaffold(
          body: SafeArea(
            child: PageView(
              controller: _pageController,
              children: [
                const LiveScreen(),
                const UpcomingScreen(),
                Container(),
              ],
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.live_tv_outlined,
                ),
                label: 'Live',
                activeIcon: Icon(
                  Icons.live_tv,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.schedule_outlined,
                ),
                label: 'Upcoming',
                activeIcon: Icon(
                  Icons.schedule,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'Settings',
                activeIcon: Icon(
                  Icons.settings,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
