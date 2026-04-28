# AI 모델 설계 (AI Model Design)

## 개요
AI_SYS의 AI 모델 설계는 정보 검색(Information Retrieval)과 프롬프트 엔지니어링을 중심으로 합니다. 로컬 LLM과 서버 기반 모델을 통합하여 정책 및 판례 검색, 권한 검증, 케이스 분석을 수행합니다.

---

## 책임사항

### 1. 정보 검색 모델 개발
- 키워드 기반 검색 알고리즘
- 의미론적 유사도 계산
- 검색 결과 순위 매김

### 2. 프롬프트 엔지니어링
- 프롬프트 템플릿 작성
- 사용자 입력 최적화
- 출력 포맷 정의

### 3. LLM 통합 및 최적화
- 로컬 모델(Llama-3.2-1B) 최적화
- 서버 모델과의 연동
- 성능 튜닝

### 4. 모델 성능 평가
- 정확도 측정
- 응답 시간 분석
- 사용자 만족도 평가

### 5. 정책/판례 분석
- 정책 의도 파악
- 판례 유사성 분석
- 권한 검증 로직 개발

---

## 기술 스택

| 항목 | 기술 |
|------|------|
| **로컬 모델** | Llama-3.2-1B-Instruct-Q4_K_M |
| **프레임워크** | llama-cpp-python, Ollama |
| **검색 엔진** | 키워드 기반 + 벡터 기반 검색 |
| **개발 언어** | Python, Swift |

---

## 프로젝트 구조

```
code/
├── stitch_prompts_ai_sys.txt        # 프롬프트 템플릿 모음
├── backend/
│   └── app/
│       ├── grounding.py             # 모델 기반 응답 생성
│       └── main.py                  # API 엔드포인트
└── ios/
    └── AISYSApp/Sources/
        ├── LLMService.swift         # 로컬 LLM 서비스
        ├── LocalLLMEngines.swift    # LLM 엔진 설정
        └── PromptTemplates.swift    # 프롬프트 템플릿

data/
├── raw/                             # 원본 정책/판례 데이터
├── normalized/                      # 정규화된 데이터
├── templates/
│   └── scourt_permission_request_email.md  # 이메일 템플릿
└── policy/
    └── SCourt_Policy_Check_Guide.md # 정책 검증 가이드
```

---

## 주요 파일 설명

### `stitch_prompts_ai_sys.txt`
- 모든 프롬프트 템플릿 모음
- 역할별 프롬프트 정의
- Few-shot 예제 포함

### `grounding.py`
- 백엔드의 AI 추론 로직
- 정책/판례 데이터 활용
- 응답 생성 및 검증

### `LLMService.swift`
- `LlamaCppEngine` / `RuleBasedLocalEngine` 이중 엔진 구조 관리
- `summarize()`, `generateQuiz()`, `compare()` 인터페이스 제공
- 앱 시작 시 선로딩, ready 상태 대기

### `PromptTemplates.swift`
- `LLMPromptTemplate.summarize()` — 판례 요약 (one_line_summary / key_issue / ruling_point / exam_takeaway)
- `LLMPromptTemplate.compare()` — 판례 비교 (common_points / differences / likely_exam_trap / citations)
- `LLMPromptTemplate.quiz()` — 객관식 퀴즈 생성 (prompt / options / answer / explanation)
- 모든 템플릿: `[ROLE]`, `[TASK]`, `[EVIDENCE]`, `[RULES]`, `[OUTPUT]` 구조

### `grounding.py` (backend)
- `HALLUCINATION_RULES`: 5가지 환각 방지 규칙 정의
  - `must_have_citation` — 모든 법적 주장에 인용 필수
  - `citation_must_exist_in_retrieval` — 인용된 사건번호는 검색 결과 내에 있어야 함
  - `no_unsupported_numeric_facts` — 근거 없는 날짜/조리번호/수치 금지
  - `uncertainty_on_missing_evidence` — 증거 부족 시 명시적 불확실성 진술 필요
  - `quote_must_match_snippet` — 인용문은 증거 스니펫과 실제 일치 필요
- `validate_grounded_answer()` — 서버 사이드 경량 검증, 위반된 규칙 키 반환

---

## 프롬프트 아키텍처

### 프롬프트 구성 요소

```
1. 시스템 프롬프트 (System Prompt)
   - 모델의 역할 정의
   - 동작 방식 설명
   
2. 사용자 입력 (User Input)
   - 질문 또는 요청
   
3. 컨텍스트 (Context)
   - 관련 정책/판례 정보
   
4. 제약 조건 (Constraints)
   - 출력 포맷
   - 길이 제한
```

### 템플릿 예제

**검색 쿼리 확장**
```
System: 당신은 법률 정보 검색 전문가입니다.
User: "권한 신청"을 관련 검색어로 확장하세요.
Response: [권한 신청, 권한 검증, 승인 절차, ...]
```

**케이스 분석**
```
System: 제공된 정책을 기반으로 권한 검증을 수행하세요.
User: 사용자가 X 권한을 요청했습니다.
Context: [관련 정책 내용]
Response: {
  "권한": "X",
  "승인": true/false,
  "이유": "..."
}
```

---

## 정보 검색 모델

### 1. 키워드 기반 검색
```
검색어 전처리 → 토큰화 → 정규화 → 매칭
```

### 2. 벡터 기반 검색 (향후 확장)
```
텍스트 → 임베딩 → 유사도 계산 → 순위 매김
```

### 3. 검색 결과 순위 매김
- TF-IDF 점수
- 사용자 상호작용 데이터
- 시간 기반 가중치

---

## 환각 방지 (Grounding)

### `HALLUCINATION_RULES` (grounding.py)

| 규칙 키 | 설명 |
|---------|------|
| `must_have_citation` | 모든 법적 주장에 사건번호 인용 필수 |
| `citation_must_exist_in_retrieval` | 인용 사건번호는 검색 결과에 실제 존재해야 함 |
| `no_unsupported_numeric_facts` | 근거 없는 날짜/조리번호/수치 삽입 금지 |
| `uncertainty_on_missing_evidence` | 증거 부족 시 명시적 불확실성 진술 필요 |
| `quote_must_match_snippet` | 인용문은 증거 스니펫과 실제 일치 필요 |

### `validate_grounded_answer()` (server-side)
```python
# 사용 예
위반 = validate_grounded_answer(
    answer_text=generated_text,
    cited_case_numbers=["2021도16503"],
    retrieved_case_numbers={"2021도16503", "2022도12345"}
)
# 반환: 위반된 규칙 키 리스트 ([] = 정상)
```

---

## 모델 성능 지표

### 응답 시간 (Latency)
- 로컈 데이터 로드 (`loadInitialCasesIfNeeded`): 네트워크 상태에 따라 다름
- LLM 추론 참조: RuleBasedEngine < LlamaCpp (실기기 계측 미완료)
- 서버 검색 응답: `timeoutIntervalForRequest: 8초` 기준

### 파싱 성공률
- `LLMSummary(rawOutput:)` 실패 시 fallback 데이터 (`toCaseDetail()`) 사용
- 목표: 파싱 실패률 < 5% (미달성, 현재 관측 미제)

---

## 로컬 LLM 최적화

### 모델 선택 이유
- **Llama-3.2-1B**: 경량 모델로 모바일 디바이스에 최적화
- **Q4_K_M**: 양자화로 메모리 절감 및 성능 향상

### 최적화 기법

1. **프롬프트 최적화**
   - 불필요한 토큰 제거
   - 명확한 지시사항 제공

2. **모델 양자화**
   - 정밀도 손실 최소화
   - 메모리 사용량 감소

3. **배치 처리**
   - 여러 요청 동시 처리
   - 처리량 증가

---

## 개발 워크플로우

### 1. 프롬프트 개발
```
초안 작성 → 테스트 → 평가 → 최적화 → 배포
```

### 2. 모델 평가
```
테스트 세트 준비 → 평가 메트릭 정의 → 성능 측정 → 개선
```

### 3. A/B 테스트
```
버전 A 배포 → 사용자 피드백 수집 → 버전 B 테스트 → 최종 선택
```

---

## 데이터 흐름

```
사용자 입력
    ↓
[프롬프트 템플릿] 적용
    ↓
LLM 추론 (로컬 또는 서버)
    ↓
[정보 검색] - 정책/판례 조회
    ↓
응답 생성 및 검증
    ↓
사용자에게 제시
```

---

## 상호작용

### 백엔드와의 상호작용
- `grounding.py`를 통한 추론 처리
- 정책/판례 데이터 활용

### 프론트엔드와의 상호작용
- 로컬 LLM을 통한 오프라인 추론
- 프롬프트 템플릿 적용

### 데이터 관리와의 상호작용
- 정책/판례 데이터 활용
- 데이터 품질 피드백

---

## 참고 문서
- [프롬프트 템플릿](../code/stitch_prompts_ai_sys.txt)
- [정책 검증 가이드](../data/policy/SCourt_Policy_Check_Guide.md)
- [데이터 빌드 가이드](../code/Data_Build_Guide_AI_SYS.md)

---

## 현재 진행 상황 (기준: 2026-04-28)

### 완료 사항 ✅

| 항목 | 상세 |
|------|------|
| 온디바이스 LLM 전략 확정 | 서버형 → 로컬 추론(LlamaSwift + GGUF) 전략으로 전환 완료 |
| LLM 상태 머신 | loading / ready / inferring / error 상태 관리 구현 |
| 프롬프트 흐름 구현 | 요약 / 퀴즈 생성 / 비교 프롬프트 흐름 구현 |
| 선로딩 로직 | 앱 시작 시 모델 선로딩 및 ready 대기 로직 반영 |
| Rule-based 폴백 | 엔진 실패 시 규칙 기반 fallback으로 기능 연속성 확보 |
| 정보 검색 기본 구성 | 사건번호/키워드 기반 검색 API와 연동 |

### 전략 전환 배경 (서버형 → 로컬형)

| 항목 | 이전 전략 | 현재 전략 |
|------|-----------|----------|
| 추론 위치 | 서버 API 호출 | 온디바이스 로컬 추론 |
| 오프라인 지원 | 불가 | 가능 |
| 개인정보 보호 | 외부 전송 발생 | 최소화 |
| 서버 비용 | 변동 리스크 | 없음 |
| 전환 이유 | — | 오프라인 학습 환경, 네트워크 의존도 감소 |

### 현재 제한 사항 ⚠️

- **출력 포맷 파싱 불안정**: 요약/퀴즈 파싱 실패 케이스 발생, 안정화 필요
- **모델 파라미터 미튜닝**: 샘플링 파라미터 최적화 미완료
- **실기기 성능 미계측**: 지연시간/발열/메모리 계측 기반 최적화 미흡
- **검색 정확도 고도화 미완료**: 재순위화, 쿼리 확장, 동의어 처리 미완

### 다음 작업 (우선순위 순)

1. **[P0]** 프롬프트 포맷 고정 — 필드 키 강제로 파싱 실패율 감소 (목표: < 5%)
2. **[P0]** 파서 보강 — 누락 필드 보정, 안전 디폴트 처리
3. **[P0]** 실패 로그 수집 포인트 추가
4. **[P1]** 검색 쿼리 정규화 — 불용어/동의어/사건번호 우선순위 처리
5. **[P2]** 개인화 고도화 — 오답 유형별 복습 추천, 과목/쟁점 기반 학습 경로 제안
6. **[P2]** 실기기 성능 계측 및 모델 파라미터 튜닝

---

**마지막 업데이트**: 2026-04-28
