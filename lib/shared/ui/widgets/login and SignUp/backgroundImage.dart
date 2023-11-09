import 'package:flutter/material.dart';

Widget backgroundImage() {
  return ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.white, Colors.white12],
            begin: Alignment.bottomCenter,
            end: Alignment.center)
        .createShader(bounds),
    blendMode: BlendMode.darken,
    child: Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/pokemon_ball.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken))),
    ),
  );
}
