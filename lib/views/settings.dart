import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF263238),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              _header(),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Damilola',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text(
                  'I love to make imagination into design',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Accounts',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Free plan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  'Upgrade your plan',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                ),
              ),

              //
              const Text(
                'Constant preferences',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Allow Explicit Content',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                subtitle: SizedBox(
                  width: 50,
                  child: Text(
                    'Tap to play explicit content explicit content is labeled with E tag',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              //Choose your preferred languages for audio
              //
              const Text(
                'Languages',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.all(0),
                trailing: Checkbox(
                  value: false,
                  onChanged: (_) {},
                ),
                title: const Text(
                  'Languages for music',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                subtitle: SizedBox(
                  width: 50,
                  child: Text(
                    'Choose your preferred languages for audio',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              //
              const Text(
                'Audio Quality',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const ListTile(
                visualDensity: VisualDensity(vertical: -4),
                contentPadding: EdgeInsets.all(0),
                trailing: SizedBox(
                  width: 90,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Very High',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                title: Text(
                  'WiFi streaming',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Mobile streaming',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                subtitle: SizedBox(
                  width: 50,
                  child: Text(
                    'Streaming higher quality over a mobile connection uses more data.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              //
              Row(
                children: [
                  const Text(
                    'Download using mobile data',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Checkbox(
                    value: false,
                    onChanged: (_) {},
                  )
                ],
              ),
              //
              const Text(
                'About',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                subtitle: SizedBox(
                  width: 50,
                  child: Text(
                    'All the stuff you need to know.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                subtitle: SizedBox(
                  width: 50,
                  child: Text(
                    'Important for both of us.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              //Help keep this platform safe for all
              ListTile(
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.all(0),
                title: const Text(
                  'Rules',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                subtitle: SizedBox(
                  width: 50,
                  child: Text(
                    'Help keep this platform safe for all ',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _header() => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 0,
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
            'Settings',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          SizedBox(),
        ],
      ),
    );
