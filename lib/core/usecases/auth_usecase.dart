abstract class AuthUsecase<T, Param> {
  Future<T> call(param);
}
