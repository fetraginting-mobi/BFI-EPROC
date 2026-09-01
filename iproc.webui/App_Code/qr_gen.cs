using System;
using System.Collections.Generic;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.IO; 

using MessagingToolkit.QRCode.Codec;
using MessagingToolkit.QRCode.Codec.Ecc;
using MessagingToolkit.QRCode.Codec.Data;
using MessagingToolkit.QRCode.Codec.Util;

using iProc.DataAccessLayer;

public class qr_gen : System.Web.UI.Page
{
    public void QRGen(string input)
    {
        try
        {
            string toenc = input;
            int qrlevel = 2;
            MessagingToolkit.QRCode.Codec.QRCodeEncoder qe = new MessagingToolkit.QRCode.Codec.QRCodeEncoder();
            qe.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;
            qe.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.L;
            qe.QRCodeVersion = qrlevel;

            string folderPath = Server.MapPath(@"..\..\temp\qrcodes\");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fullFilePath = Path.Combine(folderPath, input + ".png");

            using (System.Drawing.Bitmap bm = qe.Encode(toenc))
            {
                bm.Save(fullFilePath, System.Drawing.Imaging.ImageFormat.Png);
            } 
            ConvertPictureToByte(input, input + ".png", folderPath);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public String QRImageSave(String barcodes, int id)
    {
        try
        {
            String Path;
            Path = Server.MapPath(@"..\temp\qrcodes\" + barcodes + DateTime.Now.ToString("yyyyMMddHHmmss") + ".png");
            return "Image Saved Successfully";
        }
        catch (Exception)
        {
            return "Failed to save picture";
        }
    }

    private void ConvertPictureToByte(String barcode, String FileName, String path)
    {
        GeneralDAL dal = null;
        Hashtable parameters = null;

        try
        {
            dal = new GeneralDAL();
            parameters = new Hashtable();

            parameters["p_barcode"] = barcode;
            string targetFile = Path.Combine(path, FileName);

            if (File.Exists(targetFile))
            {
                byte[] buffer = System.IO.File.ReadAllBytes(targetFile);
                parameters["p_barcode_image"] = buffer;
                Shared.ApplyDefaultProp(parameters);
                dal.Insert("FA_ASSET_BARCODE_IMAGE", parameters);
            }
            else
            {
                throw new FileNotFoundException("File QR Code tidak ditemukan di path: " + targetFile);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}