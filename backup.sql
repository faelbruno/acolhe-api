-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: acolhe
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acolhimentos`
--

DROP TABLE IF EXISTS `acolhimentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acolhimentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_psicossocial` int(11) NOT NULL,
  `id_aluno` int(11) NOT NULL,
  `id_oficina` int(11) NOT NULL,
  `data_horario` datetime NOT NULL,
  `local` enum('Unidade','Residência','Outros') NOT NULL,
  `motivo` enum('Matrícula','Acompanhamento','Outros') NOT NULL,
  `unidade_responsavel` int(11) NOT NULL,
  `status` enum('Agendado','Concluído','Remarcado','Cancelado') DEFAULT 'Agendado',
  `observacoes` text DEFAULT NULL,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp(),
  `atualizado_em` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `id_psicossocial` (`id_psicossocial`),
  KEY `id_aluno` (`id_aluno`),
  KEY `id_oficina` (`id_oficina`),
  KEY `unidade_responsavel` (`unidade_responsavel`),
  CONSTRAINT `acolhimentos_ibfk_1` FOREIGN KEY (`id_psicossocial`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `acolhimentos_ibfk_2` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id`),
  CONSTRAINT `acolhimentos_ibfk_3` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `acolhimentos_ibfk_4` FOREIGN KEY (`unidade_responsavel`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acolhimentos`
--

LOCK TABLES `acolhimentos` WRITE;
/*!40000 ALTER TABLE `acolhimentos` DISABLE KEYS */;
INSERT INTO `acolhimentos` VALUES (5,1,80,6,'2024-11-24 21:30:00','Unidade','Matrícula',1,'Agendado','sadsasd','2024-11-25 04:40:21','2024-11-25 04:40:21'),(6,1,80,1,'2024-11-24 22:30:00','Unidade','Acompanhamento',1,'Agendado','123asd','2024-11-25 04:42:01','2024-11-25 04:42:01');
/*!40000 ALTER TABLE `acolhimentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aluno_oficinas`
--

DROP TABLE IF EXISTS `aluno_oficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_oficinas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) NOT NULL,
  `id_oficina` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_aluno` (`id_aluno`),
  KEY `id_oficina` (`id_oficina`),
  CONSTRAINT `aluno_oficinas_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `aluno_oficinas_ibfk_2` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno_oficinas`
--

LOCK TABLES `aluno_oficinas` WRITE;
/*!40000 ALTER TABLE `aluno_oficinas` DISABLE KEYS */;
INSERT INTO `aluno_oficinas` VALUES (51,2,2),(52,3,2),(55,78,2),(62,1,2),(63,1,3),(71,82,1),(72,82,2),(73,82,3),(74,82,4),(75,82,6),(81,80,1),(82,80,6),(93,83,1),(94,83,2),(95,83,3),(96,83,4),(97,83,6),(98,1,1),(102,1,1),(103,1,2),(104,1,5),(105,1,1),(106,1,5),(107,1,1),(108,79,2),(109,79,5),(110,81,1),(111,81,2),(112,81,3),(113,81,4),(114,81,6),(115,82,1),(116,82,2),(117,82,3),(118,82,4),(119,82,6),(120,78,2),(121,2,2),(122,3,2),(123,4,1),(124,4,3),(125,5,2);
/*!40000 ALTER TABLE `aluno_oficinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alunos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `idade` int(11) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `id_unidade` int(11) DEFAULT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `sexo` enum('Masculino','Feminino','Outro') DEFAULT NULL,
  `nome_pai` varchar(255) DEFAULT NULL,
  `nome_mae` varchar(255) DEFAULT NULL,
  `responsavel` varchar(255) DEFAULT NULL,
  `contato` varchar(15) DEFAULT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `oficina` int(11) DEFAULT NULL,
  `foto` longblob DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_unidade` (`id_unidade`),
  CONSTRAINT `alunos_ibfk_1` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES (1,'Lucas Albuquerque da Silva Mendonça',18,'Rua A, 123, Cuiabá',1,'888.888.888','2024-10-01','Masculino','Fulano de Tal','Beltrana de 123','Beltrana de 123','65992252525','ww',1,'uploads/Rogerio.png'),(2,'Julia Costa e Silva',19,'Rua B, 456, Várzea Grande',1,'2222','2024-10-09','Masculino','asdasd','asdasd','asdasd','99999','123123',1,'uploads/Georgia.png'),(3,'Pedro Lima de Campos',17,'Rua C, 789, Rondonópolis',1,NULL,'2024-10-22','Masculino','Kakaroto','Bulma','Kuriri','659999999','Esq. do Dragon Ball',1,'uploads/Humberto.png'),(4,'Mariana Rocha Silveira',20,'Rua D, 321, Nova Olímpia',1,NULL,'2024-10-23','Masculino','Levado','Levada','Levada','659999999','Rua dos 123',1,'uploads/livia.png'),(5,'Julio Silva Silva',22,'Rua E, 654, Cáceres',1,NULL,'2024-10-23','Masculino','Rubens','Catia','Catia','65999999','Vila do Chaves',1,'uploads/mateus.png'),(78,'Augusto Fernando da Silva',0,'Rua do Zé Colméia',1,'8888888881','2024-10-22','Masculino','Raimundo','Maria','Maria 123','9188888888','123',NULL,'uploads/Rhuan.png'),(79,'João Marcelo da Cruz',0,'Rua das Esferas',1,'82521332112','2015-10-23','Masculino','Mestre Kame','Bulma','Bulma','6599999','',NULL,'uploads/Kuririn.png'),(80,'Luan Santana',0,'asdasd',1,'123234234','2024-10-30','Masculino','asdasd','asdasd','asdasd','2123123','',NULL,'uploads/aut2.jpeg'),(81,'Gustavo Henrique de Lima',0,'asdasd',1,'123123123','2024-10-30','Masculino','asdasd','asdas','asdasd','123123','',NULL,'uploads/TESTE.jpg'),(82,'Raimundo Bruno Venâncio Nonato',0,'Rua 123',1,'23423423','2024-10-17','Masculino','Fulano de Tal','Fulana de Tal','Fulana de Tal','659999999','',NULL,'uploads/joker.jpg'),(83,'Alexandre Pires',0,'Rua dos Testes',1,'34534534534','2024-10-16','Masculino','Fulano de Tal','Fulana de Tal','Fulana de Tal','2134234234','',NULL,'uploads/logo-golfinho.png');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avisos`
--

DROP TABLE IF EXISTS `avisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avisos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `mensagem` text NOT NULL,
  `id_unidade` int(11) DEFAULT NULL,
  `data_aviso` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_unidade` (`id_unidade`),
  CONSTRAINT `avisos_ibfk_1` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avisos`
--

LOCK TABLES `avisos` WRITE;
/*!40000 ALTER TABLE `avisos` DISABLE KEYS */;
/*!40000 ALTER TABLE `avisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matriculas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) DEFAULT NULL,
  `id_oficina` int(11) DEFAULT NULL,
  `data_matricula` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_aluno` (`id_aluno`),
  KEY `id_oficina` (`id_oficina`),
  CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id`),
  CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
INSERT INTO `matriculas` VALUES (1,1,1,'2024-08-01'),(2,2,2,'2024-08-02'),(3,3,3,'2024-08-03'),(4,4,4,'2024-08-04'),(5,5,5,'2024-08-05');
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `observacoes`
--

DROP TABLE IF EXISTS `observacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_matricula` int(11) DEFAULT NULL,
  `comentario` text NOT NULL,
  `data` date NOT NULL,
  `profissional` varchar(255) DEFAULT NULL,
  `id_aluno_oficina` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_observacoes_aluno_oficinas` (`id_aluno_oficina`),
  KEY `observacoes_ibfk_1` (`id_matricula`),
  CONSTRAINT `fk_observacoes_aluno_oficinas` FOREIGN KEY (`id_aluno_oficina`) REFERENCES `aluno_oficinas` (`id`),
  CONSTRAINT `observacoes_ibfk_1` FOREIGN KEY (`id_matricula`) REFERENCES `matriculas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observacoes`
--

LOCK TABLES `observacoes` WRITE;
/*!40000 ALTER TABLE `observacoes` DISABLE KEYS */;
INSERT INTO `observacoes` VALUES (3,3,'Necessita de acompanhamento.','2024-08-07','Professor',52),(14,1,'asdasd','2024-10-14','Rafael Mendes',62),(19,2,'Hj ele foi muito mal educado.','2024-10-14','Rafael Mendes',51),(25,NULL,'Bricou na informatica','2024-10-30','Rafael B A Mendes',71),(26,NULL,'Brigou em Artes','2024-10-30','Rafael B A Mendes',72),(27,NULL,'Brugou em Musica','2024-10-30','Rafael B A Mendes',73),(30,NULL,'Brigou em Handball','2024-10-30','Rafael B A Mendes',75),(31,NULL,'Hoje ele estava impulsivo demais.','2024-11-18','Rafael Bruno Amorim Mendes',55),(32,NULL,'sdfsdf','2024-11-18','Rafael Bruno Amorim Mendes',55),(33,NULL,'Hoje fez toda tarefa!','2024-11-18','Rafael Bruno Amorim Mendes',51);
/*!40000 ALTER TABLE `observacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oficinas`
--

DROP TABLE IF EXISTS `oficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oficinas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `id_unidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_unidade` (`id_unidade`),
  CONSTRAINT `oficinas_ibfk_1` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oficinas`
--

LOCK TABLES `oficinas` WRITE;
/*!40000 ALTER TABLE `oficinas` DISABLE KEYS */;
INSERT INTO `oficinas` VALUES (1,'Oficina de Informática',1),(2,'Oficina de Artes',1),(3,'Oficina de Música',1),(4,'Oficina de Dança',1),(5,'Oficina de Esporte',4),(6,'Handball',1);
/*!40000 ALTER TABLE `oficinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `presencas`
--

DROP TABLE IF EXISTS `presencas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presencas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aluno` int(11) DEFAULT NULL,
  `data` date NOT NULL,
  `status` enum('presente','ausente','justificado') NOT NULL,
  `id_oficina` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_presenca` (`id_aluno`,`data`,`id_oficina`),
  KEY `id_matricula` (`id_aluno`),
  CONSTRAINT `presencas_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=796 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presencas`
--

LOCK TABLES `presencas` WRITE;
/*!40000 ALTER TABLE `presencas` DISABLE KEYS */;
INSERT INTO `presencas` VALUES (741,82,'2024-11-20','ausente',1),(742,80,'2024-11-20','ausente',1),(743,81,'2024-11-20','ausente',1),(744,83,'2024-11-20','ausente',1),(745,1,'2024-11-20','ausente',1),(746,2,'2024-11-20','ausente',2),(747,3,'2024-11-20','ausente',2),(748,5,'2024-11-20','ausente',2),(749,78,'2024-11-20','ausente',2),(750,1,'2024-11-20','ausente',2),(751,79,'2024-11-20','ausente',2),(752,82,'2024-11-20','ausente',2),(753,81,'2024-11-20','ausente',2),(754,83,'2024-11-20','ausente',2),(760,82,'2024-11-19','presente',1),(761,80,'2024-11-19','presente',1),(762,83,'2024-11-19','presente',1),(763,1,'2024-11-19','presente',1),(764,81,'2024-11-19','presente',1),(765,4,'2024-11-19','presente',1),(784,82,'2024-11-18','presente',1),(785,80,'2024-11-18','presente',1),(786,83,'2024-11-18','presente',1),(787,1,'2024-11-18','presente',1),(788,81,'2024-11-18','presente',1),(789,4,'2024-11-18','presente',1),(790,82,'2024-11-24','presente',1),(791,80,'2024-11-24','presente',1),(792,83,'2024-11-24','presente',1),(793,1,'2024-11-24','presente',1),(794,81,'2024-11-24','presente',1),(795,4,'2024-11-24','presente',1);
/*!40000 ALTER TABLE `presencas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor_oficinas`
--

DROP TABLE IF EXISTS `professor_oficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professor_oficinas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_professor` int(11) DEFAULT NULL,
  `id_oficina` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_professor` (`id_professor`),
  KEY `id_oficina` (`id_oficina`),
  CONSTRAINT `professor_oficinas_ibfk_1` FOREIGN KEY (`id_professor`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `professor_oficinas_ibfk_2` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor_oficinas`
--

LOCK TABLES `professor_oficinas` WRITE;
/*!40000 ALTER TABLE `professor_oficinas` DISABLE KEYS */;
INSERT INTO `professor_oficinas` VALUES (11,2,1),(12,2,2),(13,2,3),(85,16,4),(86,16,5),(87,17,1),(88,17,5),(89,12,4),(90,12,5),(91,13,4),(92,13,5),(93,14,3),(94,14,4),(95,15,3),(122,9,1),(123,9,2),(124,9,3),(125,9,4),(126,9,5),(127,6,1),(128,6,2),(131,8,4);
/*!40000 ALTER TABLE `professor_oficinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades`
--

DROP TABLE IF EXISTS `unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades`
--

LOCK TABLES `unidades` WRITE;
/*!40000 ALTER TABLE `unidades` DISABLE KEYS */;
INSERT INTO `unidades` VALUES (1,'Cuiabá'),(2,'Várzea Grande'),(3,'Rondonópolis'),(4,'Nova Olímpia'),(5,'Cáceres');
/*!40000 ALTER TABLE `unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('Psicossocial','Professor','Coordenador','Administrativo') NOT NULL,
  `id_unidade` int(11) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `sexo` enum('masculino','feminino') NOT NULL,
  `contato` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `id_unidade` (`id_unidade`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'João da Silva','faelbruno@gmail.com','123456','Psicossocial',1,'lib/img/upload/FOTO-RAFAEL-BRUNO-3X4.png',NULL,'masculino',NULL,NULL,NULL,1),(2,'Maria Oliveira','maria@exemplo.com','0','Professor',2,'lib/img/upload/Screenshot_4.png',NULL,'masculino',NULL,NULL,NULL,1),(3,'Carlos Pereira','carlos@exemplo.com','senha789','Coordenador',1,NULL,NULL,'masculino',NULL,NULL,NULL,1),(4,'Ana Santos','ana@exemplo.com','senha123','Professor',2,NULL,NULL,'masculino',NULL,NULL,NULL,1),(5,'Fernanda Almeida','fernanda@exemplo.com','senha456','Coordenador',2,NULL,NULL,'masculino',NULL,NULL,NULL,1),(6,'Rafael Bruno Amorim Mendes','mendes.analista@gmail.com','123456','Professor',1,'lib/img/upload/FOTO-RAFAEL-BRUNO-3X4.png',NULL,'masculino','65992252121','Rua 123',NULL,1),(7,'Valquiria','valqmesquita@gmail.com','123456','Administrativo',1,'lib/img/upload/FOTO-RAFAEL-BRUNO-3X4.png',NULL,'feminino','65992252121','Rua 123','88701662287',1),(8,'Julio','julio@com','123456','Professor',1,'lib/img/upload/Screenshot_5.png',NULL,'masculino',NULL,NULL,NULL,1),(9,'Roberto Renato','barba@azul.com','123456','Professor',1,'lib/img/upload/Screenshot_5.png',NULL,'masculino',NULL,NULL,NULL,1),(12,'Ricardo','ricardo@gmail.com','123456','Professor',1,'lib/img/upload/Screenshot_6.png',NULL,'masculino',NULL,NULL,'888888',1),(13,'Junior','junior@gmail.com','123456','Professor',1,'lib/img/upload/Screenshot_5.png',NULL,'masculino',NULL,NULL,'777777',1),(14,'Kátia Martins','kutia@gmail.com','123456','Professor',1,'lib/img/upload/Screenshot_2.png',NULL,'masculino',NULL,NULL,'99999',1),(15,'Bruno Mezenga','bruno@bruno.com','123456','Professor',1,'lib/img/upload/Rogerio.png','2024-10-09','masculino',NULL,NULL,'1111111',1),(16,'Rafael Bruno','rafaelbruno@gmail.com','123456','Professor',1,'lib/img/upload/FOTO-RAFAEL-BRUNO-3X4.png','2024-10-23','masculino',NULL,NULL,'83298355291',1),(17,'Jaqueline Silva','jaqueline@gmail.com','123456','Professor',1,'lib/img/upload/Screenshot_2.png','2024-10-23','masculino',NULL,NULL,'222222222',1),(18,'Luis Fernando','vegeta@gmail.com','123456','Professor',1,'uploads/vegeta.png','2024-10-23','masculino',NULL,NULL,'88888888',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-24 23:00:01
