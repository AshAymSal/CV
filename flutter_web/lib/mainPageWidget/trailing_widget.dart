import 'package:flutter/material.dart';
import 'package:flutter_web/features/language/lang.dart';

class TrailingWidget extends StatefulWidget {
  const TrailingWidget({super.key});

  @override
  State<TrailingWidget> createState() => _TrailingWidgetState();
}

class _TrailingWidgetState extends State<TrailingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        // color: Colors.red,
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Row(children: [
          const Spacer(),
          Column(
            children: [
              Text(
                AppLocalizations.of(context).translate('help'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context).translate('get_a_help'),
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                AppLocalizations.of(context).translate('returns'),
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                AppLocalizations.of(context).translate('reviews'),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(width: 80),
          Column(
            children: [
              Text(
                AppLocalizations.of(context).translate('resources'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context).translate('find_a_store'),
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                AppLocalizations.of(context).translate('feedback'),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(width: 80),
          Column(
            children: [
              Text(
                AppLocalizations.of(context).translate('company'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context).translate('about_nike'),
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                AppLocalizations.of(context).translate('careers'),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const Spacer(),
        ]));
  }
}
