INSERT INTO trainer (trainer_id, pay_id, trainer_first_name, trainer_last_name)
VALUES
(1, 101, 'John', 'Doe'),
(2, 102, 'Jane', 'Smith'),
(3, 103, 'Mike', 'Johnson'),
(4, 104, 'David', 'Lee'),
(5, 105, 'Sarah', 'Taylor'),
(6, 106, 'Amy', 'Chen'),
(7, 107, 'Kevin', 'Wong'),
(8, 108, 'Karen', 'Ng'),
(9, 109, 'Peter', 'Chang'),
(10, 110, 'Cathy', 'Liu');

CREATE TABLE gym ( gym_id NUMBER PRIMARY KEY, gym_name VARCHAR2(50) NOT NULL,  addresss varchar2(100), type varchar2(78));
CREATE TABLE login (Id INT PRIMARY KEY,uname VARCHAR(50),pwd VARCHAR(50));

CREATE TABLE trainer (trainer_id INT PRIMARY KEY,pay_id INT, trainer_first_name VARCHAR(50), trainer_last_name VARCHAR(50), FOREIGN KEY (pay_id) REFERENCES payment(pay_id));

CREATE TABLE member (mem_id INT PRIMARY KEY,dob DATE,age INT,pay_id INT,trainer_id INT,mem_first_name VARCHAR(50),mem_last_name VARCHAR(50),FOREIGN KEY (pay_id) REFERENCES payment(pay_id),FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id));

CREATE TABLE gym (gym_id INT PRIMARY KEY,gym_name VARCHAR(50),pin_code VARCHAR(10),street_name VARCHAR(50),street_no INT,landmark VARCHAR(50));

CREATE TABLE workout (workout_id INT PRIMARY KEY,workout_name VARCHAR(50),description VARCHAR(255));

CREATE TABLE payment (pay_id INT PRIMARY KEY,amount DECIMAL(10,2),gym_id INT,FOREIGN KEY (gym_id) REFERENCES gym(gym_id);

CREATE TABLE workout_plan (workout_id INT,workout_schedule VARCHAR(50),workout_repetition INT,PRIMARY KEY (workout_id, workout_schedule),
  FOREIGN KEY (workout_id) REFERENCES workout(workout_id));

CREATE TABLE enrolls_to (mem_id INT,workout_id INT,dat DATE,PRIMARY KEY (mem_id, workout_id),FOREIGN KEY (mem_id) REFERENCEmember(mem_id),
  FOREIGN KEY (workout_id) REFERENCES workout(workout_id));

CREATE TABLE instructs (trainer_id INT,workout_id INT,PRIMARY KEY (trainer_id, workout_id),FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id),FOREIGN KEY (workout_id) REFERENCES workout(workout_id));

CREATE TABLE mem_mobile_no (
  mobile_no VARCHAR(20),
  mem_id INT,
  PRIMARY KEY (mobile_no),
  FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

CREATE TABLE trainer_mobile_no (
  mobile_no VARCHAR(20),
  trainer_id INT,
  PRIMARY KEY (mobile_no),
  FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
);

CREATE TABLE trainer_time (
  trainer_id INT,
  time TIME,
  PRIMARY KEY (trainer_id, time),
  FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
);

CREATE TABLE gym_type (
  gym_id INT,
  type VARCHAR(50),
  PRIMARY KEY (gym_id, type),
  FOREIGN KEY (gym_id) REFERENCES gym(gym_id)
);
SELECT m.mem_id, m.mem_first_name, m.mem_last_name, m.trainer_id, t.trainer_first_name, t.trainer_last_name FROM member m LEFT JOIN trainer t ON m.trainer_id = t.trainer_id; 

SELECT g.gym_id, g.gym_name, SUM(p.amount) AS total_paid FROM gym g LEFT JOIN payment p ON g.gym_id = p.gym_id GROUP BY g.gym_id, g.gym_name;

SELECT m.mem_id, m.mem_first_name, m.mem_last_name, mm.mobile_no FROM member m LEFT JOIN mem_mobile_no mm ON m.mem_id = mm.mem_id;

SELECT t.trainer_id, t.trainer_first_name, t.trainer_last_name, w.workout_name FROM trainer t LEFT JOIN instructs i ON t.trainer_id = i.trainer_id LEFT JOIN workout w ON i.workout_id = w.workout_id; 

SELECT g.gym_id, g.gym_name, g.gym_type, COUNT(t.trainer_id) AS num_trainers FROM gym g LEFT JOIN trainer t ON g.gym_id = t.pay_id GROUP BY g.gym_id, g.gym_name, g.gym_type; 

SELECT p.pay_id, g.gym_name, g.gym_type, p.amount FROM payment p LEFT JOIN gym g ON p.gym_id = g.gym_id;SELECT m.mem_id, m.mem_first_name, m.mem_last_name FROM member m LEFT JOIN enrolls_to e ON m.mem_id = e.mem_id WHERE e.date IS NULL; 

SELECT t.trainer_id, t.trainer_first_name, t.trainer_last_name, GROUP_CONCAT(tt.time) AS timeslots FROM trainer t LEFT JOIN trainer_time tt ON t.trainer_id = tt.trainer_id GROUP BY t.trainer_id, t.trainer_first_name, t.trainer_last_name;