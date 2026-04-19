import json
import requests
import boto3
import os
from datetime import datetime

def lambda_handler(event, context):
    # API Setup
    url = 'https://api.abuseipdb.com/api/v2/blacklist'
    params = {'confidenceMinimum': '90', 'limit': '1000'}
    headers = {
        'Accept': 'application/json',
        'Key': os.environ['ABUSEIPDB_API_KEY']
    }

    # Fetching Data
    response = requests.get(url=url, headers=headers, params=params)
    data = response.json()

    # S3 Storage (Bronze Zone)
    s3 = boto3.client('s3')
    bucket_name = 'sentinel-flow-raw-zone'
    file_name = f"threat_logs_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    
    s3.put_object(
        Bucket=bucket_name,
        Key=file_name,
        Body=json.dumps(data)
    )

    return {'statusCode': 200, 'body': 'Telemetry Ingested Successfully'}
