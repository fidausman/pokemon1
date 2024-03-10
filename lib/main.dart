// ignore_for_file: library_private_types_in_public_api

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/modules/daily_checkin/bloc/daily_checkin_bloc_bloc.dart';
import 'package:app/modules/favourites/bloc/favourites_bloc.dart';
import 'package:app/shared/bloc/video_bloc/video_bloc.dart';
import 'package:app/shared/getit/getit.dart';
import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/providers/favourites_provider.dart';
import 'package:app/theme/dark/dark_theme.dart';
import 'package:app/theme/light/light_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/routes/router.dart' as router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  SharedPreferences.getInstance().then((instance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    WidgetsFlutterBinding.ensureInitialized();

    runApp(MyApp(prefs));
  });
}

Future<void> loadEnv() async {
  await dotenv.load();
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    GetItRegister.register();

    final botToastBuilder = BotToastInit();

    return ThemeProvider(
        initTheme:
            widget.prefs.getBool("darkTheme") ?? false ? darkTheme : lightTheme,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => VideoBloc(),
            ),
            BlocProvider(create: (context) => FavouritesBloc()),
            BlocProvider(create: (context) => DailyCheckinBloc()),
          ],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => AuthProvider()),
              ChangeNotifierProvider(
                  create: (context) => FavouritesProvider(context)),
            ],
            child: ScreenUtilInit(
              builder: (_, child) => MaterialApp(
                navigatorKey: navigatorKey,
                title: 'Pokedex',
                builder: (context, child) {
                  child = botToastBuilder(context, child);

                  return child;
                },
                theme: lightTheme,
                navigatorObservers: [BotToastNavigatorObserver()],
                debugShowCheckedModeBanner: false,
                routes: router.Router.getRoutes(context),
                initialRoute: "/login",
              ),
              designSize: const Size(360, 640),
            ),
          ),
        ));
  }
}
