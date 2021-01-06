SELECT
cm.CampaignName, 
im.impr Impressions,
cb.*,
cc.Conversions,
cc.conv_obrigado, 
cc.conv_blog, 
cc.conv_ebook,
(sum(cb.clicks) / sum(NULLIF(im.impr,0))) ctr,
(sum(cb.cost) / sum(NULLIF(cb.clicks,0))) cpc,
(sum(cc.Conversions) / sum(NULLIF(cb.clicks,0))) convRate,
(sum(cb.Cost) / sum(NULLIF(cc.Conversions, 0))) costPerConv
FROM {{ref('stg_campaignBase')}} cb
JOIN {{ref('stg_campaignLookup')}} cm
ON cb.campaignId = cm.campaignId
JOIN {{ref('stg_campaignImpressions')}} im
ON cb.campaignId = im.campaignId 
AND cb.externalCustomerId = im.externalCustomerId
AND cb.Date = im.Date
AND cb.ISOWEEK = im.ISOWEEK
AND cb.month = im.month
AND cb.year = im.year
LEFT JOIN {{ref('stg_campaignConversions')}} cc
ON cb.campaignId = cc.campaignId
AND cb.ISOWEEK = cc.ISOWEEK
AND cb.month = cc.month
AND cb.year = cc.year
AND cb.Date = cc.Date
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
