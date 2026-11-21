enum AppRoutes {
  home('/', 'home'),
  // Relative: a sub-route of home (keeps the tab bar).
  notifications('notifications', 'notifications'),
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
  theme('/theme', 'theme'),
  orderDetails('/order-details/:id', 'orderDetails');

  AppRoutes(this.path, this.name);
  final String path;
  final String name;
}
