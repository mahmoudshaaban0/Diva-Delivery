enum AppRoutes {
  home('/', 'home'),
  notifications('/notifications', 'notifications'),
  cart('/cart', 'cart'),
  splash('/splash', 'splash'),
  login('/login', 'login'),
  otp('/otp', 'otp');

  AppRoutes(this.path, this.name);
  final String path;
  final String name;
}
