import 'package:app/shared/providers/favourites_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/ui/canvas/white_pokeball_canvas.dart';
import 'package:app/shared/utils/image_utils.dart';
import 'package:app/theme/app_theme.dart';
import 'package:provider/provider.dart';

class PokeItemWidget extends StatefulWidget {
  final PokemonSummary pokemon;
  final bool isFavorite;

  const PokeItemWidget(
      {Key? key, required this.pokemon, this.isFavorite = false})
      : super(key: key);

  @override
  State<PokeItemWidget> createState() => _PokeItemWidgetState();
}

class _PokeItemWidgetState extends State<PokeItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getColors(context).pokemonItem(widget.pokemon.types[0]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              bottom: -15,
              right: -3,
              child: Container(
                child: CustomPaint(
                  size: Size(
                      83,
                      (83 * 1.0040160642570282)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: PokeballLogoPainter(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 7, bottom: 3),
                child: SizedBox(
                  height: 76,
                  width: 76,
                  child: Hero(
                    tag: widget.isFavorite
                        ? "favorite-pokemon-image-${widget.pokemon.number}"
                        : "pokemon-image-${widget.pokemon.number}",
                    child: ImageUtils.networkImage(
                      url: widget.pokemon.thumbnailUrl,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, top: 8),
                child: Text(
                  "#${widget.pokemon.number}",
                  style: TextStyle(
                    fontFamily: "CircularStd-Book",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getColors(context)
                        .pokemonDetailsTitleColor
                        .withOpacity(0.6),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pokemon.name,
                    style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.getColors(context)
                            .pokemonDetailsTitleColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: widget.pokemon.types
                        .map((type) => Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(38),
                                    color: AppTheme.getColors(context)
                                        .pokemonDetailsTitleColor
                                        .withOpacity(0.4)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Text(
                                    type,
                                    style: textTheme.bodyLarge?.copyWith(
                                      fontSize: 8,
                                      color: AppTheme.getColors(context)
                                          .pokemonDetailsTitleColor,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
