DROP TABLE users;
DROP TABLE questions;
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE question_likes;

CREATE TABLE users (
  id INTEGER primary key autoincrement NOT NULL,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL
);

CREATE TABLE questions (
  id INTEGER primary key autoincrement NOT NULL,
  title VARCHAR(50) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL references users(id)
);

CREATE TABLE question_follows (
  id INTEGER primary key autoincrement NOT NULL,
  user_id INTEGER NOT NULL references users(id),
  question_id INTEGER NOT NULL references questions(id)
);

CREATE TABLE replies (
  id INTEGER primary key autoincrement NOT NULL,
  question_id INTEGER NOT NULL references questions(id),
  parent_id INTEGER references replies(id),
  user_id INTEGER NOT NULL references users(id),
  body TEXT NOT NULL
);

CREATE TABLE question_likes (
  id INTEGER primary key autoincrement NOT NULL,
  question_id INTEGER NOT NULL references questions(id),
  user_id INTEGER NOT NULL references uesrs(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Charles', 'Francis'),
  ('Karen', 'Ling'),
  ('Ned', 'Ruggeri');


INSERT INTO
  questions(title, body, user_id)
VALUES
  ('This is the first question', 'This is the body of the 1st question', 2),
  ('App Academy', 'How did you find out about App Academy', 1),
  ('Favorite Water', 'What is your favorite water?', 2);

INSERT INTO
  question_follows(user_id, question_id)
VALUES
  (2, 2), (1, 1);

INSERT INTO
  replies(question_id, parent_id, user_id, body)
VALUES
  (2, NULL, 2, 'The internet!'),
  (2, 1, 1, 'Thats awesome!');

INSERT INTO
  question_likes(question_id, user_id)
VALUES
  (1, 1), (1, 3), (2, 1), (1, 2);
