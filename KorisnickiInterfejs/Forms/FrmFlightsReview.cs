using KorisnickiInterfejs.GUIController;
using System;
using System.Diagnostics;
using System.Windows.Forms;

namespace KorisnickiInterfejs.Forms
{
    public partial class FrmFlightsReview : Form
    {
        private FlightsReviewController controller;

        public FrmFlightsReview()
        {
            InitializeComponent();
            controller = new FlightsReviewController();
            controller.InitData(this);
        }

        private void btnFlightSearch_Click(object sender, System.EventArgs e)
        {
            controller.GetFlights();
        }

        private void dgvLogBook_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            controller.SelectFlight(e);
            
        }

        private void dpFlightTimeStart_ValueChanged(object sender, System.EventArgs e)
        {
            controller.FlightChanged();
        }

        private void dpFlightTimeStop_ValueChanged(object sender, System.EventArgs e)
        {
            controller.FlightChanged();
        }

        private void btnUpdate_Click(object sender, System.EventArgs e)
        {
            controller.UpdateFlight();
            controller.ClearComponent();
        }

        private void btnCancel_Click(object sender, System.EventArgs e)
        {
            controller.ClearComponent();
        }
    }
}
