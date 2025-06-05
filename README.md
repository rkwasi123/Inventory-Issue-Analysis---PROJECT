
# 📦 Inventory Issue Analysis Dashboard 

---

## 📚 Problem Statement

**Stakeholder:** Inventory Manager

**Goal:** Identify products with the highest number of inventory issues:
- Manual adjustments
- Stockouts

---

## 🎯 Objectives

1️⃣ Analyze inventory logs  
2️⃣ Spot patterns in stockouts & manual adjustments  
3️⃣ Highlight the most affected products  
4️⃣ Visualize trends for team insights 🚀

---

## 🗃️ Data Sources

| Table | Description |
|-------|-------------|
| inventory_logs | Raw inventory log (change_type, stock levels, timestamp) |
| products | Product details |
| suppliers | Supplier details |
| product_reviews | Product reviews |

---

## 🧹 Data Cleaning Process

### Inventory Logs Cleaning:

- Timestamps had inconsistent formats → standardized with STR_TO_DATE
- Blank log_notes set to NULL

### Products Cleaning:

- Dates standardized (date_added, last_updated_date)
- Blank fields (currency, is_active, is_popular_product) handled with NULLIF

### Views Created:

- inventory_logs_clean
- products_clean
- suppliers_clean
- product_reviews_clean
- final_inventory_analysis 🚀

---

## 📥 Import & Transformation in Power BI

- Imported `final_inventory_analysis` view
- Performed additional Power Query steps
- Unpivoted manual_adjustments and stockouts for flexible charting

---

## 📊 Visualizations

### Main Dashboard

| Visual | Description |
|--------|-------------|
| Top Affected Products | Clustered Bar |
| Inventory Issues by Category | Bar Chart |
| Trend Over Time | Line Chart (Monthly) |
| KPI Cards | Total Inventory Changes, Manual Adjustments, Stockouts |

### 📋 Full Report Page

👉 **[Click here to view the Inventory Report Page](./Report_Page_FINAL_RaymondKadzashie.html)** 🚀

---

## 🎨 Styling & Branding

- Header Bar: #005B96 (Deep Blue)
- Background: #f9f9f9
- Titles: #333333

---

## 🚀 Key Insights

- Manual Adjustments = 5.7% of activity
- Stockouts very low (0.1%)
- Top Categories: Toys & Games, Office Supplies, Craft Supplies

Recommendations: See **Insights & Recommendations** in **[Inventory Report Page](./Report_Page_FINAL_RaymondKadzashie.html)** 🚀

---

## 📎 Files in this Repo

| File | Description |
|------|-------------|
| `load_data.sql` | Loads CSVs into MySQL |
| `cleaning.sql` | Creates clean views |
| `analysis.sql` | Final analysis query |
| `run_project.sql` | Full pipeline |
| `README.md` | Project documentation |
| `/Report_Page_FINAL_RaymondKadzashie.html` | Full Report Page 🚀 |
| `/Inventory_Report_Package/images` | All visuals used in Report Page |

---

Prepared by: **Raymond Kadzashie** 🚀
