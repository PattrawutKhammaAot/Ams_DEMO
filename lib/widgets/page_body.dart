
import 'package:flutter/material.dart';

class PageBody extends StatelessWidget {
  final  Widget  child;
  final GlobalKey keyForm;
  final AutovalidateMode? autoValidateMode;
  const PageBody({Key? key, required this.child, required this.keyForm, this.autoValidateMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final keyForm = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => {FocusScope.of(context).unfocus()},
      child: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Form(
                  key: keyForm,
                  autovalidateMode: autoValidateMode ?? AutovalidateMode.always,
                  child: child
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: widgets,
                  // ),
                ),
              )
          ),
        ],

      ),
    );
  }
}
