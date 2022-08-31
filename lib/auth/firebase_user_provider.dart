import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BaristafflogFirebaseUser {
  BaristafflogFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

BaristafflogFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BaristafflogFirebaseUser> baristafflogFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BaristafflogFirebaseUser>(
            (user) => currentUser = BaristafflogFirebaseUser(user));
