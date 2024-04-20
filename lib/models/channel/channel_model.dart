class ChannelModel {
  final int id;
  final String channelName;
  final String channelDescription;
  final String channelImage;
  final String channelCoverImage;
  final List<PodModel> pods;

  ChannelModel copyWith({
    int? id,
    List<PodModel>? pods,
    String? channelCoverImage,
    String? channelName,
    String? channelDescription,
    String? channelImage,
  }) =>
      ChannelModel(
          id: id ?? this.id,
          channelName: channelName ?? this.channelName,
          channelDescription: channelDescription ?? this.channelDescription,
          pods: pods ?? this.pods,
          channelCoverImage: channelCoverImage?? this.channelCoverImage,
          channelImage: channelImage ?? this.channelImage
          );

  const ChannelModel(
      {required this.id,
      required this.channelName,
      required this.channelDescription,
      this.channelCoverImage = "",
      this.channelImage = "",
      this.pods = const []});

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
      id: json['channel_id'],
      channelName: json['channel_name'],
      channelDescription: json['channel_description'],
      channelImage: json['channel_image'] ?? "",
      pods: ((json['pods'] ?? []) as List<dynamic>)
          .map((e) => PodModel.fromJson(e))
          .toList(),
      channelCoverImage: json['cover_image'] ?? "");
}

class PodModel {
  final int podId;
  final String creatorId;
  final String podName;
  final String? podDescription;
  final String podType;
  final String image;
  final DateTime airDate;
  final bool isOnAir;
  final String likes;
  final int channelId;
  final String viewerCount;
  final String commentCount;
  final bool isBroadcasting;

  const PodModel(
      {required this.airDate,
      required this.creatorId,
      required this.isBroadcasting,
      required this.isOnAir,
      required this.podDescription,
      required this.podId,
      this.image = "",
      required this.channelId,
      required this.commentCount,
      required this.likes,
      required this.viewerCount,
      required this.podName,
      required this.podType});

  factory PodModel.fromJson(Map<String, dynamic> json) => PodModel(
      airDate: DateTime.tryParse((json["air_date"] is String)
              ? json["air_date"]
              : json["air_date"]["date"] ?? "") ??
          DateTime.now(),
      channelId: int.parse(json["channel_id"].toString()),
      creatorId: json["creator_id"].toString(),
      isBroadcasting: json['is_broadcasting'],
      isOnAir: json["on_air"],
      podDescription: json["pod_description"],
      podId: json["pod_id"],
      commentCount: json["comment_count"].toString(),
      likes: json["likes"].toString(),
      viewerCount: json["viewer_count"].toString(),
      podName: json["pod_name"],
      podType: json["pod_type"]);
}
