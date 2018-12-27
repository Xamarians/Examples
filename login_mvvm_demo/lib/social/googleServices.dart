import 'dart:convert';

import 'package:flutter_mvvm_demo/social/models/googleUserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleServices {
  GoogleSignInAccount _currentUser;
  GoogleSignIn _googleSignIn = new GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future fetchGoogleUser() async {
    try {
      GoogleSignInAccount result = await _googleSignIn.signIn();
      return new GoogleUserModel(
        isSuccess: true,
        photoUrl: result.photoUrl,
        id: result.id,
        email: result.email,
        firstName: result.displayName.split(" ").first,
        lastName: result.displayName.split(" ").toList()[1] ?? " ",
      );
    } catch (error) {
      print(error);
      return new GoogleUserModel(isSuccess: false, error: error.toString());
    }
  }

  Future logOut() async {
    try {
      GoogleSignInAccount result = await _googleSignIn.disconnect();
      var tt = result.email;
    } catch (error) {}
  }

  Future<void> _handleGetContact() async {
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }
}
