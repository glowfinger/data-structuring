CREATE TABLE data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    status VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    phone VARCHAR(100),
    instagram VARCHAR(100),
    twitter VARCHAR(100),
    facebook VARCHAR(100),
    snapchat VARCHAR(100)
);


CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL
);

CREATE TABLE user_bio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE user_dob (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    dob DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE user_contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    method VARCHAR(100) NOT NULL,
    info VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE INDEX idx_user_email
ON user (email);

CREATE INDEX idx_user_type
ON user (type);

CREATE INDEX idx_user_status_type
ON user (status, type);

CREATE INDEX idx_user_dob_dob
ON user_dob (dob);

CREATE INDEX idx_bio_region
ON user_bio (region);

CREATE INDEX idx_user_contact_method
ON user_contact (method);

INSERT INTO user (id, email, status, type)
SELECT id, email, status, type 
FROM data;

INSERT INTO user_bio (user_id, first_name, last_name, region)
SELECT id, first_name, last_name, region
FROM data;

INSERT INTO user_dob (user_id, dob )
SELECT id, dob
FROM data;

INSERT INTO user_contact (user_id, method, info) 
SELECT id, 'phone', phone
FROM data
WHERE phone IS NOT NULL
UNION
SELECT id, 'instagram', instagram
FROM data
WHERE instagram IS NOT NULL
UNION
SELECT id, 'twitter', twitter
FROM data
WHERE twitter IS NOT NULL
UNION
SELECT id, 'facebook', facebook
FROM data
WHERE facebook IS NOT NULL
UNION
SELECT id, 'snapchat', snapchat
FROM data
WHERE snapchat IS NOT NULL;


