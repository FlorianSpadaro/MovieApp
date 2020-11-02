import 'package:flutter/material.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/shared/app_styles.dart';
import 'package:tmdbapp/ui/widgets/loading_widget.dart';
import 'package:tmdbapp/ui/widgets/rounded_button_widget.dart';

class BottomFormWidget extends StatefulWidget {
  final String title;
  final Form form;
  final String submitLabel;
  final Function onSubmit;
  final Function onBack;
  final Color mainColor;
  final Color secondaryColor;
  final bool isLoading;

  BottomFormWidget(
      {Key key,
      @required this.title,
      @required this.form,
      @required this.submitLabel,
      @required this.onSubmit,
      @required this.onBack,
      @required this.mainColor,
      @required this.secondaryColor,
      @required this.isLoading})
      : super(key: key);

  @override
  _BottomFormWidgetState createState() => _BottomFormWidgetState();
}

class _BottomFormWidgetState extends State<BottomFormWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
    _controller.forward();
    //_controller.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        width: MediaQuery.of(context).size.width,
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.5),
        decoration: BoxDecoration(
            color: widget.mainColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0))),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: widget.secondaryColor,
                      ),
                      onPressed: widget.onBack),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.22),
                    child: Text(
                      widget.title,
                      style: kMainTitleTextStyle.copyWith(
                          color: widget.secondaryColor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: widget.form,
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: widget.isLoading
                    ? LoadingWidget(
                        color:
                            widget.mainColor != kMainColor ? kMainColor : null,
                      )
                    : RoundedButton(
                        onTap: widget.onSubmit,
                        color: widget.secondaryColor,
                        text: widget.submitLabel,
                        textColor: widget.mainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
