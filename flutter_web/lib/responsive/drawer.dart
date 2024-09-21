import 'package:flutter/material.dart';
import 'package:flutter_web/features/language/lang.dart';

class NestedDrawer extends StatefulWidget {
  const NestedDrawer({super.key});

  @override
  _NestedDrawerState createState() => _NestedDrawerState();
}

class _NestedDrawerState extends State<NestedDrawer> {
  List<String> mainMenu = ['Men', 'Women', 'Kids'];
  Map<String, List<String>> subMenu = {
    'Men': ['Men Featured', 'Men Shoes', 'Men Colthing'],
    'Women': ['Women Featured', 'Women Shoes', 'Women Colthing'],
    'Kids': [
      'Kids Featured',
      'Kids Shoes',
      'Kids Colthing',
      'Kids Kids By Age'
    ],
    // 'Sale': ['Sale For Men', 'Sale For Women', 'Sale For Kids'],
  };

  Map<String, List<String>> subSubMenu = {
    'Men Featured': ['New Release', 'Best Seller'],
    'Men Shoes': ['All Shoes', 'Life Style'],
    'Men Colthing': ['Hodies', 'Jacket'],
    'Women Featured': ['New Release', 'Best Seller'],
    'Women Shoes': ['All Shoes', 'Life Style'],
    'Women Colthing': ['Hodies', 'Jacket'],
    'Kids Featured': ['New Release', 'Best Seller'],
    'Kids Shoes': ['All Shoes', 'Life Style'],
    'Kids Colthing': ['Hodies', 'Jacket'],
    'Kids Kids By Age': ['Older', 'Younger', 'Baby']
  };

  String currentSubMenu = "Men";
  String currentSubSubMenu = "Men Featured";

  bool vismain = true;
  bool vissub = true;
  bool vissubsub = true;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: 290,
        color: Colors.white,
        child: _buildSubSubMenu(currentSubSubMenu),
      ),
      AnimatedPositioned(
        left: vissub ? 0 : -290,
        duration: const Duration(milliseconds: 200),
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: 290,
            color: Colors.white,
            child: _buildSubMenu(currentSubMenu)),
      ),
      AnimatedPositioned(
          left: vismain ? 0 : -290,
          duration: const Duration(milliseconds: 200),
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: 290,
              color: Colors.white,
              child: _buildMainMenu())),
    ]);
  }

  Widget _buildMainMenu() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 120,
          color: Colors.white,
          child: Text(
            AppLocalizations.of(context).translate('main_menu'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        for (String item in mainMenu)
          ListTile(
            title: Text(
              AppLocalizations.of(context).translate(item),
              style: const TextStyle(fontSize: 22),
            ),
            onTap: () {
              setState(() {
                currentSubMenu = item;
                //  currentMenu = item; // Navigate to the submenu
                vismain = false;
                vissub = true;
              });
            },
          ),
      ],
    );
  }

  Widget _buildSubMenu(String menu) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 120,
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    vismain = true;
                    //vissub = false;
                    // Go back to main menu
                  });
                },
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context).translate('main'),
                style: const TextStyle(color: Colors.black, fontSize: 19),
              ),
            ],
          ),
        ),
        Text(currentSubMenu,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 24)),
        const SizedBox(height: 20),
        /* ListTile(
          leading: Text(currentSubMenu,
              style: TextStyle(color: Colors.black, fontSize: 19)),
        ),*/
        for (String subItem in subMenu[menu]!)
          ListTile(
            title: Text(
              AppLocalizations.of(context)
                  .translate(subItem.split(" ").skip(1).join(" ")),
              style: const TextStyle(fontSize: 22),
            ),
            onTap: () {
              setState(() {
                currentSubSubMenu = subItem;
                vissub = false;

                //currentSubMenu = subItem; // Navigate to the sub-submenu
              });
            },
          ),
      ],
    );
  }

  Widget _buildSubSubMenu(String subMenuItem) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 120,
          color: Colors.white,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    vissub = true;
                    //  currentSubMenu = null; // Go back to sub menu
                  });
                },
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context).translate(currentSubMenu),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
        Text(AppLocalizations.of(context).translate(currentSubSubMenu),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 24)),
        const SizedBox(height: 20),
        for (String subSubItem in subSubMenu[subMenuItem]!)
          ListTile(
            title: Text(
              AppLocalizations.of(context).translate(subSubItem),
              style: const TextStyle(fontSize: 22),
            ),
            onTap: () {
              // Perform action here
              Navigator.pop(context); // Close the drawer after action
            },
          ),
      ],
    );
  }
}
