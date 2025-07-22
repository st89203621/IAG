/*查询账号偏差使用多个的清单*/
SELECT user_name,count(distinct strsrc_ip ) as q
from test_dw_ods.ods_nf_other_log_tmp_072212
group by user_name
order by q desc;

/*查询账号对应的明细记录*/
select user_name, strsrc_ip, src_port , strdst_ip,dst_port, dev_id,
app_type ,app_name,DATE_FORMAT(from_unixtime(cast(capture_time / 1000 as bigint)), 'yyyy-MM-dd HH:mm:ss') as capture_date,   capture_time
from test_dw_ods.ods_nf_other_log_tmp_072212
where user_name = 'juf44251286'
order by capture_time asc ;

juf44251286,41.109.136.113,123,87.121.84.125,47171,5ab8231e,NET Protocol,NTP,2025-07-22 11:53:19,1753181599000
juf44251286,41.109.136.113,161,138.68.75.93,54852,5ab8231e,NET Protocol,SNMP,2025-07-22 12:03:44,1753182224000
juf44251286,41.109.136.113,3478,146.88.241.92,47944,5ab8231e,NET Protocol,STUN_TURN,2025-07-22 12:49:17,1753184957000
juf44251286,41.109.136.113,500,31.14.32.7,34880,5ab8231e,NET Protocol,ISAKMP,2025-07-22 12:54:11,1753185251000
juf44251286,154.248.198.14,443,185.200.118.46,32946,43e61b70,NET Protocol,QUIC,2025-07-22 13:03:25,1753185805000



/*查询账号对应的信令记录*/
select account, ip, action, session_id, mac,DATE_FORMAT(from_unixtime(cast(capture_time / 1000 as bigint)), 'yyyy-MM-dd HH:mm:ss') as captrue_date, capture_time
from v64_deye_dw_ods.ods_fixnet_radius_store ofrs
where capture_day in ('2025-07-21', '2025-07-22') and account  = 'juf44251286'
order by capture_time asc ;

juf44251286,154.248.198.14,logout,SF9CTEQyMDcyMzMzNTY4MDAxODliMWJkNTNBQUNOenc=,24:91:bb:4e:a6:8f,2025-07-21 18:29:33,1753118973602
juf44251286,41.109.136.113,login,SF9CTEQyMDcyMzMzNTY4MDAxODkxNjcxMmNBQUFiQVU=,24:91:bb:4e:a6:8f,2025-07-21 18:30:08,1753119008832
juf44251286,41.109.136.113,logout,SF9CTEQyMDcyMzMzNTY4MDAxODkxNjcxMmNBQUFiQVU=,24:91:bb:4e:a6:8f,2025-07-22 02:31:41,1753147901844
juf44251286,41.105.197.1,login,SF9CTEQyMDcyMzMzNTY4MDAxODk1NGIzMTVBQUFoU0c=,24:91:bb:4e:a6:8f,2025-07-22 02:54:25,1753149265985




/*查询IP对应的信令记录*/
select account, ip, action, session_id, mac,DATE_FORMAT(from_unixtime(cast(capture_time / 1000 as bigint)), 'yyyy-MM-dd HH:mm:ss') as captrue_date, capture_time
from v64_deye_dw_ods.ods_fixnet_radius_store ofrs
where capture_day in ('2025-07-21', '2025-07-22') and ip  = '41.109.136.113'
order by capture_time asc;

ycf20816703,41.109.136.113,logout,SF9CTEQyMDcyMzMzNTUzMDAxMjQ4OGQ3ODNBQUFxV2w=,c8:84:cf:ba:fe:c5,2025-07-21 09:57:08,1753088228869
vla25277576,41.109.136.113,login,SF9CTEQyMDEyMzAwOTA3MDAxMTA1MTY0MDNBQUNIeWs=,a0:a3:f0:d5:c2:08,2025-07-21 09:57:09,1753088229743
vla25277576,41.109.136.113,logout,SF9CTEQyMDEyMzAwOTA3MDAxMTA1MTY0MDNBQUNIeWs=,a0:a3:f0:d5:c2:08,2025-07-21 16:51:04,1753113064045
bnf44897651,41.109.136.113,login,SF9CTEQyMDcyMzMzNTUwMDAxNzVmMTA4YWZBQUFCWkg=,24:91:bb:1f:1f:37,2025-07-21 16:51:04,1753113064913
bnf44897651,41.109.136.113,logout,SF9CTEQyMDcyMzMzNTUwMDAxNzVmMTA4YWZBQUFCWkg=,24:91:bb:1f:1f:37,2025-07-21 18:30:08,1753119008625
juf44251286,41.109.136.113,login,SF9CTEQyMDcyMzMzNTY4MDAxODkxNjcxMmNBQUFiQVU=,24:91:bb:4e:a6:8f,2025-07-21 18:30:08,1753119008832
juf44251286,41.109.136.113,logout,SF9CTEQyMDcyMzMzNTY4MDAxODkxNjcxMmNBQUFiQVU=,24:91:bb:4e:a6:8f,2025-07-22 02:31:41,1753147901844
sdkenai,41.109.136.113,login,SF9CTEQyMDUyMzEwOTAwMDAxMjM0OGQwZGZBQUExOXA=,0c:b6:d2:c6:33:62,2025-07-22 02:33:31,1753148011736
sdkenai,41.109.136.113,logout,SF9CTEQyMDUyMzEwOTAwMDAxMjM0OGQwZGZBQUExOXA=,0c:b6:d2:c6:33:62,2025-07-22 02:35:48,1753148148895
imf44559571,41.109.136.113,login,SF9CTEQyMDcyMzMzNTQ2MDAxMTBmZDk5YmFBQUF0cEM=,b0:16:56:77:02:d0,2025-07-22 02:38:35,1753148315273



