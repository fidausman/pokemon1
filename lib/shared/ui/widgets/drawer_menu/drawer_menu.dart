import 'dart:developer';

import 'package:app/modules/daily_checkin/daily_checkin_page.dart';
import 'package:app/modules/favourites/favouritesPage.dart';
import 'package:app/modules/news/newsPage.dart';
import 'package:app/modules/store/choose_pokemon.dart';
import 'package:app/modules/video/videoList.dart';
import 'package:app/shared/models/checkin_model.dart';
import 'package:app/shared/providers/auth_state_provider.dart';
import 'package:app/shared/repositories/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:app/modules/home/home_page_store.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/ui/widgets/drawer_menu/widgets/drawer_menu_item.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({Key? key}) : super(key: key);

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget>
    with TickerProviderStateMixin {
  final HomePageStore _homeStore = GetIt.instance<HomePageStore>();

  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    AppConstants.pokedexIcon,
                    width: 100,
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedPokeballWidget(
                          color: AppTheme.getColors(context).pokeballLogoBlack,
                          size: 24),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("Pokedex", style: textTheme.displayLarge),
                    ],
                  ),
                ],
              ),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 70),
                children: [
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerPokedex,
                    text: "Pokedex",
                    onTap: () {
                      Navigator.pop(context);

                      _homeStore.setPage(HomePageType.POKEMON_GRID);
                    },
                  ),
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerItems,
                    text: "Items",
                    onTap: () {
                      Navigator.pop(context);

                      _homeStore.setPage(HomePageType.ITENS);
                    },
                  ),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerMoves,
                      text: "Moves"),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerAbilities,
                      text: "Abilities"),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerTypeCharts,
                      text: "Type Charts"),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerLocations,
                      text: "Locations"),
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerPokedex,
                    text: "DailyCheckin",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DailyCheckinPage()));
                    },
                  ),
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerPokedex,
                    text: "Favourites",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavouritesList()));
                    },
                  ),
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerPokedex,
                    text: "News",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewsPage()));
                    },
                  ),
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerPokedex,
                    text: "Videos",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VideoList()));
                    },
                  ),
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerPokedex,
                    text: "Store",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChoosePokemon()));
                    },
                  ),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerPokedex,
                      text: "Logout",
                      onTap: () async {
                        await AuthService.instance.logout();
                      }),
                ],
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Lottie.asset(
          //     AppConstants.diglettLottie,
          //     height: 200.0,
          //   ),
          // ),
        ],
      ),
    );
  }
}
