
/* Drop Tables */

DROP TABLE cm_cd CASCADE CONSTRAINTS;
DROP TABLE cm_user CASCADE CONSTRAINTS;
DROP TABLE cm_department CASCADE CONSTRAINTS;
DROP TABLE cm_grp_cd CASCADE CONSTRAINTS;
DROP TABLE cm_job_grade CASCADE CONSTRAINTS;
DROP TABLE wd_prj_dic CASCADE CONSTRAINTS;
DROP TABLE wd_dictionary CASCADE CONSTRAINTS;
DROP TABLE wd_definition CASCADE CONSTRAINTS;
DROP TABLE wd_project CASCADE CONSTRAINTS;




/* Create Tables */

-- �����ڵ�
CREATE TABLE cm_cd
(
	-- �ڵ�
	cd varchar2(20) NOT NULL,
	-- �ڵ��
	cd_name varchar2(100) NOT NULL,
	-- �׷��ڵ�
	grp_cd varchar2(20) NOT NULL,
	PRIMARY KEY (cd)
);


-- �μ�
CREATE TABLE cm_department
(
	-- �μ��ڵ� : 'SOL' �ַ�ǻ����, 'EVM' ȯ������, 'BA1' BA1, 'BA2' BA2
	dept_cd char(3) NOT NULL,
	-- �μ���
	dept_name varchar2(50),
	-- �����μ��ڵ� : 'SOL' �ַ�ǻ����, 'EVM' ȯ������, 'BA1' BA1, 'BA2' BA2
	upper_dept_cd char(3),
	PRIMARY KEY (dept_cd)
);


-- �׷��ڵ�
CREATE TABLE cm_grp_cd
(
	-- �׷��ڵ�
	grp_cd varchar2(20) NOT NULL,
	-- �׸��ڵ��
	grp_name varchar2(100) NOT NULL,
	PRIMARY KEY (grp_cd)
);


-- ����
CREATE TABLE cm_job_grade
(
	-- ����ID : '01' ���, '02' �븮, '03' ����, '04' ����, '05' ����, '06' �̻�
	jgrade_id char(2) NOT NULL,
	-- ���޸�
	jgrade_name varchar2(20) NOT NULL,
	PRIMARY KEY (jgrade_id)
);


-- �����
CREATE TABLE cm_user
(
	-- ����ڹ�ȣ
	user_no number NOT NULL,
	-- ������̸�
	user_name varchar2(50) NOT NULL,
	-- �Ի���
	hired_date char(10) NOT NULL,
	-- �μ��ڵ� : 'SOL' �ַ�ǻ����, 'EVM' ȯ������, 'BA1' BA1, 'BA2' BA2
	dept_cd char(3) NOT NULL,
	-- ����ID : '01' ���, '02' �븮, '03' ����, '04' ����, '05' ����, '06' �̻�
	jgrade_id char(2) NOT NULL,
	PRIMARY KEY (user_no)
);


-- �������
CREATE TABLE wd_definition
(
	-- ������ǹ�ȣ
	def_no number NOT NULL,
	-- �ѱ۸�
	ko_name varchar2(200) NOT NULL,
	-- ������
	en_name varchar2(200) NOT NULL,
	-- ���
	acronym varchar2(100) NOT NULL,
	-- ����
	description varchar2(1000) NOT NULL,
	-- �ڵ�
	cd varchar2(20) NOT NULL,
	PRIMARY KEY (def_no)
);


-- �ܾ����
CREATE TABLE wd_dictionary
(
	-- ������ȣ
	dic_no number NOT NULL,
	-- ����
	logical_name varchar2(100) NOT NULL,
	-- ������
	physical_name varchar2(100) NOT NULL,
	-- ������Ÿ��
	data_type varchar2(20),
	-- ����
	length number(7,0),
	-- ������ǹ�ȣ
	def_no number NOT NULL,
	PRIMARY KEY (dic_no)
);


-- ������Ʈ�ܾ����map
CREATE TABLE wd_prj_dic
(
	-- ������Ʈ��ȣ
	prj_no number NOT NULL,
	-- ������ȣ
	dic_no number NOT NULL,
	PRIMARY KEY (prj_no, dic_no)
);


-- ������Ʈ
CREATE TABLE wd_project
(
	-- ������Ʈ��ȣ
	prj_no number NOT NULL,
	-- ������Ʈ��
	prj_name varchar2(100) NOT NULL,
	-- ������Ʈ������
	prj_sdate char(10),
	-- ������Ʈ������
	prj_edate char(10),
	PRIMARY KEY (prj_no)
);



/* Create Foreign Keys */

ALTER TABLE cm_department
	ADD FOREIGN KEY (upper_dept_cd)
	REFERENCES cm_department (dept_cd)
;


ALTER TABLE cm_user
	ADD FOREIGN KEY (dept_cd)
	REFERENCES cm_department (dept_cd)
;


ALTER TABLE cm_cd
	ADD FOREIGN KEY (grp_cd)
	REFERENCES cm_grp_cd (grp_cd)
;


ALTER TABLE cm_user
	ADD FOREIGN KEY (jgrade_id)
	REFERENCES cm_job_grade (jgrade_id)
;


ALTER TABLE wd_dictionary
	ADD FOREIGN KEY (def_no)
	REFERENCES wd_definition (def_no)
;


ALTER TABLE wd_prj_dic
	ADD FOREIGN KEY (dic_no)
	REFERENCES wd_dictionary (dic_no)
;


ALTER TABLE wd_prj_dic
	ADD FOREIGN KEY (prj_no)
	REFERENCES wd_project (prj_no)
;



/* Comments */

COMMENT ON TABLE cm_cd IS '�����ڵ�';
COMMENT ON COLUMN cm_cd.cd IS '�ڵ�';
COMMENT ON COLUMN cm_cd.cd_name IS '�ڵ��';
COMMENT ON COLUMN cm_cd.grp_cd IS '�׷��ڵ�';
COMMENT ON TABLE cm_department IS '�μ�';
COMMENT ON COLUMN cm_department.dept_cd IS '�μ��ڵ� : ''SOL'' �ַ�ǻ����, ''EVM'' ȯ������, ''BA1'' BA1, ''BA2'' BA2';
COMMENT ON COLUMN cm_department.dept_name IS '�μ���';
COMMENT ON COLUMN cm_department.upper_dept_cd IS '�����μ��ڵ� : ''SOL'' �ַ�ǻ����, ''EVM'' ȯ������, ''BA1'' BA1, ''BA2'' BA2';
COMMENT ON TABLE cm_grp_cd IS '�׷��ڵ�';
COMMENT ON COLUMN cm_grp_cd.grp_cd IS '�׷��ڵ�';
COMMENT ON COLUMN cm_grp_cd.grp_name IS '�׸��ڵ��';
COMMENT ON TABLE cm_job_grade IS '����';
COMMENT ON COLUMN cm_job_grade.jgrade_id IS '����ID : ''01'' ���, ''02'' �븮, ''03'' ����, ''04'' ����, ''05'' ����, ''06'' �̻�';
COMMENT ON COLUMN cm_job_grade.jgrade_name IS '���޸�';
COMMENT ON TABLE cm_user IS '�����';
COMMENT ON COLUMN cm_user.user_no IS '����ڹ�ȣ';
COMMENT ON COLUMN cm_user.user_name IS '������̸�';
COMMENT ON COLUMN cm_user.hired_date IS '�Ի���';
COMMENT ON COLUMN cm_user.dept_cd IS '�μ��ڵ� : ''SOL'' �ַ�ǻ����, ''EVM'' ȯ������, ''BA1'' BA1, ''BA2'' BA2';
COMMENT ON COLUMN cm_user.jgrade_id IS '����ID : ''01'' ���, ''02'' �븮, ''03'' ����, ''04'' ����, ''05'' ����, ''06'' �̻�';
COMMENT ON TABLE wd_definition IS '�������';
COMMENT ON COLUMN wd_definition.def_no IS '������ǹ�ȣ';
COMMENT ON COLUMN wd_definition.ko_name IS '�ѱ۸�';
COMMENT ON COLUMN wd_definition.en_name IS '������';
COMMENT ON COLUMN wd_definition.acronym IS '���';
COMMENT ON COLUMN wd_definition.description IS '����';
COMMENT ON COLUMN wd_definition.cd IS '�ڵ�';
COMMENT ON TABLE wd_dictionary IS '�ܾ����';
COMMENT ON COLUMN wd_dictionary.dic_no IS '������ȣ';
COMMENT ON COLUMN wd_dictionary.logical_name IS '����';
COMMENT ON COLUMN wd_dictionary.physical_name IS '������';
COMMENT ON COLUMN wd_dictionary.data_type IS '������Ÿ��';
COMMENT ON COLUMN wd_dictionary.length IS '����';
COMMENT ON COLUMN wd_dictionary.def_no IS '������ǹ�ȣ';
COMMENT ON TABLE wd_prj_dic IS '������Ʈ�ܾ����map';
COMMENT ON COLUMN wd_prj_dic.prj_no IS '������Ʈ��ȣ';
COMMENT ON COLUMN wd_prj_dic.dic_no IS '������ȣ';
COMMENT ON TABLE wd_project IS '������Ʈ';
COMMENT ON COLUMN wd_project.prj_no IS '������Ʈ��ȣ';
COMMENT ON COLUMN wd_project.prj_name IS '������Ʈ��';
COMMENT ON COLUMN wd_project.prj_sdate IS '������Ʈ������';
COMMENT ON COLUMN wd_project.prj_edate IS '������Ʈ������';



