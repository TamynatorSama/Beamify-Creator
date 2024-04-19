class ApiRoutes {
  // Profile 
  static const String profileRoute = '/profile';
  static const String updateProfileAvatar = '/profile';
  static const String getProfile = '/profile/update_avatar';
  // Channel
  static const String channelRoute = '/channels';
  String updateChannelImage(String channelId) => '/channels/$channelId/update_channel_image';
  static const String singleChannelRoute = '/channels/';
  // Pods
  static const String podRoute = '/pods';
  static const String singlePodRoute = '/pods/';
  String podComment(String podId) => '/pods/$podId/comment';
  
}
