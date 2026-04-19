# SENTINEL FLOW: Enterprise Serverless Threat Intelligence 

"An automated pipeline on AWS that resolves the 'Data Silo' challenge by transforming raw security telemetry into actionable risk forensics."

## 1. The Problem We Solve: Data Fragmentation
Raw threat intelligence from APIs is often "locked" in complex, nested JSON arrays that standard BI tools cannot interpret natively.Manual Bottlenecks: Security teams often rely on static blacklists; this project automates the lifecycle of a threat, from API ingestion to a live "Risk Map".
## 2. Technology Stack

| Layer | Service Used | Implementation Details |
| :--- | :--- | :--- |
| **Ingestion** | Python (Requests/Boto3) & AWS Lambda | Automated extraction from AbuseIPDB API |
| **Orchestration** | Amazon EventBridge | Scheduled hourly micro-batching |
| **Storage** | Amazon S3 | Multi-tier storage (Raw Bronze & Analytical Silver) |
| **Processing** | Amazon Athena | Serverless SQL logic and hierarchical JSON unnesting |
| **Cataloging** | AWS Glue Data Catalog | Automated metadata management and schema enforcement |
| **Visualization** | Power BI | Real-time security telemetry dashboarding |

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
