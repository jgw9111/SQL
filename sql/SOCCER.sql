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
SELECT T.TEAM_NAME Ȩ��,C.SCHE_DATE ��¥ , S.STADIUM_NAME �����, C.AWAYTEAM_ID ������
FROM  STADIUM S
    JOIN TEAM T
    ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT AWAYTEAM_ID, SCHE_DATE, STADIUM_ID FROM SCHEDULE WHERE SCHE_DATE LIKE '20120317')C
    ON S.STADIUM_ID LIKE C.STADIUM_ID
--WHERE SCHE_DATE LIKE '20120317'
ORDER BY TEAM_NAME
;

SELECT T.TEAM_NAME Ȩ��,
        C.SCHE_DATE ��¥ , 
        S.STADIUM_NAME �����, 
        (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE C.AWAYTEAM_ID)������
FROM  STADIUM S
    JOIN TEAM T
    ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT AWAYTEAM_ID, SCHE_DATE, STADIUM_ID FROM SCHEDULE WHERE SCHE_DATE LIKE '20120317')C
    ON S.STADIUM_ID LIKE C.STADIUM_ID
--WHERE SCHE_DATE LIKE '20120317'
ORDER BY TEAM_NAME
;

-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

-- �� :
SELECT PLAYER_NAME �̸�, POSITION ������, REGION_NAME||' '||TEAM_NAME ����,STADIUM_NAME �����,SCHE_DATE ��⳯¥
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



-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�

-- �� : 
SELECT S.STADIUM_NAME "����� �̸�",
        SC.SCHE_DATE "��� ����" ,
        (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE SC.HOMETEAM_ID) "Ȩ", 
        (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE SC.AWAYTEAM_ID) "�����",
        SC.HOME_SCORE "Ȩ�� ����", 
        SC.AWAY_SCORE "������� ����"
FROM TEAM T
    JOIN STADIUM S
    ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE SC
    ON SC.STADIUM_ID LIKE T.STADIUM_ID
WHERE SC.HOME_SCORE - SC.AWAY_SCORE >= 3
    OR SC.AWAYTEAM_ID LIKE T.TEAM_NAME
ORDER BY SCHE_DATE;

--
SELECT S.STADIUM_ID "����� �̸�",
       C.SCHE_DATE "��� ����",
       (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE C.HOMETEAM_ID) "Ȩ�� �̸�",
       (SELECT T.TEAM_NAME FROM TEAM T WHERE T.TEAM_ID LIKE C.AWAYTEAM_ID) "������ �̸�", 
       C.HOME_SCORE "Ȩ�� ����", 
       C.AWAY_SCORE "������� ����"
FROM STADIUM S
    JOIN TEAM T
    ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT C.AWAY_SCORE,C.AWAYTEAM_ID,C.HOME_SCORE,C.HOMETEAM_ID,C.SCHE_DATE,C.STADIUM_ID
        FROM SCHEDULE C
        WHERE C.HOME_SCORE >= C.AWAY_SCORE + 3) C
    ON C.STADIUM_ID LIKE T.STADIUM_ID
   
;


SELECT *
FROM TEAM;


--STADIUM S
   -- JOIN TEAM T 
   -- ON S.STADIUM_ID LIKE T.STADIUM_ID
   -- JOIN SCHEDULE SC
   -- ON SC.STADIUM_ID LIKE S.STADIUM_ID
   
   
-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20

-- �� : 
SELECT S.STADIUM_NAME ,S.STADIUM_ID,S.SEAT_COUNT,HOMETEAM_ID,T.E_TEAM_NAME
FROM STADIUM S 
    LEFT JOIN TEAM T
    ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY HOMETEAM_ID
;

-- �� 2 (�ξ� ����):
SELECT S.STADIUM_NAME "��Ÿ��� �̸�",
        S.STADIUM_ID ���̵� ,
        S.SEAT_COUNT �¼��� ,
        S.HOMETEAM_ID"Ȩ�� ���̵�", 
        (SELECT T.E_TEAM_NAME FROM TEAM T WHERE T.STADIUM_ID LIKE S.STADIUM_ID) "���� �̸�"
FROM STADIUM S
; 

-- SOCCER_SQL_016
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����


-- 1�ܰ� : 
SELECT P.TEAM_ID , T.TEAM_NAME , ROUND(AVG(P.HEIGHT),2) ���Ű
FROM TEAM T
    JOIN PLAYER P
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
;


-- 2�ܰ� :
SELECT T.TEAM_ID "�� ID",T.TEAM_NAME ����,ROUND(AVG(P.HEIGHT),2) ���Ű
FROM PLAYER P
    JOIN TEAM T
        ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID,T.TEAM_NAME
HAVING ROUND(AVG(P.HEIGHT),2) < 
                                (SELECT ROUND(AVG(P.HEIGHT),2) 
                                FROM PLAYER P
                                    JOIN TEAM T
                                        ON P.TEAM_ID LIKE T.TEAM_ID
                                WHERE TEAM_NAME LIKE '������Ƽ��')
;

-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���

-- �� :

SELECT P.POSITION,T.TEAM_NAME,P.PLAYER_NAME,P.BACK_NO
FROM (SELECT P.POSITION,P.PLAYER_NAME,P.BACK_NO,P.TEAM_ID
    FROM PLAYER P 
    WHERE P.POSITION LIKE 'MF') P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY P.PLAYER_NAME
;
    
-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����

-- �� : 
SELECT P.PLAYER_NAME, P.BACK_NO, P.POSITION, P."MAX(HEIGHT)"
FROM (SELECT PLAYER_NAME, BACK_NO, POSITION, MAX(HEIGHT) 
    FROM PLAYER
    GROUP BY PLAYER_NAME, BACK_NO, POSITION, HEIGHT
    HAVING HEIGHT IS NOT NULL 
    ORDER BY HEIGHT DESC) P 
WHERE ROWNUM BETWEEN 1 AND 5 
;


-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���

-- �� :
SELECT T.TEAM_NAME, P.PLAYER_NAME, P.POSITION, P.BACK_NO, P.HEIGHT
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.HEIGHT < (SELECT AVG(P2.HEIGHT) 
                    FROM PLAYER P2
                    WHERE P2.TEAM_ID LIKE P.TEAM_ID)
;    


-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.

-- �� :

SELECT STADIUM_NAME,STADIUM_ID 
FROM STADIUM 
WHERE EXISTS 
(SELECT 1
FROM SCHEDULE 
WHERE STADIUM.STADIUM_ID LIKE SCHEDULE.STADIUM_ID
AND SCHE_DATE LIKE '201205%') ;


-- SOCCER_SQL_021
-- ���� ���� �Ҽ����� ������� ���

-- �� :
SELECT P.PLAYER_NAME,P.BACK_NO,P.POSITION 
FROM PLAYER P
    JOIN TEAM T
    ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.TEAM_ID LIKE (SELECT TEAM_ID FROM PLAYER WHERE PLAYER_NAME LIKE '����')    
ORDER BY P.PLAYER_NAME
;

------------------------------------------------------------------->

-- SOCCER_SQL_022
-- NULL ó���� �־�
-- SUM(NVL(SAL,0)) �� ��������
-- NVL(SUM(SAL),0) ���� �ؾ� �ڿ����� �پ���
 
-- ���� �����Ǻ� �ο����� ���� ��ü �ο��� ���
 
-- Oracle, Simple Case Expr 

-- �� : 
SELECT DISTINCT TEAM_ID,(SELECT COUNT(*) FROM PLAYER WHERE POSITION LIKE 'FW') FW
FROM PLAYER 
;

SELECT COUNT(*)
FROM TEAM
WHERE (SELECT POSITION FROM PLAYER WHERE POSITION LIKE 'FW')
;



-- SOCCER_SQL_023
-- GROUP BY �� ���� ��ü �������� �����Ǻ� ��� Ű �� ��ü ��� Ű ���

-- �� :

SELECT DISTINCT 
       (SELECT ROUND(AVG(HEIGHT),2) FROM PLAYER WHERE POSITION LIKE 'FW') ������,
       (SELECT ROUND(AVG(HEIGHT),2) FROM PLAYER WHERE POSITION LIKE 'MF') �̵��ʴ�,
       (SELECT ROUND(AVG(HEIGHT),2) FROM PLAYER WHERE POSITION LIKE 'DF') �����,
       (SELECT ROUND(AVG(HEIGHT),2) FROM PLAYER WHERE POSITION LIKE 'GK') ��Ű��, 
       (SELECT ROUND(AVG(HEIGHT),2) FROM PLAYER) ��ü
FROM PLAYER
;

-- SOCCER_SQL_024 
-- �Ҽ����� Ű�� ���� ���� ������� ����

-- �� : 
SELECT TEMA_NAME, PLAYER_NAME, POSITION ,PLAYER_HEIGHT
FROM PLAYER
;

