import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:guffgaff/src/models/user_profile.dart';
import 'package:guffgaff/src/services/authentication_service.dart';

class DatabaseService {
  final GetIt _getIt = GetIt.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  late AuthenticationService _authenticationService;

  CollectionReference? _usersCollection;

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
  }

  Future<void> createUserProfile({required UserProfile userProfile}) async {
    await _usersCollection?.doc(userProfile.userId).set(userProfile);
  }

  Stream<QuerySnapshot<UserProfile>> getUserProfiles() {
    return _usersCollection
        ?.where('userId', isNotEqualTo: _authenticationService.user!.uid)
        .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }
}
