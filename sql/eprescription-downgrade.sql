drop TABLE if EXISTS  `erx_medispan_db`;

drop TABLE if EXISTS`erx_patient`;

drop TABLE if EXISTS `erx_physician`;

drop TABLE if EXISTS `erx_physician_suffix`;

drop TABLE if EXISTS `erx_practice_vendor`;

drop TABLE if EXISTS `erx_vendor`;

delete from `layout_options` where `field_id` =  'suffix';

delete from `layout_options` where `field_id` =  'address2';

update `layout_options` set `form_id`='DEM',`field_id`='city',`group_name`='3Contact',`title`='City',`seq`='2',`data_type`='2',`uor`='1',`fld_length`='15',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='C',`description`='City Name' where `form_id`='DEM' and `field_id`='city';

update `layout_options` set `form_id`='DEM',`field_id`='address',`group_name`='3Contact',`title`='Address',`seq`='1',`data_type`='2',`uor`='1',`fld_length`='25',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='C',`description`='Address' where `form_id`='DEM' and `field_id`='address';

update `layout_options` set `form_id`='DEM',`field_id`='country_code',`group_name`='3Contact',`title`='Country',`seq`='7',`data_type`='1',`uor`='1',`fld_length`='0',`max_length`='0',`list_id`='country',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='',`description`='Country' where `form_id`='DEM' and `field_id`='country_code';

update `layout_options` set `form_id`='DEM',`field_id`='phone_home',`group_name`='3Contact',`title`='Home Phone',`seq`='9',`data_type`='2',`uor`='1',`fld_length`='20',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='P',`description`='Home Phone Number' where `form_id`='DEM' and `field_id`='phone_home';

update `layout_options` set `group_name`='3Contact',`title`='State',`seq`='6',`data_type`='1',`uor`='1',`fld_length`='0',`max_length`='0',`list_id`='state',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='',`description`='State/Locality' where `form_id`='DEM' and `field_id`='state';

update `layout_options` set `form_id`='DEM',`field_id`='postal_code',`group_name`='3Contact',`title`='Postal Code',`seq`='4',`data_type`='2',`uor`='1',`fld_length`='6',`max_length`='63',`list_id`='',`titlecols`='1',`datacols`='1',`default_value`='',`edit_options`='',`description`='Postal Code' where `form_id`='DEM' and `field_id`='postal_code';

update `layout_options` set `field_id`='address',`group_name`='2Contact',`seq` ='1',`data_type`='2',`uor`='1' where `form_id`='DEM' and `field_id`='address';

update `layout_options` set `seq`='2',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='city';

update `layout_options` set `seq`='3',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='address2';

update `layout_options` set `seq`='4',`group_name`='2Contact',`data_type`='1',`uor`='1' where `form_id`='DEM' and `field_id`='state';

update `layout_options` set `seq`='5',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='suffix';

update `layout_options` set `seq`='6',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='postal_code';

update `layout_options` set `seq`='7',`data_type`='1',`uor`='1',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='country_code';

update `layout_options` set `seq`='8',`form_id`='DEM',`uor` = '1',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='phone_home';

update `layout_options` set `seq`='9',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='contact_relationship';

update `layout_options` set `seq`='10',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='phone_contact';

update `layout_options` set `seq`='11',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='phone_biz';

update `layout_options` set `seq`='12',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='phone_cell';

update `layout_options` set `seq`='13',`group_name`='2Contact' where `form_id`='DEM' and `field_id`='email';

delete from `list_options` where `list_id` = 'suffix';
delete from `list_options` where `list_id` = 'lists' and  `option_id` = 'Suffix';

alter table `patient_data` drop column `suffix`, drop column `address2`;

alter table `prescriptions` drop column `sig`,drop column `erx_active`;

alter table `users` drop column `suffix`, drop column `dea`, drop column `specializationCode`, drop column `specializationCode2`,drop column `drxPrimaryKey`,drop column `licenseNo`,drop column `licenseStateCode`,drop column `birthdate`, drop column `sex`;

