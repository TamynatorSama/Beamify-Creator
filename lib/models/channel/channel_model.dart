class ChannelModel{
  final int id;
  final String channelName;
  final String channelDescription;
  final String channelImage;
  final String channelCoverImage;
  final List<String> pods;


  const ChannelModel({required this.id,required this.channelName,required this.channelDescription,this.channelCoverImage = "",this.channelImage = "",this.pods = const []});



  factory ChannelModel.fromJson(Map<String,dynamic>json)=>ChannelModel(id: json['channel_id'], channelName:json ['channel_name'], channelDescription: json['channel_description'],channelImage:json['channel_image']??"",channelCoverImage:json['cover_image']??"" );

}