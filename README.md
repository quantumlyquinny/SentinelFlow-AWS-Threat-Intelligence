# Sentinel Flow: Serverless Threat Intelligence Pipeline

![AWS](https://img.shields.io/badge/AWS-Serverless-orange.svg)
![Python](https://img.shields.io/badge/Python-3.11-blue.svg)
![SQL](https://img.shields.io/badge/Athena-SQL-yellow.svg)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-gold.svg)

An automated, fully serverless ETL pipeline on AWS that ingests 100–1,000 threat
intelligence records per hour from the AbuseIPDB API and transforms them into a
live, queryable risk map — with zero manual intervention from API call to dashboard refresh.

![Architecture Diagram](docs/architecture.png)

## The Problem

Raw threat intelligence APIs return deeply nested JSON arrays that standard BI tools
cannot interpret natively. Security teams relying on static IP blacklists face constant
manual updates. This pipeline automates the full threat lifecycle: ingest → clean →
enrich → visualise.

## Architecture
AbuseIPDB API
│
▼
AWS Lambda (Python/Boto3)     ← Triggered hourly by EventBridge
│
▼
S3 Bronze Layer (Raw JSON)    ← Immutable landing zone
│
▼
AWS Glue Data Catalog         ← Schema enforcement + crawling
│
▼
Amazon Athena (SQL)           ← Flattening, cleaning, aggregation
│
▼
S3 Silver Layer (Curated)     ← Optimised for analytical queries
│
▼
Power BI Dashboard            ← Live threat risk map

## Data Engineering Challenges Solved

Real-world threat data is messy. This pipeline resolves four categories of engineered anomalies:

| Problem | Solution |
|---|---|
| Nested JSON arrays (attack categories) | `CROSS JOIN UNNEST` in Athena SQL |
| Missing geographic metadata | `COALESCE` imputation logic |
| Schema drift in nested integer arrays | Manual Glue catalog refinement |
| Raw confidence scores as strings | `CAST` to Integer for risk averaging |

## Key Results

- **100% automated** — zero manual steps from API call to dashboard
- **80–90% query cost reduction** via serverless pay-per-query model vs. always-on EC2
- **Single source of truth** — all telemetry aggregated into one optimised Athena view
- **Hourly freshness** — EventBridge micro-batching keeps the risk map current

## Tech Stack

| Layer | Service |
|---|---|
| Ingestion | Python (Requests + Boto3) on AWS Lambda |
| Orchestration | Amazon EventBridge (hourly schedule) |
| Storage | Amazon S3 (Bronze + Silver tiers) |
| Processing | Amazon Athena (serverless SQL) |
| Cataloging | AWS Glue Data Catalog |
| Visualisation | Power BI |

## Running Locally

```bash
git clone https://github.com/quantumlyquinny/sentinel-flow
cd sentinel-flow
pip install -r requirements.txt

# Configure AWS credentials
aws configure

# Run manual ingestion
python src/ingest.py
```

> For full pipeline deployment, see `docs/deployment.md` for CloudFormation/SAM setup.
