import { success } from "../utils/response.js";
import { uploadModal, getUploadList } from "../model/uploadModel.js";
import { upload } from "../middlewar/upload.js";
import { uploadToOSS } from "../utils/oss.js";

export async function uploadFile(ctx) {
  await upload.single("file")(ctx, async () => {
    const file = ctx.req.file;
    if (!ctx.req.file) {
      throw "请选择要上传的文件";
    }

    const ossResult = await uploadToOSS({
      originalname: file.originalname,
      buffer: file.buffer,
      size: file.size,
      mimetype: file.mimetype,
    });

    await uploadModal({
      originalname: file.originalname,
      path: ossResult.filePath,
      size: file.size,
      mimetype: file.mimetype,
    });

    return success(
      ctx,
      {
        fileName: ossResult.fileName,
        filePath: ossResult.filePath,
        fileSize: ossResult.fileSize,
        fileType: ossResult.fileType,
      },
      "上传成功",
    );
  });
}

export async function uploadFiles(ctx) {
  await upload.array("files", 10)(ctx, async () => {
    const files = ctx.req.files;
    if (!files || files.length === 0) {
      ctx.throw(400, "请选择要上传的文件");
    }

    const userId = ctx.state.user?.id || 0;
    const uploadedFiles = [];

    for (const file of files) {
      const ossResult = await uploadToOSS({
        originalname: file.originalname,
        buffer: file.buffer,
        size: file.size,
        mimetype: file.mimetype,
      });

      await uploadModal(
        {
          originalname: file.originalname,
          path: ossResult.filePath,
          size: file.size,
          mimetype: file.mimetype,
        },
        userId,
      );

      uploadedFiles.push({
        fileName: ossResult.fileName,
        filePath: ossResult.filePath,
        fileSize: ossResult.fileSize,
      });
    }

    return success(
      ctx,
      uploadedFiles,
      `成功上传 ${uploadedFiles.length} 个文件`,
    );
  });
}

export async function getFiles(ctx) {
  const { page = 1, pageSize = 10 } = ctx.query;
  const files = await getUploadList(parseInt(page), parseInt(pageSize));
  return success(ctx, files, "获取成功");
}
