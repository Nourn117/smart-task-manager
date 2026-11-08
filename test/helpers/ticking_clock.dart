/// A clock that moves one second forward on every call, so consecutive
/// writes get distinct timestamps.
DateTime Function() tickingClock({DateTime? start}) {
  var current = start ?? DateTime(2026);
  return () => current = current.add(const Duration(seconds: 1));
}
