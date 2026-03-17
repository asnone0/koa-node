/**
 * 接受参数
 * post 请求
 * @param {*} ctx
 */
export function receiveValuePost(ctx) {
  const data = {
    ...ctx.request.body,
  };
  return {
    data,
  };
}

/**
 * 接受参数
 * get 请求
 * @param {*} ctx
 */

export function receiveValueGet(ctx) {
  const data = {
    ...ctx.query,
  };
  return {
    data,
  };
}
