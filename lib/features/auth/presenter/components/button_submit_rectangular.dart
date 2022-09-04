import 'package:flutter/material.dart';

class ButtonSubmitRectangular extends StatelessWidget {
  ButtonSubmitRectangular({
    required this.title,
    this.onPress,
    this.isLoading = false
  });

  final String title;
  final bool isLoading;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: onPress,
      child: Container(
        width: size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: !isLoading,
              replacement: Container(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(strokeWidth: 1.5, color: Colors.white),
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            )
          ],
        ),
      ) 
    );
  }

}
