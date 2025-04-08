import 'package:dio/dio.dart';
import 'package:teslo_app/config/config.dart';
import 'package:teslo_app/features/auth/domain/domain.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDataSource {
  final dio = Dio(
    BaseOptions(baseUrl: Eviroment.apiUrl),
  );

  @override
  Future<User> checkAuthStatus(String token) {
    // TODO: implement checkAuthStatus
    throw UnimplementedError();
  }

  @override
  Future<User> login(String emial, String password) async {
    try {
      final response = await dio
          .post('/auth/login', data: {'email': emial, 'password': password});
      final user = UserMapper.userJsonEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'CREDENCIALES INCORRECTAS');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(e.response?.data['message'] ?? 'CONNECTION TIMEOUT');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        'fullName': fullName,
      });
      final user = UserMapper.userJsonEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data['message'] ?? 'ERROR DE PARAMETROS');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError(e.response?.data['message'] ?? 'CONNECTION TIMEOUT');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
