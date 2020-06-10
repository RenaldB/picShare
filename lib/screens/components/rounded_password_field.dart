import 'package:flutter/material.dart';
import 'package:picshare/screens/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  bool visibility = true;
  RoundedPasswordField({
    Key key,
    this.onChanged, String hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: visibility,
        onChanged: onChanged,
        validator: (value) {
          if (value.isEmpty || value.length < 5) {
            return 'Le mot de passe doit contenir au moins 6 caractères';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Mot de passe",
          icon: Icon(
            Icons.lock,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              visibility= !visibility;
                        print('Visibi : ' + visibility.toString());
                      }, 
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}