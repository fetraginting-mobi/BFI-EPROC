using System;

namespace iProc.DataAccessLayer.Utility
{
    public class Shared
    {
        public static string ConnectionString
        {
            get { return System.Configuration.ConfigurationSettings.AppSettings["ConnectionString"]; }
        }

        public static string RPTDBServer
        {
            get { return System.Configuration.ConfigurationSettings.AppSettings["RPTDBServer"]; }
        }

        public static string RPTDBName
        {
            get { return System.Configuration.ConfigurationSettings.AppSettings["RPTDBName"]; }
        }


        public static string RPTDBUID
        {
            get { return System.Configuration.ConfigurationSettings.AppSettings["RPTDBUID"]; }
        }

        public static string RPTDBPassword
        {
            get { return System.Configuration.ConfigurationSettings.AppSettings["RPTDBPassword"]; }
        }
    }
}
