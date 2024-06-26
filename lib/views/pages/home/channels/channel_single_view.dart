import 'package:beamify_creator/controller/repository/signalling/php_signalling.dart';
import 'package:beamify_creator/models/channel/channel_model.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/views/pages/home/channels/widget/empty_pod.dart';
import 'package:beamify_creator/views/pages/home/channels/widget/event_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SingleChannelView extends StatelessWidget {
  final ChannelModel model;
  const SingleChannelView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).padding.top + 20,
                        horizontal: 24),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: model.channelCoverImage.isEmpty
                            ? const DecorationImage(
                                image:
                                    AssetImage("assets/images/record_room.jpg"),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: CachedNetworkImageProvider(
                                    model.channelCoverImage),
                                fit: BoxFit.cover),
                        backgroundBlendMode: BlendMode.overlay,
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xff262738), Color(0xffD9B38C)])),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).padding.top + 20,
                        horizontal: 24),
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        backgroundBlendMode: BlendMode.srcOver,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(175, 38, 39, 56),
                              Color.fromARGB(195, 217, 178, 140)
                            ])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Channel Detail",
                          style: AppTheme.headerStyle,
                        ),
                        const Opacity(
                          opacity: 0,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset:
                    Offset(0, (MediaQuery.of(context).size.height * 0.18) / 3),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15)),
                    child: model.channelImage.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(45.0),
                            child: Image.asset("assets/images/Audio track.png"),
                          )
                        : CachedNetworkImage(
                            imageUrl:
                                'https://beamify.stream/${model.channelImage}',
                            width: double.maxFinite,
                            cacheKey: model.channelImage,

                            // fit: BoxFit.cover
                          ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.18 / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStats(
                          title: "Followers",
                          value: model.pods.isEmpty ? "0": model.pods
                              .map((e) => int.parse(e.likes))
                              .reduce((value, element) => element + value)
                              .toString()),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  (((MediaQuery.of(context).size.width / 3) -
                                              44) /
                                          3)
                                      .clamp(12, 20)),
                          width: 2,
                          height: 20,
                          color: const Color.fromARGB(167, 142, 142, 142)),
                      _buildStats(
                          title: "Pods", value: model.pods.length.toString()),
                      Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  (((MediaQuery.of(context).size.width / 3) -
                                              44) /
                                          3)
                                      .clamp(12, 20)),
                          width: 2,
                          height: 20,
                          color: const Color.fromARGB(167, 142, 142, 142)),
                      _buildStats(
                          title: "Listeners",
                          value: model.pods.isEmpty ? "0":  model.pods
                              .map((e) => int.parse(e.viewerCount))
                              .reduce((value, element) => element + value)
                              .toString())
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                        "Live Events ",
                        style: AppTheme.headerStyle,
                      ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          const SizedBox(
                            height: 25,
                          ),
                          model.pods.isEmpty
                                ? emptyPod()
                                : Column(
                                    children: List.generate(
                                        model.pods.length,
                                        (index) => Padding(
                                            padding: EdgeInsets.only(
                                                bottom:
                                                    index == model.pods.length - 1
                                                        ? 0
                                                        : 25),
                                            child: InkWell(
                                              onTap: ()=>PhpSignalling().tiggerEvent(model.pods[index].podId.toString()),
                                              child: eventBuilder(
                                                
                                                model.pods[index],
                                              ),
                                            ))),
                                  ),
                          
                          // Expanded(
                          //     child: ListView.builder(
                          //       clipBehavior: Clip.antiAlias,
                          //       padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom+20),
                          //       itemCount: dummyEventData.length,
                          // itemBuilder: (context,index)=>Padding(padding: EdgeInsets.only(
                          // bottom: index == dummyChannelData.length - 1 ? 0 : 25),child: _eventBuilder(dummyEventData[index],))))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildStats({required String title, required String value}) => Column(
      children: [
        Text(
          value,
          style: AppTheme.headerStyle.copyWith(fontSize: 22),
        ),
        Text(
          title,
          style: AppTheme.bodyTextLight.copyWith(),
        )
      ],
    );
