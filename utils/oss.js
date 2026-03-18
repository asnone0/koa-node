import OSS from "ali-oss";
import path from "path";
import { v4 as uuidv4 } from "uuid";

let client = null;

export function getOSSClient() {
  if (client) return client;

  client = new OSS({
    accessKeyId: process.env.OSS_ACCESS_KEY_ID,
    accessKeySecret: process.env.OSS_ACCESS_KEY_SECRET,
    bucket: process.env.OSS_BUCKET,
    region: process.env.OSS_REGION,
    endpoint: process.env.OSS_ENDPOINT,
  });

  return client;
}

export async function uploadToOSS(file) {
  const client = getOSSClient();

  const ext = path.extname(file.originalname);
  const fileName = `${uuidv4()}${ext}`;
  const ossPath = `upload/${fileName}`;

  const result = await client.put(ossPath, file.buffer, {
    mime: file.mimetype,
  });

  return {
    fileName: file.originalname,
    filePath: result.url,
    fileSize: file.size,
    fileType: file.mimetype,
  };
}

export async function uploadToOSSBuffer(buffer, fileName, mimetype) {
  const client = getOSSClient();

  const ext = path.extname(fileName);
  const newFileName = `${uuidv4()}${ext}`;
  const ossPath = `upload/${newFileName}`;

  const result = await client.put(ossPath, buffer, {
    mime: mimetype,
  });

  return result.url;
}
