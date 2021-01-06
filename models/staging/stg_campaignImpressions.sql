SELECT
campaignId, 
externalCustomerId,
Date,
{{extract('ISOWEEK')}},
{{extract('month')}},
{{extract('year')}},
sum(Impressions) impr
FROM {{var('t_campaignStats')}}
WHERE clickType = "URL_CLICKS"
GROUP BY 1,2,3,4,5,6