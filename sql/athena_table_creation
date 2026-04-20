CREATE OR REPLACE VIEW sentinel_db.cleaned_threats AS
SELECT 
    t.threat.ipAddress AS ip_address, 
    t.threat.abuseConfidenceScore AS score, 
    t.threat.countryCode AS country,
    t.threat.categories[1] AS category_id, 
    t.threat.lastReportedAt AS reported_at
FROM "sentinel_db"."threat_data"
CROSS JOIN UNNEST(data) AS t(threat);
