// lib/presentation/views/product_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/features/language/lang.dart';
import 'package:flutter_web/features/products/data/datasources/products_remote_datasource.dart';
import 'package:flutter_web/features/products/data/repositories/product_repository_imp.dart';
import 'package:flutter_web/features/products/domain/usecases/get_products_by_category_usecase.dart';

import 'package:flutter_web/features/products/presentation/bloc/product_by_category/product_by_category_bloc.dart';
import 'package:flutter_web/features/products/presentation/bloc/product_by_category/product_by_category_events.dart';
import 'package:flutter_web/features/products/presentation/bloc/product_by_category/product_by_category_state.dart';

class ProductListScreenSL extends StatelessWidget {
  final String Category;
  const ProductListScreenSL({super.key, required this.Category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductByCategoryBloc(
        getProductsByCategoryUseCase: GetProductsByCategoryUsecase(
            repository: ProductsRepositoryImpl(
                remoteDataSource: ProductsRemoteDataSource())),
      ),
      child: ProductListScreen(
        Category: Category,
      ),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  final String Category;

  const ProductListScreen({super.key, required this.Category});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState(Category);
}

class _ProductListScreenState extends State<ProductListScreen> {
  final String Category;

  _ProductListScreenState(this.Category);

  @override
  void initState() {
    super.initState();
    context
        .read<ProductByCategoryBloc>()
        .add(FetchProductsByCategory(Category));
    context
        .read<ProductByCategoryBloc>()
        .add(FetchProductsByCategory(Category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate(Category),
        ),
      ),
      body: BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
        builder: (context, state) {
          if (state is ProductByCategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductByCategoryLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  leading: Image.network(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detalis',
                      arguments: product,
                    );
                  },
                );
              },
            );
          } else if (state is ProductByCategoryError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
                child: Text(
              AppLocalizations.of(context).translate('no_products_founded'),
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
