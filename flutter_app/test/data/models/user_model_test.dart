import 'package:flutter_test/flutter_test.dart';
import 'package:streetbite/data/models/user_builder.dart';
import 'package:streetbite/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('converts JSON into a UserModel', () {
      final json = {
        'id': '123',
        'fullName': 'Nadeen',
        'email': 'example@gmail.com',
        'photoUrl': null,
      };

      final user = UserModel.fromJson(json);

      expect(user.id, '123');
      expect(user.fullName, 'Nadeen');
      expect(user.email, 'example@gmail.com');
    });

    test('converts UserModel into JSON', () {
      const user = UserModel(
        id: '123',
        fullName: 'Nadeen',
        email: 'example@gmail.com',
      );

      final json = user.toJson();

      expect(json['id'], '123');
      expect(json['fullName'], 'Nadeen');
    });

    test('Builder creates a valid UserModel', () {
      final user = UserBuilder()
          .setId('123')
          .setFullName('Nadeen')
          .setEmail('example@gmail.com')
          .build();

      expect(user, isA<UserModel>());
      expect(user.fullName, 'Nadeen');
    });

    test('Builder rejects missing required fields', () {
      expect(() => UserBuilder().setId('123').build(), throwsStateError);
    });
  });
}
