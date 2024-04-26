import 'package:beamify_creator/controller/state_manager/bloc/app_bloc.dart';
import 'package:beamify_creator/controller/state_manager/bloc/pod_bloc.dart';
import 'package:beamify_creator/controller/state_manager/events/pod_events.dart';
import 'package:beamify_creator/controller/state_manager/state/app_state.dart';
import 'package:beamify_creator/models/channel/channel_model.dart';
import 'package:beamify_creator/models/user_model.dart';
import 'package:beamify_creator/views/pages/home/channels/channel_single_view.dart';
import 'package:beamify_creator/views/pages/home/channels/widget/empty_pod.dart';
import 'package:beamify_creator/views/pages/home/channels/widget/event_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:get_time_ago/get_time_ago.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChannelsPage extends StatefulWidget {
  const ChannelsPage({super.key});

  @override
  State<ChannelsPage> createState() => _ChannelsPage();
}

class _ChannelsPage extends State<ChannelsPage> {
  GlobalKey forYouTab = GlobalKey();
  GlobalKey radioTab = GlobalKey();
  GlobalKey bookTab = GlobalKey();
  double indicatorWidth = 0.0;
  Offset indicatorOffset = const Offset(0, 0);
  late GlobalKey selectedKey;

  @override
  void initState() {
    selectedKey = forYouTab;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setPosition(selectedKey);
    });
    super.initState();
  }

  setPosition(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox;
    indicatorWidth = box.size.width;
    indicatorOffset = box.localToGlobal(Offset.zero);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      setPosition(selectedKey);
    });
    super.didChangeDependencies();
  }

  // List<Map<String, dynamic>> dummyChannelData = [
  //   {
  //     "imagePath": "assets/images/Jesus_the_Light_of_the_world.jpg",
  //     "title": "Victory Prayers",
  //     "creator": "AFM Mafoluku"
  //   },
  //   {
  //     "imagePath": "assets/images/prayer_woman.jpg",
  //     "title": "Women’s Prayers",
  //     "creator": "AFM Nsisuk"
  //   },
  //   {
  //     "imagePath": "assets/images/concecration.jpg",
  //     "title": "Parents Heaven",
  //     "creator": "Liza Riyad Podcast"
  //   }
  // ];
  // List<Map<String, dynamic>> dummyEventData = [
  //   {
  //     "imagePath": "assets/images/Jesus_the_Light_of_the_world.jpg",
  //     "title": "God’s Promises",
  //     "tags": "AFM Anthony || Bible Studies || Jk Biodun ",
  //     "time_ago": "Live since 25 min ago"
  //   },
  //   {
  //     "imagePath": "assets/images/prayer_woman.jpg",
  //     "title": "Pray and Grateful",
  //     "tags": "AFM Mafoluku || Bible Studies || Jk Biodun",
  //     "time_ago": "Live since  45 min ago"
  //   },
  //   {
  //     "imagePath": "assets/images/concecration.jpg",
  //     "title": "Thanksgiving to God",
  //     "tags": "AFM Ketu || Bible Studies || Jk Biodun ",
  //     "time_ago": "Live since  45 min ago"
  //   }
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, cont) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildUserInfo(cont.user),
                    SvgPicture.asset("assets/icons/notification.svg")
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(17),
                  child: CustomInputField(
                    controller: TextEditingController(),
                    hintText: "How can i help",
                    shinrink: true,
                    prefixIcon: SvgPicture.asset("assets/icons/search.svg"),
                    showBorder: false,
                    showRightBorder: false,
                    noBorders: true,
                    decoration: const InputDecoration(
                        filled: true, fillColor: Color(0xff1f2026)),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Wrap(
                      spacing: 20,
                      alignment: WrapAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            setPosition(forYouTab);
                            selectedKey = forYouTab;
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 8))),
                          child: Text(
                            "For You",
                            style: AppTheme.buttonStyle
                                .copyWith(color: Colors.white),
                            key: forYouTab,
                          ),
                        ),
                        TextButton(
                          onPressed: ()async {
                            setPosition(radioTab);
                            selectedKey = radioTab;
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 8))),
                          child: Text(
                            "Radio",
                            style: AppTheme.buttonStyle
                                .copyWith(color: Colors.white),
                            key: radioTab,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              setPosition(bookTab);
                              selectedKey = bookTab;
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 8))),
                            child: Text(
                              "Audio Book",
                              style: AppTheme.buttonStyle
                                  .copyWith(color: Colors.white),
                              key: bookTab,
                            )),
                      ],
                    ),
                    AnimatedPositioned(
                      left: indicatorOffset.dx - 24,
                      duration: const Duration(milliseconds: 100),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 50),
                        width: indicatorWidth,
                        height: 3,
                        decoration: const ShapeDecoration(
                            color: Color(0xffE90064), shape: StadiumBorder()),
                      ),
                    )
                  ],
                ),
                
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                  height: 20,
                ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text(
                      "My Channels",
                      style: AppTheme.headerStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  cont.channels.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: emptyPod(message: "You have no channels"),
                        )
                      : SingleChildScrollView(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: List.generate(
                              cont.channels.length,
                              (index) => Padding(
                                padding: EdgeInsets.only(
                                    right: index == cont.channels.length - 1
                                        ? 0
                                        : 25),
                                child: _buildChannelCard(
                                    context, cont.channels[index]),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Pods Streaming Now",
                          style: AppTheme.headerStyle,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Builder(builder: (context) {
                          List<PodModel> displayModel = [];

                          for (ChannelModel mod in cont.channels) {
                            for (PodModel casts in mod.pods) {
                              if (displayModel.length > 5) break;
                              if (casts.isOnAir ||
                                  casts.isBroadcasting ||
                                  casts.airDate.day == DateTime.now().day) {
                                displayModel.add(casts);
                              }
                            }
                          }
                          return displayModel.isEmpty
                              ? emptyPod()
                              : Column(
                                  children: List.generate(
                                      displayModel.length,
                                      (index) => Padding(
                                          padding: EdgeInsets.only(
                                              bottom: index ==
                                                      displayModel.length - 1
                                                  ? 0
                                                  : 25),
                                          child: GestureDetector(
                                            onTap: () => context
                                                .read<PodBloc>()
                                                .add(CheckForEventUser(
                                                    context: context,
                                                    podId: displayModel[index]
                                                        .podId
                                                        .toString())),
                                            child: eventBuilder(
                                              displayModel[index],
                                            ),
                                          ))),
                                );
                        })
                        // Expanded(
                        //     child: ListView.builder(
                        //       clipBehavior: Clip.antiAlias,
                        //       padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom+20),
                        //       itemCount: dummyEventData.length,
                        // itemBuilder: (context,index)=>Padding(padding: EdgeInsets.only(
                        // bottom: index == dummyChannelData.length - 1 ? 0 : 25),child: _eventBuilder(dummyEventData[index],))))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  Widget _buildChannelCard(BuildContext context, ChannelModel data) {
    double imageSize = MediaQuery.of(context).size.width * 0.45;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SingleChannelView(
                model: data,
              ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: imageSize,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: imageSize,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              // image: DecorationImage(
              //     image: NetworkImage(
              //         'https://beamify.stream/${data.channelImage}'),
              //     fit: BoxFit.cover)
            ),
            child: data.channelImage.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(45.0),
                    child: Image.asset("assets/images/Audio track.png"),
                  )
                : CachedNetworkImage(
                    imageUrl: 'https://beamify.stream/${data.channelImage}',
                    cacheKey: data.channelImage,
                    fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: imageSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.channelName,
                  maxLines: 2,
                  style: AppTheme.headerStyle.copyWith(fontSize: 20),
                ),
                Text(
                  data.channelDescription,
                  style: AppTheme.bodyTextLight.copyWith(fontSize: 13),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserInfo(UserModel? model) => Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // image: const DecorationImage(
              //     image:  AssetImage("assets/images/demo-dp.jpg"),
              //     fit: BoxFit.cover)),
            ),
            child: model?.avatar != null
                ? Image.network(
                    'https://beamify.stream/${model!.avatar!}',
                    errorBuilder: (context, error, stackTrace) =>
                        SvgPicture.string(
                      """<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><circle cx="12" cy="6" r="4" fill="#163C86"/><path fill="#163C86" d="M20 17.5c0 2.485 0 4.5-8 4.5s-8-2.015-8-4.5S7.582 13 12 13s8 2.015 8 4.5" opacity="0.5"/></svg>""",
                      theme: const SvgTheme(currentColor: AppTheme.btnColor),
                    ),
                  )
                : SvgPicture.string(
                    """<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><circle cx="12" cy="6" r="4" fill="#163C86"/><path fill="#163C86" d="M20 17.5c0 2.485 0 4.5-8 4.5s-8-2.015-8-4.5S7.582 13 12 13s8 2.015 8 4.5" opacity="0.5"/></svg>""",
                    theme: const SvgTheme(currentColor: AppTheme.btnColor),
                  ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning  👋",
                style: AppTheme.bodyTextLight,
              ),
              Text(
                model?.firstName ?? "",
                style: AppTheme.headerStyle.copyWith(fontSize: 22),
              )
            ],
          )
        ],
      );
}
