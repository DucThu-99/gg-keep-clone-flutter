import 'package:flutter/material.dart';
import 'package:gg_keep_clone/services/authentication.dart';

class AccountScreen extends StatelessWidget {
  static const routeName = 'account_screen';

  @override
  Widget build(BuildContext context) {
    final auth = Auth();
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Account'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              child: CircleAvatar(
                child: Image.asset('assets/pictures/avatar.png'),
                radius: 70,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You are still not log in',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80,
            ),
            auth.currentUser == null
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('assets/pictures/google-logo.png'),
                          Text(
                            'LOGIN WITH GOOGLE',
                            style: TextStyle(color: Colors.black),
                          ),
                          Opacity(
                            opacity: 0,
                            child:
                                Image.asset('assets/pictures/google-logo.png'),
                          )
                        ],
                      ),
                    ),
                    onPressed: () => auth.signInWithGoogle(),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        'SYNCHRONIZE YOUR DATA',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    onPressed: () {},
                  ),
            if (auth.currentUser != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                onPressed: auth.signOut,
              ),
          ],
        ),
      ),
    );
  }
}
