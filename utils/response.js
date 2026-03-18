class turnClass {
  code = 0;
  message = "success";
  data = {} || null;
  constructor(code, message, data = null) {
    this.code = code;
    this.message = message;
    this.data = data;
  }
}

export function success(ctx, data = null, message = "操作成功", code = 0) {
  ctx.body = new turnClass(code, message, data);
}

export function error(ctx, message = "操作失败", code = -1) {
  ctx.body = new turnClass(code, message);
}
