
SELECT responsible, status, COUNT(*) as count
FROM five_s_cards
GROUP BY responsible, status
ORDER BY responsible;
