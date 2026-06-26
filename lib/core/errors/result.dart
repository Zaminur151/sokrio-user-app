class Result<S, F> {
  final S? _success;
  final F? _failure;

  Result.success(S success) : _success = success, _failure = null;
  Result.failure(F failure) : _failure = failure, _success = null;

  bool get isSuccess => _success != null;
  bool get isFailure => _failure != null;

  S get success => _success!;
  F get failure => _failure!;

  R fold<R>(R Function(S success) onSuccess, R Function(F failure) onFailure) {
    if (isSuccess) {
      return onSuccess(_success as S);
    } else {
      return onFailure(_failure as F);
    }
  }
}
