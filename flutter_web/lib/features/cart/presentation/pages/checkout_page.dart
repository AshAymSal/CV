import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_bloc.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:flutter_web/features/language/lang.dart';

class CheckoutPage extends StatefulWidget {
  final List<cartitem> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState(cartItems);
}

class _CheckoutPageState extends State<CheckoutPage> {
  List<cartitem> cartItems;

  _CheckoutPageState(this.cartItems);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('check_out'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(
                      AppLocalizations.of(context).translate('product_id') +
                          ' ' +
                          '${item.productId}'),
                  subtitle: Text(
                      AppLocalizations.of(context).translate('quantity') +
                          ' ' +
                          '${item.quantity}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle checkout logic
                DateTime now = DateTime.now();
                cart c = cart(
                    date: now.toString(),
                    products: widget.cartItems,
                    userId: context.read<AuthBloc>().u!.id);
                context.read<CartBloc>().add(AddCartEvent(c));

                _onCheckoutPressed(context);
                setState(() {
                  cartItems = [];
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(fontSize: 18.0),
              ),
              child: Text(
                AppLocalizations.of(context).translate('check_out'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onCheckoutPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        AppLocalizations.of(context).translate('check_out_successful'),
      )),
    );
  }
}
