--
-- Database: `openemr`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `addresses`
-- 

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` int(11) NOT NULL default '0',
  `line1` varchar(255) default NULL,
  `line2` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(35) default NULL,
  `zip` varchar(10) default NULL,
  `plus_four` varchar(4) default NULL,
  `country` varchar(255) default NULL,
  `foreign_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `foreign_id` (`foreign_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `array`
-- 

DROP TABLE IF EXISTS `array`;
CREATE TABLE `array` (
  `array_key` varchar(255) default NULL,
  `array_value` longtext
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `batchcom`
-- 

DROP TABLE IF EXISTS `batchcom`;
CREATE TABLE `batchcom` (
  `id` bigint(20) NOT NULL auto_increment,
  `patient_id` int(11) NOT NULL default '0',
  `sent_by` bigint(20) NOT NULL default '0',
  `msg_type` varchar(60) default NULL,
  `msg_subject` varchar(255) default NULL,
  `msg_text` mediumtext,
  `msg_date_sent` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `billing`
-- 

DROP TABLE IF EXISTS `billing`;
CREATE TABLE `billing` (
  `id` int(11) NOT NULL auto_increment,
  `date` datetime default NULL,
  `code_type` varchar(7) default NULL,
  `code` varchar(9) default NULL,
  `pid` int(11) default NULL,
  `provider_id` int(11) default NULL,
  `user` int(11) default NULL,
  `groupname` varchar(255) default NULL,
  `authorized` tinyint(1) default NULL,
  `encounter` int(11) default NULL,
  `code_text` longtext,
  `billed` tinyint(1) default NULL,
  `activity` tinyint(1) default NULL,
  `payer_id` int(11) default NULL,
  `bill_process` tinyint(2) NOT NULL default '0',
  `bill_date` datetime default NULL,
  `process_date` datetime default NULL,
  `process_file` varchar(255) default NULL,
  `modifier` varchar(5) default NULL,
  `units` tinyint(3) default NULL,
  `fee` decimal(12,2) default NULL,
  `justify` varchar(255) default NULL,
  `target` varchar(30) default NULL,
  `x12_partner_id` int(11) default NULL,
  `ndc_info` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `categories`
-- 

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  `parent` int(11) NOT NULL default '0',
  `lft` int(11) NOT NULL default '0',
  `rght` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `parent` (`parent`),
  KEY `lft` (`lft`,`rght`)
) ENGINE=MyISAM;

-- 
-- Dumping data for table `categories`
-- 

INSERT INTO `categories` VALUES (1, 'Categories', '', 0, 0, 19);
INSERT INTO `categories` VALUES (2, 'Lab Report', '', 1, 1, 2);
INSERT INTO `categories` VALUES (3, 'Medical Record', '', 1, 3, 4);
INSERT INTO `categories` VALUES (4, 'Patient Information', '', 1, 5, 10);
INSERT INTO `categories` VALUES (5, 'Patient ID card', '', 4, 6, 7);
INSERT INTO `categories` VALUES (6, 'Advance Directive', '', 1, 11, 18);
INSERT INTO `categories` VALUES (7, 'Do Not Resuscitate Order', '', 6, 12, 13);
INSERT INTO `categories` VALUES (8, 'Durable Power of Attorney', '', 6, 14, 15);
INSERT INTO `categories` VALUES (9, 'Living Will', '', 6, 16, 17);
INSERT INTO `categories` VALUES (10, 'Patient Photograph', '', 4, 8, 9);

-- --------------------------------------------------------

-- 
-- Table structure for table `categories_seq`
-- 

DROP TABLE IF EXISTS `categories_seq`;
CREATE TABLE `categories_seq` (
  `id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM;

-- 
-- Dumping data for table `categories_seq`
-- 

INSERT INTO `categories_seq` VALUES (10);

-- --------------------------------------------------------

-- 
-- Table structure for table `categories_to_documents`
-- 

DROP TABLE IF EXISTS `categories_to_documents`;
CREATE TABLE `categories_to_documents` (
  `category_id` int(11) NOT NULL default '0',
  `document_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`category_id`,`document_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `claims`
-- 

DROP TABLE IF EXISTS `claims`;
CREATE TABLE `claims` (
  `patient_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `version` int(10) unsigned NOT NULL auto_increment,
  `payer_id` int(11) NOT NULL default '0',
  `status` tinyint(2) NOT NULL default '0',
  `payer_type` tinyint(4) NOT NULL default '0',
  `bill_process` tinyint(2) NOT NULL default '0',
  `bill_time` datetime default NULL,
  `process_time` datetime default NULL,
  `process_file` varchar(255) default NULL,
  `target` varchar(30) default NULL,
  `x12_partner_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`patient_id`,`encounter_id`,`version`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `clinical_plans`
--

DROP TABLE IF EXISTS `clinical_plans`;
CREATE TABLE `clinical_plans` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_plans',
  `pid` bigint(20) NOT NULL DEFAULT '0' COMMENT '0 is default for all patients, while > 0 is id from patient_data table',
  `normal_flag` tinyint(1) COMMENT 'Normal Activation Flag',
  `cqm_flag` tinyint(1) COMMENT 'Clinical Quality Measure flag (unable to customize per patient)',
  `cqm_measure_group` varchar(10) NOT NULL default '' COMMENT 'Clinical Quality Measure Group Identifier',
  PRIMARY KEY  (`id`,`pid`)
) ENGINE=MyISAM ;

--
-- Clinical Quality Measure (CMQ) plans
--
-- Measure Group A: Diabetes Mellitus
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('dm_plan_cqm', 0, 0, 1, 'A');
-- Measure Group C: Chronic Kidney Disease (CKD)
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('ckd_plan_cqm', 0, 0, 1, 'C');
-- Measure Group D: Preventative Care
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('prevent_plan_cqm', 0, 0, 1, 'D');
-- Measure Group E: Perioperative Care
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('periop_plan_cqm', 0, 0, 1, 'E');
-- Measure Group F: Rheumatoid Arthritis
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('rheum_arth_plan_cqm', 0, 0, 1, 'F');
-- Measure Group G: Back Pain
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('back_pain_plan_cqm', 0, 0, 1, 'G');
-- Measure Group H: Coronary Artery Bypass Graft (CABG)
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('cabg_plan_cqm', 0, 0, 1, 'H');
--
-- Standard clinical plans
--
-- Diabetes Mellitus
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('dm_plan', 0, 1, 0, '');
INSERT INTO `clinical_plans` ( `id`, `pid`, `normal_flag`, `cqm_flag`, `cqm_measure_group` ) VALUES ('prevent_plan', 0, 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `clinical_plans_rules`
--

DROP TABLE IF EXISTS `clinical_plans_rules`;
CREATE TABLE `clinical_plans_rules` (
  `plan_id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_plans',
  `rule_id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_rules',
  PRIMARY KEY  (`plan_id`,`rule_id`)
) ENGINE=MyISAM ;

--
-- Clinical Quality Measure (CMQ) plans to rules mappings
--
-- Measure Group A: Diabetes Mellitus
--   NQF 0061 (PQRI 3)   Diabetes: Blood Pressure Management
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('dm_plan_cqm', 'rule_dm_bp_control_cqm');
--   NQF 0055 (PQRI 117) Diabetes: Eye Exam
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('dm_plan_cqm', 'rule_dm_eye_cqm');
--   NQF 0056 (PQRI 163) Diabetes: Foot Exam
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('dm_plan_cqm', 'rule_dm_foot_cqm');
-- Measure Group D: Preventative Care
--   NQF 0041 (PQRI 110) Influenza Immunization for Patients >= 50 Years Old
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan_cqm', 'rule_influenza_ge_50_cqm');
--   NQF 0043 (PQRI 111) Pneumonia Vaccination Status for Older Adults
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan_cqm', 'rule_pneumovacc_ge_65_cqm');
--   NQF 0421 (PQRI 128) Adult Weight Screening and Follow-Up
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan_cqm', 'rule_adult_wt_screen_fu_cqm');
--
-- Standard clinical plans to rules mappings
--
-- Diabetes Mellitus
--   Hemoglobin A1C
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('dm_plan', 'rule_dm_hemo_a1c');
--   Urine Microalbumin
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('dm_plan', 'rule_dm_urine_alb');
--   Eye Exam
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('dm_plan', 'rule_dm_eye');
--   Foot Exam
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('dm_plan', 'rule_dm_foot');
-- Preventative Care
--   Hypertension: Blood Pressure Measurement
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_htn_bp_measure');
--   Tobacco Use Assessment
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_tob_use_assess');
--   Tobacco Cessation Intervention
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_tob_cess_inter');
--   Adult Weight Screening and Follow-Up
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_adult_wt_screen_fu');
--   Weight Assessment and Counseling for Children and Adolescents
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_wt_assess_couns_child');
--   Influenza Immunization for Patients >= 50 Years Old
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_influenza_ge_50');
--   Pneumonia Vaccination Status for Older Adults
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_pneumovacc_ge_65');
--   Cancer Screening: Mammogram
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_cs_mammo');
--   Cancer Screening: Pap Smear
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_cs_pap');
--   Cancer Screening: Colon Cancer Screening
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_cs_colon');
--   Cancer Screening: Prostate Cancer Screening
INSERT INTO `clinical_plans_rules` ( `plan_id`, `rule_id` ) VALUES ('prevent_plan', 'rule_cs_prostate');

-- --------------------------------------------------------

--
-- Table structure for table `clinical_rules`
--

DROP TABLE IF EXISTS `clinical_rules`;
CREATE TABLE `clinical_rules` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Unique and maps to list_options list clinical_rules',
  `pid` bigint(20) NOT NULL DEFAULT '0' COMMENT '0 is default for all patients, while > 0 is id from patient_data table',
  `active_alert_flag` tinyint(1) COMMENT 'Active Alert Widget Module flag - note not yet utilized',
  `passive_alert_flag` tinyint(1) COMMENT 'Passive Alert Widget Module flag',
  `cqm_flag` tinyint(1) COMMENT 'Clinical Quality Measure flag (unable to customize per patient)',
  `cqm_nqf_code` varchar(10) NOT NULL default '' COMMENT 'Clinical Quality Measure NQF identifier',
  `cqm_pqri_code` varchar(10) NOT NULL default '' COMMENT 'Clinical Quality Measure PQRI identifier',
  `amc_flag` tinyint(1) COMMENT 'Automated Measure Calculation flag (unable to customize per patient)',
  `amc_code` varchar(10) NOT NULL default '' COMMENT 'Automated Measure Calculation indentifier (MU rule)',
  `patient_reminder_flag` tinyint(1) COMMENT 'Clinical Reminder Module flag',
  PRIMARY KEY  (`id`,`pid`)
) ENGINE=MyISAM ;

--
-- Automated Measure Calculation (AMC) rules
--
-- MU 170.302(c) Maintain an up-to-date problem list of current and active diagnoses
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('problem_list_amc', 0, 0, 0, 0, '', '', 1, '170.302(c)', 0);
-- MU 170.302(d) Maintain active medication list
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('med_list_amc', 0, 0, 0, 0, '', '', 1, '170.302(d)', 0);
-- MU 170.302(e) Maintain active medication allergy list
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('med_allergy_list_amc', 0, 0, 0, 0, '', '', 1, '170.302(e)', 0);
-- MU 170.302(f) Record and chart changes in vital signs
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('record_vitals_amc', 0, 0, 0, 0, '', '', 1, '170.302(f)', 0);
-- MU 170.302(g) Record smoking status for patients 13 years old or older
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('record_smoke_amc', 0, 0, 0, 0, '', '', 1, '170.302(g)', 0);
-- MU 170.302(h) Incorporate clinical lab-test results into certified EHR technology as
--               structured data
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('lab_result_amc', 0, 0, 0, 0, '', '', 1, '170.302(h)', 0);
-- MU 170.302(j) The EP, eligible hospital or CAH who receives a patient from another
--               setting of care or provider of care or believes an encounter is relevant
--               should perform medication reconciliation
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('med_reconc_amc', 0, 0, 0, 0, '', '', 1, '170.302(j)', 0);
-- MU 170.302(m) Use certified EHR technology to identify patient-specific education resources
--              and provide those resources to the patient if appropriate
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('patient_edu_amc', 0, 0, 0, 0, '', '', 1, '170.302(m)', 0);
-- MU 170.304(a) Use CPOE for medication orders directly entered by any licensed healthcare
--              professional who can enter orders into the medical record per state, local
--              and professional guidelines
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('cpoe_med_amc', 0, 0, 0, 0, '', '', 1, '170.304(a)', 0);
-- MU 170.304(b) Generate and transmit permissible prescriptions electronically (eRx)
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('e_prescribe_amc', 0, 0, 0, 0, '', '', 1, '170.304(b)', 0);
-- MU 170.304(c) Record demographics
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('record_dem_amc', 0, 0, 0, 0, '', '', 1, '170.304(c)', 0);
-- MU 170.304(d) Send reminders to patients per patient preference for preventive/follow up care
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('send_reminder_amc', 0, 0, 0, 0, '', '', 1, '170.304(d)', 0);
-- MU 170.304(f) Provide patients with an electronic copy of their health information
--               (including diagnostic test results, problem list, medication lists,
--               medication allergies), upon request
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('provide_rec_pat_amc', 0, 0, 0, 0, '', '', 1, '170.304(f)', 0);
-- MU 170.304(g) Provide patients with timely electronic access to their health information
--              (including lab results, problem list, medication lists, medication allergies)
--              within four business days of the information being available to the EP
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('timely_access_amc', 0, 0, 0, 0, '', '', 1, '170.304(g)', 0);
-- MU 170.304(h) Provide clinical summaries for patients for each office visit
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('provide_sum_pat_amc', 0, 0, 0, 0, '', '', 1, '170.304(h)', 0);
-- MU 170.304(i) The EP, eligible hospital or CAH who transitions their patient to
--               another setting of care or provider of care or refers their patient to
--               another provider of care should provide summary of care record for
--               each transition of care or referral
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('send_sum_amc', 0, 0, 0, 0, '', '', 1, '170.304(i)', 0);
--
-- Clinical Quality Measure (CQM) rules
--
-- NQF 0013 Hypertension: Blood Pressure Measurement
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_htn_bp_measure_cqm', 0, 0, 0, 1, '0013', '', 0, '', 0);
-- NQF 0028a Tobacco Use Assessment
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_tob_use_assess_cqm', 0, 0, 0, 1, '0028a', '', 0, '', 0);
-- NQF 0028b Tobacco Cessation Intervention
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_tob_cess_inter_cqm', 0, 0, 0, 1, '0028b', '', 0, '', 0);
-- NQF 0421 (PQRI 128) Adult Weight Screening and Follow-Up
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_adult_wt_screen_fu_cqm', 0, 0, 0, 1, '0421', '128', 0, '', 0);
-- NQF 0024 Weight Assessment and Counseling for Children and Adolescents
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_wt_assess_couns_child_cqm', 0, 0, 0, 1, '0024', '', 0, '', 0);
-- NQF 0041 (PQRI 110) Influenza Immunization for Patients >= 50 Years Old
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_influenza_ge_50_cqm', 0, 0, 0, 1, '0041', '110', 0, '', 0);
-- NQF 0038 Childhood immunization Status
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_child_immun_stat_cqm', 0, 0, 0, 1, '0038', '', 0, '', 0);
-- NQF 0043 (PQRI 111) Pneumonia Vaccination Status for Older Adults
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_pneumovacc_ge_65_cqm', 0, 0, 0, 1, '0043', '111', 0, '', 0);
-- NQF 0055 (PQRI 117) Diabetes: Eye Exam
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_dm_eye_cqm', 0, 0, 0, 1, '0055', '117', 0, '', 0);
-- NQF 0056 (PQRI 163) Diabetes: Foot Exam
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_dm_foot_cqm', 0, 0, 0, 1, '0056', '163', 0, '', 0);
-- NQF 0061 (PQRI 3)   Diabetes: Blood Pressure Management
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_dm_bp_control_cqm', 0, 0, 0, 1, '0061', '3', 0, '', 0);
--
-- Standard clinical rules
--
-- Hypertension: Blood Pressure Measurement
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_htn_bp_measure', 0, 0, 1, 0, '', '', 0, '', 0);
-- Tobacco Use Assessment
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_tob_use_assess', 0, 0, 1, 0, '', '', 0, '', 0);
-- Tobacco Cessation Intervention
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_tob_cess_inter', 0, 0, 1, 0, '', '', 0, '', 0);
-- Adult Weight Screening and Follow-Up
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_adult_wt_screen_fu', 0, 0, 1, 0, '', '', 0, '', 0);
-- Weight Assessment and Counseling for Children and Adolescents
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_wt_assess_couns_child', 0, 0, 1, 0, '', '', 0, '', 0);
-- Influenza Immunization for Patients >= 50 Years Old
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_influenza_ge_50', 0, 0, 1, 0, '', '', 0, '', 0);
-- Pneumonia Vaccination Status for Older Adults
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_pneumovacc_ge_65', 0, 0, 1, 0, '', '', 0, '', 0);
-- Diabetes: Hemoglobin A1C
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_dm_hemo_a1c', 0, 0, 1, 0, '', '', 0, '', 0);
-- Diabetes: Urine Microalbumin
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_dm_urine_alb', 0, 0, 1, 0, '', '', 0, '', 0);
-- Diabetes: Eye Exam
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_dm_eye', 0, 0, 1, 0, '', '', 0, '', 0);
-- Diabetes: Foot Exam
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_dm_foot', 0, 0, 1, 0, '', '', 0, '', 0);
-- Cancer Screening: Mammogram
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_cs_mammo', 0, 0, 1, 0, '', '', 0, '', 0);
-- Cancer Screening: Pap Smear
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_cs_pap', 0, 0, 1, 0, '', '', 0, '', 0);
-- Cancer Screening: Colon Cancer Screening
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_cs_colon', 0, 0, 1, 0, '', '', 0, '', 0);
-- Cancer Screening: Prostate Cancer Screening
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_cs_prostate', 0, 0, 1, 0, '', '', 0, '', 0);
--
-- Rules to specifically demonstrate passing of NIST criteria
--
-- Coumadin Management - INR Monitoring
INSERT INTO `clinical_rules` ( `id`, `pid`, `active_alert_flag`, `passive_alert_flag`, `cqm_flag`, `cqm_nqf_code`, `cqm_pqri_code`, `amc_flag`, `amc_code`, `patient_reminder_flag` ) VALUES ('rule_inr_monitor', 0, 0, 1, 0, '', '', 0, '', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `codes`
-- 

DROP TABLE IF EXISTS `codes`;
CREATE TABLE `codes` (
  `id` int(11) NOT NULL auto_increment,
  `code_text` varchar(255) NOT NULL default '',
  `code_text_short` varchar(24) NOT NULL default '',
  `code` varchar(10) NOT NULL default '',
  `code_type` tinyint(2) default NULL,
  `modifier` varchar(5) NOT NULL default '',
  `units` tinyint(3) default NULL,
  `fee` decimal(12,2) default NULL,
  `superbill` varchar(31) NOT NULL default '',
  `related_code` varchar(255) NOT NULL default '',
  `taxrates` varchar(255) NOT NULL default '',
  `cyp_factor` float NOT NULL DEFAULT 0 COMMENT 'quantity representing a years supply',
  `active` TINYINT(1) DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `reportable` TINYINT(1) DEFAULT 0 COMMENT '0 = non-reportable, 1 = reportable',
  PRIMARY KEY  (`id`),
  KEY `code` (`code`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;
-- --------------------------------------------------------

-- 
-- Table structure for table `syndromic_surveillance`
-- 

DROP TABLE IF EXISTS `syndromic_surveillance`;
CREATE TABLE `syndromic_surveillance` (
  `id` bigint(20) NOT NULL auto_increment,
  `lists_id` bigint(20) NOT NULL,
  `submission_date` datetime NOT NULL,
  `filename` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY (`lists_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `config`
-- 

DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  `parent` int(11) NOT NULL default '0',
  `lft` int(11) NOT NULL default '0',
  `rght` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `parent` (`parent`),
  KEY `lft` (`lft`,`rght`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `config_seq`
-- 

DROP TABLE IF EXISTS `config_seq`;
CREATE TABLE `config_seq` (
  `id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM;

-- 
-- Dumping data for table `config_seq`
-- 

INSERT INTO `config_seq` VALUES (0);

-- --------------------------------------------------------

-- 
-- Table structure for table `documents`
-- 

DROP TABLE IF EXISTS `documents`;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL default '0',
  `type` enum('file_url','blob','web_url') default NULL,
  `size` int(11) default NULL,
  `date` datetime default NULL,
  `url` varchar(255) default NULL,
  `mimetype` varchar(255) default NULL,
  `pages` int(11) default NULL,
  `owner` int(11) default NULL,
  `revision` timestamp NOT NULL,
  `foreign_id` int(11) default NULL,
  `docdate` date default NULL,
  `hash` varchar(40) DEFAULT NULL COMMENT '40-character SHA-1 hash of document',
  `list_id` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `revision` (`revision`),
  KEY `foreign_id` (`foreign_id`),
  KEY `owner` (`owner`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `drug_inventory`
-- 

DROP TABLE IF EXISTS `drug_inventory`;
CREATE TABLE `drug_inventory` (
  `inventory_id` int(11) NOT NULL auto_increment,
  `drug_id` int(11) NOT NULL,
  `lot_number` varchar(20) default NULL,
  `expiration` date default NULL,
  `manufacturer` varchar(255) default NULL,
  `on_hand` int(11) NOT NULL default '0',
  `warehouse_id` varchar(31) NOT NULL DEFAULT '',
  `vendor_id` bigint(20) NOT NULL DEFAULT 0,
  `last_notify` date NOT NULL default '0000-00-00',
  `destroy_date` date default NULL,
  `destroy_method` varchar(255) default NULL,
  `destroy_witness` varchar(255) default NULL,
  `destroy_notes` varchar(255) default NULL,
  PRIMARY KEY  (`inventory_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `drug_sales`
-- 

DROP TABLE IF EXISTS `drug_sales`;
CREATE TABLE `drug_sales` (
  `sale_id` int(11) NOT NULL auto_increment,
  `drug_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `prescription_id` int(11) NOT NULL default '0',
  `pid` int(11) NOT NULL default '0',
  `encounter` int(11) NOT NULL default '0',
  `user` varchar(255) default NULL,
  `sale_date` date NOT NULL,
  `quantity` int(11) NOT NULL default '0',
  `fee` decimal(12,2) NOT NULL default '0.00',
  `billed` tinyint(1) NOT NULL default '0' COMMENT 'indicates if the sale is posted to accounting',
  `xfer_inventory_id` int(11) NOT NULL DEFAULT 0,
  `distributor_id` bigint(20) NOT NULL DEFAULT 0 COMMENT 'references users.id',
  `notes` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY  (`sale_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `drug_templates`
-- 

DROP TABLE IF EXISTS `drug_templates`;
CREATE TABLE `drug_templates` (
  `drug_id` int(11) NOT NULL,
  `selector` varchar(255) NOT NULL default '',
  `dosage` varchar(10) default NULL,
  `period` int(11) NOT NULL default '0',
  `quantity` int(11) NOT NULL default '0',
  `refills` int(11) NOT NULL default '0',
  `taxrates` varchar(255) default NULL,
  PRIMARY KEY  (`drug_id`,`selector`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `drugs`
-- 

DROP TABLE IF EXISTS `drugs`;
CREATE TABLE `drugs` (
  `drug_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL DEFAULT '',
  `ndc_number` varchar(20) NOT NULL DEFAULT '',
  `on_order` int(11) NOT NULL default '0',
  `reorder_point` int(11) NOT NULL default '0',
  `last_notify` date NOT NULL default '0000-00-00',
  `reactions` text,
  `form` int(3) NOT NULL default '0',
  `size` float unsigned NOT NULL default '0',
  `unit` int(11) NOT NULL default '0',
  `route` int(11) NOT NULL default '0',
  `substitute` int(11) NOT NULL default '0',
  `related_code` varchar(255) NOT NULL DEFAULT '' COMMENT 'may reference a related codes.code',
  `cyp_factor` float NOT NULL DEFAULT 0 COMMENT 'quantity representing a years supply',
  `active` TINYINT(1) DEFAULT 1 COMMENT '0 = inactive, 1 = active',
  `allow_combining` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = allow filling an order from multiple lots',
  `allow_multiple`  tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 = allow multiple lots at one warehouse',
  PRIMARY KEY  (`drug_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `eligibility_response`
--

DROP TABLE IF EXISTS `eligibility_response`;
CREATE TABLE `eligibility_response` (
  `response_id` bigint(20) NOT NULL auto_increment,
  `response_description` varchar(255) default NULL,
  `response_status` enum('A','D') NOT NULL default 'A',
  `response_vendor_id` bigint(20) default NULL,
  `response_create_date` date default NULL,
  `response_modify_date` date default NULL,
  PRIMARY KEY  (`response_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Table structure for table `eligibility_verification`
--

DROP TABLE IF EXISTS `eligibility_verification`;
CREATE TABLE `eligibility_verification` (
  `verification_id` bigint(20) NOT NULL auto_increment,
  `response_id` bigint(20) default NULL,
  `insurance_id` bigint(20) default NULL,
  `eligibility_check_date` datetime default NULL,
  `copay` int(11) default NULL,
  `deductible` int(11) default NULL,
  `deductiblemet` enum('Y','N') default 'Y',
  `create_date` date default NULL,
  PRIMARY KEY  (`verification_id`),
  KEY `insurance_id` (`insurance_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1;

-- --------------------------------------------------------

-- 
-- Table structure for table `employer_data`
-- 

DROP TABLE IF EXISTS `employer_data`;
CREATE TABLE `employer_data` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `street` varchar(255) default NULL,
  `postal_code` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `country` varchar(255) default NULL,
  `date` datetime default NULL,
  `pid` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `enc_category_map`
--
-- Mapping of rule encounter categories to category ids from the event category in openemr_postcalendar_categories
--

DROP TABLE IF EXISTS `enc_category_map`;
CREATE TABLE `enc_category_map` (
  `rule_enc_id` varchar(31) NOT NULL DEFAULT '' COMMENT 'encounter id from rule_enc_types list in list_options',
  `main_cat_id` int(11) NOT NULL DEFAULT 0 COMMENT 'category id from event category in openemr_postcalendar_categories',
  KEY  (`rule_enc_id`,`main_cat_id`)
) ENGINE=MyISAM ;

INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_outpatient', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_outpatient', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_outpatient', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nurs_fac', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nurs_fac', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nurs_fac', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_off_vis', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_off_vis', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_off_vis', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_hea_and_beh', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_hea_and_beh', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_hea_and_beh', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_occ_ther', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_occ_ther', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_occ_ther', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_psych_and_psych', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_psych_and_psych', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_psych_and_psych', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_ser_18_older', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_ser_18_older', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_ser_18_older', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_ind_counsel', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_ind_counsel', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_ind_counsel', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_group_counsel', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_group_counsel', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_group_counsel', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_other_serv', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_other_serv', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pre_med_other_serv', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_out_pcp_obgyn', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_out_pcp_obgyn', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_out_pcp_obgyn', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pregnancy', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pregnancy', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_pregnancy', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nurs_discharge', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nurs_discharge', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nurs_discharge', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_acute_inp_or_ed', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_acute_inp_or_ed', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_acute_inp_or_ed', 10);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nonac_inp_out_or_opth', 5);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nonac_inp_out_or_opth', 9);
INSERT INTO `enc_category_map` ( `rule_enc_id`, `main_cat_id` ) VALUES ('enc_nonac_inp_out_or_opth', 10);

-- --------------------------------------------------------

-- 
-- Table structure for table `facility`
-- 

DROP TABLE IF EXISTS `facility`;
CREATE TABLE `facility` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `phone` varchar(30) default NULL,
  `fax` varchar(30) default NULL,
  `street` varchar(255) default NULL,
  `city` varchar(255) default NULL,
  `state` varchar(50) default NULL,
  `postal_code` varchar(11) default NULL,
  `country_code` varchar(10) default NULL,
  `federal_ein` varchar(15) default NULL,
  `service_location` tinyint(1) NOT NULL default '1',
  `billing_location` tinyint(1) NOT NULL default '0',
  `accepts_assignment` tinyint(1) NOT NULL default '0',
  `pos_code` tinyint(4) default NULL,
  `x12_sender_id` varchar(25) default NULL,
  `attn` varchar(65) default NULL,
  `domain_identifier` varchar(60) default NULL,
  `facility_npi` varchar(15) default NULL,
  `tax_id_type` VARCHAR(31) NOT NULL DEFAULT '',
  `color` VARCHAR(7) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 ;

-- 
-- Dumping data for table `facility`
-- 

INSERT INTO `facility` VALUES (3, 'Your Clinic Name Here', '000-000-0000', '000-000-0000', '', '', '', '', '', '', 1, 1, 0, NULL, '', '', '', '', '','#99FFFF');

-- --------------------------------------------------------

-- 
-- Table structure for table `fee_sheet_options`
-- 

DROP TABLE IF EXISTS `fee_sheet_options`;
CREATE TABLE `fee_sheet_options` (
  `fs_category` varchar(63) default NULL,
  `fs_option` varchar(63) default NULL,
  `fs_codes` varchar(255) default NULL
) ENGINE=MyISAM;

-- 
-- Dumping data for table `fee_sheet_options`
-- 

INSERT INTO `fee_sheet_options` VALUES ('1New Patient', '1Brief', 'CPT4|99201|');
INSERT INTO `fee_sheet_options` VALUES ('1New Patient', '2Limited', 'CPT4|99202|');
INSERT INTO `fee_sheet_options` VALUES ('1New Patient', '3Detailed', 'CPT4|99203|');
INSERT INTO `fee_sheet_options` VALUES ('1New Patient', '4Extended', 'CPT4|99204|');
INSERT INTO `fee_sheet_options` VALUES ('1New Patient', '5Comprehensive', 'CPT4|99205|');
INSERT INTO `fee_sheet_options` VALUES ('2Established Patient', '1Brief', 'CPT4|99211|');
INSERT INTO `fee_sheet_options` VALUES ('2Established Patient', '2Limited', 'CPT4|99212|');
INSERT INTO `fee_sheet_options` VALUES ('2Established Patient', '3Detailed', 'CPT4|99213|');
INSERT INTO `fee_sheet_options` VALUES ('2Established Patient', '4Extended', 'CPT4|99214|');
INSERT INTO `fee_sheet_options` VALUES ('2Established Patient', '5Comprehensive', 'CPT4|99215|');

-- --------------------------------------------------------

-- 
-- Table structure for table `form_dictation`
-- 

DROP TABLE IF EXISTS `form_dictation`;
CREATE TABLE `form_dictation` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `pid` bigint(20) default NULL,
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `authorized` tinyint(4) default NULL,
  `activity` tinyint(4) default NULL,
  `dictation` longtext,
  `additional_notes` longtext,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `form_encounter`
-- 

DROP TABLE IF EXISTS `form_encounter`;
CREATE TABLE `form_encounter` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `reason` longtext,
  `facility` longtext,
  `facility_id` int(11) NOT NULL default '0',
  `pid` bigint(20) default NULL,
  `encounter` bigint(20) default NULL,
  `onset_date` datetime default NULL,
  `sensitivity` varchar(30) default NULL,
  `billing_note` text,
  `pc_catid` int(11) NOT NULL default '5' COMMENT 'event category from openemr_postcalendar_categories',
  `last_level_billed` int  NOT NULL DEFAULT 0 COMMENT '0=none, 1=ins1, 2=ins2, etc',
  `last_level_closed` int  NOT NULL DEFAULT 0 COMMENT '0=none, 1=ins1, 2=ins2, etc',
  `last_stmt_date`    date DEFAULT NULL,
  `stmt_count`        int  NOT NULL DEFAULT 0,
  `provider_id` INT(11) DEFAULT '0' COMMENT 'default and main provider for this visit',
  `supervisor_id` INT(11) DEFAULT '0' COMMENT 'supervising provider, if any, for this visit',
  `invoice_refno` varchar(31) NOT NULL DEFAULT '',
  `referral_source` varchar(31) NOT NULL DEFAULT '',
  `billing_facility` INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `form_misc_billing_options`
-- 

DROP TABLE IF EXISTS `form_misc_billing_options`;
CREATE TABLE `form_misc_billing_options` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `pid` bigint(20) default NULL,
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `authorized` tinyint(4) default NULL,
  `activity` tinyint(4) default NULL,
  `employment_related` tinyint(1) default NULL,
  `auto_accident` tinyint(1) default NULL,
  `accident_state` varchar(2) default NULL,
  `other_accident` tinyint(1) default NULL,
  `outside_lab` tinyint(1) default NULL,
  `lab_amount` decimal(5,2) default NULL,
  `is_unable_to_work` tinyint(1) default NULL,
  `off_work_from` date default NULL,
  `off_work_to` date default NULL,
  `is_hospitalized` tinyint(1) default NULL,
  `hospitalization_date_from` date default NULL,
  `hospitalization_date_to` date default NULL,
  `medicaid_resubmission_code` varchar(10) default NULL,
  `medicaid_original_reference` varchar(15) default NULL,
  `prior_auth_number` varchar(20) default NULL,
  `comments` varchar(255) default NULL,
  `replacement_claim` tinyint(1) default 0,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `form_reviewofs`
-- 

DROP TABLE IF EXISTS `form_reviewofs`;
CREATE TABLE `form_reviewofs` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `pid` bigint(20) default NULL,
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `authorized` tinyint(4) default NULL,
  `activity` tinyint(4) default NULL,
  `fever` varchar(5) default NULL,
  `chills` varchar(5) default NULL,
  `night_sweats` varchar(5) default NULL,
  `weight_loss` varchar(5) default NULL,
  `poor_appetite` varchar(5) default NULL,
  `insomnia` varchar(5) default NULL,
  `fatigued` varchar(5) default NULL,
  `depressed` varchar(5) default NULL,
  `hyperactive` varchar(5) default NULL,
  `exposure_to_foreign_countries` varchar(5) default NULL,
  `cataracts` varchar(5) default NULL,
  `cataract_surgery` varchar(5) default NULL,
  `glaucoma` varchar(5) default NULL,
  `double_vision` varchar(5) default NULL,
  `blurred_vision` varchar(5) default NULL,
  `poor_hearing` varchar(5) default NULL,
  `headaches` varchar(5) default NULL,
  `ringing_in_ears` varchar(5) default NULL,
  `bloody_nose` varchar(5) default NULL,
  `sinusitis` varchar(5) default NULL,
  `sinus_surgery` varchar(5) default NULL,
  `dry_mouth` varchar(5) default NULL,
  `strep_throat` varchar(5) default NULL,
  `tonsillectomy` varchar(5) default NULL,
  `swollen_lymph_nodes` varchar(5) default NULL,
  `throat_cancer` varchar(5) default NULL,
  `throat_cancer_surgery` varchar(5) default NULL,
  `heart_attack` varchar(5) default NULL,
  `irregular_heart_beat` varchar(5) default NULL,
  `chest_pains` varchar(5) default NULL,
  `shortness_of_breath` varchar(5) default NULL,
  `high_blood_pressure` varchar(5) default NULL,
  `heart_failure` varchar(5) default NULL,
  `poor_circulation` varchar(5) default NULL,
  `vascular_surgery` varchar(5) default NULL,
  `cardiac_catheterization` varchar(5) default NULL,
  `coronary_artery_bypass` varchar(5) default NULL,
  `heart_transplant` varchar(5) default NULL,
  `stress_test` varchar(5) default NULL,
  `emphysema` varchar(5) default NULL,
  `chronic_bronchitis` varchar(5) default NULL,
  `interstitial_lung_disease` varchar(5) default NULL,
  `shortness_of_breath_2` varchar(5) default NULL,
  `lung_cancer` varchar(5) default NULL,
  `lung_cancer_surgery` varchar(5) default NULL,
  `pheumothorax` varchar(5) default NULL,
  `stomach_pains` varchar(5) default NULL,
  `peptic_ulcer_disease` varchar(5) default NULL,
  `gastritis` varchar(5) default NULL,
  `endoscopy` varchar(5) default NULL,
  `polyps` varchar(5) default NULL,
  `colonoscopy` varchar(5) default NULL,
  `colon_cancer` varchar(5) default NULL,
  `colon_cancer_surgery` varchar(5) default NULL,
  `ulcerative_colitis` varchar(5) default NULL,
  `crohns_disease` varchar(5) default NULL,
  `appendectomy` varchar(5) default NULL,
  `divirticulitis` varchar(5) default NULL,
  `divirticulitis_surgery` varchar(5) default NULL,
  `gall_stones` varchar(5) default NULL,
  `cholecystectomy` varchar(5) default NULL,
  `hepatitis` varchar(5) default NULL,
  `cirrhosis_of_the_liver` varchar(5) default NULL,
  `splenectomy` varchar(5) default NULL,
  `kidney_failure` varchar(5) default NULL,
  `kidney_stones` varchar(5) default NULL,
  `kidney_cancer` varchar(5) default NULL,
  `kidney_infections` varchar(5) default NULL,
  `bladder_infections` varchar(5) default NULL,
  `bladder_cancer` varchar(5) default NULL,
  `prostate_problems` varchar(5) default NULL,
  `prostate_cancer` varchar(5) default NULL,
  `kidney_transplant` varchar(5) default NULL,
  `sexually_transmitted_disease` varchar(5) default NULL,
  `burning_with_urination` varchar(5) default NULL,
  `discharge_from_urethra` varchar(5) default NULL,
  `rashes` varchar(5) default NULL,
  `infections` varchar(5) default NULL,
  `ulcerations` varchar(5) default NULL,
  `pemphigus` varchar(5) default NULL,
  `herpes` varchar(5) default NULL,
  `osetoarthritis` varchar(5) default NULL,
  `rheumotoid_arthritis` varchar(5) default NULL,
  `lupus` varchar(5) default NULL,
  `ankylosing_sondlilitis` varchar(5) default NULL,
  `swollen_joints` varchar(5) default NULL,
  `stiff_joints` varchar(5) default NULL,
  `broken_bones` varchar(5) default NULL,
  `neck_problems` varchar(5) default NULL,
  `back_problems` varchar(5) default NULL,
  `back_surgery` varchar(5) default NULL,
  `scoliosis` varchar(5) default NULL,
  `herniated_disc` varchar(5) default NULL,
  `shoulder_problems` varchar(5) default NULL,
  `elbow_problems` varchar(5) default NULL,
  `wrist_problems` varchar(5) default NULL,
  `hand_problems` varchar(5) default NULL,
  `hip_problems` varchar(5) default NULL,
  `knee_problems` varchar(5) default NULL,
  `ankle_problems` varchar(5) default NULL,
  `foot_problems` varchar(5) default NULL,
  `insulin_dependent_diabetes` varchar(5) default NULL,
  `noninsulin_dependent_diabetes` varchar(5) default NULL,
  `hypothyroidism` varchar(5) default NULL,
  `hyperthyroidism` varchar(5) default NULL,
  `cushing_syndrom` varchar(5) default NULL,
  `addison_syndrom` varchar(5) default NULL,
  `additional_notes` longtext,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `form_ros`
-- 

DROP TABLE IF EXISTS `form_ros`;
CREATE TABLE `form_ros` (
  `id` int(11) NOT NULL auto_increment,
  `pid` int(11) NOT NULL,
  `activity` int(11) NOT NULL default '1',
  `date` datetime default NULL,
  `weight_change` varchar(3) default NULL,
  `weakness` varchar(3) default NULL,
  `fatigue` varchar(3) default NULL,
  `anorexia` varchar(3) default NULL,
  `fever` varchar(3) default NULL,
  `chills` varchar(3) default NULL,
  `night_sweats` varchar(3) default NULL,
  `insomnia` varchar(3) default NULL,
  `irritability` varchar(3) default NULL,
  `heat_or_cold` varchar(3) default NULL,
  `intolerance` varchar(3) default NULL,
  `change_in_vision` varchar(3) default NULL,
  `glaucoma_history` varchar(3) default NULL,
  `eye_pain` varchar(3) default NULL,
  `irritation` varchar(3) default NULL,
  `redness` varchar(3) default NULL,
  `excessive_tearing` varchar(3) default NULL,
  `double_vision` varchar(3) default NULL,
  `blind_spots` varchar(3) default NULL,
  `photophobia` varchar(3) default NULL,
  `hearing_loss` varchar(3) default NULL,
  `discharge` varchar(3) default NULL,
  `pain` varchar(3) default NULL,
  `vertigo` varchar(3) default NULL,
  `tinnitus` varchar(3) default NULL,
  `frequent_colds` varchar(3) default NULL,
  `sore_throat` varchar(3) default NULL,
  `sinus_problems` varchar(3) default NULL,
  `post_nasal_drip` varchar(3) default NULL,
  `nosebleed` varchar(3) default NULL,
  `snoring` varchar(3) default NULL,
  `apnea` varchar(3) default NULL,
  `breast_mass` varchar(3) default NULL,
  `breast_discharge` varchar(3) default NULL,
  `biopsy` varchar(3) default NULL,
  `abnormal_mammogram` varchar(3) default NULL,
  `cough` varchar(3) default NULL,
  `sputum` varchar(3) default NULL,
  `shortness_of_breath` varchar(3) default NULL,
  `wheezing` varchar(3) default NULL,
  `hemoptsyis` varchar(3) default NULL,
  `asthma` varchar(3) default NULL,
  `copd` varchar(3) default NULL,
  `chest_pain` varchar(3) default NULL,
  `palpitation` varchar(3) default NULL,
  `syncope` varchar(3) default NULL,
  `pnd` varchar(3) default NULL,
  `doe` varchar(3) default NULL,
  `orthopnea` varchar(3) default NULL,
  `peripheal` varchar(3) default NULL,
  `edema` varchar(3) default NULL,
  `legpain_cramping` varchar(3) default NULL,
  `history_murmur` varchar(3) default NULL,
  `arrythmia` varchar(3) default NULL,
  `heart_problem` varchar(3) default NULL,
  `dysphagia` varchar(3) default NULL,
  `heartburn` varchar(3) default NULL,
  `bloating` varchar(3) default NULL,
  `belching` varchar(3) default NULL,
  `flatulence` varchar(3) default NULL,
  `nausea` varchar(3) default NULL,
  `vomiting` varchar(3) default NULL,
  `hematemesis` varchar(3) default NULL,
  `gastro_pain` varchar(3) default NULL,
  `food_intolerance` varchar(3) default NULL,
  `hepatitis` varchar(3) default NULL,
  `jaundice` varchar(3) default NULL,
  `hematochezia` varchar(3) default NULL,
  `changed_bowel` varchar(3) default NULL,
  `diarrhea` varchar(3) default NULL,
  `constipation` varchar(3) default NULL,
  `polyuria` varchar(3) default NULL,
  `polydypsia` varchar(3) default NULL,
  `dysuria` varchar(3) default NULL,
  `hematuria` varchar(3) default NULL,
  `frequency` varchar(3) default NULL,
  `urgency` varchar(3) default NULL,
  `incontinence` varchar(3) default NULL,
  `renal_stones` varchar(3) default NULL,
  `utis` varchar(3) default NULL,
  `hesitancy` varchar(3) default NULL,
  `dribbling` varchar(3) default NULL,
  `stream` varchar(3) default NULL,
  `nocturia` varchar(3) default NULL,
  `erections` varchar(3) default NULL,
  `ejaculations` varchar(3) default NULL,
  `g` varchar(3) default NULL,
  `p` varchar(3) default NULL,
  `ap` varchar(3) default NULL,
  `lc` varchar(3) default NULL,
  `mearche` varchar(3) default NULL,
  `menopause` varchar(3) default NULL,
  `lmp` varchar(3) default NULL,
  `f_frequency` varchar(3) default NULL,
  `f_flow` varchar(3) default NULL,
  `f_symptoms` varchar(3) default NULL,
  `abnormal_hair_growth` varchar(3) default NULL,
  `f_hirsutism` varchar(3) default NULL,
  `joint_pain` varchar(3) default NULL,
  `swelling` varchar(3) default NULL,
  `m_redness` varchar(3) default NULL,
  `m_warm` varchar(3) default NULL,
  `m_stiffness` varchar(3) default NULL,
  `muscle` varchar(3) default NULL,
  `m_aches` varchar(3) default NULL,
  `fms` varchar(3) default NULL,
  `arthritis` varchar(3) default NULL,
  `loc` varchar(3) default NULL,
  `seizures` varchar(3) default NULL,
  `stroke` varchar(3) default NULL,
  `tia` varchar(3) default NULL,
  `n_numbness` varchar(3) default NULL,
  `n_weakness` varchar(3) default NULL,
  `paralysis` varchar(3) default NULL,
  `intellectual_decline` varchar(3) default NULL,
  `memory_problems` varchar(3) default NULL,
  `dementia` varchar(3) default NULL,
  `n_headache` varchar(3) default NULL,
  `s_cancer` varchar(3) default NULL,
  `psoriasis` varchar(3) default NULL,
  `s_acne` varchar(3) default NULL,
  `s_other` varchar(3) default NULL,
  `s_disease` varchar(3) default NULL,
  `p_diagnosis` varchar(3) default NULL,
  `p_medication` varchar(3) default NULL,
  `depression` varchar(3) default NULL,
  `anxiety` varchar(3) default NULL,
  `social_difficulties` varchar(3) default NULL,
  `thyroid_problems` varchar(3) default NULL,
  `diabetes` varchar(3) default NULL,
  `abnormal_blood` varchar(3) default NULL,
  `anemia` varchar(3) default NULL,
  `fh_blood_problems` varchar(3) default NULL,
  `bleeding_problems` varchar(3) default NULL,
  `allergies` varchar(3) default NULL,
  `frequent_illness` varchar(3) default NULL,
  `hiv` varchar(3) default NULL,
  `hai_status` varchar(3) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `form_soap`
-- 

DROP TABLE IF EXISTS `form_soap`;
CREATE TABLE `form_soap` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `pid` bigint(20) default '0',
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `authorized` tinyint(4) default '0',
  `activity` tinyint(4) default '0',
  `subjective` text,
  `objective` text,
  `assessment` text,
  `plan` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `form_vitals`
-- 

DROP TABLE IF EXISTS `form_vitals`;
CREATE TABLE `form_vitals` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `pid` bigint(20) default '0',
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `authorized` tinyint(4) default '0',
  `activity` tinyint(4) default '0',
  `bps` varchar(40) default NULL,
  `bpd` varchar(40) default NULL,
  `weight` float(5,2) default '0.00',
  `height` float(5,2) default '0.00',
  `temperature` float(5,2) default '0.00',
  `temp_method` varchar(255) default NULL,
  `pulse` float(5,2) default '0.00',
  `respiration` float(5,2) default '0.00',
  `note` varchar(255) default NULL,
  `BMI` float(4,1) default '0.0',
  `BMI_status` varchar(255) default NULL,
  `waist_circ` float(5,2) default '0.00',
  `head_circ` float(4,2) default '0.00',
  `oxygen_saturation` float(5,2) default '0.00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `forms`
-- 

DROP TABLE IF EXISTS `forms`;
CREATE TABLE `forms` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `encounter` bigint(20) default NULL,
  `form_name` longtext,
  `form_id` bigint(20) default NULL,
  `pid` bigint(20) default NULL,
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `authorized` tinyint(4) default NULL,
  `deleted` tinyint(4) DEFAULT '0' NOT NULL COMMENT 'flag indicates form has been deleted',
  `formdir` longtext,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `geo_country_reference`
-- 

DROP TABLE IF EXISTS `geo_country_reference`;
CREATE TABLE `geo_country_reference` (
  `countries_id` int(5) NOT NULL auto_increment,
  `countries_name` varchar(64) default NULL,
  `countries_iso_code_2` char(2) NOT NULL default '',
  `countries_iso_code_3` char(3) NOT NULL default '',
  PRIMARY KEY  (`countries_id`),
  KEY `IDX_COUNTRIES_NAME` (`countries_name`)
) ENGINE=MyISAM AUTO_INCREMENT=240 ;

-- 
-- Dumping data for table `geo_country_reference`
-- 

INSERT INTO `geo_country_reference` VALUES (1, 'Afghanistan', 'AF', 'AFG');
INSERT INTO `geo_country_reference` VALUES (2, 'Albania', 'AL', 'ALB');
INSERT INTO `geo_country_reference` VALUES (3, 'Algeria', 'DZ', 'DZA');
INSERT INTO `geo_country_reference` VALUES (4, 'American Samoa', 'AS', 'ASM');
INSERT INTO `geo_country_reference` VALUES (5, 'Andorra', 'AD', 'AND');
INSERT INTO `geo_country_reference` VALUES (6, 'Angola', 'AO', 'AGO');
INSERT INTO `geo_country_reference` VALUES (7, 'Anguilla', 'AI', 'AIA');
INSERT INTO `geo_country_reference` VALUES (8, 'Antarctica', 'AQ', 'ATA');
INSERT INTO `geo_country_reference` VALUES (9, 'Antigua and Barbuda', 'AG', 'ATG');
INSERT INTO `geo_country_reference` VALUES (10, 'Argentina', 'AR', 'ARG');
INSERT INTO `geo_country_reference` VALUES (11, 'Armenia', 'AM', 'ARM');
INSERT INTO `geo_country_reference` VALUES (12, 'Aruba', 'AW', 'ABW');
INSERT INTO `geo_country_reference` VALUES (13, 'Australia', 'AU', 'AUS');
INSERT INTO `geo_country_reference` VALUES (14, 'Austria', 'AT', 'AUT');
INSERT INTO `geo_country_reference` VALUES (15, 'Azerbaijan', 'AZ', 'AZE');
INSERT INTO `geo_country_reference` VALUES (16, 'Bahamas', 'BS', 'BHS');
INSERT INTO `geo_country_reference` VALUES (17, 'Bahrain', 'BH', 'BHR');
INSERT INTO `geo_country_reference` VALUES (18, 'Bangladesh', 'BD', 'BGD');
INSERT INTO `geo_country_reference` VALUES (19, 'Barbados', 'BB', 'BRB');
INSERT INTO `geo_country_reference` VALUES (20, 'Belarus', 'BY', 'BLR');
INSERT INTO `geo_country_reference` VALUES (21, 'Belgium', 'BE', 'BEL');
INSERT INTO `geo_country_reference` VALUES (22, 'Belize', 'BZ', 'BLZ');
INSERT INTO `geo_country_reference` VALUES (23, 'Benin', 'BJ', 'BEN');
INSERT INTO `geo_country_reference` VALUES (24, 'Bermuda', 'BM', 'BMU');
INSERT INTO `geo_country_reference` VALUES (25, 'Bhutan', 'BT', 'BTN');
INSERT INTO `geo_country_reference` VALUES (26, 'Bolivia', 'BO', 'BOL');
INSERT INTO `geo_country_reference` VALUES (27, 'Bosnia and Herzegowina', 'BA', 'BIH');
INSERT INTO `geo_country_reference` VALUES (28, 'Botswana', 'BW', 'BWA');
INSERT INTO `geo_country_reference` VALUES (29, 'Bouvet Island', 'BV', 'BVT');
INSERT INTO `geo_country_reference` VALUES (30, 'Brazil', 'BR', 'BRA');
INSERT INTO `geo_country_reference` VALUES (31, 'British Indian Ocean Territory', 'IO', 'IOT');
INSERT INTO `geo_country_reference` VALUES (32, 'Brunei Darussalam', 'BN', 'BRN');
INSERT INTO `geo_country_reference` VALUES (33, 'Bulgaria', 'BG', 'BGR');
INSERT INTO `geo_country_reference` VALUES (34, 'Burkina Faso', 'BF', 'BFA');
INSERT INTO `geo_country_reference` VALUES (35, 'Burundi', 'BI', 'BDI');
INSERT INTO `geo_country_reference` VALUES (36, 'Cambodia', 'KH', 'KHM');
INSERT INTO `geo_country_reference` VALUES (37, 'Cameroon', 'CM', 'CMR');
INSERT INTO `geo_country_reference` VALUES (38, 'Canada', 'CA', 'CAN');
INSERT INTO `geo_country_reference` VALUES (39, 'Cape Verde', 'CV', 'CPV');
INSERT INTO `geo_country_reference` VALUES (40, 'Cayman Islands', 'KY', 'CYM');
INSERT INTO `geo_country_reference` VALUES (41, 'Central African Republic', 'CF', 'CAF');
INSERT INTO `geo_country_reference` VALUES (42, 'Chad', 'TD', 'TCD');
INSERT INTO `geo_country_reference` VALUES (43, 'Chile', 'CL', 'CHL');
INSERT INTO `geo_country_reference` VALUES (44, 'China', 'CN', 'CHN');
INSERT INTO `geo_country_reference` VALUES (45, 'Christmas Island', 'CX', 'CXR');
INSERT INTO `geo_country_reference` VALUES (46, 'Cocos (Keeling) Islands', 'CC', 'CCK');
INSERT INTO `geo_country_reference` VALUES (47, 'Colombia', 'CO', 'COL');
INSERT INTO `geo_country_reference` VALUES (48, 'Comoros', 'KM', 'COM');
INSERT INTO `geo_country_reference` VALUES (49, 'Congo', 'CG', 'COG');
INSERT INTO `geo_country_reference` VALUES (50, 'Cook Islands', 'CK', 'COK');
INSERT INTO `geo_country_reference` VALUES (51, 'Costa Rica', 'CR', 'CRI');
INSERT INTO `geo_country_reference` VALUES (52, 'Cote D Ivoire', 'CI', 'CIV');
INSERT INTO `geo_country_reference` VALUES (53, 'Croatia', 'HR', 'HRV');
INSERT INTO `geo_country_reference` VALUES (54, 'Cuba', 'CU', 'CUB');
INSERT INTO `geo_country_reference` VALUES (55, 'Cyprus', 'CY', 'CYP');
INSERT INTO `geo_country_reference` VALUES (56, 'Czech Republic', 'CZ', 'CZE');
INSERT INTO `geo_country_reference` VALUES (57, 'Denmark', 'DK', 'DNK');
INSERT INTO `geo_country_reference` VALUES (58, 'Djibouti', 'DJ', 'DJI');
INSERT INTO `geo_country_reference` VALUES (59, 'Dominica', 'DM', 'DMA');
INSERT INTO `geo_country_reference` VALUES (60, 'Dominican Republic', 'DO', 'DOM');
INSERT INTO `geo_country_reference` VALUES (61, 'East Timor', 'TP', 'TMP');
INSERT INTO `geo_country_reference` VALUES (62, 'Ecuador', 'EC', 'ECU');
INSERT INTO `geo_country_reference` VALUES (63, 'Egypt', 'EG', 'EGY');
INSERT INTO `geo_country_reference` VALUES (64, 'El Salvador', 'SV', 'SLV');
INSERT INTO `geo_country_reference` VALUES (65, 'Equatorial Guinea', 'GQ', 'GNQ');
INSERT INTO `geo_country_reference` VALUES (66, 'Eritrea', 'ER', 'ERI');
INSERT INTO `geo_country_reference` VALUES (67, 'Estonia', 'EE', 'EST');
INSERT INTO `geo_country_reference` VALUES (68, 'Ethiopia', 'ET', 'ETH');
INSERT INTO `geo_country_reference` VALUES (69, 'Falkland Islands (Malvinas)', 'FK', 'FLK');
INSERT INTO `geo_country_reference` VALUES (70, 'Faroe Islands', 'FO', 'FRO');
INSERT INTO `geo_country_reference` VALUES (71, 'Fiji', 'FJ', 'FJI');
INSERT INTO `geo_country_reference` VALUES (72, 'Finland', 'FI', 'FIN');
INSERT INTO `geo_country_reference` VALUES (73, 'France', 'FR', 'FRA');
INSERT INTO `geo_country_reference` VALUES (74, 'France, MEtropolitan', 'FX', 'FXX');
INSERT INTO `geo_country_reference` VALUES (75, 'French Guiana', 'GF', 'GUF');
INSERT INTO `geo_country_reference` VALUES (76, 'French Polynesia', 'PF', 'PYF');
INSERT INTO `geo_country_reference` VALUES (77, 'French Southern Territories', 'TF', 'ATF');
INSERT INTO `geo_country_reference` VALUES (78, 'Gabon', 'GA', 'GAB');
INSERT INTO `geo_country_reference` VALUES (79, 'Gambia', 'GM', 'GMB');
INSERT INTO `geo_country_reference` VALUES (80, 'Georgia', 'GE', 'GEO');
INSERT INTO `geo_country_reference` VALUES (81, 'Germany', 'DE', 'DEU');
INSERT INTO `geo_country_reference` VALUES (82, 'Ghana', 'GH', 'GHA');
INSERT INTO `geo_country_reference` VALUES (83, 'Gibraltar', 'GI', 'GIB');
INSERT INTO `geo_country_reference` VALUES (84, 'Greece', 'GR', 'GRC');
INSERT INTO `geo_country_reference` VALUES (85, 'Greenland', 'GL', 'GRL');
INSERT INTO `geo_country_reference` VALUES (86, 'Grenada', 'GD', 'GRD');
INSERT INTO `geo_country_reference` VALUES (87, 'Guadeloupe', 'GP', 'GLP');
INSERT INTO `geo_country_reference` VALUES (88, 'Guam', 'GU', 'GUM');
INSERT INTO `geo_country_reference` VALUES (89, 'Guatemala', 'GT', 'GTM');
INSERT INTO `geo_country_reference` VALUES (90, 'Guinea', 'GN', 'GIN');
INSERT INTO `geo_country_reference` VALUES (91, 'Guinea-bissau', 'GW', 'GNB');
INSERT INTO `geo_country_reference` VALUES (92, 'Guyana', 'GY', 'GUY');
INSERT INTO `geo_country_reference` VALUES (93, 'Haiti', 'HT', 'HTI');
INSERT INTO `geo_country_reference` VALUES (94, 'Heard and Mc Donald Islands', 'HM', 'HMD');
INSERT INTO `geo_country_reference` VALUES (95, 'Honduras', 'HN', 'HND');
INSERT INTO `geo_country_reference` VALUES (96, 'Hong Kong', 'HK', 'HKG');
INSERT INTO `geo_country_reference` VALUES (97, 'Hungary', 'HU', 'HUN');
INSERT INTO `geo_country_reference` VALUES (98, 'Iceland', 'IS', 'ISL');
INSERT INTO `geo_country_reference` VALUES (99, 'India', 'IN', 'IND');
INSERT INTO `geo_country_reference` VALUES (100, 'Indonesia', 'ID', 'IDN');
INSERT INTO `geo_country_reference` VALUES (101, 'Iran (Islamic Republic of)', 'IR', 'IRN');
INSERT INTO `geo_country_reference` VALUES (102, 'Iraq', 'IQ', 'IRQ');
INSERT INTO `geo_country_reference` VALUES (103, 'Ireland', 'IE', 'IRL');
INSERT INTO `geo_country_reference` VALUES (104, 'Israel', 'IL', 'ISR');
INSERT INTO `geo_country_reference` VALUES (105, 'Italy', 'IT', 'ITA');
INSERT INTO `geo_country_reference` VALUES (106, 'Jamaica', 'JM', 'JAM');
INSERT INTO `geo_country_reference` VALUES (107, 'Japan', 'JP', 'JPN');
INSERT INTO `geo_country_reference` VALUES (108, 'Jordan', 'JO', 'JOR');
INSERT INTO `geo_country_reference` VALUES (109, 'Kazakhstan', 'KZ', 'KAZ');
INSERT INTO `geo_country_reference` VALUES (110, 'Kenya', 'KE', 'KEN');
INSERT INTO `geo_country_reference` VALUES (111, 'Kiribati', 'KI', 'KIR');
INSERT INTO `geo_country_reference` VALUES (112, 'Korea, Democratic Peoples Republic of', 'KP', 'PRK');
INSERT INTO `geo_country_reference` VALUES (113, 'Korea, Republic of', 'KR', 'KOR');
INSERT INTO `geo_country_reference` VALUES (114, 'Kuwait', 'KW', 'KWT');
INSERT INTO `geo_country_reference` VALUES (115, 'Kyrgyzstan', 'KG', 'KGZ');
INSERT INTO `geo_country_reference` VALUES (116, 'Lao Peoples Democratic Republic', 'LA', 'LAO');
INSERT INTO `geo_country_reference` VALUES (117, 'Latvia', 'LV', 'LVA');
INSERT INTO `geo_country_reference` VALUES (118, 'Lebanon', 'LB', 'LBN');
INSERT INTO `geo_country_reference` VALUES (119, 'Lesotho', 'LS', 'LSO');
INSERT INTO `geo_country_reference` VALUES (120, 'Liberia', 'LR', 'LBR');
INSERT INTO `geo_country_reference` VALUES (121, 'Libyan Arab Jamahiriya', 'LY', 'LBY');
INSERT INTO `geo_country_reference` VALUES (122, 'Liechtenstein', 'LI', 'LIE');
INSERT INTO `geo_country_reference` VALUES (123, 'Lithuania', 'LT', 'LTU');
INSERT INTO `geo_country_reference` VALUES (124, 'Luxembourg', 'LU', 'LUX');
INSERT INTO `geo_country_reference` VALUES (125, 'Macau', 'MO', 'MAC');
INSERT INTO `geo_country_reference` VALUES (126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD');
INSERT INTO `geo_country_reference` VALUES (127, 'Madagascar', 'MG', 'MDG');
INSERT INTO `geo_country_reference` VALUES (128, 'Malawi', 'MW', 'MWI');
INSERT INTO `geo_country_reference` VALUES (129, 'Malaysia', 'MY', 'MYS');
INSERT INTO `geo_country_reference` VALUES (130, 'Maldives', 'MV', 'MDV');
INSERT INTO `geo_country_reference` VALUES (131, 'Mali', 'ML', 'MLI');
INSERT INTO `geo_country_reference` VALUES (132, 'Malta', 'MT', 'MLT');
INSERT INTO `geo_country_reference` VALUES (133, 'Marshall Islands', 'MH', 'MHL');
INSERT INTO `geo_country_reference` VALUES (134, 'Martinique', 'MQ', 'MTQ');
INSERT INTO `geo_country_reference` VALUES (135, 'Mauritania', 'MR', 'MRT');
INSERT INTO `geo_country_reference` VALUES (136, 'Mauritius', 'MU', 'MUS');
INSERT INTO `geo_country_reference` VALUES (137, 'Mayotte', 'YT', 'MYT');
INSERT INTO `geo_country_reference` VALUES (138, 'Mexico', 'MX', 'MEX');
INSERT INTO `geo_country_reference` VALUES (139, 'Micronesia, Federated States of', 'FM', 'FSM');
INSERT INTO `geo_country_reference` VALUES (140, 'Moldova, Republic of', 'MD', 'MDA');
INSERT INTO `geo_country_reference` VALUES (141, 'Monaco', 'MC', 'MCO');
INSERT INTO `geo_country_reference` VALUES (142, 'Mongolia', 'MN', 'MNG');
INSERT INTO `geo_country_reference` VALUES (143, 'Montserrat', 'MS', 'MSR');
INSERT INTO `geo_country_reference` VALUES (144, 'Morocco', 'MA', 'MAR');
INSERT INTO `geo_country_reference` VALUES (145, 'Mozambique', 'MZ', 'MOZ');
INSERT INTO `geo_country_reference` VALUES (146, 'Myanmar', 'MM', 'MMR');
INSERT INTO `geo_country_reference` VALUES (147, 'Namibia', 'NA', 'NAM');
INSERT INTO `geo_country_reference` VALUES (148, 'Nauru', 'NR', 'NRU');
INSERT INTO `geo_country_reference` VALUES (149, 'Nepal', 'NP', 'NPL');
INSERT INTO `geo_country_reference` VALUES (150, 'Netherlands', 'NL', 'NLD');
INSERT INTO `geo_country_reference` VALUES (151, 'Netherlands Antilles', 'AN', 'ANT');
INSERT INTO `geo_country_reference` VALUES (152, 'New Caledonia', 'NC', 'NCL');
INSERT INTO `geo_country_reference` VALUES (153, 'New Zealand', 'NZ', 'NZL');
INSERT INTO `geo_country_reference` VALUES (154, 'Nicaragua', 'NI', 'NIC');
INSERT INTO `geo_country_reference` VALUES (155, 'Niger', 'NE', 'NER');
INSERT INTO `geo_country_reference` VALUES (156, 'Nigeria', 'NG', 'NGA');
INSERT INTO `geo_country_reference` VALUES (157, 'Niue', 'NU', 'NIU');
INSERT INTO `geo_country_reference` VALUES (158, 'Norfolk Island', 'NF', 'NFK');
INSERT INTO `geo_country_reference` VALUES (159, 'Northern Mariana Islands', 'MP', 'MNP');
INSERT INTO `geo_country_reference` VALUES (160, 'Norway', 'NO', 'NOR');
INSERT INTO `geo_country_reference` VALUES (161, 'Oman', 'OM', 'OMN');
INSERT INTO `geo_country_reference` VALUES (162, 'Pakistan', 'PK', 'PAK');
INSERT INTO `geo_country_reference` VALUES (163, 'Palau', 'PW', 'PLW');
INSERT INTO `geo_country_reference` VALUES (164, 'Panama', 'PA', 'PAN');
INSERT INTO `geo_country_reference` VALUES (165, 'Papua New Guinea', 'PG', 'PNG');
INSERT INTO `geo_country_reference` VALUES (166, 'Paraguay', 'PY', 'PRY');
INSERT INTO `geo_country_reference` VALUES (167, 'Peru', 'PE', 'PER');
INSERT INTO `geo_country_reference` VALUES (168, 'Philippines', 'PH', 'PHL');
INSERT INTO `geo_country_reference` VALUES (169, 'Pitcairn', 'PN', 'PCN');
INSERT INTO `geo_country_reference` VALUES (170, 'Poland', 'PL', 'POL');
INSERT INTO `geo_country_reference` VALUES (171, 'Portugal', 'PT', 'PRT');
INSERT INTO `geo_country_reference` VALUES (172, 'Puerto Rico', 'PR', 'PRI');
INSERT INTO `geo_country_reference` VALUES (173, 'Qatar', 'QA', 'QAT');
INSERT INTO `geo_country_reference` VALUES (174, 'Reunion', 'RE', 'REU');
INSERT INTO `geo_country_reference` VALUES (175, 'Romania', 'RO', 'ROM');
INSERT INTO `geo_country_reference` VALUES (176, 'Russian Federation', 'RU', 'RUS');
INSERT INTO `geo_country_reference` VALUES (177, 'Rwanda', 'RW', 'RWA');
INSERT INTO `geo_country_reference` VALUES (178, 'Saint Kitts and Nevis', 'KN', 'KNA');
INSERT INTO `geo_country_reference` VALUES (179, 'Saint Lucia', 'LC', 'LCA');
INSERT INTO `geo_country_reference` VALUES (180, 'Saint Vincent and the Grenadines', 'VC', 'VCT');
INSERT INTO `geo_country_reference` VALUES (181, 'Samoa', 'WS', 'WSM');
INSERT INTO `geo_country_reference` VALUES (182, 'San Marino', 'SM', 'SMR');
INSERT INTO `geo_country_reference` VALUES (183, 'Sao Tome and Principe', 'ST', 'STP');
INSERT INTO `geo_country_reference` VALUES (184, 'Saudi Arabia', 'SA', 'SAU');
INSERT INTO `geo_country_reference` VALUES (185, 'Senegal', 'SN', 'SEN');
INSERT INTO `geo_country_reference` VALUES (186, 'Seychelles', 'SC', 'SYC');
INSERT INTO `geo_country_reference` VALUES (187, 'Sierra Leone', 'SL', 'SLE');
INSERT INTO `geo_country_reference` VALUES (188, 'Singapore', 'SG', 'SGP');
INSERT INTO `geo_country_reference` VALUES (189, 'Slovakia (Slovak Republic)', 'SK', 'SVK');
INSERT INTO `geo_country_reference` VALUES (190, 'Slovenia', 'SI', 'SVN');
INSERT INTO `geo_country_reference` VALUES (191, 'Solomon Islands', 'SB', 'SLB');
INSERT INTO `geo_country_reference` VALUES (192, 'Somalia', 'SO', 'SOM');
INSERT INTO `geo_country_reference` VALUES (193, 'south Africa', 'ZA', 'ZAF');
INSERT INTO `geo_country_reference` VALUES (194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS');
INSERT INTO `geo_country_reference` VALUES (195, 'Spain', 'ES', 'ESP');
INSERT INTO `geo_country_reference` VALUES (196, 'Sri Lanka', 'LK', 'LKA');
INSERT INTO `geo_country_reference` VALUES (197, 'St. Helena', 'SH', 'SHN');
INSERT INTO `geo_country_reference` VALUES (198, 'St. Pierre and Miquelon', 'PM', 'SPM');
INSERT INTO `geo_country_reference` VALUES (199, 'Sudan', 'SD', 'SDN');
INSERT INTO `geo_country_reference` VALUES (200, 'Suriname', 'SR', 'SUR');
INSERT INTO `geo_country_reference` VALUES (201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM');
INSERT INTO `geo_country_reference` VALUES (202, 'Swaziland', 'SZ', 'SWZ');
INSERT INTO `geo_country_reference` VALUES (203, 'Sweden', 'SE', 'SWE');
INSERT INTO `geo_country_reference` VALUES (204, 'Switzerland', 'CH', 'CHE');
INSERT INTO `geo_country_reference` VALUES (205, 'Syrian Arab Republic', 'SY', 'SYR');
INSERT INTO `geo_country_reference` VALUES (206, 'Taiwan, Province of China', 'TW', 'TWN');
INSERT INTO `geo_country_reference` VALUES (207, 'Tajikistan', 'TJ', 'TJK');
INSERT INTO `geo_country_reference` VALUES (208, 'Tanzania, United Republic of', 'TZ', 'TZA');
INSERT INTO `geo_country_reference` VALUES (209, 'Thailand', 'TH', 'THA');
INSERT INTO `geo_country_reference` VALUES (210, 'Togo', 'TG', 'TGO');
INSERT INTO `geo_country_reference` VALUES (211, 'Tokelau', 'TK', 'TKL');
INSERT INTO `geo_country_reference` VALUES (212, 'Tonga', 'TO', 'TON');
INSERT INTO `geo_country_reference` VALUES (213, 'Trinidad and Tobago', 'TT', 'TTO');
INSERT INTO `geo_country_reference` VALUES (214, 'Tunisia', 'TN', 'TUN');
INSERT INTO `geo_country_reference` VALUES (215, 'Turkey', 'TR', 'TUR');
INSERT INTO `geo_country_reference` VALUES (216, 'Turkmenistan', 'TM', 'TKM');
INSERT INTO `geo_country_reference` VALUES (217, 'Turks and Caicos Islands', 'TC', 'TCA');
INSERT INTO `geo_country_reference` VALUES (218, 'Tuvalu', 'TV', 'TUV');
INSERT INTO `geo_country_reference` VALUES (219, 'Uganda', 'UG', 'UGA');
INSERT INTO `geo_country_reference` VALUES (220, 'Ukraine', 'UA', 'UKR');
INSERT INTO `geo_country_reference` VALUES (221, 'United Arab Emirates', 'AE', 'ARE');
INSERT INTO `geo_country_reference` VALUES (222, 'United Kingdom', 'GB', 'GBR');
INSERT INTO `geo_country_reference` VALUES (223, 'United States', 'US', 'USA');
INSERT INTO `geo_country_reference` VALUES (224, 'United States Minor Outlying Islands', 'UM', 'UMI');
INSERT INTO `geo_country_reference` VALUES (225, 'Uruguay', 'UY', 'URY');
INSERT INTO `geo_country_reference` VALUES (226, 'Uzbekistan', 'UZ', 'UZB');
INSERT INTO `geo_country_reference` VALUES (227, 'Vanuatu', 'VU', 'VUT');
INSERT INTO `geo_country_reference` VALUES (228, 'Vatican City State (Holy See)', 'VA', 'VAT');
INSERT INTO `geo_country_reference` VALUES (229, 'Venezuela', 'VE', 'VEN');
INSERT INTO `geo_country_reference` VALUES (230, 'Viet Nam', 'VN', 'VNM');
INSERT INTO `geo_country_reference` VALUES (231, 'Virgin Islands (British)', 'VG', 'VGB');
INSERT INTO `geo_country_reference` VALUES (232, 'Virgin Islands (U.S.)', 'VI', 'VIR');
INSERT INTO `geo_country_reference` VALUES (233, 'Wallis and Futuna Islands', 'WF', 'WLF');
INSERT INTO `geo_country_reference` VALUES (234, 'Western Sahara', 'EH', 'ESH');
INSERT INTO `geo_country_reference` VALUES (235, 'Yemen', 'YE', 'YEM');
INSERT INTO `geo_country_reference` VALUES (236, 'Yugoslavia', 'YU', 'YUG');
INSERT INTO `geo_country_reference` VALUES (237, 'Zaire', 'ZR', 'ZAR');
INSERT INTO `geo_country_reference` VALUES (238, 'Zambia', 'ZM', 'ZMB');
INSERT INTO `geo_country_reference` VALUES (239, 'Zimbabwe', 'ZW', 'ZWE');

-- --------------------------------------------------------

-- 
-- Table structure for table `geo_zone_reference`
-- 

DROP TABLE IF EXISTS `geo_zone_reference`;
CREATE TABLE `geo_zone_reference` (
  `zone_id` int(5) NOT NULL auto_increment,
  `zone_country_id` int(5) NOT NULL default '0',
  `zone_code` varchar(5) default NULL,
  `zone_name` varchar(32) default NULL,
  PRIMARY KEY  (`zone_id`)
) ENGINE=MyISAM AUTO_INCREMENT=83 ;

-- 
-- Dumping data for table `geo_zone_reference`
-- 

INSERT INTO `geo_zone_reference` VALUES (1, 223, 'AL', 'Alabama');
INSERT INTO `geo_zone_reference` VALUES (2, 223, 'AK', 'Alaska');
INSERT INTO `geo_zone_reference` VALUES (3, 223, 'AS', 'American Samoa');
INSERT INTO `geo_zone_reference` VALUES (4, 223, 'AZ', 'Arizona');
INSERT INTO `geo_zone_reference` VALUES (5, 223, 'AR', 'Arkansas');
INSERT INTO `geo_zone_reference` VALUES (6, 223, 'AF', 'Armed Forces Africa');
INSERT INTO `geo_zone_reference` VALUES (7, 223, 'AA', 'Armed Forces Americas');
INSERT INTO `geo_zone_reference` VALUES (8, 223, 'AC', 'Armed Forces Canada');
INSERT INTO `geo_zone_reference` VALUES (9, 223, 'AE', 'Armed Forces Europe');
INSERT INTO `geo_zone_reference` VALUES (10, 223, 'AM', 'Armed Forces Middle East');
INSERT INTO `geo_zone_reference` VALUES (11, 223, 'AP', 'Armed Forces Pacific');
INSERT INTO `geo_zone_reference` VALUES (12, 223, 'CA', 'California');
INSERT INTO `geo_zone_reference` VALUES (13, 223, 'CO', 'Colorado');
INSERT INTO `geo_zone_reference` VALUES (14, 223, 'CT', 'Connecticut');
INSERT INTO `geo_zone_reference` VALUES (15, 223, 'DE', 'Delaware');
INSERT INTO `geo_zone_reference` VALUES (16, 223, 'DC', 'District of Columbia');
INSERT INTO `geo_zone_reference` VALUES (17, 223, 'FM', 'Federated States Of Micronesia');
INSERT INTO `geo_zone_reference` VALUES (18, 223, 'FL', 'Florida');
INSERT INTO `geo_zone_reference` VALUES (19, 223, 'GA', 'Georgia');
INSERT INTO `geo_zone_reference` VALUES (20, 223, 'GU', 'Guam');
INSERT INTO `geo_zone_reference` VALUES (21, 223, 'HI', 'Hawaii');
INSERT INTO `geo_zone_reference` VALUES (22, 223, 'ID', 'Idaho');
INSERT INTO `geo_zone_reference` VALUES (23, 223, 'IL', 'Illinois');
INSERT INTO `geo_zone_reference` VALUES (24, 223, 'IN', 'Indiana');
INSERT INTO `geo_zone_reference` VALUES (25, 223, 'IA', 'Iowa');
INSERT INTO `geo_zone_reference` VALUES (26, 223, 'KS', 'Kansas');
INSERT INTO `geo_zone_reference` VALUES (27, 223, 'KY', 'Kentucky');
INSERT INTO `geo_zone_reference` VALUES (28, 223, 'LA', 'Louisiana');
INSERT INTO `geo_zone_reference` VALUES (29, 223, 'ME', 'Maine');
INSERT INTO `geo_zone_reference` VALUES (30, 223, 'MH', 'Marshall Islands');
INSERT INTO `geo_zone_reference` VALUES (31, 223, 'MD', 'Maryland');
INSERT INTO `geo_zone_reference` VALUES (32, 223, 'MA', 'Massachusetts');
INSERT INTO `geo_zone_reference` VALUES (33, 223, 'MI', 'Michigan');
INSERT INTO `geo_zone_reference` VALUES (34, 223, 'MN', 'Minnesota');
INSERT INTO `geo_zone_reference` VALUES (35, 223, 'MS', 'Mississippi');
INSERT INTO `geo_zone_reference` VALUES (36, 223, 'MO', 'Missouri');
INSERT INTO `geo_zone_reference` VALUES (37, 223, 'MT', 'Montana');
INSERT INTO `geo_zone_reference` VALUES (38, 223, 'NE', 'Nebraska');
INSERT INTO `geo_zone_reference` VALUES (39, 223, 'NV', 'Nevada');
INSERT INTO `geo_zone_reference` VALUES (40, 223, 'NH', 'New Hampshire');
INSERT INTO `geo_zone_reference` VALUES (41, 223, 'NJ', 'New Jersey');
INSERT INTO `geo_zone_reference` VALUES (42, 223, 'NM', 'New Mexico');
INSERT INTO `geo_zone_reference` VALUES (43, 223, 'NY', 'New York');
INSERT INTO `geo_zone_reference` VALUES (44, 223, 'NC', 'North Carolina');
INSERT INTO `geo_zone_reference` VALUES (45, 223, 'ND', 'North Dakota');
INSERT INTO `geo_zone_reference` VALUES (46, 223, 'MP', 'Northern Mariana Islands');
INSERT INTO `geo_zone_reference` VALUES (47, 223, 'OH', 'Ohio');
INSERT INTO `geo_zone_reference` VALUES (48, 223, 'OK', 'Oklahoma');
INSERT INTO `geo_zone_reference` VALUES (49, 223, 'OR', 'Oregon');
INSERT INTO `geo_zone_reference` VALUES (50, 223, 'PW', 'Palau');
INSERT INTO `geo_zone_reference` VALUES (51, 223, 'PA', 'Pennsylvania');
INSERT INTO `geo_zone_reference` VALUES (52, 223, 'PR', 'Puerto Rico');
INSERT INTO `geo_zone_reference` VALUES (53, 223, 'RI', 'Rhode Island');
INSERT INTO `geo_zone_reference` VALUES (54, 223, 'SC', 'South Carolina');
INSERT INTO `geo_zone_reference` VALUES (55, 223, 'SD', 'South Dakota');
INSERT INTO `geo_zone_reference` VALUES (56, 223, 'TN', 'Tenessee');
INSERT INTO `geo_zone_reference` VALUES (57, 223, 'TX', 'Texas');
INSERT INTO `geo_zone_reference` VALUES (58, 223, 'UT', 'Utah');
INSERT INTO `geo_zone_reference` VALUES (59, 223, 'VT', 'Vermont');
INSERT INTO `geo_zone_reference` VALUES (60, 223, 'VI', 'Virgin Islands');
INSERT INTO `geo_zone_reference` VALUES (61, 223, 'VA', 'Virginia');
INSERT INTO `geo_zone_reference` VALUES (62, 223, 'WA', 'Washington');
INSERT INTO `geo_zone_reference` VALUES (63, 223, 'WV', 'West Virginia');
INSERT INTO `geo_zone_reference` VALUES (64, 223, 'WI', 'Wisconsin');
INSERT INTO `geo_zone_reference` VALUES (65, 223, 'WY', 'Wyoming');
INSERT INTO `geo_zone_reference` VALUES (66, 38, 'AB', 'Alberta');
INSERT INTO `geo_zone_reference` VALUES (67, 38, 'BC', 'British Columbia');
INSERT INTO `geo_zone_reference` VALUES (68, 38, 'MB', 'Manitoba');
INSERT INTO `geo_zone_reference` VALUES (69, 38, 'NF', 'Newfoundland');
INSERT INTO `geo_zone_reference` VALUES (70, 38, 'NB', 'New Brunswick');
INSERT INTO `geo_zone_reference` VALUES (71, 38, 'NS', 'Nova Scotia');
INSERT INTO `geo_zone_reference` VALUES (72, 38, 'NT', 'Northwest Territories');
INSERT INTO `geo_zone_reference` VALUES (73, 38, 'NU', 'Nunavut');
INSERT INTO `geo_zone_reference` VALUES (74, 38, 'ON', 'Ontario');
INSERT INTO `geo_zone_reference` VALUES (75, 38, 'PE', 'Prince Edward Island');
INSERT INTO `geo_zone_reference` VALUES (76, 38, 'QC', 'Quebec');
INSERT INTO `geo_zone_reference` VALUES (77, 38, 'SK', 'Saskatchewan');
INSERT INTO `geo_zone_reference` VALUES (78, 38, 'YT', 'Yukon Territory');
INSERT INTO `geo_zone_reference` VALUES (79, 61, 'QLD', 'Queensland');
INSERT INTO `geo_zone_reference` VALUES (80, 61, 'SA', 'South Australia');
INSERT INTO `geo_zone_reference` VALUES (81, 61, 'ACT', 'Australian Capital Territory');
INSERT INTO `geo_zone_reference` VALUES (82, 61, 'VIC', 'Victoria');

-- --------------------------------------------------------

-- 
-- Table structure for table `groups`
-- 

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` longtext,
  `user` longtext,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `history_data`
-- 

DROP TABLE IF EXISTS `history_data`;
CREATE TABLE `history_data` (
  `id` bigint(20) NOT NULL auto_increment,
  `coffee` longtext,
  `tobacco` longtext,
  `alcohol` longtext,
  `sleep_patterns` longtext,
  `exercise_patterns` longtext,
  `seatbelt_use` longtext,
  `counseling` longtext,
  `hazardous_activities` longtext,
  `recreational_drugs` longtext,
  `last_breast_exam` varchar(255) default NULL,
  `last_mammogram` varchar(255) default NULL,
  `last_gynocological_exam` varchar(255) default NULL,
  `last_rectal_exam` varchar(255) default NULL,
  `last_prostate_exam` varchar(255) default NULL,
  `last_physical_exam` varchar(255) default NULL,
  `last_sigmoidoscopy_colonoscopy` varchar(255) default NULL,
  `last_ecg` varchar(255) default NULL,
  `last_cardiac_echo` varchar(255) default NULL,
  `last_retinal` varchar(255) default NULL,
  `last_fluvax` varchar(255) default NULL,
  `last_pneuvax` varchar(255) default NULL,
  `last_ldl` varchar(255) default NULL,
  `last_hemoglobin` varchar(255) default NULL,
  `last_psa` varchar(255) default NULL,
  `last_exam_results` varchar(255) default NULL,
  `history_mother` longtext,
  `history_father` longtext,
  `history_siblings` longtext,
  `history_offspring` longtext,
  `history_spouse` longtext,
  `relatives_cancer` longtext,
  `relatives_tuberculosis` longtext,
  `relatives_diabetes` longtext,
  `relatives_high_blood_pressure` longtext,
  `relatives_heart_problems` longtext,
  `relatives_stroke` longtext,
  `relatives_epilepsy` longtext,
  `relatives_mental_illness` longtext,
  `relatives_suicide` longtext,
  `cataract_surgery` datetime default NULL,
  `tonsillectomy` datetime default NULL,
  `cholecystestomy` datetime default NULL,
  `heart_surgery` datetime default NULL,
  `hysterectomy` datetime default NULL,
  `hernia_repair` datetime default NULL,
  `hip_replacement` datetime default NULL,
  `knee_replacement` datetime default NULL,
  `appendectomy` datetime default NULL,
  `date` datetime default NULL,
  `pid` bigint(20) NOT NULL default '0',
  `name_1` varchar(255) default NULL,
  `value_1` varchar(255) default NULL,
  `name_2` varchar(255) default NULL,
  `value_2` varchar(255) default NULL,
  `additional_history` text,
  `exams`      text         NOT NULL DEFAULT '',
  `usertext11` varchar(255) NOT NULL DEFAULT '',
  `usertext12` varchar(255) NOT NULL DEFAULT '',
  `usertext13` varchar(255) NOT NULL DEFAULT '',
  `usertext14` varchar(255) NOT NULL DEFAULT '',
  `usertext15` varchar(255) NOT NULL DEFAULT '',
  `usertext16` varchar(255) NOT NULL DEFAULT '',
  `usertext17` varchar(255) NOT NULL DEFAULT '',
  `usertext18` varchar(255) NOT NULL DEFAULT '',
  `usertext19` varchar(255) NOT NULL DEFAULT '',
  `usertext20` varchar(255) NOT NULL DEFAULT '',
  `usertext21` varchar(255) NOT NULL DEFAULT '',
  `usertext22` varchar(255) NOT NULL DEFAULT '',
  `usertext23` varchar(255) NOT NULL DEFAULT '',
  `usertext24` varchar(255) NOT NULL DEFAULT '',
  `usertext25` varchar(255) NOT NULL DEFAULT '',
  `usertext26` varchar(255) NOT NULL DEFAULT '',
  `usertext27` varchar(255) NOT NULL DEFAULT '',
  `usertext28` varchar(255) NOT NULL DEFAULT '',
  `usertext29` varchar(255) NOT NULL DEFAULT '',
  `usertext30` varchar(255) NOT NULL DEFAULT '',
  `userdate11` date DEFAULT NULL,
  `userdate12` date DEFAULT NULL,
  `userdate13` date DEFAULT NULL,
  `userdate14` date DEFAULT NULL,
  `userdate15` date DEFAULT NULL,
  `userarea11` text NOT NULL DEFAULT '',
  `userarea12` text NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `immunizations`
-- 

DROP TABLE IF EXISTS `immunizations`;
CREATE TABLE `immunizations` (
  `id` bigint(20) NOT NULL auto_increment,
  `patient_id` int(11) default NULL,
  `administered_date` date default NULL,
  `immunization_id` int(11) default NULL,
  `manufacturer` varchar(100) default NULL,
  `lot_number` varchar(50) default NULL,
  `administered_by_id` bigint(20) default NULL,
  `administered_by` VARCHAR( 255 ) default NULL COMMENT 'Alternative to administered_by_id',
  `education_date` date default NULL,
  `vis_date` date default NULL COMMENT 'Date of VIS Statement', 
  `note` text,
  `create_date` datetime default NULL,
  `update_date` timestamp NOT NULL,
  `created_by` bigint(20) default NULL,
  `updated_by` bigint(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `insurance_companies`
-- 

DROP TABLE IF EXISTS `insurance_companies`;
CREATE TABLE `insurance_companies` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(255) default NULL,
  `attn` varchar(255) default NULL,
  `cms_id` varchar(15) default NULL,
  `freeb_type` tinyint(2) default NULL,
  `x12_receiver_id` varchar(25) default NULL,
  `x12_default_partner_id` int(11) default NULL,
  `alt_cms_id` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `insurance_data`
-- 

DROP TABLE IF EXISTS `insurance_data`;
CREATE TABLE `insurance_data` (
  `id` bigint(20) NOT NULL auto_increment,
  `type` enum('primary','secondary','tertiary') default NULL,
  `provider` varchar(255) default NULL,
  `plan_name` varchar(255) default NULL,
  `policy_number` varchar(255) default NULL,
  `group_number` varchar(255) default NULL,
  `subscriber_lname` varchar(255) default NULL,
  `subscriber_mname` varchar(255) default NULL,
  `subscriber_fname` varchar(255) default NULL,
  `subscriber_relationship` varchar(255) default NULL,
  `subscriber_ss` varchar(255) default NULL,
  `subscriber_DOB` date default NULL,
  `subscriber_street` varchar(255) default NULL,
  `subscriber_postal_code` varchar(255) default NULL,
  `subscriber_city` varchar(255) default NULL,
  `subscriber_state` varchar(255) default NULL,
  `subscriber_country` varchar(255) default NULL,
  `subscriber_phone` varchar(255) default NULL,
  `subscriber_employer` varchar(255) default NULL,
  `subscriber_employer_street` varchar(255) default NULL,
  `subscriber_employer_postal_code` varchar(255) default NULL,
  `subscriber_employer_state` varchar(255) default NULL,
  `subscriber_employer_country` varchar(255) default NULL,
  `subscriber_employer_city` varchar(255) default NULL,
  `copay` varchar(255) default NULL,
  `date` date NOT NULL default '0000-00-00',
  `pid` bigint(20) NOT NULL default '0',
  `subscriber_sex` varchar(25) default NULL,
  `accept_assignment` varchar(5) NOT NULL DEFAULT 'TRUE',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `pid_type_date` (`pid`,`type`,`date`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `insurance_numbers`
-- 

DROP TABLE IF EXISTS `insurance_numbers`;
CREATE TABLE `insurance_numbers` (
  `id` int(11) NOT NULL default '0',
  `provider_id` int(11) NOT NULL default '0',
  `insurance_company_id` int(11) default NULL,
  `provider_number` varchar(20) default NULL,
  `rendering_provider_number` varchar(20) default NULL,
  `group_number` varchar(20) default NULL,
  `provider_number_type` varchar(4) default NULL,
  `rendering_provider_number_type` varchar(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `integration_mapping`
-- 

DROP TABLE IF EXISTS `integration_mapping`;
CREATE TABLE `integration_mapping` (
  `id` int(11) NOT NULL default '0',
  `foreign_id` int(11) NOT NULL default '0',
  `foreign_table` varchar(125) default NULL,
  `local_id` int(11) NOT NULL default '0',
  `local_table` varchar(125) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `foreign_id` (`foreign_id`,`foreign_table`,`local_id`,`local_table`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `issue_encounter`
-- 

DROP TABLE IF EXISTS `issue_encounter`;
CREATE TABLE `issue_encounter` (
  `pid` int(11) NOT NULL,
  `list_id` int(11) NOT NULL,
  `encounter` int(11) NOT NULL,
  `resolved` tinyint(1) NOT NULL,
  PRIMARY KEY  (`pid`,`list_id`,`encounter`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `lang_constants`
-- 

DROP TABLE IF EXISTS `lang_constants`;
CREATE TABLE `lang_constants` (
  `cons_id` int(11) NOT NULL auto_increment,
  `constant_name` varchar(255) BINARY default NULL,
  UNIQUE KEY `cons_id` (`cons_id`),
  KEY `constant_name` (`constant_name`)
) ENGINE=MyISAM ;

-- 
-- Table structure for table `lang_definitions`
-- 

DROP TABLE IF EXISTS `lang_definitions`;
CREATE TABLE `lang_definitions` (
  `def_id` int(11) NOT NULL auto_increment,
  `cons_id` int(11) NOT NULL default '0',
  `lang_id` int(11) NOT NULL default '0',
  `definition` mediumtext,
  UNIQUE KEY `def_id` (`def_id`),
  KEY `cons_id` (`cons_id`)
) ENGINE=MyISAM ;

-- 
-- Table structure for table `lang_languages`
-- 

DROP TABLE IF EXISTS `lang_languages`;
CREATE TABLE `lang_languages` (
  `lang_id` int(11) NOT NULL auto_increment,
  `lang_code` char(2) NOT NULL default '',
  `lang_description` varchar(100) default NULL,
  UNIQUE KEY `lang_id` (`lang_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `lang_languages`
-- 

INSERT INTO `lang_languages` VALUES (1, 'en', 'English');

-- --------------------------------------------------------

--
-- Table structure for table `lang_custom`
--

DROP TABLE IF EXISTS `lang_custom`;
CREATE TABLE `lang_custom` (
  `lang_description` varchar(100) NOT NULL default '',
  `lang_code` char(2) NOT NULL default '',
  `constant_name` varchar(255) NOT NULL default '',
  `definition` mediumtext NOT NULL default ''
) ENGINE=MyISAM ;

-- --------------------------------------------------------

-- 
-- Table structure for table `layout_options`
-- 

DROP TABLE IF EXISTS `layout_options`;
CREATE TABLE `layout_options` (
  `form_id` varchar(31) NOT NULL default '',
  `field_id` varchar(31) NOT NULL default '',
  `group_name` varchar(31) NOT NULL default '',
  `title` varchar(63) NOT NULL default '',
  `seq` int(11) NOT NULL default '0',
  `data_type` tinyint(3) NOT NULL default '0',
  `uor` tinyint(1) NOT NULL default '1',
  `fld_length` int(11) NOT NULL default '15',
  `max_length` int(11) NOT NULL default '0',
  `list_id` varchar(31) NOT NULL default '',
  `titlecols` tinyint(3) NOT NULL default '1',
  `datacols` tinyint(3) NOT NULL default '1',
  `default_value` varchar(255) NOT NULL default '',
  `edit_options` varchar(36) NOT NULL default '',
  `description` text,
  PRIMARY KEY  (`form_id`,`field_id`,`seq`)
) ENGINE=MyISAM;

-- 
-- Dumping data for table `layout_options`
-- 
INSERT INTO `layout_options` VALUES ('DEM', 'title', '1Who', 'Name', 1, 1, 1, 0, 0, 'titles', 1, 1, '', 'N', 'Title');
INSERT INTO `layout_options` VALUES ('DEM', 'fname', '1Who', '', 2, 2, 2, 10, 63, '', 0, 0, '', 'CD', 'First Name');
INSERT INTO `layout_options` VALUES ('DEM', 'mname', '1Who', '', 3, 2, 1, 2, 63, '', 0, 0, '', 'C', 'Middle Name');
INSERT INTO `layout_options` VALUES ('DEM', 'lname', '1Who', '', 4, 2, 2, 10, 63, '', 0, 0, '', 'CD', 'Last Name');
INSERT INTO `layout_options` VALUES ('DEM', 'pubpid', '1Who', 'External ID', 5, 2, 1, 10, 15, '', 1, 1, '', 'ND', 'External identifier');
INSERT INTO `layout_options` VALUES ('DEM', 'DOB', '1Who', 'DOB', 6, 4, 2, 10, 10, '', 1, 1, '', 'D', 'Date of Birth');
INSERT INTO `layout_options` VALUES ('DEM', 'sex', '1Who', 'Sex', 7, 1, 2, 0, 0, 'sex', 1, 1, '', 'N', 'Sex');
INSERT INTO `layout_options` VALUES ('DEM', 'ss', '1Who', 'S.S.', 8, 2, 1, 11, 11, '', 1, 1, '', '', 'Social Security Number');
INSERT INTO `layout_options` VALUES ('DEM', 'drivers_license', '1Who', 'License/ID', 9, 2, 1, 15, 63, '', 1, 1, '', '', 'Drivers License or State ID');
INSERT INTO `layout_options` VALUES ('DEM', 'status', '1Who', 'Marital Status', 10, 1, 1, 0, 0, 'marital', 1, 3, '', '', 'Marital Status');
INSERT INTO `layout_options` VALUES ('DEM', 'genericname1', '1Who', 'User Defined', 11, 2, 1, 15, 63, '', 1, 3, '', '', 'User Defined Field');
INSERT INTO `layout_options` VALUES ('DEM', 'genericval1', '1Who', '', 12, 2, 1, 15, 63, '', 0, 0, '', '', 'User Defined Field');
INSERT INTO `layout_options` VALUES ('DEM', 'genericname2', '1Who', '', 13, 2, 1, 15, 63, '', 0, 0, '', '', 'User Defined Field');
INSERT INTO `layout_options` VALUES ('DEM', 'genericval2', '1Who', '', 14, 2, 1, 15, 63, '', 0, 0, '', '', 'User Defined Field');
INSERT INTO `layout_options` VALUES ('DEM', 'squad', '1Who', 'Squad', 15, 13, 0, 0, 0, '', 1, 3, '', '', 'Squad Membership');
INSERT INTO `layout_options` VALUES ('DEM', 'pricelevel', '1Who', 'Price Level', 16, 1, 0, 0, 0, 'pricelevel', 1, 1, '', '', 'Discount Level');
INSERT INTO `layout_options` VALUES ('DEM', 'street', '2Contact', 'Address', 1, 2, 1, 25, 63, '', 1, 1, '', 'C', 'Street and Number');
INSERT INTO `layout_options` VALUES ('DEM', 'city', '2Contact', 'City', 2, 2, 1, 15, 63, '', 1, 1, '', 'C', 'City Name');
INSERT INTO `layout_options` VALUES ('DEM', 'state', '2Contact', 'State', 3, 26, 1, 0, 0, 'state', 1, 1, '', '', 'State/Locality');
INSERT INTO `layout_options` VALUES ('DEM', 'postal_code', '2Contact', 'Postal Code', 4, 2, 1, 6, 63, '', 1, 1, '', '', 'Postal Code');
INSERT INTO `layout_options` VALUES ('DEM', 'country_code', '2Contact', 'Country', 5, 26, 1, 0, 0, 'country', 1, 1, '', '', 'Country');
INSERT INTO `layout_options` VALUES ('DEM', 'mothersname', '2Contact', 'Mother''s Name', 6, 2, 1, 20, 63, '', 1, 1, '', '', '');
INSERT INTO `layout_options` VALUES ('DEM', 'guardiansname', '2Contact', 'Guardian''s Name', 7, 2, 1, 20, 63, '', 1, 1, '', '', '');
INSERT INTO `layout_options` VALUES ('DEM', 'contact_relationship', '2Contact', 'Emergency Contact', 8, 2, 1, 10, 63, '', 1, 1, '', 'C', 'Emergency Contact Person');
INSERT INTO `layout_options` VALUES ('DEM', 'phone_contact', '2Contact', 'Emergency Phone', 9, 2, 1, 20, 63, '', 1, 1, '', 'P', 'Emergency Contact Phone Number');
INSERT INTO `layout_options` VALUES ('DEM', 'phone_home', '2Contact', 'Home Phone', 10, 2, 1, 20, 63, '', 1, 1, '', 'P', 'Home Phone Number');
INSERT INTO `layout_options` VALUES ('DEM', 'phone_biz', '2Contact', 'Work Phone', 11, 2, 1, 20, 63, '', 1, 1, '', 'P', 'Work Phone Number');
INSERT INTO `layout_options` VALUES ('DEM', 'phone_cell', '2Contact', 'Mobile Phone', 12, 2, 1, 20, 63, '', 1, 1, '', 'P', 'Cell Phone Number');
INSERT INTO `layout_options` VALUES ('DEM', 'email', '2Contact', 'Contact Email', 13, 2, 1, 30, 95, '', 1, 1, '', '', 'Contact Email Address');
INSERT INTO `layout_options` VALUES ('DEM', 'providerID', '3Choices', 'Provider', 1, 11, 1, 0, 0, '', 1, 3, '', '', 'Referring Provider');
INSERT INTO `layout_options` VALUES ('DEM', 'pharmacy_id', '3Choices', 'Pharmacy', 2, 12, 1, 0, 0, '', 1, 3, '', '', 'Preferred Pharmacy');
INSERT INTO `layout_options` VALUES ('DEM', 'hipaa_notice', '3Choices', 'HIPAA Notice Received', 3, 1, 1, 0, 0, 'yesno', 1, 1, '', '', 'Did you receive a copy of the HIPAA Notice?');
INSERT INTO `layout_options` VALUES ('DEM', 'hipaa_voice', '3Choices', 'Allow Voice Message', 4, 1, 1, 0, 0, 'yesno', 1, 1, '', '', 'Allow telephone messages?');
INSERT INTO `layout_options` VALUES ('DEM', 'hipaa_message', '3Choices', 'Leave Message With', 5, 2, 1, 20, 63, '', 1, 1, '', '', 'With whom may we leave a message?');
INSERT INTO `layout_options` VALUES ('DEM', 'hipaa_mail', '3Choices', 'Allow Mail Message', 6, 1, 1, 0, 0, 'yesno', 1, 1, '', '', 'Allow email messages?');
INSERT INTO `layout_options` VALUES ('DEM', 'hipaa_allowsms'  , '3Choices', 'Allow SMS'  , 7, 1, 1, 0, 0, 'yesno', 1, 1, '', '', 'Allow SMS (text messages)?');
INSERT INTO `layout_options` VALUES ('DEM', 'hipaa_allowemail', '3Choices', 'Allow Email', 8, 1, 1, 0, 0, 'yesno', 1, 1, '', '', 'Allow Email?');

INSERT INTO `layout_options` VALUES ('DEM', 'allow_imm_reg_use', '3Choices', 'Allow Immunization Registry Use', 9, 1, 1, 0, 0, 'yesno', 1, 1, '', '', '');
INSERT INTO `layout_options` VALUES ('DEM', 'allow_imm_info_share', '3Choices', 'Allow Immunization Info Sharing', 10, 1, 1, 0, 0, 'yesno', 1, 1, '', '', '');
INSERT INTO `layout_options` VALUES ('DEM', 'allow_health_info_ex', '3Choices', 'Allow Health Information Exchange', 11, 1, 1, 0, 0, 'yesno', 1, 1, '', '', '');
INSERT INTO `layout_options` VALUES ('DEM', 'occupation', '4Employer', 'Occupation', 1, 2, 1, 20, 63, '', 1, 1, '', 'C', 'Occupation');
INSERT INTO `layout_options` VALUES ('DEM', 'em_name', '4Employer', 'Employer Name', 2, 2, 1, 20, 63, '', 1, 1, '', 'C', 'Employer Name');
INSERT INTO `layout_options` VALUES ('DEM', 'em_street', '4Employer', 'Employer Address', 3, 2, 1, 25, 63, '', 1, 1, '', 'C', 'Street and Number');
INSERT INTO `layout_options` VALUES ('DEM', 'em_city', '4Employer', 'City', 4, 2, 1, 15, 63, '', 1, 1, '', 'C', 'City Name');
INSERT INTO `layout_options` VALUES ('DEM', 'em_state', '4Employer', 'State', 5, 26, 1, 0, 0, 'state', 1, 1, '', '', 'State/Locality');
INSERT INTO `layout_options` VALUES ('DEM', 'em_postal_code', '4Employer', 'Postal Code', 6, 2, 1, 6, 63, '', 1, 1, '', '', 'Postal Code');
INSERT INTO `layout_options` VALUES ('DEM', 'em_country', '4Employer', 'Country', 7, 26, 1, 0, 0, 'country', 1, 1, '', '', 'Country');
INSERT INTO `layout_options` VALUES ('DEM', 'language', '5Stats', 'Language', 1, 26, 1, 0, 0, 'language', 1, 1, '', '', 'Preferred Language');
INSERT INTO `layout_options` VALUES ('DEM', 'ethnicity', '5Stats', 'Ethnicity', 2, 33, 1, 0, 0, 'ethnicity', 1, 1, '', '', 'Ethnicity');
INSERT INTO `layout_options` VALUES ('DEM', 'race', '5Stats', 'Race', 3, 33, 1, 0, 0, 'race', 1, 1, '', '', 'Race');
INSERT INTO `layout_options` VALUES ('DEM', 'financial_review', '5Stats', 'Financial Review Date', 4, 2, 1, 10, 10, '', 1, 1, '', 'D', 'Financial Review Date');
INSERT INTO `layout_options` VALUES ('DEM', 'family_size', '5Stats', 'Family Size', 4, 2, 1, 20, 63, '', 1, 1, '', '', 'Family Size');
INSERT INTO `layout_options` VALUES ('DEM', 'monthly_income', '5Stats', 'Monthly Income', 5, 2, 1, 20, 63, '', 1, 1, '', '', 'Monthly Income');
INSERT INTO `layout_options` VALUES ('DEM', 'homeless', '5Stats', 'Homeless, etc.', 6, 2, 1, 20, 63, '', 1, 1, '', '', 'Homeless or similar?');
INSERT INTO `layout_options` VALUES ('DEM', 'interpretter', '5Stats', 'Interpreter', 7, 2, 1, 20, 63, '', 1, 1, '', '', 'Interpreter needed?');
INSERT INTO `layout_options` VALUES ('DEM', 'migrantseasonal', '5Stats', 'Migrant/Seasonal', 8, 2, 1, 20, 63, '', 1, 1, '', '', 'Migrant or seasonal worker?');
INSERT INTO `layout_options` VALUES ('DEM', 'contrastart', '5Stats', 'Contraceptives Start',9,4,0,10,10,'',1,1,'','','Date contraceptive services initially provided');
INSERT INTO `layout_options` VALUES ('DEM', 'referral_source', '5Stats', 'Referral Source',10, 26, 1, 0, 0, 'refsource', 1, 1, '', '', 'How did they hear about us');
INSERT INTO `layout_options` VALUES ('DEM', 'vfc', '5Stats', 'VFC', 12, 1, 1, 20, 0, 'eligibility', 1, 1, '', '', 'Eligibility status for Vaccine for Children supplied vaccine');
INSERT INTO `layout_options` VALUES ('DEM', 'usertext1', '6Misc', 'User Defined Text 1', 1, 2, 0, 10, 63, '', 1, 1, '', '', 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'usertext2', '6Misc', 'User Defined Text 2', 2, 2, 0, 10, 63, '', 1, 1, '', '', 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'usertext3', '6Misc', 'User Defined Text 3', 3,2,0,10,63,'',1,1,'','','User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'usertext4', '6Misc', 'User Defined Text 4', 4,2,0,10,63,'',1,1,'','','User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'usertext5', '6Misc', 'User Defined Text 5', 5,2,0,10,63,'',1,1,'','','User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'usertext6', '6Misc', 'User Defined Text 6', 6,2,0,10,63,'',1,1,'','','User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'usertext7', '6Misc', 'User Defined Text 7', 7,2,0,10,63,'',1,1,'','','User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'usertext8', '6Misc', 'User Defined Text 8', 8,2,0,10,63,'',1,1,'','','User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'userlist1', '6Misc', 'User Defined List 1', 9, 1, 0, 0, 0, 'userlist1', 1, 1, '', '', 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'userlist2', '6Misc', 'User Defined List 2',10, 1, 0, 0, 0, 'userlist2', 1, 1, '', '', 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'userlist3', '6Misc', 'User Defined List 3',11, 1, 0, 0, 0, 'userlist3', 1, 1, '', '' , 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'userlist4', '6Misc', 'User Defined List 4',12, 1, 0, 0, 0, 'userlist4', 1, 1, '', '' , 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'userlist5', '6Misc', 'User Defined List 5',13, 1, 0, 0, 0, 'userlist5', 1, 1, '', '' , 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'userlist6', '6Misc', 'User Defined List 6',14, 1, 0, 0, 0, 'userlist6', 1, 1, '', '' , 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'userlist7', '6Misc', 'User Defined List 7',15, 1, 0, 0, 0, 'userlist7', 1, 1, '', '' , 'User Defined');
INSERT INTO `layout_options` VALUES ('DEM', 'regdate'  , '6Misc', 'Registration Date'  ,16, 4, 0,10,10, ''         , 1, 1, '', 'D', 'Start Date at This Clinic');


INSERT INTO layout_options VALUES ('REF','refer_date'      ,'1Referral','Referral Date'                  , 1, 4,2, 0,  0,''         ,1,1,'C','D','Date of referral');
INSERT INTO layout_options VALUES ('REF','refer_from'      ,'1Referral','Refer By'                       , 2,10,2, 0,  0,''         ,1,1,'' ,'' ,'Referral By');
INSERT INTO layout_options VALUES ('REF','refer_external'  ,'1Referral','External Referral'              , 3, 1,1, 0,  0,'boolean'  ,1,1,'' ,'' ,'External referral?');
INSERT INTO layout_options VALUES ('REF','refer_to'        ,'1Referral','Refer To'                       , 4,14,2, 0,  0,''         ,1,1,'' ,'' ,'Referral To');
INSERT INTO layout_options VALUES ('REF','body'            ,'1Referral','Reason'                         , 5, 3,2,30,  3,''         ,1,1,'' ,'' ,'Reason for referral');
INSERT INTO layout_options VALUES ('REF','refer_diag'      ,'1Referral','Referrer Diagnosis'             , 6, 2,1,30,255,''         ,1,1,'' ,'X','Referrer diagnosis');
INSERT INTO layout_options VALUES ('REF','refer_risk_level','1Referral','Risk Level'                     , 7, 1,1, 0,  0,'risklevel',1,1,'' ,'' ,'Level of urgency');
INSERT INTO layout_options VALUES ('REF','refer_vitals'    ,'1Referral','Include Vitals'                 , 8, 1,1, 0,  0,'boolean'  ,1,1,'' ,'' ,'Include vitals data?');
INSERT INTO layout_options VALUES ('REF','refer_related_code','1Referral','Requested Service'            , 9,15,1,30,255,''         ,1,1,'' ,'' ,'Billing Code for Requested Service');
INSERT INTO layout_options VALUES ('REF','reply_date'      ,'2Counter-Referral','Reply Date'             ,10, 4,1, 0,  0,''         ,1,1,'' ,'D','Date of reply');
INSERT INTO layout_options VALUES ('REF','reply_from'      ,'2Counter-Referral','Reply From'             ,11, 2,1,30,255,''         ,1,1,'' ,'' ,'Who replied?');
INSERT INTO layout_options VALUES ('REF','reply_init_diag' ,'2Counter-Referral','Presumed Diagnosis'     ,12, 2,1,30,255,''         ,1,1,'' ,'' ,'Presumed diagnosis by specialist');
INSERT INTO layout_options VALUES ('REF','reply_final_diag','2Counter-Referral','Final Diagnosis'        ,13, 2,1,30,255,''         ,1,1,'' ,'' ,'Final diagnosis by specialist');
INSERT INTO layout_options VALUES ('REF','reply_documents' ,'2Counter-Referral','Documents'              ,14, 2,1,30,255,''         ,1,1,'' ,'' ,'Where may related scanned or paper documents be found?');
INSERT INTO layout_options VALUES ('REF','reply_findings'  ,'2Counter-Referral','Findings'               ,15, 3,1,30,  3,''         ,1,1,'' ,'' ,'Findings by specialist');
INSERT INTO layout_options VALUES ('REF','reply_services'  ,'2Counter-Referral','Services Provided'      ,16, 3,1,30,  3,''         ,1,1,'' ,'' ,'Service provided by specialist');
INSERT INTO layout_options VALUES ('REF','reply_recommend' ,'2Counter-Referral','Recommendations'        ,17, 3,1,30,  3,''         ,1,1,'' ,'' ,'Recommendations by specialist');
INSERT INTO layout_options VALUES ('REF','reply_rx_refer'  ,'2Counter-Referral','Prescriptions/Referrals',18, 3,1,30,  3,''         ,1,1,'' ,'' ,'Prescriptions and/or referrals by specialist');

INSERT INTO layout_options VALUES ('HIS','usertext11','1General','Risk Factors',1,21,1,0,0,'riskfactors',1,1,'','' ,'Risk Factors');
INSERT INTO layout_options VALUES ('HIS','exams'     ,'1General','Exams/Tests' ,2,23,1,0,0,'exams'      ,1,1,'','' ,'Exam and test results');
INSERT INTO layout_options VALUES ('HIS','history_father'   ,'2Family History','Father'   ,1, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','history_mother'   ,'2Family History','Mother'   ,2, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','history_siblings' ,'2Family History','Siblings' ,3, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','history_spouse'   ,'2Family History','Spouse'   ,4, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','history_offspring','2Family History','Offspring',5, 2,1,20,255,'',1,3,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_cancer'             ,'3Relatives','Cancer'             ,1, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_tuberculosis'       ,'3Relatives','Tuberculosis'       ,2, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_diabetes'           ,'3Relatives','Diabetes'           ,3, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_high_blood_pressure','3Relatives','High Blood Pressure',4, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_heart_problems'     ,'3Relatives','Heart Problems'     ,5, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_stroke'             ,'3Relatives','Stroke'             ,6, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_epilepsy'           ,'3Relatives','Epilepsy'           ,7, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_mental_illness'     ,'3Relatives','Mental Illness'     ,8, 2,1,20,255,'',1,1,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','relatives_suicide'            ,'3Relatives','Suicide'            ,9, 2,1,20,255,'',1,3,'','' ,'');
INSERT INTO layout_options VALUES ('HIS','coffee'              ,'4Lifestyle','Coffee'              ,2,28,1,20,255,'',1,3,'','' ,'Caffeine consumption');
INSERT INTO layout_options VALUES ('HIS','tobacco'             ,'4Lifestyle','Tobacco'             ,1,32,1,0,255,'smoking_status',1,3,'','' ,'Tobacco use');
INSERT INTO layout_options VALUES ('HIS','alcohol'             ,'4Lifestyle','Alcohol'             ,3,28,1,20,255,'',1,3,'','' ,'Alcohol consumption');
INSERT INTO layout_options VALUES ('HIS','recreational_drugs'  ,'4Lifestyle','Recreational Drugs'  ,4,28,1,20,255,'',1,3,'','' ,'Recreational drug use');
INSERT INTO layout_options VALUES ('HIS','counseling'          ,'4Lifestyle','Counseling'          ,5,28,1,20,255,'',1,3,'','' ,'Counseling activities');
INSERT INTO layout_options VALUES ('HIS','exercise_patterns'   ,'4Lifestyle','Exercise Patterns'   ,6,28,1,20,255,'',1,3,'','' ,'Exercise patterns');
INSERT INTO layout_options VALUES ('HIS','hazardous_activities','4Lifestyle','Hazardous Activities',7,28,1,20,255,'',1,3,'','' ,'Hazardous activities');
INSERT INTO layout_options VALUES ('HIS','sleep_patterns'      ,'4Lifestyle','Sleep Patterns'      ,8, 2,1,20,255,'',1,3,'','' ,'Sleep patterns');
INSERT INTO layout_options VALUES ('HIS','seatbelt_use'        ,'4Lifestyle','Seatbelt Use'        ,9, 2,1,20,255,'',1,3,'','' ,'Seatbelt use');
INSERT INTO layout_options VALUES ('HIS','name_1'            ,'5Other','Name/Value'        ,1, 2,1,10,255,'',1,1,'','' ,'Name 1' );
INSERT INTO layout_options VALUES ('HIS','value_1'           ,'5Other',''                  ,2, 2,1,10,255,'',0,0,'','' ,'Value 1');
INSERT INTO layout_options VALUES ('HIS','name_2'            ,'5Other','Name/Value'        ,3, 2,1,10,255,'',1,1,'','' ,'Name 2' );
INSERT INTO layout_options VALUES ('HIS','value_2'           ,'5Other',''                  ,4, 2,1,10,255,'',0,0,'','' ,'Value 2');
INSERT INTO layout_options VALUES ('HIS','additional_history','5Other','Additional History',5, 3,1,30,  3,'',1,3,'' ,'' ,'Additional history notes');
INSERT INTO layout_options VALUES ('HIS','userarea11'        ,'5Other','User Defined Area 11',6,3,0,30,3,'',1,3,'','','User Defined');
INSERT INTO layout_options VALUES ('HIS','userarea12'        ,'5Other','User Defined Area 12',7,3,0,30,3,'',1,3,'','','User Defined');

-- --------------------------------------------------------

-- 
-- Table structure for table `list_options`
-- 

DROP TABLE IF EXISTS `list_options`;
CREATE TABLE `list_options` (
  `list_id` varchar(31) NOT NULL default '',
  `option_id` varchar(31) NOT NULL default '',
  `title` varchar(255) NOT NULL default '',
  `seq` int(11) NOT NULL default '0',
  `is_default` tinyint(1) NOT NULL default '0',
  `option_value` float NOT NULL default '0',
  `mapping` varchar(31) NOT NULL DEFAULT '',
  `notes` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY  (`list_id`,`option_id`)
) ENGINE=MyISAM;

-- 
-- Dumping data for table `list_options`
-- 

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('yesno', 'NO', 'NO', 1, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('yesno', 'YES', 'YES', 2, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('titles', 'Mr.', 'Mr.', 1, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('titles', 'Mrs.', 'Mrs.', 2, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('titles', 'Ms.', 'Ms.', 3, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('titles', 'Dr.', 'Dr.', 4, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('sex', 'Female', 'Female', 1, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('sex', 'Male', 'Male', 2, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('marital', 'married', 'Married', 1, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('marital', 'single', 'Single', 2, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('marital', 'divorced', 'Divorced', 3, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('marital', 'widowed', 'Widowed', 4, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('marital', 'separated', 'Separated', 5, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('marital', 'domestic partner', 'Domestic Partner', 6, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'armenian', 'Armenian', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'chinese', 'Chinese', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'danish', 'Danish', 30, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'deaf', 'Deaf', 40, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'English', 'English', 50, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'farsi', 'Farsi', 60, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'french', 'French', 70, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'german', 'German', 80, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'greek', 'Greek', 90, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'hmong', 'Hmong', 100, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'italian', 'Italian', 110, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'japanese', 'Japanese', 120, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'korean', 'Korean', 130, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'laotian', 'Laotian', 140, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'mien', 'Mien', 150, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'norwegian', 'Norwegian', 160, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'othrs', 'Others', 170, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'portuguese', 'Portuguese', 180, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'punjabi', 'Punjabi', 190, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'russian', 'Russian', 200, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'Spanish', 'Spanish', 210, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'tagalog', 'Tagalog', 220, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'turkish', 'Turkish', 230, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'vietnamese', 'Vietnamese', 240, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'yiddish', 'Yiddish', 250, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('language', 'zulu', 'Zulu', 260, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'aleut', 'ALEUT', 10,  0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'amer_indian', 'American Indian', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'Asian', 'Asian', 30, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'Black', 'Black', 40, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'cambodian', 'Cambodian', 50, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'Caucasian', 'Caucasian', 60, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'cs_american', 'Central/South American', 70, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'chinese', 'Chinese', 80, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'cuban', 'Cuban', 90, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'eskimo', 'Eskimo', 100, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'filipino', 'Filipino', 110, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'guamanian', 'Guamanian', 120, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'hawaiian', 'Hawaiian', 130, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'Hispanic', 'Hispanic', 140, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'othr_us', 'Hispanic - Other (Born in US)', 150, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'othr_non_us', 'Hispanic - Other (Born outside US)', 160, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'hmong', 'Hmong', 170, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'indian', 'Indian', 180, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'japanese', 'Japanese', 190, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'korean', 'Korean', 200, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'laotian', 'Laotian', 210, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'mexican', 'Mexican/MexAmer/Chicano', 220, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'mlt-race', 'Multiracial', 230, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'othr', 'Other', 240, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'othr_spec', 'Other - Specified', 250, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'pac_island', 'Pacific Islander', 260, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'puerto_rican', 'Puerto Rican', 270, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'refused', 'Refused To State', 280, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'samoan', 'Samoan', 290, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'spec', 'Specified', 300, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'thai', 'Thai', 310, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'unknown', 'Unknown', 320, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'unspec', 'Unspecified', 330, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'vietnamese', 'Vietnamese', 340, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'white', 'White', 350, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethrace', 'withheld', 'Withheld', 360, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('userlist1', 'sample', 'Sample', 1, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('userlist2', 'sample', 'Sample', 1, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('userlist3','sample','Sample',1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('userlist4','sample','Sample',1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('userlist5','sample','Sample',1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('userlist6','sample','Sample',1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('userlist7','sample','Sample',1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('pricelevel', 'standard', 'Standard', 1, 1);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('risklevel', 'low', 'Low', 1, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('risklevel', 'medium', 'Medium', 2, 1);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('risklevel', 'high', 'High', 3, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('boolean', '0', 'No', 1, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('boolean', '1', 'Yes', 2, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('country', 'USA', 'USA', 1, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','AL','Alabama'             , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','AK','Alaska'              , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','AZ','Arizona'             , 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','AR','Arkansas'            , 4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','CA','California'          , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','CO','Colorado'            , 6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','CT','Connecticut'         , 7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','DE','Delaware'            , 8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','DC','District of Columbia', 9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','FL','Florida'             ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','GA','Georgia'             ,11,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','HI','Hawaii'              ,12,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','ID','Idaho'               ,13,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','IL','Illinois'            ,14,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','IN','Indiana'             ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','IA','Iowa'                ,16,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','KS','Kansas'              ,17,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','KY','Kentucky'            ,18,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','LA','Louisiana'           ,19,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','ME','Maine'               ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','MD','Maryland'            ,21,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','MA','Massachusetts'       ,22,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','MI','Michigan'            ,23,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','MN','Minnesota'           ,24,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','MS','Mississippi'         ,25,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','MO','Missouri'            ,26,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','MT','Montana'             ,27,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','NE','Nebraska'            ,28,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','NV','Nevada'              ,29,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','NH','New Hampshire'       ,30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','NJ','New Jersey'          ,31,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','NM','New Mexico'          ,32,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','NY','New York'            ,33,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','NC','North Carolina'      ,34,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','ND','North Dakota'        ,35,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','OH','Ohio'                ,36,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','OK','Oklahoma'            ,37,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','OR','Oregon'              ,38,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','PA','Pennsylvania'        ,39,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','RI','Rhode Island'        ,40,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','SC','South Carolina'      ,41,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','SD','South Dakota'        ,42,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','TN','Tennessee'           ,43,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','TX','Texas'               ,44,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','UT','Utah'                ,45,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','VT','Vermont'             ,46,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','VA','Virginia'            ,47,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','WA','Washington'          ,48,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','WV','West Virginia'       ,49,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','WI','Wisconsin'           ,50,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('state','WY','Wyoming'             ,51,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Patient'      ,'Patient'      , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Employee'     ,'Employee'     , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Walk-In'      ,'Walk-In'      , 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Newspaper'    ,'Newspaper'    , 4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Radio'        ,'Radio'        , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','T.V.'         ,'T.V.'         , 6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Direct Mail'  ,'Direct Mail'  , 7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Coupon'       ,'Coupon'       , 8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Referral Card','Referral Card', 9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('refsource','Other'        ,'Other'        ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','vv' ,'Varicose Veins'                      , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','ht' ,'Hypertension'                        , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','db' ,'Diabetes'                            , 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','sc' ,'Sickle Cell'                         , 4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','fib','Fibroids'                            , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','pid','PID (Pelvic Inflammatory Disease)'   , 6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','mig','Severe Migraine'                     , 7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','hd' ,'Heart Disease'                       , 8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','str','Thrombosis/Stroke'                   , 9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','hep','Hepatitis'                           ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','gb' ,'Gall Bladder Condition'              ,11,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','br' ,'Breast Disease'                      ,12,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','dpr','Depression'                          ,13,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','all','Allergies'                           ,14,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','inf','Infertility'                         ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','ast','Asthma'                              ,16,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','ep' ,'Epilepsy'                            ,17,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','cl' ,'Contact Lenses'                      ,18,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','coc','Contraceptive Complication (specify)',19,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('riskfactors','oth','Other (specify)'                     ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'brs','Breast Exam'          , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'cec','Cardiac Echo'         , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'ecg','ECG'                  , 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'gyn','Gynecological Exam'   , 4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'mam','Mammogram'            , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'phy','Physical Exam'        , 6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'pro','Prostate Exam'        , 7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'rec','Rectal Exam'          , 8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'sic','Sigmoid/Colonoscopy'  , 9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'ret','Retinal Exam'         ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'flu','Flu Vaccination'      ,11,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'pne','Pneumonia Vaccination',12,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'ldl','LDL'                  ,13,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'hem','Hemoglobin'           ,14,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('exams' ,'psa','PSA'                  ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','0',''           ,0,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','1','suspension' ,1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','2','tablet'     ,2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','3','capsule'    ,3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','4','solution'   ,4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','5','tsp'        ,5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','6','ml'         ,6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','7','units'      ,7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','8','inhalations',8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','9','gtts(drops)',9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','10','cream'   ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_form','11','ointment',11,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','0',''          ,0,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','1','mg'    ,1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','2','mg/1cc',2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','3','mg/2cc',3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','4','mg/3cc',4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','5','mg/4cc',5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','6','mg/5cc',6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','7','mcg'   ,7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_units','8','grams' ,8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '0',''                 , 0,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '1','Per Oris'         , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '2','Per Rectum'       , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '3','To Skin'          , 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '4','To Affected Area' , 4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '5','Sublingual'       , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '6','OS'               , 6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '7','OD'               , 7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '8','OU'               , 8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route', '9','SQ'               , 9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route','10','IM'               ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route','11','IV'               ,11,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route','12','Per Nostril'      ,12,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route','13','Both Ears',13,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route','14','Left Ear' ,14,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_route','15','Right Ear',15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','0',''      ,0,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','1','b.i.d.',1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','2','t.i.d.',2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','3','q.i.d.',3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','4','q.3h'  ,4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','5','q.4h'  ,5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','6','q.5h'  ,6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','7','q.6h'  ,7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','8','q.8h'  ,8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','9','q.d.'  ,9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','10','a.c.'  ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','11','p.c.'  ,11,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','12','a.m.'  ,12,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','13','p.m.'  ,13,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','14','ante'  ,14,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','15','h'     ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','16','h.s.'  ,16,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','17','p.r.n.',17,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('drug_interval','18','stat'  ,18,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('chartloc','fileroom','File Room'              ,1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'boolean'      ,'Boolean'            , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'chartloc'     ,'Chart Storage Locations',1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'country'      ,'Country'            , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'drug_form'    ,'Drug Forms'         , 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'drug_units'   ,'Drug Units'         , 4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'drug_route'   ,'Drug Routes'        , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'drug_interval','Drug Intervals'     , 6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'exams'        ,'Exams/Tests'        , 7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'feesheet'     ,'Fee Sheet'          , 8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'language'     ,'Language'           , 9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'lbfnames'     ,'Layout-Based Visit Forms',9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'marital'      ,'Marital Status'     ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'pricelevel'   ,'Price Level'        ,11,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'ethrace'      ,'Race/Ethnicity'     ,12,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'refsource'    ,'Referral Source'    ,13,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'riskfactors'  ,'Risk Factors'       ,14,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'risklevel'    ,'Risk Level'         ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'superbill'    ,'Service Category'   ,16,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'sex'          ,'Sex'                ,17,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'state'        ,'State'              ,18,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'taxrate'      ,'Tax Rate'           ,19,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'titles'       ,'Titles'             ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'yesno'        ,'Yes/No'             ,21,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'userlist1'    ,'User Defined List 1',22,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'userlist2'    ,'User Defined List 2',23,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'userlist3'    ,'User Defined List 3',24,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'userlist4'    ,'User Defined List 4',25,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'userlist5'    ,'User Defined List 5',26,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'userlist6'    ,'User Defined List 6',27,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists' ,'userlist7'    ,'User Defined List 7',28,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'    ,'adjreason'      ,'Adjustment Reasons',1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Adm adjust'     ,'Adm adjust'     , 5,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','After hrs calls','After hrs calls',10,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Bad check'      ,'Bad check'      ,15,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Bad debt'       ,'Bad debt'       ,20,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Coll w/o'       ,'Coll w/o'       ,25,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Discount'       ,'Discount'       ,30,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Hardship w/o'   ,'Hardship w/o'   ,35,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Ins adjust'     ,'Ins adjust'     ,40,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Ins bundling'   ,'Ins bundling'   ,45,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Ins overpaid'   ,'Ins overpaid'   ,50,5);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Ins refund'     ,'Ins refund'     ,55,5);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Pt overpaid'    ,'Pt overpaid'    ,60,5);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Pt refund'      ,'Pt refund'      ,65,5);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Pt released'    ,'Pt released'    ,70,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Sm debt w/o'    ,'Sm debt w/o'    ,75,1);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','To copay'       ,'To copay'       ,80,2);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','To ded\'ble'    ,'To ded\'ble'    ,85,3);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('adjreason','Untimely filing','Untimely filing',90,1);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'       ,'sub_relation','Subscriber Relationship',18,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('sub_relation','self'        ,'Self'                   , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('sub_relation','spouse'      ,'Spouse'                 , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('sub_relation','child'       ,'Child'                  , 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('sub_relation','other'       ,'Other'                  , 4,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'     ,'occurrence','Occurrence'                  ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('occurrence','0'         ,'Unknown or N/A'              , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('occurrence','1'         ,'First'                       ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('occurrence','6'         ,'Early Recurrence (<2 Mo)'    ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('occurrence','7'         ,'Late Recurrence (2-12 Mo)'   ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('occurrence','8'         ,'Delayed Recurrence (> 12 Mo)',25,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('occurrence','4'         ,'Chronic/Recurrent'           ,30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('occurrence','5'         ,'Acute on Chronic'            ,35,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'  ,'outcome','Outcome'         ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('outcome','0'      ,'Unassigned'      , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('outcome','1'      ,'Resolved'        , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('outcome','2'      ,'Improved'        ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('outcome','3'      ,'Status quo'      ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('outcome','4'      ,'Worse'           ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('outcome','5'      ,'Pending followup',25,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'    ,'note_type'      ,'Patient Note Types',10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Unassigned'     ,'Unassigned'        , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Chart Note'     ,'Chart Note'        , 2,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Insurance'      ,'Insurance'         , 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','New Document'   ,'New Document'      , 4,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Pharmacy'       ,'Pharmacy'          , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Prior Auth'     ,'Prior Auth'        , 6,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Referral'       ,'Referral'          , 7,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Test Scheduling','Test Scheduling'   , 8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Bill/Collect'   ,'Bill/Collect'      , 9,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Other'          ,'Other'             ,10,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'        ,'immunizations','Immunizations'           ,  8,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','1'            ,'DTaP 1'                  , 30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','2'            ,'DTaP 2'                  , 35,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','3'            ,'DTaP 3'                  , 40,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','4'            ,'DTaP 4'                  , 45,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','5'            ,'DTaP 5'                  , 50,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','6'            ,'DT 1'                    ,  5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','7'            ,'DT 2'                    , 10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','8'            ,'DT 3'                    , 15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','9'            ,'DT 4'                    , 20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','10'           ,'DT 5'                    , 25,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','11'           ,'IPV 1'                   ,110,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','12'           ,'IPV 2'                   ,115,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','13'           ,'IPV 3'                   ,120,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','14'           ,'IPV 4'                   ,125,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','15'           ,'Hib 1'                   , 80,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','16'           ,'Hib 2'                   , 85,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','17'           ,'Hib 3'                   , 90,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','18'           ,'Hib 4'                   , 95,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','19'           ,'Pneumococcal Conjugate 1',140,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','20'           ,'Pneumococcal Conjugate 2',145,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','21'           ,'Pneumococcal Conjugate 3',150,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','22'           ,'Pneumococcal Conjugate 4',155,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','23'           ,'MMR 1'                   ,130,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','24'           ,'MMR 2'                   ,135,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','25'           ,'Varicella 1'             ,165,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','26'           ,'Varicella 2'             ,170,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','27'           ,'Hepatitis B 1'           , 65,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','28'           ,'Hepatitis B 2'           , 70,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','29'           ,'Hepatitis B 3'           , 75,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','30'           ,'Influenza 1'             ,100,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','31'           ,'Influenza 2'             ,105,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','32'           ,'Td'                      ,160,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','33'           ,'Hepatitis A 1'           , 55,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','34'           ,'Hepatitis A 2'           , 60,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('immunizations','35'           ,'Other'                   ,175,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'apptstat','Appointment Statuses', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','-'       ,'- None'              , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','*'       ,'* Reminder done'     ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','+'       ,'+ Chart pulled'      ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','x'       ,'x Canceled'          ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','?'       ,'? No show'           ,25,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','@'       ,'@ Arrived'           ,30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','~'       ,'~ Arrived late'      ,35,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','!'       ,'! Left w/o visit'    ,40,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','#'       ,'# Ins/fin issue'     ,45,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','<'       ,'< In exam room'      ,50,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','>'       ,'> Checked out'       ,55,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','$'       ,'$ Coding done'       ,60,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('apptstat','%'       ,'% Canceled < 24h'    ,65,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'    ,'warehouse','Warehouses',21,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('warehouse','onsite'   ,'On Site'   , 5,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','abook_type'  ,'Address Book Types'  , 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('abook_type','ord_img','Imaging Service'     , 5,3);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('abook_type','ord_imm','Immunization Service',10,3);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('abook_type','ord_lab','Lab Service'         ,15,3);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('abook_type','spe'    ,'Specialist'          ,20,2);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('abook_type','vendor' ,'Vendor'              ,25,3);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('abook_type','dist'   ,'Distributor'         ,30,3);
INSERT INTO list_options ( list_id, option_id, title, seq, option_value ) VALUES ('abook_type','oth'    ,'Other'               ,95,1);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_type','Procedure Types', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_type','grp','Group'          ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_type','ord','Procedure Order',20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_type','res','Discrete Result',30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_type','rec','Recommendation' ,40,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_body_site','Procedure Body Sites', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_body_site','arm'    ,'Arm'    ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_body_site','buttock','Buttock',20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_body_site','oth'    ,'Other'  ,90,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_specimen','Procedure Specimen Types', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_specimen','blood' ,'Blood' ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_specimen','saliva','Saliva',20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_specimen','urine' ,'Urine' ,30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_specimen','oth'   ,'Other' ,90,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_route','Procedure Routes', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_route','inj' ,'Injection',10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_route','oral','Oral'     ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_route','oth' ,'Other'    ,90,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_lat','Procedure Lateralities', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_lat','left' ,'Left'     ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_lat','right','Right'    ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_lat','bilat','Bilateral',30,0);

INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('lists','proc_unit','Procedure Units', 1);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','bool'       ,'Boolean'    ,  5);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','cu_mm'      ,'CU.MM'      , 10);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','fl'         ,'FL'         , 20);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','g_dl'       ,'G/DL'       , 30);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','gm_dl'      ,'GM/DL'      , 40);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','hmol_l'     ,'HMOL/L'     , 50);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','iu_l'       ,'IU/L'       , 60);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','mg_dl'      ,'MG/DL'      , 70);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','mil_cu_mm'  ,'Mil/CU.MM'  , 80);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','percent'    ,'Percent'    , 90);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','percentile' ,'Percentile' ,100);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','pg'         ,'PG'         ,110);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','ratio'      ,'Ratio'      ,120);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','thous_cu_mm','Thous/CU.MM',130);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','units'      ,'Units'      ,140);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','units_l'    ,'Units/L'    ,150);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','days'       ,'Days'       ,600);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','weeks'      ,'Weeks'      ,610);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','months'     ,'Months'     ,620);
INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('proc_unit','oth'        ,'Other'      ,990);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','ord_priority','Order Priorities', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ord_priority','high'  ,'High'  ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ord_priority','normal','Normal',20,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','ord_status','Order Statuses', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ord_status','pending' ,'Pending' ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ord_status','routed'  ,'Routed'  ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ord_status','complete','Complete',30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ord_status','canceled','Canceled',40,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_rep_status','Procedure Report Statuses', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_rep_status','final'  ,'Final'      ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_rep_status','review' ,'Reviewed'   ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_rep_status','prelim' ,'Preliminary',30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_rep_status','cancel' ,'Canceled'   ,40,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_rep_status','error'  ,'Error'      ,50,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_rep_status','correct','Corrected'  ,60,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_res_abnormal','Procedure Result Abnormal', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_abnormal','no'  ,'No'  ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_abnormal','yes' ,'Yes' ,20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_abnormal','high','High',30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_abnormal','low' ,'Low' ,40,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_res_status','Procedure Result Statuses', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_status','final'     ,'Final'      ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_status','prelim'    ,'Preliminary',20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_status','cancel'    ,'Canceled'   ,30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_status','error'     ,'Error'      ,40,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_status','correct'   ,'Corrected'  ,50,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_status','incomplete','Incomplete' ,60,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists','proc_res_bool','Procedure Boolean Results', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_bool','neg' ,'Negative',10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('proc_res_bool','pos' ,'Positive',20,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'         ,'message_status','Message Status',45,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('message_status','Done'           ,'Done'         , 5,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('message_status','Forwarded'      ,'Forwarded'    ,10,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('message_status','New'            ,'New'          ,15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('message_status','Read'           ,'Read'         ,20,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Lab Results' ,'Lab Results', 15,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','New Orders' ,'New Orders', 20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('note_type','Patient Reminders' ,'Patient Reminders', 25,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'irnpool','Invoice Reference Number Pools', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default, notes ) VALUES ('irnpool','main','Main',1,1,'000001');

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists', 'eligibility', 'Eligibility', 60, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('eligibility', 'eligible', 'Eligible', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('eligibility', 'ineligible', 'Ineligible', 20, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists', 'transactions', 'Transactions', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('transactions', 'Referral', 'Referral', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('transactions', 'Patient Request', 'Patient Request', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('transactions', 'Physician Request', 'Physician Request', 30, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('transactions', 'Legal', 'Legal', 40, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('transactions', 'Billing', 'Billing', 50, 0);


INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'payment_adjustment_code','Payment Adjustment Code', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_adjustment_code', 'family_payment', 'Family Payment', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_adjustment_code', 'group_payment', 'Group Payment', 30, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_adjustment_code', 'insurance_payment', 'Insurance Payment', 40, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_adjustment_code', 'patient_payment', 'Patient Payment', 50, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_adjustment_code', 'pre_payment', 'Pre Payment', 60, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'payment_ins','Payment Ins', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_ins', '0', 'Pat', 40, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_ins', '1', 'Ins1', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_ins', '2', 'Ins2', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_ins', '3', 'Ins3', 30, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'payment_method','Payment Method', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_method', 'bank_draft', 'Bank Draft', 50, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_method', 'cash', 'Cash', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_method', 'check_payment', 'Check Payment', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_method', 'credit_card', 'Credit Card', 30, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_method', 'electronic', 'Electronic', 40, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'payment_sort_by','Payment Sort By', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_sort_by', 'check_date', 'Check Date', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_sort_by', 'payer_id', 'Ins Code', 40, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_sort_by', 'payment_method', 'Payment Method', 50, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_sort_by', 'payment_type', 'Paying Entity', 30, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_sort_by', 'pay_total', 'Amount', 70, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_sort_by', 'reference', 'Check Number', 60, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_sort_by', 'session_id', 'Id', 10, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'payment_status','Payment Status', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_status', 'fully_paid', 'Fully Paid', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_status', 'unapplied', 'Unapplied', 20, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'payment_type','Payment Type', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_type', 'insurance', 'Insurance', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_type', 'patient', 'Patient', 20, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists', 'date_master_criteria', 'Date Master Criteria', 33, 1);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('date_master_criteria', 'all', 'All', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('date_master_criteria', 'today', 'Today', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('date_master_criteria', 'this_month_to_date', 'This Month to Date', 30, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('date_master_criteria', 'last_month', 'Last Month', 40, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('date_master_criteria', 'this_week_to_date', 'This Week to Date', 50, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('date_master_criteria', 'this_calendar_year', 'This Calendar Year', 60, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('date_master_criteria', 'last_calendar_year', 'Last Calendar Year', 70, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('date_master_criteria', 'custom', 'Custom', 80, 0);

-- Clinical Plan Titles
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'clinical_plans','Clinical Plans', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'dm_plan_cqm', 'Diabetes Mellitus', 5, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'ckd_plan_cqm', 'Chronic Kidney Disease (CKD)', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'prevent_plan_cqm', 'Preventative Care', 15, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'periop_plan_cqm', 'Perioperative Care', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'rheum_arth_plan_cqm', 'Rheumatoid Arthritis', 25, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'back_pain_plan_cqm', 'Back Pain', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'cabg_plan_cqm', 'Coronary Artery Bypass Graft (CABG)', 35, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'dm_plan', 'Diabetes Mellitus', 500, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_plans', 'prevent_plan', 'Preventative Care', 510, 0);

-- Clinical Rule Titles
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'clinical_rules','Clinical Rules', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'problem_list_amc', 'Maintain an up-to-date problem list of current and active diagnoses.', 5, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'med_list_amc', 'Maintain active medication list.', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'med_allergy_list_amc', 'Maintain active medication allergy list.', 15, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'record_vitals_amc', 'Record and chart changes in vital signs.', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'record_smoke_amc', 'Record smoking status for patients 13 years old or older.', 25, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'lab_result_amc', 'Incorporate clinical lab-test results into certified EHR technology as structured data.', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'med_reconc_amc', 'The EP, eligible hospital or CAH who receives a patient from another setting of care or provider of care or believes an encounter is relevant should perform medication reconciliation.', 35, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'patient_edu_amc', 'Use certified EHR technology to identify patient-specific education resources and provide those resources to the patient if appropriate.', 40, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'cpoe_med_amc', 'Use CPOE for medication orders directly entered by any licensed healthcare professional who can enter orders into the medical record per state, local and professional guidelines.', 45, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'e_prescribe_amc', 'Generate and transmit permissible prescriptions electronically.', 50, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'record_dem_amc', 'Record demographics.', 55, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'send_reminder_amc', 'Send reminders to patients per patient preference for preventive/follow up care.', 60, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'provide_rec_pat_amc', 'Provide patients with an electronic copy of their health information (including diagnostic test results, problem list, medication lists, medication allergies), upon request.', 65, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'timely_access_amc', 'Provide patients with timely electronic access to their health information (including lab results, problem list, medication lists, medication allergies) within four business days of the information being available to the EP.', 70, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'provide_sum_pat_amc', 'Provide clinical summaries for patients for each office visit.', 75, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'send_sum_amc', 'The EP, eligible hospital or CAH who transitions their patient to another setting of care or provider of care or refers their patient to another provider of care should provide summary of care record for each transition of care or referral.', 80, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_htn_bp_measure_cqm', 'Hypertension: Blood Pressure Measurement (CQM)', 200, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_tob_use_assess_cqm', 'Tobacco Use Assessment (CQM)', 205, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_tob_cess_inter_cqm', 'Tobacco Cessation Intervention (CQM)', 210, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_adult_wt_screen_fu_cqm', 'Adult Weight Screening and Follow-Up (CQM)', 220, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_wt_assess_couns_child_cqm', 'Weight Assessment and Counseling for Children and Adolescents (CQM)', 230, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_influenza_ge_50_cqm', 'Influenza Immunization for Patients >= 50 Years Old (CQM)', 240, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_child_immun_stat_cqm', 'Childhood immunization Status (CQM)', 250, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_pneumovacc_ge_65_cqm', 'Pneumonia Vaccination Status for Older Adults (CQM)', 260, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_dm_eye_cqm', 'Diabetes: Eye Exam (CQM)', 270, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_dm_foot_cqm', 'Diabetes: Foot Exam (CQM)', 280, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_dm_bp_control_cqm', 'Diabetes: Blood Pressure Management (CQM)', 290, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_htn_bp_measure', 'Hypertension: Blood Pressure Measurement', 500, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_tob_use_assess', 'Tobacco Use Assessment', 510, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_tob_cess_inter', 'Tobacco Cessation Intervention', 520, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_adult_wt_screen_fu', 'Adult Weight Screening and Follow-Up', 530, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_wt_assess_couns_child', 'Weight Assessment and Counseling for Children and Adolescents', 540, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_influenza_ge_50', 'Influenza Immunization for Patients >= 50 Years Old', 550, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_pneumovacc_ge_65', 'Pneumonia Vaccination Status for Older Adults', 570, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_dm_hemo_a1c', 'Diabetes: Hemoglobin A1C', 570, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_dm_urine_alb', 'Diabetes: Urine Microalbumin', 590, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_dm_eye', 'Diabetes: Eye Exam', 600, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_dm_foot', 'Diabetes: Foot Exam', 610, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_cs_mammo', 'Cancer Screening: Mammogram', 620, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_cs_pap', 'Cancer Screening: Pap Smear', 630, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_cs_colon', 'Cancer Screening: Colon Cancer Screening', 640, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_cs_prostate', 'Cancer Screening: Prostate Cancer Screening', 650, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_inr_monitor', 'Coumadin Management - INR Monitoring', 1000, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('clinical_rules', 'rule_appt_reminder', 'Appointment Reminder Rule', 2000, 0);

-- Clinical Rule Target Methods
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_targets', 'Clinical Rule Target Methods', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_targets' ,'target_database', 'Database', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_targets' ,'target_interval', 'Interval', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_targets' ,'target_proc', 'Procedure', 20, 0);

-- Clinical Rule Target Intervals
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_target_intervals', 'Clinical Rules Target Intervals', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_target_intervals' ,'year', 'Year', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_target_intervals' ,'month', 'Month', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_target_intervals' ,'week', 'Week', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_target_intervals' ,'day', 'Day', 40, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_target_intervals' ,'hour', 'Hour', 50, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_target_intervals' ,'minute', 'Minute', 60, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_target_intervals' ,'second', 'Second', 70, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_target_intervals' ,'flu_season', 'Flu Season', 80, 0);

-- Clinical Rule Comparisons
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_comparisons', 'Clinical Rules Comparisons', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_comparisons' ,'EXIST', 'Exist', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_comparisons' ,'lt', 'Less Than', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_comparisons' ,'le', 'Less Than or Equal To', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_comparisons' ,'gt', 'Greater Than', 40, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_comparisons' ,'ge', 'Greater Than or Equal To', 50, 0);

-- Clinical Rule Filter Methods
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_filters','Clinical Rule Filter Methods', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_filters', 'filt_database', 'Database', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_filters', 'filt_diagnosis', 'Diagnosis', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_filters', 'filt_sex', 'Gender', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_filters', 'filt_age_max', 'Maximum Age', 40, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_filters', 'filt_age_min', 'Minimum Age', 50, 0);

-- Clinical Rule Age Intervals
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_age_intervals', 'Clinical Rules Age Intervals', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_age_intervals' ,'year', 'Year', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_age_intervals' ,'month', 'Month', 20, 0);

-- Encounter Types (needed for mapping encounters for CQM rules)
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_enc_types', 'Clinical Rules Encounter Types', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_outpatient', 'encounter outpatient', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_nurs_fac', 'encounter nursing facility', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_off_vis', 'encounter office visit', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_hea_and_beh', 'encounter health and behavior assessment', 40, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_occ_ther', 'encounter occupational therapy', 50, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_psych_and_psych', 'encounter psychiatric & psychologic', 60, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_pre_med_ser_18_older', 'encounter preventive medicine services 18 and older', 70, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_pre_ind_counsel', 'encounter preventive medicine - individual counseling', 80, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_pre_med_group_counsel', 'encounter preventive medicine group counseling', 90, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_pre_med_other_serv', 'encounter preventive medicine other services', 100, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_out_pcp_obgyn', 'encounter outpatient w/PCP & obgyn', 110, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_pregnancy', 'encounter pregnancy', 120, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_nurs_discharge', 'encounter nursing discharge', 130, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_acute_inp_or_ed', 'encounter acute inpatient or ED', 130, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_enc_types' ,'enc_nonac_inp_out_or_opth', 'Encounter: encounter non-acute inpt, outpatient, or ophthalmology', 140, 0);

-- Clinical Rule Action Categories
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_action_category', 'Clinical Rule Action Category', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action_category' ,'act_cat_assess', 'Assessment', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action_category' ,'act_cat_edu', 'Education', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action_category' ,'act_cat_exam', 'Examination', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action_category' ,'act_cat_inter', 'Intervention', 40, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action_category' ,'act_cat_measure', 'Measurement', 50, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action_category' ,'act_cat_treat', 'Treatment', 60, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action_category' ,'act_cat_remind', 'Reminder', 70, 0);

-- Clinical Rule Action Items
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_action', 'Clinical Rule Action Item', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_bp', 'Blood Pressure', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_influvacc', 'Influenza Vaccine', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_tobacco', 'Tobacco', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_wt', 'Weight', 40, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_pneumovacc', 'Pneumococcal Vaccine', 60, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_hemo_a1c', 'Hemoglobin A1C', 70, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_urine_alb', 'Urine Microalbumin', 80, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_eye', 'Opthalmic', 90, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_foot', 'Podiatric', 100, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_mammo', 'Mammogram', 110, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_pap', 'Pap Smear', 120, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_colon_cancer_screen', 'Colon Cancer Screening', 130, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_prostate_cancer_screen', 'Prostate Cancer Screening', 140, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_lab_inr', 'INR', 150, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_action' ,'act_appointment', 'Appointment', 160, 0);

-- Clinical Rule Reminder Intervals
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_reminder_intervals', 'Clinical Rules Reminder Intervals', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_intervals' ,'month', 'Month', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_intervals' ,'week', 'Week', 20, 0);

-- Clinical Rule Reminder Methods
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_reminder_methods', 'Clinical Rules Reminder Methods', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_methods' ,'clinical_reminder_pre', 'Past Due Interval (Clinical Reminders)', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_methods' ,'patient_reminder_pre', 'Past Due Interval (Patient Reminders)', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_methods' ,'clinical_reminder_post', 'Soon Due Interval (Clinical Reminders)', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_methods' ,'patient_reminder_post', 'Soon Due Interval (Patient Reminders)', 40, 0);

-- Clinical Rule Reminder Due Options
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_reminder_due_opt', 'Clinical Rules Reminder Due Options', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_due_opt' ,'due', 'Due', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_due_opt' ,'soon_due', 'Due Soon', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_due_opt' ,'past_due', 'Past Due', 30, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_due_opt' ,'not_due', 'Not Due', 30, 0);

-- Clinical Rule Reminder Inactivate Options
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('lists' ,'rule_reminder_inactive_opt', 'Clinical Rules Reminder Inactivation Options', 3, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_inactive_opt' ,'auto', 'Automatic', 10, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_inactive_opt' ,'due_status_update', 'Due Status Update', 20, 0);
INSERT INTO `list_options` ( `list_id`, `option_id`, `title`, `seq`, `is_default` ) VALUES ('rule_reminder_inactive_opt' ,'manual', 'Manual', 20, 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `lists`
-- 

DROP TABLE IF EXISTS `lists`;
CREATE TABLE `lists` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `type` varchar(255) default NULL,
  `title` varchar(255) default NULL,
  `begdate` date default NULL,
  `enddate` date default NULL,
  `returndate` date default NULL,
  `occurrence` int(11) default '0',
  `classification` int(11) default '0',
  `referredby` varchar(255) default NULL,
  `extrainfo` varchar(255) default NULL,
  `diagnosis` varchar(255) default NULL,
  `activity` tinyint(4) default NULL,
  `comments` longtext,
  `pid` bigint(20) default NULL,
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `outcome` int(11) NOT NULL default '0',
  `destination` varchar(255) default NULL,
  `reinjury_id` bigint(20)  NOT NULL DEFAULT 0,
  `injury_part` varchar(31) NOT NULL DEFAULT '',
  `injury_type` varchar(31) NOT NULL DEFAULT '',
  `injury_grade` varchar(31) NOT NULL DEFAULT '',
  `reaction` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `log`
-- 

DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `event` varchar(255) default NULL,
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `comments` longtext,
  `user_notes` longtext,
  `patient_id` bigint(20) default NULL,
  `success` tinyint(1) default 1,
  `checksum` longtext default NULL,
  `crt_user` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `notes`
-- 

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL default '0',
  `foreign_id` int(11) NOT NULL default '0',
  `note` varchar(255) default NULL,
  `owner` int(11) default NULL,
  `date` datetime default NULL,
  `revision` timestamp NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `foreign_id` (`owner`),
  KEY `foreign_id_2` (`foreign_id`),
  KEY `date` (`date`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `onotes`
-- 

DROP TABLE IF EXISTS `onotes`;
CREATE TABLE `onotes` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `body` longtext,
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `activity` tinyint(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `openemr_module_vars`
-- 

DROP TABLE IF EXISTS `openemr_module_vars`;
CREATE TABLE `openemr_module_vars` (
  `pn_id` int(11) unsigned NOT NULL auto_increment,
  `pn_modname` varchar(64) default NULL,
  `pn_name` varchar(64) default NULL,
  `pn_value` longtext,
  PRIMARY KEY  (`pn_id`),
  KEY `pn_modname` (`pn_modname`),
  KEY `pn_name` (`pn_name`)
) ENGINE=MyISAM AUTO_INCREMENT=235 ;

-- 
-- Dumping data for table `openemr_module_vars`
-- 

INSERT INTO `openemr_module_vars` VALUES (234, 'PostCalendar', 'pcNotifyEmail', '');
INSERT INTO `openemr_module_vars` VALUES (233, 'PostCalendar', 'pcNotifyAdmin', '0');
INSERT INTO `openemr_module_vars` VALUES (232, 'PostCalendar', 'pcCacheLifetime', '3600');
INSERT INTO `openemr_module_vars` VALUES (231, 'PostCalendar', 'pcUseCache', '0');
INSERT INTO `openemr_module_vars` VALUES (230, 'PostCalendar', 'pcDefaultView', 'day');
INSERT INTO `openemr_module_vars` VALUES (229, 'PostCalendar', 'pcTimeIncrement', '5');
INSERT INTO `openemr_module_vars` VALUES (228, 'PostCalendar', 'pcAllowUserCalendar', '1');
INSERT INTO `openemr_module_vars` VALUES (227, 'PostCalendar', 'pcAllowSiteWide', '1');
INSERT INTO `openemr_module_vars` VALUES (226, 'PostCalendar', 'pcTemplate', 'default');
INSERT INTO `openemr_module_vars` VALUES (225, 'PostCalendar', 'pcEventDateFormat', '%Y-%m-%d');
INSERT INTO `openemr_module_vars` VALUES (224, 'PostCalendar', 'pcDisplayTopics', '0');
INSERT INTO `openemr_module_vars` VALUES (223, 'PostCalendar', 'pcListHowManyEvents', '15');
INSERT INTO `openemr_module_vars` VALUES (222, 'PostCalendar', 'pcAllowDirectSubmit', '1');
INSERT INTO `openemr_module_vars` VALUES (221, 'PostCalendar', 'pcUsePopups', '0');
INSERT INTO `openemr_module_vars` VALUES (220, 'PostCalendar', 'pcDayHighlightColor', '#EEEEEE');
INSERT INTO `openemr_module_vars` VALUES (219, 'PostCalendar', 'pcFirstDayOfWeek', '1');
INSERT INTO `openemr_module_vars` VALUES (218, 'PostCalendar', 'pcUseInternationalDates', '0');
INSERT INTO `openemr_module_vars` VALUES (217, 'PostCalendar', 'pcEventsOpenInNewWindow', '0');
INSERT INTO `openemr_module_vars` VALUES (216, 'PostCalendar', 'pcTime24Hours', '0');

-- --------------------------------------------------------

-- 
-- Table structure for table `openemr_modules`
-- 

DROP TABLE IF EXISTS `openemr_modules`;
CREATE TABLE `openemr_modules` (
  `pn_id` int(11) unsigned NOT NULL auto_increment,
  `pn_name` varchar(64) default NULL,
  `pn_type` int(6) NOT NULL default '0',
  `pn_displayname` varchar(64) default NULL,
  `pn_description` varchar(255) default NULL,
  `pn_regid` int(11) unsigned NOT NULL default '0',
  `pn_directory` varchar(64) default NULL,
  `pn_version` varchar(10) default NULL,
  `pn_admin_capable` tinyint(1) NOT NULL default '0',
  `pn_user_capable` tinyint(1) NOT NULL default '0',
  `pn_state` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`pn_id`)
) ENGINE=MyISAM AUTO_INCREMENT=47 ;

-- 
-- Dumping data for table `openemr_modules`
-- 

INSERT INTO `openemr_modules` VALUES (46, 'PostCalendar', 2, 'PostCalendar', 'PostNuke Calendar Module', 0, 'PostCalendar', '4.0.0', 1, 1, 3);

-- --------------------------------------------------------

-- 
-- Table structure for table `openemr_postcalendar_categories`
-- 

DROP TABLE IF EXISTS `openemr_postcalendar_categories`;
CREATE TABLE `openemr_postcalendar_categories` (
  `pc_catid` int(11) unsigned NOT NULL auto_increment,
  `pc_catname` varchar(100) default NULL,
  `pc_catcolor` varchar(50) default NULL,
  `pc_catdesc` text,
  `pc_recurrtype` int(1) NOT NULL default '0',
  `pc_enddate` date default NULL,
  `pc_recurrspec` text,
  `pc_recurrfreq` int(3) NOT NULL default '0',
  `pc_duration` bigint(20) NOT NULL default '0',
  `pc_end_date_flag` tinyint(1) NOT NULL default '0',
  `pc_end_date_type` int(2) default NULL,
  `pc_end_date_freq` int(11) NOT NULL default '0',
  `pc_end_all_day` tinyint(1) NOT NULL default '0',
  `pc_dailylimit` int(2) NOT NULL default '0',
  `pc_cattype` INT( 11 ) NOT NULL COMMENT 'Used in grouping categories',
  PRIMARY KEY  (`pc_catid`),
  KEY `basic_cat` (`pc_catname`,`pc_catcolor`)
) ENGINE=MyISAM AUTO_INCREMENT=11 ;

-- 
-- Dumping data for table `openemr_postcalendar_categories`
-- 

INSERT INTO `openemr_postcalendar_categories` VALUES (5, 'Office Visit', '#FFFFCC', 'Normal Office Visit', 0, NULL, 'a:5:{s:17:"event_repeat_freq";s:1:"0";s:22:"event_repeat_freq_type";s:1:"0";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, 900, 0, 0, 0, 0, 0,0);
INSERT INTO `openemr_postcalendar_categories` VALUES (4, 'Vacation', '#EFEFEF', 'Reserved for use to define Scheduled Vacation Time', 0, NULL, 'a:5:{s:17:"event_repeat_freq";s:1:"0";s:22:"event_repeat_freq_type";s:1:"0";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, 0, 0, 0, 0, 1, 0, 1);
INSERT INTO `openemr_postcalendar_categories` VALUES (1, 'No Show', '#DDDDDD', 'Reserved to define when an event did not occur as specified.', 0, NULL, 'a:5:{s:17:"event_repeat_freq";s:1:"0";s:22:"event_repeat_freq_type";s:1:"0";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `openemr_postcalendar_categories` VALUES (2, 'In Office', '#99CCFF', 'Reserved todefine when a provider may haveavailable appointments after.', 1, NULL, 'a:5:{s:17:"event_repeat_freq";s:1:"1";s:22:"event_repeat_freq_type";s:1:"4";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, 0, 1, 3, 2, 0, 0, 1);
INSERT INTO `openemr_postcalendar_categories` VALUES (3, 'Out Of Office', '#99FFFF', 'Reserved to define when a provider may not have available appointments after.', 1, NULL, 'a:5:{s:17:"event_repeat_freq";s:1:"1";s:22:"event_repeat_freq_type";s:1:"4";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, 0, 1, 3, 2, 0, 0, 1);
INSERT INTO `openemr_postcalendar_categories` VALUES (8, 'Lunch', '#FFFF33', 'Lunch', 1, NULL, 'a:5:{s:17:"event_repeat_freq";s:1:"1";s:22:"event_repeat_freq_type";s:1:"4";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, 3600, 0, 3, 2, 0, 0, 1);
INSERT INTO `openemr_postcalendar_categories` VALUES (9, 'Established Patient', '#CCFF33', '', 0, NULL, 'a:5:{s:17:"event_repeat_freq";s:1:"0";s:22:"event_repeat_freq_type";s:1:"0";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, 900, 0, 0, 0, 0, 0, 0);
INSERT INTO `openemr_postcalendar_categories` VALUES (10,'New Patient', '#CCFFFF', '', 0, NULL, 'a:5:{s:17:"event_repeat_freq";s:1:"0";s:22:"event_repeat_freq_type";s:1:"0";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, 1800, 0, 0, 0, 0, 0, 0);
INSERT INTO `openemr_postcalendar_categories` VALUES (11,'Reserved','#FF7777','Reserved',1,NULL,'a:5:{s:17:\"event_repeat_freq\";s:1:\"1\";s:22:\"event_repeat_freq_type\";s:1:\"4\";s:19:\"event_repeat_on_num\";s:1:\"1\";s:19:\"event_repeat_on_day\";s:1:\"0\";s:20:\"event_repeat_on_freq\";s:1:\"0\";}',0,900,0,3,2,0,0, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `openemr_postcalendar_events`
-- 

DROP TABLE IF EXISTS `openemr_postcalendar_events`;
CREATE TABLE `openemr_postcalendar_events` (
  `pc_eid` int(11) unsigned NOT NULL auto_increment,
  `pc_catid` int(11) NOT NULL default '0',
  `pc_multiple` int(10) unsigned NOT NULL,
  `pc_aid` varchar(30) default NULL,
  `pc_pid` varchar(11) default NULL,
  `pc_title` varchar(150) default NULL,
  `pc_time` datetime default NULL,
  `pc_hometext` text,
  `pc_comments` int(11) default '0',
  `pc_counter` mediumint(8) unsigned default '0',
  `pc_topic` int(3) NOT NULL default '1',
  `pc_informant` varchar(20) default NULL,
  `pc_eventDate` date NOT NULL default '0000-00-00',
  `pc_endDate` date NOT NULL default '0000-00-00',
  `pc_duration` bigint(20) NOT NULL default '0',
  `pc_recurrtype` int(1) NOT NULL default '0',
  `pc_recurrspec` text,
  `pc_recurrfreq` int(3) NOT NULL default '0',
  `pc_startTime` time default NULL,
  `pc_endTime` time default NULL,
  `pc_alldayevent` int(1) NOT NULL default '0',
  `pc_location` text,
  `pc_conttel` varchar(50) default NULL,
  `pc_contname` varchar(50) default NULL,
  `pc_contemail` varchar(255) default NULL,
  `pc_website` varchar(255) default NULL,
  `pc_fee` varchar(50) default NULL,
  `pc_eventstatus` int(11) NOT NULL default '0',
  `pc_sharing` int(11) NOT NULL default '0',
  `pc_language` varchar(30) default NULL,
  `pc_apptstatus` varchar(15) NOT NULL default '-',
  `pc_prefcatid` int(11) NOT NULL default '0',
  `pc_facility` smallint(6) NOT NULL default '0' COMMENT 'facility id for this event',
  `pc_sendalertsms` VARCHAR(3) NOT NULL DEFAULT 'NO',
  `pc_sendalertemail` VARCHAR( 3 ) NOT NULL DEFAULT 'NO',
  `pc_billing_location` SMALLINT (6) NOT NULL DEFAULT '0',
  PRIMARY KEY  (`pc_eid`),
  KEY `basic_event` (`pc_catid`,`pc_aid`,`pc_eventDate`,`pc_endDate`,`pc_eventstatus`,`pc_sharing`,`pc_topic`)
) ENGINE=MyISAM AUTO_INCREMENT=7 ;

-- 
-- Dumping data for table `openemr_postcalendar_events`
-- 

INSERT INTO `openemr_postcalendar_events` VALUES (3, 2, 0, '1', '', 'In Office', '2005-03-03 12:22:31', ':text:', 0, 0, 0, '1', '2005-03-03', '2007-03-03', 0, 1, 'a:5:{s:17:"event_repeat_freq";s:1:"1";s:22:"event_repeat_freq_type";s:1:"4";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, '09:00:00', '09:00:00', 0, 'a:6:{s:14:"event_location";N;s:13:"event_street1";N;s:13:"event_street2";N;s:10:"event_city";N;s:11:"event_state";N;s:12:"event_postal";N;}', '', '', '', '', '', 1, 1, '', '-', 0, 0, 'NO', 'NO');
INSERT INTO `openemr_postcalendar_events` VALUES (5, 3, 0, '1', '', 'Out Of Office', '2005-03-03 12:22:52', ':text:', 0, 0, 0, '1', '2005-03-03', '2007-03-03', 0, 1, 'a:5:{s:17:"event_repeat_freq";s:1:"1";s:22:"event_repeat_freq_type";s:1:"4";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, '17:00:00', '17:00:00', 0, 'a:6:{s:14:"event_location";N;s:13:"event_street1";N;s:13:"event_street2";N;s:10:"event_city";N;s:11:"event_state";N;s:12:"event_postal";N;}', '', '', '', '', '', 1, 1, '', '-', 0, 0, 'NO', 'NO');
INSERT INTO `openemr_postcalendar_events` VALUES (6, 8, 0, '1', '', 'Lunch', '2005-03-03 12:23:31', ':text:', 0, 0, 0, '1', '2005-03-03', '2007-03-03', 3600, 1, 'a:5:{s:17:"event_repeat_freq";s:1:"1";s:22:"event_repeat_freq_type";s:1:"4";s:19:"event_repeat_on_num";s:1:"1";s:19:"event_repeat_on_day";s:1:"0";s:20:"event_repeat_on_freq";s:1:"0";}', 0, '12:00:00', '13:00:00', 0, 'a:6:{s:14:"event_location";N;s:13:"event_street1";N;s:13:"event_street2";N;s:10:"event_city";N;s:11:"event_state";N;s:12:"event_postal";N;}', '', '', '', '', '', 1, 1, '', '-', 0, 0, 'NO', 'NO');

-- --------------------------------------------------------

-- 
-- Table structure for table `openemr_postcalendar_limits`
-- 

DROP TABLE IF EXISTS `openemr_postcalendar_limits`;
CREATE TABLE `openemr_postcalendar_limits` (
  `pc_limitid` int(11) NOT NULL auto_increment,
  `pc_catid` int(11) NOT NULL default '0',
  `pc_starttime` time NOT NULL default '00:00:00',
  `pc_endtime` time NOT NULL default '00:00:00',
  `pc_limit` int(11) NOT NULL default '1',
  PRIMARY KEY  (`pc_limitid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `openemr_postcalendar_topics`
-- 

DROP TABLE IF EXISTS `openemr_postcalendar_topics`;
CREATE TABLE `openemr_postcalendar_topics` (
  `pc_catid` int(11) unsigned NOT NULL auto_increment,
  `pc_catname` varchar(100) default NULL,
  `pc_catcolor` varchar(50) default NULL,
  `pc_catdesc` text,
  PRIMARY KEY  (`pc_catid`),
  KEY `basic_cat` (`pc_catname`,`pc_catcolor`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `openemr_session_info`
-- 

DROP TABLE IF EXISTS `openemr_session_info`;
CREATE TABLE `openemr_session_info` (
  `pn_sessid` varchar(32) NOT NULL default '',
  `pn_ipaddr` varchar(20) default NULL,
  `pn_firstused` int(11) NOT NULL default '0',
  `pn_lastused` int(11) NOT NULL default '0',
  `pn_uid` int(11) NOT NULL default '0',
  `pn_vars` blob,
  PRIMARY KEY  (`pn_sessid`)
) ENGINE=MyISAM;

-- 
-- Dumping data for table `openemr_session_info`
-- 

INSERT INTO `openemr_session_info` VALUES ('978d31441dccd350d406bfab98978f20', '127.0.0.1', 1109233952, 1109234177, 0, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `patient_data`
-- 

DROP TABLE IF EXISTS `patient_data`;
CREATE TABLE `patient_data` (
  `id` bigint(20) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `language` varchar(255) NOT NULL default '',
  `financial` varchar(255) NOT NULL default '',
  `fname` varchar(255) NOT NULL default '',
  `lname` varchar(255) NOT NULL default '',
  `mname` varchar(255) NOT NULL default '',
  `DOB` date default NULL,
  `street` varchar(255) NOT NULL default '',
  `postal_code` varchar(255) NOT NULL default '',
  `city` varchar(255) NOT NULL default '',
  `state` varchar(255) NOT NULL default '',
  `country_code` varchar(255) NOT NULL default '',
  `drivers_license` varchar(255) NOT NULL default '',
  `ss` varchar(255) NOT NULL default '',
  `occupation` longtext,
  `phone_home` varchar(255) NOT NULL default '',
  `phone_biz` varchar(255) NOT NULL default '',
  `phone_contact` varchar(255) NOT NULL default '',
  `phone_cell` varchar(255) NOT NULL default '',
  `pharmacy_id` int(11) NOT NULL default '0',
  `status` varchar(255) NOT NULL default '',
  `contact_relationship` varchar(255) NOT NULL default '',
  `date` datetime default NULL,
  `sex` varchar(255) NOT NULL default '',
  `referrer` varchar(255) NOT NULL default '',
  `referrerID` varchar(255) NOT NULL default '',
  `providerID` int(11) default NULL,
  `email` varchar(255) NOT NULL default '',
  `ethnoracial` varchar(255) NOT NULL default '',
  `race` varchar(255) NOT NULL default '',
  `ethnicity` varchar(255) NOT NULL default '',
  `interpretter` varchar(255) NOT NULL default '',
  `migrantseasonal` varchar(255) NOT NULL default '',
  `family_size` varchar(255) NOT NULL default '',
  `monthly_income` varchar(255) NOT NULL default '',
  `homeless` varchar(255) NOT NULL default '',
  `financial_review` datetime default NULL,
  `pubpid` varchar(255) NOT NULL default '',
  `pid` bigint(20) NOT NULL default '0',
  `genericname1` varchar(255) NOT NULL default '',
  `genericval1` varchar(255) NOT NULL default '',
  `genericname2` varchar(255) NOT NULL default '',
  `genericval2` varchar(255) NOT NULL default '',
  `hipaa_mail` varchar(3) NOT NULL default '',
  `hipaa_voice` varchar(3) NOT NULL default '',
  `hipaa_notice` varchar(3) NOT NULL default '',
  `hipaa_message` varchar(20) NOT NULL default '',
  `hipaa_allowsms` VARCHAR(3) NOT NULL DEFAULT 'NO',
  `hipaa_allowemail` VARCHAR(3) NOT NULL DEFAULT 'NO',
  `squad` varchar(32) NOT NULL default '',
  `fitness` int(11) NOT NULL default '0',
  `referral_source` varchar(30) NOT NULL default '',
  `usertext1` varchar(255) NOT NULL DEFAULT '',
  `usertext2` varchar(255) NOT NULL DEFAULT '',
  `usertext3` varchar(255) NOT NULL DEFAULT '',
  `usertext4` varchar(255) NOT NULL DEFAULT '',
  `usertext5` varchar(255) NOT NULL DEFAULT '',
  `usertext6` varchar(255) NOT NULL DEFAULT '',
  `usertext7` varchar(255) NOT NULL DEFAULT '',
  `usertext8` varchar(255) NOT NULL DEFAULT '',
  `userlist1` varchar(255) NOT NULL DEFAULT '',
  `userlist2` varchar(255) NOT NULL DEFAULT '',
  `userlist3` varchar(255) NOT NULL DEFAULT '',
  `userlist4` varchar(255) NOT NULL DEFAULT '',
  `userlist5` varchar(255) NOT NULL DEFAULT '',
  `userlist6` varchar(255) NOT NULL DEFAULT '',
  `userlist7` varchar(255) NOT NULL DEFAULT '',
  `pricelevel` varchar(255) NOT NULL default 'standard',
  `regdate`     date DEFAULT NULL COMMENT 'Registration Date',
  `contrastart` date DEFAULT NULL COMMENT 'Date contraceptives initially used',
  `completed_ad` VARCHAR(3) NOT NULL DEFAULT 'NO',
  `ad_reviewed` date DEFAULT NULL,
  `vfc` varchar(255) NOT NULL DEFAULT '',
  `mothersname` varchar(255) NOT NULL DEFAULT '',
  `guardiansname` varchar(255) NOT NULL DEFAULT '',
  `allow_imm_reg_use` varchar(255) NOT NULL DEFAULT '',
  `allow_imm_info_share` varchar(255) NOT NULL DEFAULT '',
  `allow_health_info_ex` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `pid` (`pid`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `patient_reminders`
--

DROP TABLE IF EXISTS `patient_reminders`;
CREATE TABLE `patient_reminders` (
  `id` bigint(20) NOT NULL auto_increment,
  `active` tinyint(1) NOT NULL default 1 COMMENT '1 if active and 0 if not active',
  `date_inactivated` datetime DEFAULT NULL,
  `reason_inactivated` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_reminder_inactive_opt',
  `due_status` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_reminder_due_opt',
  `pid` bigint(20) NOT NULL COMMENT 'id from patient_data table',
  `category` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the category item in the rule_action_item table',
  `item` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the item column in the rule_action_item table',
  `date_created` datetime DEFAULT NULL,
  `date_sent` datetime DEFAULT NULL,
  `voice_status` tinyint(1) NOT NULL default 0 COMMENT '0 if not sent and 1 if sent',
  `sms_status` tinyint(1) NOT NULL default 0 COMMENT '0 if not sent and 1 if sent',
  `email_status` tinyint(1) NOT NULL default 0 COMMENT '0 if not sent and 1 if sent',
  `mail_status` tinyint(1) NOT NULL default 0 COMMENT '0 if not sent and 1 if sent',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY (`category`,`item`)
) ENGINE=MyISAM AUTO_INCREMENT=1;

-- --------------------------------------------------------

-- 
-- Table structure for table `payments`
-- 

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL auto_increment,
  `pid` bigint(20) NOT NULL default '0',
  `dtime` datetime NOT NULL,
  `encounter` bigint(20) NOT NULL default '0',
  `user` varchar(255) default NULL,
  `method` varchar(255) default NULL,
  `source` varchar(255) default NULL,
  `amount1` decimal(12,2) NOT NULL default '0.00',
  `amount2` decimal(12,2) NOT NULL default '0.00',
  `posted1` decimal(12,2) NOT NULL default '0.00',
  `posted2` decimal(12,2) NOT NULL default '0.00',
  PRIMARY KEY  (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pharmacies`
-- 

DROP TABLE IF EXISTS `pharmacies`;
CREATE TABLE `pharmacies` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(255) default NULL,
  `transmit_method` int(11) NOT NULL default '1',
  `email` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `phone_numbers`
-- 

DROP TABLE IF EXISTS `phone_numbers`;
CREATE TABLE `phone_numbers` (
  `id` int(11) NOT NULL default '0',
  `country_code` varchar(5) default NULL,
  `area_code` char(3) default NULL,
  `prefix` char(3) default NULL,
  `number` varchar(4) default NULL,
  `type` int(11) default NULL,
  `foreign_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `foreign_id` (`foreign_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `pma_bookmark`
-- 

DROP TABLE IF EXISTS `pma_bookmark`;
CREATE TABLE `pma_bookmark` (
  `id` int(11) NOT NULL auto_increment,
  `dbase` varchar(255) default NULL,
  `user` varchar(255) default NULL,
  `label` varchar(255) default NULL,
  `query` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM COMMENT='Bookmarks' AUTO_INCREMENT=10 ;

-- 
-- Dumping data for table `pma_bookmark`
-- 

INSERT INTO `pma_bookmark` VALUES (2, 'openemr', 'openemr', 'Aggregate Race Statistics', 'SELECT ethnoracial as "Race/Ethnicity", count(*) as Count FROM  `patient_data` WHERE 1 group by ethnoracial');
INSERT INTO `pma_bookmark` VALUES (9, 'openemr', 'openemr', 'Search by Code', 'SELECT  b.code, concat(pd.fname," ", pd.lname) as "Patient Name", concat(u.fname," ", u.lname) as "Provider Name", en.reason as "Encounter Desc.", en.date\r\nFROM billing as b\r\nLEFT JOIN users AS u ON b.user = u.id\r\nLEFT JOIN patient_data as pd on b.pid = pd.pid\r\nLEFT JOIN form_encounter as en on b.encounter = en.encounter and b.pid = en.pid\r\nWHERE 1 /* and b.code like ''%[VARIABLE]%'' */ ORDER BY b.code');
INSERT INTO `pma_bookmark` VALUES (8, 'openemr', 'openemr', 'Count No Shows By Provider since Interval ago', 'SELECT concat( u.fname,  " ", u.lname )  AS  "Provider Name", u.id AS  "Provider ID", count(  DISTINCT ev.pc_eid )  AS  "Number of No Shows"/* , concat(DATE_FORMAT(NOW(),''%Y-%m-%d''), '' and '',DATE_FORMAT(DATE_ADD(now(), INTERVAL [VARIABLE]),''%Y-%m-%d'') ) as "Between Dates" */ FROM  `openemr_postcalendar_events`  AS ev LEFT  JOIN users AS u ON ev.pc_aid = u.id WHERE ev.pc_catid =1/* and ( ev.pc_eventDate >= DATE_SUB(now(), INTERVAL [VARIABLE]) )  */\r\nGROUP  BY u.id;');
INSERT INTO `pma_bookmark` VALUES (6, 'openemr', 'openemr', 'Appointments By Race/Ethnicity from today plus interval', 'SELECT  count(pd.ethnoracial) as "Number of Appointments", pd.ethnoracial AS  "Race/Ethnicity" /* , concat(DATE_FORMAT(NOW(),''%Y-%m-%d''), '' and '',DATE_FORMAT(DATE_ADD(now(), INTERVAL [VARIABLE]),''%Y-%m-%d'') ) as "Between Dates" */ FROM openemr_postcalendar_events AS ev LEFT  JOIN   `patient_data`  AS pd ON  pd.pid = ev.pc_pid where ev.pc_eventstatus=1 and ev.pc_catid = 5 and ev.pc_eventDate >= now()  /* and ( ev.pc_eventDate <= DATE_ADD(now(), INTERVAL [VARIABLE]) )  */ group by pd.ethnoracial');

-- --------------------------------------------------------

-- 
-- Table structure for table `pma_column_info`
-- 

DROP TABLE IF EXISTS `pma_column_info`;
CREATE TABLE `pma_column_info` (
  `id` int(5) unsigned NOT NULL auto_increment,
  `db_name` varchar(64) default NULL,
  `table_name` varchar(64) default NULL,
  `column_name` varchar(64) default NULL,
  `comment` varchar(255) default NULL,
  `mimetype` varchar(255) default NULL,
  `transformation` varchar(255) default NULL,
  `transformation_options` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`)
) ENGINE=MyISAM COMMENT='Column Information for phpMyAdmin' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pma_history`
-- 

DROP TABLE IF EXISTS `pma_history`;
CREATE TABLE `pma_history` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `username` varchar(64) default NULL,
  `db` varchar(64) default NULL,
  `table` varchar(64) default NULL,
  `timevalue` timestamp NOT NULL,
  `sqlquery` text,
  PRIMARY KEY  (`id`),
  KEY `username` (`username`,`db`,`table`,`timevalue`)
) ENGINE=MyISAM COMMENT='SQL history' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pma_pdf_pages`
-- 

DROP TABLE IF EXISTS `pma_pdf_pages`;
CREATE TABLE `pma_pdf_pages` (
  `db_name` varchar(64) default NULL,
  `page_nr` int(10) unsigned NOT NULL auto_increment,
  `page_descr` varchar(50) default NULL,
  PRIMARY KEY  (`page_nr`),
  KEY `db_name` (`db_name`)
) ENGINE=MyISAM COMMENT='PDF Relationpages for PMA' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pma_relation`
-- 

DROP TABLE IF EXISTS `pma_relation`;
CREATE TABLE `pma_relation` (
  `master_db` varchar(64) NOT NULL default '',
  `master_table` varchar(64) NOT NULL default '',
  `master_field` varchar(64) NOT NULL default '',
  `foreign_db` varchar(64) default NULL,
  `foreign_table` varchar(64) default NULL,
  `foreign_field` varchar(64) default NULL,
  PRIMARY KEY  (`master_db`,`master_table`,`master_field`),
  KEY `foreign_field` (`foreign_db`,`foreign_table`)
) ENGINE=MyISAM COMMENT='Relation table';

-- --------------------------------------------------------

-- 
-- Table structure for table `pma_table_coords`
-- 

DROP TABLE IF EXISTS `pma_table_coords`;
CREATE TABLE `pma_table_coords` (
  `db_name` varchar(64) NOT NULL default '',
  `table_name` varchar(64) NOT NULL default '',
  `pdf_page_number` int(11) NOT NULL default '0',
  `x` float unsigned NOT NULL default '0',
  `y` float unsigned NOT NULL default '0',
  PRIMARY KEY  (`db_name`,`table_name`,`pdf_page_number`)
) ENGINE=MyISAM COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

-- 
-- Table structure for table `pma_table_info`
-- 

DROP TABLE IF EXISTS `pma_table_info`;
CREATE TABLE `pma_table_info` (
  `db_name` varchar(64) NOT NULL default '',
  `table_name` varchar(64) NOT NULL default '',
  `display_field` varchar(64) default NULL,
  PRIMARY KEY  (`db_name`,`table_name`)
) ENGINE=MyISAM COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

-- 
-- Table structure for table `pnotes`
-- 

DROP TABLE IF EXISTS `pnotes`;
CREATE TABLE `pnotes` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `body` longtext,
  `pid` bigint(20) default NULL,
  `user` varchar(255) default NULL,
  `groupname` varchar(255) default NULL,
  `activity` tinyint(4) default NULL,
  `authorized` tinyint(4) default NULL,
  `title` varchar(255) default NULL,
  `assigned_to` varchar(255) default NULL,
  `deleted` tinyint(4) default 0 COMMENT 'flag indicates note is deleted',
  `message_status` VARCHAR(20) NOT NULL DEFAULT 'New',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `prescriptions`
-- 

DROP TABLE IF EXISTS `prescriptions`;
CREATE TABLE `prescriptions` (
  `id` int(11) NOT NULL auto_increment,
  `patient_id` int(11) default NULL,
  `filled_by_id` int(11) default NULL,
  `pharmacy_id` int(11) default NULL,
  `date_added` date default NULL,
  `date_modified` date default NULL,
  `provider_id` int(11) default NULL,
  `start_date` date default NULL,
  `drug` varchar(150) default NULL,
  `drug_id` int(11) NOT NULL default '0',
  `form` int(3) default NULL,
  `dosage` varchar(100) default NULL,
  `quantity` varchar(31) default NULL,
  `size` float unsigned default NULL,
  `unit` int(11) default NULL,
  `route` int(11) default NULL,
  `interval` int(11) default NULL,
  `substitute` int(11) default NULL,
  `refills` int(11) default NULL,
  `per_refill` int(11) default NULL,
  `filled_date` date default NULL,
  `medication` int(11) default NULL,
  `note` text,
  `active` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `prices`
-- 

DROP TABLE IF EXISTS `prices`;
CREATE TABLE `prices` (
  `pr_id` varchar(11) NOT NULL default '',
  `pr_selector` varchar(255) NOT NULL default '' COMMENT 'template selector for drugs, empty for codes',
  `pr_level` varchar(31) NOT NULL default '',
  `pr_price` decimal(12,2) NOT NULL default '0.00' COMMENT 'price in local currency',
  PRIMARY KEY  (`pr_id`,`pr_selector`,`pr_level`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `registry`
-- 

DROP TABLE IF EXISTS `registry`;
CREATE TABLE `registry` (
  `name` varchar(255) default NULL,
  `state` tinyint(4) default NULL,
  `directory` varchar(255) default NULL,
  `id` bigint(20) NOT NULL auto_increment,
  `sql_run` tinyint(4) default NULL,
  `unpackaged` tinyint(4) default NULL,
  `date` datetime default NULL,
  `priority` int(11) default '0',
  `category` varchar(255) default NULL,
  `nickname` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 ;

-- 
-- Dumping data for table `registry`
-- 

INSERT INTO `registry` VALUES ('New Encounter Form', 1, 'newpatient', 1, 1, 1, '2003-09-14 15:16:45', 0, 'Administrative', '');
INSERT INTO `registry` VALUES ('Review of Systems Checks', 1, 'reviewofs', 9, 1, 1, '2003-09-14 15:16:45', 0, 'Clinical', '');
INSERT INTO `registry` VALUES ('Speech Dictation', 1, 'dictation', 10, 1, 1, '2003-09-14 15:16:45', 0, 'Clinical', '');
INSERT INTO `registry` VALUES ('SOAP', 1, 'soap', 11, 1, 1, '2005-03-03 00:16:35', 0, 'Clinical', '');
INSERT INTO `registry` VALUES ('Vitals', 1, 'vitals', 12, 1, 1, '2005-03-03 00:16:34', 0, 'Clinical', '');
INSERT INTO `registry` VALUES ('Review Of Systems', 1, 'ros', 13, 1, 1, '2005-03-03 00:16:30', 0, 'Clinical', '');
INSERT INTO `registry` VALUES ('Fee Sheet', 1, 'fee_sheet', 14, 1, 1, '2007-07-28 00:00:00', 0, 'Administrative', '');
INSERT INTO `registry` VALUES ('Misc Billing Options HCFA', 1, 'misc_billing_options', 15, 1, 1, '2007-07-28 00:00:00', 0, 'Administrative', '');
INSERT INTO `registry` VALUES ('Procedure Order', 1, 'procedure_order', 16, 1, 1, '2010-02-25 00:00:00', 0, 'Administrative', '');

-- --------------------------------------------------------

--
-- Table structure for table `rule_action`
--

DROP TABLE IF EXISTS `rule_action`;
CREATE TABLE `rule_action` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the id column in the clinical_rules table',
  `group_id` bigint(20) NOT NULL DEFAULT 1 COMMENT 'Contains group id to identify collection of targets in a rule',
  `category` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the category item in the rule_action_item table',
  `item` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the item column in the rule_action_item table',
  KEY  (`id`)
) ENGINE=MyISAM ;

--
-- Standard clinical rule actions
--
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_htn_bp_measure', 1, 'act_cat_measure', 'act_bp');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_tob_use_assess', 1, 'act_cat_assess', 'act_tobacco');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_tob_cess_inter', 1, 'act_cat_inter', 'act_tobacco');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_adult_wt_screen_fu', 1, 'act_cat_measure', 'act_wt');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_wt_assess_couns_child', 1, 'act_cat_measure', 'act_wt');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_wt_assess_couns_child', 2, 'act_cat_edu', 'act_wt');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_influenza_ge_50', 1, 'act_cat_treat', 'act_influvacc');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_pneumovacc_ge_65', 1, 'act_cat_treat', 'act_pneumovacc');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_dm_hemo_a1c', 1, 'act_cat_measure', 'act_hemo_a1c');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_dm_urine_alb', 1, 'act_cat_measure', 'act_urine_alb');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_dm_eye', 1, 'act_cat_exam', 'act_eye');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_dm_foot', 1, 'act_cat_exam', 'act_foot');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_cs_mammo', 1, 'act_cat_measure', 'act_mammo');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_cs_pap', 1, 'act_cat_exam', 'act_pap');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_cs_colon', 1, 'act_cat_assess', 'act_colon_cancer_screen');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_cs_prostate', 1, 'act_cat_assess', 'act_prostate_cancer_screen');
INSERT INTO `rule_action` ( `id`, `group_id`, `category`, `item` ) VALUES ('rule_inr_monitor', 1, 'act_cat_measure', 'act_lab_inr');

-- --------------------------------------------------------

--
-- Table structure for table `rule_action_item`
--

DROP TABLE IF EXISTS `rule_action_item`;
CREATE TABLE `rule_action_item` (
  `category` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_action_category',
  `item` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_action',
  `clin_rem_link` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom html link in clinical reminder widget',
  `reminder_message` text  NOT NULL DEFAULT '' COMMENT 'Custom message in patient reminder',
  `custom_flag` tinyint(1) NOT NULL default 0 COMMENT '1 indexed to rule_patient_data, 0 indexed within main schema',
  PRIMARY KEY  (`category`,`item`)
) ENGINE=MyISAM ;

INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_measure', 'act_bp', '', '', 0);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_assess', 'act_tobacco', '', '', 0);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_inter', 'act_tobacco', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_measure', 'act_wt', '', '', 0);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_edu', 'act_wt', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_treat', 'act_influvacc', '', '', 0);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_treat', 'act_pneumovacc', '', '', 0);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_measure', 'act_hemo_a1c', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_measure', 'act_urine_alb', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_exam', 'act_eye', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_exam', 'act_foot', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_measure', 'act_mammo', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_exam', 'act_pap', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_assess', 'act_colon_cancer_screen', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_assess', 'act_prostate_cancer_screen', '', '', 1);
INSERT INTO `rule_action_item` ( `category`, `item`, `clin_rem_link`, `reminder_message`, `custom_flag` ) VALUES ('act_cat_measure', 'act_lab_inr', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `rule_filter`
--

DROP TABLE IF EXISTS `rule_filter`;
CREATE TABLE `rule_filter` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the id column in the clinical_rules table',
  `include_flag` tinyint(1) NOT NULL default 0 COMMENT '0 is exclude and 1 is include',
  `required_flag` tinyint(1) NOT NULL default 0 COMMENT '0 is required and 1 is optional',
  `method` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_filters',
  `method_detail` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options lists rule__intervals',
  `value` varchar(255) NOT NULL DEFAULT '',
  KEY  (`id`)
) ENGINE=MyISAM ;

--
-- Standard clinical rule filters
--
-- Hypertension: Blood Pressure Measurement
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'CUSTOM::HTN');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::401.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::401.1');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::401.9');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::402.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::402.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::402.10');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::402.11');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::402.90');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::402.91');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::403.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::403.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::403.10');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::403.11');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::403.90');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::403.91');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.10');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.11');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.12');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.13');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.90');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.91');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.92');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::404.93');
-- Tobacco Use Assessment
-- no filters
-- Tobacco Cessation Intervention
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_cess_inter', 1, 1, 'filt_database', '', 'LIFESTYLE::tobacco::current');
-- Adult Weight Screening and Follow-Up
-- no filters
-- Weight Assessment and Counseling for Children and Adolescents
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_wt_assess_couns_child', 1, 1, 'filt_age_max', 'year', '18');
-- Influenza Immunization for Patients >= 50 Years Old
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_influenza_ge_50', 1, 1, 'filt_age_min', 'year', '50');
-- Pneumonia Vaccination Status for Older Adults
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_pneumovacc_ge_65', 1, 1, 'filt_age_min', 'year', '65');
-- Diabetes: Hemoglobin A1C
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'CUSTOM::diabetes');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.10');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.11');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.12');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.13');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.20');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.21');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.22');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.23');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.30');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.31');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.32');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.33');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.4');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.40');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.41');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.42');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.43');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.50');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.51');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.52');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.53');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.60');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.61');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.62');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.63');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.7');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.70');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.71');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.72');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.73');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.80');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.81');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.82');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.83');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.9');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.90');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.91');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.92');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.93');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::357.2');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.04');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.05');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.06');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::366.41');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.04');
-- Diabetes: Urine Microalbumin
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'CUSTOM::diabetes');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.10');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.11');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.12');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.13');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.20');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.21');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.22');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.23');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.30');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.31');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.32');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.33');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.4');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.40');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.41');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.42');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.43');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.50');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.51');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.52');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.53');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.60');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.61');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.62');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.63');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.7');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.70');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.71');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.72');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.73');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.80');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.81');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.82');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.83');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.9');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.90');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.91');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.92');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.93');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::357.2');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.04');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.05');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.06');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::366.41');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.04');
-- Diabetes: Eye Exam
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'CUSTOM::diabetes');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.10');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.11');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.12');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.13');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.20');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.21');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.22');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.23');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.30');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.31');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.32');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.33');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.4');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.40');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.41');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.42');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.43');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.50');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.51');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.52');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.53');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.60');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.61');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.62');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.63');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.7');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.70');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.71');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.72');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.73');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.80');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.81');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.82');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.83');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.9');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.90');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.91');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.92');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.93');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::357.2');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.04');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.05');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.06');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::366.41');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.04');
-- Diabetes: Foot Exam
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'CUSTOM::diabetes');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.10');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.11');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.12');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.13');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.20');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.21');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.22');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.23');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.30');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.31');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.32');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.33');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.4');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.40');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.41');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.42');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.43');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.50');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.51');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.52');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.53');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.60');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.61');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.62');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.63');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.7');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.70');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.71');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.72');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.73');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.80');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.81');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.82');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.83');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.9');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.90');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.91');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.92');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::250.93');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::357.2');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.04');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.05');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::362.06');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::366.41');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.0');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.00');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.01');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.02');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.03');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 1, 0, 'filt_lists', 'medical_problem', 'ICD9::648.04');
-- Cancer Screening: Mammogram
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_mammo', 1, 1, 'filt_age_min', 'year', '40');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_mammo', 1, 1, 'filt_sex', '', 'Female');
-- Cancer Screening: Pap Smear
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_pap', 1, 1, 'filt_age_min', 'year', '18');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_pap', 1, 1, 'filt_sex', '', 'Female');
-- Cancer Screening: Colon Cancer Screening
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_colon', 1, 1, 'filt_age_min', 'year', '50');
-- Cancer Screening: Prostate Cancer Screening
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_prostate', 1, 1, 'filt_age_min', 'year', '50');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_prostate', 1, 1, 'filt_sex', '', 'Male');
--
-- Rule filters to specifically demonstrate passing of NIST criteria
--
-- Coumadin Management - INR Monitoring
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_inr_monitor', 1, 0, 'filt_lists', 'medication', 'coumadin');
INSERT INTO `rule_filter` ( `id`, `include_flag`, `required_flag`, `method`, `method_detail`, `value` ) VALUES ('rule_inr_monitor', 1, 0, 'filt_lists', 'medication', 'warfarin');

-- --------------------------------------------------------

--
-- Table structure for table `rule_patient_data`
--

DROP TABLE IF EXISTS `rule_patient_data`;
CREATE TABLE `rule_patient_data` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime DEFAULT NULL,
  `pid` bigint(20) NOT NULL,
  `category` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the category item in the rule_action_item table',
  `item` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the item column in the rule_action_item table',
  `complete` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list yesno',
  `result` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`),
  KEY (`pid`),
  KEY (`category`,`item`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rule_reminder`
--

DROP TABLE IF EXISTS `rule_reminder`;
CREATE TABLE `rule_reminder` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the id column in the clinical_rules table',
  `method` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_reminder_methods',
  `method_detail` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_reminder_intervals',
  `value` varchar(255) NOT NULL DEFAULT '',
  KEY  (`id`)
) ENGINE=MyISAM ;

-- Hypertension: Blood Pressure Measurement
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_htn_bp_measure', 'patient_reminder_post', 'month', '1');
-- Tobacco Use Assessment
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_use_assess', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_use_assess', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_use_assess', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_use_assess', 'patient_reminder_post', 'month', '1');
-- Tobacco Cessation Intervention
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_cess_inter', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_cess_inter', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_cess_inter', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_tob_cess_inter', 'patient_reminder_post', 'month', '1');
-- Adult Weight Screening and Follow-Up
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_adult_wt_screen_fu', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_adult_wt_screen_fu', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_adult_wt_screen_fu', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_adult_wt_screen_fu', 'patient_reminder_post', 'month', '1');
-- Weight Assessment and Counseling for Children and Adolescents
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_wt_assess_couns_child', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_wt_assess_couns_child', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_wt_assess_couns_child', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_wt_assess_couns_child', 'patient_reminder_post', 'month', '1');
-- Influenza Immunization for Patients >= 50 Years Old
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_influenza_ge_50', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_influenza_ge_50', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_influenza_ge_50', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_influenza_ge_50', 'patient_reminder_post', 'month', '1');
-- Pneumonia Vaccination Status for Older Adults
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_pneumovacc_ge_65', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_pneumovacc_ge_65', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_pneumovacc_ge_65', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_pneumovacc_ge_65', 'patient_reminder_post', 'month', '1');
-- Diabetes: Hemoglobin A1C
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_hemo_a1c', 'patient_reminder_post', 'month', '1');
-- Diabetes: Urine Microalbumin
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_urine_alb', 'patient_reminder_post', 'month', '1');
-- Diabetes: Eye Exam
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_eye', 'patient_reminder_post', 'month', '1');
-- Diabetes: Foot Exam
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_dm_foot', 'patient_reminder_post', 'month', '1');
-- Cancer Screening: Mammogram
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_mammo', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_mammo', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_mammo', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_mammo', 'patient_reminder_post', 'month', '1');
-- Cancer Screening: Pap Smear
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_pap', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_pap', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_pap', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_pap', 'patient_reminder_post', 'month', '1');
-- Cancer Screening: Colon Cancer Screening
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_colon', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_colon', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_colon', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_colon', 'patient_reminder_post', 'month', '1');
-- Cancer Screening: Prostate Cancer Screening
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_prostate', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_prostate', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_prostate', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_cs_prostate', 'patient_reminder_post', 'month', '1');
-- Coumadin Management - INR Monitoring
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_inr_monitor', 'clinical_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_inr_monitor', 'clinical_reminder_post', 'month', '1');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_inr_monitor', 'patient_reminder_pre', 'week', '2');
INSERT INTO `rule_reminder` ( `id`, `method`, `method_detail`, `value` ) VALUES ('rule_inr_monitor', 'patient_reminder_post', 'month', '1');

-- --------------------------------------------------------

--
-- Table structure for table `rule_target`
--

DROP TABLE IF EXISTS `rule_target`;
CREATE TABLE `rule_target` (
  `id` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to the id column in the clinical_rules table',
  `group_id` bigint(20) NOT NULL DEFAULT 1 COMMENT 'Contains group id to identify collection of targets in a rule',
  `include_flag` tinyint(1) NOT NULL default 0 COMMENT '0 is exclude and 1 is include',
  `required_flag` tinyint(1) NOT NULL default 0 COMMENT '0 is required and 1 is optional',
  `method` varchar(31) NOT NULL DEFAULT '' COMMENT 'Maps to list_options list rule_targets', 
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'Data is dependent on the method',
  `interval` bigint(20) NOT NULL DEFAULT 0 COMMENT 'Only used in interval entries', 
  KEY  (`id`)
) ENGINE=MyISAM ;

--
-- Standard clinical rule targets
--
-- Hypertension: Blood Pressure Measurement
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_htn_bp_measure', 1, 1, 1, 'target_interval', 'year', 1);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_htn_bp_measure', 1, 1, 1, 'target_database', '::form_vitals::bps::::::ge::1', 0);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_htn_bp_measure', 1, 1, 1, 'target_database', '::form_vitals::bpd::::::ge::1', 0);
-- Tobacco Use Assessment
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_tob_use_assess', 1, 1, 1, 'target_database', 'LIFESTYLE::tobacco::', 0);
-- Tobacco Cessation Intervention
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_tob_cess_inter', 1, 1, 1, 'target_interval', 'year', 1);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_tob_cess_inter', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_inter::act_tobacco::YES::ge::1', 0);
-- Adult Weight Screening and Follow-Up
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_adult_wt_screen_fu', 1, 1, 1, 'target_database', '::form_vitals::weight::::::ge::2', 0);
-- Weight Assessment and Counseling for Children and Adolescents
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_wt_assess_couns_child', 1, 1, 1, 'target_database', '::form_vitals::weight::::::ge::1', 0);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_wt_assess_couns_child', 2, 1, 1, 'target_database', 'CUSTOM::act_cat_edu::act_wt::YES::ge::1', 0);
-- Influenza Immunization for Patients >= 50 Years Old
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_influenza_ge_50', 1, 1, 1, 'target_interval', 'flu_season', 1);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_influenza_ge_50', 1, 1, 0, 'target_database', '::immunizations::immunization_id::eq::30::ge::1', 0);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_influenza_ge_50', 1, 1, 0, 'target_database', '::immunizations::immunization_id::eq::31::ge::1', 0);
-- Pneumonia Vaccination Status for Older Adults
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_pneumovacc_ge_65', 1, 1, 0, 'target_database', '::immunizations::immunization_id::eq::19::ge::1', 0);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_pneumovacc_ge_65', 1, 1, 0, 'target_database', '::immunizations::immunization_id::eq::20::ge::1', 0);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_pneumovacc_ge_65', 1, 1, 0, 'target_database', '::immunizations::immunization_id::eq::21::ge::1', 0);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_pneumovacc_ge_65', 1, 1, 0, 'target_database', '::immunizations::immunization_id::eq::22::ge::1', 0);
-- Diabetes: Hemoglobin A1C
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_dm_hemo_a1c', 1, 1, 1, 'target_interval', 'month', 3);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_dm_hemo_a1c', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_measure::act_hemo_a1c::YES::ge::1', 0);
-- Diabetes: Urine Microalbumin
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_dm_urine_alb', 1, 1, 1, 'target_interval', 'year', 1);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_dm_urine_alb', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_measure::act_urine_alb::YES::ge::1', 0);
-- Diabetes: Eye Exam
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_dm_eye', 1, 1, 1, 'target_interval', 'year', 1);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_dm_eye', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_exam::act_eye::YES::ge::1', 0);
-- Diabetes: Foot Exam
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_dm_foot', 1, 1, 1, 'target_interval', 'year', 1);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_dm_foot', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_exam::act_foot::YES::ge::1', 0);
-- Cancer Screening: Mammogram
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_cs_mammo', 1, 1, 1, 'target_interval', 'year', 1);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_cs_mammo', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_measure::act_mammo::YES::ge::1', 0);
-- Cancer Screening: Pap Smear
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_cs_pap', 1, 1, 1, 'target_interval', 'year', 1);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_cs_pap', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_exam::act_pap::YES::ge::1', 0);
-- Cancer Screening: Colon Cancer Screening
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_cs_colon', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_assess::act_colon_cancer_screen::YES::ge::1', 0);
-- Cancer Screening: Prostate Cancer Screening
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_cs_prostate', 1, 1, 1, 'target_database', 'CUSTOM::act_cat_assess::act_prostate_cancer_screen::YES::ge::1', 0);
--
-- Rule targets to specifically demonstrate passing of NIST criteria
--
-- Coumadin Management - INR Monitoring
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_inr_monitor', 1, 1, 1, 'target_interval', 'week', 3);
INSERT INTO `rule_target` ( `id`, `group_id`, `include_flag`, `required_flag`, `method`, `value`, `interval` ) VALUES ('rule_inr_monitor', 1, 1, 1, 'target_proc', 'INR::::::::ge::1', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `sequences`
-- 

DROP TABLE IF EXISTS `sequences`;
CREATE TABLE `sequences` (
  `id` int(11) unsigned NOT NULL default '0'
) ENGINE=MyISAM;

-- 
-- Dumping data for table `sequences`
-- 

INSERT INTO `sequences` VALUES (1);

-- --------------------------------------------------------

-- 
-- Table structure for table `transactions`
-- 

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id`                      bigint(20)   NOT NULL auto_increment,
  `date`                    datetime     default NULL,
  `title`                   varchar(255) NOT NULL DEFAULT '',
  `body`                    longtext     NOT NULL DEFAULT '',
  `pid`                     bigint(20)   default NULL,
  `user`                    varchar(255) NOT NULL DEFAULT '',
  `groupname`               varchar(255) NOT NULL DEFAULT '',
  `authorized`              tinyint(4)   default NULL,
  `refer_date`              date         DEFAULT NULL,
  `refer_from`              int(11)      NOT NULL DEFAULT 0,
  `refer_to`                int(11)      NOT NULL DEFAULT 0,
  `refer_diag`              varchar(255) NOT NULL DEFAULT '',
  `refer_risk_level`        varchar(255) NOT NULL DEFAULT '',
  `refer_vitals`            tinyint(1)   NOT NULL DEFAULT 0,
  `refer_external`          tinyint(1)   NOT NULL DEFAULT 0,
  `refer_related_code`      varchar(255) NOT NULL DEFAULT '',
  `refer_reply_date`        date         DEFAULT NULL,
  `reply_date`              date         DEFAULT NULL,
  `reply_from`              varchar(255) NOT NULL DEFAULT '',
  `reply_init_diag`         varchar(255) NOT NULL DEFAULT '',
  `reply_final_diag`        varchar(255) NOT NULL DEFAULT '',
  `reply_documents`         varchar(255) NOT NULL DEFAULT '',
  `reply_findings`          text         NOT NULL DEFAULT '',
  `reply_services`          text         NOT NULL DEFAULT '',
  `reply_recommend`         text         NOT NULL DEFAULT '',
  `reply_rx_refer`          text         NOT NULL DEFAULT '',
  `reply_related_code`      varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL auto_increment,
  `username` varchar(255) default NULL,
  `password` longtext,
  `authorized` tinyint(4) default NULL,
  `info` longtext,
  `source` tinyint(4) default NULL,
  `fname` varchar(255) default NULL,
  `mname` varchar(255) default NULL,
  `lname` varchar(255) default NULL,
  `federaltaxid` varchar(255) default NULL,
  `federaldrugid` varchar(255) default NULL,
  `upin` varchar(255) default NULL,
  `facility` varchar(255) default NULL,
  `facility_id` int(11) NOT NULL default '0',
  `see_auth` int(11) NOT NULL default '1',
  `active` tinyint(1) NOT NULL default '1',
  `npi` varchar(15) default NULL,
  `title` varchar(30) default NULL,
  `specialty` varchar(255) default NULL,
  `billname` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `assistant` varchar(255) default NULL,
  `organization` varchar(255) default NULL,
  `valedictory` varchar(255) default NULL,
  `street` varchar(60) default NULL,
  `streetb` varchar(60) default NULL,
  `city` varchar(30) default NULL,
  `state` varchar(30) default NULL,
  `zip` varchar(20) default NULL,
  `street2` varchar(60) default NULL,
  `streetb2` varchar(60) default NULL,
  `city2` varchar(30) default NULL,
  `state2` varchar(30) default NULL,
  `zip2` varchar(20) default NULL,
  `phone` varchar(30) default NULL,
  `fax` varchar(30) default NULL,
  `phonew1` varchar(30) default NULL,
  `phonew2` varchar(30) default NULL,
  `phonecell` varchar(30) default NULL,
  `notes` text,
  `cal_ui` tinyint(4) NOT NULL default '1',
  `taxonomy` varchar(30) NOT NULL DEFAULT '207Q00000X',
  `ssi_relayhealth` varchar(64) NULL,
  `calendar` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1 = appears in calendar',
  `abook_type` varchar(31) NOT NULL DEFAULT '',
  `pwd_expiration_date` date default NULL,
  `pwd_history1` longtext default NULL,
  `pwd_history2` longtext default NULL,
  `default_warehouse` varchar(31) NOT NULL DEFAULT '',
  `irnpool` varchar(31) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE `user_settings` (
  `setting_user`  bigint(20)   NOT NULL DEFAULT 0,
  `setting_label` varchar(63)  NOT NULL,
  `setting_value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`setting_user`, `setting_label`)
) ENGINE=MyISAM;

--
-- Dumping data for table `user_settings`
--

INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'allergy_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'appointments_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'billing_ps_expand', '0');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'clinical_reminders_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'demographics_ps_expand', '0');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'dental_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'directives_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'disclosures_ps_expand', '0');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'immunizations_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'insurance_ps_expand', '0');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'medical_problem_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'medication_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'patient_reminders_ps_expand', '0');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'pnotes_ps_expand', '0');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'prescriptions_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'surgery_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'vitals_ps_expand', '1');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (0, 'gacl_protect', '0');
INSERT INTO user_settings ( setting_user, setting_label, setting_value ) VALUES (1, 'gacl_protect', '1');

-- --------------------------------------------------------

-- 
-- Table structure for table `x12_partners`
-- 

DROP TABLE IF EXISTS `x12_partners`;
CREATE TABLE `x12_partners` (
  `id` int(11) NOT NULL default '0',
  `name` varchar(255) default NULL,
  `id_number` varchar(255) default NULL,
  `x12_sender_id` varchar(255) default NULL,
  `x12_receiver_id` varchar(255) default NULL,
  `x12_version` varchar(255) default NULL,
  `processing_format` enum('standard','medi-cal','cms','proxymed') default NULL,
  `x12_isa05` char(2)     NOT NULL DEFAULT 'ZZ',
  `x12_isa07` char(2)     NOT NULL DEFAULT 'ZZ',
  `x12_isa14` char(1)     NOT NULL DEFAULT '0',
  `x12_isa15` char(1)     NOT NULL DEFAULT 'P',
  `x12_gs02`  varchar(15) NOT NULL DEFAULT '',
  `x12_per06` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM;

------------------------------------------------------------------------------------- 
-- Table structure for table `automatic_notification`
-- 

DROP TABLE IF EXISTS `automatic_notification`;
CREATE TABLE `automatic_notification` (
  `notification_id` int(5) NOT NULL auto_increment,
  `sms_gateway_type` varchar(255) NOT NULL,
  `next_app_date` date NOT NULL,
  `next_app_time` varchar(10) NOT NULL,
  `provider_name` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `email_sender` varchar(100) NOT NULL,
  `email_subject` varchar(100) NOT NULL,
  `type` enum('SMS','Email') NOT NULL default 'SMS',
  `notification_sent_date` datetime NOT NULL,
  PRIMARY KEY  (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `automatic_notification`
-- 

INSERT INTO `automatic_notification` (`notification_id`, `sms_gateway_type`, `next_app_date`, `next_app_time`, `provider_name`, `message`, `email_sender`, `email_subject`, `type`, `notification_sent_date`) VALUES (1, 'CLICKATELL', '0000-00-00', ':', 'EMR GROUP 1 .. SMS', 'Welcome to EMR GROUP 1.. SMS', '', '', 'SMS', '0000-00-00 00:00:00'),
(2, '', '2007-10-02', '05:50', 'EMR GROUP', 'Welcome to EMR GROUP . Email', 'EMR Group', 'Welcome to EMR GROUP', 'Email', '2007-09-30 00:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for table `notification_log`
-- 

DROP TABLE IF EXISTS `notification_log`;
CREATE TABLE `notification_log` (
  `iLogId` int(11) NOT NULL auto_increment,
  `pid` int(7) NOT NULL,
  `pc_eid` int(11) unsigned NULL,
  `sms_gateway_type` varchar(50) NOT NULL,
  `smsgateway_info` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `email_sender` varchar(255) NOT NULL,
  `email_subject` varchar(255) NOT NULL,
  `type` enum('SMS','Email') NOT NULL,
  `patient_info` text NOT NULL,
  `pc_eventDate` date NOT NULL,
  `pc_endDate` date NOT NULL,
  `pc_startTime` time NOT NULL,
  `pc_endTime` time NOT NULL,
  `dSentDateTime` datetime NOT NULL,
  PRIMARY KEY  (`iLogId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `notification_settings`
-- 

DROP TABLE IF EXISTS `notification_settings`;
CREATE TABLE `notification_settings` (
  `SettingsId` int(3) NOT NULL auto_increment,
  `Send_SMS_Before_Hours` int(3) NOT NULL,
  `Send_Email_Before_Hours` int(3) NOT NULL,
  `SMS_gateway_username` varchar(100) NOT NULL,
  `SMS_gateway_password` varchar(100) NOT NULL,
  `SMS_gateway_apikey` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY  (`SettingsId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `notification_settings`
-- 

INSERT INTO `notification_settings` (`SettingsId`, `Send_SMS_Before_Hours`, `Send_Email_Before_Hours`, `SMS_gateway_username`, `SMS_gateway_password`, `SMS_gateway_apikey`, `type`) VALUES (1, 150, 150, 'sms username', 'sms password', 'sms api key', 'SMS/Email Settings');

-- -------------------------------------------------------------------

CREATE TABLE chart_tracker (
  ct_pid            int(11)       NOT NULL,
  ct_when           datetime      NOT NULL,
  ct_userid         bigint(20)    NOT NULL DEFAULT 0,
  ct_location       varchar(31)   NOT NULL DEFAULT '',
  PRIMARY KEY (ct_pid, ct_when)
) ENGINE=MyISAM;

CREATE TABLE ar_session (
  session_id     int unsigned  NOT NULL AUTO_INCREMENT,
  payer_id       int(11)       NOT NULL            COMMENT '0=pt else references insurance_companies.id',
  user_id        int(11)       NOT NULL            COMMENT 'references users.id for session owner',
  closed         tinyint(1)    NOT NULL DEFAULT 0  COMMENT '0=no, 1=yes',
  reference      varchar(255)  NOT NULL DEFAULT '' COMMENT 'check or EOB number',
  check_date     date          DEFAULT NULL,
  deposit_date   date          DEFAULT NULL,
  pay_total      decimal(12,2) NOT NULL DEFAULT 0,
  created_time timestamp NOT NULL default CURRENT_TIMESTAMP,
  modified_time datetime NOT NULL,
  global_amount decimal( 12, 2 ) NOT NULL ,
  payment_type varchar( 50 ) NOT NULL ,
  description text NOT NULL ,
  adjustment_code varchar( 50 ) NOT NULL ,
  post_to_date date NOT NULL ,
  patient_id int( 11 ) NOT NULL ,
  payment_method varchar( 25 ) NOT NULL,
  PRIMARY KEY (session_id),
  KEY user_closed (user_id, closed),
  KEY deposit_date (deposit_date)
) ENGINE=MyISAM;

CREATE TABLE ar_activity (
  pid            int(11)       NOT NULL,
  encounter      int(11)       NOT NULL,
  sequence_no    int unsigned  NOT NULL AUTO_INCREMENT,
  code           varchar(9)    NOT NULL            COMMENT 'empty means claim level',
  modifier       varchar(5)    NOT NULL DEFAULT '',
  payer_type     int           NOT NULL            COMMENT '0=pt, 1=ins1, 2=ins2, etc',
  post_time      datetime      NOT NULL,
  post_user      int(11)       NOT NULL            COMMENT 'references users.id',
  session_id     int unsigned  NOT NULL            COMMENT 'references ar_session.session_id',
  memo           varchar(255)  NOT NULL DEFAULT '' COMMENT 'adjustment reasons go here',
  pay_amount     decimal(12,2) NOT NULL DEFAULT 0  COMMENT 'either pay or adj will always be 0',
  adj_amount     decimal(12,2) NOT NULL DEFAULT 0,
  modified_time datetime NOT NULL,
  follow_up char(1) NOT NULL,
  follow_up_note text NOT NULL,
  account_code varchar(15) NOT NULL,
  PRIMARY KEY (pid, encounter, sequence_no),
  KEY session_id (session_id)
) ENGINE=MyISAM;

CREATE TABLE `users_facility` (
  `tablename` varchar(64) NOT NULL,
  `table_id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  PRIMARY KEY (`tablename`,`table_id`,`facility_id`)
) ENGINE=InnoDB COMMENT='joins users or patient_data to facility table';

CREATE TABLE `lbf_data` (
  `form_id`     int(11)      NOT NULL AUTO_INCREMENT COMMENT 'references forms.form_id',
  `field_id`    varchar(31)  NOT NULL COMMENT 'references layout_options.field_id',
  `field_value` varchar(255) NOT NULL,
  PRIMARY KEY (`form_id`,`field_id`)
) ENGINE=MyISAM COMMENT='contains all data from layout-based forms';

CREATE TABLE gprelations (
  type1 int(2)     NOT NULL,
  id1   bigint(20) NOT NULL,
  type2 int(2)     NOT NULL,
  id2   bigint(20) NOT NULL,
  PRIMARY KEY (type1,id1,type2,id2),
  KEY key2  (type2,id2)
) ENGINE=MyISAM COMMENT='general purpose relations';

CREATE TABLE `procedure_type` (
  `procedure_type_id`   bigint(20)   NOT NULL AUTO_INCREMENT,
  `parent`              bigint(20)   NOT NULL DEFAULT 0  COMMENT 'references procedure_type.procedure_type_id',
  `name`                varchar(63)  NOT NULL DEFAULT '' COMMENT 'name for this category, procedure or result type',
  `lab_id`              bigint(20)   NOT NULL DEFAULT 0  COMMENT 'references users.id, 0 means default to parent',
  `procedure_code`      varchar(31)  NOT NULL DEFAULT '' COMMENT 'code identifying this procedure',
  `procedure_type`      varchar(31)  NOT NULL DEFAULT '' COMMENT 'see list proc_type',
  `body_site`           varchar(31)  NOT NULL DEFAULT '' COMMENT 'where to do injection, e.g. arm, buttok',
  `specimen`            varchar(31)  NOT NULL DEFAULT '' COMMENT 'blood, urine, saliva, etc.',
  `route_admin`         varchar(31)  NOT NULL DEFAULT '' COMMENT 'oral, injection',
  `laterality`          varchar(31)  NOT NULL DEFAULT '' COMMENT 'left, right, ...',
  `description`         varchar(255) NOT NULL DEFAULT '' COMMENT 'descriptive text for procedure_code',
  `standard_code`       varchar(255) NOT NULL DEFAULT '' COMMENT 'industry standard code type and code (e.g. CPT4:12345)',
  `related_code`        varchar(255) NOT NULL DEFAULT '' COMMENT 'suggested code(s) for followup services if result is abnormal',
  `units`               varchar(31)  NOT NULL DEFAULT '' COMMENT 'default for procedure_result.units',
  `range`               varchar(255) NOT NULL DEFAULT '' COMMENT 'default for procedure_result.range',
  `seq`                 int(11)      NOT NULL default 0  COMMENT 'sequence number for ordering',
  PRIMARY KEY (`procedure_type_id`),
  KEY parent (parent)
) ENGINE=MyISAM;

CREATE TABLE `procedure_order` (
  `procedure_order_id`     bigint(20)   NOT NULL AUTO_INCREMENT,
  `procedure_type_id`      bigint(20)   NOT NULL            COMMENT 'references procedure_type.procedure_type_id',
  `provider_id`            bigint(20)   NOT NULL DEFAULT 0  COMMENT 'references users.id',
  `patient_id`             bigint(20)   NOT NULL            COMMENT 'references patient_data.pid',
  `encounter_id`           bigint(20)   NOT NULL DEFAULT 0  COMMENT 'references form_encounter.encounter',
  `date_collected`         datetime     DEFAULT NULL        COMMENT 'time specimen collected',
  `date_ordered`           date         DEFAULT NULL,
  `order_priority`         varchar(31)  NOT NULL DEFAULT '',
  `order_status`           varchar(31)  NOT NULL DEFAULT '' COMMENT 'pending,routed,complete,canceled',
  `patient_instructions`   text         NOT NULL DEFAULT '',
  `activity`               tinyint(1)   NOT NULL DEFAULT 1  COMMENT '0 if deleted',
  `control_id`             bigint(20)   NOT NULL            COMMENT 'This is the CONTROL ID that is sent back from lab',
  PRIMARY KEY (`procedure_order_id`),
  KEY datepid (date_ordered, patient_id)
) ENGINE=MyISAM;

CREATE TABLE `procedure_report` (
  `procedure_report_id` bigint(20)     NOT NULL AUTO_INCREMENT,
  `procedure_order_id`  bigint(20)     DEFAULT NULL   COMMENT 'references procedure_order.procedure_order_id',
  `date_collected`      datetime       DEFAULT NULL,
  `date_report`         date           DEFAULT NULL,
  `source`              bigint(20)     NOT NULL DEFAULT 0  COMMENT 'references users.id, who entered this data',
  `specimen_num`        varchar(63)    NOT NULL DEFAULT '',
  `report_status`       varchar(31)    NOT NULL DEFAULT '' COMMENT 'received,complete,error',
  `review_status`       varchar(31)    NOT NULL DEFAULT 'received' COMMENT 'panding reivew status: received,reviewed',  
  PRIMARY KEY (`procedure_report_id`),
  KEY procedure_order_id (procedure_order_id)
) ENGINE=MyISAM; 

CREATE TABLE `procedure_result` (
  `procedure_result_id` bigint(20)   NOT NULL AUTO_INCREMENT,
  `procedure_report_id` bigint(20)   NOT NULL            COMMENT 'references procedure_report.procedure_report_id',
  `procedure_type_id`   bigint(20)   NOT NULL            COMMENT 'references procedure_type.procedure_type_id',
  `date`                datetime     DEFAULT NULL        COMMENT 'lab-provided date specific to this result',
  `facility`            varchar(255) NOT NULL DEFAULT '' COMMENT 'lab-provided testing facility ID',
  `units`               varchar(31)  NOT NULL DEFAULT '',
  `result`              varchar(255) NOT NULL DEFAULT '',
  `range`               varchar(255) NOT NULL DEFAULT '',
  `abnormal`            varchar(31)  NOT NULL DEFAULT '' COMMENT 'no,yes,high,low',
  `comments`            text         NOT NULL DEFAULT '' COMMENT 'comments from the lab',
  `document_id`         bigint(20)   NOT NULL DEFAULT 0  COMMENT 'references documents.id if this result is a document',
  `result_status`       varchar(31)  NOT NULL DEFAULT '' COMMENT 'preliminary, cannot be done, final, corrected, incompete...etc.',
  PRIMARY KEY (`procedure_result_id`),
  KEY procedure_report_id (procedure_report_id)
) ENGINE=MyISAM; 

CREATE TABLE `globals` (
  `gl_name`             varchar(63)    NOT NULL,
  `gl_index`            int(11)        NOT NULL DEFAULT 0,
  `gl_value`            varchar(255)   NOT NULL DEFAULT '',
  PRIMARY KEY (`gl_name`, `gl_index`)
) ENGINE=MyISAM; 

CREATE TABLE code_types (
  ct_key  varchar(15) NOT NULL           COMMENT 'short alphanumeric name',
  ct_id   int(11)     UNIQUE NOT NULL    COMMENT 'numeric identifier',
  ct_seq  int(11)     NOT NULL DEFAULT 0 COMMENT 'sort order',
  ct_mod  int(11)     NOT NULL DEFAULT 0 COMMENT 'length of modifier field',
  ct_just varchar(15) NOT NULL DEFAULT ''COMMENT 'ct_key of justify type, if any',
  ct_mask varchar(9)  NOT NULL DEFAULT ''COMMENT 'formatting mask for code values',
  ct_fee  tinyint(1)  NOT NULL default 0 COMMENT '1 if fees are used',
  ct_rel  tinyint(1)  NOT NULL default 0 COMMENT '1 if can relate to other code types',
  ct_nofs tinyint(1)  NOT NULL default 0 COMMENT '1 if to be hidden in the fee sheet',
  ct_diag tinyint(1)  NOT NULL default 0 COMMENT '1 if this is a diagnosis type',
  PRIMARY KEY (ct_key)
) ENGINE=MyISAM;
INSERT INTO code_types (ct_key, ct_id, ct_seq, ct_mod, ct_just, ct_fee, ct_rel, ct_nofs, ct_diag ) VALUES ('ICD9' , 2, 1, 2, ''    , 0, 0, 0, 1);
INSERT INTO code_types (ct_key, ct_id, ct_seq, ct_mod, ct_just, ct_fee, ct_rel, ct_nofs, ct_diag ) VALUES ('CPT4' , 1, 2, 2, 'ICD9', 1, 0, 0, 0);
INSERT INTO code_types (ct_key, ct_id, ct_seq, ct_mod, ct_just, ct_fee, ct_rel, ct_nofs, ct_diag ) VALUES ('HCPCS', 3, 3, 2, 'ICD9', 1, 0, 0, 0);

INSERT INTO list_options ( list_id, option_id, title, seq ) VALUES ('lists', 'code_types', 'Code Types', 1);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'disclosure_type','Disclosure Type', 3,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('disclosure_type', 'disclosure-treatment', 'Treatment', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('disclosure_type', 'disclosure-payment', 'Payment', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('disclosure_type', 'disclosure-healthcareoperations', 'Health Care Operations', 30, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'smoking_status','Smoking Status', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('smoking_status', '1', 'Current every day smoker', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('smoking_status', '2', 'Current some day smoker', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('smoking_status', '3', 'Former smoker', 30, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('smoking_status', '4', 'Never smoker', 40, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('smoking_status', '5', 'Smoker, current status unknown', 50, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('smoking_status', '9', 'Unknown if ever smoked', 60, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'race','Race', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('race', 'amer_ind_or_alaska_native', 'American Indian or Alaska Native', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('race', 'Asian', 'Asian',20,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('race', 'black_or_afri_amer', 'Black or African American',30,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('race', 'native_hawai_or_pac_island', 'Native Hawaiian or Other Pacific Islander',40,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('race', 'white', 'White',50,0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'ethnicity','Ethnicity', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethnicity', 'hisp_or_latin', 'Hispanic or Latino', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('ethnicity', 'not_hisp_or_latin', 'Not Hispanic or Latino', 10, 0);

INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('lists'   ,'payment_date','Payment Date', 1,0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_date', 'date_val', 'Date', 10, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_date', 'post_to_date', 'Post To Date', 20, 0);
INSERT INTO list_options ( list_id, option_id, title, seq, is_default ) VALUES ('payment_date', 'deposit_date', 'Deposit Date', 30, 0);
-- --------------------------------------------------------

-- 
-- Table structure for table `extended_log`
--

DROP TABLE IF EXISTS `extended_log`;
CREATE TABLE `extended_log` (
  `id` bigint(20) NOT NULL auto_increment,
  `date` datetime default NULL,
  `event` varchar(255) default NULL,
  `user` varchar(255) default NULL,
  `recipient` varchar(255) default NULL,
  `description` longtext,
  `patient_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 ;

CREATE TABLE version (
  v_major    int(11)     NOT NULL DEFAULT 0,
  v_minor    int(11)     NOT NULL DEFAULT 0,
  v_patch    int(11)     NOT NULL DEFAULT 0,
  v_tag      varchar(31) NOT NULL DEFAULT '',
  v_database int(11)     NOT NULL DEFAULT 0
) ENGINE=MyISAM;
INSERT INTO version (v_major, v_minor, v_patch, v_tag, v_database) VALUES (0, 0, 0, '', 0);

DROP TABLE IF EXISTS `erx_medispan_db`;

CREATE TABLE `erx_medispan_db` (

  `DispensableDrugID` int(11) default NULL,

  `TradeDrugDesc` varchar(50) default NULL,

  `TradeDrugName` varchar(50) default NULL,

  `DrugName` varchar(50) default NULL,

  `StrengthValue` varchar(50) default NULL,

  `StrengthUnit` varchar(50) default NULL,

  `StrengthDesc` varchar(50) default NULL,

  `DosageFormCode` varchar(50) default NULL,

  `DosageFormCodeDesc` varchar(50) default NULL,

  `RouteCode` varchar(50) default NULL,

  `RouteDesc` varchar(50) default NULL,

  `DEAClassCode` varchar(50) default NULL,

  `DEAClassDesc` varchar(50) default NULL,

  `TherapeuticClassCode` varchar(50) default NULL,

  `TherapeuticClassDesc` varchar(50) default NULL,

  `RxOrOTCInd` varchar(50) default NULL,

  `GenericOrBrandedInd` varchar(50) default NULL,

  `ObsoleteDate` varchar(50) default NULL,

  `HistoricalInd` varchar(50) default NULL,

  `RepackageInd` varchar(50) default NULL,

  `DeviceInd` varchar(50) default NULL,

  `ImageInd` varchar(50) default NULL,

  `sigDescription` varchar(50) default NULL

) ENGINE=INNODB DEFAULT CHARSET=utf8;



/*Data for the table `erx_medispan_db` */



insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (3,'1+1-F Creme External Cream 3-1-1 %','1+1-F Creme','drug name','3-1-1','%','3-1-1 %','18','Cream','5','External','0','','840408','Antifungals','1','1','19960702','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (5,'1000BC Injection Injectable','1000BC','drug name','','',' ','40','Injectable','9','Injection','0','','882800','Multivitamin Preparations','1','1','19980215','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (6,'12 Hour Antihist/Decongestant Oral Tablet Extended','12 Hour Antihist/Decongestant','drug name','6-120','MG','6-120 MG','85','Tablet Extended Release 12 Hour','24','Oral','0','','040420','Propylamine Derivatives','2','1','20070210','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (8,'12 Hour Nasal Spray Nasal Solution 0.05 %','12 Hour Nasal Spray','drug name','0.05','%','0.05 %','70','Solution','22','Nasal','0','','523200','Vasoconstrictors','2','1','','0','2','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (9,'12 Hour Nasal Oral Tablet Extended Release 12 Hour','12 Hour Nasal','drug name','6-120','MG','6-120 MG','85','Tablet Extended Release 12 Hour','24','Oral','0','','040420','Propylamine Derivatives','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (10,'12 Hour Nasal Decongestant Oral Tablet Extended Re','12 Hour Nasal Decongestant','drug name','12-75','MG','12-75 MG','85','Tablet Extended Release 12 Hour','24','Oral','0','','040420','Propylamine Derivatives','2','1','20010930','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (16,'20/20 Eye Products Ophthalmic Solution 0.012-0.06 ','20/20 Eye Products','drug name','0.012-0.06','%','0.012-0.06 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (19,'3-in-1 Mixing Container Miscellaneous','3-in-1 Mixing Container','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (20,'3H W/R Oral Tablet 25-15-0.1 MG','3H W/R','drug name','25-15-0.1','MG','25-15-0.1 MG','81','Tablet','24','Oral','0','','240892','Hypotensive Agents, Miscellaneous','1','1','19980624','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (21,'3M Air Warming Mask Miscellaneous','3M Air Warming Mask','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (22,'3M Cold Pack Miscellaneous','3M Cold Pack','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (23,'3M Cold Pack Plus Miscellaneous','3M Cold Pack Plus','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (24,'3M Dust/Pollen Mask Miscellaneous','3M Dust/Pollen Mask','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (25,'3M Germ Mask Miscellaneous','3M Germ Mask','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (26,'3M Hot Pack Miscellaneous','3M Hot Pack','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (27,'3M Tegasorb Large Oval External Miscellaneous','3M Tegasorb Large Oval','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (28,'3M Tegasorb Large Square External Miscellaneous','3M Tegasorb Large Square','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (29,'3M Tegasorb Medium Oval External Miscellaneous','3M Tegasorb Medium Oval','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (30,'3M Tegasorb Small Oval External Miscellaneous','3M Tegasorb Small Oval','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (31,'3M Tegasorb Small Square External Miscellaneous','3M Tegasorb Small Square','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (34,'4-Way Nasal Long Lasting Spray Nasal Solution 0.05','4-Way Nasal Long Lasting Spray','drug name','0.05','%','0.05 %','70','Solution','22','Nasal','0','','523200','Vasoconstrictors','2','1','20070501','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (36,'4-Way Nasal Spray Nasal Solution 0.05 %','4-Way Nasal Spray','drug name','0.05','%','0.05 %','70','Solution','22','Nasal','0','','523200','Vasoconstrictors','2','1','20071201','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (38,'666 Cold Oral Tablet','666 Cold','drug name','','',' ','81','Tablet','24','Oral','0','','121204','alpha-Adrenergic Agonists','2','1','20010930','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (40,'666 Preparation/Quinine Oral Liquid','666 Preparation/Quinine','drug name','','',' ','45','Liquid','24','Oral','0','','','','2','1','19980501','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (41,'8-Mop Oral Capsule 10 MG','8-Mop','drug name','10','MG','10 MG','8','Capsule','24','Oral','0','','845006','Pigmenting Agents','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (52,'A-200 Combination Kit 0.5-0.33-4 %','A-200','drug name','0.5-0.33-4','%','0.5-0.33-4 %','43','Kit','2','Combination','0','','840412','Scabicides and Pediculicides','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (54,'A-4 High Compression Mens Hose Miscellaneous','A-4 High Compression Mens Hose','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (57,'A-Fil External Cream 5-5 %','A-Fil','drug name','5-5','%','5-5 %','18','Cream','5','External','0','','848000','Sunscreen Agents','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (58,'A-Hydrocort Injection Solution Reconstituted 100 M','A-Hydrocort','drug name','100','MG','100 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (59,'A-Hydrocort Injection Solution Reconstituted 1000 ','A-Hydrocort','drug name','1000','MG','1000 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20020920','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (60,'A-Hydrocort Injection Solution Reconstituted 250 M','A-Hydrocort','drug name','250','MG','250 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20040318','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (61,'A-Hydrocort Injection Solution Reconstituted 500 M','A-Hydrocort','drug name','500','MG','500 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20051018','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (62,'A-Methapred Injection Solution Reconstituted 1000 ','A-Methapred','drug name','1000','MG','1000 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20040318','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (63,'A-Methapred Injection Solution Reconstituted 125 M','A-Methapred','drug name','125','MG','125 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (64,'A-Methapred Injection Solution Reconstituted 40 MG','A-Methapred','drug name','40','MG','40 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (65,'A-Methapred Injection Solution Reconstituted 500 M','A-Methapred','drug name','500','MG','500 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20040318','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (67,'A-Nuric Diuretic Oral Tablet','A-Nuric Diuretic','drug name','','',' ','81','Tablet','24','Oral','0','','402892','Diuretics, Miscellaneous','2','1','20010102','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (68,'A-Phedrin Oral Syrup 1.25-30 MG/5ML','A-Phedrin','drug name','1.25-30','MG/5ML','1.25-30 MG/5ML','80','Syrup','24','Oral','0','','040420','Propylamine Derivatives','2','1','20040219','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (69,'ECK A-Phedrin Oral Capsule 2.5-60 MG','ECK A-Phedrin','drug name','2.5-60','MG','2.5-60 MG','8','Capsule','24','Oral','0','','040420','Propylamine Derivatives','2','1','20070731','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (77,'A.E.R. Witch Hazel External Pad','A.E.R. Witch Hazel','drug name','','',' ','56','Pad','5','External','0','','842412','Basic Ointments and Protectants','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (82,'A.P.L. Injection Solution Reconstituted 20000 U','A.P.L.','drug name','20000','U','20000 U','71','Solution Reconstituted','9','Injection','0','','681800','Gonadotropins','1','1','20010206','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (83,'A.P.L. Intramuscular Solution Reconstituted 10000 ','A.P.L.','drug name','10000','U','10000 U','71','Solution Reconstituted','11','Intramuscular','0','','681800','Gonadotropins','1','1','20010308','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (84,'A.P.L. Intramuscular Solution Reconstituted 5000 U','A.P.L.','drug name','5000','U','5000 U','71','Solution Reconstituted','11','Intramuscular','0','','681800','Gonadotropins','1','1','20010313','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (85,'A.R.M. Oral Tablet 4-25 MG','A.R.M.','drug name','4-25','MG','4-25 MG','81','Tablet','24','Oral','0','','040420','Propylamine Derivatives','2','1','20010930','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (86,'A/B Otic Otic Solution 1.4-5.4 %','A/B Otic','drug name','1.4-5.4','%','1.4-5.4 %','70','Solution','25','Otic','0','','521600','Local Anesthetics','1','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (87,'A/G Pro Oral Tablet','A/G Pro','drug name','','',' ','81','Tablet','24','Oral','0','','402000','Caloric Agents','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (88,'A/T/S External Gel 2 %','A/T/S','drug name','2','%','2 %','34','Gel','5','External','0','','840404','Antibacterials','1','1','20041112','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (89,'A/T/S External Solution 2 %','A/T/S','drug name','2','%','2 %','70','Solution','5','External','0','','840404','Antibacterials','1','1','20031130','1','1','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (94,'ABC-Z Oral Tablet Extended Release','ABC-Z','drug name','','',' ','87','Tablet Extended Release','24','Oral','0','','882800','Multivitamin Preparations','2','1','20010102','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (105,'ADC-Fluoride Oral Solution 0.5 MG/ML','ADC-Fluoride','drug name','0.5','MG/ML','0.5 MG/ML','70','Solution','24','Oral','0','','882800','Multivitamin Preparations','1','0','19990401','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (108,'ADC-Fluoride Oral Solution 0.25 MG/ML','ADC-Fluoride','drug name','0.25','MG/ML','0.25 MG/ML','70','Solution','24','Oral','0','','882800','Multivitamin Preparations','1','0','19990401','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (114,'AK-Cide Ophthalmic Ointment 10-0.5 %','AK-Cide','drug name','10-0.5','%','10-0.5 %','54','Ointment','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20030826','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (115,'AK-Cide Ophthalmic Suspension 10-0.5 %','AK-Cide','drug name','10-0.5','%','10-0.5 %','77','Suspension','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20030131','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (116,'AK-Con Ophthalmic Solution 0.1 %','AK-Con','drug name','0.1','%','0.1 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','1','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (120,'AK-Dex Ophthalmic Solution 0.1 %','AK-Dex','drug name','0.1','%','0.1 %','70','Solution','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20031030','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (121,'AK-Dilate Ophthalmic Solution 10 %','AK-Dilate','drug name','10','%','10 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (122,'AK-Dilate Ophthalmic Solution 2.5 %','AK-Dilate','drug name','2.5','%','2.5 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (123,'AK-Fluor Injection Solution 10 %','AK-Fluor','drug name','10','%','10 %','70','Solution','9','Injection','0','','365800','Ocular Disorders','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (124,'AK-Fluor Injection Solution 25 %','AK-Fluor','drug name','25','%','25 %','70','Solution','9','Injection','0','','365800','Ocular Disorders','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (128,'AK-NaCl Ophthalmic Ointment 5 %','AK-NaCl','drug name','5','%','5 %','54','Ointment','23','Ophthalmic','0','','529200','EENT Drugs, Miscellaneous','2','1','20040520','1','1','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (129,'AK-NaCl Ophthalmic Solution 5 %','AK-NaCl','drug name','5','%','5 %','70','Solution','23','Ophthalmic','0','','529200','EENT Drugs, Miscellaneous','2','1','19990625','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (130,'AK-Nefrin Ophthalmic Solution 0.125 %','AK-Nefrin','drug name','0.125','%','0.125 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','2','1','20020425','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (132,'AK-Neo-Dex Ophthalmic Solution 0.5-0.1 %','AK-Neo-Dex','drug name','0.5-0.1','%','0.5-0.1 %','70','Solution','23','Ophthalmic','0','','520808','Corticosteroids','1','1','19990601','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (134,'AK-Pentolate Ophthalmic Solution 1 %','AK-Pentolate','drug name','1','%','1 %','70','Solution','23','Ophthalmic','0','','522400','Mydriatics','1','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (135,'AK-Poly-Bac Ophthalmic Ointment 500-10000 UNIT/GM','AK-Poly-Bac','drug name','500-10000','UNIT/GM','500-10000 UNIT/GM','54','Ointment','23','Ophthalmic','0','','520404','Antibacterials','1','1','','0','0','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (137,'AK-Pred Ophthalmic Solution 1 %','AK-Pred','drug name','1','%','1 %','70','Solution','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20040206','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (139,'AK-Rinse Ophthalmic Solution','AK-Rinse','drug name','','',' ','70','Solution','23','Ophthalmic','0','','529200','EENT Drugs, Miscellaneous','2','1','20050831','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (140,'AK-Spore Ophthalmic Solution 1.75-5000-0.025','AK-Spore','drug name','1.75-5000-0.025','','1.75-5000-0.025 ','70','Solution','23','Ophthalmic','0','','520404','Antibacterials','1','0','20010531','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (142,'AK-Spore HC Ophthalmic Ointment 1 %','AK-Spore HC','drug name','1','%','1 %','54','Ointment','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20030131','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (143,'AK-Spore HC Otic Solution 1-5-10000','AK-Spore HC','drug name','1-5-10000','','1-5-10000 ','70','Solution','25','Otic','0','','520808','Corticosteroids','1','1','20010531','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (145,'AK-Spore Ophthalmic Ointment 5-400-10000','AK-Spore','drug name','5-400-10000','','5-400-10000 ','54','Ointment','23','Ophthalmic','0','','520404','Antibacterials','1','0','20040618','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (146,'AK-Sulf Ophthalmic Ointment 10 %','AK-Sulf','drug name','10','%','10 %','54','Ointment','23','Ophthalmic','0','','520404','Antibacterials','1','1','20030409','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (147,'AK-Sulf Ophthalmic Solution 10 %','AK-Sulf','drug name','10','%','10 %','70','Solution','23','Ophthalmic','0','','520404','Antibacterials','1','1','20021101','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (150,'AK-T-Caine Ophthalmic Solution 0.5 %','AK-T-Caine','drug name','0.5','%','0.5 %','70','Solution','23','Ophthalmic','0','','521600','Local Anesthetics','1','1','20030409','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (151,'AK-Taine Ophthalmic Solution 0.5 %','AK-Taine','drug name','0.5','%','0.5 %','70','Solution','23','Ophthalmic','0','','521600','Local Anesthetics','1','0','19950411','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (153,'AK-Tracin Ophthalmic Ointment 500 U/GM','AK-Tracin','drug name','500','U/GM','500 U/GM','54','Ointment','23','Ophthalmic','0','','520404','Antibacterials','1','1','20011130','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (155,'AK-Trol Ophthalmic Suspension 0.5-10000-0.1','AK-Trol','drug name','0.5-10000-0.1','','0.5-10000-0.1 ','77','Suspension','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20041123','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (159,'APAP Oral Solution 160 MG/5ML','APAP','drug name','160','MG/5ML','160 MG/5ML','70','Solution','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','20070921','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (161,'APAP Childrens Oral Suspension 160 MG/5ML','APAP Childrens','drug name','160','MG/5ML','160 MG/5ML','77','Suspension','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','20000622','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (162,'APAP Child Oral Tablet Chewable 80 MG','APAP Child','drug name','80','MG','80 MG','9','Tablet Chewable','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','1','19990101','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (164,'APAP Drops Oral Solution 100 MG/ML','APAP Drops','drug name','100','MG/ML','100 MG/ML','70','Solution','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','0','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (165,'APAP Extra Strength Oral Tablet 500 MG','APAP Extra Strength','drug name','500','MG','500 MG','81','Tablet','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (175,'APDC Cold Oral Tablet','APDC Cold','drug name','','',' ','81','Tablet','24','Oral','0','','480800','Antitussives','2','1','20010930','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (180,'ASA/Butal/Caff w/Codeine Oral Capsule','ASA/Butal/Caff w/Codeine','drug name','','',' ','8','Capsule','24','Oral','3','Schedule III','280808','Opiate Agonists','1','0','19910826','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (182,'AVC Vaginal Vaginal Suppository 1.05 GM','AVC Vaginal','drug name','1.05','GM','1.05 GM','76','Suppository','33','Vaginal','0','','840492','Local Anti-infectives, Miscellaneous','1','1','20030430','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (183,'AVC Vaginal Vaginal Cream 15 %','AVC Vaginal','drug name','15','%','15 %','18','Cream','33','Vaginal','0','','840492','Local Anti-infectives, Miscellaneous','1','1','','0','2','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (184,'Aapri Gentle Scrub External Miscellaneous','Aapri Gentle Scrub','drug name','','',' ','50','Miscellaneous','5','External','0','','842000','Detergents','2','1','20010104','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (185,'Aapri Original Scrub External Miscellaneous','Aapri Original Scrub','drug name','','',' ','50','Miscellaneous','5','External','0','','842000','Detergents','2','1','20010104','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (186,'Abbocath-T Miscellaneous','Abbocath-T','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (187,'Abbocath-T/Syringe Miscellaneous','Abbocath-T/Syringe','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','1','1','','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (188,'Abbokinase Injection Solution Reconstituted 250000','Abbokinase','drug name','250000','UNIT','250000 UNIT','71','Solution Reconstituted','9','Injection','0','','201220','Thrombolytic Agents','1','1','20080407','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (189,'Abbokinase Injection Solution Reconstituted 5000 U','Abbokinase','drug name','5000','U','5000 U','71','Solution Reconstituted','9','Injection','0','','201220','Thrombolytic Agents','1','1','20000102','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (190,'Abbott Sanitary Tray Miscellaneous','Abbott Sanitary Tray','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (194,'Absorbine Antifungal External Cream 2 %','Absorbine Antifungal','drug name','2','%','2 %','18','Cream','5','External','0','','840408','Antifungals','2','1','20080519','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (198,'Absorbine Jr External Liquid','Absorbine Jr','drug name','','',' ','45','Liquid','5','External','0','','842404','Basic Lotions and Liniments','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (199,'Absorbine Jr External Solution 1 %','Absorbine Jr','drug name','1','%','1 %','70','Solution','5','External','0','','840408','Antifungals','2','1','20080519','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (200,'Acacia Powder','Acacia','drug name','','',' ','59','Powder','35','','0','','960000','Pharmaceutical Aids','3','0','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (204,'Accu-Chek Easy Diabetes Care Kit','Accu-Chek Easy Diabetes Care','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','19990428','1','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (206,'Accu-Chek Easy Hospital Test Kit','Accu-Chek Easy Hospital Test','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','19990428','1','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (207,'Accu-Chek II Accu-Drop Miscellaneous','Accu-Chek II Accu-Drop','drug name','','',' ','50','Miscellaneous','35','','0','','','','2','1','19990428','1','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (213,'Accu-Chek II Hospital Testing Miscellaneous','Accu-Chek II Hospital Testing','drug name','','',' ','50','Miscellaneous','35','','0','','','','2','1','19990428','1','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (215,'Accu-Chek III Diabetes Meter Miscellaneous','Accu-Chek III Diabetes Meter','drug name','','',' ','50','Miscellaneous','35','','0','','','','2','1','19990602','1','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (216,'Accu-Chek III Hospital Test Kit','Accu-Chek III Hospital Test','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','19990428','1','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (217,'Accu-Chek III Kit','Accu-Chek III','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','19990602','1','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (219,'Accu-Pro Add-On Set Miscellaneous','Accu-Pro Add-On Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (220,'Accu-Pro Fat Emulsion Set Miscellaneous','Accu-Pro Fat Emulsion Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (221,'Accu-Pro Mini-Drop Set Miscellaneous','Accu-Pro Mini-Drop Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (222,'Accu-Pro Nitroglycerin Set Miscellaneous','Accu-Pro Nitroglycerin Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (223,'Accu-Pro Pump Set Miscellaneous','Accu-Pro Pump Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (224,'Accu-Pro Pump Set/Check Valve Miscellaneous','Accu-Pro Pump Set/Check Valve','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (225,'Accu-Pro Pump Set/Filter Miscellaneous','Accu-Pro Pump Set/Filter','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (227,'Accu-Pro Pump Set/Roller Clamp Miscellaneous','Accu-Pro Pump Set/Roller Clamp','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (228,'Accu-Pro Pump Set/Vent Miscellaneous','Accu-Pro Pump Set/Vent','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (229,'Accu-Pro Y-Type Blood Set Miscellaneous','Accu-Pro Y-Type Blood Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','1','1','20060628','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (232,'Accupril Oral Tablet 10 MG','Accupril','drug name','10','MG','10 MG','81','Tablet','24','Oral','0','','243204','Angiotensin-Converting Enzyme Inhibitors','1','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (233,'Accupril Oral Tablet 20 MG','Accupril','drug name','20','MG','20 MG','81','Tablet','24','Oral','0','','243204','Angiotensin-Converting Enzyme Inhibitors','1','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (234,'Accupril Oral Tablet 40 MG','Accupril','drug name','40','MG','40 MG','81','Tablet','24','Oral','0','','243204','Angiotensin-Converting Enzyme Inhibitors','1','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (235,'Accupril Oral Tablet 5 MG','Accupril','drug name','5','MG','5 MG','81','Tablet','24','Oral','0','','243204','Angiotensin-Converting Enzyme Inhibitors','1','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (239,'Accusens T Taste Function Kit','Accusens T Taste Function','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','20010102','1','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (240,'Accutane Oral Capsule 10 MG','Accutane','drug name','10','MG','10 MG','8','Capsule','24','Oral','0','','849200','Skin and Mucous Membrane Agents, Misc','1','1','','0','0','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (241,'Accutane Oral Capsule 20 MG','Accutane','drug name','20','MG','20 MG','8','Capsule','24','Oral','0','','849200','Skin and Mucous Membrane Agents, Misc','1','1','','0','0','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (242,'Accutane Oral Capsule 40 MG','Accutane','drug name','40','MG','40 MG','8','Capsule','24','Oral','0','','849200','Skin and Mucous Membrane Agents, Misc','1','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (245,'ACE Athletic Bandage Miscellaneous','ACE Athletic Bandage','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (247,'ACE Bandage Miscellaneous','ACE Bandage','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (250,'ACE Cold Compress Miscellaneous','ACE Cold Compress','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (265,'Ace+Z Oral Tablet','Ace+Z','drug name','','',' ','81','Tablet','24','Oral','0','','','','2','1','19990326','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (267,'Acel-Imune Adsorbed Intramuscular Injectable 7.5-4','Acel-Imune Adsorbed','drug name','7.5-40-5','LFU/0.5ML','7.5-40-5 LFU/0.5ML','40','Injectable','11','Intramuscular','0','','800800','Toxoids','1','1','20010115','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (268,'Acephen Rectal Suppository 120 MG','Acephen','drug name','120','MG','120 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (269,'Acephen Rectal Suppository 325 MG','Acephen','drug name','325','MG','325 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (270,'Acephen Rectal Suppository 650 MG','Acephen','drug name','650','MG','650 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','0','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (273,'Acerola-C Oral Tablet 300 MG','Acerola-C','drug name','300','MG','300 MG','81','Tablet','24','Oral','0','','881200','Vitamin C','2','1','20010102','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (275,'Aceta-Gesic Oral Tablet 30-325 MG','Aceta-Gesic','drug name','30-325','MG','30-325 MG','81','Tablet','24','Oral','0','','040404','Ethanolamine Derivatives','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (276,'Acetaminophen Oral Capsule 500 MG','Acetaminophen','drug name','500','MG','500 MG','8','Capsule','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (277,'Acetaminophen Oral Tablet Chewable 80 MG','Acetaminophen','drug name','80','MG','80 MG','9','Tablet Chewable','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (278,'Acetaminophen Oral Elixir 120 MG/5ML','Acetaminophen','drug name','120','MG/5ML','120 MG/5ML','26','Elixir','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','20000217','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (282,'Acetaminophen Oral Solution 160 MG/5ML','Acetaminophen','drug name','160','MG/5ML','160 MG/5ML','70','Solution','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','0','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (283,'Acetaminophen Oral Tablet 325 MG','Acetaminophen','drug name','325','MG','325 MG','81','Tablet','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (284,'Acetaminophen Oral Tablet 500 MG','Acetaminophen','drug name','500','MG','500 MG','81','Tablet','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (286,'Acetaminophen Rectal Suppository 120 MG','Acetaminophen','drug name','120','MG','120 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (288,'Acetaminophen Rectal Suppository 325 MG','Acetaminophen','drug name','325','MG','325 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (289,'Acetaminophen Rectal Suppository 650 MG','Acetaminophen','drug name','650','MG','650 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (290,'Acetaminophen Powder','Acetaminophen','drug name','','',' ','59','Powder','35','','0','','960000','Pharmaceutical Aids','2','0','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (294,'Acetaminophen Jr Oral Tablet Chewable 160 MG','Acetaminophen Jr','drug name','160','MG','160 MG','9','Tablet Chewable','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (295,'Acetaminophen PM Oral Tablet 500-25 MG','Acetaminophen PM','drug name','500-25','MG','500-25 MG','81','Tablet','24','Oral','0','','282492','Anxiolytics, Sedatives, & Hypnotics Misc','2','1','','0','0','0','1','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (298,'Acetaminophen-Codeine Oral Elixir 120-12 MG/5ML','Acetaminophen-Codeine','drug name','120-12','MG/5ML','120-12 MG/5ML','26','Elixir','24','Oral','5','Schedule V','280808','Opiate Agonists','1','0','20031023','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (300,'Acetaminophen-Codeine Oral Tablet','Acetaminophen-Codeine','drug name','','',' ','81','Tablet','24','Oral','3','Schedule III','280808','Opiate Agonists','1','0','20040416','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (302,'Acetaminophen-Hydrocodone Oral Tablet','Acetaminophen-Hydrocodone','drug name','','',' ','81','Tablet','24','Oral','3','Schedule III','280808','Opiate Agonists','1','0','20030919','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (310,'Acetasol Otic Solution 2 %','Acetasol','drug name','2','%','2 %','70','Solution','25','Otic','0','','529200','EENT Drugs, Miscellaneous','1','1','20030425','1','0','0','0','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (0,'','','','','','','','','','','','','','','','','','','','','','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (0,'','','','','','','','','','','','','','','','','','','','','','sig');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (3,'1+1-F Creme External Cream 3-1-1 %','1+1-F Creme','drug name','3-1-1','%','3-1-1 %','18','Cream','5','External','0','','840408','Antifungals','1','1','19960702','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (5,'1000BC Injection Injectable','1000BC','drug name','','',' ','40','Injectable','9','Injection','0','','882800','Multivitamin Preparations','1','1','19980215','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (6,'12 Hour Antihist/Decongestant Oral Tablet Extended','12 Hour Antihist/Decongestant','drug name','6-120','MG','6-120 MG','85','Tablet Extended Release 12 Hour','24','Oral','0','','040420','Propylamine Derivatives','2','1','20070210','0','0','0','0','1 TABLET EVERY 12 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (8,'12 Hour Nasal Spray Nasal Solution 0.05 %','12 Hour Nasal Spray','drug name','0.05','%','0.05 %','70','Solution','22','Nasal','0','','523200','Vasoconstrictors','2','1','','0','2','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (9,'12 Hour Nasal Oral Tablet Extended Release 12 Hour','12 Hour Nasal','drug name','6-120','MG','6-120 MG','85','Tablet Extended Release 12 Hour','24','Oral','0','','040420','Propylamine Derivatives','2','1','','0','0','0','0','1 TABLET EVERY 12 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (10,'12 Hour Nasal Decongestant Oral Tablet Extended Re','12 Hour Nasal Decongestant','drug name','12-75','MG','12-75 MG','85','Tablet Extended Release 12 Hour','24','Oral','0','','040420','Propylamine Derivatives','2','1','20010930','1','0','0','0','1 TABLET EVERY 12 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (16,'20/20 Eye Products Ophthalmic Solution 0.012-0.06 ','20/20 Eye Products','drug name','0.012-0.06','%','0.012-0.06 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','2','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (19,'3-in-1 Mixing Container Miscellaneous','3-in-1 Mixing Container','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (20,'3H W/R Oral Tablet 25-15-0.1 MG','3H W/R','drug name','25-15-0.1','MG','25-15-0.1 MG','81','Tablet','24','Oral','0','','240892','Hypotensive Agents, Miscellaneous','1','1','19980624','1','0','0','0','1 TABLET 3 TIMES DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (21,'3M Air Warming Mask Miscellaneous','3M Air Warming Mask','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (22,'3M Cold Pack Miscellaneous','3M Cold Pack','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (23,'3M Cold Pack Plus Miscellaneous','3M Cold Pack Plus','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (24,'3M Dust/Pollen Mask Miscellaneous','3M Dust/Pollen Mask','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (25,'3M Germ Mask Miscellaneous','3M Germ Mask','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (26,'3M Hot Pack Miscellaneous','3M Hot Pack','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20070101','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (27,'3M Tegasorb Large Oval External Miscellaneous','3M Tegasorb Large Oval','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (28,'3M Tegasorb Large Square External Miscellaneous','3M Tegasorb Large Square','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (29,'3M Tegasorb Medium Oval External Miscellaneous','3M Tegasorb Medium Oval','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (30,'3M Tegasorb Small Oval External Miscellaneous','3M Tegasorb Small Oval','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (31,'3M Tegasorb Small Square External Miscellaneous','3M Tegasorb Small Square','drug name','','',' ','50','Miscellaneous','5','External','0','','849200','Skin and Mucous Membrane Agents, Misc','2','1','20000315','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (34,'4-Way Nasal Long Lasting Spray Nasal Solution 0.05','4-Way Nasal Long Lasting Spray','drug name','0.05','%','0.05 %','70','Solution','22','Nasal','0','','523200','Vasoconstrictors','2','1','20070501','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (36,'4-Way Nasal Spray Nasal Solution 0.05 %','4-Way Nasal Spray','drug name','0.05','%','0.05 %','70','Solution','22','Nasal','0','','523200','Vasoconstrictors','2','1','20071201','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (38,'666 Cold Oral Tablet','666 Cold','drug name','','',' ','81','Tablet','24','Oral','0','','121204','alpha-Adrenergic Agonists','2','1','20010930','1','0','0','0','2 TABLETS 3 TIMES DAILY AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (40,'666 Preparation/Quinine Oral Liquid','666 Preparation/Quinine','drug name','','',' ','45','Liquid','24','Oral','0','','','','2','1','19980501','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (41,'8-Mop Oral Capsule 10 MG','8-Mop','drug name','10','MG','10 MG','8','Capsule','24','Oral','0','','845006','Pigmenting Agents','1','1','','0','0','0','0','3 CAPSULES TWICE WEEKLY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (52,'A-200 Combination Kit 0.5-0.33-4 %','A-200','drug name','0.5-0.33-4','%','0.5-0.33-4 %','43','Kit','2','Combination','0','','840412','Scabicides and Pediculicides','2','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (54,'A-4 High Compression Mens Hose Miscellaneous','A-4 High Compression Mens Hose','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (57,'A-Fil External Cream 5-5 %','A-Fil','drug name','5-5','%','5-5 %','18','Cream','5','External','0','','848000','Sunscreen Agents','2','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (58,'A-Hydrocort Injection Solution Reconstituted 100 M','A-Hydrocort','drug name','100','MG','100 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','','0','0','0','0','20 MG DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (59,'A-Hydrocort Injection Solution Reconstituted 1000 ','A-Hydrocort','drug name','1000','MG','1000 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20020920','1','0','0','0','1 TIME ONLY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (60,'A-Hydrocort Injection Solution Reconstituted 250 M','A-Hydrocort','drug name','250','MG','250 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20040318','1','0','0','0','25 MG DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (61,'A-Hydrocort Injection Solution Reconstituted 500 M','A-Hydrocort','drug name','500','MG','500 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20051018','0','0','0','0','1 TIME ONLY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (62,'A-Methapred Injection Solution Reconstituted 1000 ','A-Methapred','drug name','1000','MG','1000 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20040318','1','0','0','0','40 MG DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (63,'A-Methapred Injection Solution Reconstituted 125 M','A-Methapred','drug name','125','MG','125 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','','0','0','0','0','40 MG DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (64,'A-Methapred Injection Solution Reconstituted 40 MG','A-Methapred','drug name','40','MG','40 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','','0','0','0','0','40 MG DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (65,'A-Methapred Injection Solution Reconstituted 500 M','A-Methapred','drug name','500','MG','500 MG','71','Solution Reconstituted','9','Injection','0','','680400','Adrenals','1','1','20040318','1','0','0','0','40 MG DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (67,'A-Nuric Diuretic Oral Tablet','A-Nuric Diuretic','drug name','','',' ','81','Tablet','24','Oral','0','','402892','Diuretics, Miscellaneous','2','1','20010102','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (68,'A-Phedrin Oral Syrup 1.25-30 MG/5ML','A-Phedrin','drug name','1.25-30','MG/5ML','1.25-30 MG/5ML','80','Syrup','24','Oral','0','','040420','Propylamine Derivatives','2','1','20040219','1','0','0','0','2 TEASPOONSFUL EVERY 4 TO 6 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (69,'ECK A-Phedrin Oral Capsule 2.5-60 MG','ECK A-Phedrin','drug name','2.5-60','MG','2.5-60 MG','8','Capsule','24','Oral','0','','040420','Propylamine Derivatives','2','1','20070731','0','0','0','0','1 CAPSULE EVERY 6 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (77,'A.E.R. Witch Hazel External Pad','A.E.R. Witch Hazel','drug name','','',' ','56','Pad','5','External','0','','842412','Basic Ointments and Protectants','2','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (82,'A.P.L. Injection Solution Reconstituted 20000 U','A.P.L.','drug name','20000','U','20000 U','71','Solution Reconstituted','9','Injection','0','','681800','Gonadotropins','1','1','20010206','1','0','0','0','1 TIME ONLY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (83,'A.P.L. Intramuscular Solution Reconstituted 10000 ','A.P.L.','drug name','10000','U','10000 U','71','Solution Reconstituted','11','Intramuscular','0','','681800','Gonadotropins','1','1','20010308','1','0','0','0','1 TIME ONLY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (84,'A.P.L. Intramuscular Solution Reconstituted 5000 U','A.P.L.','drug name','5000','U','5000 U','71','Solution Reconstituted','11','Intramuscular','0','','681800','Gonadotropins','1','1','20010313','1','0','0','0','1 TIME ONLY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (85,'A.R.M. Oral Tablet 4-25 MG','A.R.M.','drug name','4-25','MG','4-25 MG','81','Tablet','24','Oral','0','','040420','Propylamine Derivatives','2','1','20010930','1','0','0','0','1 TABLET EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (86,'A/B Otic Otic Solution 1.4-5.4 %','A/B Otic','drug name','1.4-5.4','%','1.4-5.4 %','70','Solution','25','Otic','0','','521600','Local Anesthetics','1','1','','0','2','0','1','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (87,'A/G Pro Oral Tablet','A/G Pro','drug name','','',' ','81','Tablet','24','Oral','0','','402000','Caloric Agents','2','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (88,'A/T/S External Gel 2 %','A/T/S','drug name','2','%','2 %','34','Gel','5','External','0','','840404','Antibacterials','1','1','20041112','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (89,'A/T/S External Solution 2 %','A/T/S','drug name','2','%','2 %','70','Solution','5','External','0','','840404','Antibacterials','1','1','20031130','1','1','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (94,'ABC-Z Oral Tablet Extended Release','ABC-Z','drug name','','',' ','87','Tablet Extended Release','24','Oral','0','','882800','Multivitamin Preparations','2','1','20010102','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (105,'ADC-Fluoride Oral Solution 0.5 MG/ML','ADC-Fluoride','drug name','0.5','MG/ML','0.5 MG/ML','70','Solution','24','Oral','0','','882800','Multivitamin Preparations','1','0','19990401','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (108,'ADC-Fluoride Oral Solution 0.25 MG/ML','ADC-Fluoride','drug name','0.25','MG/ML','0.25 MG/ML','70','Solution','24','Oral','0','','882800','Multivitamin Preparations','1','0','19990401','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (114,'AK-Cide Ophthalmic Ointment 10-0.5 %','AK-Cide','drug name','10-0.5','%','10-0.5 %','54','Ointment','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20030826','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (115,'AK-Cide Ophthalmic Suspension 10-0.5 %','AK-Cide','drug name','10-0.5','%','10-0.5 %','77','Suspension','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20030131','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (116,'AK-Con Ophthalmic Solution 0.1 %','AK-Con','drug name','0.1','%','0.1 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','1','1','','0','2','0','1','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (120,'AK-Dex Ophthalmic Solution 0.1 %','AK-Dex','drug name','0.1','%','0.1 %','70','Solution','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20031030','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (121,'AK-Dilate Ophthalmic Solution 10 %','AK-Dilate','drug name','10','%','10 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','1','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (122,'AK-Dilate Ophthalmic Solution 2.5 %','AK-Dilate','drug name','2.5','%','2.5 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','1','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (123,'AK-Fluor Injection Solution 10 %','AK-Fluor','drug name','10','%','10 %','70','Solution','9','Injection','0','','365800','Ocular Disorders','1','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (124,'AK-Fluor Injection Solution 25 %','AK-Fluor','drug name','25','%','25 %','70','Solution','9','Injection','0','','365800','Ocular Disorders','1','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (128,'AK-NaCl Ophthalmic Ointment 5 %','AK-NaCl','drug name','5','%','5 %','54','Ointment','23','Ophthalmic','0','','529200','EENT Drugs, Miscellaneous','2','1','20040520','1','1','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (129,'AK-NaCl Ophthalmic Solution 5 %','AK-NaCl','drug name','5','%','5 %','70','Solution','23','Ophthalmic','0','','529200','EENT Drugs, Miscellaneous','2','1','19990625','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (130,'AK-Nefrin Ophthalmic Solution 0.125 %','AK-Nefrin','drug name','0.125','%','0.125 %','70','Solution','23','Ophthalmic','0','','523200','Vasoconstrictors','2','1','20020425','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (132,'AK-Neo-Dex Ophthalmic Solution 0.5-0.1 %','AK-Neo-Dex','drug name','0.5-0.1','%','0.5-0.1 %','70','Solution','23','Ophthalmic','0','','520808','Corticosteroids','1','1','19990601','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (134,'AK-Pentolate Ophthalmic Solution 1 %','AK-Pentolate','drug name','1','%','1 %','70','Solution','23','Ophthalmic','0','','522400','Mydriatics','1','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (135,'AK-Poly-Bac Ophthalmic Ointment 500-10000 UNIT/GM','AK-Poly-Bac','drug name','500-10000','UNIT/GM','500-10000 UNIT/GM','54','Ointment','23','Ophthalmic','0','','520404','Antibacterials','1','1','','0','0','0','1','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (137,'AK-Pred Ophthalmic Solution 1 %','AK-Pred','drug name','1','%','1 %','70','Solution','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20040206','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (139,'AK-Rinse Ophthalmic Solution','AK-Rinse','drug name','','',' ','70','Solution','23','Ophthalmic','0','','529200','EENT Drugs, Miscellaneous','2','1','20050831','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (140,'AK-Spore Ophthalmic Solution 1.75-5000-0.025','AK-Spore','drug name','1.75-5000-0.025','','1.75-5000-0.025 ','70','Solution','23','Ophthalmic','0','','520404','Antibacterials','1','0','20010531','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (142,'AK-Spore HC Ophthalmic Ointment 1 %','AK-Spore HC','drug name','1','%','1 %','54','Ointment','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20030131','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (143,'AK-Spore HC Otic Solution 1-5-10000','AK-Spore HC','drug name','1-5-10000','','1-5-10000 ','70','Solution','25','Otic','0','','520808','Corticosteroids','1','1','20010531','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (145,'AK-Spore Ophthalmic Ointment 5-400-10000','AK-Spore','drug name','5-400-10000','','5-400-10000 ','54','Ointment','23','Ophthalmic','0','','520404','Antibacterials','1','0','20040618','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (146,'AK-Sulf Ophthalmic Ointment 10 %','AK-Sulf','drug name','10','%','10 %','54','Ointment','23','Ophthalmic','0','','520404','Antibacterials','1','1','20030409','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (147,'AK-Sulf Ophthalmic Solution 10 %','AK-Sulf','drug name','10','%','10 %','70','Solution','23','Ophthalmic','0','','520404','Antibacterials','1','1','20021101','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (150,'AK-T-Caine Ophthalmic Solution 0.5 %','AK-T-Caine','drug name','0.5','%','0.5 %','70','Solution','23','Ophthalmic','0','','521600','Local Anesthetics','1','1','20030409','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (151,'AK-Taine Ophthalmic Solution 0.5 %','AK-Taine','drug name','0.5','%','0.5 %','70','Solution','23','Ophthalmic','0','','521600','Local Anesthetics','1','0','19950411','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (153,'AK-Tracin Ophthalmic Ointment 500 U/GM','AK-Tracin','drug name','500','U/GM','500 U/GM','54','Ointment','23','Ophthalmic','0','','520404','Antibacterials','1','1','20011130','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (155,'AK-Trol Ophthalmic Suspension 0.5-10000-0.1','AK-Trol','drug name','0.5-10000-0.1','','0.5-10000-0.1 ','77','Suspension','23','Ophthalmic','0','','520808','Corticosteroids','1','1','20041123','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (159,'APAP Oral Solution 160 MG/5ML','APAP','drug name','160','MG/5ML','160 MG/5ML','70','Solution','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','20070921','0','0','0','0','4 TEASPOONSFUL EVERY 3 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (161,'APAP Childrens Oral Suspension 160 MG/5ML','APAP Childrens','drug name','160','MG/5ML','160 MG/5ML','77','Suspension','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','20000622','1','0','0','0','2 TEASPOONSFUL EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (162,'APAP Child Oral Tablet Chewable 80 MG','APAP Child','drug name','80','MG','80 MG','9','Tablet Chewable','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','1','19990101','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (164,'APAP Drops Oral Solution 100 MG/ML','APAP Drops','drug name','100','MG/ML','100 MG/ML','70','Solution','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','0','0','1','1 TEASPOONFUL EVERY 3 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (165,'APAP Extra Strength Oral Tablet 500 MG','APAP Extra Strength','drug name','500','MG','500 MG','81','Tablet','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','2','0','1','1 TABLET EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (175,'APDC Cold Oral Tablet','APDC Cold','drug name','','',' ','81','Tablet','24','Oral','0','','480800','Antitussives','2','1','20010930','1','0','0','0','2 TABLETS EVERY 4 TO 6 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (180,'ASA/Butal/Caff w/Codeine Oral Capsule','ASA/Butal/Caff w/Codeine','drug name','','',' ','8','Capsule','24','Oral','3','Schedule III','280808','Opiate Agonists','1','0','19910826','1','0','0','0','1 CAPSULE EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (182,'AVC Vaginal Vaginal Suppository 1.05 GM','AVC Vaginal','drug name','1.05','GM','1.05 GM','76','Suppository','33','Vaginal','0','','840492','Local Anti-infectives, Miscellaneous','1','1','20030430','1','0','0','0','1 SUPPOSITORY AT BEDTIME\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (183,'AVC Vaginal Vaginal Cream 15 %','AVC Vaginal','drug name','15','%','15 %','18','Cream','33','Vaginal','0','','840492','Local Anti-infectives, Miscellaneous','1','1','','0','2','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (184,'Aapri Gentle Scrub External Miscellaneous','Aapri Gentle Scrub','drug name','','',' ','50','Miscellaneous','5','External','0','','842000','Detergents','2','1','20010104','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (185,'Aapri Original Scrub External Miscellaneous','Aapri Original Scrub','drug name','','',' ','50','Miscellaneous','5','External','0','','842000','Detergents','2','1','20010104','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (186,'Abbocath-T Miscellaneous','Abbocath-T','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (187,'Abbocath-T/Syringe Miscellaneous','Abbocath-T/Syringe','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','1','1','','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (188,'Abbokinase Injection Solution Reconstituted 250000','Abbokinase','drug name','250000','UNIT','250000 UNIT','71','Solution Reconstituted','9','Injection','0','','201220','Thrombolytic Agents','1','1','20080407','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (189,'Abbokinase Injection Solution Reconstituted 5000 U','Abbokinase','drug name','5000','U','5000 U','71','Solution Reconstituted','9','Injection','0','','201220','Thrombolytic Agents','1','1','20000102','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (190,'Abbott Sanitary Tray Miscellaneous','Abbott Sanitary Tray','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (194,'Absorbine Antifungal External Cream 2 %','Absorbine Antifungal','drug name','2','%','2 %','18','Cream','5','External','0','','840408','Antifungals','2','1','20080519','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (198,'Absorbine Jr External Liquid','Absorbine Jr','drug name','','',' ','45','Liquid','5','External','0','','842404','Basic Lotions and Liniments','2','1','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (199,'Absorbine Jr External Solution 1 %','Absorbine Jr','drug name','1','%','1 %','70','Solution','5','External','0','','840408','Antifungals','2','1','20080519','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (200,'Acacia Powder','Acacia','drug name','','',' ','59','Powder','35','','0','','960000','Pharmaceutical Aids','3','0','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (204,'Accu-Chek Easy Diabetes Care Kit','Accu-Chek Easy Diabetes Care','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','19990428','1','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (206,'Accu-Chek Easy Hospital Test Kit','Accu-Chek Easy Hospital Test','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','19990428','1','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (207,'Accu-Chek II Accu-Drop Miscellaneous','Accu-Chek II Accu-Drop','drug name','','',' ','50','Miscellaneous','35','','0','','','','2','1','19990428','1','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (213,'Accu-Chek II Hospital Testing Miscellaneous','Accu-Chek II Hospital Testing','drug name','','',' ','50','Miscellaneous','35','','0','','','','2','1','19990428','1','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (215,'Accu-Chek III Diabetes Meter Miscellaneous','Accu-Chek III Diabetes Meter','drug name','','',' ','50','Miscellaneous','35','','0','','','','2','1','19990602','1','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (216,'Accu-Chek III Hospital Test Kit','Accu-Chek III Hospital Test','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','19990428','1','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (217,'Accu-Chek III Kit','Accu-Chek III','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','19990602','1','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (219,'Accu-Pro Add-On Set Miscellaneous','Accu-Pro Add-On Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (220,'Accu-Pro Fat Emulsion Set Miscellaneous','Accu-Pro Fat Emulsion Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (221,'Accu-Pro Mini-Drop Set Miscellaneous','Accu-Pro Mini-Drop Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (222,'Accu-Pro Nitroglycerin Set Miscellaneous','Accu-Pro Nitroglycerin Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (223,'Accu-Pro Pump Set Miscellaneous','Accu-Pro Pump Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (224,'Accu-Pro Pump Set/Check Valve Miscellaneous','Accu-Pro Pump Set/Check Valve','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (225,'Accu-Pro Pump Set/Filter Miscellaneous','Accu-Pro Pump Set/Filter','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (227,'Accu-Pro Pump Set/Roller Clamp Miscellaneous','Accu-Pro Pump Set/Roller Clamp','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (228,'Accu-Pro Pump Set/Vent Miscellaneous','Accu-Pro Pump Set/Vent','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (229,'Accu-Pro Y-Type Blood Set Miscellaneous','Accu-Pro Y-Type Blood Set','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','1','1','20060628','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (232,'Accupril Oral Tablet 10 MG','Accupril','drug name','10','MG','10 MG','81','Tablet','24','Oral','0','','243204','Angiotensin-Converting Enzyme Inhibitors','1','1','','0','2','0','1','1 TABLET DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (233,'Accupril Oral Tablet 20 MG','Accupril','drug name','20','MG','20 MG','81','Tablet','24','Oral','0','','243204','Angiotensin-Converting Enzyme Inhibitors','1','1','','0','2','0','1','1 TABLET DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (234,'Accupril Oral Tablet 40 MG','Accupril','drug name','40','MG','40 MG','81','Tablet','24','Oral','0','','243204','Angiotensin-Converting Enzyme Inhibitors','1','1','','0','2','0','1','1 TABLET DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (235,'Accupril Oral Tablet 5 MG','Accupril','drug name','5','MG','5 MG','81','Tablet','24','Oral','0','','243204','Angiotensin-Converting Enzyme Inhibitors','1','1','','0','2','0','1','1 TABLET DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (239,'Accusens T Taste Function Kit','Accusens T Taste Function','drug name','','',' ','43','Kit','35','','0','','940000','Devices','2','1','20010102','1','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (240,'Accutane Oral Capsule 10 MG','Accutane','drug name','10','MG','10 MG','8','Capsule','24','Oral','0','','849200','Skin and Mucous Membrane Agents, Misc','1','1','','0','0','0','1','3 CAPSULES TWICE DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (241,'Accutane Oral Capsule 20 MG','Accutane','drug name','20','MG','20 MG','8','Capsule','24','Oral','0','','849200','Skin and Mucous Membrane Agents, Misc','1','1','','0','0','0','1','2 CAPSULES TWICE DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (242,'Accutane Oral Capsule 40 MG','Accutane','drug name','40','MG','40 MG','8','Capsule','24','Oral','0','','849200','Skin and Mucous Membrane Agents, Misc','1','1','','0','2','0','1','1 CAPSULE DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (245,'ACE Athletic Bandage Miscellaneous','ACE Athletic Bandage','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (247,'ACE Bandage Miscellaneous','ACE Bandage','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (250,'ACE Cold Compress Miscellaneous','ACE Cold Compress','drug name','','',' ','50','Miscellaneous','35','','0','','940000','Devices','2','1','','0','0','1','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (265,'Ace+Z Oral Tablet','Ace+Z','drug name','','',' ','81','Tablet','24','Oral','0','','','','2','1','19990326','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (267,'Acel-Imune Adsorbed Intramuscular Injectable 7.5-4','Acel-Imune Adsorbed','drug name','7.5-40-5','LFU/0.5ML','7.5-40-5 LFU/0.5ML','40','Injectable','11','Intramuscular','0','','800800','Toxoids','1','1','20010115','1','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (268,'Acephen Rectal Suppository 120 MG','Acephen','drug name','120','MG','120 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','2','0','1','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (269,'Acephen Rectal Suppository 325 MG','Acephen','drug name','325','MG','325 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','2','0','1','2 SUPPOSITORIES EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (270,'Acephen Rectal Suppository 650 MG','Acephen','drug name','650','MG','650 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','0','0','1','1 SUPPOSITORY EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (273,'Acerola-C Oral Tablet 300 MG','Acerola-C','drug name','300','MG','300 MG','81','Tablet','24','Oral','0','','881200','Vitamin C','2','1','20010102','1','0','0','0','1 TABLET TWICE DAILY\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (275,'Aceta-Gesic Oral Tablet 30-325 MG','Aceta-Gesic','drug name','30-325','MG','30-325 MG','81','Tablet','24','Oral','0','','040404','Ethanolamine Derivatives','2','1','','0','0','0','0','1 TABLET 4 TIMES DAILY AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (276,'Acetaminophen Oral Capsule 500 MG','Acetaminophen','drug name','500','MG','500 MG','8','Capsule','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','0','1 CAPSULE EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (277,'Acetaminophen Oral Tablet Chewable 80 MG','Acetaminophen','drug name','80','MG','80 MG','9','Tablet Chewable','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (278,'Acetaminophen Oral Elixir 120 MG/5ML','Acetaminophen','drug name','120','MG/5ML','120 MG/5ML','26','Elixir','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','20000217','1','0','0','0','2.5 TEASPOONSFUL EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (282,'Acetaminophen Oral Solution 160 MG/5ML','Acetaminophen','drug name','160','MG/5ML','160 MG/5ML','70','Solution','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','0','0','1','4 TEASPOONSFUL EVERY 3 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (283,'Acetaminophen Oral Tablet 325 MG','Acetaminophen','drug name','325','MG','325 MG','81','Tablet','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','2 TABLETS EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (284,'Acetaminophen Oral Tablet 500 MG','Acetaminophen','drug name','500','MG','500 MG','81','Tablet','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','1 TABLET EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (286,'Acetaminophen Rectal Suppository 120 MG','Acetaminophen','drug name','120','MG','120 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (288,'Acetaminophen Rectal Suppository 325 MG','Acetaminophen','drug name','325','MG','325 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','2 SUPPOSITORIES EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (289,'Acetaminophen Rectal Suppository 650 MG','Acetaminophen','drug name','650','MG','650 MG','76','Suppository','27','Rectal','0','','280892','Analgesics and Antipyretics, Misc','2','0','','0','2','0','1','1 SUPPOSITORY EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (290,'Acetaminophen Powder','Acetaminophen','drug name','','',' ','59','Powder','35','','0','','960000','Pharmaceutical Aids','2','0','','0','0','0','0','\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (294,'Acetaminophen Jr Oral Tablet Chewable 160 MG','Acetaminophen Jr','drug name','160','MG','160 MG','9','Tablet Chewable','24','Oral','0','','280892','Analgesics and Antipyretics, Misc','2','1','','0','0','0','0','2 TABLETS EVERY 3 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (295,'Acetaminophen PM Oral Tablet 500-25 MG','Acetaminophen PM','drug name','500-25','MG','500-25 MG','81','Tablet','24','Oral','0','','282492','Anxiolytics, Sedatives, & Hypnotics Misc','2','1','','0','0','0','1','1 TABLET AT BEDTIME AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (298,'Acetaminophen-Codeine Oral Elixir 120-12 MG/5ML','Acetaminophen-Codeine','drug name','120-12','MG/5ML','120-12 MG/5ML','26','Elixir','24','Oral','5','Schedule V','280808','Opiate Agonists','1','0','20031023','1','0','0','0','1 TABLESPOONFUL EVERY 4 TO 6 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (300,'Acetaminophen-Codeine Oral Tablet','Acetaminophen-Codeine','drug name','','',' ','81','Tablet','24','Oral','3','Schedule III','280808','Opiate Agonists','1','0','20040416','1','0','0','0','1 OR 2 TABLETS EVERY 4 TO 6 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (302,'Acetaminophen-Hydrocodone Oral Tablet','Acetaminophen-Hydrocodone','drug name','','',' ','81','Tablet','24','Oral','3','Schedule III','280808','Opiate Agonists','1','0','20030919','1','0','0','0','1 CAPSULE EVERY 4 HOURS AS NEEDED\r');

insert  into `erx_medispan_db`(`DispensableDrugID`,`TradeDrugDesc`,`TradeDrugName`,`DrugName`,`StrengthValue`,`StrengthUnit`,`StrengthDesc`,`DosageFormCode`,`DosageFormCodeDesc`,`RouteCode`,`RouteDesc`,`DEAClassCode`,`DEAClassDesc`,`TherapeuticClassCode`,`TherapeuticClassDesc`,`RxOrOTCInd`,`GenericOrBrandedInd`,`ObsoleteDate`,`HistoricalInd`,`RepackageInd`,`DeviceInd`,`ImageInd`,`sigDescription`) values (310,'Acetasol Otic Solution 2 %','Acetasol','drug name','2','%','2 %','70','Solution','25','Otic','0','','529200','EENT Drugs, Miscellaneous','1','1','20030425','1','0','0','0','\r');


/*Table structure for table `erx_patient` */

DROP TABLE IF EXISTS `erx_patient`;
CREATE TABLE `erx_patient` (

  `patient_id` int(11) NOT NULL auto_increment,

  `vendor_patient_id` varchar(50) default NULL,

  `create_date` timestamp NOT NULL default CURRENT_TIMESTAMP,

  PRIMARY KEY  (`patient_id`)

) ENGINE=INNODB DEFAULT CHARSET=utf8;


/*Table structure for table `erx_physician` */

DROP TABLE IF EXISTS `erx_physician`;
CREATE TABLE `erx_physician` (

  `erx_physician_id` int(11) NOT NULL auto_increment,

  `physician_username` varchar(50) NOT NULL,

  `physician_password` varchar(50) NOT NULL,

  `user_id` int(11) NOT NULL,

  `create_date` timestamp NOT NULL default CURRENT_TIMESTAMP,

  `active_status` VARCHAR( 2 ) NOT NULL default '0',

  PRIMARY KEY  (`erx_physician_id`)

) ENGINE=INNODB DEFAULT CHARSET=utf8;


/*Table structure for table `erx_physician_suffix` */
DROP TABLE IF EXISTS `erx_physician_suffix`;
CREATE TABLE `erx_physician_suffix` (

  `id` int(11) NOT NULL auto_increment,

  `name` varchar(20) NOT NULL,

  PRIMARY KEY  (`id`)

) ENGINE=INNODB DEFAULT CHARSET=utf8;

/*Data for the table `erx_physician_suffix` */



insert  into `erx_physician_suffix`(`id`,`name`) values (1,'ANP');

insert  into `erx_physician_suffix`(`id`,`name`) values (2,'APN');

insert  into `erx_physician_suffix`(`id`,`name`) values (3,'APRN');

insert  into `erx_physician_suffix`(`id`,`name`) values (4,'ARNP');

insert  into `erx_physician_suffix`(`id`,`name`) values (5,'CNF-RxN');

insert  into `erx_physician_suffix`(`id`,`name`) values (6,'CNM');

insert  into `erx_physician_suffix`(`id`,`name`) values (7,'CNMW');

insert  into `erx_physician_suffix`(`id`,`name`) values (8,'CNP');

insert  into `erx_physician_suffix`(`id`,`name`) values (9,'CNS');

insert  into `erx_physician_suffix`(`id`,`name`) values (10,'CRNA');

insert  into `erx_physician_suffix`(`id`,`name`) values (11,'CRNP');

insert  into `erx_physician_suffix`(`id`,`name`) values (12,'DDS');

insert  into `erx_physician_suffix`(`id`,`name`) values (13,'DMD');

insert  into `erx_physician_suffix`(`id`,`name`) values (14,'DO');

insert  into `erx_physician_suffix`(`id`,`name`) values (15,'DPM');

insert  into `erx_physician_suffix`(`id`,`name`) values (16,'FNP');

insert  into `erx_physician_suffix`(`id`,`name`) values (17,'FNP-C');

insert  into `erx_physician_suffix`(`id`,`name`) values (18,'MD');

insert  into `erx_physician_suffix`(`id`,`name`) values (19,'MD, FACC');

insert  into `erx_physician_suffix`(`id`,`name`) values (20,'MD, FACC, PhD');

insert  into `erx_physician_suffix`(`id`,`name`) values (21,'MD, FACOG');

insert  into `erx_physician_suffix`(`id`,`name`) values (22,'MD, FACP');

insert  into `erx_physician_suffix`(`id`,`name`) values (23,'MD, PhD');

insert  into `erx_physician_suffix`(`id`,`name`) values (24,'MD, JD');

insert  into `erx_physician_suffix`(`id`,`name`) values (25,'NA');

insert  into `erx_physician_suffix`(`id`,`name`) values (26,'NM');

insert  into `erx_physician_suffix`(`id`,`name`) values (27,'NP');

insert  into `erx_physician_suffix`(`id`,`name`) values (28,'NP-C');

insert  into `erx_physician_suffix`(`id`,`name`) values (29,'OD');

insert  into `erx_physician_suffix`(`id`,`name`) values (30,'PA');

insert  into `erx_physician_suffix`(`id`,`name`) values (31,'PA-C');

insert  into `erx_physician_suffix`(`id`,`name`) values (32,'PD');

insert  into `erx_physician_suffix`(`id`,`name`) values (33,'PharmD');

insert  into `erx_physician_suffix`(`id`,`name`) values (34,'RMA');

insert  into `erx_physician_suffix`(`id`,`name`) values (35,'RN');

insert  into `erx_physician_suffix`(`id`,`name`) values (36,'RN, FNP-BC');

insert  into `erx_physician_suffix`(`id`,`name`) values (37,'RN, FNP-C');

insert  into `erx_physician_suffix`(`id`,`name`) values (38,'RNA');

insert  into `erx_physician_suffix`(`id`,`name`) values (39,'RNP');

insert  into `erx_physician_suffix`(`id`,`name`) values (40,'RPA-C');

insert  into `erx_physician_suffix`(`id`,`name`) values (41,'RPH');

insert  into `erx_physician_suffix`(`id`,`name`) values (42,'Other');

insert  into `erx_physician_suffix`(`id`,`name`) values (43,'None');

--
-- Table structure for table `erx_practice_vendor`
--

DROP TABLE IF EXISTS `erx_practice_vendor`;
CREATE TABLE IF NOT EXISTS `erx_practice_vendor` (
  `id` int(11) NOT NULL auto_increment,
  `vendor_id` varchar(50) NOT NULL,
  `vendor_erx_practice_id` varchar(50) NOT NULL,
  `practice_id` varchar(50) NOT NULL,
  `create_date` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `active` enum('0','1') NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


/* Table structure for table `erx_vendor` */

DROP TABLE IF EXISTS `erx_vendor`;
CREATE TABLE `erx_vendor` (

  `vendor_id` int(11) NOT NULL auto_increment,

  `vendor_erx_id` varchar(50) NOT NULL,

  `vendor_erx_password` varchar(50) NOT NULL,

  `vendor_drug_database` varchar(50) NOT NULL,

  PRIMARY KEY  (`vendor_id`)

) ENGINE=INNODB DEFAULT CHARSET=utf8;


/*Data for the table `layout_options` */

insert  into `layout_options`(`form_id`,`field_id`,`group_name`,`title`,`seq`,`data_type`,`uor`,`fld_length`,`max_length`,`list_id`,`titlecols`,`datacols`,`default_value`,`edit_options`,`description`) values ('DEM','suffix','2Contact','Suffix',5,1,2,0,20,'suffix',1,1,'','','Suffix');

insert  into `layout_options`(`form_id`,`field_id`,`group_name`,`title`,`seq`,`data_type`,`uor`,`fld_length`,`max_length`,`list_id`,`titlecols`,`datacols`,`default_value`,`edit_options`,`description`) values ('DEM','address2','2Contact','Address2',3,2,2,25,50,'',1,1,'','','Address Line2');

update `layout_options` set `form_id`='DEM',`field_id`='city',`group_name`='2Contact',`title`='City',`seq`='2',`data_type`='2',`uor`='2',`fld_length`='15',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='C',`description`='City Name' where `form_id`='DEM' and `field_id`='city';

update `layout_options` set `form_id`='DEM',`field_id`='street',`group_name`='2Contact',`title`='Address',`seq`='1',`data_type`='2',`uor`='2',`fld_length`='25',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='C',`description`='Address' where `form_id`='DEM' and `field_id`='street';

update `layout_options` set `form_id`='DEM',`field_id`='country_code',`group_name`='2Contact',`title`='Country',`seq`='7',`data_type`='1',`uor`='2',`fld_length`='0',`max_length`='0',`list_id`='country',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='',`description`='Country' where `form_id`='DEM' and `field_id`='country_code';

update `layout_options` set `form_id`='DEM',`field_id`='phone_home',`group_name`='2Contact',`title`='Home Phone',`seq`='8',`data_type`='2',`uor`='2',`fld_length`='20',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='P',`description`='Home Phone Number' where `form_id`='DEM' and `field_id`='phone_home';

update `layout_options` set `group_name`='2Contact',`title`='State',`seq`='6',`data_type`='1',`uor`='2',`fld_length`='0',`max_length`='0',`list_id`='state',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='',`description`='State/Locality' where `form_id`='DEM' and `field_id`='state';

update `layout_options` set `form_id`='DEM',`field_id`='postal_code',`group_name`='2Contact',`title`='Postal Code',`seq`='4',`data_type`='2',`uor`='2',`fld_length`='6',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='',`description`='Postal Code' where `form_id`='DEM' and `field_id`='postal_code';

update `layout_options` set `field_id`='street',`group_name`='2Contact',`seq` ='1',`data_type`='2',`uor`='2' where `form_id`='DEM' and `field_id`='address';

update `layout_options` set `seq`='2',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='city';

update `layout_options` set `seq`='3',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='address2';

update `layout_options` set `seq`='4',`group_name`='2Contact',`data_type`='1',`uor`='2' where `form_id`='DEM' and `field_id`='state';

update `layout_options` set `seq`='5',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='suffix';

update `layout_options` set `seq`='6',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='postal_code';

update `layout_options` set `seq`='7',`data_type`='1',`uor`='2',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='country_code';

update `layout_options` set `form_id`='DEM',`field_id`='phone_home',`group_name`='2Contact',`title`='Home Phone',`seq`='8',`data_type`='2',`uor`='2',`fld_length`='20',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='P',`description`='Home Phone Number' where `form_id`='DEM' and `field_id`='phone_home';

update `layout_options` set `seq`='9',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='contact_relationship';

update `layout_options` set `seq`='10',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='phone_contact';

update `layout_options` set `seq`='11',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='phone_biz';

update `layout_options` set `seq`='12',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='phone_cell';

update `layout_options` set `seq`='13',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='email';

/*Data for the table `list_options` */

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','1','ANP',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','2','APN',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','3','APRN',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','4','ARNP',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','5','CNF-RxN',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','6','CNM',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','7','CNMW',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','8','CNP',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','9','CNS',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','10','CRNA',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','11','CRNP',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','12','DDS',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','13','DMD',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','14','DO',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','15','DPM',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','16','FNP',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','17','FNP-C',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','18','MD',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','19','MD, FACC',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','20','MD, FACC, PhD',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','21','MD, FACOG',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','22','MD, FACP',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','23','MD, PhD',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','24','MD, JD',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','25','NA',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','26','NM',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','27','NP',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','28','NP-C',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','29','OD',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','30','PA',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','31','PA-C',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','32','PD',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','33','PharmD',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','34','RMA',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','35','RN',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','36','RN, FNP-BC',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','37','RN, FNP-C',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','38','RNA',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','39','RNP',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','40','RPA-C',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','41','RPH',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','42','Other',1,0,0);

insert  into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('suffix','43','None',1,1,0);

insert into `list_options`(`list_id`,`option_id`,`title`,`seq`,`is_default`,`option_value`) values ('lists','Suffix','Suffix','29','1','0');

update `list_options` set `list_id`='country',`option_id`='USA',`title`='USA',`seq`='1',`is_default`='1',`option_value`='0' where `list_id`='country' and `option_id`='USA';

alter table `patient_data` add column `suffix` varchar(30) NULL after `street`, add column `address2` varchar(255) NULL after `suffix`;


alter table `prescriptions` add column `sig` varchar(255) NULL after `drug_id`, add column `erx_active` enum('0','1') DEFAULT '0' NOT NULL after `active`,change `date_added` `date_added` datetime NULL , change `date_modified` `date_modified` datetime NULL , change `start_date` `start_date` datetime NULL , change `drug_id` `drug_id` int(11) default '0' NOT NULL, change `form` `form` varchar(100) NULL , change `size` `size` varchar(100) NULL , change `unit` `unit` varchar(100) NULL , change `route` `route` varchar(100) NULL , change `filled_date` `filled_date` datetime NULL , change `active` `active` int(11) default '0' NOT NULL;

alter table `users` add column `suffix` varchar(5) NOT NULL after `irnpool`, add column `dea` varchar(15) NULL after `suffix`, add column `specializationCode` varchar(15) NULL after `dea`, add column `specializationCode2` varchar(15) NULL after `specializationCode`, add column `drxPrimaryKey` varchar(30) NULL after `specializationCode2`, add column `licenseNo` bigint(15) NOT NULL after `drxPrimaryKey`, add column `licenseStateCode` bigint(15) NOT NULL after `licenseNo`, add column `birthdate` date NOT NULL after `licenseStateCode`, add column `sex` enum('0','1') DEFAULT '1' NOT NULL after `birthdate`,change `npi` `npi` varchar(15) NULL , change `fax` `fax` bigint(15) NULL , change `phonew1` `phonew1` bigint(15) NULL , change `phonew2` `phonew2` bigint(15) NULL , change `phonecell` `phonecell` bigint(15) NULL ;

