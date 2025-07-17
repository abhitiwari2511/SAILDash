<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs"
Inherits="SAILDashboard.Dashboard" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SAIL HR Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap"
      rel="stylesheet"
    />
    <style>
      /* CSS Variables */
      :root {
        --primary: #0056b3;
        --accent: #f1f1f1;
        --bg-light: #f8f9fa;
        --bg-dark: #1e1e2f;
        --text-light: #ffffff;
        --text-dark: #333333;
      }

      /* Base Styles */
      body {
        font-family: "Inter", sans-serif;
        background-color: var(--bg-light);
        color: var(--text-dark);
        transition: background-color 0.3s, color 0.3s;
      }

      body.dark-mode {
        background-color: var(--bg-dark);
        color: var(--text-light);
      }

      /* Sidebar Styles */
      .sidebar {
        background: linear-gradient(180deg, #003366, #004080);
        padding: 10px;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        width: 200px;
        overflow-y: auto;
      }

      .sidebar .btn {
        width: 100%;
        margin-bottom: 8px;
        color: white;
        font-weight: 600;
        border: none;
        border-radius: 8px;
        padding: 10px 12px;
        text-align: left;
        background-color: rgba(255, 255, 255, 0.1);
        transition: background-color 0.3s;
      }

      .sidebar .btn:hover {
        background-color: rgba(255, 255, 255, 0.2);
      }

      .sidebar .btn.active {
        background-color: var(--primary);
      }

      .sidebar .btn-secondary {
        background-color: rgba(255, 255, 255, 0.1);
      }

      /* Content Area */
      .content {
        margin-left: 220px;
        padding: 30px 40px;
      }

      /* Header Styles */
      .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
      }

      .header img.logo {
        height: 50px;
        margin-right: 15px;
      }

      /* Info Box Styles */
      .info-box {
        background: white;
        border-radius: 16px;
        padding: 25px;
        text-align: center;
        font-size: 18px;
        font-weight: 600;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
        transition: background-color 0.3s, color 0.3s;
      }

      body.dark-mode .info-box {
        background: #2a2a3b;
        color: #fff;
      }

      /* Control Styles */
      .theme-toggle {
        cursor: pointer;
        border: none;
        background: none;
        font-weight: 600;
        color: var(--primary);
      }

      select {
        border-radius: 6px;
        padding: 6px 12px;
        border: 1px solid #ccc;
      }

      /* Chart Styles */
      .charts-container {
        margin-top: 20px;
      }

      .chart-wrapper {
        background: white;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        height: 100%;
      }

      body.dark-mode .chart-wrapper {
        background: #2a2a3b;
      }
    </style>
  </head>
  <body>
    <form id="form1" runat="server">
      <div class="sidebar">
        <img src="sail_logo.png" class="img-fluid mb-3" alt="SAIL Logo" />
        <asp:Repeater
          ID="rptPlants"
          runat="server"
          OnItemCommand="rptPlants_ItemCommand"
        >
          <ItemTemplate>
            <asp:Button
              ID="btnPlant"
              runat="server"
              CssClass='<%# GetButtonClass(Eval("UnitCd").ToString()) %>'
              Text='<%# Eval("UnitAbb") %>'
              CommandName="SelectPlant"
              CommandArgument='<%# Eval("UnitCd") %>'
            />
          </ItemTemplate>
        </asp:Repeater>
      </div>

      <div class="content">
        <div class="header">
          <h2 class="fw-semibold">
            SAIL /
            <asp:Label
              ID="lblSelectedPlant"
              runat="server"
              Text="Plant"
            ></asp:Label>
          </h2>
        </div>

        <div class="d-flex justify-content-end mb-4">
          <asp:DropDownList ID="ddlMonth" runat="server" CssClass="me-2">
            <asp:ListItem Value="All">Select Month</asp:ListItem>
            <asp:ListItem Value="January">January</asp:ListItem>
            <asp:ListItem Value="February">February</asp:ListItem>
            <asp:ListItem Value="March">March</asp:ListItem>
            <asp:ListItem Value="April">April</asp:ListItem>
            <asp:ListItem Value="May">May</asp:ListItem>
            <asp:ListItem Value="June">June</asp:ListItem>
          </asp:DropDownList>

          <asp:DropDownList
            ID="ddlYear"
            runat="server"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlYear_SelectedIndexChanged"
          >
            <asp:ListItem Value="YEAR">YEAR</asp:ListItem>
            <asp:ListItem Value="2023">2023</asp:ListItem>
            <asp:ListItem Value="2024">2024</asp:ListItem>
          </asp:DropDownList>
        </div>

        <div class="row g-4 mb-5">
          <div class="col-md-4">
            <div class="info-box" id="TextBox1">
              Manpower Count<br />
              <asp:TextBox
                ID="TextBox2"
                runat="server"
                BorderStyle="None"
                style="margin-left: 53px"
                Width="111px"
              ></asp:TextBox>
            </div>
          </div>
          <div class="col-md-4">
            <div class="info-box">
              LP<br /><span class="fw-bold">4,560</span>
            </div>
          </div>
          <div class="col-md-4">
            <div class="info-box">
              Works / Non-Works<br /><asp:Label
                ID="lblWorksNonWorks"
                runat="server"
                CssClass="fw-bold"
              ></asp:Label>
            </div>
          </div>
        </div>

        <!-- Charts Container -->
        <div class="charts-container">
          <!-- Original chart for individual plants (hidden, kept for compatibility) -->
          <canvas
            id="lineChart"
            style="
              min-height: 350px;
              max-width: 100%;
              width: 100%;
              display: none;
              margin-bottom: 30px;
            "
          ></canvas>

          <!-- Charts for both SAIL and individual plants -->
          <div class="row mb-4">
            <div class="col-md-6">
              <div
                class="chart-wrapper"
                onclick="openChartModal('functionBarChart', 'Function-wise Manpower Distribution')"
              >
                <canvas
                  id="functionBarChart"
                  style="min-height: 300px; width: 100%; cursor: pointer"
                ></canvas>
              </div>
            </div>
            <div class="col-md-6">
              <div
                class="chart-wrapper"
                onclick="openChartModal('cadreBarChart', 'Cadre-wise Manpower Distribution')"
              >
                <canvas
                  id="cadreBarChart"
                  style="min-height: 300px; width: 100%; cursor: pointer"
                ></canvas>
              </div>
            </div>
          </div>
          <div class="row mb-4">
            <div class="col-md-6">
              <div
                class="chart-wrapper"
                onclick="openChartModal('genderBarChart', 'Gender-wise Manpower Distribution')"
              >
                <canvas
                  id="genderBarChart"
                  style="min-height: 300px; width: 100%; cursor: pointer"
                ></canvas>
              </div>
            </div>
            <div class="col-md-6">
              <div
                class="chart-wrapper"
                onclick="openChartModal('totalBarChart', 'Total Manpower Distribution')"
              >
                <canvas
                  id="totalBarChart"
                  style="min-height: 300px; width: 100%; cursor: pointer"
                ></canvas>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Chart Modal -->
      <div
        class="modal fade"
        id="chartModal"
        tabindex="-1"
        aria-labelledby="chartModalLabel"
        aria-hidden="true"
      >
        <div class="modal-dialog modal-xl">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="chartModalLabel">Chart Details</h5>
              <button
                type="button"
                class="btn-close"
                data-bs-dismiss="modal"
                aria-label="Close"
              ></button>
            </div>
            <div class="modal-body">
              <canvas
                id="modalChart"
                style="width: 100%; height: 500px"
              ></canvas>
            </div>
          </div>
        </div>
      </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      // Theme Toggle Function
      function toggleTheme() {
        document.body.classList.toggle("dark-mode");
      }

      // Chart Modal Functions
      function openChartModal(chartId, title) {
        const sourceChart = window[chartId + "Obj"];
        if (!sourceChart) return;

        // Set modal title
        document.getElementById("chartModalLabel").textContent = title;

        // Show modal
        const modal = new bootstrap.Modal(
          document.getElementById("chartModal")
        );
        modal.show();

        // Wait for modal to be fully shown, then create enlarged chart
        document.getElementById("chartModal").addEventListener(
          "shown.bs.modal",
          function () {
            createModalChart(sourceChart);
          },
          { once: true }
        );
      }

      function createModalChart(sourceChart) {
        const modalCanvas = document.getElementById("modalChart");
        const ctx = modalCanvas.getContext("2d");

        // Destroy existing modal chart if any
        if (window.modalChartObj) {
          window.modalChartObj.destroy();
        }

        // Clone the chart configuration
        const config = {
          type: sourceChart.config.type,
          data: JSON.parse(JSON.stringify(sourceChart.data)),
          options: {
            ...sourceChart.config.options,
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
              ...sourceChart.config.options.plugins,
              title: {
                ...sourceChart.config.options.plugins.title,
                font: { size: 18 },
              },
            },
          },
        };

        // Create new chart in modal
        window.modalChartObj = new Chart(ctx, config);
      }

      // Clean up modal chart when modal is hidden
      document
        .getElementById("chartModal")
        .addEventListener("hidden.bs.modal", function () {
          if (window.modalChartObj) {
            window.modalChartObj.destroy();
            window.modalChartObj = null;
          }
        });
    </script>
    <%-- Chart data script injected from backend --%> <%= chartScript %>
  </body>
</html>
