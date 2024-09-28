import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:guffgaff/src/models/chat.dart';
import 'package:guffgaff/src/models/message.dart';
import 'package:guffgaff/src/models/user_profile.dart';
import 'package:guffgaff/src/services/authentication_service.dart';
import 'package:guffgaff/utils.dart';

class DatabaseService {
  final GetIt _getIt = GetIt.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late AuthenticationService _authenticationService;

  CollectionReference? _usersCollection;
  CollectionReference? _chatsCollection;

  DatabaseService() {
    _authenticationService = _getIt<AuthenticationService>();
    _setupCollectionReferences();
  }

  void _setupCollectionReferences() {
    _usersCollection =
        _firebaseFirestore.collection('users').withConverter<UserProfile>(
            fromFirestore: (snapshots, _) => UserProfile.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (userProfile, _) => userProfile.toJson());

    _chatsCollection = _firebaseFirestore
        .collection('chats')
        .withConverter<Chat>(
        fromFirestore: (snapshots, _) => Chat.fromJson(snapshots.data()!),
        toFirestore: (chat, _) => chat.toJson());
  }

  Future<void> createUserProfile({required UserProfile userProfile}) async {
    await _usersCollection?.doc(userProfile.userId).set(userProfile);
  }

  Stream<QuerySnapshot<UserProfile>> getUserProfiles() {
    return _usersCollection
        ?.where('userId', isNotEqualTo: _authenticationService.user!.uid)
        .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }

  Future<bool> checkChatExists(String userId1, String userId2) async {
    String chatID = generateChatID(userId1: userId1, userId2: userId2);
    final result = await _chatsCollection?.doc(chatID).get();
    if (result != null) {
      return result.exists;
    }
    return false;
  }

  Future<void> createNewChat(String userId1, String userId2) async {
    String chatID = generateChatID(userId1: userId1, userId2: userId2);
    final docRef = _chatsCollection!.doc(chatID);
    final chat = Chat(
      id: chatID,
      participants: [userId1, userId2],
      messages: [],
    );
    await docRef.set(chat);
  }

  Future<void> sendChatMessage(
      String userId1, String userId2, Message message) async {
    String chatID = generateChatID(userId1: userId1, userId2: userId2);
    final docRef = _chatsCollection!.doc(chatID);
    await docRef.update(
      {
        "messages": FieldValue.arrayUnion(
          [
            message.toJson(),
          ],
        ),
      },
    );
  }

  Stream<DocumentSnapshot<Chat>> getChatData(String userId1, String userId2) {
  String chatID = generateChatID(userId1: userId1, userId2: userId2);
  return _chatsCollection?.doc(chatID).snapshots() as Stream<DocumentSnapshot<Chat>>;
  }
}
