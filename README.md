# 📚 스마트 금융 과제 모음

이 저장소는 스마트 금융 관련 다양한 과제와 프로젝트를 Python, Java 등 여러 프로그래밍 언어로 구현한 자료를 모아둔 공간입니다.  
각 과제는 폴더별로 정리되어 있으며, 소스 코드와 보고서 등 다양한 자료가 포함되어 있습니다.

## 🗂 저장소 구조

```txt
/
├── 01_Python/                  # Python 과제 폴더
│    ├── 001_trimmed_mean
│    └── 002_yearweek_shift
│    └── 003_simple_db_migration
│    └── 004_BeautifulSoup
│    └── 005_Selenium
│    └── 006_bing_image_downloader
│    └── 007_public_data_API
│    └── 008_aihub_mrc_data_cleaning
├── 02_Java/                    # Java 과제 폴더
│    └── java_catch_game
│         └── README.md 
├── .gitattributes              # 언어 통계 설정 파일
└── README.md                   
```

## 📌 과제 목록

### 🐍 Python

| 과제명 | 설명 | 수행일자 |
|---|---|---|
| [Q2절사평균](https://github.com/WoojinJeonkr/smart_finance_assignments/blob/main/01_Python/001_trimmed_mean/Q2절사평균.ipynb) | 절사평균 구하기 | 2025.03.11 |
| [연도주차 함수 작성하기](https://github.com/WoojinJeonkr/smart_finance_assignments/blob/main/01_Python/002_yearweek_shift/연도주차_함수_작성하기.ipynb) | 연도 및 주차 이동 계산 | 2025.03.19 |
| [Oracle에서 MySQL로 DB 이관하기](https://github.com/WoojinJeonkr/smart_finance_assignments/tree/main/01_Python/003_simple_db_migration/Oracle에서_MySQL로_DB_이관하기.ipynb) | Oracle DB 데이터를 MySQL DB로 이관 | 2025.03.24 |
| [BeautiftulSoup을 통한 웹 크롤링](https://github.com/WoojinJeonkr/smart_finance_assignments/tree/main/01_Python/004_BeautifulSoup/BeautiftulSoup을_통한_웹_크롤링.ipynb)  | BeautifulSoup을 이용한 위키독스 페이지 크롤링 | 2025.03.28 |
| [timeanddate South Korea holidays 웹 크롤링](https://github.com/WoojinJeonkr/smart_finance_assignments/tree/main/01_Python/004_BeautifulSoup/timeanddate_South_Korea_holidays_웹_크롤링.ipynb) | BeautifulSoup을 이용한 timeanddate south korea 휴일 웹 페이지 크롤링 | 2025.03.28 |
| [학교알리미 selenium을 활용한 웹 크롤링](https://github.com/WoojinJeonkr/smart_finance_assignments/tree/main/01_Python/005_Selenium/학교알리미_selenium을_활용한_웹_크롤링.ipynb) | Selenium을 이용한 학교 알리미 동작구 고등학교 웹 페이지 크롤링 | 2025.03.31 |
| [bing 쿼리 검색 이미지 수집](https://github.com/WoojinJeonkr/smart_finance_assignments/tree/main/01_Python/006_bing_image_downloader/bing_쿼리_검색_이미지_수집.ipynb) | bing image downloader를 통한 화난 얼굴, 행복한 얼굴 이미지 수집 및 라벨링 | 2025.04.07 |
| [아파트 매매 실거래가 공개 API를 통한 데이터 전처리](https://github.com/WoojinJeonkr/smart_finance_assignments/tree/main/01_Python/007_public_data_API/아파트_매매_실거래가_공개_API를_통한_데이터_전처리.ipynb) | 아파트 매매 실거래가 공개(상세) 공공데이터 API를 통한 데이터 수집 및 전처리 | 2025.04.07 |
| [구조동물 조회 API를 통한 데이터 전처리](https://github.com/WoojinJeonkr/smart_finance_assignments/tree/main/01_Python/007_public_data_API/구조동물_조회_API를_통한_데이터_전처리.ipynb) | 구조동물 조회 공공데이터 API를 통한 데이터 수집 및 전처리 | 2025.04.07 |
| [AI허브 행정 문서 대상 기계독해 데이터 정제](https://github.com/WoojinJeonkr/smart_finance_assignments/tree/main/01_Python/008_aihub_mrc_data_cleaning/AI허브_행정_문서_대상_기계독해_데이터_정제.ipynb) | AI허브 행정 문서 대상 기계독해 테스트 라벨링 데이터 전처리 및 허깅페이스 연동 | 2025.04.14 |

### Java

| 폴더/과제폴더명/과제명 | 언어 | 설명 |
|---|---|---|
| Java catch game v1 | Java | 상속을 사용하여 콘솔 기반 몬스터 포획 게임 작성 & 리팩토링하기 |

## 📝 사용 방법

### 1. 저장소 클론하기

```bash
git clone https://github.com/WoojinJeonkr/smart_finance_assignments.git
```

### 2. 원하는 과제 폴더로 이동

```bash
cd 01_python/001_trimmed_mean
```

### 3. 각 과제 폴더의 README.md에서 상세 설명 확인

### 4. 코드 실행

- Jupyter Notebook: JupyterLab 또는 Jupyter Notebook에서 열기

## ⚙️ 필요 환경

- Java (Java 과제)
- Jupyter Notebook 또는 google colab (.ipynb 파일 실행용)
- 각 과제 폴더의 README.md에서 추가 의존성 확인

## 🗒️ 참고 사항

- .gitattributes 파일을 통해 01_python 폴더 내 Jupyter Notebook 파일이 GitHub 언어 통계에서 Python 코드로 인식되도록 설정되어 있습니다.
