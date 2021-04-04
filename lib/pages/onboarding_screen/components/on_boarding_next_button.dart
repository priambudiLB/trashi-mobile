part of 'on_boarding_body.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (contex, state) {
          return InkWell(
            onTap: () =>
                context
                    .read<OnBoardingBloc>()
                    .add(OnBoardingNavigateToHome()),
            child: Container(
              width: 286,
              height: 44,
              child: Center(
                  child: Text(
                "Get Started",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              )),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(100)),
            ),
          );
        });
  }
}
