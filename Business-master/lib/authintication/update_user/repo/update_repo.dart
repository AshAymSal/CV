// Future updateUser(UserModel model, {String userImageToken}) async {
//   LocalStoreData storeData = Get.find<LocalStoreData>();
//   UserModel userModel = storeData.getUser;
//
//   Map<String, String> body = {
//     'phone': model.phone,
//     'address': model.address,
//     'email': model.email,
//     'username': model.username,
//     'password': model.password,
//     'password_confirmation': model.password_confirmation,
//   };
//   if (userImageToken != null) {
//     body.addAll({'photo': userImageToken});
//   }
//   print(body);
//
//   var response = await apiRequest.putData(
//     url: 'wp-json/volar/v1/profile/update',
//     body: body,
//     bearerToken: userModel.token,
//   );
//
//   try {
//     return response;
//   } catch (e) {
//     return response;
//   }
// }

// Future<int> uploadMedia(File file) async {
//   LocalStoreData storeData = Get.find<LocalStoreData>();
//   UserModel userModel = storeData.getUser;
//   var response = await apiRequest.uploadMedia(
//     url: 'wp-json/wp/v2/media',
//     image: file,
//     bearerToken: userModel.token,
//   );
//   if (response != null) {
//     print(response.body);
//     var jsonData = json.decode(response.body);
//     print(jsonData["id"]);
//
//     return jsonData["id"];
//   }
// }
