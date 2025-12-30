using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;

using iProc.DataAccessLayer.Utility;

namespace iProc.DataAccessLayer
{
    public class GeneralDAL
    {
        #region Insert
        public void Insert(string TableName, Hashtable parameters, ref int id)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP("xsp_" + TableName + "_insert", parameters, ref id))
            {
                throw new Exception("Fail to execute xsp_" + TableName + "_insert", new Exception(dbw.DBErrorMessage));
            }
        }

        public void Insert(string TableName, Hashtable parameters, ref string id)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP("xsp_" + TableName + "_insert", parameters, ref id))
            {
                throw new Exception("Fail to execute xsp_" + TableName + "_insert", new Exception(dbw.DBErrorMessage));
            }
        }

        public void Insert(string TableName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP("xsp_" + TableName + "_insert", parameters))
            {
                throw new Exception("Fail to execute xsp_" + TableName + "_insert", new Exception(dbw.DBErrorMessage));
            }
        }

        public void Insert(string TableName, string SPName, Hashtable parameters, ref int id)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP(SPName, parameters, ref id))
            {
                throw new Exception("Fail to execute " + SPName, new Exception(dbw.DBErrorMessage));
            }
        }

        public void Insert(string TableName, string SPName, Hashtable parameters, ref string id)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP(SPName, parameters, ref id))
            {
                throw new Exception("Fail to execute " + SPName, new Exception(dbw.DBErrorMessage));
            }
        }

        public void Insert(string TableName, string SPName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP(SPName, parameters))
            {
                throw new Exception("Fail to execute " + SPName, new Exception(dbw.DBErrorMessage));
            }
        }
        #endregion

        #region Update
        public void Update(string TableName, string SPName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP(SPName, parameters))
            {
                throw new Exception("Fail to execute " + SPName, new Exception(dbw.DBErrorMessage));
            }
        }

        public void Update(string TableName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP("xsp_" + TableName + "_update", parameters))
            {

                throw new Exception("Fail to execute xsp_" + TableName + "_update", new Exception(dbw.DBErrorMessage));
            }
        }
        #endregion

        #region Delete
        public void Delete(string TableName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP("xsp_" + TableName + "_delete", parameters))
            {
                throw new Exception("Fail to execute xsp_" + TableName + "_delete", new Exception(dbw.DBErrorMessage));
            }
        }
        #endregion

        #region GetRows
        public DataTable GetRows(string TableName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            DataSet ds = new DataSet();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP("xsp_" + TableName + "_getrows", parameters, ds))
            {
                throw new Exception("Fail to xsp_" + TableName + "_getrows", new Exception(dbw.DBErrorMessage));
            }
            else
            {
                if (ds.Tables.Count <= 0)
                    throw new Exception("Fail to xsp_" + TableName + "_getrows. No row found.");
                else
                    return ds.Tables[0];
            }
        }

        public DataTable GetRows(string TableName, string SPName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            DataSet ds = new DataSet();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP(SPName, parameters, ds))
            {
                throw new Exception("Fail to " + SPName, new Exception(dbw.DBErrorMessage));
            }
            else
            {
                if (ds.Tables.Count <= 0)
                    throw new Exception("Fail to " + SPName + ". No row found.");
                else
                    return ds.Tables[0];
            }
        }
        #endregion

        #region GetRow
        public DataRow GetRow(string TableName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            DataSet ds = new DataSet();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP("xsp_" + TableName + "_getrow", parameters, ds))
            {
                throw new Exception("Fail to execute xsp_" + TableName + "_getrow", new Exception(dbw.DBErrorMessage));
            }
            else
            {
                if (ds.Tables.Count <= 0)
                    throw new Exception("Fail to xsp_" + TableName + "_getrow. No row found.");
                else
                    return ds.Tables[0].Rows[0];
            }
        }

        public DataRow GetRow(string TableName, string SPName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            DataSet ds = new DataSet();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP(SPName, parameters, ds))
            {
                throw new Exception("Fail to execute " + SPName, new Exception(dbw.DBErrorMessage));
            }
            else
            {
                if (ds.Tables.Count <= 0)
                    throw new Exception("Fail to " + SPName + ". No row found.");
                else
                    return ds.Tables[0].Rows[0];
            }
        }
        #endregion

        public void ExecRawSP(string SPName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP(SPName, parameters))
            {
                throw new Exception("Fail to execute " + SPName, new Exception(dbw.DBErrorMessage));
            }
        }

        public void ExecRawSP(string SPName, Hashtable parameters, ref string ReturnValue)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            if (!dbw.ExecuteSP(SPName, parameters, ref ReturnValue))
            {
                throw new Exception("Fail to execute " + SPName, new Exception(dbw.DBErrorMessage));
            }
        }

        public DataTable ExecuteExcelReport(string spReportName, string spResultName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            DataSet ds = new DataSet();

            dbw.ConnectionString = Shared.ConnectionString;

            if (spReportName != null && spResultName != null)
            {
                if (dbw.ExecuteSP(spReportName, parameters))
                {

                    if (!dbw.ExecuteSP(spResultName, parameters, ds))
                    {
                        throw new Exception(spResultName, new Exception(dbw.DBErrorMessage));
                    }
                    else
                    {
                        if (ds.Tables.Count <= 0)
                            throw new Exception("Fail to " + spResultName + ". No row found.");
                        else
                            return ds.Tables[0];
                    }
                }
                else
                {
                    throw new Exception(spReportName);
                }
            }
            else if (spReportName == null)
            {
                if (!dbw.ExecuteSP(spResultName, parameters, ds))
                {
                    throw new Exception(spResultName, new Exception(dbw.DBErrorMessage));
                }
                else
                {
                    if (ds.Tables.Count <= 0)
                        throw new Exception("Fail to " + spResultName + ". No row found.");
                    else
                        return ds.Tables[0];
                }
            }
            else if (spResultName == null)
            {
                if (!dbw.ExecuteSP(spReportName, parameters))
                {
                    throw new Exception(spReportName, new Exception(dbw.DBErrorMessage));
                }
                else
                    return null;
            }
            else return null;
        }


        public int UploadWithReturnInt(string tableName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            int id = 0;

            if (!dbw.ExecuteSP("xsp_" + tableName + "_upload", parameters, ref id))
                throw new Exception(
                    "Fail to execute xsp_" + tableName + "_upload",
                    new Exception(dbw.DBErrorMessage)
                );

            return id; 
        }

        public string UploadWithReturnString(string tableName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;
            string code = "";

            if (!dbw.ExecuteSP("xsp_" + tableName + "_upload", parameters, ref code))
                throw new Exception(
                    "Fail to execute xsp_" + tableName + "_upload",
                    new Exception(dbw.DBErrorMessage)
                );

            return code;
 
        }

        public int ExecSPReturnInt(string spName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;

            int outputValue = 0;

            if (!dbw.ExecuteSP(spName, parameters, ref outputValue))
            {
                throw new Exception(
                    "Fail to execute " + spName,
                    new Exception(dbw.DBErrorMessage)
                );
            }

            return outputValue;
        }

        public void ExecuteNonQuery(string spName, Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;

            if (!dbw.ExecuteSP(spName, parameters))
                throw new Exception(
                    "Fail to execute " + spName,
                    new Exception(dbw.DBErrorMessage)
                );
        }

        public void InsertProcessErrorLog(Hashtable parameters)
        {
            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;

            if (!dbw.ExecuteSP("xsp_app_process_error_log_upload", parameters))
                throw new Exception(dbw.DBErrorMessage);
        }

        public int GetOnhandStock( string itemCode, string locationCode, string branchCode)
        {
            Hashtable ht = new Hashtable();
            ht["p_item_code"] = itemCode;
            ht["p_location_code"] = locationCode;
            ht["p_branch_code"] = branchCode;

            DBWrapper dbw = DBWrapper.GetSqlClientWrapper();
            dbw.ConnectionString = Shared.ConnectionString;

            DataSet ds = new DataSet();

            if (!dbw.ExecuteSP("xsp_inventory_stock_getrow", ht, ds))
                throw new Exception(
                    "Fail to execute xsp_inventory_stock_getrow",
                    new Exception(dbw.DBErrorMessage)
                );

            if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                return 0;

            object val = ds.Tables[0].Rows[0]["ONHAND_QTY"];
            if (val == DBNull.Value)
                return 0;

            return Convert.ToInt32(val);
        }
    }
}
