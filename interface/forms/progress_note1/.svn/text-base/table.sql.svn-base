-- --------------------------------------------------------

--
-- Table structure for table `form_progress_note1_cb_flds`
--

DROP TABLE IF EXISTS `form_progress_note1_cb_flds`;
CREATE TABLE IF NOT EXISTS `form_progress_note1_cb_flds` (
  `id` int(11) NOT NULL auto_increment,
  `code` int(11) NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form_progress_note1_cb_flds`
--


-- --------------------------------------------------------

--
-- Table structure for table `form_progress_note1_cb_sel`
--

DROP TABLE IF EXISTS `form_progress_note1_cb_sel`;
CREATE TABLE IF NOT EXISTS `form_progress_note1_cb_sel` (
  `id` int(11) NOT NULL auto_increment,
  `fk_form_progress_note1_header` int(11) NOT NULL,
  `fk_form_progress_note1_cb_flds` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form_progress_note1_cb_sel`
--


-- --------------------------------------------------------

--
-- Table structure for table `form_progress_note1_header`
--

DROP TABLE IF EXISTS `form_progress_note1_header`;
CREATE TABLE IF NOT EXISTS `form_progress_note1_header` (
  `id` int(11) NOT NULL auto_increment,
  `pid` bigint(20) NOT NULL,
  `encounter` bigint(20) NOT NULL,
  `date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `tstamp` bigint(20) NOT NULL,
  `signed_user` bigint(20) default NULL,
  `signed_tstamp` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form_progress_note1_header`
--


-- --------------------------------------------------------

--
-- Table structure for table `form_progress_note1_txt`
--

DROP TABLE IF EXISTS `form_progress_note1_txt`;
CREATE TABLE IF NOT EXISTS `form_progress_note1_txt` (
  `id` int(11) NOT NULL auto_increment,
  `fk_form_progress_note1_header` int(11) NOT NULL,
  `note` text,
  `fk_form_progress_note1_txt_cat` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form_progress_note1_txt`
--


-- --------------------------------------------------------

--
-- Table structure for table `form_progress_note1_txt_cat`
--

DROP TABLE IF EXISTS `form_progress_note1_txt_cat`;
CREATE TABLE IF NOT EXISTS `form_progress_note1_txt_cat` (
  `id` int(11) NOT NULL auto_increment,
  `code` int(11) NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `form_progress_note1_txt_cat`
--
