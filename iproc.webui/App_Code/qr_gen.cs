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

using MessagingToolkit.QRCode.Codec;
using MessagingToolkit.QRCode.Codec.Ecc;
using MessagingToolkit.QRCode.Codec.Data;
using MessagingToolkit.QRCode.Codec.Util;

using iProc.DataAccessLayer;

public class qr_gen : System.Web.UI.Page
{
    public void QRGen(string input)
    {
        //qrlev(input.Length);
        try
        {
            string toenc = input;
            int qrlevel = 2;
            MessagingToolkit.QRCode.Codec.QRCodeEncoder qe = new MessagingToolkit.QRCode.Codec.QRCodeEncoder();
            qe.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;
            qe.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.L;
            // Level 12 L - max 367 alphanumerics
            qe.QRCodeVersion = qrlevel;
            System.Drawing.Bitmap bm = qe.Encode(toenc);

            String Path = Server.MapPath(@"..\..\temp\qrcodes\");
            //Path = "C:\\" + input + ".png";
            bm.Save(Path + input + ".png");

            ConvertPictureToByte(input, input + ".png", Path);
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
            String Path; ;
            Path = Server.MapPath(@"..\temp\qrcodes\" + barcodes + DateTime.Now.ToString("yyyyMMddHHmmss") + ".png");
            //qr_pic.Image.Save( + @"\Code_" + DateTime.Now.ToString("d_MM_yy_HH_mm_ss") + ".png");

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
            byte[] buffer = System.IO.File.ReadAllBytes(path + "/" + FileName);
            parameters["p_barcode_image"] = buffer;
            Shared.ApplyDefaultProp(parameters);
            dal.Insert("FA_ASSET_BARCODE_IMAGE", parameters);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
