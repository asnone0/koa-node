// 路由类
class routes {
  path = null;
  method = null;
  controller = null;
  code = null;
  constructor(path, method, controller, code) {
    this.path = path;
    this.method = method;
    this.controller = controller;
    this.code = code;
  }
}

export default routes;
