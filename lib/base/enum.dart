enum ImageType { network, assets, localFile }

enum LineType { vertical, horizontal }

///页面的模式
enum LoginMode {
  ///登录账户
  login,

  ///注册账户
  register,
}

enum LoaderState { noAction, loading, succeed, failed, noData }

enum RefreshType { normal, loadMore, refresh }

enum Rotation { lr, rl, tb, bt, tl2br, bl2tr, tr2bl, br2tl }

enum Direction { left, right, up, down }

enum ButtonShape {
  normal,
  // 圆角
  fillet,
  // 方角
  squareCorner,
  // 圆形
  circle,
  // 边框
  outline
}
