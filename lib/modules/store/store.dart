import 'package:flutter/material.dart';

class TShirtPage extends StatelessWidget {
  const TShirtPage({super.key, required this.ImageUrl});
  final String ImageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: Column(children: [
        Stack(
          children: [
            // T-shirt image at the bottom
            Image.asset('assets/images/tshirt.jpg', width: 300, height: 300),

            // Image to be overlaid, centered
            Positioned(
              top: 120, // Adjust as needed
              left: 125, // Adjust as needed
              child: Image.network(ImageUrl, width: 50, height: 50),
            ),
          ],
        ),
        ElevatedButton(onPressed: () {}, child: const Text('Buy'))
      ]),
    );
  }
}
