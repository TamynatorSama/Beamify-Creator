import 'dart:io';

import 'package:beamify_creator/controller/state_manager/bloc/app_bloc.dart';
import 'package:beamify_creator/controller/state_manager/bloc/auth_bloc.dart';
import 'package:beamify_creator/controller/state_manager/events/app_events.dart';
import 'package:beamify_creator/controller/state_manager/state/app_state.dart';
// import 'package:beamify_creator/controller/state_manager/state/auth_action.dart';
import 'package:beamify_creator/shared/enum/channel_type_enum.dart';
import 'package:beamify_creator/shared/enum/subscription_frequency_enum.dart';
import 'package:beamify_creator/shared/social_auth_button.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/custom_button.dart';
import 'package:beamify_creator/shared/utils/custom_input_field.dart';
import 'package:beamify_creator/views/single_image_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateChannel extends StatefulWidget {
  const CreateChannel({super.key});

  @override
  State<CreateChannel> createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  late TextEditingController channelNameController;
  late TextEditingController channelDescriptionController;
  late TextEditingController amountController;
  SubscriptionFrequency subscriptionFrequency = SubscriptionFrequency.monthly;
  ChannelType channelType = ChannelType.free;
  late TextEditingController channelTypeController;
  File? coverImage;
  File? channelImage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    channelNameController = TextEditingController();
    channelDescriptionController = TextEditingController();
    amountController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 20,
              ),
              buildSocialLogins(
                "assets/icons/Arrow-Left.svg",
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Channel",
                    style: AppTheme.headerStyle,
                  ),
                  Text(
                    "Enter neccessary details to create a channel.",
                    style: AppTheme.bodyText
                        .copyWith(color: Colors.white.withOpacity(0.7)),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    child: IntrinsicHeight(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Column(children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (coverImage == null) return;
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => SingleImageView(
                                                file: coverImage!),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundImage: coverImage != null
                                                ? FileImage(coverImage!)
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                        );

                                        if (result != null) {
                                          setState(() {
                                            coverImage =
                                                File(result.files.single.path!);
                                          });
                                        }
                                      },
                                      child: const Text(
                                        'Select Channel Cover Image',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const Spacer(),
                                    CloseButton(
                                      onPressed: () {
                                        setState(() {
                                          coverImage = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (channelImage == null) return;
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => SingleImageView(
                                                file: channelImage!),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 18,
                                            backgroundImage:
                                                channelImage != null
                                                    ? FileImage(channelImage!)
                                                    : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                        );

                                        if (result != null) {
                                          setState(() {
                                            channelImage =
                                                File(result.files.single.path!);
                                          });
                                        } else {
                                          // User canceled the picker
                                        }
                                      },
                                      child: const Text(
                                        'Select Channel Image',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const Spacer(),
                                    CloseButton(
                                      onPressed: () {
                                        setState(() {
                                          channelImage = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomInputField(
                                  hintText: "Channel Name",
                                  inputType: TextInputType.name,
                                  controller: channelNameController,
                                  validator: (val) {
                                    if (val.runtimeType == String &&
                                        val.length < 4) {
                                      return 'Channel name must be more than 4 chars';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomInputField(
                                  hintText: "Describe your channel",
                                  inputType: TextInputType.multiline,
                                  controller: channelDescriptionController,
                                  validator: (val) {
                                    if (val.runtimeType == String &&
                                        val.length < 8) {
                                      return 'Channel name must be more than 4 chars';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                DropdownButtonFormField(
                                  dropdownColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  hint: const Text("Channel Type"),
                                  value: channelType,
                                  items: const [
                                    DropdownMenuItem(
                                      value: ChannelType.free,
                                      child: Text(
                                        'Free',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: ChannelType.paid,
                                      child: Text(
                                        'Paid',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                  onChanged: (val) {
                                    if (val == null) return;
                                    setState(() {
                                      channelType = val;
                                    });
                                  },
                                ),
                                if (channelType == ChannelType.paid) ...[
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  DropdownButtonFormField(
                                    dropdownColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    hint:
                                        const Text("Frequency of subscription"),
                                    value: subscriptionFrequency,
                                    items: const [
                                      DropdownMenuItem(
                                        value: SubscriptionFrequency.weekly,
                                        child: Text(
                                          'Weekly',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: SubscriptionFrequency.monthly,
                                        child: Text(
                                          'Monthly',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      if (val == null) return;
                                      setState(() {
                                        subscriptionFrequency = val;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomInputField(
                                    hintText: "Amount",
                                    inputType: TextInputType.number,
                                    controller: amountController,
                                    validator: (val) {
                                      final amount = int.tryParse(val);
                                      if (amount == null || amount < 100) {
                                        return 'Amount must be a valid number above 100 naira';
                                      }

                                      return null;
                                    },
                                  ),
                                ],
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const Spacer(),
                          BlocBuilder<AppBloc, AppState>(
                              builder: (context, controller) {
                            return CustomButton(
                                text: "Create",
                                isLoading: controller.isLoading,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<AppBloc>().add(
                                        CreateChannelEvent(
                                          context: context,
                                            channelDescription:
                                                channelDescriptionController
                                                    .text,
                                            channelName:
                                                channelNameController.text,
                                            image: channelImage,
                                            type: channelType.name,
                                            coverImage: coverImage));
                                  }
                                });
                          }),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).padding.bottom + 20),
                        ]),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
