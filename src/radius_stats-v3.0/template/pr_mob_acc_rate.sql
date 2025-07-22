SELECT  'pr移网关联准确率'                                             AS cal_type
       ,'{cal_day}'                                             AS cal_day
       ,'{start_hour}-{end_hour}'                               AS cal_hour
	   ,'{uparea_id}'                                           AS uparea_id
       ,SUM(if(calling_station_id = auth_account,1,0))          AS connect_account
       ,SUM(1)                                                  AS total_account
       ,SUM(if(calling_station_id = auth_account,1,0)) / SUM(1) AS acc_rate
FROM
(
	SELECT  pr.strsrc_ip
	       ,pr.auth_account
	       ,pr.capture_time
	       ,radius.calling_station_id
	       ,radius.capture_time                                                  AS r_capture_time
	       ,(pr.capture_time - (radius.capture_time + {pr_offline_time} * 1000)) AS time_diff
	       ,DENSE_RANK() OVER (PARTITION BY pr.strsrc_ip,pr.auth_account,pr.capture_time ORDER BY  pr.capture_time - (radius.capture_time + {pr_offline_time} * 1000)) AS rn
	FROM
	(
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_http_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_im_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_email_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_remotectrl_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_voip_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_ftp_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_game_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_p2p_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_telnet_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_vpn_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
		UNION ALL
		SELECT  strsrc_ip
		       ,auth_account
		       ,src_port
			   ,capture_time
		FROM v64_deye_dw_ods.ods_pr_hardwarestring_store
		WHERE capture_day = '{cal_day}'
		AND capture_hour BETWEEN '{start_hour}' AND '{end_hour}'
		AND auth_account LIKE '213%'
		AND uparea_id = '{uparea_id}'
	) pr
	JOIN
	(
		SELECT  internet_ip
		       ,calling_station_id
		       ,cast(split(port_range,'-')[0] AS int) AS start_port
		       ,cast(split(port_range,'-')[1] AS int) AS end_port
		       ,capture_time
		FROM v64_deye_dw_ods.ods_mobilenet_radius_mobilis_store
		WHERE capture_day = '{cal_day}'
		AND action = 'Start' 
		GROUP BY internet_ip,calling_station_id,port_range,capture_time
	) radius
	ON pr.strsrc_ip = radius.internet_ip AND pr.src_port >= start_port AND pr.src_port <= end_port
	WHERE pr.capture_time >= (radius.capture_time + {pr_offline_time} * 1000) 
) tmp
WHERE rn = 1;