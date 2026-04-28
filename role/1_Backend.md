# 백엔드 (Backend)

## 개요
AI_SYS의 백엔드는 REST API를 통해 프론트엔드, AI 모델, 데이터베이스를 연결하는 핵심 계층입니다.

---

## 책임사항

### 1. API 설계 및 구현
- RESTful API 엔드포인트 개발
- 요청/응답 스펙 정의
- API 문서화 (OpenAPI/Swagger)

### 2. 비즈니스 로직 개발
- 정책/판례 검색 로직
- 데이터 처리 및 변환
- 비즈니스 규칙 구현

### 3. 데이터베이스 관리
- 데이터베이스 상호작용
- 쿼리 최적화
- 트랜잭션 관리

### 4. 보안 및 인증
- 사용자 인증 처리
- 권한 검증
- 데이터 암호화 및 보호

### 5. 시스템 인프라 및 배포
- Docker 컨테이너 관리
- 배포 자동화
- 로깅 및 모니터링

---

## 기술 스택

| 항목 | 기술 |
|------|------|
| **언어** | Python 3.11+ |
| **프레임워크** | FastAPI |
| **데이터베이스** | PostgreSQL |
| **ORM** | SQLAlchemy |
| **배포** | Docker |
| **API 문서** | OpenAPI (Swagger) |

---

## 프로젝트 구조

```
code/backend/
├── Dockerfile              # Docker 이미지 정의
├── pyproject.toml         # 프로젝트 메타데이터
├── requirements.txt       # Python 패키지 의존성
├── README.md              # 백엔드 설명 문서
└── app/
    ├── __init__.py
    ├── main.py            # FastAPI 앱 진입점
    ├── database.py        # DB 연결 설정
    ├── grounding.py       # AI 모델 추론 로직
    └── schemas.py         # Pydantic 스키마 정의
```

---

## 주요 파일 설명

### `main.py`
- FastAPI 애플리케이션 초기화
- API 엔드포인트 정의
- 라우터 통합

### `database.py`
- PostgreSQL 연결 설정
- SQLAlchemy 세션 관리
- 데이터베이스 마이그레이션

### `grounding.py`
- AI 모델 기반 응답 생성
- 정보 검색 및 검증
- 프롬프트 엔지니어링

### `schemas.py`
- 요청/응답 데이터 모델
- 타입 검증
- API 문서 자동 생성

---

## 주요 기능

### 1. 정책/판례 검색
```
GET /api/search?query=keyword
```
- 사용자 입력에 따른 정책/판례 검색
- AI 모델 기반 관련성 순위 매김

### 2. 케이스 분석
```
POST /api/cases/analyze
```
- 업로드된 문서 분석
- AI 모델 활용한 자동 요약 및 분류

### 3. 권한 검증
```
POST /api/permissions/check
```
- 정책 기반 권한 검증
- 대법원 정책 확인

### 4. 사용자 관리
- 사용자 등록 및 인증
- 세션 관리
- 접근 권한 관리

---

## 개발 워크플로우

### 1. 환경 설정
```bash
cd code/backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### 2. 로컬 실행
```bash
uvicorn app.main:app --reload
```

### 3. API 테스트
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

### 4. 배포
```bash
docker build -t aisys-backend .
docker run -p 8000:8000 aisys-backend
```

---

## 데이터베이스 스키마

관련 파일: `db/schema.sql`, `db/seed.sql`

### 주요 테이블
- `users` - 사용자 정보
- `cases` - 케이스/판례
- `policies` - 정책 정보
- `permissions` - 권한 관리

---

## 상호작용

### 프론트엔드와의 상호작용
- iOS 앱이 REST API를 호출
- JSON 형식 데이터 송수신

### AI 모델 설계와의 상호작용
- 사용자 쿼리를 AI 모델에 전달
- 모델 추론 결과를 처리 및 반환

### 데이터 관리와의 상호작용
- PostgreSQL 데이터베이스와 CRUD 작업
- 데이터 정규화 및 검증

---

## 참고 문서
- [백엔드 상세 가이드](../code/backend/README.md)
- [데이터베이스 스키마](../db/schema.sql)
- [실행 가이드](../code/Run_Guide_AI_SYS.md)

---

## 현재 진행 상황 (기준: 2026-04-28)

### 완료 사항 ✅

| 항목 | 상세 |
|------|------|
| API 기본 구조 | FastAPI 앱 초기화, 라우터 구성 완료 |
| `/health` | 서버 상태 확인 엔드포인트 |
| `/search?q=&limit=` | 사건번호/키워드 기반 검색 API |
| `/cases/{case_number}` | 판례 상세 조회 API |
| `/cases?limit=` | 판례 목록 조회 API |
| `/dashboard/recommended` | 추천 복습 카드 반환 API |
| `/dashboard/wrong-answers` | 오답 목록 반환 API |
| Pydantic 스키마 | `RecommendedCaseItem`, `WrongAnswerListItem` 등 응답 모델 정의 완료 |
| Docker Compose | API/DB 동시 실행 환경 구성 완료 |
| API 문서 | `/docs` (Swagger) 접근 가능 |

### 현재 제한 사항 ⚠️

- **추천 로직 미흡**: 단순 점수식 기반, 최근 학습/오답 가중치 미반영
- **인증/권한 미도입**: 사용자별 세션 관리, 로그인 기능 본격 도입 전
- **검색 정확도 미흡**: 재순위화(re-ranking), 쿼리 확장 등 고도화 미완료
- **자동 테스트 부족**: API 단위 테스트, DB 통합 테스트 기본 세트 미구축
- **관측성 부족**: API 요청 실패 원인 추적 로그 표준화 필요

### 다음 작업 (우선순위 순)

1. **[P0]** 추천 점수식 개선 — 최근 학습/오답 가중치 반영
2. **[P0]** 검색 쿼리 정규화 — 불용어/동의어/사건번호 우선순위 처리
3. **[P1]** 백엔드 단위 테스트 + DB 통합 테스트 기본 세트 구축
4. **[P1]** API 요청 실패 원인 추적 로그 표준화
5. **[P2]** 환경별 설정(dev/stage/prod) 분리
6. **[P2]** 인증/권한 관리 도입

---

**마지막 업데이트**: 2026-04-28
