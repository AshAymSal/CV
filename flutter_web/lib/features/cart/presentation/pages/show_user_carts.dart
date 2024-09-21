// lib/presentation/views/cart_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/auth/presentation/bloc/product/auth_bloc.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_event.dart';
import 'package:flutter_web/features/cart/presentation/bloc/cart/cart_state.dart';
import 'package:flutter_web/features/language/lang.dart';

class CartListScreen extends StatefulWidget {
  final int userId;

  const CartListScreen({super.key, required this.userId});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<CartBloc>()
        .add(GetUserCartsEvent(context.read<AuthBloc>().u!.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('your_carts'),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is UserCartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserCartLoaded) {
            return ListView.builder(
              itemCount: state.carts.length,
              itemBuilder: (context, index) {
                final cart = state.carts[index];
                return Card(
                  child: ListTile(
                    title: Text(
                        '${AppLocalizations.of(context).translate('cart_id')}${cart.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${AppLocalizations.of(context).translate('date')} ${cart.date}'),
                        Text(
                            '${AppLocalizations.of(context).translate('user_id')} ${cart.userId}'),
                        Text(
                            '${AppLocalizations.of(context).translate('total_products')} ${cart.products.length}'),
                      ],
                    ),
                    onTap: () {
                      // Handle cart item tap, maybe show cart details
                    },
                  ),
                );
              },
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
                child: Text(
              AppLocalizations.of(context).translate('no_carts_available'),
            ));
          }
        },
      ),
    );
  }
}
