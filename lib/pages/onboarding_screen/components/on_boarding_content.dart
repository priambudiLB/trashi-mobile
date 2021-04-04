part of 'on_boarding_body.dart';

class OnBoardingContent extends StatelessWidget {
  final List<Map<String, String>> splashData = [
    {
      "title": "Berita Terkini",
      "description": "Aplikasi trasHI lalalalalla lorem ipsum lalala",
      "image": "assets/images/discover.svg",
    },
    {
      "title": "Transaksi Sampah",
      "description": "Aplikasi trasHI lalalalalla lorem ipsum lalala",
      "image": "assets/images/garbage.svg",
    },
    {
      "title": "Lalala",
      "description": "Aplikasi trasHI lalalalalla lorem ipsum lalala",
      "image": "assets/images/world.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return GestureDetector(
            child: Column(
              children: [
                Container(
                    height: size.height * 0.5,
                    width: double.infinity,
                    child: Center(
                        child: SvgPicture.asset(
                        splashData[state.index]["image"],
                        semanticsLabel: splashData[state.index]["title"],
                      )
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                ),
                Text(splashData[state.index]["title"],
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.white)),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                Text(
                  splashData[state.index]["description"],
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            onHorizontalDragEnd: (DragEndDetails details) {
              if (details.primaryVelocity > 0) {
                // User swiped Left
                context.read<OnBoardingBloc>().add(OnBoardingIndexDecrease());
              } else if (details.primaryVelocity < 0) {
                // User swiped Right
                context.read<OnBoardingBloc>().add(OnBoardingIndexIncrease());
              }
            });
      },
    );
  }
}
