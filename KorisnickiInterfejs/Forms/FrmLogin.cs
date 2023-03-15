using KorisnickiInterfejs.GUIController;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace KorisnickiInterfejs.Forms
{
    public partial class FrmLogin : Form
    {
        private LoginController controller;
        public FrmLogin()
        {
            InitializeComponent();
            controller = new LoginController();
            controller.InitData(this);

        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            controller.Login();
        }
    }
}
