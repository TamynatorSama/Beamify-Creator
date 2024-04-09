abstract class ISignalling {
  Future<void> createPod();
  Future<void> endStream();
  Future<void> openUserMedia();
  void registerPeerConnectionListeners();
}
