import 'package:flutter/material.dart';
import 'package:socket/app/features/contact/models/contact_model.dart';
import 'package:socket/app/features/contact/repositories/contact_repository.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> _formkey;
  late final TextEditingController emailInputController;
  late final TextEditingController nameInputController;
  late final ContactRepository contactRepository;

  @override
  void initState() {
    _formkey = GlobalKey<FormState>();

    emailInputController = TextEditingController();
    nameInputController = TextEditingController();

    contactRepository = ContactRepository();
    verifyIfSettedHost();

    super.initState();
  }

  verifyIfSettedHost() async {
    var host = await contactRepository.getHost();
    if (host.name != 'Nulo') {
      return Navigator.pushReplacementNamed(context, '/contacts');
    }
  }

  @override
  void dispose() {
    emailInputController.dispose();
    nameInputController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .9,
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailInputController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: nameInputController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  )),
            ),
            TextButton(
                onPressed: () async {
                  await contactRepository.createHost(ContactModel(
                      name: nameInputController.text,
                      email: emailInputController.text));
                },
                child: Text('Create host'))
          ],
        ),
      ),
    );
  }
}
