import 'package:beamify_creator/shared/http/http_helper.dart';

class PodRepository {
  Future<HttpResponse> getUngoingPodInfo(String podId) async {
    return await HttpHelper.getRequest("pods/$podId/get_pod_members").then((value) {
      print(value);
      if (value.isSuccessful) {}
      return value;
    });
  }
}
