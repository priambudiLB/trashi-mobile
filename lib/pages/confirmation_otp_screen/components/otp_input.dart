part of 'confirmation_otp_body.dart';

class OTPInput extends StatefulWidget {
  @override
  _OTPInputState createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  FocusNode pin1FocusNode;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  TextEditingController controller1;
  TextEditingController controller2;
  TextEditingController controller3;
  TextEditingController controller4;
  TextEditingController controller5;

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
    controller5 = TextEditingController();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();

    pin1FocusNode.addListener(() {
      if (pin1FocusNode.hasFocus) {
        context.read<OTP>().setOtp1("");
        controller1.clear();
      }
    });

    pin2FocusNode.addListener(() {
      if (pin2FocusNode.hasFocus) {
        context.read<OTP>().setOtp2("");
        controller2.clear();
      }
    });

    pin3FocusNode.addListener(() {
      if (pin3FocusNode.hasFocus) {
        context.read<OTP>().setOtp3("");
        controller3.clear();
      }
    });

    pin4FocusNode.addListener(() {
      if (pin4FocusNode.hasFocus) {
        context.read<OTP>().setOtp4("");
        controller4.clear();
      }
    });

    pin5FocusNode.addListener(() {
      if (pin5FocusNode.hasFocus) {
        context.read<OTP>().setOtp5("");
        controller5.clear();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: hexToColor("#909090")),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool has5OTPDigits = context.watch<RegistrationProvider>().has5OTPDigits;
    print(has5OTPDigits);

    return Padding(
      padding: EdgeInsets.only(right: 48, left: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: TextFormField(
              focusNode: pin1FocusNode,
              controller: controller1,
              autofocus: true,
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                context.read<OTP>().setOtp1(value);
                nextField(value, pin2FocusNode);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: outlineInputBorder(),
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: TextFormField(
              focusNode: pin2FocusNode,
              controller: controller2,
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                context.read<OTP>().setOtp2(value);
                nextField(value, pin3FocusNode);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: outlineInputBorder(),
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: TextFormField(
              focusNode: pin3FocusNode,
              controller: controller3,
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                context.read<OTP>().setOtp3(value);
                nextField(value, pin4FocusNode);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: outlineInputBorder(),
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            width: 48,
            height: 48,
            child: TextFormField(
              focusNode: pin4FocusNode,
              controller: controller4,
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                context.read<OTP>().setOtp4(value);
                if (has5OTPDigits) {
                  nextField(value, pin5FocusNode);
                } else {
                  if (value.length == 1) {
                    pin4FocusNode.unfocus();
                    // Then you need to check is the code is correct or not
                  }
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: outlineInputBorder(),
                focusedBorder: outlineInputBorder(),
                enabledBorder: outlineInputBorder(),
              ),
            ),
          ),
          if (has5OTPDigits)
            SizedBox(
              width: 48,
              height: 48,
              child: TextFormField(
                focusNode: pin5FocusNode,
                controller: controller5,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  context.read<OTP>().setOtp5(value);
                  if (value.length == 1) {
                    pin5FocusNode.unfocus();
                    // Then you need to check is the code is correct or not
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: outlineInputBorder(),
                  focusedBorder: outlineInputBorder(),
                  enabledBorder: outlineInputBorder(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
