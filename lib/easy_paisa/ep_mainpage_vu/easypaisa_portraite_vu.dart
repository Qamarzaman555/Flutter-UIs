import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:practice/ui_kit/local_pub.dart';

import '../Models/easypaisa_model.dart';
import 'easypaisa_vm.dart';

class EasyPaisaPortraiteView extends StatelessWidget {
  const EasyPaisaPortraiteView(this.viewModel, {super.key});
  final EasyPaisaViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerContainer(context),
          easypaisaCardList(context, viewModel),
          _headingText('More with easypaisa'),
          4.spaceY,
          _gridPageVIew(context, viewModel),
          16.spaceY,
          _headingText('Get your easypaisa Debit Card'),
          16.spaceY,
          easypaisaDebitCards(context, viewModel),
          16.spaceY,
          _headingText('Promotions'),
          16.spaceY,
        ],
      ),
    );
  }

  Widget headerContainer(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
            Color.fromARGB(255, 39, 149, 74),
            Color.fromRGBO(50, 189, 94, 1),
          ])),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: userDetailsCard(context),
      ),
    );
  }

  Widget userDetailsCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/easypaisa_logo.png",
                  height: MediaQuery.sizeOf(context).height / 28,
                  width: MediaQuery.sizeOf(context).width / 3.6,
                ),
                8.spaceY,
                const Text(
                  "QAMAR ZAMAN",
                ),
                4.spaceY,
                Text(
                  "03159392193",
                  style: CHIStyles.displayXsBoldStyle,
                ),
                // 2.spaceY,
                Text(
                  "Sign in to your easypaisa account",
                  style: CHIStyles.xsNormalStyle,
                ),
              ],
            ),
            _signinBtn()
          ],
        ),
      ),
    );
  }

  Widget _signinBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(100.0, 25.0),
        backgroundColor: const Color.fromARGB(255, 39, 149, 74),
      ),
      onPressed: () {},
      child: Text(
        'Sign In',
        style: CHIStyles.xsNormalStyle.copyWith(color: CHIStyles.whiteColor),
      ),
    );
  }

  Widget easypaisaCardList(BuildContext context, EasyPaisaViewModel viewModel) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 24.0, top: 12, bottom: 12, right: 24),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 9.2,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.easypaisaCards.length,
            itemBuilder: (context, index) {
              return easypaisaCard(viewModel.easypaisaCards[index], context);
            }),
      ),
    );
  }

  Widget easypaisaCard(EasyPaisaCard easyPaisaCard, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: MediaQuery.sizeOf(context).width / 24),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 3.8,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  easyPaisaCard.icon,
                  color: const Color.fromARGB(255, 39, 149, 74),
                ),
                Text(
                  easyPaisaCard.name,
                  style: CHIStyles.xsSemiBoldStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headingText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        text,
        style: CHIStyles.mdBoldStyle,
      ),
    );
  }

  Widget easypaisaGridCell(EasyPaisaCard gridView, BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          gridView.icon,
          color: const Color.fromARGB(255, 39, 149, 74),
        ),
        const SizedBox(height: 12),
        Text(gridView.name,
            style: CHIStyles.xsSemiBoldStyle, textAlign: TextAlign.center),
      ],
    );
  }

  GridView moreGridView(List<EasyPaisaCard> gridView, BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: List.generate(
        gridView.length,
        (index) {
          return easypaisaGridCell(gridView[index], context);
        },
      ),
    );
  }

  Widget _gridPageVIew(BuildContext context, EasyPaisaViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 3.4,
                child: PageView(
                  controller: viewModel.pageController,
                  onPageChanged: (page) {
                    viewModel.selectedPage = page;
                    viewModel.notifyListeners();
                  },
                  children: [
                    moreGridView(viewModel.gridView1, context),
                    moreGridView(viewModel.gridView2, context),
                  ],
                ),
              ),
              _pageIndicator(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageIndicator(EasyPaisaViewModel viewModel) {
    return PageViewDotIndicator(
      currentItem: viewModel.selectedPage,
      count: 2,
      unselectedColor: Colors.black26,
      selectedColor: Colors.green,
      duration: const Duration(milliseconds: 200),
      boxShape: BoxShape.circle,
      size: const Size(8, 8),
      onItemClicked: (index) {
        viewModel.pageController?.animateToPage(
          viewModel.selectedPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
        viewModel.notifyListeners();
      },
    );
  }

  Widget easypaisaDebitCards(
      BuildContext context, EasyPaisaViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 4,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.debitCard.length,
          itemBuilder: (context, index) {
            return _debitCard(viewModel, index, context);
          },
        ),
      ),
    );
  }

  Widget _debitCard(
      EasyPaisaViewModel viewModel, int index, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: viewModel.debitCard[index].color,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.debitCard[index].name,
              style:
                  CHIStyles.mdBoldStyle.copyWith(color: CHIStyles.whiteColor),
              textAlign: TextAlign.center,
            ),
            4.spaceY,
            Expanded(
              child: Text(
                viewModel.debitCard[index].text,
                maxLines: 3,
                style: CHIStyles.xsNormalStyle
                    .copyWith(color: CHIStyles.primaryWarningColor),
              ),
            ),
            _debitCardBtn(viewModel, index, context),
          ],
        ),
      ),
    );
  }

  Widget _debitCardBtn(
      EasyPaisaViewModel viewModel, int index, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(
            side:
                BorderSide(color: Color.fromARGB(255, 41, 129, 44), width: 2)),
        minimumSize: const Size(100.0, 25.0),
        backgroundColor: viewModel.debitCard[index].color,
      ),
      onPressed: () {
        CHIRouter.push(context, viewModel.debitCard[index].toRoute);
      },
      child: Row(
        children: [
          Text(
            'Manage Card',
            style:
                CHIStyles.xsNormalStyle.copyWith(color: CHIStyles.whiteColor),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 18,
          )
        ],
      ),
    );
  }

  Widget moreGridTabs(BuildContext context, EasyPaisaViewModel viewModel) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [],
      ),
    );
  }
}
