
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

-- 공통코드
CREATE TABLE cm_cd
(
	-- 코드
	cd varchar2(20) NOT NULL,
	-- 코드명
	cd_name varchar2(100) NOT NULL,
	-- 그룹코드
	grp_cd varchar2(20) NOT NULL,
	PRIMARY KEY (cd)
);


-- 부서
CREATE TABLE cm_department
(
	-- 부서코드 : 'SOL' 솔루션사업부, 'EVM' 환경사업부, 'BA1' BA1, 'BA2' BA2
	dept_cd char(3) NOT NULL,
	-- 부서명
	dept_name varchar2(50),
	-- 상위부서코드 : 'SOL' 솔루션사업부, 'EVM' 환경사업부, 'BA1' BA1, 'BA2' BA2
	upper_dept_cd char(3),
	PRIMARY KEY (dept_cd)
);


-- 그룹코드
CREATE TABLE cm_grp_cd
(
	-- 그룹코드
	grp_cd varchar2(20) NOT NULL,
	-- 그릅코드명
	grp_name varchar2(100) NOT NULL,
	PRIMARY KEY (grp_cd)
);


-- 직급
CREATE TABLE cm_job_grade
(
	-- 직급ID : '01' 사원, '02' 대리, '03' 과장, '04' 차장, '05' 부장, '06' 이사
	jgrade_id char(2) NOT NULL,
	-- 직급명
	jgrade_name varchar2(20) NOT NULL,
	PRIMARY KEY (jgrade_id)
);


-- 사용자
CREATE TABLE cm_user
(
	-- 사용자번호
	user_no number NOT NULL,
	-- 사용자이름
	user_name varchar2(50) NOT NULL,
	-- 입사일
	hired_date char(10) NOT NULL,
	-- 부서코드 : 'SOL' 솔루션사업부, 'EVM' 환경사업부, 'BA1' BA1, 'BA2' BA2
	dept_cd char(3) NOT NULL,
	-- 직급ID : '01' 사원, '02' 대리, '03' 과장, '04' 차장, '05' 부장, '06' 이사
	jgrade_id char(2) NOT NULL,
	PRIMARY KEY (user_no)
);


-- 용어정의
CREATE TABLE wd_definition
(
	-- 용어정의번호
	def_no number NOT NULL,
	-- 한글명
	ko_name varchar2(200) NOT NULL,
	-- 영문명
	en_name varchar2(200) NOT NULL,
	-- 약어
	acronym varchar2(100) NOT NULL,
	-- 설명
	description varchar2(1000) NOT NULL,
	-- 코드
	cd varchar2(20) NOT NULL,
	PRIMARY KEY (def_no)
);


-- 단어사전
CREATE TABLE wd_dictionary
(
	-- 사전번호
	dic_no number NOT NULL,
	-- 논리명
	logical_name varchar2(100) NOT NULL,
	-- 물리명
	physical_name varchar2(100) NOT NULL,
	-- 데이터타입
	data_type varchar2(20),
	-- 길이
	length number(7,0),
	-- 용어정의번호
	def_no number NOT NULL,
	PRIMARY KEY (dic_no)
);


-- 프로젝트단어사전map
CREATE TABLE wd_prj_dic
(
	-- 프로젝트번호
	prj_no number NOT NULL,
	-- 사전번호
	dic_no number NOT NULL,
	PRIMARY KEY (prj_no, dic_no)
);


-- 프로젝트
CREATE TABLE wd_project
(
	-- 프로젝트번호
	prj_no number NOT NULL,
	-- 프로젝트명
	prj_name varchar2(100) NOT NULL,
	-- 프로젝트시작일
	prj_sdate char(10),
	-- 프로젝트종료일
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

COMMENT ON TABLE cm_cd IS '공통코드';
COMMENT ON COLUMN cm_cd.cd IS '코드';
COMMENT ON COLUMN cm_cd.cd_name IS '코드명';
COMMENT ON COLUMN cm_cd.grp_cd IS '그룹코드';
COMMENT ON TABLE cm_department IS '부서';
COMMENT ON COLUMN cm_department.dept_cd IS '부서코드 : ''SOL'' 솔루션사업부, ''EVM'' 환경사업부, ''BA1'' BA1, ''BA2'' BA2';
COMMENT ON COLUMN cm_department.dept_name IS '부서명';
COMMENT ON COLUMN cm_department.upper_dept_cd IS '상위부서코드 : ''SOL'' 솔루션사업부, ''EVM'' 환경사업부, ''BA1'' BA1, ''BA2'' BA2';
COMMENT ON TABLE cm_grp_cd IS '그룹코드';
COMMENT ON COLUMN cm_grp_cd.grp_cd IS '그룹코드';
COMMENT ON COLUMN cm_grp_cd.grp_name IS '그릅코드명';
COMMENT ON TABLE cm_job_grade IS '직급';
COMMENT ON COLUMN cm_job_grade.jgrade_id IS '직급ID : ''01'' 사원, ''02'' 대리, ''03'' 과장, ''04'' 차장, ''05'' 부장, ''06'' 이사';
COMMENT ON COLUMN cm_job_grade.jgrade_name IS '직급명';
COMMENT ON TABLE cm_user IS '사용자';
COMMENT ON COLUMN cm_user.user_no IS '사용자번호';
COMMENT ON COLUMN cm_user.user_name IS '사용자이름';
COMMENT ON COLUMN cm_user.hired_date IS '입사일';
COMMENT ON COLUMN cm_user.dept_cd IS '부서코드 : ''SOL'' 솔루션사업부, ''EVM'' 환경사업부, ''BA1'' BA1, ''BA2'' BA2';
COMMENT ON COLUMN cm_user.jgrade_id IS '직급ID : ''01'' 사원, ''02'' 대리, ''03'' 과장, ''04'' 차장, ''05'' 부장, ''06'' 이사';
COMMENT ON TABLE wd_definition IS '용어정의';
COMMENT ON COLUMN wd_definition.def_no IS '용어정의번호';
COMMENT ON COLUMN wd_definition.ko_name IS '한글명';
COMMENT ON COLUMN wd_definition.en_name IS '영문명';
COMMENT ON COLUMN wd_definition.acronym IS '약어';
COMMENT ON COLUMN wd_definition.description IS '설명';
COMMENT ON COLUMN wd_definition.cd IS '코드';
COMMENT ON TABLE wd_dictionary IS '단어사전';
COMMENT ON COLUMN wd_dictionary.dic_no IS '사전번호';
COMMENT ON COLUMN wd_dictionary.logical_name IS '논리명';
COMMENT ON COLUMN wd_dictionary.physical_name IS '물리명';
COMMENT ON COLUMN wd_dictionary.data_type IS '데이터타입';
COMMENT ON COLUMN wd_dictionary.length IS '길이';
COMMENT ON COLUMN wd_dictionary.def_no IS '용어정의번호';
COMMENT ON TABLE wd_prj_dic IS '프로젝트단어사전map';
COMMENT ON COLUMN wd_prj_dic.prj_no IS '프로젝트번호';
COMMENT ON COLUMN wd_prj_dic.dic_no IS '사전번호';
COMMENT ON TABLE wd_project IS '프로젝트';
COMMENT ON COLUMN wd_project.prj_no IS '프로젝트번호';
COMMENT ON COLUMN wd_project.prj_name IS '프로젝트명';
COMMENT ON COLUMN wd_project.prj_sdate IS '프로젝트시작일';
COMMENT ON COLUMN wd_project.prj_edate IS '프로젝트종료일';



