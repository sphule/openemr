CREATE TABLE `form_nurse_note_header` (                                         
                              `id` int(11) NOT NULL auto_increment,                                             
                              `pid` bigint(20) NOT NULL,                                                        
                              `encounter` bigint(20) NOT NULL,                                                  
                              `date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,  
                              `tstamp` bigint(20) NOT NULL,                                                     
                              `signed_user` bigint(20) default NULL,                                            
                              `signed_tstamp` datetime default NULL,                                            
                              PRIMARY KEY  (`id`)                                                               
                            ) ENGINE=innoDB DEFAULT CHARSET=latin1;    


CREATE TABLE `form_nurse_note_txt` (              
                           `id` int(11) NOT NULL auto_increment,               
                           `fk_form_nurse_note_header` int(11) NOT NULL,   
                           `note` text,
			   `fk_form_nurse_note_txt_cat` int(11) default NULL,  
                           PRIMARY KEY  (`id`)                                 
                         ) ENGINE=innoDB DEFAULT CHARSET=latin1;   

 CREATE TABLE `form_nurse_note_txt_cat` (              
		       `id` int(11) NOT NULL auto_increment,                   
		       `code` int(11) NOT NULL,                                
		       `name` text NOT NULL,                                   
		       PRIMARY KEY  (`id`)                                     
		     ) ENGINE=innoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 ;

CREATE TABLE `form_nurse_note_cb_sel` (           
                              `id` int(11) NOT NULL auto_increment,               
                              `fk_form_nurse_note_header` int(11) NOT NULL,   
                              `fk_form_nurse_note_cb_flds` int(11) NOT NULL,  
                              PRIMARY KEY  (`id`)                                 
                            ) ENGINE=innoDB DEFAULT CHARSET=latin1;

CREATE TABLE `form_nurse_note_cb_flds` (  
                               `id` int(11) NOT NULL auto_increment,       
                               `code` int(11) NOT NULL,                    
                               `name` text NOT NULL,                       
                               PRIMARY KEY  (`id`)                         
                             ) ENGINE=innoDB DEFAULT CHARSET=latin1;  
