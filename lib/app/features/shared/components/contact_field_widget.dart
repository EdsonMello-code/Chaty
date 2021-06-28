import 'package:flutter/material.dart';
import 'package:socket/app/features/contact/repositories/contact_repository.dart';
import 'package:socket/app/features/shared/state/message_state.dart';
// import 'package:socket/app/features/shared/state/message.dart';

class ContactFieldWidget extends StatefulWidget {
  final String name;
  final String email;
  final String avatarPath;

  const ContactFieldWidget(
      {Key? key,
      required this.name,
      required this.email,
      required this.avatarPath})
      : super(key: key);

  @override
  _ContactFieldWidgetState createState() => _ContactFieldWidgetState();
}

class _ContactFieldWidgetState extends State<ContactFieldWidget> {
  late final String from;
  late final ContactRepository contactRepository;

  @override
  void initState() {
    contactRepository = ContactRepository();
    initFrom();
    super.initState();
  }

  initFrom() async {
    var host = await contactRepository.getHost();
    from = host.email;
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    final name = widget.name;

    return GestureDetector(
      onTap: () {
        Message.message.storeHostEmail(to: widget.email, from: from);
        Navigator.pushReplacementNamed(context, '/chat');
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.redAccent,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: $email'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Name: $name'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.white24,
            ),
          )
        ],
      ),
    );
  }
}
