class Opirations {
  List sortPosts(List toSort) {
    var sorted = [];
    var IDs = [];
    var HM = {};
    for (var post in toSort) {
      int id = int.parse(post.id);
      IDs.add(id);
      HM[id] = post;
    }
    IDs.sort();
    for (int i = 0; i < toSort.length; i++) {
      var id = IDs[i];
      sorted.add(HM[id]);
    }
    return sorted;
  }
}
