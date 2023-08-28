import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_module/core/core.dart';
import 'package:user_module/src/presentation/shared/circle_avatar_with_error_handler.dart';
import 'package:user_module/src/presentation/shared/unauthenticated_widget.dart';
import 'package:user_module/src/presentation/widgets/responsive_width.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthViewBuilderWrapper(
      onAuthenticated: (user) => _UserProfile(user: user),
      onUnAuthenticated: () => const _UnAuthenticatedUserProfile(),
    );
  }
}

class _UserProfile extends StatelessWidget {
  final AppUser user;
  const _UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ProfileCover(user: user);
  }
}

class _ProfileInfomation extends StatelessWidget {
  final AppUser user;
  const _ProfileInfomation({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: _RowData(
                icon: Icons.phone_rounded,
                data: user.phoneNumber,
              ),
            ),
            kGapW12,
            Flexible(
              child: _RowData(
                icon: Icons.cake_rounded,
                data: user.dob.toDateReadable(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RowData extends StatelessWidget {
  final IconData icon;
  final String data;
  const _RowData({
    required this.icon,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: kTheme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: kTheme.colorScheme.onBackground.withOpacity(.3),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Icon(
            icon,
            color: kTheme.colorScheme.primary,
            size: 16,
          ),
        ),
        kGapW12,
        Text(
          data,
          style: kTheme.textTheme.titleMedium?.copyWith(
            color: kTheme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: kTheme.colorScheme.onBackground,
                blurRadius: 60,
                offset: const Offset(2, 2),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FadeStyleContainer extends StatelessWidget {
  final Widget child;
  const FadeStyleContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: kTheme.colorScheme.primaryContainer.withOpacity(.5),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: child,
    );
  }
}

class _ProfileCover extends StatelessWidget {
  const _ProfileCover({
    required this.user,
  });

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    const double avatarRadius = 48;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: BaseExtendedImageNetwork(
            imageUrl: user.avatar,
          ).image,
          fit: BoxFit.cover,
          opacity: .2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _GenderWrapper(
            gender: user.gender,
            radius: avatarRadius,
            child: CircleAvatarWithErrorHandler(
              radius: avatarRadius,
              avatarUrl: user.avatar,
              fullName: user.fullName,
            ),
          ),
          kGapH12,
          FittedBox(
            child: Text(
              user.fullName,
              style: kTheme.textTheme.headlineLarge?.copyWith(
                color: kTheme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.dancingScript().fontFamily,
                shadows: [
                  Shadow(
                    color: kTheme.colorScheme.onBackground.withOpacity(.5),
                    blurRadius: 40,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
            ),
          ),
          kGapH12,
          FittedBox(
            child: Text(
              user.email,
              style: kTheme.textTheme.titleMedium?.copyWith(
                color: kTheme.colorScheme.primary,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: kTheme.colorScheme.onBackground.withOpacity(.5),
                    blurRadius: 40,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
            ),
          ),
          kGapH12,
          Text(
            user.address,
            textAlign: TextAlign.center,
            style: kTheme.textTheme.titleSmall?.copyWith(
              color: kTheme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: kTheme.colorScheme.onBackground.withOpacity(.5),
                  blurRadius: 40,
                  offset: const Offset(0, 2),
                )
              ],
            ),
          ),
          kGapH12,
          ResponsiveWidthWrapper(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _ProfileInfomation(user: user),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnAuthenticatedUserProfile extends StatelessWidget {
  const _UnAuthenticatedUserProfile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: kTheme.colorScheme.primary.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 48,
            child: Icon(
              Icons.person,
              size: 48,
            ),
          ),
          kGapH12,
          UnauthenticatedWidget(
            message: 'Bạn chưa đăng nhập để xem thông tin cá nhân',
          )
        ],
      ),
    );
  }
}

class _GenderWrapper extends StatelessWidget {
  final Gender gender;
  final double radius;
  final Widget child;
  const _GenderWrapper({
    required this.child,
    required this.radius,
    required this.gender,
  });

  IconData get icon {
    switch (gender) {
      case Gender.male:
        return Icons.male;
      case Gender.female:
        return Icons.female;
      case Gender.other:
        return Icons.transgender_sharp;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double borderWidth = 10;
    return Container(
      clipBehavior: Clip.none,
      height: radius * 2 + borderWidth,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: child,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0 + radius,
            child: CircleAvatar(
              backgroundColor: kTheme.colorScheme.primary,
              child: Icon(
                icon,
                color: kTheme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
