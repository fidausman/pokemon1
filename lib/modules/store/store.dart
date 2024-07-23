import 'package:app/shared/repositories/stripe_service.dart';
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
        ElevatedButton(
            onPressed: () async {
              var items = [
                {"productPrice": 500, "productName": "T-Shirt", "qty": 1}
              ];
              await StripeService.stripePaymentCheckout(
                  items, 500, context, true, onSuccess: () {
                print("Success");
              }, onCancel: () {
                print("Cancel");
              }, onError: (e) {
                print("Error: " + e.toString());
              });
            },
            child: const Text('Buy'))
      ]),
    );
  }
}
