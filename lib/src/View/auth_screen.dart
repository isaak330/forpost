import 'package:flutter/material.dart';
import 'package:forpost/src/Repos/auth_repo.dart';
import 'package:forpost/src/Repos/memory.dart';
import 'package:forpost/src/View/camera_list_screen.dart';
import 'package:forpost/src/View/camera_screen.dart';

class AuthCreen extends StatefulWidget {
  const AuthCreen({super.key});

  @override
  State<AuthCreen> createState() => _AuthCreenState();
}

class _AuthCreenState extends State<AuthCreen> {
  late TextEditingController _login;
  late TextEditingController _password;
  late bool _authState;
  late String auth;
  @override
  void initState() {
    _authState = true;
    _login = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _login.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: TextFormField(
                controller: _login,
                decoration: InputDecoration(
                  labelText: 'Логин',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                        color:
                            _authState ? const Color(0xFFE1E3E6) : Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                        color: _authState ? Colors.deepPurple : Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              child: TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                        color:_authState ? const Color(0xFFE1E3E6) : Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(
                        color: _authState ? Colors.deepPurple : Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              _authState ? '' : 'Не верный логин и/или пароль',
              style: const TextStyle(
                  color: Colors.red, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () async {
                auth = await AuthRepo.auth(_login.text, _password.text);
                if (auth == 'error') {
                  setState(() {
                    _authState = false;
                  });
                } else {
                  Route route = MaterialPageRoute(
                      builder: (context) => const CameraListScreen());
                  Navigator.pushAndRemoveUntil(
                      context, route, (route) => false);
                }
              },
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: const Text(
                  'Войти',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
