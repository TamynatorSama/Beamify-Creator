 import 'package:beamify_creator/models/channel/channel_model.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_time_ago/get_time_ago.dart';

Widget eventBuilder(PodModel data) => GestureDetector(
        // onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
        // builder: (context) => StreamingPage(data: data,))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                // if(data.isBroadcasting) 
                          Transform.translate(
                            offset: const Offset(0, -5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal:7),
                              decoration: const ShapeDecoration(
                                shape: StadiumBorder(),
                                color: AppTheme.primaryColor
                                ),
                              child: Text(data.podTag,style: AppTheme.headerStyle.copyWith(fontSize: 9),),
                            ),
                          ),
                Container(
                  height: 55,
                  width: 55,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                  ),
                          child:data.image.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("assets/images/Audio track.png"),
                      )
                    : CachedNetworkImage(imageUrl:'https://beamify.stream/${data.image}',
                    cacheKey: data.image,
                        fit: BoxFit.cover),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.podName,
                  style: AppTheme.headerStyle.copyWith(fontSize: 17),
                ),
                if( data.podDescription !=null)
                Text(
                  data.podDescription ??"",
                  style: AppTheme.bodyTextLight.copyWith(fontSize: 11),
                ),
                Text(
                  "${GetTimeAgo.parse(data.airDate)} | ${data.podType}",
                  style: AppTheme.bodyTextLight.copyWith(fontSize: 11),
                ),
              ],
            )),
            const SizedBox(
              width: 15,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: SvgPicture.asset("assets/icons/play.svg"),
            )
          ],
        ),
      );
