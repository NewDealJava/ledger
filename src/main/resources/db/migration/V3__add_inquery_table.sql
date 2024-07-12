create table qboard
(
    qbno     INT AUTO_INCREMENT PRIMARY KEY,
    email    VARCHAR(50),
    qtitle   VARCHAR(50),
    qcontent TEXT,
    qstatus  INT,
    qdate    DATE,
    qfile    VARCHAR(50)
);
