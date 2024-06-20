import 'dart:collection';

String baseUrl = "http://192.168.1.25/demo/new1.php";

class NotificationsStatment {
  Map getHashMap() {
    Map<String, String> notificationsHM = {};
    notificationsHM['friend_request_send'] = "send you a friend request";
    notificationsHM['friend_request_accept'] = "accept you friend request";

    return notificationsHM;
  }
}
