import 'package:beamify_creator/models/category_model.dart';
import 'package:beamify_creator/shared/http/http_helper.dart';

class AppRepository {
  Future<HttpResponse> getSystemCategories() async {
    return await HttpHelper.getRequest("utils/system_tags").then((value) {
      if (value.isSuccessful) {
        return (value as SuccessResponse).withConverter((json) {
          final jsonData = value.result;
          return (jsonData as Iterable)
              .map((e) => CategoryModel.fromJson(e))
              .toList();
        });
      }
      return value;
    });
  }
}
