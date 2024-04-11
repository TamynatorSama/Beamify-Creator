class ChannelModel {
  final int id;
  final String channelName;
  final String channelDescription;
  final String channelImage;
  final String channelCoverImage;
  final List<PodModel> pods;

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
      pods: (json['pods'] as List<dynamic>).map((e)=>PodModel.fromJson(e)).toList(),
      channelCoverImage: json['cover_image'] ?? "");
}

class PodModel {
  final int podId;
  final String creatorId;
  final String podName;
  final String? podDescription;
  final String podType;
  final DateTime airDate;
  final bool isOnAir;
  final String likes;
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
      required this.commentCount,
      required this.likes,
      required this.viewerCount,
      required this.podName,
      required this.podType});

  factory PodModel.fromJson(Map<String, dynamic> json) => PodModel(
      airDate:
          DateTime.tryParse(json["air_date"]?? "") ?? DateTime.now(),
      creatorId: json["creator_id"],
      isBroadcasting: json['is_broadcasting'],
      isOnAir: json["on_air"],
      podDescription: json["pod_description"],
      podId: json["pod_id"],
      commentCount: json["comment_count"],
      likes: json["likes"],
      viewerCount: json["viewer_count"],
      podName: json["pod_name"],
      podType: json["pod_type"]);
}
