import 'package:chat_app/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        AppImages.frame,
        fit: BoxFit.fill,
      ),
    );
  }
}





    /*
    Column(
      children: [
        SizedBox(
          height: 140,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                  )),
                  child: Image.asset(
                    AppImages.frame,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                // TODO : Change This Container With Image
                width: 150,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: 
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

    */