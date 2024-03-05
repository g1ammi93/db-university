-- SELECT

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * FROM `students` WHERE `date_of_birth` LIKE '1990%'; 

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM `courses` WHERE `cfu` > 10; 

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) <= 1994; 

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * FROM `courses` WHERE `period` = 'I semestre' AND `year` = '1'; 

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * FROM `exams` WHERE `hour` > '14:00:00' AND date = '2020-06-20'; 

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT * FROM `degrees` WHERE `level` = 'magistrale'; 

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(*) FROM `departments`; 

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT COUNT(*) FROM `teachers` WHERE `phone` IS NULL; 


-- GROUP



-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*), YEAR(`enrolment_date`) FROM `students` GROUP BY YEAR(`enrolment_date`) ORDER BY YEAR(`enrolment_date`); 

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(*), `office_address` FROM `teachers` GROUP BY (`office_address`); 

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT `exam_id` , AVG(`vote`) FROM `exam_student` GROUP BY `exam_id`; 

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(*), `degree_id` FROM `courses` GROUP BY `degree_id`; 



-- JOIN


-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT S.`name`, `S`.`surname` FROM `students` AS S JOIN `degrees` AS D ON `S`.`degree_id` = D.`id` WHERE D.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT * FROM `degrees` AS DEG JOIN `departments` AS DEP ON `DEG`.`department_id` = DEP.`id` WHERE DEP.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT * FROM `courses` AS C JOIN `course_teacher` AS CT ON `CT`.`course_id` = C.`id` JOIN `teachers` AS T ON T.`id` = `CT`.`teacher_id` WHERE T.`name` = 'Fulvio' AND `T`.`surname` = 'Amato';

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `S`.`name`, `S`.`surname`,`D`.`name` AS 'Corso Laurea', `departments`.`name` AS 'Dipartimento' FROM `students` AS S JOIN `degrees` AS D ON `S`.`degree_id` = `D`.`id` JOIN `departments` ON `D`.`department_id` = `departments`.`id` ORDER BY `S`.`surname`, `S`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT D.`name` AS 'nome corso di laurea', C.`name` AS 'nome corso', C.`year` AS 'anno del corso', C.`cfu` AS 'crediti del corso', T.`name` AS 'nome insegnante', T.`surname` AS 'cognome insegnante' FROM `course_teacher` AS CT JOIN `teachers` AS T ON CT.`teacher_id` = T.`id` JOIN `courses` AS C ON CT.`course_id` = C.`id` JOIN `degrees` AS D ON C.`degree_id` = D.`id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT DISTINCT T.`id`, T.`surname` AS 'cognome professore', T.`name` AS 'nome professore', DEP.`name` AS 'nome dipartimento' FROM `course_teacher` AS CT JOIN `teachers` AS T ON CT.`teacher_id` = T.`id` JOIN `courses` AS C ON CT.`course_id` = C.`id` JOIN `degrees` AS DEG ON C.`degree_id` = DEG.`id` JOIN `departments` AS DEP ON DEG.`department_id` = DEP.`id` WHERE DEP.`name` = 'Dipartimento di Matematica' ORDER BY T.`surname`, T.`name`;