SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;

CREATE TABLE `action_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `title_male` varchar(256) NOT NULL,
  `title_female` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `action_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryID` int(3) NOT NULL,
  `title` varchar(256) NOT NULL,
  `title_male` varchar(256) NOT NULL,
  `title_female` varchar(256) NOT NULL,
  `isShowFeed` int(1) NOT NULL,
  `isShowNotification` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `categoryID` (`categoryID`),
  KEY `title` (`title`),
  KEY `isShowNotification` (`isShowNotification`),
  KEY `isShowFeed` (`isShowFeed`),
  CONSTRAINT `action_types_ibfk_1` FOREIGN KEY (`categoryID`) REFERENCES `action_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `activators` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `user` varchar(64) NOT NULL DEFAULT '',
  `type` enum('regNewUser','password_recovery') NOT NULL,
  `date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `authorID` int(11) NOT NULL,
  `isbn10` varchar(32) NOT NULL DEFAULT '',
  `isbn13` varchar(32) NOT NULL DEFAULT '',
  `coverPhotoFolder` varchar(16) NOT NULL DEFAULT '',
  `coverPhotoFilename` varchar(32) NOT NULL DEFAULT '',
  `owner_userID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `isbn` (`isbn10`),
  KEY `authorID` (`authorID`),
  KEY `title` (`title`),
  KEY `isbn13` (`isbn13`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `book_author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `book_complains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorName` varchar(64) NOT NULL DEFAULT '',
  `title` varchar(128) NOT NULL DEFAULT '',
  `isbn10` varchar(32) NOT NULL DEFAULT '',
  `isbn13` varchar(32) NOT NULL DEFAULT '',
  `cover` varchar(32) NOT NULL DEFAULT '',
  `userID` int(11) NOT NULL,
  `complain` varchar(512) NOT NULL DEFAULT '',
  `resolveComment` varchar(512) NOT NULL DEFAULT '',
  `state` enum('new','handling','closed') NOT NULL DEFAULT 'new',
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `captcha` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `session` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `purpose` varchar(255) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `id_2` (`id`),
  KEY `id_3` (`id`),
  KEY `id_4` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `certification_tracks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `logo_folder` varchar(16) NOT NULL DEFAULT '',
  `logo_filename` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title_2` (`title`),
  KEY `title` (`title`),
  KEY `vendor_id` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `chat_contact_list` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `friendID` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userID` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `chat_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `messageType` enum('text','image') NOT NULL DEFAULT 'text',
  `fromType` enum('fromUser','fromCompany') NOT NULL,
  `fromID` int(11) NOT NULL,
  `toType` enum('toUser','toCompany','toGroup','Broadcast') NOT NULL,
  `toID` int(11) NOT NULL,
  `messageStatus` enum('unread','read','unread_const','delivered','sent') NOT NULL,
  `eventTimestamp` datetime NOT NULL,
  `secondsSinceY2k` bigint(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fromType` (`fromType`),
  KEY `fromID` (`fromID`),
  KEY `toType` (`toType`),
  KEY `toID` (`toID`),
  KEY `messageStatus` (`messageStatus`),
  KEY `secondsSinceY2k` (`secondsSinceY2k`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `checklist_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_checklist_id` int(11) NOT NULL,
  `checklist_predefined_id` int(11) NOT NULL,
  `state` enum('Y','N') NOT NULL DEFAULT 'N',
  `price` int(11) NOT NULL DEFAULT '0',
  `comment` varchar(1024) NOT NULL DEFAULT '',
  `eventTimestamp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `event_checklist_id` (`event_checklist_id`),
  KEY `checklist_predefined_id` (`checklist_predefined_id`),
  CONSTRAINT `checklist_items_ibfk_1` FOREIGN KEY (`event_checklist_id`) REFERENCES `event_checklists` (`id`),
  CONSTRAINT `checklist_items_ibfk_2` FOREIGN KEY (`checklist_predefined_id`) REFERENCES `checklist_predefined` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


SET NAMES utf8mb4;

CREATE TABLE `checklist_predefined` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(128) NOT NULL,
  `title` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category` (`category`,`title`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('','ООО','ОАО','ПАО','ЗАО','Группа','ИП','ЧОП','Конгломерат','Концерн','Кооператив','ТСЖ','Холдинг','Корпорация','НИИ') NOT NULL DEFAULT '',
  `name` varchar(256) NOT NULL,
  `link` varchar(32) NOT NULL DEFAULT '',
  `admin_userID` int(11) NOT NULL DEFAULT '0',
  `isConfirmed` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT 'Company owning confirmed with documents',
  `foundationDate` varchar(15) NOT NULL DEFAULT '01/01/2000' COMMENT 'date format: dd/mm/yyyy',
  `numberOfEmployee` int(11) NOT NULL DEFAULT '0',
  `webSite` varchar(254) NOT NULL DEFAULT '',
  `description` varchar(16384) NOT NULL DEFAULT '',
  `isBlocked` enum('Y','N') NOT NULL DEFAULT 'N',
  `logo_folder` varchar(16) NOT NULL DEFAULT '',
  `logo_filename` varchar(32) NOT NULL DEFAULT '',
  `ownerChangeCounter` int(11) NOT NULL DEFAULT '0',
  `lastActivity` int(11) NOT NULL DEFAULT '0' COMMENT 'If no activities for a long time, user may not be active or cyber-squatter. Reset company ownership to 0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `owner_userID` (`admin_userID`),
  KEY `isBlocked` (`isBlocked`),
  KEY `lastActivity` (`lastActivity`),
  KEY `link` (`link`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_candidates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vacancy_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `answer1` enum('1','2','3') NOT NULL,
  `answer2` enum('1','2','3') NOT NULL,
  `answer3` enum('1','2','3') NOT NULL,
  `language1` enum('Y','N','') NOT NULL DEFAULT '',
  `language2` enum('Y','N','') NOT NULL DEFAULT '',
  `language3` enum('Y','N','') NOT NULL DEFAULT '',
  `skill1` enum('Y','N','') NOT NULL DEFAULT '',
  `skill2` enum('Y','N','') NOT NULL DEFAULT '',
  `skill3` enum('Y','N','') NOT NULL DEFAULT '',
  `description` varchar(1024) NOT NULL DEFAULT '',
  `status` enum('applied','rejected') NOT NULL DEFAULT 'applied' COMMENT 'if add more statuses, investigate sort in user_profile.',
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vacancy_id` (`vacancy_id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_founder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyID` int(11) NOT NULL,
  `founder_name` varchar(256) NOT NULL DEFAULT '',
  `founder_userID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `companyID` (`companyID`),
  KEY `owner_userID` (`founder_userID`),
  KEY `founder_name` (`founder_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_industry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_industry_ref` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `profile_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_owner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyID` int(11) NOT NULL,
  `owner_name` varchar(256) NOT NULL DEFAULT '',
  `owner_userID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `companyID` (`companyID`),
  KEY `owner_userID` (`owner_userID`),
  KEY `owner_name` (`owner_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_posession_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requested_company_id` int(11) NOT NULL,
  `requester_user_id` int(11) NOT NULL,
  `status` enum('requested','approved','rejected') NOT NULL,
  `description` varchar(1024) NOT NULL DEFAULT '',
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `requested_company_id` (`requested_company_id`),
  KEY `requester_user_id` (`requester_user_id`),
  KEY `eventTimestamp` (`eventTimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) NOT NULL,
  `area` varchar(256) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `set_id` int(11) NOT NULL,
  `question` varchar(256) NOT NULL,
  `answer1` varchar(256) NOT NULL,
  `answer2` varchar(256) NOT NULL,
  `answer3` varchar(256) NOT NULL,
  `correct_answer` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `set_id` (`set_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `company_vacancy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `company_position_id` int(11) NOT NULL,
  `geo_locality_id` int(11) NOT NULL,
  `salary_min` int(11) NOT NULL DEFAULT '0',
  `salary_max` int(11) NOT NULL DEFAULT '0',
  `start_month` int(2) NOT NULL,
  `work_format` enum('fte','pte','remote','entrepreneur') NOT NULL DEFAULT 'fte',
  `description` varchar(16384) NOT NULL DEFAULT '',
  `question1` varchar(256) NOT NULL DEFAULT '',
  `answer11` varchar(256) NOT NULL DEFAULT '',
  `answer12` varchar(256) NOT NULL DEFAULT '',
  `answer13` varchar(256) NOT NULL DEFAULT '',
  `correct_answer1` int(11) NOT NULL DEFAULT '0',
  `question2` varchar(256) NOT NULL DEFAULT '',
  `answer21` varchar(256) NOT NULL DEFAULT '',
  `answer22` varchar(256) NOT NULL DEFAULT '',
  `answer23` varchar(256) NOT NULL DEFAULT '',
  `correct_answer2` int(11) NOT NULL DEFAULT '0',
  `question3` varchar(256) NOT NULL DEFAULT '',
  `answer31` varchar(256) NOT NULL DEFAULT '',
  `answer32` varchar(256) NOT NULL DEFAULT '',
  `answer33` varchar(256) NOT NULL DEFAULT '',
  `correct_answer3` int(11) NOT NULL DEFAULT '0',
  `language1_id` int(11) NOT NULL DEFAULT '0',
  `language2_id` int(11) NOT NULL DEFAULT '0',
  `language3_id` int(11) NOT NULL DEFAULT '0',
  `skill1_id` int(11) NOT NULL DEFAULT '0',
  `skill2_id` int(11) NOT NULL DEFAULT '0',
  `skill3_id` int(11) NOT NULL DEFAULT '0',
  `publish_finish` date NOT NULL DEFAULT '2000-01-01',
  `publish_period` enum('suspend','week','month') NOT NULL DEFAULT 'suspend',
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `company_position_id` (`company_position_id`),
  KEY `geo_locality_id` (`geo_locality_id`),
  KEY `publish_start` (`publish_finish`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `dictionary_adverse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `email_change_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `new_email` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eventTimestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(64) NOT NULL DEFAULT '' COMMENT 'name in web-link',
  `title` varchar(64) NOT NULL COMMENT 'human readable title',
  `description` varchar(1024) NOT NULL DEFAULT '',
  `address` varchar(512) NOT NULL DEFAULT '',
  `accessType` enum('invitee','everyone','none') NOT NULL DEFAULT 'invitee',
  `startTimestamp` int(11) NOT NULL DEFAULT '0',
  `logo_folder` varchar(32) NOT NULL DEFAULT '',
  `logo_filename` varchar(32) NOT NULL DEFAULT '',
  `owner_id` int(11) NOT NULL,
  `hideGifts` enum('Y','N') NOT NULL DEFAULT 'N',
  `isBlocked` enum('N','Y') NOT NULL DEFAULT 'N',
  `eventTimestampCreation` int(11) NOT NULL,
  `eventTimestampLastPost` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`),
  KEY `isBlocked` (`isBlocked`),
  KEY `accessType` (`accessType`),
  KEY `title` (`title`),
  KEY `description` (`description`),
  KEY `link` (`link`) USING BTREE,
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `event_checklists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '',
  `event_id` int(11) NOT NULL,
  `favorite` enum('Y','N') NOT NULL DEFAULT 'N',
  `eventTimestamp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `favorite` (`favorite`),
  CONSTRAINT `event_checklists_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `event_guests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `quick_registration_id` int(11) NOT NULL DEFAULT '0',
  `status` enum('invited','rejected','accepted','') NOT NULL DEFAULT '',
  `adults` int(11) NOT NULL DEFAULT '0',
  `kids` int(11) NOT NULL DEFAULT '0',
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`),
  KEY `quick_registration_id` (`quick_registration_id`),
  CONSTRAINT `event_guests_event_id` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `event_hosts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `event_hosts__event` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `event_hosts__user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `exception` (
  `identifier` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `id` varchar(100) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `template` varchar(100) NOT NULL DEFAULT '',
  `lng` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`identifier`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `faq` (
  `id` int(11) NOT NULL,
  `role` enum('subcontractor','helpdesk','agency','approver','user') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `feed` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(4) NOT NULL DEFAULT '',
  `srcType` enum('user','company','group','event') NOT NULL DEFAULT 'user',
  `userId` int(11) NOT NULL COMMENT 'srcID (something producing action)',
  `dstType` enum('user','company','group','event','') NOT NULL DEFAULT '',
  `dstID` int(11) NOT NULL DEFAULT '0',
  `actionTypeId` int(11) NOT NULL COMMENT 'Action type',
  `actionId` int(11) NOT NULL DEFAULT '0' COMMENT 'Additional data',
  `eventTimestamp` datetime NOT NULL COMMENT 'format YYYY-MM-DD HH:MM:SS',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `eventTimestamp` (`eventTimestamp`),
  KEY `actionTypeId` (`actionTypeId`),
  KEY `actionId` (`actionId`),
  KEY `srcType` (`srcType`),
  KEY `dstType` (`dstType`),
  KEY `dstID` (`dstID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `feed_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `setID` int(11) NOT NULL DEFAULT '0',
  `srcType` enum('user','company','group') NOT NULL DEFAULT 'user',
  `userID` int(10) NOT NULL,
  `folder` varchar(32) NOT NULL,
  `filename` varchar(128) NOT NULL,
  `mediaType` enum('image','video','youtube_video') NOT NULL DEFAULT 'image',
  `isActive` tinyint(1) NOT NULL DEFAULT '0',
  `tempSet` int(9) NOT NULL,
  `removeFlag` enum('keep','remove') NOT NULL DEFAULT 'keep',
  `exifDateTime` varchar(64) NOT NULL DEFAULT '',
  `exifGPSAltitude` varchar(64) NOT NULL DEFAULT '',
  `exifGPSLatitude` varchar(64) NOT NULL DEFAULT '',
  `exifGPSLongitude` varchar(64) NOT NULL DEFAULT '',
  `exifGPSSpeed` varchar(64) NOT NULL DEFAULT '',
  `exifModel` varchar(64) NOT NULL DEFAULT '',
  `exifAuthors` varchar(64) NOT NULL DEFAULT '',
  `exifApertureValue` varchar(64) NOT NULL DEFAULT '',
  `exifBrightnessValue` varchar(64) NOT NULL DEFAULT '',
  `exifColorSpace` varchar(64) NOT NULL DEFAULT '',
  `exifComponentsConfiguration` varchar(64) NOT NULL DEFAULT '',
  `exifCompression` varchar(64) NOT NULL DEFAULT '',
  `exifDateTimeDigitized` varchar(64) NOT NULL DEFAULT '',
  `exifDateTimeOriginal` varchar(64) NOT NULL DEFAULT '',
  `exifExifImageLength` varchar(64) NOT NULL DEFAULT '',
  `exifExifImageWidth` varchar(64) NOT NULL DEFAULT '',
  `exifExifOffset` varchar(64) NOT NULL DEFAULT '',
  `exifExifVersion` varchar(64) NOT NULL DEFAULT '',
  `exifExposureBiasValue` varchar(64) NOT NULL DEFAULT '',
  `exifExposureMode` varchar(64) NOT NULL DEFAULT '',
  `exifExposureProgram` varchar(64) NOT NULL DEFAULT '',
  `exifExposureTime` varchar(64) NOT NULL DEFAULT '',
  `exifFlash` varchar(64) NOT NULL DEFAULT '',
  `exifFlashPixVersion` varchar(64) NOT NULL DEFAULT '',
  `exifFNumber` varchar(64) NOT NULL DEFAULT '',
  `exifFocalLength` varchar(64) NOT NULL DEFAULT '',
  `exifFocalLengthIn35mmFilm` varchar(64) NOT NULL DEFAULT '',
  `exifGPSDateStamp` varchar(64) NOT NULL DEFAULT '',
  `exifGPSDestBearing` varchar(64) NOT NULL DEFAULT '',
  `exifGPSDestBearingRef` varchar(64) NOT NULL DEFAULT '',
  `exifGPSImgDirection` varchar(64) NOT NULL DEFAULT '',
  `exifGPSImgDirectionRef` varchar(64) NOT NULL DEFAULT '',
  `exifGPSInfo` varchar(64) NOT NULL DEFAULT '',
  `exifGPSTimeStamp` varchar(64) NOT NULL DEFAULT '',
  `exifISOSpeedRatings` varchar(64) NOT NULL DEFAULT '',
  `exifJPEGInterchangeFormat` varchar(64) NOT NULL DEFAULT '',
  `exifJPEGInterchangeFormatLength` varchar(64) NOT NULL DEFAULT '',
  `exifMake` varchar(64) NOT NULL DEFAULT '',
  `exifMeteringMode` varchar(64) NOT NULL DEFAULT '',
  `exifOrientation` varchar(64) NOT NULL DEFAULT '',
  `exifResolutionUnit` varchar(64) NOT NULL DEFAULT '',
  `exifSceneCaptureType` varchar(64) NOT NULL DEFAULT '',
  `exifSceneType` varchar(64) NOT NULL DEFAULT '',
  `exifSensingMethod` varchar(64) NOT NULL DEFAULT '',
  `exifShutterSpeedValue` varchar(64) NOT NULL DEFAULT '',
  `exifSoftware` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `exifSubjectArea` varchar(64) NOT NULL DEFAULT '',
  `exifSubSecTimeDigitized` varchar(64) NOT NULL DEFAULT '',
  `exifSubSecTimeOriginal` varchar(64) NOT NULL DEFAULT '',
  `exifWhiteBalance` varchar(64) NOT NULL DEFAULT '',
  `exifXResolution` varchar(64) NOT NULL DEFAULT '',
  `exifYCbCrPositioning` varchar(64) NOT NULL DEFAULT '',
  `exifYResolution` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `userID` (`userID`),
  KEY `tempSet` (`tempSet`),
  KEY `setID` (`setID`),
  KEY `srcType` (`srcType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `feed_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(1024) NOT NULL,
  `link` varchar(1024) NOT NULL,
  `message` text NOT NULL,
  `imageSetID` int(11) NOT NULL,
  `access` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `imageSetID` (`imageSetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ATTENTION ! "Table truncation" must be implemented with care';


CREATE TABLE `feed_message_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `messageID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `type` enum('message','book','certification','university','course','language','school','company') NOT NULL DEFAULT 'message',
  `comment` text NOT NULL,
  `eventTimestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `messageID` (`messageID`),
  KEY `userID` (`userID`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `feed_message_params` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parameter` enum('like','spam','likeBook','likeCertification','likeUniversityDegree','likeCourse','likeLanguage','likeSchool','likeCompany') NOT NULL,
  `messageID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `messageID` (`messageID`),
  KEY `userID` (`userID`),
  KEY `parameter` (`parameter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `geo_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `geo_locality` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_region_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(128) NOT NULL,
  `population` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `geo_region_id` (`geo_region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `geo_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_country_id` int(11) NOT NULL DEFAULT '7',
  `title` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title_2` (`title`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `gifts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(256) NOT NULL DEFAULT '',
  `link` varchar(512) NOT NULL DEFAULT '',
  `logo_folder` varchar(32) NOT NULL DEFAULT '',
  `logo_filename` varchar(32) NOT NULL DEFAULT '',
  `estimated_price` int(11) NOT NULL DEFAULT '0',
  `description` varchar(1024) NOT NULL DEFAULT '',
  `requested_quantity` bigint(11) NOT NULL DEFAULT '1',
  `gained_quantity` int(11) NOT NULL DEFAULT '0',
  `eventTimestamp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `eventTimestamp` (`eventTimestamp`),
  KEY `estimated_price` (`estimated_price`),
  KEY `status` (`requested_quantity`),
  KEY `book_days` (`gained_quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `gifts_to_give` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `gift_id` int(11) NOT NULL,
  `reserve_period` int(3) NOT NULL DEFAULT '30' COMMENT 'Period length in days',
  `visibility` enum('visible','anonymous') NOT NULL DEFAULT 'visible',
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `gift_id` (`gift_id`),
  KEY `eventTimestamp` (`eventTimestamp`),
  KEY `reserve_period` (`reserve_period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `gift_thanks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `src_user_id` int(11) NOT NULL,
  `dst_user_id` int(11) NOT NULL,
  `gift_id` int(11) NOT NULL,
  `comment` varchar(512) NOT NULL,
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `src_user_id` (`src_user_id`),
  KEY `dst_user_id` (`dst_user_id`),
  KEY `gift_id` (`gift_id`),
  CONSTRAINT `gift_thanks_ibfk_1` FOREIGN KEY (`src_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `gift_thanks_ibfk_2` FOREIGN KEY (`dst_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `gift_thanks_ibfk_3` FOREIGN KEY (`gift_id`) REFERENCES `gifts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(64) NOT NULL DEFAULT '' COMMENT 'name in web-link',
  `title` varchar(64) NOT NULL COMMENT 'human readable title',
  `description` varchar(1024) NOT NULL DEFAULT '',
  `logo_folder` varchar(32) NOT NULL DEFAULT '',
  `logo_filename` varchar(32) NOT NULL DEFAULT '',
  `owner_id` int(11) NOT NULL,
  `isBlocked` enum('N','Y') NOT NULL DEFAULT 'N',
  `eventTimestampCreation` int(11) NOT NULL,
  `eventTimestampLastPost` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `link` (`link`),
  KEY `owner_id` (`owner_id`),
  KEY `isBlocked` (`isBlocked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `helpdesk_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `opener_user_id` (`customer_user_id`),
  CONSTRAINT `helpdesk_tickets_ibfk_1` FOREIGN KEY (`customer_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `helpdesk_ticket_attaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `helpdesk_ticket_history_id` int(11) NOT NULL,
  `filename` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `helpdesk_ticket_history_id` (`helpdesk_ticket_history_id`),
  CONSTRAINT `helpdesk_ticket_attaches_ibfk_1` FOREIGN KEY (`helpdesk_ticket_history_id`) REFERENCES `helpdesk_ticket_history` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `helpdesk_ticket_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `helpdesk_ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `severity` int(11) NOT NULL,
  `state` enum('new','customer_pending','company_pending','assigned','solution_provided','monitoring','close_pending','closed','severity_changed','change_company_user') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `helpdesk_ticket_id` (`helpdesk_ticket_id`),
  KEY `state` (`state`),
  KEY `eventTimestamp` (`eventTimestamp`),
  KEY `company_user_id` (`user_id`),
  KEY `severity` (`severity`),
  CONSTRAINT `helpdesk_ticket_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `helpdesk_ticket_history_ibfk_2` FOREIGN KEY (`helpdesk_ticket_id`) REFERENCES `helpdesk_tickets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `helpdesk_ticket_history_helpdesk_users_view` (`id` int(11), `helpdesk_ticket_id` int(11), `user_id` int(11), `severity` int(11), `state` enum('new','customer_pending','company_pending','assigned','solution_provided','monitoring','close_pending','closed','severity_changed','change_company_user'), `description` text, `eventTimestamp` int(11));


CREATE TABLE `helpdesk_ticket_history_last_case_state_view` (`id` int(11), `helpdesk_ticket_id` int(11), `user_id` int(11), `severity` int(11), `state` enum('new','customer_pending','company_pending','assigned','solution_provided','monitoring','close_pending','closed','severity_changed','change_company_user'), `description` text, `eventTimestamp` int(11));


CREATE TABLE `helpdesk_ticket_history_last_helpdesk_user_update_view` (`id` int(11), `helpdesk_ticket_id` int(11), `user_id` int(11), `severity` int(11), `state` enum('new','customer_pending','company_pending','assigned','solution_provided','monitoring','close_pending','closed','severity_changed','change_company_user'), `description` text, `eventTimestamp` int(11));


CREATE TABLE `language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(512) NOT NULL,
  `logo_folder` varchar(16) NOT NULL DEFAULT '',
  `logo_filename` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `name_sex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `sex` enum('male','female') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `sex` (`sex`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `password_dictionary_adjectives` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `password_dictionary_characteristics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `password_dictionary_nouns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `phone_confirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session` varchar(64) NOT NULL,
  `confirmation_code` varchar(8) NOT NULL,
  `country_code` varchar(8) NOT NULL DEFAULT '',
  `phone_number` varchar(32) NOT NULL DEFAULT '',
  `attempt` int(11) NOT NULL DEFAULT '0',
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `session` (`session`),
  KEY `confirmation_code` (`confirmation_code`),
  KEY `eventTimestamp` (`eventTimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `quick_registration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `invite_hash` bigint(15) NOT NULL,
  `action` enum('event') NOT NULL,
  `action_id` int(11) NOT NULL,
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invite_hash_2` (`invite_hash`),
  KEY `eventTimestamp` (`eventTimestamp`),
  KEY `invite_hash` (`invite_hash`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `school` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_locality_id` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `logo_folder` varchar(16) NOT NULL DEFAULT '',
  `logo_filename` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `geo_locality_id` (`geo_locality_id`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `sessions` (
  `id` varchar(128) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL,
  `country_auto` varchar(128) NOT NULL DEFAULT '',
  `city_auto` varchar(128) NOT NULL DEFAULT '',
  `lng` varchar(4) NOT NULL DEFAULT '',
  `ip` varchar(40) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `http_user_agent` varchar(512) NOT NULL DEFAULT '',
  `expire` int(11) NOT NULL DEFAULT '3600' COMMENT 'session duration in seconds',
  `remove_flag` enum('N','Y','pending') NOT NULL DEFAULT 'N',
  `remove_flag_timestamp` int(11) NOT NULL DEFAULT '0',
  `previous_sessid` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `time` (`time`),
  KEY `user_id` (`user_id`),
  KEY `previous_sesid` (`previous_sessid`),
  KEY `expire` (`expire`),
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `sessions_persistence_ratelimit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  `attempts` int(11) NOT NULL,
  `eventTimestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`),
  KEY `eventTimestamp` (`eventTimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `settings_default` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `setting` varchar(64) NOT NULL,
  `value` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting` (`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `site_themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `path` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(512) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `skill_confirmed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_skill_id` int(11) NOT NULL,
  `approver_userID` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `approver_userID` (`approver_userID`),
  KEY `users_skill_id` (`users_skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `sms_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(32) NOT NULL DEFAULT '',
  `sms_id` int(11) NOT NULL,
  `sms_cost` float NOT NULL,
  `sms_quantity` int(11) NOT NULL DEFAULT '1',
  `sms_text` varchar(1024) NOT NULL DEFAULT '',
  `current_balance` float NOT NULL,
  `eventTimestamp` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `temp_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT 'user uploaded image',
  `mediaType` enum('image','youtube_video') NOT NULL DEFAULT 'image',
  `folder` varchar(4) NOT NULL,
  `filename` varchar(64) NOT NULL,
  `eventTimestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `eventTimestamp` (`eventTimestamp`),
  KEY `user_id` (`user_id`),
  KEY `mediaType` (`mediaType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `university` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `geo_region_id` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `logo_folder` varchar(16) NOT NULL DEFAULT '',
  `logo_filename` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `geo_region_id` (`geo_region_id`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(64) NOT NULL DEFAULT '',
  `email_changeable` enum('Y','N') NOT NULL DEFAULT 'N',
  `type` enum('user','guest','helpdesk') NOT NULL DEFAULT 'user',
  `isactivated` enum('N','Y') NOT NULL DEFAULT 'N',
  `isblocked` enum('Y','N') NOT NULL DEFAULT 'N',
  `lng` varchar(20) NOT NULL DEFAULT '',
  `regdate` date NOT NULL DEFAULT '0000-01-01',
  `partnerid` int(10) unsigned NOT NULL DEFAULT '0',
  `country` int(10) unsigned NOT NULL DEFAULT '0',
  `geo_locality_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(30) NOT NULL DEFAULT '',
  `nameLast` varchar(30) NOT NULL DEFAULT '',
  `address` varchar(64) NOT NULL DEFAULT '',
  `phone` varchar(64) NOT NULL DEFAULT '',
  `country_code` varchar(5) NOT NULL DEFAULT '',
  `is_phone_confirmed` enum('Y','N') NOT NULL DEFAULT 'N',
  `cv` text NOT NULL,
  `sex` enum('male','female','') NOT NULL DEFAULT '',
  `site_theme_id` int(11) NOT NULL DEFAULT '2',
  `smartway_employee_id` varchar(64) NOT NULL DEFAULT '',
  `birthday` varchar(32) NOT NULL DEFAULT '00/00/0000',
  `birthdayAccess` enum('public','private') NOT NULL DEFAULT 'public',
  `appliedVacanciesRender` enum('all','inprogress') NOT NULL DEFAULT 'all' COMMENT 'declares vacancies render in profile_edit: "show all" / "in-progress"',
  `helpdesk_new_notification_S1_sms` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_new_notification_S2_sms` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_new_notification_S3_sms` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_new_notification_S4_sms` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_new_notification_S1_email` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_new_notification_S2_email` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_new_notification_S3_email` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_new_notification_S4_email` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_subscription_S1_sms` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_subscription_S2_sms` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_subscription_S3_sms` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_subscription_S4_sms` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_subscription_S1_email` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_subscription_S2_email` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_subscription_S3_email` enum('Y','N') NOT NULL DEFAULT 'N',
  `helpdesk_subscription_S4_email` enum('Y','N') NOT NULL DEFAULT 'N',
  `last_online` datetime NOT NULL DEFAULT '0000-01-01 00:00:00' COMMENT 'используется для presence',
  `last_onlineSecondsSinceY2k` bigint(15) NOT NULL DEFAULT '0',
  `ip` varchar(40) NOT NULL DEFAULT '',
  `activated` datetime NOT NULL DEFAULT '0000-01-01 00:00:00',
  `activator_sent` datetime NOT NULL DEFAULT '0000-01-01 00:00:00',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `login` (`login`),
  KEY `email` (`email`),
  KEY `name` (`name`),
  KEY `nameLast` (`nameLast`),
  KEY `birthdayAccess` (`birthdayAccess`),
  KEY `birthday` (`birthday`),
  KEY `isactivated` (`isactivated`),
  KEY `isblocked` (`isblocked`),
  KEY `site_theme_id` (`site_theme_id`),
  KEY `phone` (`phone`),
  KEY `country_code` (`country_code`),
  KEY `helpdesk_subscription_S4_email` (`helpdesk_subscription_S4_email`),
  KEY `helpdesk_subscription_S3_email` (`helpdesk_subscription_S3_email`),
  KEY `helpdesk_subscription_S2_email` (`helpdesk_subscription_S2_email`),
  KEY `helpdesk_subscription_S1_email` (`helpdesk_subscription_S1_email`),
  KEY `helpdesk_subscription_S4_sms` (`helpdesk_subscription_S4_sms`),
  KEY `helpdesk_subscription_S3_sms` (`helpdesk_subscription_S3_sms`),
  KEY `helpdesk_subscription_S2_sms` (`helpdesk_subscription_S2_sms`),
  KEY `helpdesk_subscription_S1_sms` (`helpdesk_subscription_S1_sms`),
  KEY `helpdesk_new_notification_S4_email` (`helpdesk_new_notification_S4_email`),
  KEY `helpdesk_new_notification_S3_email` (`helpdesk_new_notification_S3_email`),
  KEY `helpdesk_new_notification_S2_email` (`helpdesk_new_notification_S2_email`),
  KEY `helpdesk_new_notification_S1_email` (`helpdesk_new_notification_S1_email`),
  KEY `helpdesk_new_notification_S4_sms` (`helpdesk_new_notification_S4_sms`),
  KEY `helpdesk_new_notification_S3_sms` (`helpdesk_new_notification_S3_sms`),
  KEY `helpdesk_new_notification_S2_sms` (`helpdesk_new_notification_S2_sms`),
  KEY `helpdesk_new_notification_S1_sms` (`helpdesk_new_notification_S1_sms`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`site_theme_id`) REFERENCES `site_themes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_avatars` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) NOT NULL,
  `folder` text NOT NULL,
  `filename` text NOT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `isActive` (`isActive`),
  CONSTRAINT `users_avatars_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_block` (
  `userid` varchar(255) NOT NULL DEFAULT '',
  `date` datetime NOT NULL DEFAULT '0000-01-01 00:00:00',
  `notes` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `users_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `bookID` int(11) NOT NULL,
  `rating` int(1) NOT NULL DEFAULT '0',
  `bookReadTimestamp` int(11) NOT NULL COMMENT 'Timestamp book was read',
  PRIMARY KEY (`id`),
  KEY `userID` (`userID`),
  KEY `bookID` (`bookID`),
  KEY `isLiked` (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_certifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(15) NOT NULL,
  `track_id` int(11) NOT NULL,
  `certification_number` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `track_id` (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_company` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `position_title_id` int(11) NOT NULL,
  `occupation_start` date NOT NULL,
  `occupation_finish` date NOT NULL,
  `current_company` tinyint(1) NOT NULL,
  `responsibilities` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `company_id` (`company_id`),
  KEY `position_title_id` (`position_title_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_complains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `entityID` int(11) NOT NULL,
  `type` enum('company','certification','course','university','school','language','book') NOT NULL,
  `subtype` enum('image','title','description','general') NOT NULL,
  `complainComment` varchar(512) NOT NULL DEFAULT '',
  `resolveComment` varchar(512) NOT NULL DEFAULT '',
  `state` enum('new','handling','closed') NOT NULL DEFAULT 'new',
  `openEventTimestamp` int(11) NOT NULL,
  `closeEventTimestamp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entityID` (`entityID`),
  KEY `userID` (`userID`),
  KEY `subtype` (`subtype`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(15) NOT NULL,
  `track_id` int(11) NOT NULL,
  `rating` int(1) NOT NULL DEFAULT '0',
  `eventTimestamp` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `track_id` (`track_id`),
  KEY `rating` (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_friends` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `friendID` int(11) NOT NULL,
  `state` enum('requested','confirmed','blocked','ignored','requesting') NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userID` (`userID`),
  KEY `friendID` (`friendID`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(15) NOT NULL,
  `language_id` int(11) NOT NULL,
  `level` enum('Свободно','Читаю, пишу','Начинающий','') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `language_id` (`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_notification` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(1024) NOT NULL DEFAULT '',
  `userId` int(11) NOT NULL COMMENT 'User making an action',
  `actionTypeId` int(11) NOT NULL COMMENT 'Action type',
  `actionId` int(11) NOT NULL DEFAULT '0' COMMENT 'Additional data',
  `notificationStatus` enum('read','unread') NOT NULL DEFAULT 'unread',
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `actionTypeId` (`actionTypeId`),
  KEY `actionId` (`actionId`),
  KEY `notificationStatus` (`notificationStatus`),
  KEY `eventTimestamp_2` (`eventTimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_passwd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `passwd` varchar(128) NOT NULL,
  `isActive` enum('true','false') NOT NULL DEFAULT 'false',
  `eventTimestamp` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  PRIMARY KEY (`id`),
  KEY `userID` (`userID`),
  KEY `isActive` (`isActive`),
  KEY `passwd` (`passwd`),
  CONSTRAINT `users_passwd_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_recommendation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recommended_userID` int(11) NOT NULL,
  `recommending_userID` int(11) NOT NULL,
  `title` text NOT NULL,
  `eventTimestamp` int(11) NOT NULL,
  `state` enum('unknown','clean','potentially adverse','adverse') NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`),
  KEY `recommended_userID` (`recommended_userID`),
  KEY `recommending_userID` (`recommending_userID`),
  KEY `eventTimestamp` (`eventTimestamp`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_school` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `school_id` int(11) NOT NULL,
  `occupation_start` int(11) NOT NULL,
  `occupation_finish` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `school_id` (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(15) NOT NULL,
  `skill_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `skill_id` (`skill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `entity_type` enum('company','group') NOT NULL,
  `entity_id` int(11) NOT NULL,
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `entity_type` (`entity_type`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_university` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `university_id` int(11) NOT NULL,
  `degree` enum('Магистр','Бакалавр','Кандидат наук','Доктор наук','Другое','Студент') NOT NULL,
  `occupation_start` int(11) NOT NULL,
  `occupation_finish` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `university_id` (`university_id`),
  KEY `degree` (`degree`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users_watched` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `watched_userID` int(11) NOT NULL,
  `watching_userID` int(11) NOT NULL,
  `eventTimestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `watching_userID` (`watching_userID`),
  KEY `eventTimestamp` (`eventTimestamp`),
  KEY `watched_userID` (`watched_userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `helpdesk_ticket_history_helpdesk_users_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `helpdesk_ticket_history_helpdesk_users_view` AS select `helpdesk_ticket_history`.`id` AS `id`,`helpdesk_ticket_history`.`helpdesk_ticket_id` AS `helpdesk_ticket_id`,`helpdesk_ticket_history`.`user_id` AS `user_id`,`helpdesk_ticket_history`.`severity` AS `severity`,`helpdesk_ticket_history`.`state` AS `state`,`helpdesk_ticket_history`.`description` AS `description`,`helpdesk_ticket_history`.`eventTimestamp` AS `eventTimestamp` from `helpdesk_ticket_history` where `helpdesk_ticket_history`.`user_id` in (select `users`.`id` from `users` where (`users`.`type` = 'helpdesk'));

DROP TABLE IF EXISTS `helpdesk_ticket_history_last_case_state_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `helpdesk_ticket_history_last_case_state_view` AS select `a`.`id` AS `id`,`a`.`helpdesk_ticket_id` AS `helpdesk_ticket_id`,`a`.`user_id` AS `user_id`,`a`.`severity` AS `severity`,`a`.`state` AS `state`,`a`.`description` AS `description`,`a`.`eventTimestamp` AS `eventTimestamp` from (`helpdesk_ticket_history` `a` left join `helpdesk_ticket_history` `b` on(((`a`.`helpdesk_ticket_id` = `b`.`helpdesk_ticket_id`) and (`a`.`eventTimestamp` < `b`.`eventTimestamp`)))) where isnull(`b`.`helpdesk_ticket_id`);

DROP TABLE IF EXISTS `helpdesk_ticket_history_last_helpdesk_user_update_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `helpdesk_ticket_history_last_helpdesk_user_update_view` AS select `a`.`id` AS `id`,`a`.`helpdesk_ticket_id` AS `helpdesk_ticket_id`,`a`.`user_id` AS `user_id`,`a`.`severity` AS `severity`,`a`.`state` AS `state`,`a`.`description` AS `description`,`a`.`eventTimestamp` AS `eventTimestamp` from (`helpdesk_ticket_history_helpdesk_users_view` `a` left join `helpdesk_ticket_history_helpdesk_users_view` `b` on(((`a`.`helpdesk_ticket_id` = `b`.`helpdesk_ticket_id`) and (`a`.`eventTimestamp` < `b`.`eventTimestamp`)))) where isnull(`b`.`helpdesk_ticket_id`);

