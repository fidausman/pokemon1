// ignore_for_file: library_private_types_in_public_api

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/shared/getit/getit.dart';
import 'package:app/theme/dark/dark_theme.dart';
import 'package:app/theme/light/light_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/routes/router.dart' as router;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animations/animations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    WidgetsFlutterBinding.ensureInitialized();

    runApp(MyApp(prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs, {super.key});

  @override
  Widget build(BuildContext context) {
    GetItRegister.register();

    final botToastBuilder = BotToastInit();

    return ThemeProvider(
      initTheme:
          this.prefs.getBool("darkTheme") ?? false ? darkTheme : lightTheme,
      child: ScreenUtilInit(
        builder: (_, child) => MaterialApp(
          title: 'Pokedex',
          builder: (context, child) {
            child = botToastBuilder(context, child);

            return child;
          },
          theme: lightTheme,
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
          routes: router.Router.getRoutes(context),
          initialRoute: "/",
        ),
        designSize: const Size(360, 640),
      ),
    );
  }
}

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(
        vsync: this,
         duration: Duration(seconds: 3),
         )..repeat(reverse: true);
  late Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: Offset(0, 0.08),
  ).animate(_controller);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Image.asset('assets/images/login2.jpg'),
      );
  }
}
