# 📊 Loan Default Prediction Dashboard

An interactive Power BI dashboard built using SQL and DAX to analyze loan default patterns and risk factors based on customer financial and demographic attributes.

## 🎯 Project Objective

To identify key risk indicators contributing to loan defaults and build an intuitive, interactive dashboard that enables stakeholders to analyze customer profiles and predict potential defaults.

## 🛠️ Tech Stack

- **SQL** - For data transformation and cleaning
- **Power BI** - For data modeling, visual storytelling, and interactivity
- **DAX** - For calculated KPIs and business logic
- **Custom Visuals** - Enhanced user experience with Radar, Star Rating, and Search visuals

## 🗂️ Dashboard Overview

### 📌 Executive Summary
- Key metrics: Average Loan Amount, Income, Credit Score
- Visual breakdown of default vs. non-default rates
- Loan purpose and credit grade distribution

### ⚠️ Risk Overview
Analysis of risk contributors:
- Credit Score
- Income Levels
- DTI Ratio
- Employment Type
- Trends and correlations with default behavior

### 🧑‍💼 Client Profile
- Drill-down analysis for individual customers
- Radar Chart for multi-dimensional score comparison
- Star Rating Visual to highlight customer credit health
- Search Visual to look up customers by Loan ID or name

### 🧭 Navigation Page
Created a custom navigation page with buttons that allow users to jump between:
- Executive Summary
- Risk Overview
- Client Profile

Enhanced user experience with intuitive and visually guided page transitions.

## 📊 Key Metrics & Features

- **Default Rate %**
- **Star Rating** per customer
- **Dynamic color-coding** based on risk
- **Customer Search** (by ID or name)
- **Interactive Navigation Buttons** to streamline dashboard flow

## 🧮 Sample DAX Formulas

```dax
Avg Credit Score = AVERAGE([CreditScore])

Avg Income = AVERAGE([Income])

Avg Loan Amount = AVERAGE([LoanAmount])

Default Count = COUNTROWS(FILTER(LoanData, LoanData[Default] = "Yes"))

Default Rate % = DIVIDE([Default Count], COUNTROWS(LoanData), 0)

Default Rate Color = 
VAR Rate = [Default Rate %]
RETURN
SWITCH(TRUE(),
    Rate > 0.15, "brown",
    Rate >= 0.10 && Rate <= 0.15, "mustard yellow",
    Rate < 0.10, "teal",
    "gray"
)

StarRating = // Custom logic based on weighted risk factors
```

## 🖼️ Dashboard Screenshots

### Executive Summary Page

The Executive Summary provides a high-level overview with:
- **Key Performance Indicators**: Average Credit Score (574.62), Total Loans (2bn), Average Loan Amount (127.79K), Average Income (83.0K)
- **Default Rate Overview**: 0.12 (12%) overall default rate with 1,569 defaults vs 12K non-defaults
- **Credit Grade Analysis**: Default rates by credit grade (Poor, Good, Fair, Excellent)
- **Loan Purpose Distribution**: Breakdown by Auto, Business, Education, Home, and Other categories
- **Key Influencers**: Interactive analysis showing factors that increase default risk, including interest rate and income thresholds

### Risk Overview Page

The Risk Overview page focuses on detailed risk analysis:
- **Employment Impact**: Loan amounts by employment type (Self-employed, Unemployed, Part-time, Full-time) with default indicators
- **Income Distribution**: Scatter plot showing loan amounts across different income levels
- **Marital Status Analysis**: Pie chart breakdown of loan distribution by marital status (Single, Married, Divorced)
- **Age & DTI Risk**: Analysis of loan amounts by age groups and DTI risk levels (High, Low, Medium)
- **Default Rate Gauge**: Central gauge showing 0.12 default rate
- **Loan Purpose Risk**: Bar chart showing default rates across different loan purposes

### Client Profile Page

The Client Profile page offers individual customer analysis:
- **Customer Search**: Search functionality for specific loan IDs (shown: 0HGZQKJ36W)
- **Applicant Information**: Personal details including age (56), income (126,802), marital status (Married), education (PhD)
- **Credit Assessment**: Star rating system showing Financial Trust Score (2.5/5 stars)
- **Loan Details**: Specific loan information including amount (155,511), purpose (Home), interest rate (8.15%), term (60 months)
- **Risk Analysis Radar Chart**: Multi-dimensional view of customer risk factors including Loan Amount, Income, Credit Score, DTI Ratio, and Employment Duration
- **Credit Metrics**: Detailed breakdown of credit lines (4), credit score (531), and default status (0)

## 💡 Key Insights

- Customers with a **Credit Score < 600** and high DTI ratios are **3x more likely** to default
- **Self-employed individuals** show a slightly higher default rate than full-time employees
- **Marital status and dependents** have moderate correlation with default risk
- **Interest rates above 17.95%** significantly increase default probability
- **Poor credit grade** customers show the highest default rates compared to other grades

## 📁 Project Structure

```
Loan-Default-Dashboard/
│
├── PowerBI/
│   ├── LoanDefault.pbix
│
├── SQL/
│   ├── Data_Cleansing.sql
│   ├── FeatureEngineering.sql
│
├── README.md
├── LICENSE
└── Assets/
    ├── Executive_Summary.png
    ├── Risk_Overview.png
    ├── Client_Profile.png
    └── Navigation_Page.png
```

## 🚀 Getting Started

### Prerequisites
- Power BI Desktop (latest version)
- SQL Server or compatible database
- Access to loan dataset

### Installation
1. Clone this repository
2. Open `LoanDefault.pbix` in Power BI Desktop
3. Update data source connections as needed
4. Refresh data to load latest information

### Usage
1. Navigate through dashboard pages using the custom navigation buttons
2. Use filters to drill down into specific customer segments
3. Leverage the search functionality to find specific customers
4. Analyze risk patterns using the interactive visuals

## 📈 Dashboard Features

### Interactive Elements
- **Dynamic Filtering**: Filter by credit score, income, employment type
- **Cross-Filtering**: Selections in one visual automatically filter others
- **Drill-Through**: Click on data points to see detailed customer information
- **Search Functionality**: Find customers by ID or name

### Visual Components
- **KPI Cards**: Display key metrics at a glance
- **Bar Charts**: Show distribution across categories
- **Radar Charts**: Multi-dimensional customer scoring
- **Star Ratings**: Visual representation of customer credit health
- **Heat Maps**: Risk distribution visualization

## 🔧 Customization

### Adding New Metrics
1. Create new measures in the DAX editor
2. Add to appropriate dashboard pages
3. Update color coding and formatting as needed

### Modifying Visuals
1. Select visual in Power BI Desktop
2. Adjust properties in the Formatting pane
3. Update data fields as required

## 📊 Data Sources

The dashboard uses synthetic financial data generated for academic/educational purposes, including:
- Customer demographics
- Loan details
- Credit scores
- Employment information
- Default indicators


## 🙏 Acknowledgments

- Microsoft Power BI Community
- Custom visuals from AppSource
- DAX community for formula optimization
- Dataset: Synthetic financial data generated for academic/educational purposes
