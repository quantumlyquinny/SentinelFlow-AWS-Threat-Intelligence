# SENTINEL FLOW: Enterprise Serverless Threat Intelligence 
"An automated pipeline on AWS that resolves the 'Data Silo' challenge by transforming raw security telemetry into actionable risk forensics."
## 1. The Problem We Solve Data Fragmentation: Raw threat intelligence from APIs is often "locked" in complex, nested JSON arrays that standard BI tools cannot interpret natively.Manual Bottlenecks: Security teams often rely on static blacklists; this project automates the lifecycle of a threat, from API ingestion to a live "Risk Map".
## 2. Technology Stack

| Layer | Service Used | Implementation Details |
| :--- | :--- | :--- |
| **Ingestion** | Python (Requests/Boto3) & AWS Lambda | Event-driven extraction from AbuseIPDB API |
| **Orchestration** | Amazon EventBridge | Scheduled micro-batch triggers (Cron-based) |
| **Storage** | Amazon S3 | Multi-tier Data Lake (Bronze, Silver, Curated zones) |
| **Processing** | Amazon Athena | Serverless SQL queries & complex JSON Unnesting |
| **Cataloging** | AWS Glue Data Catalog | Schema enforcement and metadata management |
| **Visualization** | Power BI | Interactive SOC dashboards via Simba ODBC bridge |

## 3. Data Engineering & "Dirty Data" Resolution 
To simulate real-world enterprise data challenges, this pipeline resolves the following engineered anomalies:
* Nested JSON Arrays: Resolving attack category lists into individual records using SQL CROSS JOIN UNNEST.
* Missing Values (Imputation): Implementing COALESCE logic in Athena to handle records missing geographic metadata.
* Schema Drift: Manually refining the AWS Glue Data Catalog to handle nested integer arrays missed by automated crawlers.
* Type Mismatch: Casting raw confidence scores into Integers to enable mathematical risk averaging.
## 4. Analytical Results 100% Automated: 
* Zero manual intervention from API call to Dashboard refresh.
* Single Source of Truth: Aggregated insights generated from JSON web logs into a single, optimized Athena View.
* Cost Optimization: Serverless architecture ensures a "pay-per-query" model, eliminating idle server costs
