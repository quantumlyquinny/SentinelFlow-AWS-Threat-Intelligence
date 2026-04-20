-- Used to check the raw JSON string to see if the AbuseIPDB API 
-- was actually sending us 'categories' data in the first place.
SELECT data FROM "sentinel_db"."threat_data" LIMIT 5;
