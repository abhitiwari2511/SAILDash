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
        transition: transform 0.2s, box-shadow 0.2s;
        cursor: pointer;
      }

      .chart-wrapper:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
      }

      .pie-chart-small {
        min-height: 250px;
      }

      .pie-chart-small canvas {
        max-height: 200px !important;
      }

      body.dark-mode .chart-wrapper {
        background: #2a2a3b;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      }

      body.dark-mode .chart-wrapper:hover {
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
      }

      /* Layout Control */
      .bar-charts-layout {
        display: block;
      }

      .pie-charts-layout {
        display: none;
      }

      /* Modal Qualification Breakdown Styles */
      .qualification-breakdown-panel {
        background: #f8f9fa;
        border-radius: 8px;
        padding: 20px;
        margin-top: 20px;
        border: 1px solid #dee2e6;
      }

      .breakdown-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 8px 0;
        border-bottom: 1px solid #e9ecef;
      }

      .breakdown-item:last-child {
        border-bottom: none;
      }

      .breakdown-label {
        font-weight: 500;
        color: #495057;
      }

      .breakdown-value {
        font-weight: 600;
        color: #007bff;
      }

      .breakdown-total {
        text-align: center;
        padding: 15px 0 5px 0;
        font-size: 1.1em;
        color: #28a745;
      }

      body.dark-mode .qualification-breakdown-panel {
        background: #343a40;
        border-color: #495057;
      }

      body.dark-mode .breakdown-item {
        border-bottom-color: #495057;
      }

      body.dark-mode .breakdown-label {
        color: #adb5bd;
      }

      body.dark-mode .breakdown-value {
        color: #17a2b8;
      }

      body.dark-mode .breakdown-total {
        color: #28a745;
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
          <!-- Bar charts layout (for SAIL view) -->
          <div class="bar-charts-layout">
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

          <!-- Pie charts layout (for individual plant view) -->
          <div class="pie-charts-layout">
            <div class="row mb-4">
              <div class="col-md-3 col-sm-6 mb-3">
                <div
                  class="chart-wrapper pie-chart-small"
                  onclick="openChartModal('functionPieChart', 'Function-wise Distribution')"
                >
                  <canvas
                    id="functionPieChart"
                    style="height: 200px; width: 100%; cursor: pointer"
                  ></canvas>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 mb-3">
                <div
                  class="chart-wrapper pie-chart-small"
                  onclick="openChartModal('cadrePieChart', 'Cadre-wise Distribution')"
                >
                  <canvas
                    id="cadrePieChart"
                    style="height: 200px; width: 100%; cursor: pointer"
                  ></canvas>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 mb-3">
                <div
                  class="chart-wrapper pie-chart-small"
                  onclick="openChartModal('genderPieChart', 'Gender-wise Distribution')"
                >
                  <canvas
                    id="genderPieChart"
                    style="height: 200px; width: 100%; cursor: pointer"
                  ></canvas>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 mb-3">
                <div
                  class="chart-wrapper pie-chart-small"
                  onclick="openChartModal('totalPieChart', 'Qualification-wise Distribution')"
                >
                  <canvas
                    id="totalPieChart"
                    style="height: 200px; width: 100%; cursor: pointer"
                  ></canvas>
                </div>
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
              <div class="row">
                <div class="col-12" id="modalChartContainer">
                  <canvas
                    id="modalChart"
                    style="width: 100%; height: 500px"
                  ></canvas>
                </div>
                <div
                  class="col-md-4"
                  id="qualificationBreakdown"
                  style="display: none"
                >
                  <div class="qualification-breakdown-panel">
                    <h6 class="mb-3">
                      <i class="fas fa-info-circle"></i> Others Category
                      Includes:
                    </h6>
                    <div class="breakdown-item">
                      <span class="breakdown-label">
                        <i class="fas fa-square text-info"></i> Higher
                        Secondary:
                      </span>
                      <span class="breakdown-value" id="higherSecondaryValue"
                        >N/A</span
                      >
                    </div>
                    <div class="breakdown-item">
                      <span class="breakdown-label">
                        <i class="fas fa-square text-info"></i> Matriculate:
                      </span>
                      <span class="breakdown-value" id="matriculateValue"
                        >N/A</span
                      >
                    </div>
                    <div class="breakdown-item">
                      <span class="breakdown-label">
                        <i class="fas fa-square text-info"></i> Below
                        Matriculate:
                      </span>
                      <span class="breakdown-value" id="belowMatriculateValue"
                        >N/A</span
                      >
                    </div>
                    <hr />
                    <div class="breakdown-total">
                      <strong>
                        <i class="fas fa-calculator"></i> Total Others:
                        <span id="totalOthersValue">N/A</span>
                      </strong>
                    </div>
                  </div>
                </div>
              </div>
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
            createModalChart(sourceChart, chartId, title);
          },
          { once: true }
        );
      }

      function createModalChart(sourceChart, chartId, title) {
        const modalCanvas = document.getElementById("modalChart");
        const ctx = modalCanvas.getContext("2d");
        const qualificationBreakdown = document.getElementById(
          "qualificationBreakdown"
        );

        // Destroy existing modal chart if any
        if (window.modalChartObj) {
          window.modalChartObj.destroy();
        }

        // Check if this is a qualification chart
        const isQualificationChart =
          chartId === "totalBarChart" ||
          chartId === "totalPieChart" ||
          title.includes("Qualification");

        // Get the modal chart container
        const modalChartContainer = document.getElementById(
          "modalChartContainer"
        );

        // Show/hide breakdown panel based on chart type and adjust layout
        if (
          isQualificationChart &&
          sourceChart.data.labels.includes("Others")
        ) {
          qualificationBreakdown.style.display = "block";
          // Adjust chart container to make room for breakdown panel
          modalChartContainer.className = "col-md-8";
          populateModalBreakdown(sourceChart);
        } else {
          qualificationBreakdown.style.display = "none";
          // Chart takes full width when no breakdown panel
          modalChartContainer.className = "col-12";
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

      function populateModalBreakdown(sourceChart) {
        // Use stored breakdown data if available
        if (window.qualificationBreakdownData) {
          const data = window.qualificationBreakdownData;
          document.getElementById("higherSecondaryValue").textContent =
            data.higherSecondary || 0;
          document.getElementById("matriculateValue").textContent =
            data.matriculate || 0;
          document.getElementById("belowMatriculateValue").textContent =
            data.belowMatriculate || 0;
          document.getElementById("totalOthersValue").textContent =
            data.totalOthers || 0;
        } else {
          // Fallback to N/A if no breakdown data
          document.getElementById("higherSecondaryValue").textContent = "N/A";
          document.getElementById("matriculateValue").textContent = "N/A";
          document.getElementById("belowMatriculateValue").textContent = "N/A";
          document.getElementById("totalOthersValue").textContent = "N/A";
        }
      }

      // Function to store qualification breakdown data from backend
      function storeQualificationBreakdownData(breakdownData) {
        window.qualificationBreakdownData = breakdownData;
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
