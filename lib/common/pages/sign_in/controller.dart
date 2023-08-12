
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nchat/common/entities/user.dart';
import 'package:nchat/common/pages/sign_in/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nchat/common/routes/names.dart';
import 'package:nchat/common/store/user.dart';
import 'package:nchat/common/widgets/toast.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String> [
    'openid'
  ]
);

class SignInController extends GetxController{
  final state = SignInState();
  SignInController();

  // Get an instance of the Firebase Firestore
  final db = FirebaseFirestore.instance;

  // Define the handleSignIn method
  Future<void> handleSignIn() async{
    try{
      var user = await _googleSignIn.signIn();
      if(user != null){

        /*
        * BEGIN Adding user to Authentication
        * Add user credentials to users list in firebase Authentication app
        * */
        final gAuthentication = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: gAuthentication.idToken,
          accessToken: gAuthentication.accessToken
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        /*
        * END Adding user to Firebase Authentication
        * */

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? '';

        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.displayName = displayName;
        userProfile.email = email;
        userProfile.photoUrl = photoUrl;
        userProfile.accessToken = id;

        // Save user data to local storage with shared_preferences
        UserStore.to.saveProfile(userProfile);

        /*
        * BEGIN Save data to Firebase Firestore users collection
        * */
        var userBase = await db.collection('users')
            .withConverter(
            fromFirestore: UserData.fromFirestore,
            toFirestore: (UserData userdata, options) => userdata.toFirestore()
        ).where('id', isEqualTo: id).get();

        if(userBase.docs.isEmpty){
          final userData = UserData(
            id: id,
            name: displayName,
            email: email,
            photourl: photoUrl,
            location: '',
            fcmtoken: '',
            addtime: Timestamp.now()
          );

          await db.collection('users')
              .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userdata, options) => userdata.toFirestore()
          ).add(userData);
          /*
          * END Adding users to Firestore users collection
          * */
        }
        toastInfo(msg: 'Sign in successful');
        Get.offAndToNamed(AppRoutes.Application);
      }
    }catch(e){
      toastInfo(msg: 'Sign in error!');
      if(kDebugMode) print(e);
    }
  }

  @override
  void onReady(){
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if(user==null){
        print('User is logged out');
      }else{
        print('User is logged in');
      }
    });
  }
}
