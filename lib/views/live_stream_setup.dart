import 'package:beamify_creator/controller/repository/signalling/firebase_signalling.dart';
import 'package:beamify_creator/controller/repository/signalling/signalling_repository.dart';
import 'package:beamify_creator/controller/state_manager/bloc/app_bloc.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/custom_button.dart';
import 'package:beamify_creator/shared/utils/custom_input_field.dart';
import 'package:beamify_creator/views/event_scheduler.dart';
import 'package:beamify_creator/views/now_streaming_page.dart';
import 'package:beamify_creator/views/pages/onboarding/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveStreamSetup extends StatefulWidget {
  const LiveStreamSetup({super.key});
  @override
  State<LiveStreamSetup> createState() => _LiveStreamSetup();
}

class _LiveStreamSetup extends State<LiveStreamSetup> {
  late ISignalling signalling;
  final GlobalKey<PopupMenuButtonState> _popKey =
      GlobalKey<PopupMenuButtonState>();
      final GlobalKey<PopupMenuButtonState> _categoryKey =
      GlobalKey<PopupMenuButtonState>();

      final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  TextEditingController eventTitleController = TextEditingController();
  TextEditingController eventCategoryController = TextEditingController();
  TextEditingController presenter = TextEditingController();
  TextEditingController micSource = TextEditingController();
  TextEditingController pictureUpload = TextEditingController();

  @override
  void initState() {
    signalling = FirebaseSignalling();
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   await widget.signalling.createPod();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1D2224),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1D2224),
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          title: Text('Live Stream Setup', style: AppTheme.headerStyle),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: LayoutBuilder(builder: (context, lay) {
              return SingleChildScrollView(
                child: IntrinsicHeight(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: lay.maxHeight),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: _formKey,
                            child: Column(
                          children: [
                            CustomInputField(
                              label: "Event Title*",
                              controller: eventTitleController,
                              hintText: 'Input Event Title Here',
                            ),
                            const SizedBox(height: 24),
                            PopupMenuButton(
                                  key: _categoryKey,
                                  padding: const EdgeInsets.all(7),
                                  color: AppTheme.backgroundColor,
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 100),
                                  constraints: BoxConstraints(
                                      minWidth:
                                          MediaQuery.of(context).size.width -
                                              52),
                                  child: CustomInputField(
                                    label: 'Microphone Source',
                                    controller: eventCategoryController,
                                    onTap: () {
                                      if (_categoryKey.currentState != null) {
                                        _categoryKey.currentState!.showButtonMenu();
                                      }
                                    },
                                    suffixIcon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    readOnly: true,
                                    hintText:
                                        'choose pod category',
                                  ),
                                  itemBuilder: (context) => context
                                      .read<AppBloc>()
                                      .state
                                      .tags
                                      .map((e) => PopupMenuItem(
                                          padding: const EdgeInsets.all(15),
                                          onTap: () {
                                            eventCategoryController.text = e.tagSlug;
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.string(
                                                """<svg xmlns="http://www.w3.org/2000/svg" width="0.75em" height="1em" viewBox="0 0 384 512"><path fill="currentColor" d="M192 0c-53 0-96 43-96 96v160c0 53 43 96 96 96s96-43 96-96V96c0-53-43-96-96-96M64 216c0-13.3-10.7-24-24-24s-24 10.7-24 24v40c0 89.1 66.2 162.7 152 174.4V464h-48c-13.3 0-24 10.7-24 24s10.7 24 24 24h144c13.3 0 24-10.7 24-24s-10.7-24-24-24h-48v-33.6c85.8-11.7 152-85.3 152-174.4v-40c0-13.3-10.7-24-24-24s-24 10.7-24 24v40c0 70.7-57.3 128-128 128S64 326.7 64 256z"/></svg>""",
                                                width: 24,
                                                theme: const SvgTheme(
                                                    currentColor:
                                                        AppTheme.primaryColor),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                e.tagSlug,
                                                style: AppTheme.buttonStyle
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          )))
                                      .toList()),
                            const SizedBox(height: 24),
                            CustomInputField(
                              label: 'Name of Presenters (Optional)',
                              controller: presenter,
                              validator: (value) {
                                return null;
                              },
                              hintText: 'Input Presenters name e.g J.K Biodun',
                            ),
                            const SizedBox(height: 24),
                            Theme(
                              data: Theme.of(context).copyWith(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent),
                              child: PopupMenuButton(
                                  key: _popKey,
                                  padding: const EdgeInsets.all(7),
                                  color: AppTheme.backgroundColor,
                                  position: PopupMenuPosition.under,
                                  offset: const Offset(0, 100),
                                  constraints: BoxConstraints(
                                      minWidth:
                                          MediaQuery.of(context).size.width -
                                              52),
                                  child: CustomInputField(
                                    label: 'Microphone Source',
                                    controller: micSource,
                                    onTap: () {
                                      if (_popKey.currentState != null) {
                                        _popKey.currentState!.showButtonMenu();
                                      }
                                    },
                                    suffixIcon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    readOnly: true,
                                    hintText:
                                        'Select sound input source e.g built-in Mic',
                                  ),
                                  itemBuilder: (context) => context
                                      .read<AppBloc>()
                                      .state
                                      .audioSource
                                      .map((e) => PopupMenuItem(
                                          padding: const EdgeInsets.all(15),
                                          onTap: () {
                                            micSource.text = e.name;
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.string(
                                                """<svg xmlns="http://www.w3.org/2000/svg" width="0.75em" height="1em" viewBox="0 0 384 512"><path fill="currentColor" d="M192 0c-53 0-96 43-96 96v160c0 53 43 96 96 96s96-43 96-96V96c0-53-43-96-96-96M64 216c0-13.3-10.7-24-24-24s-24 10.7-24 24v40c0 89.1 66.2 162.7 152 174.4V464h-48c-13.3 0-24 10.7-24 24s10.7 24 24 24h144c13.3 0 24-10.7 24-24s-10.7-24-24-24h-48v-33.6c85.8-11.7 152-85.3 152-174.4v-40c0-13.3-10.7-24-24-24s-24 10.7-24 24v40c0 70.7-57.3 128-128 128S64 326.7 64 256z"/></svg>""",
                                                width: 24,
                                                theme: const SvgTheme(
                                                    currentColor:
                                                        AppTheme.primaryColor),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                e.name,
                                                style: AppTheme.buttonStyle
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          )))
                                      .toList()),
                            ),
                            const SizedBox(height: 24),
                            CustomInputField(
                              label: 'Upload Event  Photo (Optional)',
                              controller: pictureUpload,
                              
                              validator: (value) {
                                return null;
                              },
                              hintText: 'must be PNG, JPG, JPEG',
                            ),
                          ],
                        )),
                        const Spacer(),
                        const SizedBox(height: 24),
                        CustomButton(
                          text: "Save and Go Live",
                          onTap: () async {
                            if(_formKey.currentState!.validate()){
                              await signalling
                                .openUserMedia()
                                .then((_) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NowStreamingView(
                                              signalling: signalling,
                                            ))));
                            }
                            

                            // WebRtcTest.startPod("samuel");
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).padding.bottom + 20),
                      ],
                    ),
                  ),
                ),
              );
            })));
  }
}

Widget _txtField(String title, String hint) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 4),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        customTextField(hintText: hint),
      ],
    );

Widget _header() => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 16,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          Text(
            'Live Stream Setup',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          SizedBox(),
        ],
      ),
    );
