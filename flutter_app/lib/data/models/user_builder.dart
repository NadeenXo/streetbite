import 'user_model.dart';

// Builder Pattern:
// Constructs a UserModel step by step.
//
// This is useful when user details come from different sources,
// such as Firebase Authentication, Firestore, and image_picker.
class UserBuilder {
  String? _id;
  String? _fullName;
  String? _email;
  String? _photoUrl;

  UserBuilder setId(String id) {
    _id = id;
    return this;
  }

  UserBuilder setFullName(String fullName) {
    _fullName = fullName;
    return this;
  }

  UserBuilder setEmail(String email) {
    _email = email;
    return this;
  }

  UserBuilder setPhotoUrl(String? photoUrl) {
    _photoUrl = photoUrl;
    return this;
  }

  UserModel build() {
    final id = _id;
    final fullName = _fullName;
    final email = _email;

    if (id == null ||
        id.trim().isEmpty ||
        fullName == null ||
        fullName.trim().isEmpty ||
        email == null ||
        email.trim().isEmpty) {
      throw StateError('Required user fields are missing');
    }

    return UserModel(
      id: id,
      fullName: fullName,
      email: email,
      photoUrl: _photoUrl,
    );
  }
}
