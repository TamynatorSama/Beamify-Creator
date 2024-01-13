import 'package:beamify_creator/views/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';

class EventScheduler extends StatelessWidget {
  const EventScheduler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2224),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: _header(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _txtField('Event Title*', 'Input Event Title Here'),
                      const SizedBox(
                        height: 22,
                      ),
                      dropdownField(
                          'Event Category*', 'Event Category e.g Sermon'),
                      const SizedBox(
                        height: 22,
                      ),
                      _txtField(
                        'Name of Presenters (Optional)',
                        'Input Presenters name e.g J.K Biodun',
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      dropdownField(
                        'Microphone Source',
                        'Select sound input source e.g built-in Mic',
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        children: [
                          _customInputField(
                            isDate: true,
                            value: '05/03/2024',
                            fieldName: 'Start Date',
                          ),
                          const Spacer(),
                          _customInputField(
                            value: '1pm',
                            isDate: false,
                            fieldName: 'Start Time',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Row(
                        children: [
                          _customInputField(
                            isDate: true,
                            value: '05/03/2024',
                            fieldName: 'End Date',
                          ),
                          const Spacer(),
                          _customInputField(
                            value: '1pm',
                            isDate: false,
                            fieldName: 'End Time',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      _txtField(
                        'Upload Event  Photo (Optional)',
                        'must be PNG, JPG, JPEG',
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      customButton(txt: 'Save Schedule', width: 209),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}

_customInputField({
  required String value,
  required bool isDate,
  required String fieldName,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            fieldName,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: 158,
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.45),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Icon(
                isDate ? Icons.calendar_month : Icons.arrow_drop_down_rounded,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );

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

Widget dropdownField(String title, String hint) => Column(
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
        DropdownButtonFormField(
          items: const [
            // DropdownMenuItem(
            //   // value: ,
            //   child: Text('Sermon'),
            // ),
          ],
          onChanged: (_) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.45),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );

Widget _header() => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
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
            'Event Scheduler',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          SizedBox(),
        ],
      ),
    );
