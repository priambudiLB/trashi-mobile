part of 'on_boarding_body.dart';

class OnBoardingDots extends StatelessWidget {
  const OnBoardingDots({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (index) => AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      margin: EdgeInsets.only(right: 10, left: 10),
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Colors
                                .white //                   <--- border width here
                            ),
                        color: state.index == index
                            ? hexToColor(MAIN_COLOR)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    )),
          );
        });
  }
}
