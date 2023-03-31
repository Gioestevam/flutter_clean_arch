import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CustomTextFieldOutlined extends StatelessWidget {
  CustomTextFieldOutlined({
    required this.label,
    required this.behaviorSubject,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.validation,
  });

  final String label;
  final bool isObscureText;
  final TextInputAction textInputAction;
  final Function? validation;
  final BehaviorSubject behaviorSubject;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: behaviorSubject.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        return TextFormField(
          onChanged: behaviorSubject.sink.add,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontSize: 15
            ),
            labelText: label,
            errorText: snapshot.hasError 
              ? snapshot.error.toString() 
              : null,
            errorStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: snapshot.hasError ? Color.fromRGBO(232, 0, 0, 1) : Theme.of(context).textTheme.labelMedium?.color
            )
          ),    
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: Colors.white,
            fontSize: 18
          ),  
          obscureText: isObscureText,
          validator: validation != null 
            ? (value) => validation!(value)
            : null,
        );
      }
    );
  }
}
