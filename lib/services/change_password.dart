import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Classe reponsável pela alteração de senha do usuário
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _passController = TextEditingController();
  final _newPassController = TextEditingController();
  final _newPass2Controller = TextEditingController();
  final _formKeyPass = GlobalKey<FormState>();
  final _formKeyNewPass = GlobalKey<FormState>();
  final _formKeyNewPass2 = GlobalKey<FormState>();
  bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black38,
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Image.asset('assets/imagens/password.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Redefinição de Senha do Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKeyPass,
              child: TextFormField(
                controller: _passController,
                keyboardType: TextInputType.text,
                validator: (text) {
                  if (text!.isEmpty || text.length < 6) {
                    return 'Senha inválida';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Senha atual',
                    border: const OutlineInputBorder(),
                    labelStyle: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                          _showPass == false
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue),
                      onTap: () {
                        setState(() {
                          _showPass = !_showPass;
                        });
                      },
                    )),
                style: const TextStyle(fontSize: 20),
                obscureText: _showPass == false ? true : false,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKeyNewPass,
              child: TextFormField(
                controller: _newPassController,
                keyboardType: TextInputType.text,
                validator: (text) {
                  if (text!.isEmpty || text.length < 6) {
                    return 'Senha inválida';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Nova senha',
                  border: const OutlineInputBorder(),
                  labelStyle: const TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  suffixIcon: GestureDetector(
                    child: Icon(
                        _showPass == false
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blue),
                    onTap: () {
                      setState(() {
                        _showPass = !_showPass;
                      });
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 20),
                obscureText: _showPass == false ? true : false,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKeyNewPass2,
              child: TextFormField(
                controller: _newPass2Controller,
                keyboardType: TextInputType.text,
                validator: (text) {
                  if ((text!.isEmpty || text.length < 6) ||
                      _newPassController.text != _newPass2Controller.text) {
                    return 'As senhas não coincidem';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Repita a nova senha',
                    border: const OutlineInputBorder(),
                    labelStyle: const TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    suffixIcon: GestureDetector(
                      child: Icon(
                          _showPass == false
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.blue),
                      onTap: () {
                        setState(() {
                          _showPass = !_showPass;
                        });
                      },
                    )),
                style: const TextStyle(fontSize: 20),
                obscureText: _showPass == false ? true : false,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [Colors.red, Colors.blue],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: SizedBox.expand(
                child: TextButton(
                  child: const Text(
                    'Atualizar Senha',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    if (_formKeyPass.currentState!.validate() &&
                        _formKeyNewPass.currentState!.validate() &&
                        _formKeyNewPass2.currentState!.validate()) {
                      changePassword();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  changePassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email.toString(), password: _passController.text);
    user.reauthenticateWithCredential(credential).then((value) {
      user.updatePassword(_newPassController.text).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Senha atualizada com sucesso!')));
      }).catchError((e) => e.toString());
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha atual não confere!')));
    });
  }
}
