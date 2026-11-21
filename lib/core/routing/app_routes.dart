enum AppRoutes {
  home('/', 'home'),
  notifications('/notifications', 'notifications'),
  cart('/cart', 'cart'),
  splash('/splash', 'splash'),
  login('/login', 'login'),
  otp('/otp', 'otp'),
  forgotPassword('/forgot-password', 'forgotPassword'),
  locationPermission('/permissions/location', 'locationPermission'),
  cameraPermission('/permissions/camera', 'cameraPermission'),
  orders('/orders', 'orders'),
  profile('/profile', 'profile'),
  personalInfo('/personal-info', 'personalInfo'),
  language('/language', 'language'),
  theme('/theme', 'theme');

  AppRoutes(this.path, this.name);
  final String path;
  final String name;
}
