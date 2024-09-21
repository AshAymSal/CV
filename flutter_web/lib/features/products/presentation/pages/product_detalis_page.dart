// lib/presentation/views/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_bloc.dart';
import 'package:flutter_web/features/cart/domain/entities/cart.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:flutter_web/features/language/lang.dart';
import '../../domain/entities/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  TextEditingController txt = TextEditingController();

  @override
  void initState() {
    super.initState();
    txt.text = 0.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(product.image, height: 250, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              widget.product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.product.price}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.description,
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 200,
              child: Image.network(widget.product.image),
            ),

            const SizedBox(height: 100),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (int.parse(txt.text) < 1) return;

                      cartitem ci = cartitem(
                          productId: widget.product.id,
                          quantity: int.parse(txt.text));
                      if (context.read<AuthBloc>().u == null) {
                        Navigator.pushNamed(
                          context,
                          '/login',
                        );
                      } else {
                        context.read<CartBloc>().add(AddItemsToCartEvent(ci));
                        setState(() {
                          txt.text = "0";
                        });
                        var snackBar = SnackBar(
                            content: Text(
                          AppLocalizations.of(context)
                              .translate('addedd_successfully'),
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('add_to_cart'),
                    )),
                const SizedBox(
                  width: 100,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        txt.text = (int.parse(txt.text) + 1).toString();
                      });
                    },
                    child: const Icon(Icons.plus_one)),
                Text(txt.text),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        txt.text = (int.parse(txt.text) - 1).toString();
                      });
                    },
                    child: const Icon(Icons.remove)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
