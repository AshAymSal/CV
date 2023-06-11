class FirestorePaths {
  static String chatCollectionPath(String docId) =>
      'Thread/$docId/chatCollection';

  static String threadDocumentPath(String docId) => 'Thread/$docId';

  static String threadCollectionPath() => 'Thread';

  static String docChatCollectionPath(String docChatId) => 'Thread/$docChatId';

  static String unreadCountCollectionPath(
          {required String chatPath, required String userId}) =>
      'Thread/$chatPath/unreadCountCollection/$userId';

  static String userCollection(String docId) => 'Users/$docId';

  static String messageCollection(String docId, String messageDocID) =>
      'Thread/$docId/chatCollection/$messageDocID';

  static String typingCollection(String docId, String userId) =>
      'Thread/$docId/typingCollection/$userId';
}
