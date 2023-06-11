class ListOfTabsModel {
  String name;
  bool isSelected;

  ListOfTabsModel({
    required this.name,
    required this.isSelected,
  });
}

final List<ListOfTabsModel> option = [
  ListOfTabsModel(name: 'الرئيسية', isSelected: true),
  ListOfTabsModel(name: 'الصور', isSelected: false),
  ListOfTabsModel(name: 'الفيديو', isSelected: false),
  ListOfTabsModel(name: 'عن الصفحة', isSelected: false),
  ListOfTabsModel(name: 'اعلاناتى', isSelected: false),
];
