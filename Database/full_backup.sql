-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: studentattendancedb
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `classmaster`
--

DROP TABLE IF EXISTS `classmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classmaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Class` varchar(10) DEFAULT NULL,
  `Remarks` varchar(255) DEFAULT NULL,
  `CreatedBy` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classmaster`
--

LOCK TABLES `classmaster` WRITE;
/*!40000 ALTER TABLE `classmaster` DISABLE KEYS */;
INSERT INTO `classmaster` VALUES (1,'5A',NULL,1,'2025-07-24 17:29:39',1,'2025-07-24 21:38:00'),(2,'5B',NULL,1,'2025-07-24 21:38:00',1,'2025-07-24 21:38:00');
/*!40000 ALTER TABLE `classmaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissionmaster`
--

DROP TABLE IF EXISTS `permissionmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissionmaster` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `PermissionName` varchar(100) DEFAULT NULL,
  `Remarks` varchar(255) DEFAULT NULL,
  `CreatedBy` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissionmaster`
--

LOCK TABLES `permissionmaster` WRITE;
/*!40000 ALTER TABLE `permissionmaster` DISABLE KEYS */;
INSERT INTO `permissionmaster` VALUES (1,'StudentList',NULL,1,'2025-07-24 19:49:59',1,'2025-07-24 19:49:59'),(2,'StudentAddUpdate',NULL,1,'2025-07-24 19:49:59',1,'2025-07-24 19:49:59'),(3,'StudentDelete',NULL,1,'2025-07-24 19:49:59',1,'2025-07-24 19:49:59');
/*!40000 ALTER TABLE `permissionmaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `RollNo` varchar(20) DEFAULT NULL,
  `Active` tinyint(1) DEFAULT '1',
  `Remarks` varchar(255) DEFAULT NULL,
  `CreatedBy` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Bhavesh','Khokhar','1',1,'',1,'2025-07-25 18:10:07',0,'2025-07-25 18:10:07'),(2,'Laxman','Khokhar','2',1,'',1,'2025-07-25 18:10:07',0,'2025-07-25 18:10:07'),(6,'Abhishek','Jain','1',1,'',1,'2025-07-25 18:14:12',0,'2025-07-25 18:14:12'),(7,'Divyesh','Patel','2',1,'',1,'2025-07-25 18:14:12',0,'2025-07-25 18:14:12'),(8,'Nishit','Patel','3',1,'',1,'2025-07-25 18:14:12',0,'2025-07-25 18:14:12'),(9,'Vipul','Jain','3',1,'',1,'2025-07-25 18:15:01',1,'2025-07-25 18:16:38');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentattendance`
--

DROP TABLE IF EXISTS `studentattendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentattendance` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `StudentId` int DEFAULT NULL,
  `AttendanceDate` date DEFAULT NULL,
  `Status` int DEFAULT NULL,
  `Remarks` varchar(255) DEFAULT NULL,
  `CreatedBy` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `StudentId` (`StudentId`),
  CONSTRAINT `studentattendance_ibfk_1` FOREIGN KEY (`StudentId`) REFERENCES `student` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentattendance`
--

LOCK TABLES `studentattendance` WRITE;
/*!40000 ALTER TABLE `studentattendance` DISABLE KEYS */;
INSERT INTO `studentattendance` VALUES (1,2,'2025-07-25',1,'Present',1,'2025-07-25 18:14:28',0,'2025-07-25 18:14:28'),(2,6,'2025-07-25',1,'Present',1,'2025-07-25 18:14:37',0,'2025-07-25 18:14:37');
/*!40000 ALTER TABLE `studentattendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentclassmapping`
--

DROP TABLE IF EXISTS `studentclassmapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentclassmapping` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `StudentId` int DEFAULT NULL,
  `ClassId` int DEFAULT NULL,
  `FromDate` date DEFAULT NULL,
  `ToDate` date DEFAULT NULL,
  `Active` tinyint(1) DEFAULT '1',
  `Remarks` varchar(255) DEFAULT NULL,
  `CreatedBy` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `StudentId` (`StudentId`),
  KEY `ClassId` (`ClassId`),
  CONSTRAINT `studentclassmapping_ibfk_1` FOREIGN KEY (`StudentId`) REFERENCES `student` (`Id`),
  CONSTRAINT `studentclassmapping_ibfk_2` FOREIGN KEY (`ClassId`) REFERENCES `classmaster` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentclassmapping`
--

LOCK TABLES `studentclassmapping` WRITE;
/*!40000 ALTER TABLE `studentclassmapping` DISABLE KEYS */;
INSERT INTO `studentclassmapping` VALUES (1,1,1,'2025-07-25',NULL,1,'',1,'2025-07-25 18:10:07',0,'2025-07-25 18:10:07'),(2,2,1,'2025-07-25',NULL,1,'',1,'2025-07-25 18:10:07',0,'2025-07-25 18:10:07'),(3,6,2,'2025-07-25',NULL,1,'',1,'2025-07-25 18:14:12',0,'2025-07-25 18:14:12'),(4,7,2,'2025-07-25',NULL,1,'',1,'2025-07-25 18:14:12',0,'2025-07-25 18:14:12'),(5,8,1,'2025-07-25',NULL,1,'',1,'2025-07-25 18:14:12',0,'2025-07-25 18:14:12'),(6,9,2,'2025-07-25',NULL,1,'',1,'2025-07-25 18:15:01',1,'2025-07-25 18:16:38');
/*!40000 ALTER TABLE `studentclassmapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(100) DEFAULT NULL,
  `Password` varchar(256) DEFAULT NULL,
  `Remarks` varchar(255) DEFAULT NULL,
  `CreatedBy` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserName` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Principal','kPP9vfI+OHedJz/LHXH9LA==','Password:Test@123',NULL,'2025-07-24 19:41:53',0,'2025-07-25 18:06:41'),(2,'Student','kPP9vfI+OHedJz/LHXH9LA==','Password:Test@123',NULL,'2025-07-24 19:42:35',0,'2025-07-25 18:06:41');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermission`
--

DROP TABLE IF EXISTS `userpermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpermission` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UserId` int DEFAULT NULL,
  `PermissionId` int DEFAULT NULL,
  `Remarks` varchar(255) DEFAULT NULL,
  `CreatedBy` int DEFAULT NULL,
  `CreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `UpdatedBy` int DEFAULT '0',
  `UpdatedDate` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`),
  KEY `PermissionId` (`PermissionId`),
  CONSTRAINT `userpermission_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `user` (`Id`),
  CONSTRAINT `userpermission_ibfk_2` FOREIGN KEY (`PermissionId`) REFERENCES `permissionmaster` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermission`
--

LOCK TABLES `userpermission` WRITE;
/*!40000 ALTER TABLE `userpermission` DISABLE KEYS */;
INSERT INTO `userpermission` VALUES (1,1,1,NULL,1,'2025-07-24 19:50:51',1,'2025-07-24 19:50:51'),(2,1,2,NULL,1,'2025-07-24 19:50:51',1,'2025-07-24 19:50:51'),(3,1,3,NULL,1,'2025-07-24 19:50:51',1,'2025-07-24 19:50:51');
/*!40000 ALTER TABLE `userpermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'studentattendancedb'
--

--
-- Dumping routines for database 'studentattendancedb'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_CheckUserPermission` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_CheckUserPermission`(
    IN p_UserId INT
)
BEGIN
    SELECT up.Id as PermissionId, pm.PermissionName
    FROM userpermission up
    INNER JOIN permissionmaster pm ON pm.Id = up.PermissionId
    WHERE up.UserId = p_UserId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetAttendanceSummaryToday` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetAttendanceSummaryToday`()
BEGIN
    SELECT
        (SELECT COUNT(*) FROM studentattendance WHERE AttendanceDate = CURDATE() AND Status = 1) AS PresentCount,
        (SELECT COUNT(*) FROM studentattendance WHERE AttendanceDate = CURDATE() AND Status = 0) AS AbsentCount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetCommonData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetCommonData`()
BEGIN
    SELECT 
        Id, 
        Class AS Value
    FROM classmaster;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetStudentReport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetStudentReport`(
  IN p_FromDate DATE,
  IN p_ToDate DATE,
  IN p_StudentName VARCHAR(100),
  IN p_RollNo VARCHAR(50),
  IN p_Status VARCHAR(10)
)
BEGIN
  SELECT 
    s.FirstName, 
    s.LastName, 
    s.RollNo, 
    coalesce(cm.Class, '') AS Class,
    a.AttendanceDate, 
    CASE WHEN a.Status = 1 THEN 'Present' ELSE 'Absent' END AS Status
  FROM 
    studentattendance a
    JOIN student s ON s.Id = a.StudentId AND s.Active = 1
    LEFT JOIN studentclassmapping sc ON sc.Id = s.Id AND sc.Active = 1
    LEFT JOIN classmaster cm on cm.Id = sc.ClassId
  WHERE 
    a.AttendanceDate BETWEEN p_FromDate AND p_ToDate
    AND (p_Status IS NULL OR a.Status = CASE WHEN p_Status = 'Present' THEN 1 WHEN p_Status = 'Absent' THEN 0 ELSE a.Status END)
    AND (p_StudentName IS NULL OR s.FirstName LIKE CONCAT('%', p_StudentName, '%') OR s.LastName LIKE CONCAT('%', p_StudentName, '%'))
	AND (p_RollNo IS NULL OR s.RollNo LIKE CONCAT('%', p_RollNo, '%'))
  ORDER BY 
    a.AttendanceDate DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_GetStudents` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetStudents`(
    IN p_SearchKeyword VARCHAR(100),
    IN p_PageIndex INT,
    IN p_PageSize INT,
    IN p_SortColumn VARCHAR(50),
    IN p_SortDirection VARCHAR(4) 
)
BEGIN
	DECLARE v_Offset INT;
    SET v_Offset = (p_PageIndex - 1) * p_PageSize;

	
    SELECT COUNT(*) AS TotalCount
    FROM student s
    LEFT JOIN studentclassmapping scm ON scm.StudentId = s.Id AND scm.Active = TRUE
    LEFT JOIN classmaster cm ON cm.Id = scm.ClassId
    WHERE s.Active = 1
      AND (p_SearchKeyword IS NULL OR p_SearchKeyword = ''
           OR s.FirstName LIKE CONCAT('%', p_SearchKeyword, '%')
           OR s.LastName LIKE CONCAT('%', p_SearchKeyword, '%')
           OR s.RollNo LIKE CONCAT('%', p_SearchKeyword, '%'));

	
    SELECT s.Id, s.FirstName, s.LastName, s.RollNo, coalesce(cm.Class, '') as Class
    FROM student s
    LEFT JOIN studentclassmapping scm ON scm.StudentId = s.Id AND scm.Active = TRUE
    LEFT JOIN classmaster cm ON cm.Id = scm.ClassId
    WHERE s.Active = 1
      AND (p_SearchKeyword IS NULL OR p_SearchKeyword = ''
           OR s.FirstName LIKE CONCAT('%', p_SearchKeyword, '%')
           OR s.LastName LIKE CONCAT('%', p_SearchKeyword, '%')
           OR s.RollNo LIKE CONCAT('%', p_SearchKeyword, '%'))
	ORDER BY
        CASE WHEN p_SortColumn = 'FirstName' AND p_SortDirection = 'ASC' THEN s.FirstName END ASC,
        CASE WHEN p_SortColumn = 'FirstName' AND p_SortDirection = 'DESC' THEN s.FirstName END DESC,
        CASE WHEN p_SortColumn = 'LastName' AND p_SortDirection = 'ASC' THEN s.LastName END ASC,
        CASE WHEN p_SortColumn = 'LastName' AND p_SortDirection = 'DESC' THEN s.LastName END DESC,
        CASE WHEN p_SortColumn = 'RollNo' AND p_SortDirection = 'ASC' THEN s.RollNo END ASC,
        CASE WHEN p_SortColumn = 'RollNo' AND p_SortDirection = 'DESC' THEN s.RollNo END DESC,
        CASE WHEN p_SortColumn = 'Class' AND p_SortDirection = 'ASC' THEN cm.Class END ASC,
        CASE WHEN p_SortColumn = 'Class' AND p_SortDirection = 'DESC' THEN cm.Class END DESC,
		CASE WHEN p_SortColumn = 'CreatedDate' AND p_SortDirection = 'ASC' THEN s.CreatedDate END ASC,
        CASE WHEN p_SortColumn = 'CreatedDate' AND p_SortDirection = 'DESC' THEN s.CreatedDate END DESC
    LIMIT v_Offset, p_PageSize;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_MarkAttendance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_MarkAttendance`(
    IN p_StudentId INT,
    IN p_AttendanceDate DATE,
    IN p_Status TINYINT,
    IN p_UserId INT,
    IN p_Remarks VARCHAR(255)
)
BEGIN
	DECLARE message VARCHAR(255);
    IF EXISTS (
        SELECT 1 FROM StudentAttendance WHERE StudentId = p_StudentId AND AttendanceDate = p_AttendanceDate
    ) THEN
        UPDATE StudentAttendance
        SET Status = p_Status,
            UpdatedBy = p_UserId,
            UpdatedDate = CURRENT_TIMESTAMP,
            Remarks = p_Remarks
        WHERE StudentId = p_StudentId AND AttendanceDate = p_AttendanceDate;
        SET message = 'Attendance Updated Succesfully.';
    ELSE
        INSERT INTO StudentAttendance (StudentId, AttendanceDate, Status, CreatedBy, Remarks)
        VALUES (p_StudentId, p_AttendanceDate, p_Status, p_UserId, p_Remarks);
        SET message = 'Attendance Added Succesfully.';
    END IF;
    SELECT message; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_SaveStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_SaveStudent`(
    IN p_Id INT,
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_RollNo VARCHAR(20),
    IN p_ClassId INT,
    IN p_UserId INT,
    IN p_Remarks VARCHAR(255)
)
BEGIN
	DECLARE newStudentId INT;
    IF p_Id = 0 THEN
        INSERT INTO Student (FirstName, LastName, RollNo, CreatedBy, Remarks)
        VALUES (p_FirstName, p_LastName, p_RollNo, p_UserId, p_Remarks);

        SET newStudentId = LAST_INSERT_ID();

        INSERT INTO StudentClassMapping (StudentId, ClassId, FromDate, CreatedBy, Remarks)
        VALUES (newStudentId, p_ClassId, CURDATE(), p_UserId, p_Remarks);
    ELSE
        UPDATE student
        SET FirstName = p_FirstName,
            LastName = p_LastName,
            RollNo = p_RollNo,
            UpdatedBy = p_UserId,
            UpdatedDate = CURRENT_TIMESTAMP,
            Remarks = p_Remarks
        WHERE Id = p_Id;

        UPDATE studentclassmapping
        SET ClassId = p_ClassId,
            UpdatedBy = p_UserId,
            UpdatedDate = CURRENT_TIMESTAMP,
            Remarks = p_Remarks
        WHERE StudentId = p_Id AND Active = TRUE;
    END IF;
    SELECT CASE WHEN p_Id = 0 THEN newStudentId ELSE p_Id END AS StudentId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_UserRegister` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_UserRegister`(
    IN p_Id INT,
    IN p_UserName VARCHAR(100),
    IN p_Password VARCHAR(255),
    IN p_CreatedBy INT,
    IN p_Remarks VARCHAR(255)
)
BEGIN
    DECLARE v_Count INT;

    IF p_Id IS NULL OR p_Id = 0 THEN
        
        SELECT COUNT(*) INTO v_Count FROM User WHERE UserName = p_UserName;
        
        IF v_Count > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User already exists.';
        ELSE
            
            INSERT INTO User (UserName, Password, CreatedDate, CreatedBy, Remarks)
            VALUES (p_UserName, p_Password, NOW(), p_CreatedBy, p_Remarks);
        END IF;
    ELSE
        
        UPDATE User
        SET
            UserName = p_UserName,
            Password = p_Password,
            UpdatedDate = NOW(),
            UpdatedBy = p_CreatedBy,
            Remarks = p_Remarks
        WHERE Id = p_Id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ValidateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ValidateUser`(
    IN p_UserName VARCHAR(100),
    IN p_Password VARCHAR(256)
)
BEGIN
    SELECT u.Id AS UserId, u.UserName
    FROM user u
    WHERE u.UserName = p_UserName AND u.Password = p_Password LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-02 19:46:20
