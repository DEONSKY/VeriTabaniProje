namespace VT_DB_First_Framework
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.CrudBox = new System.Windows.Forms.GroupBox();
            this.register = new System.Windows.Forms.Button();
            this.delete = new System.Windows.Forms.Button();
            this.update = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.radioUser = new System.Windows.Forms.RadioButton();
            this.radioBusinessOwner = new System.Windows.Forms.RadioButton();
            this.login = new System.Windows.Forms.Button();
            this.textInputSecurityPassword = new System.Windows.Forms.TextBox();
            this.textInputBusinessName = new System.Windows.Forms.TextBox();
            this.textInputPassword = new System.Windows.Forms.TextBox();
            this.textInputEmail = new System.Windows.Forms.TextBox();
            this.textInputUsername = new System.Windows.Forms.TextBox();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.errorLabel = new System.Windows.Forms.Label();
            this.permaDelete = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.CrudBox.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(323, 43);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(821, 352);
            this.dataGridView1.TabIndex = 0;
            // 
            // CrudBox
            // 
            this.CrudBox.Controls.Add(this.permaDelete);
            this.CrudBox.Controls.Add(this.register);
            this.CrudBox.Controls.Add(this.delete);
            this.CrudBox.Controls.Add(this.update);
            this.CrudBox.Controls.Add(this.label5);
            this.CrudBox.Controls.Add(this.label4);
            this.CrudBox.Controls.Add(this.label3);
            this.CrudBox.Controls.Add(this.label2);
            this.CrudBox.Controls.Add(this.label1);
            this.CrudBox.Controls.Add(this.radioUser);
            this.CrudBox.Controls.Add(this.radioBusinessOwner);
            this.CrudBox.Controls.Add(this.login);
            this.CrudBox.Controls.Add(this.textInputSecurityPassword);
            this.CrudBox.Controls.Add(this.textInputBusinessName);
            this.CrudBox.Controls.Add(this.textInputPassword);
            this.CrudBox.Controls.Add(this.textInputEmail);
            this.CrudBox.Controls.Add(this.textInputUsername);
            this.CrudBox.Location = new System.Drawing.Point(56, 32);
            this.CrudBox.Name = "CrudBox";
            this.CrudBox.Size = new System.Drawing.Size(247, 458);
            this.CrudBox.TabIndex = 1;
            this.CrudBox.TabStop = false;
            this.CrudBox.Text = "Login";
            // 
            // register
            // 
            this.register.Location = new System.Drawing.Point(128, 327);
            this.register.Name = "register";
            this.register.Size = new System.Drawing.Size(75, 23);
            this.register.TabIndex = 15;
            this.register.Text = "Register";
            this.register.UseVisualStyleBackColor = true;
            this.register.Click += new System.EventHandler(this.register_Click);
            // 
            // delete
            // 
            this.delete.Location = new System.Drawing.Point(128, 369);
            this.delete.Name = "delete";
            this.delete.Size = new System.Drawing.Size(75, 23);
            this.delete.TabIndex = 14;
            this.delete.Text = "Delete";
            this.delete.UseVisualStyleBackColor = true;
            this.delete.Click += new System.EventHandler(this.delete_Click);
            // 
            // update
            // 
            this.update.Location = new System.Drawing.Point(25, 369);
            this.update.Name = "update";
            this.update.Size = new System.Drawing.Size(75, 23);
            this.update.TabIndex = 13;
            this.update.Text = "Update";
            this.update.UseVisualStyleBackColor = true;
            this.update.Click += new System.EventHandler(this.update_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(51, 272);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(94, 13);
            this.label5.TabIndex = 12;
            this.label5.Text = "Security Password";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(51, 230);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(80, 13);
            this.label4.TabIndex = 11;
            this.label4.Text = "Bussines Name";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(51, 187);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(53, 13);
            this.label3.TabIndex = 10;
            this.label3.Text = "Password";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(51, 148);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(32, 13);
            this.label2.TabIndex = 9;
            this.label2.Text = "Email";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(51, 100);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(55, 13);
            this.label1.TabIndex = 8;
            this.label1.Text = "Username";
            // 
            // radioUser
            // 
            this.radioUser.AutoSize = true;
            this.radioUser.Location = new System.Drawing.Point(38, 63);
            this.radioUser.Name = "radioUser";
            this.radioUser.Size = new System.Drawing.Size(62, 17);
            this.radioUser.TabIndex = 7;
            this.radioUser.TabStop = true;
            this.radioUser.Text = "As User";
            this.radioUser.UseVisualStyleBackColor = true;
            // 
            // radioBusinessOwner
            // 
            this.radioBusinessOwner.AutoSize = true;
            this.radioBusinessOwner.Location = new System.Drawing.Point(38, 40);
            this.radioBusinessOwner.Name = "radioBusinessOwner";
            this.radioBusinessOwner.Size = new System.Drawing.Size(116, 17);
            this.radioBusinessOwner.TabIndex = 6;
            this.radioBusinessOwner.TabStop = true;
            this.radioBusinessOwner.Text = "As Business Owner";
            this.radioBusinessOwner.UseVisualStyleBackColor = true;
            // 
            // login
            // 
            this.login.Location = new System.Drawing.Point(25, 327);
            this.login.Name = "login";
            this.login.Size = new System.Drawing.Size(75, 23);
            this.login.TabIndex = 5;
            this.login.Text = "Login";
            this.login.UseVisualStyleBackColor = true;
            this.login.Click += new System.EventHandler(this.login_Click);
            // 
            // textInputSecurityPassword
            // 
            this.textInputSecurityPassword.Location = new System.Drawing.Point(38, 288);
            this.textInputSecurityPassword.Name = "textInputSecurityPassword";
            this.textInputSecurityPassword.Size = new System.Drawing.Size(153, 20);
            this.textInputSecurityPassword.TabIndex = 4;
            // 
            // textInputBusinessName
            // 
            this.textInputBusinessName.Location = new System.Drawing.Point(38, 250);
            this.textInputBusinessName.Name = "textInputBusinessName";
            this.textInputBusinessName.Size = new System.Drawing.Size(153, 20);
            this.textInputBusinessName.TabIndex = 3;
            // 
            // textInputPassword
            // 
            this.textInputPassword.Location = new System.Drawing.Point(38, 207);
            this.textInputPassword.Name = "textInputPassword";
            this.textInputPassword.Size = new System.Drawing.Size(153, 20);
            this.textInputPassword.TabIndex = 2;
            // 
            // textInputEmail
            // 
            this.textInputEmail.Location = new System.Drawing.Point(38, 164);
            this.textInputEmail.Name = "textInputEmail";
            this.textInputEmail.Size = new System.Drawing.Size(153, 20);
            this.textInputEmail.TabIndex = 1;
            // 
            // textInputUsername
            // 
            this.textInputUsername.Location = new System.Drawing.Point(38, 122);
            this.textInputUsername.Name = "textInputUsername";
            this.textInputUsername.Size = new System.Drawing.Size(153, 20);
            this.textInputUsername.TabIndex = 0;
            // 
            // dataGridView2
            // 
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Location = new System.Drawing.Point(888, 531);
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.Size = new System.Drawing.Size(256, 75);
            this.dataGridView2.TabIndex = 2;
            // 
            // errorLabel
            // 
            this.errorLabel.AutoSize = true;
            this.errorLabel.Location = new System.Drawing.Point(606, 9);
            this.errorLabel.Name = "errorLabel";
            this.errorLabel.Size = new System.Drawing.Size(55, 13);
            this.errorLabel.TabIndex = 16;
            this.errorLabel.Text = "ErrorLabel";
            // 
            // permaDelete
            // 
            this.permaDelete.BackColor = System.Drawing.Color.Firebrick;
            this.permaDelete.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.permaDelete.Location = new System.Drawing.Point(70, 413);
            this.permaDelete.Name = "permaDelete";
            this.permaDelete.Size = new System.Drawing.Size(75, 39);
            this.permaDelete.TabIndex = 16;
            this.permaDelete.Text = "Perma Delete";
            this.permaDelete.UseVisualStyleBackColor = false;
            this.permaDelete.Click += new System.EventHandler(this.permaDelete_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1156, 618);
            this.Controls.Add(this.errorLabel);
            this.Controls.Add(this.dataGridView2);
            this.Controls.Add(this.CrudBox);
            this.Controls.Add(this.dataGridView1);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.CrudBox.ResumeLayout(false);
            this.CrudBox.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.GroupBox CrudBox;
        private System.Windows.Forms.TextBox textInputBusinessName;
        private System.Windows.Forms.TextBox textInputPassword;
        private System.Windows.Forms.TextBox textInputEmail;
        private System.Windows.Forms.TextBox textInputUsername;
        private System.Windows.Forms.RadioButton radioUser;
        private System.Windows.Forms.RadioButton radioBusinessOwner;
        private System.Windows.Forms.Button login;
        private System.Windows.Forms.TextBox textInputSecurityPassword;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button update;
        private System.Windows.Forms.DataGridView dataGridView2;
        private System.Windows.Forms.Button delete;
        private System.Windows.Forms.Button register;
        private System.Windows.Forms.Label errorLabel;
        private System.Windows.Forms.Button permaDelete;
    }
}

