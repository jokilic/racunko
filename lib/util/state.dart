sealed class RacunkoState<T> {}

class Initial<T> extends RacunkoState<T> {}

class Loading<T> extends RacunkoState<T> {}

class Empty<T> extends RacunkoState<T> {}

class Error<T> extends RacunkoState<T> {
  final String? error;

  Error({
    required this.error,
  });
}

class Success<T> extends RacunkoState<T> {
  final T data;

  Success({
    required this.data,
  });
}
