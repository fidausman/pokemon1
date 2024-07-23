import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stripe_checkout/stripe_checkout.dart';

class StripeService {
  static String secretKey =
      "sk_test_51OspVuSBie3JVi2mZxRhN3MKenAxgHipxQFD4lD5MH4NP31Ecsx7VZ3D0hma4TjBKIbLzerKwNMIMfGcgwnF3YEw00MASOHrWg";
  static String publishableKey =
      "pk_test_51OspVuSBie3JVi2mg6WA7gT6QeDiWRngZVFFoVL6SVpMgEojzoZhlLsqfbL2FQnwlhAV1T0QBS7Y9EN6i38gz8Jr00luSx2Zmj";

  static Future<dynamic> createCheckoutSession(
    List<dynamic> productItems,
    totalAmount,
  ) async {
    final url = Uri.parse(
      "https://api.stripe.com/v1/checkout/sessions",
    );

    String lineItems = "";
    int index = 0;

    for (var element in productItems) {
      var productPrice = (element["productPrice"] * 100).round().toString();
      lineItems +=
          "&line_items[$index][price_data][product_data][name]=${element['productName']}";
      lineItems += "&line_items[$index][price_data][unit_amount]=$productPrice";
      lineItems += "&line_items[$index][price_data][currency]=INR";
      lineItems += "&line_items[$index][quantity]=${element['qty'].toString()}";

      index++;
    }
    final response = await http.post(url,
        body:
            'success_url=https://checkout.stripe.dev/success&mode=payment$lineItems',
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        });

    return json.decode(response.body)["id"];
  }

  static Future<dynamic> stripePaymentCheckout(
    productItems,
    subtotal,
    context,
    bool mounted, {
    onSuccess,
    onCancel,
    onError,
  }) async {
    final String sessionId =
        await createCheckoutSession(productItems, subtotal);
    final result = await redirectToCheckout(
        context: context,
        sessionId: sessionId,
        publishableKey: publishableKey,
        successUrl: "https://checkout.stripe.dev/success",
        canceledUrl: "https://checkout.stripe.dev/cancel");
    if (mounted) {
      final text = result.when(
          redirected: () => "redirected successfully",
          success: () => onSuccess(),
          canceled: () => onCancel(),
          error: (e) => onError(e));

      return text;
    }
  }
}
