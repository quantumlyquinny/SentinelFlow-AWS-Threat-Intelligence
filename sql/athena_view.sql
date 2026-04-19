/* SENTINEL FLOW: ANALYTICAL VIEW
   This query flattens the nested JSON 'categories' array 
   into a relational format for SOC analysis.
*/

CREATE OR REPLACE VIEW sentinel_db.cleaned_threats AS
SELECT 
    t.threat.ipaddress AS ip_address, 
    CAST(t.threat.abuseconfidencescore AS INTEGER) AS risk_score, 
    t.threat.countrycode AS origin_country,
    
    -- Extracting the primary Category ID from the nested array
    -- We use [1] because Athena arrays start at 1
    t.threat.categories[1] AS threat_category_id, 
    
    t.threat.lastreportedat AS timestamp_utc
FROM "sentinel_db"."threat_data"
CROSS JOIN UNNEST(data) AS t(threat);
