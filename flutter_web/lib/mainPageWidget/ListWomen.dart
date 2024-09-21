import 'package:flutter/material.dart';
import 'package:flutter_web/features/language/lang.dart';

Widget ListWomen(BuildContext context, double width) {
  return Material(
      elevation: 250,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.black,
      child: Container(
        width: width,
        height: 300,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('featured'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(AppLocalizations.of(context).translate('new_release'),
                      style: const TextStyle(fontSize: 14)),
                  Text(AppLocalizations.of(context).translate('best_seller'),
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            Container(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('shoes'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(AppLocalizations.of(context).translate('all_shoes'),
                      style: const TextStyle(fontSize: 14)),
                  Text(AppLocalizations.of(context).translate('life_style'),
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            Container(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context).translate('clothing'),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(AppLocalizations.of(context).translate('hodies'),
                      style: const TextStyle(fontSize: 14)),
                  Text(AppLocalizations.of(context).translate('jackets'),
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ));
}
