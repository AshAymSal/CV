import 'package:business/widget/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PagesDetailsAboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(20),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            CustomText(
              alignment: Alignment.topRight,
              fontSize: 24,
              text: 'وصف الصفحة',
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              alignment: Alignment.topRight,
              fontSize: 18,
              height: 1.5,
              color: Colors.grey,
              text:
                  'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.',
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              alignment: Alignment.topRight,
              fontSize: 24,
              text: 'قوانين الصفحة',
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              alignment: Alignment.topRight,
              fontSize: 18,
              height: 1.5,
              color: Colors.grey,
              text:
                  'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.',
            ),
          ],
        ),
      ),
    );
  }
}
