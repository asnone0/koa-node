import winston from "winston";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/** 日志配置 */
const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || "info",
  format: winston.format.combine(
    winston.format.timestamp({ format: "YYYY-MM-DD HH:mm:ss" }),
    winston.format.errors({ stack: true }),
    winston.format.printf(({ level, message, timestamp, stack }) => {
      return `${timestamp} [${level.toUpperCase()}] ${message}${stack ? "\n" + stack : ""}`;
    }),
  ),
  transports: [
    // 控制台输出
    new winston.transports.Console(),
    // 文件输出 - 所有日志
    new winston.transports.File({
      filename: path.join(__dirname, "../logs/all.log"),
      maxsize: 5242880, // 5MB
      maxFiles: 5,
    }),
    // 文件输出 - 错误日志
    new winston.transports.File({
      filename: path.join(__dirname, "../logs/error.log"),
      level: "error",
      maxsize: 5242880,
      maxFiles: 5,
    }),
  ],
});

export default logger;
