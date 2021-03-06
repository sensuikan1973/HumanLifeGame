import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/auth.dart';

// FIXME: これはあくまで 下書き Widget. ロジックをベタ書きしてるし、レイアウトも i18n も全てがテキトー.
// See: <https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_auth/firebase_auth/example/lib/signin_page.dart>
class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Auth _auth;

  final _emailFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController()..text = 'foo.bar@example.com';
  final String _emailPrefsKey = 'email';

  String get _currentURL => Uri.base.toString();

  Future<void> _trySignIn() async {
    final prefs = await SharedPreferences.getInstance();
    _emailController.text = prefs.getString(_emailPrefsKey);
    if (await _auth.isSignInWithEmailLink(_currentURL)) {
      try {
        await _auth.signInWithEmailAndLink(email: _emailController.text, link: _currentURL);
      } on AuthException catch (e) {
        debugPrint(e.message);
        debugPrint(e.code);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _auth = context.read<Auth>();
    _trySignIn();
  }

  @override
  void dispose() {
    _emailController.dispose(); // See: https://api.flutter.dev/flutter/widgets/TextEditingController-class.html
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Form(
          key: _emailFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (EmailValidator.validate(value)) return null;
                  return 'illegal email string';
                },
              ),
              const SizedBox(height: 100),
              FlatButton(
                onPressed: () async {
                  if (!_emailFormKey.currentState.validate()) return;
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(_emailPrefsKey, _emailController.text);
                  await _auth.sendSignInLinkToEmail(email: _emailController.text, url: _currentURL);
                },
                color: Colors.blueGrey,
                child: const Text('Sign up with Email'),
              ),
              const SizedBox(height: 100),
              StreamBuilder<FirebaseUser>(
                stream: _auth.currentUserStream,
                builder: (context, snap) {
                  if (!snap.hasData) return const Text('not signed in');
                  return Text('current id: ${snap.data.uid}');
                },
              ),
              const SizedBox(height: 100),
              FlatButton(
                onPressed: () async => context.read<Auth>().signOut(),
                color: Colors.red,
                child: const Text('Sign out'),
              ),
            ],
          ),
        ),
      );
}
