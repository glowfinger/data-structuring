-- counts
SELECT COUNT(*) FROM data;



-- Create a table called user_bio that contains the first_name and last_name columns from the data table.
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL
);

CREATE INDEX idx_user_email
ON user (email);

CREATE INDEX SELECT COUNT(*)
FROM user 
USE INDEX (idx_user_status, idx_user_type)
WHERE type = 'moderator'
AND status = 'inactive';
ON user (status);

CREATE INDEX idx_user_type
ON user (type);

CREATE INDEX idx_user_status_type
ON user (status, type);


INSERT INTO user (id, email, status, type)
SELECT id, email, status, type 
FROM data;

EXPLAIN SELECT * 
FROM user
WHERE email  =	'';

-- 0.062 s
-- 0.009 s with composite index
SELECT COUNT(*)
FROM user 
USE INDEX (idx_user_status, idx_user_type)
WHERE type = 'moderator'
AND status = 'inactive';


ANALYZE TABLE user;

SHOW INDEXES FROM user

ANALYZE TABLE user;

SHOW INDEX 
FROM user 
WHERE Key_name = 'idx_user_email';


SELECT COUNT(*) as count, region
FROM user_bio
GROUP BY region
ORDER BY count;

