import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:streetbite/core/errors/result.dart';
import 'package:streetbite/domain/entities/user_entity.dart';
import 'package:streetbite/domain/repositories/auth_repository.dart';
import 'package:streetbite/domain/usecases/auth/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late LoginUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = LoginUseCase(repository);
  });

  test('returns user when login succeeds', () async {
    const user = UserEntity(
      id: '123',
      fullName: 'Test User',
      email: 'test@example.com',
    );

    when(
      () => repository.login(email: 'test@example.com', password: '123456'),
    ).thenAnswer((_) async => const Success<UserEntity>(user));

    final result = await useCase(
      email: ' test@example.com ',
      password: '123456',
    );

    expect(result, isA<Success<UserEntity>>());

    final success = result as Success<UserEntity>;

    expect(success.data, user);

    verify(
      () => repository.login(email: 'test@example.com', password: '123456'),
    ).called(1);
  });
}
