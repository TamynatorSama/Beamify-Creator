import 'dart:io';

import 'package:beamify_creator/models/category_model.dart';
import 'package:beamify_creator/models/channel/channel_model.dart';
import 'package:beamify_creator/models/user_model.dart';
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

  Future<HttpResponse> getUserProfile() async {
    return await HttpHelper.getRequest("profile").then((value) {
      if (value.isSuccessful) {
        return (value as SuccessResponse).withConverter((json) {
          final jsonData = value.result["user"];
          return UserModel.fromJson(jsonData);
        });
      }
      return value;
    });
  }

  Future<HttpResponse> getUserChannels() async {
    return await HttpHelper.getRequest("channels?include=pod").then((value) {
      if (value.isSuccessful) {
        return (value as SuccessResponse).withConverter((json) {
          final jsonData = value.result["channels"];
          return (jsonData as Iterable)
              .map((e) => ChannelModel.fromJson(e))
              .toList();
        });
      }
      return value;
    });
  }

  Future<HttpResponse> createChannel(
      {required String channelDescription,
      required String channelName,
      File? coverImage,
      String? amount,String? frequency,
      required String category,
      File? image,
      required String type}) async {
    final payload = type.toLowerCase().contains("free") ?{
      'channel_name': channelName,
      'channel_description': channelDescription,
      'channel_type': type
    }:{
      'channel_name': channelName,
      'channel_description': channelDescription,
      'channel_type': type,
      "interval":frequency??"",
      'amount':amount??"",
      "categories": category
    };

    List<Map<String, File>> uploadFiles = [];
    if (image != null) {
      uploadFiles.add({"channel_image": image});
    }
    if (coverImage != null) {
      uploadFiles.add({"cover_image": coverImage});
    }
    return await HttpHelper.postFormRequest('channels',
            payload: payload, files: uploadFiles)
        .then((value) {
      if (value.isSuccessful) {
        return (value as SuccessResponse).withConverter((json) {
          final jsonData = value.result["channel"];
          return ChannelModel.fromJson(jsonData);
        });
      }
      return value;
    });
  }

  Future<HttpResponse> createPod(
      {required String channelId,
      required String podType,
      required String podName,
      required String podDescription,
      DateTime? airDate,
      required bool onAir,
      required bool isBroadcasting}) async {
    final payload = {
      'channel_id': channelId,
      'pod_type': podType,
      'pod_name': podName,
      'on_air': onAir,
      'is_broadcasting': isBroadcasting,
      'pod_description': podDescription,
    };
    if (airDate != null) {
      payload["air_date"] = airDate.toIso8601String();
    }


    return await HttpHelper.postRequest('pods', payload: payload).then((value) {
      if (value.isSuccessful) {
        return (value as SuccessResponse).withConverter((json) {
          Map<String, dynamic> newValue = value.result["pod"];
          return PodModel.fromJson(newValue);
        });
      }
      return value;
    });
    // return await HttpHelper.postFormRequest('pods',
    //         payload: payload, files: uploadFiles)
    //     .then((value) {
    // if (value.isSuccessful) {
    //   return (value as SuccessResponse).withConverter((json) {
    //     Map<String, dynamic> newValue = value.result["pod"];
    //     return PodModel.fromJson(newValue);
    //   });
    // }
    // return value;
    // });
  }
}
