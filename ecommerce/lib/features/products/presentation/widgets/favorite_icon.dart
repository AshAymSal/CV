import 'package:ecommernce/features/auth/sign_in_page.dart';
import 'package:ecommernce/features/products/domain/entities/product.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_bloc.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_events.dart';
import 'package:ecommernce/features/products/presentation/bloc/one_product/one_product_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*Widget favoriteIcon(BuildContext context, Product pro) {
  return BlocBuilder<OneProductBloc, OneProductState>(
      builder: (context, state) {
    if (state is FavoriteButtonState) {
      print('favoriteIcon' + state.isLiked.toString());
      if (state.isLiked) {
        return IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            if (FirebaseAuth.instance.currentUser == null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return signIn();
              }));
            }
            // oneProductProvider.getRead(context).buttonPressed(
            //   context, FirebaseAuth.instance.currentUser!.email!, pro);
          },
        );
      }
      return IconButton(
        icon: Icon(Icons.favorite_border, color: Colors.black),
        onPressed: () {
          if (FirebaseAuth.instance.currentUser == null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return signIn();
            }));
          }
          // oneProductProvider.getRead(context).buttonPressed(
          //   context, FirebaseAuth.instance.currentUser!.email!, pro);
        },
      );
    } else if (state is ErrorFavoriteButtonState) {
      return MessageDisplayWidget(message: state.message);
    }
    return IconButton(
      icon: Icon(Icons.favorite_border, color: Colors.black),
      onPressed: () {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return signIn();
          }));
        }
        // oneProductProvider.getRead(context).buttonPressed(
        //   context, FirebaseAuth.instance.currentUser!.email!, pro);
      },
    );
  });
}
*/
Widget favoriteIcon(BuildContext context, Product pro) {
  bool q = false;
  return IconButton(
    icon:
        BlocBuilder<OneProductBloc, OneProductState>(builder: (context, state) {
      if (state is FavoriteButtonState) {
        if (state.isLiked) {
          q = true;
          return Icon(Icons.favorite, color: Colors.red);
        } else {
          q = false;
          return Icon(Icons.favorite_border, color: Colors.black);
        }
      }
      return Icon(Icons.favorite_border, color: Colors.black);
    }),
    //
    onPressed: () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return signIn();
        }));
      }
      BlocProvider.of<OneProductBloc>(context)
          .add(PressFavoriteButtonEvent(product: pro, isLiked: q));
      // oneProductProvider.getRead(context).buttonPressed(
      //   context, FirebaseAuth.instance.currentUser!.email!, pro);
    },
  );
}
