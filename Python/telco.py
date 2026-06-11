import pandas as pd

df = pd.read_csv("Python\VI_TELCO_CHURN_DATASETS.csv")

# Data Info
print(df.info())

# Statistical Summary
print(df.describe())

# Average Tenure by Churn
print(df.groupby("Churn")["tenure"].mean())

# Average Monthly Charges by Churn
print(df.groupby("Churn")["MonthlyCharges"].mean())

# Average Total Charges by Churn
print(df.groupby("Churn")["TotalCharges"].mean())

df["Churn_Flag"] = df["Churn"].map({
    "No":0,
    "Yes":1
})

numeric_df = df.select_dtypes(include=["int64","float64"])

print(numeric_df.corr())

df["Risk_Score"] = (
    (df["Contract"] == "Month-to-month") * 3 +
    (df["InternetService"] == "Fiber optic") * 2 +
    (df["PaymentMethod"] == "Electronic check") * 2 +
    (df["OnlineSecurity"] == "No") * 2
)

print(df["Risk_Score"].value_counts().sort_index())

high_risk = df[df["Risk_Score"] >= 7]

print("High Risk Customers:", len(high_risk))

print(high_risk[[
    "Contract",
    "InternetService",
    "PaymentMethod",
    "OnlineSecurity",
    "Churn"
]].head())