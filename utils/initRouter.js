// 路由类
class routes {
  path = null;
  method = null;
  controller = null;

  constructor(path, method, controller) {
    this.path = path;
    this.method = method;
    this.controller = controller;
  }
}

export default routes;
