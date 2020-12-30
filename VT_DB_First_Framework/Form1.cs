using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VT_DB_First_Framework
{
    public partial class Form1 : Form
    {
        int id;
        NpgsqlConnection connection = new NpgsqlConnection("Server=localhost; Port=5432; Database=odev_2; User Id=postgres; Password=running-away-222;");
        DataSet dataSet = new DataSet();
        public Form1()
        {
            InitializeComponent();
            DataDoldur();
        }
        public void DataDoldur()
        {
            

            try
            {
                connection.Open();
            }
            catch (Exception ex)
            {
                throw;
            }

            string sql = "SELECT * FROM app_shema.\"users\"";

            NpgsqlDataAdapter add = new NpgsqlDataAdapter(sql, connection);
            add.Fill(dataSet);

            dataGridView1.DataSource = dataSet.Tables[0];
            getTwoRelationalTable("users", "business_owner", "user_id", "business_owner_id");
            connection.Close();
        }

        private void login_Click(object sender, EventArgs e)
        {
            DataSet dataSet = new DataSet();
            string sql = "SELECT * FROM app_shema.users WHERE username='" + textInputUsername.Text + "' AND password='" + textInputPassword.Text + "' AND is_account_active = true;";
            NpgsqlDataAdapter add = new NpgsqlDataAdapter(sql, connection);
            try
            {
                add.Fill(dataSet);
                id = Convert.ToInt32(dataSet.Tables[0].Rows[0]["user_id"]);
                errorLabel.Text = "Succesfull";
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
            }
        }

        public void getAllTable(string table)
        {
            string sql1 = "SELECT * FROM app_shema."+table+"";
            DataSet dataSet = new DataSet();
            NpgsqlDataAdapter add1 = new NpgsqlDataAdapter(sql1, connection);
            add1.Fill(dataSet);
            dataGridView1.DataSource = dataSet.Tables[0];
        }
        public void getTwoRelationalTable(string table1,string table2,string innerCol,string innerCol2)
        {
            string sql = "SELECT* FROM app_shema." + table1 + " FULL OUTER JOIN app_shema." + table2+" ON "+table1+"."+innerCol+" = "+table2+"."+innerCol2;
            DataSet dataSet = new DataSet();
            NpgsqlDataAdapter add1 = new NpgsqlDataAdapter(sql, connection);
            add1.Fill(dataSet);
            dataGridView1.DataSource = dataSet.Tables[0];
        }


        private void update_Click(object sender, EventArgs e)
        {
            DataSet dataSet = new DataSet();
            string sql = "update app_shema.users set \"password\" = ";
            sql += "'" + textInputPassword.Text +"'";
            sql += "where user_id = " + id + ";";
            NpgsqlDataAdapter add = new NpgsqlDataAdapter(sql, connection);
            try
            {
                add.Fill(dataSet);
                //getAllTable("business_owner");
                getTwoRelationalTable("users", "business_owner", "user_id", "business_owner_id");
                errorLabel.Text = "Succesfull";
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
            }

            /*
            DataSet dataSet = new DataSet();
            string requestRoot = "select app_shema.change_bo_password(";
            requestRoot += "'" + textInputSecurityPassword.Text + "',";
            requestRoot += id + ");";
            NpgsqlDataAdapter add = new NpgsqlDataAdapter(requestRoot, connection);
            try
            {
                add.Fill(dataSet);
                dataGridView2.DataSource = dataSet.Tables[0];
                //getAllTable("business_owner");
                getTwoRelationalTable("users", "business_owner", "user_id", "business_owner_id");
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
            }
            */


        }

        private void delete_Click(object sender, EventArgs e)
        {
            string requestRoot = "select app_shema.delete_user(";
            requestRoot += "'" + id + "');";
            NpgsqlDataAdapter add = new NpgsqlDataAdapter(requestRoot, connection);
            try
            {
                add.Fill(dataSet);
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
            }
            getTwoRelationalTable("users", "business_owner", "user_id", "business_owner_id");
        }

        private void register_Click(object sender, EventArgs e)
        {
            if (radioBusinessOwner.Checked)
            {
                string requestRoot = "select app_shema.insert_business_owner(";
                requestRoot += "'" + textInputUsername.Text + "',";
                requestRoot += "'" + textInputEmail.Text + "',";
                requestRoot += "'" + textInputPassword.Text + "',";
                requestRoot += "'" + textInputBusinessName.Text + "',";
                requestRoot += "'" + textInputSecurityPassword.Text + "');";
                NpgsqlDataAdapter add = new NpgsqlDataAdapter(requestRoot, connection);
                try
                {
                    add.Fill(dataSet);
                    getTwoRelationalTable("users", "business_owner", "user_id", "business_owner_id");
                }
                catch (Exception ex)
                {
                    errorLabel.Text =  ex.Message;
                }

            }
            else
            {
                string requestRoot = "select app_shema.insert_user(";
                requestRoot += "'" + textInputUsername.Text + "',";
                requestRoot += "'" + textInputEmail.Text + "',";
                requestRoot += "'" + textInputPassword.Text + "');";
                NpgsqlDataAdapter add = new NpgsqlDataAdapter(requestRoot, connection);
                try
                {
                    add.Fill(dataSet);
                    getTwoRelationalTable("users", "business_owner", "user_id", "business_owner_id");
                }
                catch (Exception ex)
                {
                    errorLabel.Text = ex.Message;
                }

            }

        }

        private void permaDelete_Click(object sender, EventArgs e)
        {
            string requestRoot = "DELETE FROM app_shema.users WHERE user_id = "+id+";";
            NpgsqlDataAdapter add = new NpgsqlDataAdapter(requestRoot, connection);
            try
            {
                add.Fill(dataSet);
            }
            catch (Exception ex)
            {
                errorLabel.Text = ex.Message;
            }
            getTwoRelationalTable("users", "business_owner", "user_id", "business_owner_id");
        }
    
    }
}
