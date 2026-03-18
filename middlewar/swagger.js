import swaggerJsdoc from "swagger-jsdoc";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "CMS 的 Node 服务端 API",
      version: "1.0.0",
      description: "接口文档",
    },
    servers: [
      {
        url: `http://localhost:${process.env.PORT || 3000}`,
        description: "开发环境",
      },
    ],
  },
  apis: [path.join(__dirname, "../router/**/*.js")], // 使用绝对路径
};

const swaggerSpec = swaggerJsdoc(options);

export default swaggerSpec;
