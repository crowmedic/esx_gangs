USE `essentialmode`;

CREATE TABLE 'gangs' (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,

  PRIMARY KEY (`id`)
);

INSERT INTO gangs (name, label)
VALUES ('none', 'Unaffiliated'); 

CREATE TABLE 'gang_grades' (

  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gang_name` varchar(255) NOT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,

  PRIMARY KEY (`id`)
);


INSERT INTO gang_grades (gang_name, grade, name, label)
VALUES ('none', 0, 'none', 'Unaffiliated'); 
