CREATE OR REPLACE VIEW sentinel_db.cleaned_threats AS
SELECT 
    t.threat.ipaddress AS ip_address, 
    CAST(t.threat.abuseconfidencescore AS INTEGER) AS score, 
    t.threat.countrycode AS country,
    
    -- Safely grabs the first ID, or assigns '99' if the array is empty
    COALESCE(element_at(t.threat.categories, 1), 99) AS category_id, 
    
    t.threat.lastreportedat AS reported_at
FROM "sentinel_db"."threat_data"
CROSS JOIN UNNEST(data) AS t(threat);
