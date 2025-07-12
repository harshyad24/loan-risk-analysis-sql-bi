# 📊 Loan Default Prediction Dashboard

An interactive Power BI dashboard built using SQL and DAX to analyze loan default patterns and risk factors based on customer financial and demographic attributes.

## 🎯 Project Objective

To identify key risk indicators contributing to loan defaults and build an intuitive, interactive dashboard that enables stakeholders to analyze customer profiles and predict potential defaults.

## 🖼️ Dashboard 

## Executive Summary Dashboard
![Executive Summary Dashboard](https://github.com/harshyad24/loan-risk-analysis-sql-bi/raw/main/Executive%20summary.png "Executive Summary Dashboard")

This dashboard provides leadership with a concise yet comprehensive snapshot of the loan portfolio’s overall performance. It highlights key metrics such as an average credit score of **574.62**, total loans amounting to **\$2 billion**, and an average loan amount of **\$127,790**. With an overall default rate of **12%** (1,569 defaults out of 13,569 loans), the dashboard breaks down default rates by credit grades—revealing that borrowers with Poor and Fair credit grades have significantly higher default risks. The loan purpose distribution identifies which categories (e.g., Auto, Business, Home) carry higher exposure, and the interactive key influencer analysis highlights that borrowers with interest rates above certain thresholds and incomes below **\$83,000** have elevated default probabilities. This empowers executives to focus on priority risk factors and optimize portfolio strategies.

## Risk Overview Dashboard

Focused on detailed risk segmentation, this dashboard examines loan performance across borrower demographics and financial profiles. For example, it reveals that self-employed and unemployed borrowers tend to have larger loan amounts but also exhibit higher default indicators. Income distribution analysis shows wide variability, with increased defaults concentrated in lower income brackets. The marital status breakdown indicates that single borrowers have a slightly higher proportion of defaults compared to married ones. Age and Debt-to-Income (DTI) ratio analyses demonstrate that borrowers in certain age groups with high DTI ratios face increased risk. The default rate gauge reiterates the overall **12%** default rate, while the loan purpose risk bar chart pinpoints that loans for Education and Business purposes experience comparatively higher default rates. These insights support targeted risk mitigation and credit policy refinement.

## Client Profile Dashboard

Designed for in-depth individual loan assessment, this dashboard allows users to drill down into specific borrowers—such as a customer with loan ID **0HGZQKJ36W**, who is 56 years old with an income of **\$126,802** and a PhD education level. The financial trust score is moderate at **2.5 out of 5 stars**, reflecting some risk concerns. The loan details show an amount of **\$155,511** for a Home loan at an interest rate of **8.15%** over 60 months. The radar chart synthesizes multiple risk dimensions like loan amount, credit score (**531**), DTI ratio, and employment duration, facilitating a nuanced evaluation of creditworthiness. This detailed profiling supports more informed lending decisions and proactive management of potentially risky clients.



## 💡 Key Insights

- Customers with a **Credit Score < 600** and high DTI ratios are **3x more likely** to default
- **Self-employed individuals** show a slightly higher default rate than full-time employees
- **Marital status and dependents** have moderate correlation with default risk
- **Interest rates above 17.95%** significantly increase default probability
- **Poor credit grade** customers show the highest default rates compared to other grades

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
