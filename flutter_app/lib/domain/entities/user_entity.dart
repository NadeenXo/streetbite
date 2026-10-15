import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String? photoUrl;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [id, fullName, email, photoUrl];
}
