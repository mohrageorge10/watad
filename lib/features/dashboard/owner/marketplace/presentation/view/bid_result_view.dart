import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class BidResultView extends StatelessWidget {
  final bool isAccepted;
  final String bidId;

  const BidResultView({
    super.key,
    required this.isAccepted,
    this.bidId = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFD), // Light blueish background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 90.h,
        title: Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back, color: AppColors.primary700),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          children: [
            // Icon
            Container(
              width: 80.r,
              height: 80.r,
              decoration: const BoxDecoration(
                color: Color(0xFFE5E7EB), // Light grey circle background
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isAccepted
                    ? Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: const BoxDecoration(
                          color: AppColors.accept,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: AppColors.white100,
                          size: 24.r,
                        ),
                      )
                    : Text(
                        '✕',
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w900, // Make it very bold
                          color: AppColors.alert,
                          height: 1.0,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              isAccepted ? 'Bid Accepted!' : 'Bid Rejected',
              style: AppTextStyles.font24Bold.copyWith(
                color: AppColors.primary700,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              isAccepted
                  ? 'You have successfully accepted\nBuildPro Construction\'s bid.'
                  : 'You have successfully rejected\nBuildPro Construction\'s bid.',
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Medium.copyWith(
                color: AppColors.smallText,
                height: 1.5,
              ),
            ),
            SizedBox(height: 40.h),
            
            _buildWhatsNextCard(),

            SizedBox(height: 32.h),
            
            // Custom button for "Create Contract" / "Back to Bids"
            GestureDetector(
              onTap: () {
                // Navigate logic
                if (!isAccepted) {
                  context.pop();
                  context.pop();
                } else {
                  context.pushNamed(
                    AppRoutes.createContractForm, 
                    extra: {'bidId': bidId},
                  );
                }
              },
              child: Container(
                width: 342.w,
                height: 52.h,
                decoration: BoxDecoration(
                  color: isAccepted ? AppColors.primary700 : AppColors.white100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: isAccepted ? null : Border.all(color: AppColors.primary700),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        isAccepted ? 'Create Contract' : 'Back to Bids',
                        style: isAccepted
                            ? AppTextStyles.btnWhite600.copyWith(fontWeight: FontWeight.w700)
                            : AppTextStyles.btnWhite600.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary700,
                              ),
                      ),
                    ),
                    if (isAccepted)
                      Positioned(
                        right: 24.w,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: Container(
                            width: 24.r,
                            height: 24.r,
                            decoration: const BoxDecoration(
                              color: AppColors.white100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.arrow_forward, color: AppColors.primary700, size: 16.r),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhatsNextCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isAccepted ? Icons.assignment_outlined : Icons.schedule,
                color: isAccepted ? AppColors.accept : AppColors.alert,
                size: 20.r,
              ),
              SizedBox(width: 8.w),
              Text(
                'What\'s Next?',
                style: AppTextStyles.font14SemiBoldDark.copyWith(
                  color: isAccepted ? AppColors.accept : AppColors.alert,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (isAccepted) ...[
            _buildCheckItem('The project status is now\nUnder Contracting', true),
            SizedBox(height: 16.h),
            _buildCheckItem('The contractor has been notified\nautomatically', true),
            SizedBox(height: 16.h),
            _buildCheckItem('You can view the contract and\ncommunicate in the project chat', true),
          ] else ...[
            _buildCheckItem('The contractor has been notified about\nyour decision', false, icon: Icons.check),
            SizedBox(height: 16.h),
            _buildCheckItem('You can continue reviewing other bids', false, icon: Icons.credit_card),
            SizedBox(height: 16.h),
            _buildCheckItem('You can view this bid in bids history', false, icon: Icons.close),
          ],
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text, bool isAccepted, {IconData? icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Icon(
            isAccepted ? Icons.check : (icon ?? Icons.check),
            color: isAccepted ? AppColors.accept : AppColors.alert,
            size: 16.r,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.font14Medium.copyWith(
              color: AppColors.smallText,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
