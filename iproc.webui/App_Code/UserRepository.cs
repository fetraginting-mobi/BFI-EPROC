using System;
using System.Configuration;
using System.Data.SqlClient;

public class UserRepository
{
    private string ConnStr
    {
        get
        {
            return ConfigurationManager.AppSettings["ConnectionString"];
        }
    }

    public EmployeeUser GetUserByEmailOrNik(string email, string nik)
    {
        using (SqlConnection conn = new SqlConnection(ConnStr))
        {
            conn.Open();

            string sql = @"
                SELECT TOP 1 e.*
                FROM master_user_main m
                JOIN employee_main e
                  ON m.ID = e.EMP_CODE
                WHERE m.IS_ACTIVE = 1
                  AND (e.EMAIL = @EMAIL OR e.NIK = @NIK)";

            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@EMAIL", email);
            cmd.Parameters.AddWithValue("@NIK", nik);

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (dr.Read())
                {
                    EmployeeUser user = new EmployeeUser();
                    user.EmpCode = dr["EMP_CODE"].ToString();
                    user.EmpName = dr["EMP_NAME"].ToString();
                    user.Email = dr["EMAIL"].ToString();
                    user.Nik = dr["NIK"].ToString();
                    return user;
                }
            }
        }
        return null;
    }

    public void UpdateLastLogin(string empCode)
    {
        using (SqlConnection conn = new SqlConnection(ConnStr))
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand(
                "UPDATE master_user_main SET LAST_LOGIN_DATE = GETDATE() WHERE ID = @ID",
                conn);

            cmd.Parameters.AddWithValue("@ID", empCode);
            cmd.ExecuteNonQuery();
        }
    }
}
