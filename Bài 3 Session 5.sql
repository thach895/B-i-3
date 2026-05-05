SELECT driver_id, driver_name, distance_km, trust_score
FROM Drivers
WHERE status = 'AVAILABLE'
  AND trust_score >= 80
ORDER BY distance_km ASC, trust_score DESC;