-- SQL_TEST_001
-- ��ü �౸�� ���. �̸� ��������

-- �� : 
SELECT TEAM_NAME "��ü �౸�� ���"
FROM TEAM
ORDER BY TEAM_NAME
;

-- SQL_TEST_002
-- ������ ����(�ߺ�����,������ �����)

-- �� : 
SELECT DISTINCT POSITION "������ ����"
FROM PLAYER;


-- SQL_TEST_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- nvl2()���

-- �� :
SELECT DISTINCT NVL2(POSITION,POSITION,'����') "������ ����" 
FROM PLAYER
;
-- SQL_TEST_004
-- ������(ID: K02)��Ű��

-- �� :
SELECT PLAYER_NAME �̸�
FROM PLAYER 
WHERE POSITION LIKE 'GK' AND TEAM_ID LIKE 'K02'
ORDER BY PLAYER_NAME 
;

-- SQL_TEST_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����

-- �� : 
SELECT 
    POSITION ������, 
    PLAYER_NAME �̸�
FROM 
    PLAYER  
--(SELECT TEAM_ID
--FROM PLAYER 
--WHERE TEAM_ID LIKE 'K02')
WHERE PLAYER_NAME LIKE '��%' 
    AND HEIGHT >= 170 
    AND TEAM_ID LIKE 'K02' ;

-- SQL_TEST_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������

-- �� : 
SELECT 
    (PLAYER_NAME || '����') �̸�, 
    NVL2(HEIGHT,HEIGHT || 'cm','0cm')Ű ,
    NVL2(WEIGHT,WEIGHT || 'kg','0kg')������
FROM PLAYER 
WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC;


-- SQL_TEST_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������

-- �� :
SELECT 
    (PLAYER_NAME || '����') �̸�, 
    NVL2(HEIGHT,HEIGHT || 'cm','0cm')Ű ,
    NVL2(WEIGHT,WEIGHT || 'kg','0kg')������,
    ROUND((WEIGHT/(HEIGHT*HEIGHT*0.0001)),2)"BMI ����"
FROM (SELECT PLAYER_NAME,HEIGHT,WEIGHT
    FROM PLAYER
    WHERE TEAM_ID LIKE 'K02')
ORDER BY HEIGHT DESC;

-- SQL_TEST_008
-- ������(ID: K02) �� ������(ID: K10)������ �� 
--  �������� GK ��  ����
-- ����, ����� ��������

-- NATURAL JOIN ��� (��) (�����)
SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME
FROM PLAYER P , TEAM T
WHERE P.TEAM_ID = T.TEAM_ID AND 'GK' AND P.TEAM_ID IN('K02','K10')
ORDER BY TEAM_NAME ,PLAYER_NAME ASC
;
--------------------------------------------------------
-- INNER JOIN ��� (��)
SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID = P.TEAM_ID
    --(SELECT T.TEAM_NAME, P.POSITION, P.PLAYER_NAME FROM TEAM WHERE TEAM_ID LIKE IN('K02','K10'))
WHERE P.POSITION LIKE 'GK' AND P.TEAM_ID IN('K02','K10')
ORDER BY TEAM_NAME ,PLAYER_NAME ASC
;

-- SQL_TEST_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������

-- �� :
SELECT TEAM_NAME ����, PLAYER_NAME �̸�, HEIGHT Ű 
FROM (SELECT T.TEAM_ID, T.TEAM_NAME FROM TEAM T WHERE TEAM_ID IN('K02','K10')) A
    JOIN PLAYER P
        ON P.TEAM_ID LIKE A.TEAM_ID
WHERE HEIGHT BETWEEN 180 AND 183
ORDER BY HEIGHT,TEAM_NAME,PLAYER_NAME;

-- SOCCER_SQL_010
-- ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������

-- �� : 
SELECT TEAM_NAME, PLAYER_NAME
FROM (SELECT P.TEAM_ID, P.PLAYER_NAME FROM PLAYER P WHERE POSITION IS NULL) P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY TEAM_NAME, PLAYER_NAME;

-- SOCCER_SQL_011
-- ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���

-- �� :
SELECT TEAM_NAME , STADIUM_NAME
FROM TEAM T
    JOIN STADIUM S
    ON S.STADIUM_ID LIKE T.STADIUM_ID
;

-- SOCCER_SQL_012
-- ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�.

-- �� :
SELECT TEAM_NAME Ȩ��,SCHE_DATE ��¥ , STADIUM_NAME �����, AWAYTEAM_ID ������
FROM  STADIUM S
    JOIN TEAM T
    ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN SCHEDULE C
    ON S.STADIUM_ID LIKE C.STADIUM_ID
WHERE SCHE_DATE LIKE '20120317'
ORDER BY TEAM_NAME
;

-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

-- �� :
SELECT PLAYER_NAME �̸�, POSITION ������, REGION_NAME||TEAM_NAME ����,STADIUM_NAME �����,SCHE_DATE ��⳯¥
FROM TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN STADIUM S
    ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE C
    ON S.STADIUM_ID LIKE C.STADIUM_ID
WHERE POSITION LIKE 'GK'     
    AND SCHE_DATE LIKE '20120317'
    AND REGION_NAME LIKE '����'
ORDER BY TEAM_NAME
;


-- ���� 
SELECT
   P.PLAYER_NAME ����,
   P.POSITION ������,
   T.REGION_NAME||' '||T.TEAM_NAME ����,
   S.STADIUM_NAME ��Ÿ���,
   SCH.SCHE_DATE ��⳯¥
FROM TEAM T
   JOIN STADIUM S
       ON T.STADIUM_ID LIKE S.STADIUM_ID
   JOIN SCHEDULE SCH
       ON S.STADIUM_ID LIKE SCH.STADIUM_ID
   JOIN PLAYER P
       ON T.TEAM_ID LIKE P.TEAM_ID
WHERE SCHE_DATE LIKE '20120317'
   AND T.TEAM_NAME LIKE '��ƿ����'
   AND T.REGION_NAME LIKE '����'
   AND P.POSITION LIKE 'GK'
ORDER BY P.PLAYER_NAME;

-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�

-- �� : 
SELECT S.STADIUM_NAME "����� �̸�",SC.SCHE_DATE "��� ����" ,T.TEAM_NAME "Ȩ", SC.AWAYTEAM_ID "�����",SC.HOME_SCORE "Ȩ�� ����", SC.AWAY_SCORE"������� ����"
FROM TEAM T
    JOIN STADIUM S
    ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE SC
    ON SC.STADIUM_ID LIKE T.STADIUM_ID
WHERE SC.HOME_SCORE - SC.AWAY_SCORE >= 3
ORDER BY SCHE_DATE;

SELECT *
FROM TEAM;


--STADIUM S
   -- JOIN TEAM T 
   -- ON S.STADIUM_ID LIKE T.STADIUM_ID
   -- JOIN SCHEDULE SC
   -- ON SC.STADIUM_ID LIKE S.STADIUM_ID