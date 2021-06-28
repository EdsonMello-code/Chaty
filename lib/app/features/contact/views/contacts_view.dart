import 'package:flutter/material.dart';
import 'package:socket/app/features/contact/models/contact_model.dart';
import 'package:socket/app/features/contact/repositories/contact_repository.dart';
import 'package:socket/app/features/shared/components/contact_field_widget.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  late final TextEditingController inputController;
  late final TextEditingController emailInputController;
  late final TextEditingController nameInputController;
  late final ContactRepository contactRepository;
  late Future<List<ContactModel>> contacts;
  late Future<ContactModel> host;

  @override
  void initState() {
    contactRepository = ContactRepository();

    contactRepository.createConnection();
    host = contactRepository.getHost();

    // contactRepository.listContact().then((value) => print(value[0].name));
    inputController = TextEditingController();

    emailInputController = TextEditingController();
    nameInputController = TextEditingController();
    contacts = contactRepository.listContact();

    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<ContactModel>(
            future: host,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Text(snapshot.data!.name);
            }),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 20,
                      child: TextField(
                        controller: inputController,
                        onChanged: (value) async {
                          if (value.isNotEmpty) {
                            contacts =
                                contactRepository.listContactByName(value);
                            setState(() {});
                          } else {
                            contacts = contactRepository.listContact();
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.amberAccent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.amberAccent),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      print('kds');
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                Center(
                                  child: TextButton(
                                      onPressed: () async {
                                        await contactRepository.createContact(
                                          contacts: ContactModel(
                                            name: nameInputController.text,
                                            email: emailInputController.text,
                                          ),
                                        );

                                        Navigator.of(context).pop();

                                        contacts =
                                            contactRepository.listContact();

                                        setState(() {});
                                      },
                                      child: Text('Save')),
                                )
                              ],
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Email'),
                                      Container(
                                        width: 200,
                                        child: TextField(
                                          controller: emailInputController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Nome'),
                                      Container(
                                          width: 200,
                                          child: TextField(
                                            controller: nameInputController,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });

                      // Navigator.pushReplacementNamed(context, '/chat');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        FutureBuilder<List<ContactModel>>(
            future: contacts,
            builder: (context, snapshot) {
              final contact = snapshot.data;
              if (contact == null) {
                return CircularProgressIndicator();
              }
              return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    height: 500,
                    child: ListView(
                      children: contact
                          .map((contact) => ContactFieldWidget(
                              name: contact.name,
                              email: contact.email,
                              avatarPath: contact.avatarPath ?? ''))
                          .toList(),
                    ),
                  ));
            })
      ]),
    );
  }
}
