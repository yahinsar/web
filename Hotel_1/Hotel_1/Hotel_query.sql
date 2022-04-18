CREATE TABLE [room] (
  [id] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [room_empty] nvarchar(30) NOT NULL,
  [number_of_places] int NOT NULL,
  [classID] int NOT NULL
)
GO

CREATE TABLE [class] (
  [id] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [name] nvarchar(30) NOT NULL,
  [cost] money NOT NULL
)
GO

ALTER TABLE [room] ADD FOREIGN KEY ([classID]) REFERENCES [class] ([id])
GO

INSERT class
   (name, cost)  
VALUES  
   ('������', 2000.00),
   ('������', 5000.00),
   ('����', 8000.00);

INSERT room
   (room_empty, number_of_places, classID)  
VALUES  
   ('��������', 1, 1),
   ('������', 2, 1),
   ('������', 2, 1),
   ('������', 1, 2),
   ('��������', 2, 2),
   ('��������', 2, 3);
  
  SELECT * FROM class
  SELECT * FROM room

  --        ������� ������ ��������� ������ (�����, �����), ��������������� �� ��������� ������.
  SELECT room.id, class.name, class.cost FROM class, room WHERE room.room_empty = '��������' AND room.classID = class.id ORDER BY class.cost;

--         ���������� ���������� ������� �����.
  SELECT SUM(class.cost) AS '������� �� �������' FROM class, room WHERE room.room_empty = '������' AND room.classID = class.id;

--        ���������� ������������� ����� (��������� ����� ������� � ������ ����� ������).
  SELECT CAST(SUM(case room.room_empty when '������' then 1 else 0 end) AS float)/COUNT(room.id) AS '������������� �����' FROM room;
  
--        ������� ����: {�����, ����� ����� ������}

SELECT class.name AS '�����', COUNT(room.id) AS '����� ���������� ������' FROM class, room WHERE room.classID = class.id GROUP BY class.name ORDER BY COUNT(room.id)

--       ������� ����� ������� ��������� �������, �������� ��� �������.
SELECT TOP (1) room.id FROM room, class WHERE room.classID = class.id AND room.room_empty = '��������' AND class.cost = (SELECT MAX(class.cost) FROM class)

SELECT * FROM room
--         ����� ����� ������� � ������� �� �������� ������� � ���������� � � ��������.

SELECT TOP (1) room.id, CAST(class.cost AS float)/room.number_of_places AS s FROM class, room WHERE room.classID = class.id ORDER BY s

SELECT * FROM room
--       ����� ����� ������� ������������ ����� (��������� ����� ������� ������ � ������ ����� ������ � ������) � �������� � ����� ����� ������� ����� ������.

  SELECT TOP (1) class.id, CAST(SUM(case room.room_empty when '������' then 1 else 0 end) AS float)/COUNT(room.id) AS w FROM room, class WHERE room.classID = class.id GROUP BY class.name, class.id ORDER BY w DESC;
